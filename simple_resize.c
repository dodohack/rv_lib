/*
 * @Author: yuanhang.zhang 
 * @Date: 2021-09-17 17:12:38 
 * @Last Modified by: yuanhang
 * @Last Modified time: 2021-09-28 15:10:50
 */

//#include <riscv_vector.h>
#include <stdio.h>
#include <stdlib.h>

#define BOOL int
BOOL DEBUG = 0;

#define MIN(a, b) ((a) < (b) ? (a) : (b))

struct resize_param{
    uint16_t channel;
    uint16_t height;
    uint16_t width;
    int8_t* src_ptr;
    int8_t* out_ptr;
};

// x2_resize
void resize_golden(struct resize_param *param){

    uint16_t channel = param->channel;
    uint16_t height = param->height;
    uint16_t width = param->width;
    int8_t* src_arr = param->src_ptr;
    int8_t* out_arr = param->out_ptr;

    uint16_t dst_height = height * 2;
    uint16_t dst_width = width * 2;

    size_t hw_fl = 7;   // fraction of factor is 7;
    for (uint16_t h = 0; h < dst_height; h++){
        uint16_t input_y = h << (hw_fl-1);
        uint16_t y0 = input_y >> hw_fl;
        uint16_t y1 = MIN(y0+1, height-1);  

        for (uint16_t w = 0; w < dst_width; w++){
            uint16_t input_x = w << (hw_fl-1);
            uint16_t x0 = (input_x >> hw_fl);
            uint16_t x1 = MIN(x0+1, width-1);  

            for (uint16_t c = 0; c < channel; c++){
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

// x2_resize
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


// void resize_vec(struct resize_param *param){
//     uint16_t channel = param->channel;
//     uint16_t height = param->height;
//     uint16_t width = param->width;
//     int8_t* src_arr = param->src_ptr;
//     int8_t* out_arr = param->out_ptr;

//     int8_t *src_ptr = src_arr;
//     int8_t *out_ptr = out_arr;

//     uint16_t dst_height = height * 2;
//     uint16_t dst_width = width * 2;
//     uint32_t dst_hw = dst_height * dst_width;
//     uint32_t src_hw = height * width;

//     uint16_t src_h_border = (uint16_t)(height - 1);
//     uint16_t src_w_border = (uint16_t)(width - 1);    

//     uint16_t dst_idx_arr[256];  // size of h & w is no more than 128
//     for (size_t idx = 0; idx < 256; idx++){
//         dst_idx_arr[idx] = (uint16_t)idx;
//     }
//     uint16_t* dst_idx_ptr = dst_idx_arr;

//     // xy_idx
//     uint16_t y0_arr[256];
//     uint16_t y1_arr[256];
//     uint16_t *y0_ptr = y0_arr;
//     uint16_t *y1_ptr = y1_arr;

//     uint16_t x0y0_arr[65536];
//     uint16_t x0y1_arr[65536];
//     uint16_t x1y0_arr[65536];
//     uint16_t x1y1_arr[65536];
//     uint16_t *x0y0_ptr = x0y0_arr;
//     uint16_t *x0y1_ptr = x0y1_arr;
//     uint16_t *x1y0_ptr = x1y0_arr;
//     uint16_t *x1y1_ptr = x1y1_arr;

//     // lambda 
//     uint16_t h0_lambda_arr[65536];
//     uint16_t h1_lambda_arr[65536];
//     uint16_t w0_lambda_arr[65536];
//     uint16_t w1_lambda_arr[65536];
//     uint16_t *h0_lambda_ptr = h0_lambda_arr;
//     uint16_t *h1_lambda_ptr = h1_lambda_arr;
//     uint16_t *w0_lambda_ptr = w0_lambda_arr;
//     uint16_t *w1_lambda_ptr = w1_lambda_arr;

//     size_t hw_vl, h_vl, w_vl;
//     size_t vl_cnt = 0;
//     ptrdiff_t y_stride = dst_width * 2;

//     for (uint16_t h = dst_height; (h_vl = vsetvl_e16m2(h)); h-= h_vl){
//         vuint16m2_t dst_h_idx = vle16_v_u16m2(dst_idx_ptr);
//         vuint16m2_t input_y = vsll_vx_u16m2(dst_h_idx, 6);   // 6 = 7 - 1 = hw_fl - log2(2)
//         vuint16m2_t y0 = vsrl_vx_u16m2(input_y, 7);
//         vuint16m2_t y1_tmp = vadd_vx_u16m2(y0, 1);
//         vuint16m2_t y1 = vminu_vx_u16m2(y1_tmp, src_h_border);
//         vuint16m2_t y0_shifted = vsll_vx_u16m2(y0, 7);
//         vuint16m2_t h1_lambda = vsub_vv_u16m2(input_y, y0_shifted);
//         vuint16m2_t h0_lambda = vrsub_vx_u16m2(h1_lambda, 128);   // 1 << 7

//         vse16_v_u16m2(y0_ptr, y0);
//         vse16_v_u16m2(y1_ptr, y1);
        
//         for (uint16_t h_idx = 0; h_idx < h_vl; h_idx++){
//             h0_lambda_ptr = vl_cnt * dst_width + h_idx * dst_width + h0_lambda_arr;
//             h1_lambda_ptr = vl_cnt * dst_width + h_idx * dst_width + h1_lambda_arr;
//             for (uint16_t w = dst_width; (w_vl = vsetvl_e16m2(w)); w-= w_vl){            
//                 uint16_t h0_val = h0_lambda[h_idx];
//                 uint16_t h1_val = h1_lambda[h_idx];
//                 vuint16m2_t h0_lambda_tmp = vmv_v_x_u16m2(h0_val);
//                 vuint16m2_t h1_lambda_tmp = vmv_v_x_u16m2(h1_val);
//                 vse16_v_u16m2(h0_lambda_ptr, h0_lambda_tmp);
//                 vse16_v_u16m2(h1_lambda_ptr, h1_lambda_tmp);
 
//                 h0_lambda_ptr += w_vl;
//                 h1_lambda_ptr += w_vl;
//             }
//         }

//         y0_ptr += h_vl;
//         y1_ptr += h_vl;
//         dst_idx_ptr += h_vl;
//         vl_cnt += h_vl;
//     }

//     for (uint16_t h = 0; h < dst_height; h++){
//         size_t idx_ptr_shift = h * dst_width;
//         x0y0_ptr = x0y0_arr + idx_ptr_shift;
//         x1y0_ptr = x1y0_arr + idx_ptr_shift;
//         x0y1_ptr = x0y1_arr + idx_ptr_shift;
//         x1y1_ptr = x1y1_arr + idx_ptr_shift;

//         w0_lambda_ptr = w0_lambda_arr + idx_ptr_shift;
//         w1_lambda_ptr = w1_lambda_arr + idx_ptr_shift;

//         dst_idx_ptr = dst_idx_arr;

//         uint16_t y0 = y0_arr[h];
//         uint16_t y1 = y1_arr[h];
//         uint16_t y0w = y0 * width;
//         uint16_t y1w = y1 * width;

//         for (uint16_t w = dst_width; (w_vl = vsetvl_e16m2(w)); w-= w_vl){
//             vuint16m2_t dst_w_idx = vle16_v_u16m2(dst_idx_ptr);
//             vuint16m2_t input_x = vsll_vx_u16m2(dst_w_idx, 6);   // 6 = 7 - 1 = hw_fl - log2(2)
//             vuint16m2_t x0 = vsrl_vx_u16m2(input_x, 7);
//             vuint16m2_t x1_tmp = vadd_vx_u16m2(x0, 1);
//             vuint16m2_t x1 = vminu_vx_u16m2(x1_tmp, src_w_border);
//             vuint16m2_t x0_shifted = vsll_vx_u16m2(x0, 7);
//             vuint16m2_t w1_lambda = vsub_vv_u16m2(input_x, x0_shifted);
//             vuint16m2_t w0_lambda = vrsub_vx_u16m2(w1_lambda, 128);   // 1 << 7

//             vuint16m2_t dst_hw_x0y0 = vadd_vx_u16m2(x0, y0w);
//             vuint16m2_t dst_hw_x1y0 = vadd_vx_u16m2(x1, y0w);
//             vuint16m2_t dst_hw_x0y1 = vadd_vx_u16m2(x0, y1w);
//             vuint16m2_t dst_hw_x1y1 = vadd_vx_u16m2(x1, y1w);

//             vse16_v_u16m2(x0y0_ptr, dst_hw_x0y0);
//             vse16_v_u16m2(x1y0_ptr, dst_hw_x1y0);
//             vse16_v_u16m2(x0y1_ptr, dst_hw_x0y1);
//             vse16_v_u16m2(x1y1_ptr, dst_hw_x1y1);

//             vse16_v_u16m2(w0_lambda_ptr, w0_lambda);
//             vse16_v_u16m2(w1_lambda_ptr, w1_lambda);

//             w0_lambda_ptr += w_vl;
//             w1_lambda_ptr += w_vl;

//             x0y0_ptr += w_vl;
//             x1y0_ptr += w_vl;
//             x0y1_ptr += w_vl;
//             x1y1_ptr += w_vl;

//             dst_idx_ptr += w_vl;
//         }
//     } 

//     for (uint16_t c = 0; c < channel; c++){

//         x0y0_ptr = x0y0_arr;
//         x1y0_ptr = x1y0_arr;
//         x0y1_ptr = x0y1_arr;
//         x1y1_ptr = x1y1_arr;

//         src_ptr = src_arr + c * src_hw;
//         out_ptr = out_arr + c * dst_hw;

//         w0_lambda_ptr = w0_lambda_arr;
//         w1_lambda_ptr = w1_lambda_arr;
//         h0_lambda_ptr = h0_lambda_arr;
//         h1_lambda_ptr = h1_lambda_arr;

//         for (uint32_t hw = dst_hw; (hw_vl = vsetvl_e16m2(hw)); hw-= hw_vl){
//             vuint16m2_t y0x0_index = vle16_v_u16m2(x0y0_ptr);
//             vuint16m2_t y0x1_index = vle16_v_u16m2(x1y0_ptr);
//             vuint16m2_t y1x0_index = vle16_v_u16m2(x0y1_ptr);
//             vuint16m2_t y1x1_index = vle16_v_u16m2(x1y1_ptr);     

//             vint8m1_t y0x0_val = vlxei16_v_i8m1(src_ptr, y0x0_index);
//             vint8m1_t y0x1_val = vlxei16_v_i8m1(src_ptr, y0x1_index);
//             vint8m1_t y1x0_val = vlxei16_v_i8m1(src_ptr, y1x0_index);
//             vint8m1_t y1x1_val = vlxei16_v_i8m1(src_ptr, y1x1_index);

//             vint16m2_t y0x0_val_int16 = vwadd_vx_i16m2(y0x0_val, 0);
//             vint16m2_t y0x1_val_int16 = vwadd_vx_i16m2(y0x1_val, 0);
//             vint16m2_t y1x0_val_int16 = vwadd_vx_i16m2(y1x0_val, 0);
//             vint16m2_t y1x1_val_int16 = vwadd_vx_i16m2(y1x1_val, 0);

//             vuint16m2_t w0_lambda = vle16_v_u16m2(w0_lambda_ptr);
//             vuint16m2_t w1_lambda = vle16_v_u16m2(w1_lambda_ptr);
//             vint16m2_t w0_lambda_int16 = vreinterpret_v_u16m2_i16m2(w0_lambda);
//             vint16m2_t w1_lambda_int16 = vreinterpret_v_u16m2_i16m2(w1_lambda);

//             vint16m2_t sum1_y0x0 = vmul_vv_i16m2(y0x0_val_int16, w0_lambda_int16);
//             vint16m2_t sum1_y0x1 = vmul_vv_i16m2(y0x1_val_int16, w1_lambda_int16);
//             vint16m2_t sum2_y1x0 = vmul_vv_i16m2(y1x0_val_int16, w0_lambda_int16);
//             vint16m2_t sum2_y1x1 = vmul_vv_i16m2(y1x1_val_int16, w1_lambda_int16);
//             vint16m2_t sum1 = vadd_vv_i16m2(sum1_y0x0, sum1_y0x1);
//             vint16m2_t sum1_shifted = vsra_vx_i16m2(sum1, 7);   
//             vint16m2_t sum2 = vadd_vv_i16m2(sum2_y1x0, sum2_y1x1);
//             vint16m2_t sum2_shifted = vsra_vx_i16m2(sum2, 7);

//             vuint16m2_t h0_lambda = vle16_v_u16m2(h0_lambda_ptr);
//             vuint16m2_t h1_lambda = vle16_v_u16m2(h1_lambda_ptr);
//             vint16m2_t h0_lambda_int16 = vreinterpret_v_u16m2_i16m2(h0_lambda);
//             vint16m2_t h1_lambda_int16 = vreinterpret_v_u16m2_i16m2(h1_lambda);

//             vint16m2_t dst_h0 = vmul_vv_i16m2(sum1_shifted, h0_lambda_int16);
//             vint16m2_t dst_h1 = vmul_vv_i16m2(sum2_shifted, h1_lambda_int16);
//             vint16m2_t dst_tmp = vadd_vv_i16m2(dst_h0, dst_h1);
//             vint8m1_t dst_val = vnsra_wx_i8m1(dst_tmp, 7);
//             vse8_v_i8m1(out_ptr, dst_val);

//             out_ptr += hw_vl;           
//             x0y0_ptr += hw_vl;            
//             x1y0_ptr += hw_vl;
//             x0y1_ptr += hw_vl;
//             x1y1_ptr += hw_vl;
//             h0_lambda_ptr += hw_vl;
//             h1_lambda_ptr += hw_vl;
//             w0_lambda_ptr += hw_vl;
//             w1_lambda_ptr += hw_vl; 
//         }
//     }
// }

void resize_simpile_test(){
    size_t channel = 1;
    size_t height = 2;
    size_t width = 2;
    int8_t src_arr[4] = {0,1,2,3};
    int8_t out_arr_golden[16];
    int8_t out_arr_vec[16];
    struct resize_param golden_param = {channel, height, width, src_arr, out_arr_golden};
    struct resize_param rvv_param = {channel, height, width, src_arr, out_arr_vec};
    resize_golden_v2(&golden_param);
    // resize_vec(&rvv_param);
    
    // int pass = 1;
    // for (int out_idx=0; out_idx < 16; out_idx++){
    //     if (!(golden_param.out_ptr[out_idx] == rvv_param.out_ptr[out_idx])){
    //         printf("failed, %d != %d\n", golden_param.out_ptr[out_idx], rvv_param.out_ptr[out_idx]);
    //         pass = 0;
    //     }
    // }
    // if (pass) printf("resize test passed.\n");  
    // else printf("resize simple test failed.\n");      
}

void resize58x112x88_random_test(int seed){
    srandom(seed);

    size_t channel = 58;
    size_t height = 112;
    size_t width = 88;
    int8_t src_arr[571648];
    int8_t out_arr_golden[2286592];
    int8_t out_arr_vec[2286592];

    size_t hw = height * width;
    size_t dst_hw = hw * 4;
    for(size_t idx=0; idx<hw; idx++){
        src_arr[idx] = (rand()%64);
    }

    struct resize_param golden_param = {channel, height, width, src_arr, out_arr_golden};
    struct resize_param rvv_param = {channel, height, width, src_arr, out_arr_vec};
    // resize_golden(&golden_param);
    resize_golden_v2(&golden_param);
    // resize_vec(&rvv_param);

    // int pass = 1;
    // for (uint32_t out_idx=0; out_idx < dst_hw; out_idx++){
    //     if (!(golden_param.out_ptr[out_idx] == rvv_param.out_ptr[out_idx])){
    //         printf("failed, %d != %d\n", golden_param.out_ptr[out_idx], rvv_param.out_ptr[out_idx]);
    //         pass = 0;
    //     }
    // }
    // if (pass) printf("resize58x112x88_random_test passed.\n");  
    // else printf("resize58x112x88_random_test failed.\n");      
}

int main(){
    
    resize_simpile_test();
    resize58x112x88_random_test(1);

    return 0;
}