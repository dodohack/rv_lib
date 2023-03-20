/*
 * @Author: yuanhang.zhang
 * @Date: 2021-09-23 10:08:50
 * @Last Modified by: yuanhang
 * @Last Modified time: 2021-09-28 15:20:47
 */

#include "kernel.h"
#include <riscv_vector.h>

__attribute__((noinline)) void resize(struct resize_param *param) {
  uint16_t channel = param->channel;
  uint16_t height = param->height;
  uint16_t width = param->width;
  int8_t *src_arr = param->src_ptr;
  int8_t *out_arr = param->out_ptr;

  uint16_t dst_height = height * 2;
  uint16_t dst_width = width * 2;

  size_t hw_fl = 7; // fraction of factor is 7;
  for (uint16_t c = 0; c < channel; c++) {
    for (uint16_t h = 0; h < dst_height; h++) {
      uint16_t input_y = h << (hw_fl - 1);
      uint16_t y0 = input_y >> hw_fl;
      uint16_t y1 = MIN(y0 + (uint16_t)1, height - (uint16_t)1);

      uint32_t t0 = (uint32_t)c * width * height + (uint32_t)y0 * width;
      uint32_t t1 = (uint32_t)c * width * height + (uint32_t)y1 * width;
      uint32_t t2 =
          (uint32_t)c * dst_width * dst_height + (uint32_t)h * dst_width;
      int8_t *src_ptr0 = src_arr + t0;
      int8_t *src_ptr1 = src_arr + t1;
      int8_t *out_ptr = out_arr + t2;

      size_t vl = vsetvlmax_e16m4();
      vuint16m4_t v_w = vid_v_u16m4(vl);
      for (uint16_t w = 0; w < dst_width; w += vl) {
        vl = vsetvl_e16m4(dst_width - w);
        vuint16m4_t v_input_x = vsll(v_w, hw_fl - 1, vl);
        vuint16m4_t v_x0 = vsrl(v_input_x, hw_fl, vl);
        vuint16m4_t v_x1 = vminu(vadd(v_x0, 1, vl), width - 1, vl);

        uint8_t factor = (uint8_t)1 << hw_fl;
        vuint8m2_t v_w1_lambda =
            vncvt_x(vsub(v_input_x, vsll(v_x0, hw_fl, vl), vl), vl);
        vuint8m2_t v_w0_lambda = vrsub(v_w1_lambda, factor, vl);
        uint8_t h1_lambda = (uint8_t)(input_y - (y0 << hw_fl));
        uint8_t h0_lambda = factor - h1_lambda;

        vint8m2_t v_y0x0 = vloxei16(src_ptr0, v_x0, vl);
        vint8m2_t v_y0x1 = vloxei16(src_ptr0, v_x1, vl);
        vint8m2_t v_y1x0 = vloxei16(src_ptr1, v_x0, vl);
        vint8m2_t v_y1x1 = vloxei16(src_ptr1, v_x1, vl);

        vint16m4_t v_sum1 = vsra(
            vwmaccsu(vwmulsu(v_y0x0, v_w0_lambda, vl), v_y0x1, v_w1_lambda, vl),
            hw_fl, vl);
        vint16m4_t v_sum2 = vsra(
            vwmaccsu(vwmulsu(v_y1x0, v_w0_lambda, vl), v_y1x1, v_w1_lambda, vl),
            hw_fl, vl);
        vint8m2_t v_out =
            vnsra(vmacc(vmul(v_sum1, h0_lambda, vl), h1_lambda, v_sum2, vl),
                  hw_fl, vl);
        vse8(out_ptr, v_out, vl);
        out_ptr += vl;
        v_w = vadd(v_w, vl, vl);
      }
    }
  }
}
