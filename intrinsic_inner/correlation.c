/*
 * @Author: yuanhang.zhang
 * @Date: 2021-09-22 15:22:24
 * @Last Modified by: yuanhang
 * @Last Modified time: 2021-09-23 10:59:46
 */

#include "kernel.h"
#include <riscv_vector.h>

__attribute__((noinline)) void correlation(struct correlation_param *param) {
  size_t in_channel = param->in_channel;
  size_t height = param->height;
  size_t width = param->width;
  size_t out_channel = param->out_channel;
  size_t out_shift = param->out_shift;
  int8_t *src0_arr = param->src0_ptr;
  int8_t *src1_arr = param->src1_ptr;
  int8_t *out_arr = param->out_ptr;

  size_t in_idx1 = 0, in_idx2 = 0, out_idx = 0;
  for (size_t i = 0; i < height; ++i) {
    for (size_t d = 0; d < out_channel; ++d) {
      for (size_t j = d; j < width; j++) {
        out_idx = d * width * height + i * width + j;
        size_t vl;
        vint16m1_t sum_data;
        sum_data = vmv_s(sum_data, 0, 1);
        for (size_t k = 0; k < in_channel; k += vl) {
          vl = vsetvl_e8m4(in_channel - k);
          in_idx1 = k * width * height + i * width + j;
          in_idx2 = k * width * height + i * width + j - d;
          vint8m4_t v1 = vlse8_v_i8m4(&src0_arr[in_idx1], width * height, vl);
          vint8m4_t v2 = vlse8_v_i8m4(&src1_arr[in_idx2], width * height, vl);
          sum_data = vredsum(sum_data, vwmul(v1, v2, vl), sum_data, vl);
        }
        out_arr[out_idx] = (int8_t)(vmv_x(sum_data) >> out_shift);
      }
    }
  }
}
