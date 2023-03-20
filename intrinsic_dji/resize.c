#include "kernel.h"
#include <riscv_vector.h>

__attribute__((noinline)) void resize(struct resize_param *param) {
  uint16_t channel = param->channel;
  uint16_t height = param->height;
  uint16_t width = param->width;
  int8_t *src_arr = param->src_ptr;
  int8_t *out_arr = param->out_ptr;

  int8_t *src_ptr_y0 = src_arr;
  int8_t *src_ptr_y1 = src_arr;
  int8_t *dst_ptr = out_arr;
  uint16_t dst_c = channel;
  uint16_t dst_height = height * 2;
  uint16_t dst_width = width * 2;

  uint16_t dst_h_idx_arr[256];
  uint16_t dst_w_idx_arr[256];
  for (uint16_t i = 0; i < 256; i++) {
    dst_h_idx_arr[i] = (uint16_t)i;
  }
  for (uint16_t i = 0; i < 256; i++) {
    dst_w_idx_arr[i] = (uint16_t)i;
  }

  uint16_t *dst_h_idx_ptr = dst_h_idx_arr;
  uint16_t *dst_w_idx_ptr = dst_w_idx_arr;

  // xy_idx
  uint16_t y0_arr[256];
  uint16_t y1_arr[256];
  uint16_t x0_arr[256];
  uint16_t x1_arr[256];
  uint16_t *y0_ptr = y0_arr;
  uint16_t *y1_ptr = y1_arr;
  uint16_t *x0_ptr = x0_arr;
  uint16_t *x1_ptr = x1_arr;

  // lamda
  uint16_t h0_lambda_arr[256];
  uint16_t h1_lambda_arr[256];
  uint16_t w0_lambda_arr[256];
  uint16_t w1_lambda_arr[256];
  uint16_t *h0_lambda_ptr = h0_lambda_arr;
  uint16_t *h1_lambda_ptr = h1_lambda_arr;
  uint16_t *w0_lambda_ptr = w0_lambda_arr;
  uint16_t *w1_lambda_ptr = w1_lambda_arr;

  uint16_t h_vl, w_vl;
  uint16_t src_h_border = height - 1;
  uint16_t src_w_border = width - 1;

  // x_idx
  for (uint16_t w = dst_width; w; w -= w_vl) {
    w_vl = vsetvl_e16m2(w);

    vuint16m2_t dst_w_idx = vle16_v_u16m2(dst_w_idx_ptr, w_vl);
    vuint16m2_t input_x = vsll_vx_u16m2(dst_w_idx, 6, w_vl);
    vuint16m2_t x0 = vsrl_vx_u16m2(input_x, 7, w_vl);
    vuint16m2_t x1_tmp = vadd_vx_u16m2(x0, 1, w_vl);
    vuint16m2_t x1 = vminu_vx_u16m2(x1_tmp, src_w_border, w_vl);

    vuint16m2_t x0_shifted = vsll_vx_u16m2(x0, 7, w_vl);
    vuint16m2_t w1_lambda = vsub_vv_u16m2(input_x, x0_shifted, w_vl);
    vuint16m2_t w0_lambda = vrsub_vx_u16m2(w1_lambda, 128, w_vl);

    vse16_v_u16m2(x0_ptr, x0, w_vl);
    vse16_v_u16m2(x1_ptr, x1, w_vl);
    vse16_v_u16m2(w0_lambda_ptr, w0_lambda, w_vl);
    vse16_v_u16m2(w1_lambda_ptr, w1_lambda, w_vl);

    dst_w_idx_ptr += w_vl;
    x0_ptr += w_vl;
    x1_ptr += w_vl;
    w0_lambda_ptr += w_vl;
    w1_lambda_ptr += w_vl;
  }

  // y_idx
  for (uint16_t h = dst_height; h; h -= h_vl) {
    h_vl = vsetvl_e16m2(h);

    vuint16m2_t dst_h_idx = vle16_v_u16m2(dst_h_idx_ptr, h_vl);
    vuint16m2_t input_y = vsll_vx_u16m2(dst_h_idx, 6, h_vl);
    vuint16m2_t y0 = vsrl_vx_u16m2(input_y, 7, h_vl);
    vuint16m2_t y1_tmp = vadd_vx_u16m2(y0, 1, h_vl);
    vuint16m2_t y1 = vminu_vx_u16m2(y1_tmp, src_h_border, h_vl);

    vuint16m2_t y0_shifted = vsll_vx_u16m2(y0, 7, h_vl);
    vuint16m2_t h1_lambda = vsub_vv_u16m2(input_y, y0_shifted, h_vl);
    vuint16m2_t h0_lambda = vrsub_vx_u16m2(h1_lambda, 128, h_vl);

    vse16_v_u16m2(y0_ptr, y0, h_vl);
    vse16_v_u16m2(y1_ptr, y1, h_vl);
    vse16_v_u16m2(h0_lambda_ptr, h0_lambda, h_vl);
    vse16_v_u16m2(h1_lambda_ptr, h1_lambda, h_vl);

    dst_h_idx_ptr += h_vl;
    y0_ptr += h_vl;
    y1_ptr += h_vl;
    h0_lambda_ptr += h_vl;
    h1_lambda_ptr += h_vl;
  }

  for (uint16_t c = 0; c < dst_c; c++) {
    uint32_t cwh_tmp = c * width * height;
    for (uint16_t h = 0; h < dst_height; h++) {
      uint32_t y0 = (uint32_t)y0_arr[h];
      uint32_t y0_index_tmp = y0 * width + cwh_tmp;
      uint32_t y1 = (uint32_t)y1_arr[h];
      uint32_t y1_index_tmp = y1 * width + cwh_tmp;
      int16_t h0_lambda = (int16_t)h0_lambda_arr[h];
      int16_t h1_lambda = (int16_t)h1_lambda_arr[h];

      x0_ptr = x0_arr;
      x1_ptr = x1_arr;
      w0_lambda_ptr = w0_lambda_arr;
      w1_lambda_ptr = w1_lambda_arr;

      src_ptr_y0 = src_arr + y0_index_tmp;
      src_ptr_y1 = src_arr + y1_index_tmp;

      uint16_t w_tmp = 0;
      for (uint16_t w = dst_width; w; w -= w_vl) {
        w_vl = vsetvl_e16m2(w);
        vuint16m2_t x0 = vle16_v_u16m2(x0_ptr, w_vl);
        vuint16m2_t x1 = vle16_v_u16m2(x1_ptr, w_vl);
        vuint16m2_t w0_lambda = vle16_v_u16m2(w0_lambda_ptr, w_vl);
        vuint16m2_t w1_lambda = vle16_v_u16m2(w1_lambda_ptr, w_vl);
        vint16m2_t w0_lambda_int16 = vreinterpret_v_u16m2_i16m2(w0_lambda);
        vint16m2_t w1_lambda_int16 = vreinterpret_v_u16m2_i16m2(w1_lambda);

        vint8m1_t src_data_y0_int8 = vle8_v_i8m1(src_ptr_y0, w_vl);
        vint8m1_t src_data_y1_int8 = vle8_v_i8m1(src_ptr_y1, w_vl);
        vint16m2_t src_data_y0 = vwadd_vx_i16m2(src_data_y0_int8, 0, w_vl);
        vint16m2_t src_data_y1 = vwadd_vx_i16m2(src_data_y1_int8, 0, w_vl);

        vuint16m2_t x0_seged = vsub_vx_u16m2(x0, w_tmp, w_vl);
        vuint16m2_t x1_seged = vsub_vx_u16m2(x1, w_tmp, w_vl);

        vint16m2_t y0x0_val_int16 =
            vrgather_vv_i16m2(src_data_y0, x0_seged, w_vl);
        vint16m2_t y0x1_val_int16 =
            vrgather_vv_i16m2(src_data_y0, x1_seged, w_vl);

        vint16m2_t y1x0_val_int16 =
            vrgather_vv_i16m2(src_data_y1, x0_seged, w_vl);
        vint16m2_t y1x1_val_int16 =
            vrgather_vv_i16m2(src_data_y1, x1_seged, w_vl);

        vint16m2_t sum1_y0x0 =
            vmul_vv_i16m2(y0x0_val_int16, w0_lambda_int16, w_vl);
        vint16m2_t sum4_y1x0 =
            vmul_vv_i16m2(y1x0_val_int16, w0_lambda_int16, w_vl);
        vint16m2_t sum1 =
            vmacc_vv_i16m2(sum1_y0x0, y0x1_val_int16, w1_lambda_int16, w_vl);
        vint16m2_t sum4 =
            vmacc_vv_i16m2(sum4_y1x0, y1x1_val_int16, w1_lambda_int16, w_vl);
        vint16m2_t sum1_shifted = vsra_vx_i16m2(sum1, 7, w_vl);
        vint16m2_t sum4_shifted = vsra_vx_i16m2(sum4, 7, w_vl);

        vint16m2_t dst_h0 = vmul_vx_i16m2(sum1_shifted, h0_lambda, w_vl);
        vint16m2_t dst_h1 = vmul_vx_i16m2(sum4_shifted, h1_lambda, w_vl);
        vint16m2_t dst_tmp = vadd_vv_i16m2(dst_h0, dst_h1, w_vl);
        vint8m1_t dst_val = vnsra_wx_i8m1(dst_tmp, 7, w_vl);

        vse8_v_i8m1(dst_ptr, dst_val, w_vl);

        x0_ptr += w_vl;
        x1_ptr += w_vl;
        w0_lambda_ptr += w_vl;
        w1_lambda_ptr += w_vl;
        dst_ptr += w_vl;

        src_ptr_y0 += (uint16_t)w_vl / 2;
        src_ptr_y1 += (uint16_t)w_vl / 2;
        w_tmp += (uint16_t)w_vl / 2;
      }
    }
  }
}
