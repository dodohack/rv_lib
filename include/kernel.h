#ifndef __KERNEL_H__
#define __KERNEL_H__

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

static size_t read_rdcycle() {
  size_t tmp = 0;
#ifdef __riscv
  asm __volatile__("rdcycle %[dst01]\n" : [dst01] "=r"(tmp) : : "memory");
  // asm __volatile__("csrr %[dst01], mcycle\n" : [dst01] "=r"(tmp) : :
  // "memory");
#endif
  return tmp;
}

static size_t read_rdinstret() {
  size_t tmp = 0;
#ifdef __riscv
  asm __volatile__("rdinstret %[dst01]\n" : [dst01] "=r"(tmp) : : "memory");
  // asm __volatile__("csrr %[dst01], minstret\n"
  //                  : [dst01] "=r"(tmp)
  //                  :
  //                  : "memory");
#endif
  return tmp;
}

struct correlation_param {
  size_t in_channel;
  size_t height;
  size_t width;
  size_t out_channel;
  size_t out_shift;
  int8_t *src0_ptr;
  int8_t *src1_ptr;
  int8_t *out_ptr;
};

void correlation(struct correlation_param *param);

struct psroi_param {
  uint8_t *src_arr;
  uint16_t *rois_arr;
  uint16_t *out_arr;
  uint32_t rois_num;
  uint32_t pooled_h;
  uint32_t pooled_w;
  uint32_t pooled_c;
  uint32_t src_height;
  uint32_t src_width;
  uint8_t sampling_ratio;
  uint8_t roi_shift;
};

#define inner_shift 8

void psroi_pooling_align(struct psroi_param *param);

struct resize_param {
  uint16_t channel;
  uint16_t height;
  uint16_t width;
  int8_t *src_ptr;
  int8_t *out_ptr;
};

void resize(struct resize_param *param);

struct warp_param {
  size_t channel;
  size_t height;
  size_t width;
  size_t offset_fl;
  int8_t *src_ptr;
  int16_t *offset_ptr;
  int8_t *out_ptr;
};

void warp(struct warp_param *param);

#endif
