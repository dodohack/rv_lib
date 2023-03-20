#include "kernel.h"
#include <riscv_vector.h>

// uint8_t *data = data_start + c * src_hw;
static vuint16m4_t bilinear_interpolate(uint8_t *data, uint16_t height,
                                        uint16_t width, uint16_t y, uint16_t x,
                                        uint8_t roi_shift, size_t vl,
                                        size_t stride) {
  uint16_t height_border = height - (uint16_t)1;
  uint16_t width_border = width - (uint16_t)1;
  uint16_t roi_shifted = (uint16_t)1 << roi_shift;

  uint16_t y_low = y >> roi_shift;
  uint16_t x_low = x >> roi_shift;
  bool y_low_mask = y_low < height_border;
  bool x_low_mask = x_low < width_border;
  uint16_t y_high = y_low_mask ? (y_low + (uint16_t)1) : height_border;
  uint16_t x_high = x_low_mask ? (x_low + (uint16_t)1) : width_border;
  y = y_low_mask ? y : (y_low << roi_shift);
  x = x_low_mask ? x : (x_low << roi_shift);

  uint16_t ly = y - (y_low << roi_shift);
  uint16_t lx = x - (x_low << roi_shift);
  uint16_t hy = roi_shifted - ly;
  uint16_t hx = roi_shifted - lx;
  vuint16m4_t v1 =
      vzext_vf2(vlse8_v_u8m2(&data[width * y_low + x_low], stride, vl), vl);
  vuint16m4_t v2 =
      vzext_vf2(vlse8_v_u8m2(&data[width * y_low + x_high], stride, vl), vl);
  vuint16m4_t v3 =
      vzext_vf2(vlse8_v_u8m2(&data[width * y_high + x_low], stride, vl), vl);
  vuint16m4_t v4 =
      vzext_vf2(vlse8_v_u8m2(&data[width * y_high + x_high], stride, vl), vl);

  uint16_t w1 = (hy * hx) >> roi_shift;
  uint16_t w2 = (hy * lx) >> roi_shift;
  uint16_t w3 = (ly * hx) >> roi_shift;
  uint16_t w4 = (ly * lx) >> roi_shift;

  vuint32m8_t val = vwmaccu(vwmulu(v1, w1, vl), w2, v2, vl);
  val = vwmaccu(val, w3, v3, vl);
  val = vwmaccu(val, w4, v4, vl);

  return vnsrl(val, roi_shift, vl);
}

__attribute__((noinline)) void psroi_pooling_align(struct psroi_param *param) {
  uint8_t *data_start = param->src_arr;
  uint16_t *rois_arr = param->rois_arr;
  uint32_t rois_num = param->rois_num;
  uint32_t pooled_h = param->pooled_h;
  uint32_t pooled_w = param->pooled_w;
  uint32_t pooled_c = param->pooled_c;
  uint32_t src_k2 = pooled_h * pooled_w;
  uint32_t src_height = param->src_height;
  uint32_t src_width = param->src_width;
  uint8_t sampling_ratio = param->sampling_ratio;
  uint8_t roi_shift = param->roi_shift;

  uint16_t *rois_ptr0 = rois_arr;
  uint16_t *rois_ptr1 = rois_arr + 1;
  uint16_t *rois_ptr2 = rois_arr + 2;
  uint16_t *rois_ptr3 = rois_arr + 3;
  uint16_t roi_shifted = (uint16_t)(1 << roi_shift);
  uint16_t inner_shifted = (uint16_t)(1 << inner_shift);
  uint32_t src_hw = src_height * src_width;
  uint16_t src_hwc = src_height * src_width * pooled_c;
  uint16_t height_border = src_height - 1;
  uint16_t width_border = src_width - 1;
  uint32_t out_hwc_stride = pooled_h * pooled_w * pooled_c;
  uint32_t out_hw_stride = pooled_h * pooled_w;

  uint16_t sampling_ratio_double = sampling_ratio * 2;
  uint16_t bin_size_ratio_w = (uint16_t)(inner_shifted / pooled_w);
  uint16_t bin_size_ratio_h = (uint16_t)(inner_shifted / pooled_h);

  for (uint16_t k2_index = 0; k2_index < src_k2; k2_index++) {
    uint16_t ph = k2_index / pooled_w;
    uint16_t pw = k2_index % pooled_w;

    data_start = param->src_arr + (size_t)k2_index * src_hwc;
    uint16_t *restrict out_ptr = param->out_arr + k2_index;
    for (size_t i = 0; i < rois_num; ++i) {
      uint16_t roi_start_w = rois_arr[4 * i];
      uint16_t roi_start_h = rois_arr[4 * i + 1];
      uint16_t roi_end_w = rois_arr[4 * i + 2];
      uint16_t roi_end_h = rois_arr[4 * i + 3];

      uint16_t roi_width = MAX(roi_end_w - roi_start_w, roi_shifted);
      uint16_t roi_height = MAX(roi_end_h - roi_start_h, roi_shifted);

      uint16_t bin_size_w = (roi_width * bin_size_ratio_w) >> inner_shift;
      uint16_t bin_size_h = (roi_height * bin_size_ratio_h) >> inner_shift;

      uint16_t grid_w = bin_size_w / sampling_ratio_double;
      uint16_t grid_h = bin_size_h / sampling_ratio_double;

      uint16_t y_tmp = roi_start_h + ph * bin_size_h;
      uint16_t x_tmp = roi_start_w + pw * bin_size_w;
      uint16_t grid_h3 = grid_h * 3;
      uint16_t grid_w3 = grid_w * 3;
      uint16_t y_tmp_grid_h = y_tmp + grid_h;
      uint16_t y_tmp_grid_h3 = y_tmp + grid_h3;
      uint16_t x_tmp_grid_w = x_tmp + grid_w;
      uint16_t x_tmp_grid_w3 = x_tmp + grid_w3;

      size_t vl;
      for (size_t c = 0; c < pooled_c; c += vl) {
        vl = vsetvl_e16m4(pooled_c - c);
        uint8_t *data_ptr = data_start + c * src_hw;
        vuint16m4_t output_val =
            bilinear_interpolate(data_ptr, src_height, src_width, y_tmp_grid_h,
                                 x_tmp_grid_w, roi_shift, vl, src_hw);
        output_val = vadd(output_val,
                          bilinear_interpolate(data_ptr, src_height, src_width,
                                               y_tmp_grid_h3, x_tmp_grid_w,
                                               roi_shift, vl, src_hw),
                          vl);
        output_val = vadd(output_val,
                          bilinear_interpolate(data_ptr, src_height, src_width,
                                               y_tmp_grid_h, x_tmp_grid_w3,
                                               roi_shift, vl, src_hw),
                          vl);
        output_val = vadd(output_val,
                          bilinear_interpolate(data_ptr, src_height, src_width,
                                               y_tmp_grid_h3, x_tmp_grid_w3,
                                               roi_shift, vl, src_hw),
                          vl);
        output_val = vsrl(output_val, 2, vl);
        vsse16_v_u16m4(&out_ptr[i * out_hwc_stride + c * out_hw_stride],
                       2 * out_hw_stride, output_val, vl);
      }
    }
  }
}
