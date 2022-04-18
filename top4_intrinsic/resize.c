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

void resize_vec(struct resize_param *param){
    uint16_t channel = param->channel;
    uint16_t height = param->height;
    uint16_t width = param->width;
    int8_t* src_arr = param->src_ptr;
    int8_t* out_arr = param->out_ptr;

    int8_t *src_ptr = src_arr;
    int8_t *out_ptr = out_arr;

    uint16_t dst_height = height * 2;
    uint16_t dst_width = width * 2;
    uint32_t dst_hw = dst_height * dst_width;
    uint32_t src_hw = height * width;

    uint16_t src_h_border = (uint16_t)(height - 1);
    uint16_t src_w_border = (uint16_t)(width - 1);    

    uint16_t dst_idx_arr[256];  // size of h & w is no more than 128
    for (size_t idx = 0; idx < 256; idx++){
        dst_idx_arr[idx] = (uint16_t)idx;
    }
    uint16_t* dst_idx_ptr = dst_idx_arr;

    // xy_idx
    uint16_t y0_arr[256];
    uint16_t y1_arr[256];
    uint16_t *y0_ptr = y0_arr;
    uint16_t *y1_ptr = y1_arr;

    uint16_t x0y0_arr[65536];
    uint16_t x0y1_arr[65536];
    uint16_t x1y0_arr[65536];
    uint16_t x1y1_arr[65536];
    uint16_t *x0y0_ptr = x0y0_arr;
    uint16_t *x0y1_ptr = x0y1_arr;
    uint16_t *x1y0_ptr = x1y0_arr;
    uint16_t *x1y1_ptr = x1y1_arr;

    // lambda 
    uint16_t h0_lambda_arr[65536];
    uint16_t h1_lambda_arr[65536];
    uint16_t w0_lambda_arr[65536];
    uint16_t w1_lambda_arr[65536];
    uint16_t *h0_lambda_ptr = h0_lambda_arr;
    uint16_t *h1_lambda_ptr = h1_lambda_arr;
    uint16_t *w0_lambda_ptr = w0_lambda_arr;
    uint16_t *w1_lambda_ptr = w1_lambda_arr;

    size_t hw_vl, h_vl, w_vl;
    size_t vl_cnt = 0;
    ptrdiff_t y_stride = dst_width * 2;

    for (uint16_t h = dst_height; (h_vl = vsetvl_e16m2(h)); h-= h_vl){
        vuint16m2_t dst_h_idx = vle16_v_u16m2(dst_idx_ptr);
        vuint16m2_t input_y = vsll_vx_u16m2(dst_h_idx, 6);   // 6 = 7 - 1 = hw_fl - log2(2)
        vuint16m2_t y0 = vsrl_vx_u16m2(input_y, 7);
        vuint16m2_t y1_tmp = vadd_vx_u16m2(y0, 1);
        vuint16m2_t y1 = vminu_vx_u16m2(y1_tmp, src_h_border);
        vuint16m2_t y0_shifted = vsll_vx_u16m2(y0, 7);
        vuint16m2_t h1_lambda = vsub_vv_u16m2(input_y, y0_shifted);
        vuint16m2_t h0_lambda = vrsub_vx_u16m2(h1_lambda, 128);   // 1 << 7

        vse16_v_u16m2(y0_ptr, y0);
        vse16_v_u16m2(y1_ptr, y1);
        
        for (uint16_t h_idx = 0; h_idx < h_vl; h_idx++){
            h0_lambda_ptr = vl_cnt * dst_width + h_idx * dst_width + h0_lambda_arr;
            h1_lambda_ptr = vl_cnt * dst_width + h_idx * dst_width + h1_lambda_arr;
            for (uint16_t w = dst_width; (w_vl = vsetvl_e16m2(w)); w-= w_vl){            
                uint16_t h0_val = h0_lambda[h_idx];
                uint16_t h1_val = h1_lambda[h_idx];
                vuint16m2_t h0_lambda_tmp = vmv_v_x_u16m2(h0_val);
                vuint16m2_t h1_lambda_tmp = vmv_v_x_u16m2(h1_val);
                vse16_v_u16m2(h0_lambda_ptr, h0_lambda_tmp);
                vse16_v_u16m2(h1_lambda_ptr, h1_lambda_tmp);
 
                h0_lambda_ptr += w_vl;
                h1_lambda_ptr += w_vl;
            }
        }

        y0_ptr += h_vl;
        y1_ptr += h_vl;
        dst_idx_ptr += h_vl;
        vl_cnt += h_vl;
    }

    for (uint16_t h = 0; h < dst_height; h++){
        size_t idx_ptr_shift = h * dst_width;
        x0y0_ptr = x0y0_arr + idx_ptr_shift;
        x1y0_ptr = x1y0_arr + idx_ptr_shift;
        x0y1_ptr = x0y1_arr + idx_ptr_shift;
        x1y1_ptr = x1y1_arr + idx_ptr_shift;

        w0_lambda_ptr = w0_lambda_arr + idx_ptr_shift;
        w1_lambda_ptr = w1_lambda_arr + idx_ptr_shift;

        dst_idx_ptr = dst_idx_arr;

        uint16_t y0 = y0_arr[h];
        uint16_t y1 = y1_arr[h];
        uint16_t y0w = y0 * width;
        uint16_t y1w = y1 * width;

        for (uint16_t w = dst_width; (w_vl = vsetvl_e16m2(w)); w-= w_vl){
            vuint16m2_t dst_w_idx = vle16_v_u16m2(dst_idx_ptr);
            vuint16m2_t input_x = vsll_vx_u16m2(dst_w_idx, 6);   // 6 = 7 - 1 = hw_fl - log2(2)
            vuint16m2_t x0 = vsrl_vx_u16m2(input_x, 7);
            vuint16m2_t x1_tmp = vadd_vx_u16m2(x0, 1);
            vuint16m2_t x1 = vminu_vx_u16m2(x1_tmp, src_w_border);
            vuint16m2_t x0_shifted = vsll_vx_u16m2(x0, 7);
            vuint16m2_t w1_lambda = vsub_vv_u16m2(input_x, x0_shifted);
            vuint16m2_t w0_lambda = vrsub_vx_u16m2(w1_lambda, 128);   // 1 << 7

            vuint16m2_t dst_hw_x0y0 = vadd_vx_u16m2(x0, y0w);
            vuint16m2_t dst_hw_x1y0 = vadd_vx_u16m2(x1, y0w);
            vuint16m2_t dst_hw_x0y1 = vadd_vx_u16m2(x0, y1w);
            vuint16m2_t dst_hw_x1y1 = vadd_vx_u16m2(x1, y1w);

            vse16_v_u16m2(x0y0_ptr, dst_hw_x0y0);
            vse16_v_u16m2(x1y0_ptr, dst_hw_x1y0);
            vse16_v_u16m2(x0y1_ptr, dst_hw_x0y1);
            vse16_v_u16m2(x1y1_ptr, dst_hw_x1y1);

            vse16_v_u16m2(w0_lambda_ptr, w0_lambda);
            vse16_v_u16m2(w1_lambda_ptr, w1_lambda);

            w0_lambda_ptr += w_vl;
            w1_lambda_ptr += w_vl;

            x0y0_ptr += w_vl;
            x1y0_ptr += w_vl;
            x0y1_ptr += w_vl;
            x1y1_ptr += w_vl;

            dst_idx_ptr += w_vl;
        }
    } 

    for (uint16_t c = 0; c < channel; c++){

        x0y0_ptr = x0y0_arr;
        x1y0_ptr = x1y0_arr;
        x0y1_ptr = x0y1_arr;
        x1y1_ptr = x1y1_arr;

        src_ptr = src_arr + c * src_hw;
        out_ptr = out_arr + c * dst_hw;

        w0_lambda_ptr = w0_lambda_arr;
        w1_lambda_ptr = w1_lambda_arr;
        h0_lambda_ptr = h0_lambda_arr;
        h1_lambda_ptr = h1_lambda_arr;

        for (uint32_t hw = dst_hw; (hw_vl = vsetvl_e16m2(hw)); hw-= hw_vl){
            vuint16m2_t y0x0_index = vle16_v_u16m2(x0y0_ptr);
            vuint16m2_t y0x1_index = vle16_v_u16m2(x1y0_ptr);
            vuint16m2_t y1x0_index = vle16_v_u16m2(x0y1_ptr);
            vuint16m2_t y1x1_index = vle16_v_u16m2(x1y1_ptr);     

            vint8m1_t y0x0_val = vlxei16_v_i8m1(src_ptr, y0x0_index);
            vint8m1_t y0x1_val = vlxei16_v_i8m1(src_ptr, y0x1_index);
            vint8m1_t y1x0_val = vlxei16_v_i8m1(src_ptr, y1x0_index);
            vint8m1_t y1x1_val = vlxei16_v_i8m1(src_ptr, y1x1_index);

            vint16m2_t y0x0_val_int16 = vwadd_vx_i16m2(y0x0_val, 0);
            vint16m2_t y0x1_val_int16 = vwadd_vx_i16m2(y0x1_val, 0);
            vint16m2_t y1x0_val_int16 = vwadd_vx_i16m2(y1x0_val, 0);
            vint16m2_t y1x1_val_int16 = vwadd_vx_i16m2(y1x1_val, 0);

            vuint16m2_t w0_lambda = vle16_v_u16m2(w0_lambda_ptr);
            vuint16m2_t w1_lambda = vle16_v_u16m2(w1_lambda_ptr);
            vint16m2_t w0_lambda_int16 = vreinterpret_v_u16m2_i16m2(w0_lambda);
            vint16m2_t w1_lambda_int16 = vreinterpret_v_u16m2_i16m2(w1_lambda);

            vint16m2_t sum1_y0x0 = vmul_vv_i16m2(y0x0_val_int16, w0_lambda_int16);
            vint16m2_t sum1_y0x1 = vmul_vv_i16m2(y0x1_val_int16, w1_lambda_int16);
            vint16m2_t sum2_y1x0 = vmul_vv_i16m2(y1x0_val_int16, w0_lambda_int16);
            vint16m2_t sum2_y1x1 = vmul_vv_i16m2(y1x1_val_int16, w1_lambda_int16);
            vint16m2_t sum1 = vadd_vv_i16m2(sum1_y0x0, sum1_y0x1);
            vint16m2_t sum1_shifted = vsra_vx_i16m2(sum1, 7);   
            vint16m2_t sum2 = vadd_vv_i16m2(sum2_y1x0, sum2_y1x1);
            vint16m2_t sum2_shifted = vsra_vx_i16m2(sum2, 7);

            vuint16m2_t h0_lambda = vle16_v_u16m2(h0_lambda_ptr);
            vuint16m2_t h1_lambda = vle16_v_u16m2(h1_lambda_ptr);
            vint16m2_t h0_lambda_int16 = vreinterpret_v_u16m2_i16m2(h0_lambda);
            vint16m2_t h1_lambda_int16 = vreinterpret_v_u16m2_i16m2(h1_lambda);

            vint16m2_t dst_h0 = vmul_vv_i16m2(sum1_shifted, h0_lambda_int16);
            vint16m2_t dst_h1 = vmul_vv_i16m2(sum2_shifted, h1_lambda_int16);
            vint16m2_t dst_tmp = vadd_vv_i16m2(dst_h0, dst_h1);
            vint8m1_t dst_val = vnsra_wx_i8m1(dst_tmp, 7);
            vse8_v_i8m1(out_ptr, dst_val);

            out_ptr += hw_vl;           
            x0y0_ptr += hw_vl;            
            x1y0_ptr += hw_vl;
            x0y1_ptr += hw_vl;
            x1y1_ptr += hw_vl;
            h0_lambda_ptr += hw_vl;
            h1_lambda_ptr += hw_vl;
            w0_lambda_ptr += hw_vl;
            w1_lambda_ptr += hw_vl; 
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
    resize_vec(&param);
    int tmp1 = read_rdcycle();

    printf("resize_1x112x88 running cycles : %d.\n", (tmp1-tmp0));

    return 0;
}