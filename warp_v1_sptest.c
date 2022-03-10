/*
 * @Author: yuanhang.zhang 
 * @Date: 2021-09-15 18:00:54 
 * @Last Modified by: yuanhang
 * @Last Modified time: 2021-09-28 11:15:12
 */

#include <riscv_vector.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "../env/platform.h"

#define BOOL int
BOOL DEBUG = 1;

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


void warp_vec(struct warp_param *param){

    size_t channel = param->channel;
    size_t height = param->height;
    size_t width = param->width;
    size_t offset_fl = param->offset_fl;
    int8_t* src_arr = param->src_ptr;
    int16_t* offset_arr = param->offset_ptr;
    int8_t* out_arr = param->out_ptr;

    int8_t* src_ptr = src_arr;
    int16_t* offset_ptr = offset_arr;
    int8_t* out_ptr = out_arr;

    size_t w_vl = 0;
    size_t vl_cnt = 0;
    int16_t w_arr_int16[256];
    int8_t maskedoff_arr[256];
    for (size_t i = 0; i < 256; i++){
        w_arr_int16[i] = (int16_t)i;
        maskedoff_arr[i] = (int8_t)0;
    }
    int16_t *w_ptr_int16 = w_arr_int16;

    for (size_t h = 0; h < height; h++){  
        offset_ptr = h * width + offset_arr;  
        w_ptr_int16 = w_arr_int16;  
        vl_cnt = 0; 
        for (size_t w = width; (w_vl = vsetvl_e8m1(w)); w-= w_vl){
            vint16m2_t offset_val = vle16_v_i16m2(offset_ptr);
            vint16m2_t offset_int = vsra_vx_i16m2(offset_val, offset_fl);
            vint16m2_t w_idx_int = vle16_v_i16m2(w_ptr_int16);  
            vint16m2_t offset_int_shifted = vsll_vx_i16m2(offset_int, offset_fl); 

            vint16m2_t offset_fraction = vsub_vv_i16m2(offset_val, offset_int_shifted); 
            vuint16m2_t offset_fraction_uint16 = vreinterpret_v_i16m2_u16m2(offset_fraction);
            vuint16m2_t offset_fraction_uint16_shifted = vsll_vx_u16m2(offset_fraction_uint16, 8);
            vuint8m1_t offset_fraction_uint8 = vnsrl_wx_u8m1(offset_fraction_uint16_shifted, 8);
            vint8m1_t offset_fraction_int8 = vreinterpret_v_u8m1_i8m1(offset_fraction_uint8);

            vint16m2_t right_idx_sub_int16 = vsub_vv_i16m2(w_idx_int, offset_int);
            vint16m2_t left_idx_sub_int16 = vsub_vx_i16m2(right_idx_sub_int16, 1);

            vuint16m2_t right_idx_sub_uint16 = vreinterpret_v_i16m2_u16m2(right_idx_sub_int16);
            vuint16m2_t right_idx_sub_uint16_shifted = vsll_vx_u16m2(right_idx_sub_uint16, 8);            
            vuint8m1_t right_idx_sub_uint8 = vnsrl_wx_u8m1(right_idx_sub_uint16_shifted, 8);
            // vint8m1_t right_idx_sub_int8 = vreinterpret_v_u8m1_i8m1(right_idx_sub_uint8);

            vuint16m2_t left_idx_sub_uint16 = vreinterpret_v_i16m2_u16m2(left_idx_sub_int16);
            vuint16m2_t left_idx_sub_uint16_shifted = vsll_vx_u16m2(left_idx_sub_uint16, 8);            
            vuint8m1_t left_idx_sub_uint8 = vnsrl_wx_u8m1(left_idx_sub_uint16_shifted, 8);
            // vint8m1_t left_idx_sub_int8 = vreinterpret_v_u8m1_i8m1(left_idx_sub_uint8);

            vbool8_t right_masked = vmsgt_vx_i16m2_b8(right_idx_sub_int16, -1);
            vbool8_t left_masked = vmsgt_vx_i16m2_b8(left_idx_sub_int16, -1);  

            vint8m1_t maskedoff_val = vle8_v_i8m1(maskedoff_arr);

            src_ptr = h * width + src_arr;
            out_ptr = h * width + vl_cnt + out_arr;
            for (size_t c = 0; c < channel; c++){
                vint8m1_t right_val = vlxei8_v_i8m1_m(right_masked, maskedoff_val, src_ptr, right_idx_sub_uint8);             
                vint8m1_t left_val = vlxei8_v_i8m1_m(left_masked, maskedoff_val, src_ptr, left_idx_sub_uint8); 
                vint8m1_t out_sub_part = vsub_vv_i8m1(left_val, right_val);
                vint16m2_t right_val_int16 = vwadd_vx_i16m2(right_val, 0);
                vint16m2_t right_val_shifted = vsll_vx_i16m2(right_val_int16, offset_fl);
                vint16m2_t out_val = vwmacc_vv_i16m2(right_val_shifted, out_sub_part, offset_fraction_int8);
                vint8m1_t out_val_shifted = vnsra_wx_i8m1(out_val, offset_fl);
                vse8_v_i8m1(out_ptr, out_val_shifted);
                src_ptr += width*height;
                out_ptr += width*height;
            } 
            w_ptr_int16 += w_vl; 
            offset_ptr += w_vl;  
            vl_cnt += w_vl; 
        }
    }   
}

void warp_simple_test(){
    size_t channel = 2;
    size_t height = 2;
    size_t width = 2;
    size_t offset_fl = 8;
    int8_t src_arr[8] = {1,1,2,2,3,3,4,4};
    int16_t offset_arr[4] = {256,256,256,256}; 
    int8_t out_arr_golden[8]; 
    int8_t out_arr_vec[8]; 

    struct warp_param golden_param = {channel, height, width, offset_fl, src_arr, offset_arr, out_arr_golden};
    struct warp_param rvv_param = {channel, height, width, offset_fl, src_arr, offset_arr, out_arr_vec};
    warp_golden(&golden_param);
    warp_vec(&rvv_param);

    int pass = 1;
    for (int out_idx=0; out_idx < 8; out_idx++){
        // if(DEBUG) printf("golden_param.out_ptr is %d.\n", golden_param.out_ptr[out_idx]);
        // if(DEBUG) printf("rvv_param.out_ptr is %d.\n", rvv_param.out_ptr[out_idx]);
        if (!(golden_param.out_ptr[out_idx] == rvv_param.out_ptr[out_idx])){
            printf("failed, %d != %d\n", golden_param.out_ptr[out_idx], rvv_param.out_ptr[out_idx]);
            pass = 0;
        }
    }
    if (pass) printf("warp simple test passed.\n");  
    else printf("warp simple test failed.\n");  
}

void warp_border_test(){
    srandom(1);
    size_t channel = 2;
    size_t height = 32;
    size_t width = 32;
    size_t offset_fl = 8;

    size_t data_size = channel * height * width;  // 2178

    int8_t src_arr[2048]; 
    for(size_t idx=0; idx<data_size; idx++){
        src_arr[idx] = (rand()%8);
    }

    int16_t offset_arr[1024];
    for(size_t idx=0; idx<data_size; idx++){
        offset_arr[idx] = 256;
    }   
    
    int8_t out_arr_golden[2048]; 
    int8_t out_arr_vec[2048]; 

    struct warp_param golden_param = {channel, height, width, offset_fl, src_arr, offset_arr, out_arr_golden};
    struct warp_param rvv_param = {channel, height, width, offset_fl, src_arr, offset_arr, out_arr_vec};
    warp_golden(&golden_param);
    warp_vec(&rvv_param);

    int pass = 1;
    for (int out_idx=0; out_idx < data_size; out_idx++){
        // if(DEBUG) printf("golden_param.out_ptr is %d.\n", golden_param.out_ptr[out_idx]);
        // if(DEBUG) printf("rvv_param.out_ptr is %d.\n", rvv_param.out_ptr[out_idx]);
        if (!(golden_param.out_ptr[out_idx] == rvv_param.out_ptr[out_idx])){
            printf("failed, %d != %d\n", golden_param.out_ptr[out_idx], rvv_param.out_ptr[out_idx]);
            pass = 0;
        }
    }
    if (pass) printf("warp border test passed.\n");  
    else printf("warp border test failed.\n");  
}

void warp58x112x88_random_test(int seed){
    srandom(seed);

    size_t channel = 58;
    size_t height = 112;
    size_t width = 88;
    size_t offset_fl = 8;

    int8_t src_arr[571648]; 
    // memset(src_arr, 1, 571648*sizeof(int8_t));
    for(size_t idx=0; idx<571648; idx++){
        src_arr[idx] = (rand()%127);
    }

    int16_t offset_arr[9856];
    for(size_t idx=0; idx<9856; idx++){
        offset_arr[idx] = (rand()%width) * 256 + 256;
    }

    int8_t out_arr_golden[571648]; 
    int8_t out_arr_vec[571648]; 

    struct warp_param golden_param = {channel, height, width, offset_fl, src_arr, offset_arr, out_arr_golden};
    struct warp_param rvv_param = {channel, height, width, offset_fl, src_arr, offset_arr, out_arr_vec};
    warp_golden(&golden_param);
    warp_vec(&rvv_param);

    int pass = 1;
    for (int out_idx=0; out_idx < 571648; out_idx++){
        if (!(golden_param.out_ptr[out_idx] == rvv_param.out_ptr[out_idx])){
            printf("failed, %d != %d\n", golden_param.out_ptr[out_idx], rvv_param.out_ptr[out_idx]);
            pass = 0;
        }
    }
    if (pass) printf("warp58x112x88_random test passed.\n");  
    else printf("warp58x112x88_random test failed.\n");  
}

void warp29x224x176_random_test(int seed){
    srandom(seed);

    size_t channel = 29;
    size_t height = 224;
    size_t width = 176;
    size_t offset_fl = 8;

    int8_t src_arr[1143296]; 
    // memset(src_arr, 1, 1143296*sizeof(int8_t));
    for(size_t idx=0; idx<1143296; idx++){
        src_arr[idx] = (rand()%127);
    }

    int16_t offset_arr[39424];
    for(size_t idx=0; idx<39424; idx++){
        offset_arr[idx] = (rand()%127) * 256 + 256;
    }

    int8_t out_arr_golden[1143296]; 
    int8_t out_arr_vec[1143296]; 

    struct warp_param golden_param = {channel, height, width, offset_fl, src_arr, offset_arr, out_arr_golden};
    struct warp_param rvv_param = {channel, height, width, offset_fl, src_arr, offset_arr, out_arr_vec};
    warp_golden(&golden_param);
    warp_vec(&rvv_param);

    int pass = 1;
    for (int out_idx=0; out_idx < 8; out_idx++){
        if (!(golden_param.out_ptr[out_idx] == rvv_param.out_ptr[out_idx])){
            printf("failed, %d != %d\n", golden_param.out_ptr[out_idx], rvv_param.out_ptr[out_idx]);
            pass = 0;
        }
    }
    if (pass) printf("warp29x224x176_random test passed.\n");  
    else printf("warp29x224x176_random test failed.\n");  
}


int main(){
    int tmp0 = read_rdcycle();
    warp_simple_test();
    int tmp1 = read_rdcycle();
    printf("warp_simple_test running cycles : %d.\n", (tmp1-tmp0));
    
    warp_border_test();
    warp58x112x88_random_test(1);
    warp29x224x176_random_test(2);

    return 0;
}