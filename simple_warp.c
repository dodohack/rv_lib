#include <stdlib.h>
#include <stdio.h>

struct warp_param{
    size_t channel;
    size_t height;
    size_t width;
    size_t offset_fl;
    int8_t* src_ptr;
    int16_t* offset_ptr;
    int8_t* out_ptr;
};

void warp_golden(struct warp_param *param){

    size_t channel = param->channel;
    size_t height = param->height;
    size_t width = param->width;
    size_t offset_fl = param->offset_fl;
    int8_t* src_arr = param->src_ptr;
    int16_t* offset_arr = param->offset_ptr;
    int8_t* out_arr = param->out_ptr;

    size_t offset_idx, feat_idx;
    int16_t offset_val, offset_int;
    int16_t left_val, right_val, left_weight, right_weight;;

    for (size_t c = 0; c < channel; c++){
        for (size_t h = 0; h < height; h++){
            for (size_t w = 0; w < width; w++){
                // get offset
                offset_idx = h*width + w;
                offset_val = offset_arr[offset_idx];
                offset_int = offset_val >> offset_fl;
                
                // judge whether idx out of boundary
                feat_idx = c*height*width + h*width + w;
                left_val = (((int16_t)(w - offset_int - 1) >= 0) && ((feat_idx - offset_int -1) < channel*height*width)) ? (int16_t)src_arr[feat_idx - offset_int - 1] : 0;
                right_val = (((int16_t)(w - offset_int) >= 0) && ((feat_idx - offset_int -1) < channel*height*width)) ? (int16_t)src_arr[feat_idx - offset_int] : 0;

                // linear interpolation             
                left_weight = offset_val - (offset_int << offset_fl);
                right_weight = (0x0001 << offset_fl) - left_weight;
                out_arr[feat_idx] = (int8_t)((left_val * left_weight + right_val * right_weight) >> offset_fl);
                // if(DEBUG) printf("out_arr[feat_idx] is %d.\n", out_arr[feat_idx] );
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
    rvv_instr_reg[2] = 2 * 65536 + 2;   // channel = 2, height = 2;
    rvv_instr_reg[3] = 2 * 65536 + 8;   // width = 2, offset_fl = 8;
    rvv_instr_reg[4] = 0;   // @TODO assign the real addr for src
    rvv_instr_reg[5] = 0;   // @TODO assign the real addr for offset
    rvv_instr_reg[6] = 0;   // @TODO assign the real addr for out

    struct warp_param param;

    warp_param_read(&param, rvv_instr_reg);
    warp_golden(&param);

    int pass = 1;
    int8_t out_arr_golden[8] = {0,1,0,1,0,1,0,1};
    for (int out_idx=0; out_idx < 8; out_idx++){
        if (!(out_arr_golden[out_idx] == param.out_ptr[out_idx])){
            printf("failed, %d != %d\n", out_arr_golden[out_idx], param.out_ptr[out_idx]);
            pass = 0;
        }
    }
    if (pass) printf("warp_simple_test test passed.\n");  
    else printf("warp_simple_test test failed.\n"); 

    return 0;
}