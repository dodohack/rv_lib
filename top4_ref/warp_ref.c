/*
 * @Author: yuanhang.zhang
 * @Date: 2021-09-15 18:00:54
 * @Last Modified by: yuanhang
 * @Last Modified time: 2021-09-22 19:55:22
 */

#include <stdio.h>
#include <stdlib.h>
#include <riscv_vector.h>
#include "../com_lib/platform.h"
#include "../com_lib/printf.h"
// #define BOOL int
// BOOL DEBUG = 0;

struct warp_param
{
    int8_t *restrict src_ptr;
    int16_t *restrict offset_ptr;
    int8_t *restrict out_ptr;
    size_t channel;
    size_t height;
    size_t width;
    size_t offset_fl;
};

int8_t src_arr_global[571648] = {2};
int16_t offset_arr_global[9856] = {256};
int8_t out_arr_global[571648];

// warp instruction parse
void warp_param_read(struct warp_param *param, int32_t *rvv_instr_reg)
{
    // @TODO implement the real function
    param->src_ptr = src_arr_global;
    param->offset_ptr = offset_arr_global;
    param->out_ptr = out_arr_global;
    param->channel = (size_t)((*(rvv_instr_reg + 2) & (int32_t)(0xffff0000)) >> 16);
    param->height = (size_t)(*(rvv_instr_reg + 2) & (int32_t)(0x0000ffff));
    param->width = (size_t)((*(rvv_instr_reg + 3) & (int32_t)(0xffff0000)) >> 16);
    param->offset_fl = (size_t)(*(rvv_instr_reg + 3) & (int32_t)(0x0000ffff));
}

void warp_golden(struct warp_param *restrict param)
{

    size_t channel = param->channel;
    size_t height = param->height;
    size_t width = param->width;
    size_t offset_fl = param->offset_fl;
    int8_t *restrict src_arr = param->src_ptr;
    int16_t *restrict offset_arr = param->offset_ptr;
    int8_t *restrict out_arr = param->out_ptr;

    size_t offset_idx, feat_idx;
    int16_t offset_val, offset_int;
    int16_t left_val, right_val, left_weight, right_weight;
    ;

    for (size_t h = 0; h < height; h++)
    {
        for (size_t w = 0; w < width; w++)
        {
            // get offset
            offset_idx = h * width + w;
            offset_val = offset_arr[offset_idx];
            offset_int = offset_val >> offset_fl;
            size_t vl = vsetvlmax_e32m8();
            vuint32m8_t v_c = vid_v_u32m8(vl);
            vint16m4_t v_zero = vmv_v_x_i16m4(0, vl);
            for (size_t c = 0; c < channel; c += vl)
            {
                vl = vsetvl_e16m4(channel - c);

                vuint32m8_t v_feat_idx = vadd(vmul(v_c, height * width, vl), offset_idx, vl);
                feat_idx = c * height * width + offset_idx;

                // judge whether idx out of boundary
                vint16m4_t v_left_val, v_right_val;
                vbool4_t masked = vmsltu(v_feat_idx, channel*height*width + offset_int + 1, vl);
                if ((w - offset_int) >= 1) {
                    v_left_val = vmerge(masked,
                    vwcvt_x(vlse8_v_i8m2(&src_arr[feat_idx - offset_int - 1], height * width, vl), vl)/* false */,
                    0/* true */, vl);
                } else {
                    v_left_val = v_zero;
                }
                if ((w - offset_int) >= 0) {
                    v_right_val = vmerge(masked,
                    vwcvt_x(vlse8_v_i8m2(&src_arr[feat_idx - offset_int], height * width, vl), vl)/* false */,
                    0/* true */, vl);
                } else {
                    v_right_val = v_zero;
                }
                // if ((feat_idx - offset_int -1) < channel*height*width) {
                //     left_val = 0;
                //     right_val = 0;
                // } else {
                //     left_val = (w - offset_int) >= 1 ? (int16_t)src_arr[feat_idx - offset_int - 1] : 0;
                //     right_val = (w - offset_int) >= 0 ? (int16_t)src_arr[feat_idx - offset_int] : 0;
                // }
                //left_val = (((int16_t)(w - offset_int - 1) >= 0) && ((feat_idx - offset_int -1) < channel*height*width)) ? (int16_t)src_arr[feat_idx - offset_int - 1] : 0;
                //right_val = (((int16_t)(w - offset_int) >= 0) && ((feat_idx - offset_int -1) < channel*height*width)) ? (int16_t)src_arr[feat_idx - offset_int] : 0;

                // linear interpolation
                left_weight = offset_val - (offset_int << offset_fl);
                right_weight = (0x0001 << offset_fl) - left_weight;
                vint16m4_t v_out = vadd(vmul(v_left_val, left_weight, vl), vmul(v_right_val, right_weight, vl), vl);
                vsse8_v_i8m2(&out_arr[feat_idx], height * width, vnsra(v_out, offset_fl, vl), vl);
                // out_arr[feat_idx] = (int8_t)((left_val * left_weight + right_val * right_weight) >> offset_fl);
                // if(DEBUG) printf("out_arr[feat_idx] is %d.\n", out_arr[feat_idx] );

                v_c = vadd(v_c, vl, vl);
            }
        }
    }
}

int main()
{
    // rvv instruction from ACC's register 32bit*10
    // int32_t* rvv_instr_reg = (int32_t*) malloc(10*sizeof(int32_t));
    int32_t rvv_instr_reg[10];

    // test for performance
    rvv_instr_reg[0] = 0;                // @TODO assign the real instr head value
    rvv_instr_reg[1] = 0;                // @TODO assign the real instr head value
    rvv_instr_reg[2] = 58 * 65536 + 112; // channel = 2, height = 2;
    rvv_instr_reg[3] = 88 * 65536 + 8;   // width = 2, offset_fl = 8;
    rvv_instr_reg[4] = 0;                // @TODO assign the real addr for src
    rvv_instr_reg[5] = 0;                // @TODO assign the real addr for offset
    rvv_instr_reg[6] = 0;                // @TODO assign the real addr for out

    struct warp_param param;

    warp_param_read(&param, rvv_instr_reg);

    int tmp0 = read_rdcycle();
    warp_golden(&param);
    int tmp1 = read_rdcycle();

    printf("warp_58x112x88 running cycles : %d.\n", (tmp1 - tmp0));

    return 0;
}