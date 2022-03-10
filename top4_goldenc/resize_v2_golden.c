/*
 * @Author: yuanhang.zhang 
 * @Date: 2021-09-23 10:08:50 
 * @Last Modified by: yuanhang
 * @Last Modified time: 2021-09-28 15:20:47
 */

#include <riscv_vector.h>
#include <stdio.h>
#include <stdlib.h>
#include "../env/platform.h"
#include "../stubs/printf.h"

struct resize_param{
    uint16_t channel;
    uint16_t height;
    uint16_t width;
    int8_t* src_ptr;
    int8_t* out_ptr;
};

int8_t src_arr_global[9856] = {2};    // 1x112x88   9856
int8_t out_arr_global[39424];   // 1x224x176   39424

// resize instruction parse
void resize_param_read(struct resize_param *param, int32_t* rvv_instr_reg) {
    // @TODO implement the real function
    param->channel = (size_t)((*(rvv_instr_reg+2) & (int32_t)(0xffff0000)) >> 16);
    param->height = (size_t)(*(rvv_instr_reg+2) & (int32_t)(0x0000ffff));
    param->width = (size_t)((*(rvv_instr_reg+3) & (int32_t)(0xffff0000)) >> 16);
    param->src_ptr = src_arr_global;
    param->out_ptr = out_arr_global;
}

void resize_golden_v2(struct resize_param *param){

    uint16_t channel = param->channel;
    uint16_t height = param->height;
    uint16_t width = param->width;
    int8_t* src_arr = param->src_ptr;
    int8_t* out_arr = param->out_ptr;

    uint16_t dst_height = height * 2;
    uint16_t dst_width = width * 2;

    size_t hw_fl = 7;   // fraction of factor is 7;
    // int cnt = 0;
    for (uint16_t c = 0; c < channel; c++){
        for (uint16_t h = 0; h < dst_height; h++){
            // cnt = 0;
            for (uint16_t w = 0; w < dst_width; w++){
            
                uint16_t input_y = h << (hw_fl-1);
                uint16_t y0 = input_y >> hw_fl;
                uint16_t y1 = MIN(y0+1, height-1);  
           
                uint16_t input_x = w << (hw_fl-1);
                uint16_t x0 = (input_x >> hw_fl);
                uint16_t x1 = MIN(x0+1, width-1);  
            
                uint8_t factor = (uint8_t)1 << hw_fl;
                uint8_t h1_lambda = (uint8_t)(input_y - (y0 << hw_fl));
                uint8_t h0_lambda = factor - h1_lambda;
                uint8_t w1_lambda = (uint8_t)(input_x - (x0 << hw_fl));
                uint8_t w0_lambda = factor - w1_lambda;

                uint32_t y0x0_index = c*width*height + y0*width + x0;
                uint32_t y0x1_index = c*width*height + y0*width + x1;
                uint32_t y1x0_index = c*width*height + y1*width + x0;
                uint32_t y1x1_index = c*width*height + y1*width + x1;

                uint32_t dst_index = c*dst_width*dst_height + h*dst_width + w;
                int16_t sum1 = (w0_lambda * src_arr[y0x0_index] + w1_lambda * src_arr[y0x1_index]) >> hw_fl;
                int16_t sum2 = (w0_lambda * src_arr[y1x0_index] + w1_lambda * src_arr[y1x1_index]) >> hw_fl;                
                out_arr[dst_index] = (int8_t)((h0_lambda * sum1 + h1_lambda * sum2) >> hw_fl);
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
    rvv_instr_reg[2] = 1 * 65536 + 112;   // channel = 1, height = 2;
    rvv_instr_reg[3] = 88 * 65536;   // width = 2;
    rvv_instr_reg[4] = 0;   // @TODO assign the real addr for src
    rvv_instr_reg[5] = 0;   // @TODO assign the real addr for out

    struct resize_param param;

    resize_param_read(&param, rvv_instr_reg);

    int tmp0 = read_rdcycle();
    resize_golden_v2(&param);
    int tmp1 = read_rdcycle();

    printf("resize_1x112x88 running cycles : %d.\n", (tmp1-tmp0));

    return 0;
}