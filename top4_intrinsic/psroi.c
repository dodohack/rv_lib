#include <riscv_vector.h>
#include <stdio.h>
#include <stdlib.h>
#include "../env/platform.h"
#include "../stubs/printf.h"

#define inner_shift 8
#define MAX(a, b) ((a) > (b) ? (a) : (b))

struct psroi_param{
    uint8_t* src_arr;
    uint16_t* rois_arr;
    uint16_t* out_arr;
    uint32_t rois_num;
    uint32_t pooled_h;
    uint32_t pooled_w;
    uint32_t pooled_c; 
    uint32_t src_height;
    uint32_t src_width;
    uint8_t sampling_ratio;  
    uint8_t roi_shift;
};

uint8_t src_arr_global[360640] = {8};
uint16_t rois_arr_global[1200] = {0};
uint16_t out_arr_global[117600] = {0};

void global_arr_init(){
    for(uint32_t j=0; j < 360640; j++){
        src_arr_global[j] = j % 64;
    }
    for(uint32_t i=0; i < 600; i++){
        rois_arr_global[i*8]   = (uint16_t)(1);
        rois_arr_global[i*8+1] = (uint16_t)(1);
        rois_arr_global[i*8+2] = (uint16_t)(11);
        rois_arr_global[i*8+3] = (uint16_t)(11);

        rois_arr_global[i*8+4] = (uint16_t)(2);
        rois_arr_global[i*8+5] = (uint16_t)(2);
        rois_arr_global[i*8+6] = (uint16_t)(16);
        rois_arr_global[i*8+7] = (uint16_t)(16);
    }
}

// psroi instruction parse
void psroi_param_read(struct psroi_param *param, int32_t* rvv_instr_reg) {
    // @TODO implement the real function
    param->rois_num = (uint32_t)(*(rvv_instr_reg+2));
    param->pooled_h = (uint32_t)(*(rvv_instr_reg+3));
    param->pooled_w = (uint32_t)(*(rvv_instr_reg+4));
    param->pooled_c = (uint32_t)(*(rvv_instr_reg+5));
    param->src_height = (uint32_t)(*(rvv_instr_reg+6));
    param->src_width = (uint32_t)(*(rvv_instr_reg+7));
    param->sampling_ratio = (uint8_t)((*(rvv_instr_reg+8) & (int32_t)(0x00ff0000)) >> 16);
    param->roi_shift = (uint8_t)((*(rvv_instr_reg+8) & (int32_t)(0x000000ff)));
    param->src_arr = src_arr_global;
    param->rois_arr = rois_arr_global;
    param->out_arr = out_arr_global;
}

void psroi_pooling_align_vec(struct psroi_param *param){
    uint8_t *data_ptr = param->src_arr;
    uint16_t *rois_arr = param->rois_arr;
    uint16_t *out_ptr = param->out_arr;
    uint32_t rois_num = param->rois_num;
    uint32_t pooled_h = param->pooled_h;
    uint32_t pooled_w = param->pooled_w;
    uint32_t pooled_c = param->pooled_c;
    uint32_t src_k2 = pooled_h * pooled_w;
    uint32_t src_height = param->src_height;
    uint32_t src_width = param->src_width;
    uint8_t sampling_ratio = param->sampling_ratio;
    uint8_t roi_shift = param->roi_shift;

    uint16_t *rois_ptr0= rois_arr;
    uint16_t *rois_ptr1 = rois_arr+1;
    uint16_t *rois_ptr2 = rois_arr+2;
    uint16_t *rois_ptr3 = rois_arr+3;
    uint16_t roi_shifted = (uint16_t)(1 << roi_shift);
    uint16_t inner_shifted = (uint16_t)(1 << inner_shift);    
    uint32_t src_hw = src_height * src_width;
    uint16_t src_hwc = src_height * src_width * pooled_c;
    uint16_t height_border = src_height -1;
    uint16_t width_border = src_width -1;
    uint32_t out_hwc_stride = pooled_h * pooled_w * pooled_c;
    uint32_t out_hw_stride = pooled_h * pooled_w;

    uint16_t maskedoff_height_arr[300];
    uint16_t maskedoff_width_arr[300];
    for (uint32_t i = 0; i < 300; i++){
        maskedoff_height_arr[i] = height_border;
        maskedoff_width_arr[i] = width_border;
    }
    uint16_t *maskedoff_height_ptr = maskedoff_height_arr;
    uint16_t *maskedoff_width_ptr = maskedoff_width_arr;

    uint8_t sampling_ratio_double = sampling_ratio * 2;
    uint16_t bin_size_ratio_w = (uint16_t)(inner_shifted / pooled_w);
    uint16_t bin_size_ratio_h = (uint16_t)(inner_shifted / pooled_h);

    size_t roi_vl = 0;
    
    for (uint16_t k2_index = 0; k2_index < src_k2; k2_index++){
      
        uint16_t ph = k2_index / pooled_w;
        uint16_t pw = k2_index % pooled_w;
        maskedoff_height_ptr = maskedoff_height_arr;
        maskedoff_width_ptr = maskedoff_width_arr;
        size_t vl_cnt = 0;

        for (size_t roi_n = rois_num; (roi_vl = vsetvl_e16m2(roi_n)); roi_n-= roi_vl){
            data_ptr = param->src_arr + (k2_index) * src_hwc;
            out_ptr = param->out_arr + k2_index + vl_cnt * out_hwc_stride;

            vuint16m2_t roi_start_w = vlse16_v_u16m2(rois_ptr0, 8);
            vuint16m2_t roi_start_h = vlse16_v_u16m2(rois_ptr1, 8);
            vuint16m2_t roi_end_w = vlse16_v_u16m2(rois_ptr2, 8);
            vuint16m2_t roi_end_h = vlse16_v_u16m2(rois_ptr3, 8);          

            vuint16m2_t roi_width_tmp = vsub_vv_u16m2(roi_end_w, roi_start_w);
            vuint16m2_t roi_width = vmaxu_vx_u16m2(roi_width_tmp, roi_shifted);
            vuint16m2_t roi_height_tmp = vsub_vv_u16m2(roi_end_h, roi_start_h);
            vuint16m2_t roi_height = vmaxu_vx_u16m2(roi_height_tmp, roi_shifted);

            vuint16m2_t bin_size_w_tmp = vmul_vx_u16m2(roi_width, bin_size_ratio_w);
            vuint16m2_t bin_size_w = vsrl_vx_u16m2(bin_size_w_tmp, (uint16_t)inner_shift);
            vuint16m2_t bin_size_h_tmp = vmul_vx_u16m2(roi_height, bin_size_ratio_h);
            vuint16m2_t bin_size_h = vsrl_vx_u16m2(bin_size_h_tmp, (uint16_t)inner_shift);

            vuint16m2_t grid_w = vdivu_vx_u16m2(bin_size_w, sampling_ratio_double);
            vuint16m2_t grid_h = vdivu_vx_u16m2(bin_size_h, sampling_ratio_double);

            vuint16m2_t y_tmp = vmacc_vx_u16m2(roi_start_h, ph, bin_size_h);
            vuint16m2_t x_tmp = vmacc_vx_u16m2(roi_start_w, pw, bin_size_w);
            vuint16m2_t grid_h3 = vmul_vx_u16m2(grid_h, 3);
            vuint16m2_t grid_w3 = vmul_vx_u16m2(grid_w, 3);
            vuint16m2_t y_tmp_grid_h = vadd_vv_u16m2(y_tmp, grid_h);
            vuint16m2_t y_tmp_grid_h3 = vadd_vv_u16m2(y_tmp, grid_h3);
            vuint16m2_t x_tmp_grid_w = vadd_vv_u16m2(x_tmp, grid_w);
            vuint16m2_t x_tmp_grid_w3 = vadd_vv_u16m2(x_tmp, grid_w3);

            vuint16m2_t maskedoff_height = vle16_v_u16m2(maskedoff_height_ptr);
            vuint16m2_t maskedoff_width = vle16_v_u16m2(maskedoff_width_ptr);

            for (uint32_t c = 0; c < pooled_c; c++){

                // pooled0 iy=0,ix=0,
                // y=roi_start_h+ph*bin_size_h+grid_h,  x=roi_start_w+pw*bin_size_w+grid_w
                vuint16m2_t y_low = vsrl_vx_u16m2(y_tmp_grid_h, (uint16_t)roi_shift);      
                vuint16m2_t x_low = vsrl_vx_u16m2(x_tmp_grid_w, (uint16_t)roi_shift);
                vbool8_t y_low_mask = vmsltu_vx_u16m2_b8(y_low, height_border);
                vbool8_t x_low_mask = vmsltu_vx_u16m2_b8(x_low, width_border);
                vbool8_t y_low_mask_n = vmnot_m_b8(y_low_mask);
                vbool8_t x_low_mask_n = vmnot_m_b8(x_low_mask);
                vuint16m2_t y_high = vadd_vx_u16m2_m(y_low_mask, maskedoff_height, y_low, 1);
                vuint16m2_t x_high = vadd_vx_u16m2_m(x_low_mask, maskedoff_width, x_low, 1);
                vuint16m2_t y = vsll_vx_u16m2_m(y_low_mask_n, y_tmp_grid_h, y_low, (uint16_t)roi_shift);
                vuint16m2_t x = vsll_vx_u16m2_m(x_low_mask_n, x_tmp_grid_w, x_low, (uint16_t)roi_shift);

                vuint16m2_t ly_tmp = vsll_vx_u16m2(y_low, (uint16_t)roi_shift);
                vuint16m2_t lx_tmp = vsll_vx_u16m2(x_low, (uint16_t)roi_shift);
                vuint16m2_t ly = vsub_vv_u16m2(y, ly_tmp);
                vuint16m2_t lx = vsub_vv_u16m2(x, lx_tmp);
                vuint16m2_t hy = vrsub_vx_u16m2(ly, roi_shifted);
                vuint16m2_t hx = vrsub_vx_u16m2(lx, roi_shifted);

                vuint16m2_t v1_index = vmacc_vx_u16m2(x_low, (uint16_t)src_width, y_low);
                vuint16m2_t v2_index = vmacc_vx_u16m2(x_high, (uint16_t)src_width, y_low);
                vuint16m2_t v3_index = vmacc_vx_u16m2(x_low, (uint16_t)src_width, y_high);
                vuint16m2_t v4_index = vmacc_vx_u16m2(x_high, (uint16_t)src_width, y_high);
     
                vuint8m1_t v1_tmp = vlxei16_v_u8m1(data_ptr, v1_index);
                vuint8m1_t v2_tmp = vlxei16_v_u8m1(data_ptr, v2_index);
                vuint8m1_t v3_tmp = vlxei16_v_u8m1(data_ptr, v3_index);
                vuint8m1_t v4_tmp = vlxei16_v_u8m1(data_ptr, v4_index);
                vuint16m2_t v1 = vwaddu_vx_u16m2(v1_tmp, 0);
                vuint16m2_t v2 = vwaddu_vx_u16m2(v2_tmp, 0);
                vuint16m2_t v3 = vwaddu_vx_u16m2(v3_tmp, 0);
                vuint16m2_t v4 = vwaddu_vx_u16m2(v4_tmp, 0);

                vuint16m2_t w1_tmp = vmul_vv_u16m2(hy, hx);            
                vuint16m2_t w2_tmp = vmul_vv_u16m2(hy, lx);
                vuint16m2_t w3_tmp = vmul_vv_u16m2(ly, hx);
                vuint16m2_t w4_tmp = vmul_vv_u16m2(ly, lx);
                vuint16m2_t w1 = vsrl_vx_u16m2(w1_tmp, (uint16_t)roi_shift);
                vuint16m2_t w2 = vsrl_vx_u16m2(w2_tmp, (uint16_t)roi_shift);
                vuint16m2_t w3 = vsrl_vx_u16m2(w3_tmp, (uint16_t)roi_shift);
                vuint16m2_t w4 = vsrl_vx_u16m2(w4_tmp, (uint16_t)roi_shift);

                vuint32m4_t val_pooled0_tmp = vwmulu_vv_u32m4(w1, v1);
                val_pooled0_tmp = vwmaccu_vv_u32m4(val_pooled0_tmp, w2, v2);
                val_pooled0_tmp = vwmaccu_vv_u32m4(val_pooled0_tmp, w3, v3);
                val_pooled0_tmp = vwmaccu_vv_u32m4(val_pooled0_tmp, w4, v4);
                vuint16m2_t val_pooled0 = vnsrl_wx_u16m2(val_pooled0_tmp, (uint16_t)roi_shift); 

                // // pooled1 iy=0,ix=1,
                // y=roi_start_h+ph*bin_size_h+3*grid_h,  x=roi_start_w+pw*bin_size_w+grid_w
                y_low = vsrl_vx_u16m2(y_tmp_grid_h3, (uint16_t)roi_shift);      
                x_low = vsrl_vx_u16m2(x_tmp_grid_w, (uint16_t)roi_shift);
                y_low_mask = vmsleu_vx_u16m2_b8(y_low, src_height);
                x_low_mask = vmsleu_vx_u16m2_b8(x_low, src_width);
                y_low_mask_n = vmnot_m_b8(y_low_mask);
                x_low_mask_n = vmnot_m_b8(x_low_mask);
                y_high = vadd_vx_u16m2_m(y_low_mask, maskedoff_height, y_low, 1);
                x_high = vadd_vx_u16m2_m(x_low_mask, maskedoff_width, x_low, 1);
                y = vsll_vx_u16m2_m(y_low_mask_n, y_tmp_grid_h3, y_low, (uint16_t)roi_shift);
                x = vsll_vx_u16m2_m(x_low_mask_n, x_tmp_grid_w, x_low, (uint16_t)roi_shift);

                ly_tmp = vsll_vx_u16m2(y_low, (uint16_t)roi_shift);
                lx_tmp = vsll_vx_u16m2(x_low, (uint16_t)roi_shift);
                ly = vsub_vv_u16m2(y, ly_tmp);
                lx = vsub_vv_u16m2(x, lx_tmp);
                hy = vrsub_vx_u16m2(ly, roi_shifted);
                hx = vrsub_vx_u16m2(lx, roi_shifted);

                v1_index = vmacc_vx_u16m2(x_low, (uint16_t)src_width, y_low);
                v2_index = vmacc_vx_u16m2(x_high, (uint16_t)src_width, y_low);
                v3_index = vmacc_vx_u16m2(x_low, (uint16_t)src_width, y_high);
                v4_index = vmacc_vx_u16m2(x_high, (uint16_t)src_width, y_high);
                v1_tmp = vlxei16_v_u8m1(data_ptr, v1_index);
                v2_tmp = vlxei16_v_u8m1(data_ptr, v2_index);
                v3_tmp = vlxei16_v_u8m1(data_ptr, v3_index);
                v4_tmp = vlxei16_v_u8m1(data_ptr, v4_index);
                v1 = vwaddu_vx_u16m2(v1_tmp, 0);
                v2 = vwaddu_vx_u16m2(v2_tmp, 0);
                v3 = vwaddu_vx_u16m2(v3_tmp, 0);
                v4 = vwaddu_vx_u16m2(v4_tmp, 0);

                w1_tmp = vmul_vv_u16m2(hy, hx);            
                w2_tmp = vmul_vv_u16m2(hy, lx);
                w3_tmp = vmul_vv_u16m2(ly, hx);
                w4_tmp = vmul_vv_u16m2(ly, lx);
                w1 = vsrl_vx_u16m2(w1_tmp, (uint16_t)roi_shift);
                w2 = vsrl_vx_u16m2(w2_tmp, (uint16_t)roi_shift);
                w3 = vsrl_vx_u16m2(w3_tmp, (uint16_t)roi_shift);
                w4 = vsrl_vx_u16m2(w4_tmp, (uint16_t)roi_shift);

                vuint32m4_t val_pooled1_tmp = vwmulu_vv_u32m4(w1, v1);
                val_pooled1_tmp = vwmaccu_vv_u32m4(val_pooled1_tmp, w2, v2);
                val_pooled1_tmp = vwmaccu_vv_u32m4(val_pooled1_tmp, w3, v3);
                val_pooled1_tmp = vwmaccu_vv_u32m4(val_pooled1_tmp, w4, v4);
                vuint16m2_t val_pooled1 = vnsrl_wx_u16m2(val_pooled1_tmp, (uint16_t)roi_shift);

                // // pooled2 iy=1,ix=0,
                // y=roi_start_h+ph*bin_size_h+grid_h,  x=roi_start_w+pw*bin_size_w+3*grid_w
                y_low = vsrl_vx_u16m2(y_tmp_grid_h, (uint16_t)roi_shift);      
                x_low = vsrl_vx_u16m2(x_tmp_grid_w3, (uint16_t)roi_shift);
                y_low_mask = vmsleu_vx_u16m2_b8(y_low, src_height);
                x_low_mask = vmsleu_vx_u16m2_b8(x_low, src_width);
                y_low_mask_n = vmnot_m_b8(y_low_mask);
                x_low_mask_n = vmnot_m_b8(x_low_mask);
                y_high = vadd_vx_u16m2_m(y_low_mask, maskedoff_height, y_low, 1);
                x_high = vadd_vx_u16m2_m(x_low_mask, maskedoff_width, x_low, 1);
                y = vsll_vx_u16m2_m(y_low_mask_n, y_tmp_grid_h, y_low, (uint16_t)roi_shift);
                x = vsll_vx_u16m2_m(x_low_mask_n, x_tmp_grid_w3, x_low, (uint16_t)roi_shift);

                ly_tmp = vsll_vx_u16m2(y_low, (uint16_t)roi_shift);
                lx_tmp = vsll_vx_u16m2(x_low, (uint16_t)roi_shift);
                ly = vsub_vv_u16m2(y, ly_tmp);
                lx = vsub_vv_u16m2(x, lx_tmp);
                hy = vrsub_vx_u16m2(ly, roi_shifted);
                hx = vrsub_vx_u16m2(lx, roi_shifted);

                v1_index = vmacc_vx_u16m2(x_low, (uint16_t)src_width, y_low);
                v2_index = vmacc_vx_u16m2(x_high, (uint16_t)src_width, y_low);
                v3_index = vmacc_vx_u16m2(x_low, (uint16_t)src_width, y_high);
                v4_index = vmacc_vx_u16m2(x_high, (uint16_t)src_width, y_high);

                v1_tmp = vlxei16_v_u8m1(data_ptr, v1_index);
                v2_tmp = vlxei16_v_u8m1(data_ptr, v2_index);
                v3_tmp = vlxei16_v_u8m1(data_ptr, v3_index);
                v4_tmp = vlxei16_v_u8m1(data_ptr, v4_index);
                v1 = vwaddu_vx_u16m2(v1_tmp, 0);
                v2 = vwaddu_vx_u16m2(v2_tmp, 0);
                v3 = vwaddu_vx_u16m2(v3_tmp, 0);
                v4 = vwaddu_vx_u16m2(v4_tmp, 0);

                w1_tmp = vmul_vv_u16m2(hy, hx);            
                w2_tmp = vmul_vv_u16m2(hy, lx);
                w3_tmp = vmul_vv_u16m2(ly, hx);
                w4_tmp = vmul_vv_u16m2(ly, lx);
                w1 = vsrl_vx_u16m2(w1_tmp, (uint16_t)roi_shift);
                w2 = vsrl_vx_u16m2(w2_tmp, (uint16_t)roi_shift);
                w3 = vsrl_vx_u16m2(w3_tmp, (uint16_t)roi_shift);
                w4 = vsrl_vx_u16m2(w4_tmp, (uint16_t)roi_shift);

                vuint32m4_t val_pooled2_tmp = vwmulu_vv_u32m4(w1, v1);
                val_pooled2_tmp = vwmaccu_vv_u32m4(val_pooled2_tmp, w2, v2);
                val_pooled2_tmp = vwmaccu_vv_u32m4(val_pooled2_tmp, w3, v3);
                val_pooled2_tmp = vwmaccu_vv_u32m4(val_pooled2_tmp, w4, v4);
                vuint16m2_t val_pooled2 = vnsrl_wx_u16m2(val_pooled2_tmp, (uint16_t)roi_shift);

                // // pooled3 iy=1,ix=1,
                // // y=roi_start_h+ph*bin_size_h+3*grid_h,  x=roi_start_w+pw*bin_size_w+3*grid_w
                y_low = vsrl_vx_u16m2(y_tmp_grid_h3, (uint16_t)roi_shift);      
                x_low = vsrl_vx_u16m2(x_tmp_grid_w3, (uint16_t)roi_shift);
                y_low_mask = vmsleu_vx_u16m2_b8(y_low, src_height);
                x_low_mask = vmsleu_vx_u16m2_b8(x_low, src_width);
                y_low_mask_n = vmnot_m_b8(y_low_mask);
                x_low_mask_n = vmnot_m_b8(x_low_mask);
                y_high = vadd_vx_u16m2_m(y_low_mask, maskedoff_height, y_low, 1);
                x_high = vadd_vx_u16m2_m(x_low_mask, maskedoff_width, x_low, 1);
                y = vsll_vx_u16m2_m(y_low_mask_n, y_tmp_grid_h3, y_low, (uint16_t)roi_shift);
                x = vsll_vx_u16m2_m(x_low_mask_n, x_tmp_grid_w3, x_low, (uint16_t)roi_shift);

                ly_tmp = vsll_vx_u16m2(y_low, (uint16_t)roi_shift);
                lx_tmp = vsll_vx_u16m2(x_low, (uint16_t)roi_shift);
                ly = vsub_vv_u16m2(y, ly_tmp);
                lx = vsub_vv_u16m2(x, lx_tmp);
                hy = vrsub_vx_u16m2(ly, roi_shifted);
                hx = vrsub_vx_u16m2(lx, roi_shifted);

                v1_index = vmacc_vx_u16m2(x_low, (uint16_t)src_width, y_low);
                v2_index = vmacc_vx_u16m2(x_high, (uint16_t)src_width, y_low);
                v3_index = vmacc_vx_u16m2(x_low, (uint16_t)src_width, y_high);
                v4_index = vmacc_vx_u16m2(x_high, (uint16_t)src_width, y_high);

                v1_tmp = vlxei16_v_u8m1(data_ptr, v1_index);
                v2_tmp = vlxei16_v_u8m1(data_ptr, v2_index);
                v3_tmp = vlxei16_v_u8m1(data_ptr, v3_index);
                v4_tmp = vlxei16_v_u8m1(data_ptr, v4_index);
                v1 = vwaddu_vx_u16m2(v1_tmp, 0);
                v2 = vwaddu_vx_u16m2(v2_tmp, 0);
                v3 = vwaddu_vx_u16m2(v3_tmp, 0);
                v4 = vwaddu_vx_u16m2(v4_tmp, 0);

                w1_tmp = vmul_vv_u16m2(hy, hx);            
                w2_tmp = vmul_vv_u16m2(hy, lx);
                w3_tmp = vmul_vv_u16m2(ly, hx);
                w4_tmp = vmul_vv_u16m2(ly, lx);
                w1 = vsrl_vx_u16m2(w1_tmp, (uint16_t)roi_shift);
                w2 = vsrl_vx_u16m2(w2_tmp, (uint16_t)roi_shift);
                w3 = vsrl_vx_u16m2(w3_tmp, (uint16_t)roi_shift);
                w4 = vsrl_vx_u16m2(w4_tmp, (uint16_t)roi_shift);

                vuint32m4_t val_pooled3_tmp = vwmulu_vv_u32m4(w1, v1);
                val_pooled3_tmp = vwmaccu_vv_u32m4(val_pooled3_tmp, w2, v2);
                val_pooled3_tmp = vwmaccu_vv_u32m4(val_pooled3_tmp, w3, v3);
                val_pooled3_tmp = vwmaccu_vv_u32m4(val_pooled3_tmp, w4, v4);
                vuint16m2_t val_pooled3 = vnsrl_wx_u16m2(val_pooled3_tmp, (uint16_t)roi_shift);

                vuint16m2_t val_pooled = vadd_vv_u16m2(val_pooled0, val_pooled1);
                val_pooled = vadd_vv_u16m2(val_pooled, val_pooled2);
                val_pooled = vadd_vv_u16m2(val_pooled, val_pooled3);
                val_pooled = vsrl_vx_u16m2(val_pooled, (uint16_t)(2));   

                ptrdiff_t roi_stride = out_hwc_stride * 2;
                vsse16_v_u16m2(out_ptr, roi_stride, val_pooled);

                out_ptr += out_hw_stride;
                data_ptr += src_hw;
            }       
            maskedoff_height_ptr += roi_vl;
            maskedoff_width_ptr += roi_vl;     
            vl_cnt += roi_vl;       
        }
    }
}

int main(){
    // rvv instruction from ACC's register 32bit*10
    // int32_t* rvv_instr_reg = (int32_t*) malloc(15*sizeof(int32_t));  
    int32_t rvv_instr_reg[15];
    rvv_instr_reg[0] = 0;   // @TODO assign the real instr head value
    rvv_instr_reg[1] = 0;   // @TODO assign the real instr head value
    rvv_instr_reg[2] = 300;   // rois_num = 2;
    rvv_instr_reg[3] = 7;   // pooled_h = 2;
    rvv_instr_reg[4] = 7;   // pooled_w = 2;
    rvv_instr_reg[5] = 8;   // pooled_c = 2;
    rvv_instr_reg[6] = 23;   // src_height = 4;
    rvv_instr_reg[7] = 40;   // src_width = 4;
    rvv_instr_reg[8] = 2 * 65536 + 0;   // sampling_ratio = 2; roi_shift = 0; 
    rvv_instr_reg[9] = 0;   // @TODO assign the real addr for src
    rvv_instr_reg[10] = 0;   // @TODO assign the real addr for rois
    rvv_instr_reg[11] = 0;   // @TODO assign the real addr for out

    global_arr_init();
    struct psroi_param param;
    psroi_param_read(&param, rvv_instr_reg);
    
    int tmp0 = read_rdcycle();
    psroi_pooling_align_vec(&param);
    int tmp1 = read_rdcycle();

    // for (int out_idx=0; out_idx < 117600; out_idx++){
    //     printf("output of rvv_param, index : %d, val : %d.\n", out_idx, param.out_arr[out_idx]);
    // }

    printf("psroi_23x40x392x300 running cycles : %d.\n", (tmp1-tmp0));

    return 0;
}
