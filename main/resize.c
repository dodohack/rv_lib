#include "kernel.h"

int8_t src_arr_global[9856] = {2}; // 1x112x88   9856
int8_t out_arr_global[39424];      // 1x224x176   39424

static void global_arr_init() {
#ifndef NDEBUG
  for (size_t i = 0; i < 9856; ++i)
    src_arr_global[i] = i % 64;
#endif
}

// resize instruction parse
void resize_param_read(struct resize_param *param, int32_t *rvv_instr_reg) {
  // @TODO implement the real function
  param->channel =
      (size_t)((*(rvv_instr_reg + 2) & (int32_t)(0xffff0000)) >> 16);
  param->height = (size_t)(*(rvv_instr_reg + 2) & (int32_t)(0x0000ffff));
  param->width = (size_t)((*(rvv_instr_reg + 3) & (int32_t)(0xffff0000)) >> 16);
  param->src_ptr = src_arr_global;
  param->out_ptr = out_arr_global;
}

int main() {
  // rvv instruction from ACC's register 32bit*10
  // int32_t* rvv_instr_reg = (int32_t*) malloc(10*sizeof(int32_t));
  int32_t rvv_instr_reg[10];
  rvv_instr_reg[0] = 0;               // @TODO assign the real instr head value
  rvv_instr_reg[1] = 0;               // @TODO assign the real instr head value
  rvv_instr_reg[2] = 1 * 65536 + 112; // channel = 1, height = 112;
  rvv_instr_reg[3] = 88 * 65536;      // width = 88;
  rvv_instr_reg[4] = 0;               // @TODO assign the real addr for src
  rvv_instr_reg[5] = 0;               // @TODO assign the real addr for out

  global_arr_init();
  struct resize_param param;
  resize_param_read(&param, rvv_instr_reg);

  // size_t cycles_s = read_rdcycle();
  size_t insts_s = read_rdinstret();
  resize(&param);
  size_t insts_e = read_rdinstret();
  // size_t cycles_e = read_rdcycle();

  printf("resize_1x112x88 running insts : %d\n", (insts_e - insts_s));
  // printf("resize_1x112x88 running cycles : %d\n", (cycles_e - cycles_s));
#ifndef NDEBUG
  for (int out_idx = 0; out_idx < 39424; out_idx++) {
    printf("output: index : %d, val : %d.\n", out_idx, param.out_ptr[out_idx]);
  }
#endif
  return 0;
}