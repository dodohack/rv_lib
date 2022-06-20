/*
 * @Author: yuanhang.zhang 
 * @Date: 2021-09-22 15:22:24 
 * @Last Modified by: yuanhang
 * @Last Modified time: 2021-09-23 10:59:46
 */

#include <stdio.h>
#include <stdlib.h>
#include <riscv_vector.h>
#include "../com_lib/platform.h"
#include "../com_lib/printf.h"

struct correlation_param{
    size_t in_channel;
    size_t height;
    size_t width;
    size_t out_channel;
    size_t out_shift; 
    int8_t* src0_ptr;
    int8_t* src1_ptr;
    int8_t* out_ptr;
};

int8_t src0_arr_global[571648] = {1};   // 58x112x88
int8_t src1_arr_global[571648] = {1};   // 58x112x88 
int8_t out_arr_global[49280];  // 5x112x88

// correlation instruction parse
void correlation_param_read(struct correlation_param *param, int32_t* rvv_instr_reg) {
    // @TODO implement the real function
    param->in_channel = (size_t)((*(rvv_instr_reg+2) & (int32_t)(0xffff0000)) >> 16);
    param->height = (size_t)(*(rvv_instr_reg+2) & (int32_t)(0x0000ffff));
    param->width = (size_t)((*(rvv_instr_reg+3) & (int32_t)(0xffff0000)) >> 16);
    param->out_channel = (size_t)(*(rvv_instr_reg+3) & (int32_t)(0x0000ffff));
    param->out_shift = (size_t)(*(rvv_instr_reg+4) & (int32_t)(0x0000ffff));
    param->src0_ptr = src0_arr_global;
    param->src1_ptr = src1_arr_global;
    param->out_ptr = out_arr_global;
}

void correlation_golden(struct correlation_param *param){

    size_t in_channel = param->in_channel;
    size_t height = param->height;
    size_t width = param->width;
    size_t out_channel = param->out_channel;
    size_t out_shift = param->out_shift;
    int8_t* src0_arr = param->src0_ptr;
    int8_t* src1_arr = param->src1_ptr;
    int8_t* out_arr = param->out_ptr;

    size_t in_idx1 = 0, in_idx2 = 0, out_idx = 0;
    for (size_t d = 0; d < out_channel; ++d){
        for (size_t i = 0; i < height; ++i){
            for (size_t j = 0; j < width; ++j){
                out_idx = d * width * height + i * width + j;
                int16_t sum_data = 0;
                if (j >= d)
                {
                    size_t vl;
                    vint16m1_t sum;
                    sum = vmv_s(sum, sum_data, 1);
                    for (size_t k = 0; k < in_channel; k += vl)
                    {
                        vl = vsetvl_e8m4(in_channel - k);
                        in_idx1 = k * width * height + i * width + j;
                        in_idx2 = k * width * height + i * width + j - d;
                        vint8m4_t v1 = vlse8_v_i8m4(&src0_arr[in_idx1], width * height, vl);
                        vint8m4_t v2 = vlse8_v_i8m4(&src1_arr[in_idx2], width * height, vl);
                        sum = vredsum(sum, vwmul(v1, v2, vl), sum, vl);
                    }
                    sum_data = vmv_x(sum);
                }
                out_arr[out_idx] = (int8_t)(sum_data >> out_shift);
                // if(DEBUG) printf("sum_data is %d.\n", out_arr[out_idx]);
            }
        }
    }
}


int main(){
    // rvv instruction from ACC's register 32bit*10
    // int32_t* rvv_instr_reg = (int32_t*) malloc(10*sizeof(int32_t));  
    int32_t rvv_instr_reg[10];
    rvv_instr_reg[0] = 0;   // @TODO assign the real instr head value
    rvv_instr_reg[1] = 0;   // @TODO assign the real instr head value
    rvv_instr_reg[2] = 58 * 65536 + 112;   // in_channel = 58, height = 112;
    rvv_instr_reg[3] = 88 * 65536 + 5;   // width = 88, out_channel = 5;
    rvv_instr_reg[4] = 0;   // out_shift = 3, demo test for 0;
    rvv_instr_reg[5] = 0;   // @TODO assign the real addr for src0
    rvv_instr_reg[6] = 0;   // @TODO assign the real addr for src1
    rvv_instr_reg[7] = 0;   // @TODO assign the real addr for out    

    struct correlation_param param;
    correlation_param_read(&param, rvv_instr_reg);

    int tmp0 = read_rdcycle();
    correlation_golden(&param);
    int tmp1 = read_rdcycle();

    printf("correlation_58x112x88_test running cycles : %d.\n", (tmp1-tmp0));

    return 0;
}