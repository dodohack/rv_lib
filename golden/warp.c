/*
 * @Author: yuanhang.zhang
 * @Date: 2021-09-15 18:00:54
 * @Last Modified by: yuanhang
 * @Last Modified time: 2021-09-22 19:55:22
 */

#include "kernel.h"

__attribute__((noinline)) void warp(struct warp_param *restrict param) {
  size_t channel = param->channel;
  size_t height = param->height;
  size_t width = param->width;
  uint8_t offset_fl = param->offset_fl;
  int8_t *restrict src_arr = param->src_ptr;
  int16_t *restrict offset_arr = param->offset_ptr;
  int8_t *restrict out_arr = param->out_ptr;

  for (size_t h = 0; h < height; h++) {
    int8_t indvar = 0;
// This pragma is used by outer loop vectorization.
#pragma clang loop vectorize(assume_safety) vectorize_width(16, scalable)
    for (size_t w = 0; w < width; w++, indvar++) {
      int16_t offset_val = offset_arr[h * width + w];
      int8_t offset_int = offset_val >> 8;
      int8_t offset_fraction = (offset_val << 8) >> 8;
      int8_t right_idx = indvar - offset_int;
      int8_t left_idx = right_idx - 1;
// This pragma is used by inner loop vectorization.
#pragma clang loop vectorize(assume_safety)
      for (size_t c = 0; c < channel; c++) {
        int8_t *src_ptr = &src_arr[c * height * width + h * width];
        int8_t right_val = src_ptr[(uint8_t)right_idx];
        right_val = (right_idx < 0) ? 0 : right_val;
        int8_t left_val = src_ptr[(uint8_t)left_idx];
        left_val = (left_idx < 0) ? 0 : left_val;
        // int8_t right_val = (right_idx < 0) ? 0 : src_ptr[(uint8_t)right_idx];
        // int8_t left_val = (left_idx < 0) ? 0 : src_ptr[(uint8_t)left_idx];
        int16_t out = (int16_t)right_val << 8;
        out += (int16_t)(left_val - right_val) * offset_fraction;
        out_arr[c * height * width + h * width + w] = (int8_t)(out >> 8);
      }
    }
  }
}
