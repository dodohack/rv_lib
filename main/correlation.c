#include "kernel.h"

int8_t src0_arr_global[571648] = {1}; // 58x112x88
int8_t src1_arr_global[571648] = {1}; // 58x112x88
int8_t out_arr_global[49280];         // 5x112x88

static void global_arr_init() {
#ifndef NDEBUG
  for (size_t i = 0; i < 571648; ++i) {
    src0_arr_global[i] = i % 16;
    src1_arr_global[i] = i % 32;
  }
#endif
}

// correlation instruction parse
static void correlation_param_read(struct correlation_param *param,
                                   int32_t *rvv_instr_reg) {
  // @TODO implement the real function
  param->in_channel =
      (size_t)((*(rvv_instr_reg + 2) & (int32_t)(0xffff0000)) >> 16);
  param->height = (size_t)(*(rvv_instr_reg + 2) & (int32_t)(0x0000ffff));
  param->width = (size_t)((*(rvv_instr_reg + 3) & (int32_t)(0xffff0000)) >> 16);
  param->out_channel = (size_t)(*(rvv_instr_reg + 3) & (int32_t)(0x0000ffff));
  param->out_shift = (size_t)(*(rvv_instr_reg + 4) & (int32_t)(0x0000ffff));
  param->src0_ptr = src0_arr_global;
  param->src1_ptr = src1_arr_global;
  param->out_ptr = out_arr_global;
}

int main() {
  // rvv instruction from ACC's register 32bit*10
  // int32_t* rvv_instr_reg = (int32_t*) malloc(10*sizeof(int32_t));
  int32_t rvv_instr_reg[10];
  rvv_instr_reg[0] = 0;                // @TODO assign the real instr head value
  rvv_instr_reg[1] = 0;                // @TODO assign the real instr head value
  rvv_instr_reg[2] = 58 * 65536 + 112; // in_channel = 58, height = 112;
  rvv_instr_reg[3] = 88 * 65536 + 5;   // width = 88, out_channel = 5;
  rvv_instr_reg[4] = 0;                // out_shift = 3, demo test for 0;
  rvv_instr_reg[5] = 0;                // @TODO assign the real addr for src0
  rvv_instr_reg[6] = 0;                // @TODO assign the real addr for src1
  rvv_instr_reg[7] = 0;                // @TODO assign the real addr for out

  global_arr_init();
  struct correlation_param param;
  correlation_param_read(&param, rvv_instr_reg);

  // size_t cycles_s = read_rdcycle();
  size_t insts_s = read_rdinstret();
  correlation(&param);
  size_t insts_e = read_rdinstret();
  // size_t cycles_e = read_rdcycle();
  printf("correlation_58x112x88_test running insts : %d\n",
         (insts_e - insts_s));
  // printf("correlation_58x112x88_test running cycles : %d\n",
  //        (cycles_e - cycles_s));
#ifndef NDEBUG
  for (int out_idx = 0; out_idx < 49280; out_idx++) {
    printf("output: index : %d, val : %d.\n", out_idx, param.out_ptr[out_idx]);
  }
#endif
  return 0;
}
