#include <riscv_vector.h>
#include <stdio.h>
#include <stdlib.h>
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

int8_t src0_arr_global[571648] = {1}; //58x112x88
int8_t src1_arr_global[571648] = {1}; //58x112x88
int8_t out_arr_global[49280]; // 5x112x88

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

__attribute__((noinline))
void correlation_vec(struct correlation_param *param){
    size_t in_channel = param->in_channel;
    size_t height = param->height;
    size_t width = param->width;
    size_t out_channel = param->out_channel;
    size_t out_shift = param->out_shift;
    int8_t* src0_arr = param->src0_ptr;
    int8_t* src1_arr = param->src1_ptr;
    int8_t* out_arr = param->out_ptr;

    int8_t* src0_ptr = src0_arr;
    int8_t* src1_ptr = src1_arr;
    int8_t* out_ptr = out_arr;

    size_t fm_size = height * width;
    size_t vl = 0;
    size_t vl0 = 0;
    size_t vl_cnt = 0;

    for (size_t w = width; (vl = vsetvl_e8m2(w)); w -= vl){
        for (size_t h = 0; h < height; h++){
            for (size_t d = 0; d < out_channel; d++){
                src0_ptr = h * width + vl_cnt + d + src0_arr;
                src1_ptr = h * width + vl_cnt + src1_arr;
                out_ptr = h * width + vl_cnt + d * fm_size + out_arr;
                vl0 = vsetvl_e8m2(w - d);
                vint16m4_t acc = vmv_v_x_i16m4(0, vl0);
                vint8m2_t vx, vy;
                for (size_t c = 0; c < in_channel; c++){
                    vx = vle8_v_i8m2(src0_ptr, vl0);
                    vy = vle8_v_i8m2(src1_ptr, vl0);
                    acc = vwmacc_vv_i16m4(acc, vy, vx, vl0);
                    src0_ptr += fm_size;
                    src1_ptr += fm_size;
                }
                vint8m2_t acc_sra = vnsra_wx_i8m2(acc, out_shift, vl0);
                vse8_v_i8m2(out_ptr + d, acc_sra, vl0);
            }
        }
        vl_cnt += vl;
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
    correlation_vec(&param);
    int tmp1 = read_rdcycle();

    printf("correlation_58x112x88_test running cycles : %d.\n", (tmp1-tmp0));

    return 0;
}
