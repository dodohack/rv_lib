/*
 * @Author: yuanhang.zhang
 * @Date: 2021-09-23 10:08:50
 * @Last Modified by: yuanhang
 * @Last Modified time: 2021-09-28 15:20:47
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <riscv_vector.h>
#include "../com_lib/platform.h"
#include "../com_lib/printf.h"

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) > (b) ? (a) : (b))
#define CLIP(a, min, max) min(max(min, a), max)

struct resize_param
{
    uint16_t channel;
    uint16_t height;
    uint16_t width;
    int8_t *src_ptr;
    int8_t *out_ptr;
};

int8_t src_arr_global[9856] = {2}; // 1x112x88   9856
int8_t out_arr_global[39424];      // 1x224x176   39424

// resize instruction parse
void resize_param_read(struct resize_param *param, int32_t *rvv_instr_reg)
{
    // @TODO implement the real function
    param->channel = (size_t)((*(rvv_instr_reg + 2) & (int32_t)(0xffff0000)) >> 16);
    param->height = (size_t)(*(rvv_instr_reg + 2) & (int32_t)(0x0000ffff));
    param->width = (size_t)((*(rvv_instr_reg + 3) & (int32_t)(0xffff0000)) >> 16);
    param->src_ptr = src_arr_global;
    param->out_ptr = out_arr_global;
}

void resize_golden_v2(struct resize_param *param)
{

    uint16_t channel = param->channel;
    uint16_t height = param->height;
    uint16_t width = param->width;
    int8_t *src_arr = param->src_ptr;
    int8_t *out_arr = param->out_ptr;

    uint16_t dst_height = height * 2;
    uint16_t dst_width = width * 2;

    size_t hw_fl = 7; // fraction of factor is 7;
    // int cnt = 0;
    for (uint16_t c = 0; c < channel; c++)
    {
        for (uint16_t h = 0; h < dst_height; h++)
        {
            // cnt = 0;
            uint16_t input_y = h << (hw_fl - 1);
            uint16_t y0 = input_y >> hw_fl;
            uint16_t y1 = MIN(y0 + 1, height - 1);
            uint8_t factor = (uint8_t)1 << hw_fl;
            uint8_t h1_lambda = (uint8_t)(input_y - (y0 << hw_fl));
            uint8_t h0_lambda = factor - h1_lambda;
            size_t vl = vsetvlmax_e16m4();
            vuint16m4_t v_w = vid_v_u16m4(vl);
            for (uint16_t w = 0; w < dst_width; w += vl)
            {
                vl = vsetvl_e16m4(dst_width - w);

                vuint16m4_t v_input_x = vsll(v_w, hw_fl - 1, vl);
                vuint16m4_t v_x0 = vsrl(v_input_x, hw_fl, vl);
                vuint16m4_t v_x1 = vminu(vadd(v_x0, 1, vl), width - 1, vl);
                // uint16_t input_x = w << (hw_fl-1);
                // uint16_t x0 = (input_x >> hw_fl);
                // uint16_t x1 = MIN(x0+1, width-1);

                vuint8m2_t v_w1_lambda = vncvt_x(vsub(v_input_x, vsll(v_x0, hw_fl, vl), vl), vl);
                vuint8m2_t v_w0_lambda = vrsub(v_w1_lambda, factor, vl);
                // uint8_t w1_lambda = (uint8_t)(input_x - (x0 << hw_fl));
                // uint8_t w0_lambda = factor - w1_lambda;

                vuint32m8_t v_y0x0_index = vwaddu_vx(v_x0, c * width * height + y0 * width, vl);
                vint8m2_t v_y0x0 = vloxei32(src_arr, v_y0x0_index, vl);
                vuint32m8_t v_y0x1_index = vwaddu_vx(v_x1, c * width * height + y0 * width, vl);
                vint8m2_t v_y0x1 = vloxei32(src_arr, v_y0x1_index, vl);
                vuint32m8_t v_y1x0_index = vwaddu_vx(v_x0, c * width * height + y1 * width, vl);
                vint8m2_t v_y1x0 = vloxei32(src_arr, v_y1x0_index, vl);
                vuint32m8_t v_y1x1_index = vwaddu_vx(v_x1, c * width * height + y1 * width, vl);
                vint8m2_t v_y1x1 = vloxei32(src_arr, v_y1x1_index, vl);
                // uint32_t y0x0_index = c*width*height + y0*width + x0;
                // uint32_t y0x1_index = c*width*height + y0*width + x1;
                // uint32_t y1x0_index = c*width*height + y1*width + x0;
                // uint32_t y1x1_index = c*width*height + y1*width + x1;

                vint16m4_t v_sum1 = vsra(
                    vadd(vwmulsu(v_y0x0, v_w0_lambda, vl), vwmulsu(v_y0x1, v_w1_lambda, vl), vl),
                    hw_fl, vl);
                vint16m4_t v_sum2 = vsra(
                    vadd(vwmulsu(v_y1x0, v_w0_lambda, vl), vwmulsu(v_y1x1, v_w1_lambda, vl), vl),
                    hw_fl, vl);
                vint8m2_t v_out = vnsra(
                    vadd(vmul(v_sum1, h0_lambda, vl), vmul(v_sum2, h1_lambda, vl), vl),
                    hw_fl, vl);
                vuint32m8_t v_dst_index = vwaddu_vx(v_w, c * dst_width * dst_height + h * dst_width, vl);
                vsoxei32(out_arr, v_dst_index, v_out, vl);
                // uint32_t dst_index = c*dst_width*dst_height + h*dst_width + w;
                // int16_t sum1 = (w0_lambda * src_arr[y0x0_index] + w1_lambda * src_arr[y0x1_index]) >> hw_fl;
                // int16_t sum2 = (w0_lambda * src_arr[y1x0_index] + w1_lambda * src_arr[y1x1_index]) >> hw_fl;
                // out_arr[dst_index] = (int8_t)((h0_lambda * sum1 + h1_lambda * sum2) >> hw_fl);

                v_w = vadd(v_w, vl, vl);
            }
        }
    }
}

int main()
{
    // rvv instruction from ACC's register 32bit*10
    // int32_t* rvv_instr_reg = (int32_t*) malloc(10*sizeof(int32_t));
    int32_t rvv_instr_reg[10];
    rvv_instr_reg[0] = 0;               // @TODO assign the real instr head value
    rvv_instr_reg[1] = 0;               // @TODO assign the real instr head value
    rvv_instr_reg[2] = 1 * 65536 + 112; // channel = 1, height = 2;
    rvv_instr_reg[3] = 88 * 65536;      // width = 2;
    rvv_instr_reg[4] = 0;               // @TODO assign the real addr for src
    rvv_instr_reg[5] = 0;               // @TODO assign the real addr for out

    struct resize_param param;

    resize_param_read(&param, rvv_instr_reg);

    int tmp0 = read_rdcycle();
    resize_golden_v2(&param);
    int tmp1 = read_rdcycle();

    printf("resize_1x112x88 running cycles : %d.\n", (tmp1 - tmp0));

    return 0;
}