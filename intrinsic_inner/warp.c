/*
 * @Author: yuanhang.zhang
 * @Date: 2021-09-15 18:00:54
 * @Last Modified by: yuanhang
 * @Last Modified time: 2021-09-22 19:55:22
 */

#include "kernel.h"
#include <riscv_vector.h>

__attribute__((noinline)) void warp(struct warp_param *restrict param) {
  size_t channel = param->channel;
  size_t height = param->height;
  size_t width = param->width;
  uint8_t offset_fl = param->offset_fl;
  int8_t *restrict src_arr = param->src_ptr;
  int16_t *restrict offset_arr = param->offset_ptr;
  int8_t *restrict out_arr = param->out_ptr;

  for (size_t h = 0; h < height; h++)
    for (size_t w = 0; w < width; w++) {
      int16_t offset_val = offset_arr[h * width + w];
      int8_t offset_int = offset_val >> 8;
      int8_t offset_fraction = (offset_val << 8) >> 8;
      int8_t right_idx = (int8_t)w - offset_int;
      int8_t left_idx = right_idx - 1;
      size_t vl;
      for (size_t c = 0; c < channel; c += vl) {
        vl = vsetvl_e8m4(channel - c);
        int8_t *src_ptr = &src_arr[c * height * width + h * width];
        vint8m4_t Zero = vmv_v_x_i8m4(0, vl);
        vint8m4_t right_val = (right_idx < 0)
                                  ? Zero
                                  : vlse8_v_i8m4(&src_ptr[(uint8_t)right_idx],
                                                 height * width, vl);
        vint8m4_t left_val =
            (left_idx < 0)
                ? Zero
                : vlse8_v_i8m4(&src_ptr[(uint8_t)left_idx], height * width, vl);
        // int8_t right_val = (right_idx < 0) ? 0 : src_ptr[(uint8_t)right_idx];
        // int8_t left_val = (left_idx < 0) ? 0 : src_ptr[(uint8_t)left_idx];
        vint16m8_t out = vsll(vsext_vf2(right_val, vl), 8, vl);
        out = vadd(
            out, vwmul(vsub(left_val, right_val, vl), offset_fraction, vl), vl);
        vsse8_v_i8m4(&out_arr[c * height * width + h * width + w],
                     height * width, vnsra(out, 8, vl), vl);
      }
    }
}
