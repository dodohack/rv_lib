#include "kernel.h"

int8_t src_arr_global[571648];
int16_t offset_arr_global[9856];
int8_t out_arr_global[571648];

void global_arr_init() {
#ifndef NDEBUG
  for (size_t i = 0; i < 571648; ++i)
    src_arr_global[i] = i % 64;
  for (size_t i = 0; i < 9856; ++i)
    offset_arr_global[i] = i % 256;
#endif
}

// warp  instruction  32bit * 5 //
void warp_param_read(struct warp_param *param, int32_t *rvv_instr_reg) {
  // @TODO implement the real function
  param->src_ptr = src_arr_global;
  param->offset_ptr = offset_arr_global;
  param->out_ptr = out_arr_global;
  param->channel =
      (size_t)((*(rvv_instr_reg + 2) & (int32_t)(0xffff0000)) >> 16);
  param->height = (size_t)(*(rvv_instr_reg + 2) & (int32_t)(0x0000ffff));
  param->width = (size_t)((*(rvv_instr_reg + 3) & (int32_t)(0xffff0000)) >> 16);
  param->offset_fl = (size_t)(*(rvv_instr_reg + 3) & (int32_t)(0x0000ffff));
}

int main() {
  int32_t rvv_instr_reg[10];

  // test for performance
  rvv_instr_reg[0] = 0;                // @TODO assign the real instr head value
  rvv_instr_reg[1] = 0;                // @TODO assign the real instr head value
  rvv_instr_reg[2] = 58 * 65536 + 112; // channel = 58, height = 112;
  rvv_instr_reg[3] = 88 * 65536 + 8;   // width = 88, offset_fl = 8;
  rvv_instr_reg[4] = 0;                // @TODO assign the real addr for src
  rvv_instr_reg[5] = 0;                // @TODO assign the real addr for offset
  rvv_instr_reg[6] = 0;                // @TODO assign the real addr for out

  global_arr_init();
  struct warp_param param;
  warp_param_read(&param, rvv_instr_reg);

  // size_t cycles_s = read_rdcycle();
  size_t insts_s = read_rdinstret();
  warp(&param);
  size_t insts_e = read_rdinstret();
  // size_t cycles_e = read_rdcycle();

  printf("warp_58x112x88 running insts : %d\n", (insts_e - insts_s));
  // printf("warp_58x112x88 running cycles : %d\n", (cycles_e - cycles_s));
#ifndef NDEBUG
  for (int out_idx = 0; out_idx < 571648; out_idx++) {
    printf("output: index : %d, val : %d.\n", out_idx, param.out_ptr[out_idx]);
  }
#endif
  return 0;
}
