#include "kernel.h"
#include <riscv_vector.h>

__attribute__((noinline)) void warp(struct warp_param *param) {
  size_t channel = param->channel;
  size_t height = param->height;
  size_t width = param->width;
  size_t offset_fl = param->offset_fl;
  int8_t *src_arr = param->src_ptr;
  int16_t *offset_arr = param->offset_ptr;
  int8_t *out_arr = param->out_ptr;

  int8_t *src_ptr = src_arr;
  int16_t *offset_ptr = offset_arr;
  int8_t *out_ptr = out_arr;

  size_t w_vl = 0;
  size_t vl_cnt = 0;
  int8_t w_arr_int8[128]; // input_width_size is no more than 128
  for (size_t i = 0; i < 128; i++) {
    w_arr_int8[i] = (int8_t)i;
  }
  int8_t *w_ptr_int8 = w_arr_int8;

  for (size_t h = 0; h < height; h++) {
    for (size_t w = width; w; w -= w_vl) {
      w_vl = vsetvl_e8m2(w);
      vint16m4_t offset_val = vle16_v_i16m4(offset_ptr, w_vl);
      vint8m2_t offset_int = vnsra_wx_i8m2(offset_val, 8, w_vl);
      vint16m4_t offset_fraction_temp = vsll_vx_i16m4(offset_val, 8, w_vl);
      vint8m2_t offset_fraction = vnsra_wx_i8m2(offset_fraction_temp, 8, w_vl);
      vint8m2_t w_idx_int = vle8_v_i8m2(w_ptr_int8, w_vl);
      vuint8m2_t w_idx_uint8 = vreinterpret_v_i8m2_u8m2(w_idx_int);
      vint8m2_t right_idx_sub_int8 = vsub_vv_i8m2(w_idx_int, offset_int, w_vl);
      vint8m2_t left_idx_sub_int8 = vsub_vx_i8m2(right_idx_sub_int8, 1, w_vl);
      vuint8m2_t right_idx_sub_uint8 =
          vreinterpret_v_i8m2_u8m2(right_idx_sub_int8);
      vuint8m2_t left_idx_sub_uint8 =
          vreinterpret_v_i8m2_u8m2(left_idx_sub_int8);
      vbool4_t right_masked = vmsgt_vx_i8m2_b4(right_idx_sub_int8, -1, w_vl);
      vbool4_t left_masked = vmsgt_vx_i8m2_b4(left_idx_sub_int8, -1, w_vl);
      vint8m2_t maskedoff_val = vmv_v_x_i8m2(0, w_vl);

      for (size_t c = 0; c < channel; c++) {
        vint8m2_t raw_val = vle8_v_i8m2(src_ptr, w_vl);
        vint8m2_t right_val = vrgather_vv_i8m2_m(
            right_masked, maskedoff_val, raw_val, right_idx_sub_uint8, w_vl);
        vint8m2_t left_val = vrgather_vv_i8m2_m(
            left_masked, maskedoff_val, raw_val, left_idx_sub_uint8, w_vl);
        vint16m4_t right_val_shifted = vsext_vf2_i16m4(right_val, w_vl);
        right_val_shifted = vsll_vx_i16m4(right_val_shifted, 8, w_vl);
        vint8m2_t out_sub_part = vsub_vv_i8m2(left_val, right_val, w_vl);
        vint16m4_t out_val = vwmacc_vv_i16m4(right_val_shifted, out_sub_part,
                                             offset_fraction, w_vl);
        vint8m2_t out_val_shifted = vnsra_wx_i8m2(out_val, 8, w_vl);
        vse8_v_i8m2(out_ptr, out_val_shifted, w_vl);
        src_ptr += width * height;
        out_ptr += width * height;
      }
      src_ptr -= channel * width * height;
      out_ptr -= channel * width * height;
      w_ptr_int8 += w_vl;
      offset_ptr += w_vl;
    }
    src_ptr += width;
    out_ptr += width;
    w_ptr_int8 -= width;
  }
}
