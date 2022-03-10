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
    psroi_pooling_align_golden(&param);
    int tmp1 = read_rdcycle();

    // for (int out_idx=0; out_idx < 117600; out_idx++){
    //     printf("output of rvv_param, index : %d, val : %d.\n", out_idx, param.out_arr[out_idx]);
    // }

    printf("psroi_23x40x392x300 running cycles : %d.\n", (tmp1-tmp0));

    return 0;
}
