#include "kernel.h"

uint8_t src_arr_global[360640] = {0};
uint16_t rois_arr_global[1200] = {0};
uint16_t out_arr_global[117600] = {0};

static void global_arr_init() {
#ifndef NDEBUG
  for (uint32_t j = 0; j < 360640; j++) {
    src_arr_global[j] = j % 64;
  }
  for (uint32_t i = 0; i < 150; i++) {
    rois_arr_global[i * 8] = (uint16_t)(1);
    rois_arr_global[i * 8 + 1] = (uint16_t)(1);
    rois_arr_global[i * 8 + 2] = (uint16_t)(11);
    rois_arr_global[i * 8 + 3] = (uint16_t)(11);

    rois_arr_global[i * 8 + 4] = (uint16_t)(2);
    rois_arr_global[i * 8 + 5] = (uint16_t)(2);
    rois_arr_global[i * 8 + 6] = (uint16_t)(16);
    rois_arr_global[i * 8 + 7] = (uint16_t)(16);
  }
#endif
}

// psroi instruction parse
static void psroi_param_read(struct psroi_param *param,
                             int32_t *rvv_instr_reg) {
  // @TODO implement the real function
  param->rois_num = (uint32_t)(*(rvv_instr_reg + 2));
  param->pooled_h = (uint32_t)(*(rvv_instr_reg + 3));
  param->pooled_w = (uint32_t)(*(rvv_instr_reg + 4));
  param->pooled_c = (uint32_t)(*(rvv_instr_reg + 5));
  param->src_height = (uint32_t)(*(rvv_instr_reg + 6));
  param->src_width = (uint32_t)(*(rvv_instr_reg + 7));
  param->sampling_ratio =
      (uint8_t)((*(rvv_instr_reg + 8) & (int32_t)(0x00ff0000)) >> 16);
  param->roi_shift = (uint8_t)((*(rvv_instr_reg + 8) & (int32_t)(0x000000ff)));
  param->src_arr = src_arr_global;
  param->rois_arr = rois_arr_global;
  param->out_arr = out_arr_global;
}

int main() {
  // rvv instruction from ACC's register 32bit*10
  // int32_t* rvv_instr_reg = (int32_t*) malloc(15*sizeof(int32_t));
  int32_t rvv_instr_reg[15];
  rvv_instr_reg[0] = 0;             // @TODO assign the real instr head value
  rvv_instr_reg[1] = 0;             // @TODO assign the real instr head value
  rvv_instr_reg[2] = 300;           // rois_num = 300;
  rvv_instr_reg[3] = 7;             // pooled_h = 7;
  rvv_instr_reg[4] = 7;             // pooled_w = 7;
  rvv_instr_reg[5] = 8;             // pooled_c = 8;
  rvv_instr_reg[6] = 23;            // src_height = 23;
  rvv_instr_reg[7] = 40;            // src_width = 40;
  rvv_instr_reg[8] = 2 * 65536 + 0; // sampling_ratio = 2; roi_shift = 0;
  rvv_instr_reg[9] = 0;             // @TODO assign the real addr for src
  rvv_instr_reg[10] = 0;            // @TODO assign the real addr for rois
  rvv_instr_reg[11] = 0;            // @TODO assign the real addr for out

  global_arr_init();
  struct psroi_param param;
  psroi_param_read(&param, rvv_instr_reg);

  // size_t cycles_s = read_rdcycle();
  size_t insts_s = read_rdinstret();
  psroi_pooling_align(&param);
  size_t insts_e = read_rdinstret();
  // size_t cycles_e = read_rdcycle();

  printf("psroi_23x40x392x300 running insts : %d\n", (insts_e - insts_s));
  // printf("psroi_23x40x392x300 running cycles : %d\n", (cycles_e - cycles_s));
#ifndef NDEBUG
  for (int out_idx = 0; out_idx < 117600; out_idx++) {
    printf("output: index : %d, val : %d.\n", out_idx, param.out_arr[out_idx]);
  }
#endif
  return 0;
}
