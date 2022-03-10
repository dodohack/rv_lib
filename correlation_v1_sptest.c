/*
 * @Author: yuanhang.zhang 
 * @Date: 2021-09-22 10:01:31 
 * @Last Modified by: yuanhang
 * @Last Modified time: 2021-09-22 19:55:42
 */

#include <riscv_vector.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define BOOL int
BOOL DEBUG = 1;

struct correlation_param{
    size_t in_channel;
    size_t height;
    size_t width;
    size_t out_channel;
    size_t out_shift;   // 3
    int8_t* src0_ptr;
    int8_t* src1_ptr;
    int8_t* out_ptr;
};

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
                for (size_t k = 0; k < in_channel; ++k)
                {
                    if (j >= d)
                    {
                        in_idx1 = k * width * height + i * width + j;
                        in_idx2 = k * width * height + i * width + j - d;
                        sum_data += src0_arr[in_idx1] * src1_arr[in_idx2];
                    }
                }
                out_arr[out_idx] = (int8_t)(sum_data >> out_shift);
                // if(DEBUG) printf("sum_data is %d.\n", out_arr[out_idx]);
            }
        }
    }
}

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
    size_t vl_cnt = 0;

    for (size_t w = width; (vl = vsetvl_e8m1(w)); w -= vl){
        for (size_t h = 0; h < height; h++){  
            for (size_t d = 0; d < out_channel; d++){
                src0_ptr = h * width + vl_cnt + d + src0_arr;  
                src1_ptr = h * width + vl_cnt + src1_arr;  
                out_ptr = h * width + vl_cnt + d * fm_size + out_arr;
                vsetvl_e8m1(w - d);
                vint16m2_t acc = vmv_v_x_i16m2(0); 
                vint8m1_t vx, vy;
                for (size_t c = 0; c < in_channel; c++){
                    vx = vle8_v_i8m1(src0_ptr);
                    vy = vle8_v_i8m1(src1_ptr);
                    acc = vwmacc_vv_i16m2(acc, vy, vx);
                    src0_ptr += fm_size;
                    src1_ptr += fm_size;
                } 
                vint8m1_t acc_sra = vnsra_wx_i8m1(acc, out_shift);
                vse8_v_i8m1(out_ptr + d, acc_sra);       
            }          
        }
        vl_cnt += vl;
    }
}

void correlation_simple_test(){
    size_t in_channel = 1;
    size_t height = 4;
    size_t width = 4;
    size_t out_channel = 2;
    size_t out_shift = 0;
    int8_t src0_arr[16] = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};
    int8_t src1_arr[16] = {1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2};  
    int8_t out_arr_golden[32]; 
    int8_t out_arr_vec[32]; 

    for (size_t idx =0; idx < 32; idx++){
        out_arr_golden[idx] = 0;
    }
    for (size_t idx =0; idx < 32; idx++){
        out_arr_vec[idx] = 0;
    }

    struct correlation_param golden_param = {in_channel, height, width, out_channel, out_shift, src0_arr, src1_arr, out_arr_golden};
    struct correlation_param rvv_param = {in_channel, height, width, out_channel, out_shift, src0_arr, src1_arr, out_arr_vec};
    correlation_golden(&golden_param);
    correlation_vec(&rvv_param);

    int pass = 1;
    for (int out_idx=0; out_idx < 32; out_idx++){
        // if(DEBUG) printf("golden_param.out_ptr is %d.\n", golden_param.out_ptr[out_idx]);
        // if(DEBUG) printf("rvv_param.out_ptr is %d.\n", rvv_param.out_ptr[out_idx]);
        if (!(golden_param.out_ptr[out_idx] == rvv_param.out_ptr[out_idx])){
            printf("failed, %d != %d\n", golden_param.out_ptr[out_idx], rvv_param.out_ptr[out_idx]);
            pass = 0;
        }
    }
    if (pass) printf("correlation simple test passed.\n");  
    else printf("correlation simple test failed.\n");  
}

void correlation58x112x88_random_test(int seed){
    srandom(seed);

    size_t in_channel = 58;
    size_t height = 112;
    size_t width = 88;
    size_t out_channel = 5;
    size_t out_shift = 3;

    int8_t src0_arr[571648];
    int8_t src1_arr[571648];
    for(size_t idx=0; idx<571648; idx++){
        src0_arr[idx] = (rand()%8);
    }
    for(size_t idx=0; idx<571648; idx++){
        src1_arr[idx] = (rand()%8);
    }

    int8_t out_arr_golden[49280]; 
    int8_t out_arr_vec[49280]; 
    for (size_t idx =0; idx < 49280; idx++){
        out_arr_golden[idx] = 0;
    }
    for (size_t idx =0; idx < 49280; idx++){
        out_arr_vec[idx] = 0;
    }

    struct correlation_param golden_param = {in_channel, height, width, out_channel, out_shift, src0_arr, src1_arr, out_arr_golden};
    struct correlation_param rvv_param = {in_channel, height, width, out_channel, out_shift, src0_arr, src1_arr, out_arr_vec};
    correlation_golden(&golden_param);
    correlation_vec(&rvv_param);

    int pass = 1;
    for (int out_idx=0; out_idx < 49280; out_idx++){
        // if(DEBUG) printf("golden_param.out_ptr is %d.\n", golden_param.out_ptr[out_idx]);
        if (!(golden_param.out_ptr[out_idx] == rvv_param.out_ptr[out_idx])){
            printf("failed, %d != %d\n", golden_param.out_ptr[out_idx], rvv_param.out_ptr[out_idx]);
            pass = 0;
        }
    }
    if (pass) printf("correlation58x112x88 random test passed.\n");  
    else printf("correlation58x112x88 random test failed.\n");  
}

void correlation29x224x176_random_test(int seed){
    srandom(seed);

    size_t in_channel = 29;
    size_t height = 224;
    size_t width = 176;
    size_t out_channel = 5;
    size_t out_shift = 3;

    int8_t src0_arr[1143296];
    int8_t src1_arr[1143296];
    for(size_t idx=0; idx<1143296; idx++){
        src0_arr[idx] = (rand()%8);
    }
    for(size_t idx=0; idx<1143296; idx++){
        src1_arr[idx] = (rand()%8);
    }

    int8_t out_arr_golden[197120]; 
    int8_t out_arr_vec[197120]; 
    for (size_t idx =0; idx < 197120; idx++){
        out_arr_golden[idx] = 0;
    }
    for (size_t idx =0; idx < 197120; idx++){
        out_arr_vec[idx] = 0;
    }

    struct correlation_param golden_param = {in_channel, height, width, out_channel, out_shift, src0_arr, src1_arr, out_arr_golden};
    struct correlation_param rvv_param = {in_channel, height, width, out_channel, out_shift, src0_arr, src1_arr, out_arr_vec};
    correlation_golden(&golden_param);
    correlation_vec(&rvv_param);

    int pass = 1;
    for (int out_idx=0; out_idx < 197120; out_idx++){
        // if(DEBUG) printf("golden_param.out_ptr is %d.\n", golden_param.out_ptr[out_idx]);
        if (!(golden_param.out_ptr[out_idx] == rvv_param.out_ptr[out_idx])){
            printf("failed, %d != %d\n", golden_param.out_ptr[out_idx], rvv_param.out_ptr[out_idx]);
            pass = 0;
        }
    }
    if (pass) printf("correlation29x224x176 random test passed.\n");  
    else printf("correlation29x224x176 random test failed.\n");  
}


int main(){

    correlation_simple_test();
    correlation58x112x88_random_test(2);
    correlation29x224x176_random_test(1);

    return 0;
}