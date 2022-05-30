	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_f2p0_d2p0_c2p0_v1p0_zve32f1p0_zve32x1p0_zve64d1p0_zve64f1p0_zve64x1p0_zvl128b1p0_zvl32b1p0_zvl64b1p0"
	.option	nopic
	.file	"psroi.c"
	.globl	read_rdcycle                    # -- Begin function read_rdcycle
	.p2align	1
	.type	read_rdcycle,@function
read_rdcycle:                           # @read_rdcycle
# %bb.0:                                # %entry
	#APP
	rdcycle	a0

	#NO_APP
	ret
.Lfunc_end0:
	.size	read_rdcycle, .Lfunc_end0-read_rdcycle
                                        # -- End function
	.globl	global_arr_init                 # -- Begin function global_arr_init
	.p2align	1
	.type	global_arr_init,@function
global_arr_init:                        # @global_arr_init
# %bb.0:                                # %entry
	li	a0, 15
	lui	a1, %hi(src_arr_global)
	addi	a1, a1, %lo(src_arr_global)
	lui	a2, 88
	addi	a2, a2, 207
.LBB1_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	addi	a3, a0, -15
	andi	a3, a3, 48
	add	a4, a0, a1
	sb	a3, -15(a4)
	addi	a3, a0, -14
	andi	a3, a3, 49
	sb	a3, -14(a4)
	addi	a3, a0, -13
	andi	a3, a3, 50
	sb	a3, -13(a4)
	addi	a3, a0, -12
	andi	a3, a3, 51
	sb	a3, -12(a4)
	addi	a3, a0, -11
	andi	a3, a3, 52
	sb	a3, -11(a4)
	addi	a3, a0, -10
	andi	a3, a3, 53
	sb	a3, -10(a4)
	addi	a3, a0, -9
	andi	a3, a3, 54
	sb	a3, -9(a4)
	addi	a3, a0, -8
	andi	a3, a3, 55
	sb	a3, -8(a4)
	addi	a3, a0, -7
	andi	a3, a3, 56
	sb	a3, -7(a4)
	addi	a3, a0, -6
	andi	a3, a3, 57
	sb	a3, -6(a4)
	addi	a3, a0, -5
	andi	a3, a3, 58
	sb	a3, -5(a4)
	addi	a3, a0, -4
	andi	a3, a3, 59
	sb	a3, -4(a4)
	addi	a3, a0, -3
	andi	a3, a3, 60
	sb	a3, -3(a4)
	addi	a3, a0, -2
	andi	a3, a3, 61
	sb	a3, -2(a4)
	addi	a3, a0, -1
	andi	a3, a3, 62
	sb	a3, -1(a4)
	andi	a3, a0, 63
	addi	a0, a0, 16
	sb	a3, 0(a4)
	bne	a0, a2, .LBB1_1
# %bb.2:                                # %for.body5.preheader
	lui	a0, %hi(rois_arr_global)
	addi	a6, a0, %lo(rois_arr_global)
	addi	a0, a6, 16
	lui	a1, 16
	addi	a1, a1, 1
	lui	a2, 176
	addi	a2, a2, 11
	lui	a3, 32
	addi	a3, a3, 2
	lui	a4, 256
	addi	a4, a4, 16
	lui	a5, 2
	addi	a5, a5, 1424
	add	a5, a5, a6
.LBB1_3:                                # %for.body5
                                        # =>This Inner Loop Header: Depth=1
	sw	a1, -16(a0)
	sw	a2, -12(a0)
	sw	a3, -8(a0)
	sw	a4, -4(a0)
	sw	a1, 0(a0)
	sw	a2, 4(a0)
	sw	a3, 8(a0)
	sw	a4, 12(a0)
	addi	a0, a0, 32
	bne	a0, a5, .LBB1_3
# %bb.4:                                # %for.cond.cleanup4
	ret
.Lfunc_end1:
	.size	global_arr_init, .Lfunc_end1-global_arr_init
                                        # -- End function
	.globl	psroi_param_read                # -- Begin function psroi_param_read
	.p2align	1
	.type	psroi_param_read,@function
psroi_param_read:                       # @psroi_param_read
# %bb.0:                                # %entry
	lw	a2, 8(a1)
	sw	a2, 12(a0)
	lw	a2, 12(a1)
	sw	a2, 16(a0)
	lw	a2, 16(a1)
	sw	a2, 20(a0)
	lw	a2, 20(a1)
	sw	a2, 24(a0)
	lw	a2, 24(a1)
	sw	a2, 28(a0)
	lw	a2, 28(a1)
	sw	a2, 32(a0)
	lw	a1, 32(a1)
	srli	a2, a1, 16
	sb	a2, 36(a0)
	sb	a1, 37(a0)
	lui	a1, %hi(src_arr_global)
	addi	a1, a1, %lo(src_arr_global)
	sw	a1, 0(a0)
	lui	a1, %hi(rois_arr_global)
	addi	a1, a1, %lo(rois_arr_global)
	sw	a1, 4(a0)
	lui	a1, %hi(out_arr_global)
	addi	a1, a1, %lo(out_arr_global)
	sw	a1, 8(a0)
	ret
.Lfunc_end2:
	.size	psroi_param_read, .Lfunc_end2-psroi_param_read
                                        # -- End function
	.globl	psroi_pooling_align_vec         # -- Begin function psroi_pooling_align_vec
	.p2align	1
	.type	psroi_pooling_align_vec,@function
psroi_pooling_align_vec:                # @psroi_pooling_align_vec
# %bb.0:                                # %entry
	addi	sp, sp, -1328
	sw	ra, 1324(sp)                    # 4-byte Folded Spill
	sw	s0, 1320(sp)                    # 4-byte Folded Spill
	sw	s1, 1316(sp)                    # 4-byte Folded Spill
	sw	s2, 1312(sp)                    # 4-byte Folded Spill
	sw	s3, 1308(sp)                    # 4-byte Folded Spill
	sw	s4, 1304(sp)                    # 4-byte Folded Spill
	sw	s5, 1300(sp)                    # 4-byte Folded Spill
	sw	s6, 1296(sp)                    # 4-byte Folded Spill
	sw	s7, 1292(sp)                    # 4-byte Folded Spill
	sw	s8, 1288(sp)                    # 4-byte Folded Spill
	sw	s9, 1284(sp)                    # 4-byte Folded Spill
	sw	s10, 1280(sp)                   # 4-byte Folded Spill
	sw	s11, 1276(sp)                   # 4-byte Folded Spill
	csrr	a1, vlenb
	li	a2, 56
	mul	a1, a1, a2
	sub	sp, sp, a1
	lw	a1, 4(a0)
	sw	a1, 52(sp)                      # 4-byte Folded Spill
	lw	a1, 12(a0)
	sw	a1, 24(sp)                      # 4-byte Folded Spill
	lw	a7, 16(a0)
	lw	a1, 20(a0)
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	lw	a1, 24(a0)
	sw	a1, 56(sp)                      # 4-byte Folded Spill
	lw	t4, 28(a0)
	lw	s6, 32(a0)
	lbu	a6, 36(a0)
	lbu	a1, 37(a0)
	addi	t5, t4, -1
	addi	s11, s6, -1
	li	a2, 22
	addi	a5, sp, 660
	addi	s1, sp, 60
	li	s0, 622
.LBB3_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	add	a4, a5, a2
	sh	t5, -22(a4)
	add	a3, s1, a2
	sh	s11, -22(a3)
	sh	t5, -20(a4)
	sh	s11, -20(a3)
	sh	t5, -18(a4)
	sh	s11, -18(a3)
	sh	t5, -16(a4)
	sh	s11, -16(a3)
	sh	t5, -14(a4)
	sh	s11, -14(a3)
	sh	t5, -12(a4)
	sh	s11, -12(a3)
	sh	t5, -10(a4)
	sh	s11, -10(a3)
	sh	t5, -8(a4)
	sh	s11, -8(a3)
	sh	t5, -6(a4)
	sh	s11, -6(a3)
	sh	t5, -4(a4)
	sh	s11, -4(a3)
	sh	t5, -2(a4)
	sh	s11, -2(a3)
	sh	t5, 0(a4)
	addi	a2, a2, 24
	sh	s11, 0(a3)
	bne	a2, s0, .LBB3_1
# %bb.2:                                # %for.cond.cleanup
	lw	a2, 16(sp)                      # 4-byte Folded Reload
	mul	a2, a2, a7
	sw	a2, 20(sp)                      # 4-byte Folded Spill
	beqz	a2, .LBB3_18
# %bb.3:                                # %for.body39.lr.ph
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	beqz	s0, .LBB3_11
# %bb.4:                                # %for.body39.us.preheader
	li	a5, 0
	sw	zero, 28(sp)                    # 4-byte Folded Spill
	li	a2, 1
	sll	s3, a2, a1
	mul	a2, s6, t4
	lw	t0, 20(sp)                      # 4-byte Folded Reload
	mul	s1, t0, s0
	li	a4, 256
	lw	a3, 16(sp)                      # 4-byte Folded Reload
	divu	a3, a4, a3
	sw	a3, 48(sp)                      # 4-byte Folded Spill
	divu	a3, a4, a7
	sw	a3, 44(sp)                      # 4-byte Folded Spill
	lw	a4, 52(sp)                      # 4-byte Folded Reload
	addi	a3, a4, 4
	sw	a3, 40(sp)                      # 4-byte Folded Spill
	mul	a3, a2, s0
	addi	s0, a4, 6
	sw	s0, 36(sp)                      # 4-byte Folded Spill
	addi	a4, a4, 2
	sw	a4, 32(sp)                      # 4-byte Folded Spill
	slli	a4, a6, 1
	slli	a3, a3, 16
	srli	a3, a3, 16
	sw	a3, 12(sp)                      # 4-byte Folded Spill
	andi	s8, a4, 254
	mv	s7, s1
	slli	s0, s1, 1
	slli	s1, t0, 1
	li	s9, 8
	li	s10, 3
	j	.LBB3_6
.LBB3_5:                                # %for.cond.cleanup48.us
                                        #   in Loop: Header=BB3_6 Depth=1
	lw	a3, 28(sp)                      # 4-byte Folded Reload
	addi	a3, a3, 1
	sw	a3, 28(sp)                      # 4-byte Folded Spill
	slli	a3, a3, 16
	srli	a5, a3, 16
	lw	a3, 20(sp)                      # 4-byte Folded Reload
	bgeu	a5, a3, .LBB3_18
.LBB3_6:                                # %for.body39.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_8 Depth 2
                                        #       Child Loop BB3_9 Depth 3
	lw	a3, 24(sp)                      # 4-byte Folded Reload
	vsetvli	s4, a3, e16, m2, ta, mu
	beqz	s4, .LBB3_5
# %bb.7:                                # %for.body49.lr.ph.us
                                        #   in Loop: Header=BB3_6 Depth=1
	li	ra, 0
	lw	a3, 28(sp)                      # 4-byte Folded Reload
	slli	a3, a3, 16
	srli	s5, a3, 16
	lw	a3, 16(sp)                      # 4-byte Folded Reload
	divu	a6, a5, a3
	mul	a3, a6, a3
	sub	a7, a5, a3
	lw	a3, 12(sp)                      # 4-byte Folded Reload
	mul	t0, a5, a3
	addi	t3, sp, 660
	addi	t1, sp, 60
	lw	t2, 24(sp)                      # 4-byte Folded Reload
.LBB3_8:                                # %for.body49.us.us
                                        #   Parent Loop BB3_6 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_9 Depth 3
	lw	s2, 0(a0)
	lw	t6, 8(a0)
	lw	a3, 52(sp)                      # 4-byte Folded Reload
	vlse16.v	v8, (a3), s9
	lw	a3, 32(sp)                      # 4-byte Folded Reload
	vlse16.v	v10, (a3), s9
	lw	a3, 40(sp)                      # 4-byte Folded Reload
	vlse16.v	v12, (a3), s9
	lw	a3, 36(sp)                      # 4-byte Folded Reload
	vlse16.v	v14, (a3), s9
	vsub.vv	v12, v12, v8
	vmaxu.vx	v12, v12, s3
	vsub.vv	v14, v14, v10
	vmaxu.vx	v14, v14, s3
	lw	a3, 48(sp)                      # 4-byte Folded Reload
	vmul.vx	v12, v12, a3
	vsrl.vi	v12, v12, 8
	lw	a3, 44(sp)                      # 4-byte Folded Reload
	vmul.vx	v14, v14, a3
	vsrl.vi	v14, v14, 8
	vdivu.vx	v16, v12, s8
	vdivu.vx	v18, v14, s8
	vsetvli	zero, s4, e16, m2, tu, mu
	vmacc.vx	v10, a6, v14
	vmacc.vx	v8, a7, v12
	vsetvli	zero, zero, e16, m2, ta, mu
	vmul.vx	v14, v18, s10
	vmul.vx	v20, v16, s10
	vadd.vv	v22, v10, v18
	vadd.vv	v18, v10, v14
	vadd.vv	v28, v8, v16
	vadd.vv	v20, v8, v20
	vle16.v	v4, (t3)
	vle16.v	v6, (t1)
	vsrl.vx	v16, v22, a1
	vsrl.vx	v10, v28, a1
	vmsltu.vx	v0, v16, t5
	vmsltu.vx	v8, v10, s11
	vmnand.mm	v9, v0, v0
	vmnand.mm	v14, v8, v8
	vsetvli	zero, zero, e16, m2, tu, mu
	vmv.v.v	v24, v4
	vadd.vi	v24, v16, 1, v0.t
	vmv.v.v	v2, v6
	vmv1r.v	v0, v8
	vadd.vi	v2, v10, 1, v0.t
	vmv.v.v	v26, v22
	vmv1r.v	v0, v9
	vsll.vx	v26, v16, a1, v0.t
	vmv.v.v	v8, v28
	vmv1r.v	v0, v14
	vsll.vx	v8, v10, a1, v0.t
	vsetvli	zero, zero, e16, m2, ta, mu
	vsll.vx	v12, v16, a1
	csrr	a3, vlenb
	li	a4, 54
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v12, (a3)                       # Unknown-size Folded Spill
	vsll.vx	v30, v10, a1
	vsub.vv	v12, v26, v12
	vsub.vv	v8, v8, v30
	vrsub.vx	v26, v12, s3
	vrsub.vx	v0, v8, s3
	vsetvli	zero, zero, e16, m2, tu, mu
	vmv.v.v	v14, v10
	vmacc.vx	v14, s6, v24
	csrr	a3, vlenb
	li	a4, 48
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v14, (a3)                       # Unknown-size Folded Spill
	vmv2r.v	v14, v2
	vmacc.vx	v2, s6, v24
	csrr	a3, vlenb
	li	a4, 50
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v2, (a3)                        # Unknown-size Folded Spill
	vmv.v.v	v24, v10
	vmacc.vx	v24, s6, v16
	csrr	a3, vlenb
	li	a4, 44
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v24, (a3)                       # Unknown-size Folded Spill
	vmacc.vx	v14, s6, v16
	csrr	a3, vlenb
	li	a4, 46
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v14, (a3)                       # Unknown-size Folded Spill
	vsetvli	zero, zero, e16, m2, ta, mu
	vmul.vv	v24, v26, v0
	vmul.vv	v26, v26, v8
	vmul.vv	v0, v12, v0
	vmul.vv	v8, v12, v8
	vsrl.vx	v12, v24, a1
	csrr	a3, vlenb
	li	a4, 42
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v12, (a3)                       # Unknown-size Folded Spill
	vsrl.vx	v12, v26, a1
	csrr	a3, vlenb
	li	a4, 40
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v12, (a3)                       # Unknown-size Folded Spill
	vsrl.vx	v12, v0, a1
	csrr	a3, vlenb
	li	a4, 38
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v12, (a3)                       # Unknown-size Folded Spill
	vsrl.vx	v8, v8, a1
	csrr	a3, vlenb
	li	a4, 36
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v8, (a3)                        # Unknown-size Folded Spill
	vsrl.vx	v24, v18, a1
	vmsleu.vx	v0, v24, t4
	vmsleu.vx	v8, v10, s6
	vmnand.mm	v9, v0, v0
	vmnand.mm	v14, v8, v8
	vsetvli	zero, zero, e16, m2, tu, mu
	vmv.v.v	v26, v4
	vadd.vi	v26, v24, 1, v0.t
	vmv.v.v	v2, v6
	vmv1r.v	v0, v8
	vadd.vi	v2, v10, 1, v0.t
	vmv1r.v	v0, v9
	vsll.vx	v18, v24, a1, v0.t
	vmv1r.v	v0, v14
	vsll.vx	v28, v10, a1, v0.t
	vsetvli	zero, zero, e16, m2, ta, mu
	vsll.vx	v8, v24, a1
	vsub.vv	v8, v18, v8
	vsub.vv	v12, v28, v30
	vrsub.vx	v28, v8, s3
	vrsub.vx	v18, v12, s3
	vsetvli	zero, zero, e16, m2, tu, mu
	vmv.v.v	v14, v10
	vmacc.vx	v14, s6, v24
	csrr	a3, vlenb
	slli	a3, a3, 5
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v14, (a3)                       # Unknown-size Folded Spill
	vmv2r.v	v14, v2
	vmacc.vx	v14, s6, v24
	csrr	a3, vlenb
	li	a4, 30
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v14, (a3)                       # Unknown-size Folded Spill
	vmacc.vx	v10, s6, v26
	csrr	a3, vlenb
	li	a4, 52
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v10, (a3)                       # Unknown-size Folded Spill
	vmacc.vx	v2, s6, v26
	csrr	a3, vlenb
	li	a4, 34
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v2, (a3)                        # Unknown-size Folded Spill
	vsetvli	zero, zero, e16, m2, ta, mu
	vmv.v.v	v10, v28
	addi	a3, sp, 1264
	vs2r.v	v28, (a3)                       # Unknown-size Folded Spill
	vmul.vv	v28, v28, v18
	vmul.vv	v18, v8, v18
	vmul.vv	v30, v10, v12
	vmul.vv	v10, v8, v12
	vsrl.vx	v12, v28, a1
	csrr	a3, vlenb
	li	a4, 28
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v12, (a3)                       # Unknown-size Folded Spill
	vsrl.vx	v12, v30, a1
	csrr	a3, vlenb
	li	a4, 26
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v12, (a3)                       # Unknown-size Folded Spill
	vsrl.vx	v12, v18, a1
	csrr	a3, vlenb
	li	a4, 24
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v12, (a3)                       # Unknown-size Folded Spill
	vsrl.vx	v10, v10, a1
	csrr	a3, vlenb
	li	a4, 22
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v10, (a3)                       # Unknown-size Folded Spill
	vmsleu.vx	v0, v16, t4
	vsrl.vx	v18, v20, a1
	vmsleu.vx	v1, v18, s6
	vmnand.mm	v11, v0, v0
	vmnand.mm	v10, v1, v1
	vsetvli	zero, zero, e16, m2, tu, mu
	vadd.vi	v4, v16, 1, v0.t
	vmv1r.v	v0, v1
	vadd.vi	v6, v18, 1, v0.t
	vmv1r.v	v0, v11
	vsll.vx	v22, v16, a1, v0.t
	vmv1r.v	v0, v10
	vsll.vx	v20, v18, a1, v0.t
	vsetvli	zero, zero, e16, m2, ta, mu
	csrr	a3, vlenb
	li	a4, 54
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vl2re8.v	v10, (a3)                       # Unknown-size Folded Reload
	vsub.vv	v22, v22, v10
	vsll.vx	v10, v18, a1
	vsub.vv	v0, v20, v10
	vrsub.vx	v20, v22, s3
	vrsub.vx	v2, v0, s3
	vsetvli	zero, zero, e16, m2, tu, mu
	vmv.v.v	v10, v18
	vmacc.vx	v10, s6, v16
	csrr	a3, vlenb
	li	a4, 18
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v10, (a3)                       # Unknown-size Folded Spill
	vmv2r.v	v10, v6
	vmacc.vx	v10, s6, v16
	csrr	a3, vlenb
	slli	a3, a3, 4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v10, (a3)                       # Unknown-size Folded Spill
	vmv.v.v	v10, v18
	vmacc.vx	v10, s6, v4
	csrr	a3, vlenb
	li	a4, 14
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v10, (a3)                       # Unknown-size Folded Spill
	vmv2r.v	v10, v6
	vmacc.vx	v10, s6, v4
	csrr	a3, vlenb
	li	a4, 12
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v10, (a3)                       # Unknown-size Folded Spill
	vsetvli	zero, zero, e16, m2, ta, mu
	vmul.vv	v10, v20, v2
	vmul.vv	v28, v20, v0
	vmul.vv	v12, v22, v2
	vmul.vv	v4, v22, v0
	vsrl.vx	v10, v10, a1
	csrr	a3, vlenb
	li	a4, 10
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v10, (a3)                       # Unknown-size Folded Spill
	vsrl.vx	v10, v28, a1
	csrr	a3, vlenb
	slli	a3, a3, 3
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v10, (a3)                       # Unknown-size Folded Spill
	vsrl.vx	v10, v12, a1
	csrr	a3, vlenb
	li	a4, 6
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v10, (a3)                       # Unknown-size Folded Spill
	vsrl.vx	v10, v4, a1
	csrr	a3, vlenb
	slli	a3, a3, 2
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v10, (a3)                       # Unknown-size Folded Spill
	vsetvli	zero, zero, e16, m2, tu, mu
	vmv.v.v	v14, v18
	vmacc.vx	v14, s6, v24
	vmv2r.v	v10, v6
	vmacc.vx	v10, s6, v24
	csrr	a3, vlenb
	slli	a3, a3, 1
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v10, (a3)                       # Unknown-size Folded Spill
	vmacc.vx	v18, s6, v26
	csrr	a3, vlenb
	li	a4, 20
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v18, (a3)                       # Unknown-size Folded Spill
	vmacc.vx	v6, s6, v26
	csrr	a3, vlenb
	li	a4, 54
	mul	a3, a3, a4
	add	a3, a3, sp
	addi	a3, a3, 1264
	vs2r.v	v6, (a3)                        # Unknown-size Folded Spill
	vsetvli	zero, zero, e16, m2, ta, mu
	addi	a3, sp, 1264
	vl2re8.v	v10, (a3)                       # Unknown-size Folded Reload
	vmul.vv	v24, v10, v2
	vmul.vv	v26, v10, v0
	vmul.vv	v2, v8, v2
	vmul.vv	v0, v8, v0
	add	a3, s2, t0
	slli	a4, s5, 1
	add	a4, a4, t6
	mul	a5, ra, s7
	vsrl.vx	v4, v24, a1
	vsrl.vx	v24, v26, a1
	vsrl.vx	v6, v2, a1
	vsrl.vx	v26, v0, a1
	slli	a5, a5, 1
	add	a4, a4, a5
	lw	a5, 56(sp)                      # 4-byte Folded Reload
.LBB3_9:                                # %for.body66.us.us
                                        #   Parent Loop BB3_6 Depth=1
                                        #     Parent Loop BB3_8 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vsetvli	zero, zero, e8, m1, ta, mu
	csrr	t6, vlenb
	li	s2, 44
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vloxei16.v	v0, (a3), v8
	csrr	t6, vlenb
	li	s2, 46
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vloxei16.v	v1, (a3), v8
	csrr	t6, vlenb
	li	s2, 48
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vloxei16.v	v2, (a3), v8
	csrr	t6, vlenb
	li	s2, 50
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vloxei16.v	v3, (a3), v8
	vwaddu.vx	v12, v0, zero
	vwaddu.vx	v20, v1, zero
	vwaddu.vx	v0, v2, zero
	vwaddu.vx	v22, v3, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	csrr	t6, vlenb
	li	s2, 42
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vwmulu.vv	v16, v8, v12
	vsetvli	zero, zero, e16, m2, tu, mu
	csrr	t6, vlenb
	li	s2, 40
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vwmaccu.vv	v16, v8, v20
	csrr	t6, vlenb
	li	s2, 38
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vwmaccu.vv	v16, v8, v0
	csrr	t6, vlenb
	li	s2, 36
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vwmaccu.vv	v16, v8, v22
	vsetvli	zero, zero, e16, m2, ta, mu
	vnsrl.wx	v2, v16, a1
	vsetvli	zero, zero, e8, m1, ta, mu
	csrr	t6, vlenb
	slli	t6, t6, 5
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vloxei16.v	v12, (a3), v8
	csrr	t6, vlenb
	li	s2, 30
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vloxei16.v	v13, (a3), v8
	csrr	t6, vlenb
	li	s2, 52
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vloxei16.v	v16, (a3), v8
	csrr	t6, vlenb
	li	s2, 34
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vloxei16.v	v17, (a3), v8
	vwaddu.vx	v18, v12, zero
	vwaddu.vx	v20, v13, zero
	vwaddu.vx	v12, v16, zero
	vwaddu.vx	v22, v17, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	csrr	t6, vlenb
	li	s2, 28
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vwmulu.vv	v28, v8, v18
	vsetvli	zero, zero, e16, m2, tu, mu
	csrr	t6, vlenb
	li	s2, 26
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vwmaccu.vv	v28, v8, v20
	csrr	t6, vlenb
	li	s2, 24
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vwmaccu.vv	v28, v8, v12
	csrr	t6, vlenb
	li	s2, 22
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vwmaccu.vv	v28, v8, v22
	vsetvli	zero, zero, e16, m2, ta, mu
	vnsrl.wx	v0, v28, a1
	vsetvli	zero, zero, e8, m1, ta, mu
	csrr	t6, vlenb
	li	s2, 18
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vloxei16.v	v12, (a3), v8
	csrr	t6, vlenb
	slli	t6, t6, 4
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vloxei16.v	v13, (a3), v8
	csrr	t6, vlenb
	li	s2, 14
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vloxei16.v	v16, (a3), v8
	csrr	t6, vlenb
	li	s2, 12
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vloxei16.v	v17, (a3), v8
	vwaddu.vx	v18, v12, zero
	vwaddu.vx	v20, v13, zero
	vwaddu.vx	v12, v16, zero
	vwaddu.vx	v22, v17, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	csrr	t6, vlenb
	li	s2, 10
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vwmulu.vv	v28, v8, v18
	vsetvli	zero, zero, e16, m2, tu, mu
	csrr	t6, vlenb
	slli	t6, t6, 3
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vwmaccu.vv	v28, v8, v20
	csrr	t6, vlenb
	li	s2, 6
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vwmaccu.vv	v28, v8, v12
	csrr	t6, vlenb
	slli	t6, t6, 2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vwmaccu.vv	v28, v8, v22
	vsetvli	zero, zero, e16, m2, ta, mu
	vnsrl.wx	v12, v28, a1
	vsetvli	zero, zero, e8, m1, ta, mu
	vloxei16.v	v16, (a3), v14
	csrr	t6, vlenb
	slli	t6, t6, 1
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vloxei16.v	v17, (a3), v8
	csrr	t6, vlenb
	li	s2, 20
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vloxei16.v	v18, (a3), v8
	csrr	t6, vlenb
	li	s2, 54
	mul	t6, t6, s2
	add	t6, t6, sp
	addi	t6, t6, 1264
	vl2re8.v	v8, (t6)                        # Unknown-size Folded Reload
	vloxei16.v	v19, (a3), v8
	vwaddu.vx	v20, v16, zero
	vwaddu.vx	v22, v17, zero
	vwaddu.vx	v16, v18, zero
	vwaddu.vx	v28, v19, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	vwmulu.vv	v8, v4, v20
	vsetvli	zero, zero, e16, m2, tu, mu
	vwmaccu.vv	v8, v24, v22
	vwmaccu.vv	v8, v6, v16
	vwmaccu.vv	v8, v26, v28
	vsetvli	zero, zero, e16, m2, ta, mu
	vnsrl.wx	v16, v8, a1
	vadd.vv	v8, v2, v0
	vadd.vv	v8, v8, v12
	vadd.vv	v8, v8, v16
	vsrl.vi	v8, v8, 2
	vsse16.v	v8, (a4), s0
	add	a3, a3, a2
	addi	a5, a5, -1
	add	a4, a4, s1
	bnez	a5, .LBB3_9
# %bb.10:                               # %for.cond62.for.cond.cleanup65_crit_edge.us.us
                                        #   in Loop: Header=BB3_8 Depth=2
	slli	a3, s4, 1
	add	t3, t3, a3
	add	ra, ra, s4
	sub	t2, t2, s4
	vsetvli	s4, t2, e16, m2, ta, mu
	add	t1, t1, a3
	bnez	s4, .LBB3_8
	j	.LBB3_5
.LBB3_11:                               # %for.body39.preheader
	li	a0, 0
	lw	a2, 24(sp)                      # 4-byte Folded Reload
	vsetvli	a1, a2, e16, m2, ta, mu
	bnez	a1, .LBB3_14
.LBB3_12:                               # %for.cond.cleanup48
                                        # =>This Inner Loop Header: Depth=1
	addi	a0, a0, 1
	slli	a1, a0, 16
	srli	a1, a1, 16
	lw	a2, 20(sp)                      # 4-byte Folded Reload
	bgeu	a1, a2, .LBB3_18
# %bb.13:                               # %for.body39
                                        #   in Loop: Header=BB3_12 Depth=1
	lw	a2, 24(sp)                      # 4-byte Folded Reload
	vsetvli	a1, a2, e16, m2, ta, mu
	beqz	a1, .LBB3_12
.LBB3_14:                               # %for.body49
                                        # =>This Inner Loop Header: Depth=1
	sub	a1, a2, a1
	vsetvli	a2, a1, e16, m2, ta, mu
	beqz	a2, .LBB3_12
# %bb.15:                               # %for.body49.1
                                        #   in Loop: Header=BB3_14 Depth=1
	sub	a1, a1, a2
	vsetvli	a2, a1, e16, m2, ta, mu
	beqz	a2, .LBB3_12
# %bb.16:                               # %for.body49.2
                                        #   in Loop: Header=BB3_14 Depth=1
	sub	a1, a1, a2
	vsetvli	a2, a1, e16, m2, ta, mu
	beqz	a2, .LBB3_12
# %bb.17:                               # %for.body49.3
                                        #   in Loop: Header=BB3_14 Depth=1
	sub	a2, a1, a2
	vsetvli	a1, a2, e16, m2, ta, mu
	bnez	a1, .LBB3_14
	j	.LBB3_12
.LBB3_18:                               # %for.cond.cleanup38
	csrr	a0, vlenb
	li	a1, 56
	mul	a0, a0, a1
	add	sp, sp, a0
	lw	ra, 1324(sp)                    # 4-byte Folded Reload
	lw	s0, 1320(sp)                    # 4-byte Folded Reload
	lw	s1, 1316(sp)                    # 4-byte Folded Reload
	lw	s2, 1312(sp)                    # 4-byte Folded Reload
	lw	s3, 1308(sp)                    # 4-byte Folded Reload
	lw	s4, 1304(sp)                    # 4-byte Folded Reload
	lw	s5, 1300(sp)                    # 4-byte Folded Reload
	lw	s6, 1296(sp)                    # 4-byte Folded Reload
	lw	s7, 1292(sp)                    # 4-byte Folded Reload
	lw	s8, 1288(sp)                    # 4-byte Folded Reload
	lw	s9, 1284(sp)                    # 4-byte Folded Reload
	lw	s10, 1280(sp)                   # 4-byte Folded Reload
	lw	s11, 1276(sp)                   # 4-byte Folded Reload
	addi	sp, sp, 1328
	ret
.Lfunc_end3:
	.size	psroi_pooling_align_vec, .Lfunc_end3-psroi_pooling_align_vec
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %entry
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	li	a1, 15
	lui	a0, %hi(src_arr_global)
	addi	a7, a0, %lo(src_arr_global)
	lui	a0, 88
	addi	a2, a0, 207
.LBB4_1:                                # %for.body.i
                                        # =>This Inner Loop Header: Depth=1
	addi	a0, a1, -15
	andi	a0, a0, 48
	add	a3, a1, a7
	sb	a0, -15(a3)
	addi	a0, a1, -14
	andi	a0, a0, 49
	sb	a0, -14(a3)
	addi	a0, a1, -13
	andi	a0, a0, 50
	sb	a0, -13(a3)
	addi	a0, a1, -12
	andi	a0, a0, 51
	sb	a0, -12(a3)
	addi	a0, a1, -11
	andi	a0, a0, 52
	sb	a0, -11(a3)
	addi	a0, a1, -10
	andi	a0, a0, 53
	sb	a0, -10(a3)
	addi	a0, a1, -9
	andi	a0, a0, 54
	sb	a0, -9(a3)
	addi	a0, a1, -8
	andi	a0, a0, 55
	sb	a0, -8(a3)
	addi	a0, a1, -7
	andi	a0, a0, 56
	sb	a0, -7(a3)
	addi	a0, a1, -6
	andi	a0, a0, 57
	sb	a0, -6(a3)
	addi	a0, a1, -5
	andi	a0, a0, 58
	sb	a0, -5(a3)
	addi	a0, a1, -4
	andi	a0, a0, 59
	sb	a0, -4(a3)
	addi	a0, a1, -3
	andi	a0, a0, 60
	sb	a0, -3(a3)
	addi	a0, a1, -2
	andi	a0, a0, 61
	sb	a0, -2(a3)
	addi	a0, a1, -1
	andi	a0, a0, 62
	sb	a0, -1(a3)
	andi	a0, a1, 63
	addi	a1, a1, 16
	sb	a0, 0(a3)
	bne	a1, a2, .LBB4_1
# %bb.2:                                # %for.body5.i.preheader
	lui	a0, %hi(rois_arr_global)
	addi	a6, a0, %lo(rois_arr_global)
	addi	a2, a6, 16
	lui	a0, 16
	addi	a3, a0, 1
	lui	a0, 176
	addi	a4, a0, 11
	lui	a0, 32
	addi	a5, a0, 2
	lui	a0, 256
	addi	a1, a0, 16
	lui	a0, 2
	addi	a0, a0, 1424
	add	a0, a0, a6
.LBB4_3:                                # %for.body5.i
                                        # =>This Inner Loop Header: Depth=1
	sw	a3, -16(a2)
	sw	a4, -12(a2)
	sw	a5, -8(a2)
	sw	a1, -4(a2)
	sw	a3, 0(a2)
	sw	a4, 4(a2)
	sw	a5, 8(a2)
	sw	a1, 12(a2)
	addi	a2, a2, 32
	bne	a2, a0, .LBB4_3
# %bb.4:                                # %global_arr_init.exit
	li	a0, 300
	sw	a0, 12(sp)
	li	a0, 7
	sw	a0, 16(sp)
	sw	a0, 20(sp)
	li	a0, 8
	sw	a0, 24(sp)
	li	a0, 23
	sw	a0, 28(sp)
	li	a0, 40
	sw	a0, 32(sp)
	li	a0, 2
	sh	a0, 36(sp)
	sw	a7, 0(sp)
	sw	a6, 4(sp)
	lui	a0, %hi(out_arr_global)
	addi	a0, a0, %lo(out_arr_global)
	sw	a0, 8(sp)
	#APP
	rdcycle	s0

	#NO_APP
	mv	a0, sp
	call	psroi_pooling_align_vec
	#APP
	rdcycle	a0

	#NO_APP
	sub	a1, a0, s0
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	call	printf
	li	a0, 0
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end4:
	.size	main, .Lfunc_end4-main
                                        # -- End function
	.type	src_arr_global,@object          # @src_arr_global
	.data
	.globl	src_arr_global
	.p2align	2
src_arr_global:
	.byte	8                               # 0x8
	.zero	360639
	.size	src_arr_global, 360640

	.type	rois_arr_global,@object         # @rois_arr_global
	.bss
	.globl	rois_arr_global
	.p2align	2
rois_arr_global:
	.zero	2400
	.size	rois_arr_global, 2400

	.type	out_arr_global,@object          # @out_arr_global
	.globl	out_arr_global
	.p2align	2
out_arr_global:
	.zero	235200
	.size	out_arr_global, 235200

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.4,"aMS",@progbits,1
	.p2align	2
.L.str:
	.asciz	"psroi_23x40x392x300 running cycles : %d.\n"
	.size	.L.str, 42

	.ident	"Terapines LTD zcc version 1.0.0 (https://www.terapines.com 9342a04ec5543841a5f8bc068eab6c665aba47ef)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym src_arr_global
	.addrsig_sym rois_arr_global
	.addrsig_sym out_arr_global
