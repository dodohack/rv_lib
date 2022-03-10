
#include <stdio.h>
#include <stdlib.h>

#define BOOL int
BOOL DEBUG = 0;

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

uint32_t bilinear_interpolate(uint8_t *data,
                            int16_t height,
                            int16_t width,
                            int16_t y,
                            int16_t x,
                            uint8_t roi_shift){
    uint32_t val = 0;
    if ((y >> roi_shift) >= height || (x >> roi_shift) >= width){
        return 0;
    }
    if (y <=0) y=0;
    if (x <=0) x=0;

    int y_low = (y >> roi_shift);
    int x_low = (x >> roi_shift);
    int y_high;
    int x_high;

    if (y_low >= height -1) {
        y_high = y_low = height -1;
        y = y_low << roi_shift;
    }else{
        y_high = y_low + 1;
    }

    if (x_low >= width -1) {
        x_high = x_low = width -1;
        x = x_low << roi_shift;
    }else{
        x_high = x_low + 1;
    }

    uint16_t ly = y - (y_low << roi_shift);
    uint16_t lx = x - (x_low << roi_shift);
    uint16_t hy = (1 << roi_shift) - ly;
    uint16_t hx = (1 << roi_shift) - lx;
    uint16_t v1 = data[y_low*width + x_low];
    uint16_t v2 = data[y_low*width + x_high];
    uint16_t v3 = data[y_high*width + x_low];
    uint16_t v4 = data[y_high*width + x_high];

    uint16_t w1 = (hy*hx) >> roi_shift;
    uint16_t w2 = (hy*lx) >> roi_shift; 
    uint16_t w3 = (ly*hx) >> roi_shift;
    uint16_t w4 = (ly*lx) >> roi_shift;

    // val = ((uint32_t)(w1*v1 + w2*v2 + w3*v3 + w4*v4)) >> (src_shift + roi_shift);
    val = ((uint32_t)(w1*v1 + w2*v2 + w3*v3 + w4*v4)) >> (roi_shift);

    return val;
}

void psroi_align_golden(uint8_t *data,
                        uint16_t *rois_arr,
                        uint16_t *out_data,
                        uint32_t rois_num,
                        uint32_t k2_index,
                        uint32_t pooled_h,
                        uint32_t pooled_w,
                        uint32_t pooled_c,
                        uint32_t src_height,
                        uint32_t src_width,
                        uint8_t sampling_ratio,
                        uint8_t roi_shift){

    uint8_t post_shift = 2;  // div 4;

    uint16_t output_val;
    uint8_t *data_ptr = data;

    uint16_t ph = k2_index / pooled_w;
    uint16_t pw = k2_index % pooled_w;

    uint32_t out_hwc_stride = pooled_h * pooled_w * pooled_c;
    uint32_t out_hw_stride = pooled_h * pooled_w;

    for (uint32_t i=0; i<rois_num; i++){
        data_ptr = data;
        uint16_t roi_start_w = rois_arr[4 * i];
        uint16_t roi_start_h = rois_arr[4 * i + 1];
        uint16_t roi_end_w = rois_arr[4 * i + 2];
        uint16_t roi_end_h = rois_arr[4 * i + 3];       

        uint16_t roi_width = MAX((roi_end_w - roi_start_w), (1 << roi_shift));
        uint16_t roi_height = MAX((roi_end_h - roi_start_h), (1 << roi_shift));

        uint16_t bin_size_ratio_w = (uint16_t)((1.0 / pooled_w) * (1 << inner_shift));
        uint16_t bin_size_ratio_h = (uint16_t)((1.0 / pooled_h) * (1 << inner_shift));
        uint16_t bin_size_w = (roi_width * bin_size_ratio_w) >> inner_shift;
        uint16_t bin_size_h = (roi_height * bin_size_ratio_h) >> inner_shift;
    
        int roi_bin_grid_w = sampling_ratio;
        int roi_bin_grid_h = sampling_ratio;
        
        uint16_t grid_w = bin_size_w / (sampling_ratio * 2);
        uint16_t grid_h = bin_size_h / (sampling_ratio * 2);

        // (C+1) channels
        for (int c = 0; c < pooled_c; c++){
            uint32_t output_val = 0;
            uint32_t index = i*out_hwc_stride + c*out_hw_stride + ph*pooled_w + pw;
            for (int iy = 0; iy < roi_bin_grid_h; iy++){
                uint16_t y = roi_start_h + ph * bin_size_h + (2*iy + 1)*grid_h;
                for (int ix = 0; ix < roi_bin_grid_w; ix++){
                    uint16_t x = roi_start_w + pw * bin_size_w + (2*ix + 1)*grid_w;
                    output_val += bilinear_interpolate(
                        data_ptr,
                        src_height,
                        src_width,
                        y,
                        x,
                        roi_shift);        
                }// end of bin x
            }// end of bin y
            // output_val /= count                   
            out_data[index] = (uint16_t)(output_val >> post_shift);
            data_ptr += src_height * src_width;
            // printf("out_data is %d.\n", out_data[index] >> src_shift);
            // printf("out_data is %d.\n", out_data[index]);
            // printf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~.\n");
        }  
    }
}

void psroi_pooling_align_golden(struct psroi_param *param){

    uint8_t *src_ptr = param->src_arr;
    uint16_t *rois_arr = param->rois_arr;
    uint16_t *out_data = param->out_arr;
    uint32_t rois_num = param->rois_num;
    uint32_t pooled_h = param->pooled_h;
    uint32_t pooled_w = param->pooled_w;
    uint32_t pooled_c = param->pooled_c;
    uint32_t src_k2 = pooled_h * pooled_w;
    uint32_t src_height = param->src_height;
    uint32_t src_width = param->src_width;
    uint8_t sampling_ratio = param->sampling_ratio;
    uint8_t roi_shift = param->roi_shift;

    for (uint32_t i=0; i<src_k2; i++){
        psroi_align_golden(src_ptr,
                        rois_arr,
                        out_data,
                        rois_num,
                        i,
                        pooled_h,
                        pooled_w,
                        pooled_c,
                        src_height,
                        src_width,
                        sampling_ratio,
                        roi_shift);        
        src_ptr += src_height * src_width * pooled_c;  
    }  
}

// void psroi_pooling_align_vec(struct psroi_param *param){
//     uint8_t *data_ptr = param->src_arr;
//     uint16_t *rois_arr = param->rois_arr;
//     uint16_t *out_ptr = param->out_arr;
//     uint32_t rois_num = param->rois_num;
//     uint32_t pooled_h = param->pooled_h;
//     uint32_t pooled_w = param->pooled_w;
//     uint32_t pooled_c = param->pooled_c;
//     uint32_t src_k2 = pooled_h * pooled_w;
//     uint32_t src_height = param->src_height;
//     uint32_t src_width = param->src_width;
//     uint8_t sampling_ratio = param->sampling_ratio;
//     uint8_t roi_shift = param->roi_shift;

//     uint16_t *rois_ptr0= rois_arr;
//     uint16_t *rois_ptr1 = rois_arr+1;
//     uint16_t *rois_ptr2 = rois_arr+2;
//     uint16_t *rois_ptr3 = rois_arr+3;
//     uint16_t roi_shifted = (uint16_t)(1 << roi_shift);
//     uint16_t inner_shifted = (uint16_t)(1 << inner_shift);    
//     uint32_t src_hw = src_height * src_width;
//     uint16_t src_hwc = src_height * src_width * pooled_c;
//     uint16_t height_border = src_height -1;
//     uint16_t width_border = src_width -1;
//     uint32_t out_hwc_stride = pooled_h * pooled_w * pooled_c;
//     uint32_t out_hw_stride = pooled_h * pooled_w;

//     uint16_t maskedoff_height_arr[300];
//     uint16_t maskedoff_width_arr[300];
//     for (uint32_t i = 0; i < 300; i++){
//         maskedoff_height_arr[i] = height_border;
//         maskedoff_width_arr[i] = width_border;
//     }
//     uint16_t *maskedoff_height_ptr = maskedoff_height_arr;
//     uint16_t *maskedoff_width_ptr = maskedoff_width_arr;

//     uint8_t sampling_ratio_double = sampling_ratio * 2;
//     uint16_t bin_size_ratio_w = (uint16_t)(inner_shifted / pooled_w);
//     uint16_t bin_size_ratio_h = (uint16_t)(inner_shifted / pooled_h);

//     size_t roi_vl = 0;
    
//     for (uint16_t k2_index = 0; k2_index < src_k2; k2_index++){
      
//         uint16_t ph = k2_index / pooled_w;
//         uint16_t pw = k2_index % pooled_w;
//         maskedoff_height_ptr = maskedoff_height_arr;
//         maskedoff_width_ptr = maskedoff_width_arr;
//         size_t vl_cnt = 0;

//         for (size_t roi_n = rois_num; (roi_vl = vsetvl_e16m2(roi_n)); roi_n-= roi_vl){
//             data_ptr = param->src_arr + (k2_index) * src_hwc;
//             out_ptr = param->out_arr + k2_index + vl_cnt * out_hwc_stride;

//             vuint16m2_t roi_start_w = vlse16_v_u16m2(rois_ptr0, 8);
//             vuint16m2_t roi_start_h = vlse16_v_u16m2(rois_ptr1, 8);
//             vuint16m2_t roi_end_w = vlse16_v_u16m2(rois_ptr2, 8);
//             vuint16m2_t roi_end_h = vlse16_v_u16m2(rois_ptr3, 8);          

//             vuint16m2_t roi_width_tmp = vsub_vv_u16m2(roi_end_w, roi_start_w);
//             vuint16m2_t roi_width = vmaxu_vx_u16m2(roi_width_tmp, roi_shifted);
//             vuint16m2_t roi_height_tmp = vsub_vv_u16m2(roi_end_h, roi_start_h);
//             vuint16m2_t roi_height = vmaxu_vx_u16m2(roi_height_tmp, roi_shifted);

//             vuint16m2_t bin_size_w_tmp = vmul_vx_u16m2(roi_width, bin_size_ratio_w);
//             vuint16m2_t bin_size_w = vsrl_vx_u16m2(bin_size_w_tmp, (uint16_t)inner_shift);
//             vuint16m2_t bin_size_h_tmp = vmul_vx_u16m2(roi_height, bin_size_ratio_h);
//             vuint16m2_t bin_size_h = vsrl_vx_u16m2(bin_size_h_tmp, (uint16_t)inner_shift);

//             vuint16m2_t grid_w = vdivu_vx_u16m2(bin_size_w, sampling_ratio_double);
//             vuint16m2_t grid_h = vdivu_vx_u16m2(bin_size_h, sampling_ratio_double);

//             vuint16m2_t y_tmp = vmacc_vx_u16m2(roi_start_h, ph, bin_size_h);
//             vuint16m2_t x_tmp = vmacc_vx_u16m2(roi_start_w, pw, bin_size_w);
//             vuint16m2_t grid_h3 = vmul_vx_u16m2(grid_h, 3);
//             vuint16m2_t grid_w3 = vmul_vx_u16m2(grid_w, 3);
//             vuint16m2_t y_tmp_grid_h = vadd_vv_u16m2(y_tmp, grid_h);
//             vuint16m2_t y_tmp_grid_h3 = vadd_vv_u16m2(y_tmp, grid_h3);
//             vuint16m2_t x_tmp_grid_w = vadd_vv_u16m2(x_tmp, grid_w);
//             vuint16m2_t x_tmp_grid_w3 = vadd_vv_u16m2(x_tmp, grid_w3);

//             vuint16m2_t maskedoff_height = vle16_v_u16m2(maskedoff_height_ptr);
//             vuint16m2_t maskedoff_width = vle16_v_u16m2(maskedoff_width_ptr);

//             for (uint32_t c = 0; c < pooled_c; c++){

//                 // pooled0 iy=0,ix=0,
//                 // y=roi_start_h+ph*bin_size_h+grid_h,  x=roi_start_w+pw*bin_size_w+grid_w
//                 vuint16m2_t y_low = vsrl_vx_u16m2(y_tmp_grid_h, (uint16_t)roi_shift);      
//                 vuint16m2_t x_low = vsrl_vx_u16m2(x_tmp_grid_w, (uint16_t)roi_shift);
//                 vbool8_t y_low_mask = vmsltu_vx_u16m2_b8(y_low, height_border);
//                 vbool8_t x_low_mask = vmsltu_vx_u16m2_b8(x_low, width_border);
//                 vbool8_t y_low_mask_n = vmnot_m_b8(y_low_mask);
//                 vbool8_t x_low_mask_n = vmnot_m_b8(x_low_mask);
//                 vuint16m2_t y_high = vadd_vx_u16m2_m(y_low_mask, maskedoff_height, y_low, 1);
//                 vuint16m2_t x_high = vadd_vx_u16m2_m(x_low_mask, maskedoff_width, x_low, 1);
//                 vuint16m2_t y = vsll_vx_u16m2_m(y_low_mask_n, y_tmp_grid_h, y_low, (uint16_t)roi_shift);
//                 vuint16m2_t x = vsll_vx_u16m2_m(x_low_mask_n, x_tmp_grid_w, x_low, (uint16_t)roi_shift);

//                 vuint16m2_t ly_tmp = vsll_vx_u16m2(y_low, (uint16_t)roi_shift);
//                 vuint16m2_t lx_tmp = vsll_vx_u16m2(x_low, (uint16_t)roi_shift);
//                 vuint16m2_t ly = vsub_vv_u16m2(y, ly_tmp);
//                 vuint16m2_t lx = vsub_vv_u16m2(x, lx_tmp);
//                 vuint16m2_t hy = vrsub_vx_u16m2(ly, roi_shifted);
//                 vuint16m2_t hx = vrsub_vx_u16m2(lx, roi_shifted);

//                 vuint16m2_t v1_index = vmacc_vx_u16m2(x_low, (uint16_t)src_width, y_low);
//                 vuint16m2_t v2_index = vmacc_vx_u16m2(x_high, (uint16_t)src_width, y_low);
//                 vuint16m2_t v3_index = vmacc_vx_u16m2(x_low, (uint16_t)src_width, y_high);
//                 vuint16m2_t v4_index = vmacc_vx_u16m2(x_high, (uint16_t)src_width, y_high);
     
//                 vuint8m1_t v1_tmp = vlxei16_v_u8m1(data_ptr, v1_index);
//                 vuint8m1_t v2_tmp = vlxei16_v_u8m1(data_ptr, v2_index);
//                 vuint8m1_t v3_tmp = vlxei16_v_u8m1(data_ptr, v3_index);
//                 vuint8m1_t v4_tmp = vlxei16_v_u8m1(data_ptr, v4_index);
//                 vuint16m2_t v1 = vwaddu_vx_u16m2(v1_tmp, 0);
//                 vuint16m2_t v2 = vwaddu_vx_u16m2(v2_tmp, 0);
//                 vuint16m2_t v3 = vwaddu_vx_u16m2(v3_tmp, 0);
//                 vuint16m2_t v4 = vwaddu_vx_u16m2(v4_tmp, 0);

//                 vuint16m2_t w1_tmp = vmul_vv_u16m2(hy, hx);            
//                 vuint16m2_t w2_tmp = vmul_vv_u16m2(hy, lx);
//                 vuint16m2_t w3_tmp = vmul_vv_u16m2(ly, hx);
//                 vuint16m2_t w4_tmp = vmul_vv_u16m2(ly, lx);
//                 vuint16m2_t w1 = vsrl_vx_u16m2(w1_tmp, (uint16_t)roi_shift);
//                 vuint16m2_t w2 = vsrl_vx_u16m2(w2_tmp, (uint16_t)roi_shift);
//                 vuint16m2_t w3 = vsrl_vx_u16m2(w3_tmp, (uint16_t)roi_shift);
//                 vuint16m2_t w4 = vsrl_vx_u16m2(w4_tmp, (uint16_t)roi_shift);

//                 vuint32m4_t val_pooled0_tmp = vwmulu_vv_u32m4(w1, v1);
//                 val_pooled0_tmp = vwmaccu_vv_u32m4(val_pooled0_tmp, w2, v2);
//                 val_pooled0_tmp = vwmaccu_vv_u32m4(val_pooled0_tmp, w3, v3);
//                 val_pooled0_tmp = vwmaccu_vv_u32m4(val_pooled0_tmp, w4, v4);
//                 vuint16m2_t val_pooled0 = vnsrl_wx_u16m2(val_pooled0_tmp, (uint16_t)roi_shift); 

//                 // // pooled1 iy=0,ix=1,
//                 // y=roi_start_h+ph*bin_size_h+3*grid_h,  x=roi_start_w+pw*bin_size_w+grid_w
//                 y_low = vsrl_vx_u16m2(y_tmp_grid_h3, (uint16_t)roi_shift);      
//                 x_low = vsrl_vx_u16m2(x_tmp_grid_w, (uint16_t)roi_shift);
//                 y_low_mask = vmsleu_vx_u16m2_b8(y_low, src_height);
//                 x_low_mask = vmsleu_vx_u16m2_b8(x_low, src_width);
//                 y_low_mask_n = vmnot_m_b8(y_low_mask);
//                 x_low_mask_n = vmnot_m_b8(x_low_mask);
//                 y_high = vadd_vx_u16m2_m(y_low_mask, maskedoff_height, y_low, 1);
//                 x_high = vadd_vx_u16m2_m(x_low_mask, maskedoff_width, x_low, 1);
//                 y = vsll_vx_u16m2_m(y_low_mask_n, y_tmp_grid_h3, y_low, (uint16_t)roi_shift);
//                 x = vsll_vx_u16m2_m(x_low_mask_n, x_tmp_grid_w, x_low, (uint16_t)roi_shift);

//                 ly_tmp = vsll_vx_u16m2(y_low, (uint16_t)roi_shift);
//                 lx_tmp = vsll_vx_u16m2(x_low, (uint16_t)roi_shift);
//                 ly = vsub_vv_u16m2(y, ly_tmp);
//                 lx = vsub_vv_u16m2(x, lx_tmp);
//                 hy = vrsub_vx_u16m2(ly, roi_shifted);
//                 hx = vrsub_vx_u16m2(lx, roi_shifted);

//                 v1_index = vmacc_vx_u16m2(x_low, (uint16_t)src_width, y_low);
//                 v2_index = vmacc_vx_u16m2(x_high, (uint16_t)src_width, y_low);
//                 v3_index = vmacc_vx_u16m2(x_low, (uint16_t)src_width, y_high);
//                 v4_index = vmacc_vx_u16m2(x_high, (uint16_t)src_width, y_high);
//                 v1_tmp = vlxei16_v_u8m1(data_ptr, v1_index);
//                 v2_tmp = vlxei16_v_u8m1(data_ptr, v2_index);
//                 v3_tmp = vlxei16_v_u8m1(data_ptr, v3_index);
//                 v4_tmp = vlxei16_v_u8m1(data_ptr, v4_index);
//                 v1 = vwaddu_vx_u16m2(v1_tmp, 0);
//                 v2 = vwaddu_vx_u16m2(v2_tmp, 0);
//                 v3 = vwaddu_vx_u16m2(v3_tmp, 0);
//                 v4 = vwaddu_vx_u16m2(v4_tmp, 0);

//                 w1_tmp = vmul_vv_u16m2(hy, hx);            
//                 w2_tmp = vmul_vv_u16m2(hy, lx);
//                 w3_tmp = vmul_vv_u16m2(ly, hx);
//                 w4_tmp = vmul_vv_u16m2(ly, lx);
//                 w1 = vsrl_vx_u16m2(w1_tmp, (uint16_t)roi_shift);
//                 w2 = vsrl_vx_u16m2(w2_tmp, (uint16_t)roi_shift);
//                 w3 = vsrl_vx_u16m2(w3_tmp, (uint16_t)roi_shift);
//                 w4 = vsrl_vx_u16m2(w4_tmp, (uint16_t)roi_shift);

//                 vuint32m4_t val_pooled1_tmp = vwmulu_vv_u32m4(w1, v1);
//                 val_pooled1_tmp = vwmaccu_vv_u32m4(val_pooled1_tmp, w2, v2);
//                 val_pooled1_tmp = vwmaccu_vv_u32m4(val_pooled1_tmp, w3, v3);
//                 val_pooled1_tmp = vwmaccu_vv_u32m4(val_pooled1_tmp, w4, v4);
//                 vuint16m2_t val_pooled1 = vnsrl_wx_u16m2(val_pooled1_tmp, (uint16_t)roi_shift);

//                 // // pooled2 iy=1,ix=0,
//                 // y=roi_start_h+ph*bin_size_h+grid_h,  x=roi_start_w+pw*bin_size_w+3*grid_w
//                 y_low = vsrl_vx_u16m2(y_tmp_grid_h, (uint16_t)roi_shift);      
//                 x_low = vsrl_vx_u16m2(x_tmp_grid_w3, (uint16_t)roi_shift);
//                 y_low_mask = vmsleu_vx_u16m2_b8(y_low, src_height);
//                 x_low_mask = vmsleu_vx_u16m2_b8(x_low, src_width);
//                 y_low_mask_n = vmnot_m_b8(y_low_mask);
//                 x_low_mask_n = vmnot_m_b8(x_low_mask);
//                 y_high = vadd_vx_u16m2_m(y_low_mask, maskedoff_height, y_low, 1);
//                 x_high = vadd_vx_u16m2_m(x_low_mask, maskedoff_width, x_low, 1);
//                 y = vsll_vx_u16m2_m(y_low_mask_n, y_tmp_grid_h, y_low, (uint16_t)roi_shift);
//                 x = vsll_vx_u16m2_m(x_low_mask_n, x_tmp_grid_w3, x_low, (uint16_t)roi_shift);

//                 ly_tmp = vsll_vx_u16m2(y_low, (uint16_t)roi_shift);
//                 lx_tmp = vsll_vx_u16m2(x_low, (uint16_t)roi_shift);
//                 ly = vsub_vv_u16m2(y, ly_tmp);
//                 lx = vsub_vv_u16m2(x, lx_tmp);
//                 hy = vrsub_vx_u16m2(ly, roi_shifted);
//                 hx = vrsub_vx_u16m2(lx, roi_shifted);

//                 v1_index = vmacc_vx_u16m2(x_low, (uint16_t)src_width, y_low);
//                 v2_index = vmacc_vx_u16m2(x_high, (uint16_t)src_width, y_low);
//                 v3_index = vmacc_vx_u16m2(x_low, (uint16_t)src_width, y_high);
//                 v4_index = vmacc_vx_u16m2(x_high, (uint16_t)src_width, y_high);

//                 v1_tmp = vlxei16_v_u8m1(data_ptr, v1_index);
//                 v2_tmp = vlxei16_v_u8m1(data_ptr, v2_index);
//                 v3_tmp = vlxei16_v_u8m1(data_ptr, v3_index);
//                 v4_tmp = vlxei16_v_u8m1(data_ptr, v4_index);
//                 v1 = vwaddu_vx_u16m2(v1_tmp, 0);
//                 v2 = vwaddu_vx_u16m2(v2_tmp, 0);
//                 v3 = vwaddu_vx_u16m2(v3_tmp, 0);
//                 v4 = vwaddu_vx_u16m2(v4_tmp, 0);

//                 w1_tmp = vmul_vv_u16m2(hy, hx);            
//                 w2_tmp = vmul_vv_u16m2(hy, lx);
//                 w3_tmp = vmul_vv_u16m2(ly, hx);
//                 w4_tmp = vmul_vv_u16m2(ly, lx);
//                 w1 = vsrl_vx_u16m2(w1_tmp, (uint16_t)roi_shift);
//                 w2 = vsrl_vx_u16m2(w2_tmp, (uint16_t)roi_shift);
//                 w3 = vsrl_vx_u16m2(w3_tmp, (uint16_t)roi_shift);
//                 w4 = vsrl_vx_u16m2(w4_tmp, (uint16_t)roi_shift);

//                 vuint32m4_t val_pooled2_tmp = vwmulu_vv_u32m4(w1, v1);
//                 val_pooled2_tmp = vwmaccu_vv_u32m4(val_pooled2_tmp, w2, v2);
//                 val_pooled2_tmp = vwmaccu_vv_u32m4(val_pooled2_tmp, w3, v3);
//                 val_pooled2_tmp = vwmaccu_vv_u32m4(val_pooled2_tmp, w4, v4);
//                 vuint16m2_t val_pooled2 = vnsrl_wx_u16m2(val_pooled2_tmp, (uint16_t)roi_shift);

//                 // // pooled3 iy=1,ix=1,
//                 // // y=roi_start_h+ph*bin_size_h+3*grid_h,  x=roi_start_w+pw*bin_size_w+3*grid_w
//                 y_low = vsrl_vx_u16m2(y_tmp_grid_h3, (uint16_t)roi_shift);      
//                 x_low = vsrl_vx_u16m2(x_tmp_grid_w3, (uint16_t)roi_shift);
//                 y_low_mask = vmsleu_vx_u16m2_b8(y_low, src_height);
//                 x_low_mask = vmsleu_vx_u16m2_b8(x_low, src_width);
//                 y_low_mask_n = vmnot_m_b8(y_low_mask);
//                 x_low_mask_n = vmnot_m_b8(x_low_mask);
//                 y_high = vadd_vx_u16m2_m(y_low_mask, maskedoff_height, y_low, 1);
//                 x_high = vadd_vx_u16m2_m(x_low_mask, maskedoff_width, x_low, 1);
//                 y = vsll_vx_u16m2_m(y_low_mask_n, y_tmp_grid_h3, y_low, (uint16_t)roi_shift);
//                 x = vsll_vx_u16m2_m(x_low_mask_n, x_tmp_grid_w3, x_low, (uint16_t)roi_shift);

//                 ly_tmp = vsll_vx_u16m2(y_low, (uint16_t)roi_shift);
//                 lx_tmp = vsll_vx_u16m2(x_low, (uint16_t)roi_shift);
//                 ly = vsub_vv_u16m2(y, ly_tmp);
//                 lx = vsub_vv_u16m2(x, lx_tmp);
//                 hy = vrsub_vx_u16m2(ly, roi_shifted);
//                 hx = vrsub_vx_u16m2(lx, roi_shifted);

//                 v1_index = vmacc_vx_u16m2(x_low, (uint16_t)src_width, y_low);
//                 v2_index = vmacc_vx_u16m2(x_high, (uint16_t)src_width, y_low);
//                 v3_index = vmacc_vx_u16m2(x_low, (uint16_t)src_width, y_high);
//                 v4_index = vmacc_vx_u16m2(x_high, (uint16_t)src_width, y_high);

//                 v1_tmp = vlxei16_v_u8m1(data_ptr, v1_index);
//                 v2_tmp = vlxei16_v_u8m1(data_ptr, v2_index);
//                 v3_tmp = vlxei16_v_u8m1(data_ptr, v3_index);
//                 v4_tmp = vlxei16_v_u8m1(data_ptr, v4_index);
//                 v1 = vwaddu_vx_u16m2(v1_tmp, 0);
//                 v2 = vwaddu_vx_u16m2(v2_tmp, 0);
//                 v3 = vwaddu_vx_u16m2(v3_tmp, 0);
//                 v4 = vwaddu_vx_u16m2(v4_tmp, 0);

//                 w1_tmp = vmul_vv_u16m2(hy, hx);            
//                 w2_tmp = vmul_vv_u16m2(hy, lx);
//                 w3_tmp = vmul_vv_u16m2(ly, hx);
//                 w4_tmp = vmul_vv_u16m2(ly, lx);
//                 w1 = vsrl_vx_u16m2(w1_tmp, (uint16_t)roi_shift);
//                 w2 = vsrl_vx_u16m2(w2_tmp, (uint16_t)roi_shift);
//                 w3 = vsrl_vx_u16m2(w3_tmp, (uint16_t)roi_shift);
//                 w4 = vsrl_vx_u16m2(w4_tmp, (uint16_t)roi_shift);

//                 vuint32m4_t val_pooled3_tmp = vwmulu_vv_u32m4(w1, v1);
//                 val_pooled3_tmp = vwmaccu_vv_u32m4(val_pooled3_tmp, w2, v2);
//                 val_pooled3_tmp = vwmaccu_vv_u32m4(val_pooled3_tmp, w3, v3);
//                 val_pooled3_tmp = vwmaccu_vv_u32m4(val_pooled3_tmp, w4, v4);
//                 vuint16m2_t val_pooled3 = vnsrl_wx_u16m2(val_pooled3_tmp, (uint16_t)roi_shift);

//                 vuint16m2_t val_pooled = vadd_vv_u16m2(val_pooled0, val_pooled1);
//                 val_pooled = vadd_vv_u16m2(val_pooled, val_pooled2);
//                 val_pooled = vadd_vv_u16m2(val_pooled, val_pooled3);
//                 val_pooled = vsrl_vx_u16m2(val_pooled, (uint16_t)(2));   

//                 ptrdiff_t roi_stride = out_hwc_stride * 2;
//                 vsse16_v_u16m2(out_ptr, roi_stride, val_pooled);

//                 out_ptr += out_hw_stride;
//                 data_ptr += src_hw;
//             }       
//             maskedoff_height_ptr += roi_vl;
//             maskedoff_width_ptr += roi_vl;     
//             vl_cnt += roi_vl;       
//         }
//     }
// }

void psroi_simpile_test(){

    uint32_t rois_num = 2;
    uint32_t pooled_h = 2;
    uint32_t pooled_w = 2;
    uint32_t pooled_c = 2; 
    uint32_t src_height = 4;
    uint32_t src_width = 4;
    uint8_t sampling_ratio = 2; 
    uint8_t roi_shift = 0; 

    // uint8_t src_arr[16] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
    // uint8_t src_arr[32] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,\
    //                         0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
    // uint8_t src_arr[64] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,\
    //                         0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,\
    //                         0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,\
    //                         0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
    uint8_t src_arr[128] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,\
                            0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,\
                            0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,\
                            0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,
                            0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,\
                            0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,\
                            0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,\
                            0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
    // uint16_t rois_arr[4] = {1,1,3,3};
    uint16_t rois_arr[8] = {1,1,3,3,\
                            1,1,1,1};
    uint16_t out_arr_golden[16] = {0};
    uint16_t out_arr_vec[16] = {0};
    struct psroi_param golden_param = {src_arr, rois_arr, out_arr_golden, \
    rois_num, pooled_h, pooled_w, pooled_c, src_height, src_width, sampling_ratio, roi_shift};
    struct psroi_param rvv_param = {src_arr, rois_arr, out_arr_vec, \
    rois_num, pooled_h, pooled_w, pooled_c, src_height, src_width, sampling_ratio, roi_shift};
    psroi_pooling_align_golden(&golden_param);
    //psroi_pooling_align_vec(&rvv_param);

    uint32_t out_num = pooled_h * pooled_w * pooled_c * rois_num;
    // for (int out_idx=0; out_idx < out_num; out_idx++){
    //     printf("output of golden_param, index : %d, val : %d.\n", out_idx, golden_param.out_arr[out_idx]);
    // }

    // for (int out_idx=0; out_idx < out_num; out_idx++){
    //     printf("output of rvv_param, index : %d, val : %d.\n", out_idx, rvv_param.out_arr[out_idx]);
    // }

    // int pass = 1;
    // for (int out_idx=0; out_idx < out_num; out_idx++){
    //     if (!(golden_param.out_arr[out_idx] == rvv_param.out_arr[out_idx])){
    //         printf("failed, %d != %d\n", golden_param.out_arr[out_idx], rvv_param.out_arr[out_idx]);
    //         pass = 0;
    //     }
    // }
    // if (pass) printf("psroi simple test passed.\n");  
    // else printf("psroi simple test failed.\n");      
}

int main(){
    psroi_simpile_test();
    return 0;
}