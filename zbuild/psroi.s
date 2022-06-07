	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_f2p0_d2p0_c2p0_v1p0_zve32f1p0_zve32x1p0_zve64d1p0_zve64f1p0_zve64x1p0_zvl128b1p0_zvl32b1p0_zvl64b1p0"
	.option	nopic
	.file	"psroi_v1_golden.c"
	.globl	read_rdcycle                    # -- Begin function read_rdcycle
	.p2align	1
	.type	read_rdcycle,@function
read_rdcycle:                           # @read_rdcycle
# %bb.0:                                # %entry
	#APP
	csrr	a0, mcycle

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
	addi	a5, a0, %lo(rois_arr_global)
	addi	a0, a5, 16
	lui	a1, 16
	addi	a1, a1, 1
	lui	a2, 176
	addi	a2, a2, 11
	lui	a3, 32
	addi	a3, a3, 2
	lui	a4, 256
	addi	a4, a4, 16
	addi	a5, a5, 1208
	addi	a5, a5, 1208
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
	.globl	bilinear_interpolate            # -- Begin function bilinear_interpolate
	.p2align	1
	.type	bilinear_interpolate,@function
bilinear_interpolate:                   # @bilinear_interpolate
# %bb.0:                                # %entry
	sra	a6, a3, a5
	slt	a6, a6, a1
	sra	a7, a4, a5
	slt	a7, a7, a2
	and	a7, a6, a7
	li	a6, 0
	beqz	a7, .LBB3_11
# %bb.1:                                # %if.end
	bgtz	a3, .LBB3_3
# %bb.2:                                # %if.end
	li	a3, 0
.LBB3_3:                                # %if.end
	lui	a6, 16
	addi	a6, a6, -1
	and	a7, a3, a6
	bgtz	a4, .LBB3_5
# %bb.4:                                # %if.end
	li	a4, 0
.LBB3_5:                                # %if.end
	and	t1, a4, a6
	srl	t0, a7, a5
	addi	a7, a1, -1
	srl	t1, t1, a5
	bge	t0, a7, .LBB3_8
# %bb.6:                                # %if.else
	addi	a7, t0, 1
	addi	t3, a2, -1
	blt	t1, t3, .LBB3_9
.LBB3_7:                                # %if.then32
	sll	t2, t3, a5
	mv	t1, t3
	mv	a4, t2
	j	.LBB3_10
.LBB3_8:                                # %if.then22
	sll	a3, a7, a5
	mv	t0, a7
	addi	t3, a2, -1
	bge	t1, t3, .LBB3_7
.LBB3_9:                                # %if.else38
	addi	t3, t1, 1
	sll	t2, t1, a5
.LBB3_10:                               # %if.end40
	sll	a1, t0, a5
	sub	t5, a3, a1
	sub	a3, a4, t2
	li	a4, 1
	sll	a4, a4, a5
	sub	t2, a4, t5
	sub	t4, a4, a3
	mul	a4, t0, a2
	add	a1, t1, a4
	add	a1, a1, a0
	lbu	t0, 0(a1)
	add	a4, a4, t3
	add	a4, a4, a0
	lbu	t6, 0(a4)
	mul	a2, a7, a2
	add	a1, t1, a2
	add	a1, a1, a0
	lbu	a7, 0(a1)
	add	a2, a2, t3
	add	a0, a0, a2
	lbu	a0, 0(a0)
	mul	a2, t4, t2
	and	a2, a2, a6
	srl	a2, a2, a5
	mul	a4, a3, t2
	and	a4, a4, a6
	srl	a4, a4, a5
	mul	a1, t4, t5
	and	a1, a1, a6
	srl	a1, a1, a5
	mul	a3, a3, t5
	and	a3, a3, a6
	srl	a3, a3, a5
	mul	a0, a3, a0
	mul	a1, a1, a7
	mul	a3, a4, t6
	mul	a2, a2, t0
	add	a2, a2, a3
	add	a1, a1, a2
	add	a0, a0, a1
	and	a0, a0, a6
	srl	a6, a0, a5
.LBB3_11:                               # %cleanup
	mv	a0, a6
	ret
.Lfunc_end3:
	.size	bilinear_interpolate, .Lfunc_end3-bilinear_interpolate
                                        # -- End function
	.globl	psroi_align_golden              # -- Begin function psroi_align_golden
	.p2align	1
	.type	psroi_align_golden,@function
psroi_align_golden:                     # @psroi_align_golden
# %bb.0:                                # %entry
	addi	sp, sp, -144
	sw	ra, 140(sp)                     # 4-byte Folded Spill
	sw	s0, 136(sp)                     # 4-byte Folded Spill
	sw	s1, 132(sp)                     # 4-byte Folded Spill
	sw	s2, 128(sp)                     # 4-byte Folded Spill
	sw	s3, 124(sp)                     # 4-byte Folded Spill
	sw	s4, 120(sp)                     # 4-byte Folded Spill
	sw	s5, 116(sp)                     # 4-byte Folded Spill
	sw	s6, 112(sp)                     # 4-byte Folded Spill
	sw	s7, 108(sp)                     # 4-byte Folded Spill
	sw	s8, 104(sp)                     # 4-byte Folded Spill
	sw	s9, 100(sp)                     # 4-byte Folded Spill
	sw	s10, 96(sp)                     # 4-byte Folded Spill
	sw	s11, 92(sp)                     # 4-byte Folded Spill
	sw	a7, 64(sp)                      # 4-byte Folded Spill
	sw	a5, 56(sp)                      # 4-byte Folded Spill
	sw	a1, 24(sp)                      # 4-byte Folded Spill
	sw	a0, 20(sp)                      # 4-byte Folded Spill
	sw	a3, 28(sp)                      # 4-byte Folded Spill
	beqz	a3, .LBB4_39
# %bb.1:                                # %for.body.lr.ph
	lw	a0, 64(sp)                      # 4-byte Folded Reload
	beqz	a0, .LBB4_39
# %bb.2:                                # %for.body.lr.ph.split.us
	mv	t2, a2
	lw	a0, 152(sp)
	divu	a2, a4, a6
	mul	a1, a2, a6
	sub	a1, a4, a1
	andi	t4, a0, 255
	lui	a0, 16
	addi	t6, a0, -1
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	and	s0, a1, t6
	sw	a2, 16(sp)                      # 4-byte Folded Spill
	and	t5, a2, t6
	beqz	t4, .LBB4_30
# %bb.3:                                # %for.body.us.us.preheader
	lw	a0, 156(sp)
	li	s1, 0
	lw	a1, 148(sp)
	lw	a2, 144(sp)
	andi	t3, a0, 255
	li	a3, 1
	sll	s9, a3, a0
	li	a3, 256
	divu	a4, a3, a6
	sw	a4, 8(sp)                       # 4-byte Folded Spill
	lw	a4, 56(sp)                      # 4-byte Folded Reload
	divu	a3, a3, a4
	sw	a3, 4(sp)                       # 4-byte Folded Spill
	slli	a3, t4, 1
	sw	a3, 0(sp)                       # 4-byte Folded Spill
	slli	a3, a2, 16
	srai	a3, a3, 16
	sw	a3, 80(sp)                      # 4-byte Folded Spill
	addi	s7, a3, -1
	sll	a3, s7, a0
	sw	a3, 76(sp)                      # 4-byte Folded Spill
	slli	a3, a1, 16
	srai	ra, a3, 16
	mul	a1, a1, a2
	sw	a1, 36(sp)                      # 4-byte Folded Spill
	addi	s5, ra, -1
	sll	s6, s5, a0
	sw	a6, 52(sp)                      # 4-byte Folded Spill
	sw	t2, 48(sp)                      # 4-byte Folded Spill
	sw	s0, 44(sp)                      # 4-byte Folded Spill
	sw	t5, 40(sp)                      # 4-byte Folded Spill
	j	.LBB4_5
.LBB4_4:                                # %for.cond56.for.cond.cleanup59_crit_edge.split.us.us.us
                                        #   in Loop: Header=BB4_5 Depth=1
	lw	s1, 32(sp)                      # 4-byte Folded Reload
	addi	s1, s1, 1
	lw	a0, 28(sp)                      # 4-byte Folded Reload
	beq	s1, a0, .LBB4_39
.LBB4_5:                                # %for.body.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_11 Depth 2
                                        #       Child Loop BB4_13 Depth 3
                                        #         Child Loop BB4_24 Depth 4
	slli	a0, s1, 3
	lw	a1, 24(sp)                      # 4-byte Folded Reload
	add	a5, a1, a0
	lh	a7, 0(a5)
	lh	a1, 4(a5)
	sub	a1, a1, a7
	and	a3, a1, t6
	mv	a1, s9
	blt	a3, s9, .LBB4_7
# %bb.6:                                # %for.body.us.us
                                        #   in Loop: Header=BB4_5 Depth=1
	mv	a1, a3
.LBB4_7:                                # %for.body.us.us
                                        #   in Loop: Header=BB4_5 Depth=1
	lh	a3, 2(a5)
	lh	a5, 6(a5)
	sub	a5, a5, a3
	and	a5, a5, t6
	mv	a2, s9
	blt	a5, s9, .LBB4_9
# %bb.8:                                # %for.body.us.us
                                        #   in Loop: Header=BB4_5 Depth=1
	mv	a2, a5
.LBB4_9:                                # %for.body.us.us
                                        #   in Loop: Header=BB4_5 Depth=1
	li	a0, 0
	lw	a4, 8(sp)                       # 4-byte Folded Reload
	mul	a1, a1, a4
	slli	a1, a1, 16
	srli	a1, a1, 24
	lw	a4, 4(sp)                       # 4-byte Folded Reload
	mul	a5, a2, a4
	slli	a5, a5, 16
	srli	a5, a5, 24
	lw	a2, 0(sp)                       # 4-byte Folded Reload
	divu	s11, a1, a2
	divu	a2, a5, a2
	sw	a2, 88(sp)                      # 4-byte Folded Spill
	lw	a2, 16(sp)                      # 4-byte Folded Reload
	mul	a5, a5, a2
	add	a2, a5, a3
	sw	a2, 84(sp)                      # 4-byte Folded Spill
	lw	a2, 64(sp)                      # 4-byte Folded Reload
	sw	s1, 32(sp)                      # 4-byte Folded Spill
	mul	a2, s1, a2
	sw	a2, 60(sp)                      # 4-byte Folded Spill
	lw	a2, 12(sp)                      # 4-byte Folded Reload
	mul	a1, a1, a2
	add	t1, a1, a7
	li	a1, 0
	lw	s2, 20(sp)                      # 4-byte Folded Reload
	j	.LBB4_11
.LBB4_10:                               # %for.cond70.for.cond.cleanup73_crit_edge.us.us.us
                                        #   in Loop: Header=BB4_11 Depth=2
	lw	t5, 40(sp)                      # 4-byte Folded Reload
	lw	a0, 68(sp)                      # 4-byte Folded Reload
	add	a0, a0, t5
	lw	a6, 52(sp)                      # 4-byte Folded Reload
	mul	a0, a0, a6
	lw	s0, 44(sp)                      # 4-byte Folded Reload
	add	a0, a0, s0
	srli	a1, s3, 2
	slli	a0, a0, 1
	lw	t2, 48(sp)                      # 4-byte Folded Reload
	add	a0, a0, t2
	sh	a1, 0(a0)
	lw	a1, 72(sp)                      # 4-byte Folded Reload
	addi	a1, a1, 1
	lw	a0, 36(sp)                      # 4-byte Folded Reload
	add	s2, s2, a0
	lw	a0, 64(sp)                      # 4-byte Folded Reload
	beq	a1, a0, .LBB4_4
.LBB4_11:                               # %for.body60.us.us.us
                                        #   Parent Loop BB4_5 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB4_13 Depth 3
                                        #         Child Loop BB4_24 Depth 4
	li	s4, 0
	li	s3, 0
	sw	a1, 72(sp)                      # 4-byte Folded Spill
	lw	a0, 60(sp)                      # 4-byte Folded Reload
	add	a0, a0, a1
	lw	a1, 56(sp)                      # 4-byte Folded Reload
	mul	a0, a0, a1
	sw	a0, 68(sp)                      # 4-byte Folded Spill
	j	.LBB4_13
.LBB4_12:                               # %for.cond84.for.cond.cleanup87_crit_edge.us.us.us
                                        #   in Loop: Header=BB4_13 Depth=3
	addi	s4, s4, 1
	beq	s4, t4, .LBB4_10
.LBB4_13:                               # %for.body74.us.us.us
                                        #   Parent Loop BB4_5 Depth=1
                                        #     Parent Loop BB4_11 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB4_24 Depth 4
	slli	a0, s4, 1
	ori	a0, a0, 1
	lw	a1, 88(sp)                      # 4-byte Folded Reload
	mul	a0, a0, a1
	lw	a1, 84(sp)                      # 4-byte Folded Reload
	add	a0, a0, a1
	slli	a0, a0, 16
	srai	a1, a0, 16
	mv	a0, a1
	bgtz	a1, .LBB4_15
# %bb.14:                               # %for.body74.us.us.us
                                        #   in Loop: Header=BB4_13 Depth=3
	li	a0, 0
.LBB4_15:                               # %for.body74.us.us.us
                                        #   in Loop: Header=BB4_13 Depth=3
	sra	a1, a1, t3
	lw	a2, 80(sp)                      # 4-byte Folded Reload
	bge	a1, a2, .LBB4_12
# %bb.16:                               # %for.body88.us205.us.us.preheader
                                        #   in Loop: Header=BB4_13 Depth=3
	slli	a1, a0, 16
	srli	a1, a1, 16
	srl	a5, a1, t3
	slt	a3, a5, s7
	bnez	a3, .LBB4_18
# %bb.17:                               # %for.body88.us205.us.us.preheader
                                        #   in Loop: Header=BB4_13 Depth=3
	mv	s0, s7
	mv	a1, s7
	bge	s7, a5, .LBB4_19
	j	.LBB4_20
.LBB4_18:                               #   in Loop: Header=BB4_13 Depth=3
	addi	s0, a5, 1
	mv	a1, s7
	blt	s7, a5, .LBB4_20
.LBB4_19:                               # %for.body88.us205.us.us.preheader
                                        #   in Loop: Header=BB4_13 Depth=3
	mv	a1, a5
.LBB4_20:                               # %for.body88.us205.us.us.preheader
                                        #   in Loop: Header=BB4_13 Depth=3
	bnez	a3, .LBB4_22
# %bb.21:                               # %for.body88.us205.us.us.preheader
                                        #   in Loop: Header=BB4_13 Depth=3
	lw	a0, 76(sp)                      # 4-byte Folded Reload
.LBB4_22:                               # %for.body88.us205.us.us.preheader
                                        #   in Loop: Header=BB4_13 Depth=3
	li	t5, 0
	sll	a3, a1, t3
	sub	s8, a0, a3
	sub	a7, s9, s8
	mul	t2, a1, ra
	mul	t0, s0, ra
	j	.LBB4_24
.LBB4_23:                               #   in Loop: Header=BB4_24 Depth=4
	li	a1, 0
	addi	t5, t5, 1
	add	s3, s3, a1
	beq	t4, t5, .LBB4_12
.LBB4_24:                               # %for.body88.us205.us.us
                                        #   Parent Loop BB4_5 Depth=1
                                        #     Parent Loop BB4_11 Depth=2
                                        #       Parent Loop BB4_13 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	slli	a1, t5, 1
	ori	a1, a1, 1
	mul	a1, a1, s11
	add	a1, a1, t1
	slli	a1, a1, 16
	srai	a5, a1, 16
	sra	a1, a5, t3
	bge	a1, ra, .LBB4_23
# %bb.25:                               # %if.end.i.us.us.us
                                        #   in Loop: Header=BB4_24 Depth=4
	bgtz	a5, .LBB4_27
# %bb.26:                               # %if.end.i.us.us.us
                                        #   in Loop: Header=BB4_24 Depth=4
	li	a5, 0
.LBB4_27:                               # %if.end.i.us.us.us
                                        #   in Loop: Header=BB4_24 Depth=4
	slli	a1, a5, 16
	srli	a1, a1, 16
	srl	a1, a1, t3
	mv	a3, s6
	mv	s0, s5
	mv	a6, s5
	mv	s10, s6
	bge	a1, s5, .LBB4_29
# %bb.28:                               # %if.else38.i.us.us.us
                                        #   in Loop: Header=BB4_24 Depth=4
	addi	s0, a1, 1
	sll	a3, a1, t3
	mv	a6, a1
	mv	s10, a5
.LBB4_29:                               # %if.end40.i.us.us.us
                                        #   in Loop: Header=BB4_24 Depth=4
	sub	a1, s10, a3
	sub	a3, s9, a1
	add	a5, a6, t2
	add	a5, a5, s2
	lbu	a5, 0(a5)
	add	s1, s0, t2
	add	s1, s1, s2
	lbu	s1, 0(s1)
	add	a2, a6, t0
	add	a2, a2, s2
	lbu	a2, 0(a2)
	add	s0, s0, t0
	add	s0, s0, s2
	lbu	s0, 0(s0)
	mul	a0, a3, a7
	and	a0, a0, t6
	srl	a0, a0, t3
	mul	a4, a1, a7
	and	a4, a4, t6
	srl	a4, a4, t3
	mul	a3, a3, s8
	and	a3, a3, t6
	srl	a3, a3, t3
	mul	a1, a1, s8
	and	a1, a1, t6
	srl	a1, a1, t3
	mul	a1, a1, s0
	mul	a2, a3, a2
	mul	a3, a4, s1
	mul	a0, a0, a5
	add	a0, a0, a3
	add	a0, a0, a2
	add	a0, a0, a1
	and	a0, a0, t6
	srl	a1, a0, t3
	addi	t5, t5, 1
	add	s3, s3, a1
	bne	t4, t5, .LBB4_24
	j	.LBB4_12
.LBB4_30:                               # %for.body.us.preheader
	li	a0, 0
	lw	a3, 64(sp)                      # 4-byte Folded Reload
	addi	a1, a3, -1
	andi	a2, a3, 3
	sltiu	t1, a1, 3
	andi	a3, a3, -4
	seqz	a4, a2
	addi	a5, a2, -1
	seqz	t0, a5
	addi	a2, a2, -2
	seqz	a7, a2
	j	.LBB4_32
.LBB4_31:                               # %for.cond56.for.cond.cleanup59_crit_edge.split.us226
                                        #   in Loop: Header=BB4_32 Depth=1
	addi	a0, a0, 1
	lw	a1, 28(sp)                      # 4-byte Folded Reload
	beq	a0, a1, .LBB4_39
.LBB4_32:                               # %for.body.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_34 Depth 2
	li	s1, 0
	lw	a2, 64(sp)                      # 4-byte Folded Reload
	mul	a5, a0, a2
	lw	a1, 56(sp)                      # 4-byte Folded Reload
	bnez	t1, .LBB4_35
# %bb.33:                               # %for.body60.us214.preheader
                                        #   in Loop: Header=BB4_32 Depth=1
	li	s1, 0
.LBB4_34:                               # %for.body60.us214
                                        #   Parent Loop BB4_32 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	add	a2, s1, a5
	mul	a2, a2, a1
	add	a2, a2, t5
	mul	a2, a2, a6
	add	a2, a2, s0
	slli	a2, a2, 1
	add	a2, a2, t2
	sh	zero, 0(a2)
	ori	a2, s1, 1
	add	a2, a2, a5
	mul	a2, a2, a1
	add	a2, a2, t5
	mul	a2, a2, a6
	add	a2, a2, s0
	slli	a2, a2, 1
	add	a2, a2, t2
	sh	zero, 0(a2)
	ori	a2, s1, 2
	add	a2, a2, a5
	mul	a2, a2, a1
	add	a2, a2, t5
	mul	a2, a2, a6
	add	a2, a2, s0
	slli	a2, a2, 1
	add	a2, a2, t2
	sh	zero, 0(a2)
	ori	a2, s1, 3
	add	a2, a2, a5
	mul	a2, a2, a1
	add	a2, a2, t5
	mul	a2, a2, a6
	add	a2, a2, s0
	slli	a2, a2, 1
	add	a2, a2, t2
	addi	s1, s1, 4
	sh	zero, 0(a2)
	bne	a3, s1, .LBB4_34
.LBB4_35:                               # %for.cond56.for.cond.cleanup59_crit_edge.split.us226.unr-lcssa
                                        #   in Loop: Header=BB4_32 Depth=1
	bnez	a4, .LBB4_31
# %bb.36:                               # %for.body60.us214.epil
                                        #   in Loop: Header=BB4_32 Depth=1
	add	a5, a5, s1
	mul	a2, a5, a1
	add	a2, a2, t5
	mul	a2, a2, a6
	add	a2, a2, s0
	slli	a2, a2, 1
	add	a2, a2, t2
	sh	zero, 0(a2)
	bnez	t0, .LBB4_31
# %bb.37:                               # %for.body60.us214.epil.1
                                        #   in Loop: Header=BB4_32 Depth=1
	addi	a2, a5, 1
	mul	a2, a2, a1
	add	a2, a2, t5
	mul	a2, a2, a6
	add	a2, a2, s0
	slli	a2, a2, 1
	add	a2, a2, t2
	sh	zero, 0(a2)
	bnez	a7, .LBB4_31
# %bb.38:                               # %for.body60.us214.epil.2
                                        #   in Loop: Header=BB4_32 Depth=1
	addi	a2, a5, 2
	mul	a2, a2, a1
	add	a2, a2, t5
	mul	a2, a2, a6
	add	a2, a2, s0
	slli	a2, a2, 1
	add	a2, a2, t2
	sh	zero, 0(a2)
	j	.LBB4_31
.LBB4_39:                               # %for.cond.cleanup
	lw	ra, 140(sp)                     # 4-byte Folded Reload
	lw	s0, 136(sp)                     # 4-byte Folded Reload
	lw	s1, 132(sp)                     # 4-byte Folded Reload
	lw	s2, 128(sp)                     # 4-byte Folded Reload
	lw	s3, 124(sp)                     # 4-byte Folded Reload
	lw	s4, 120(sp)                     # 4-byte Folded Reload
	lw	s5, 116(sp)                     # 4-byte Folded Reload
	lw	s6, 112(sp)                     # 4-byte Folded Reload
	lw	s7, 108(sp)                     # 4-byte Folded Reload
	lw	s8, 104(sp)                     # 4-byte Folded Reload
	lw	s9, 100(sp)                     # 4-byte Folded Reload
	lw	s10, 96(sp)                     # 4-byte Folded Reload
	lw	s11, 92(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 144
	ret
.Lfunc_end4:
	.size	psroi_align_golden, .Lfunc_end4-psroi_align_golden
                                        # -- End function
	.globl	psroi_pooling_align_golden      # -- Begin function psroi_pooling_align_golden
	.p2align	1
	.type	psroi_pooling_align_golden,@function
psroi_pooling_align_golden:             # @psroi_pooling_align_golden
# %bb.0:                                # %entry
	addi	sp, sp, -80
	sw	ra, 76(sp)                      # 4-byte Folded Spill
	sw	s0, 72(sp)                      # 4-byte Folded Spill
	sw	s1, 68(sp)                      # 4-byte Folded Spill
	sw	s2, 64(sp)                      # 4-byte Folded Spill
	sw	s3, 60(sp)                      # 4-byte Folded Spill
	sw	s4, 56(sp)                      # 4-byte Folded Spill
	sw	s5, 52(sp)                      # 4-byte Folded Spill
	sw	s6, 48(sp)                      # 4-byte Folded Spill
	sw	s7, 44(sp)                      # 4-byte Folded Spill
	sw	s8, 40(sp)                      # 4-byte Folded Spill
	sw	s9, 36(sp)                      # 4-byte Folded Spill
	sw	s10, 32(sp)                     # 4-byte Folded Spill
	sw	s11, 28(sp)                     # 4-byte Folded Spill
	lw	s8, 16(a0)
	lw	s4, 20(a0)
	mul	s5, s4, s8
	beqz	s5, .LBB5_3
# %bb.1:                                # %for.body.lr.ph
	lw	a2, 4(a0)
	sw	a2, 24(sp)                      # 4-byte Folded Spill
	lw	a2, 8(a0)
	sw	a2, 20(sp)                      # 4-byte Folded Spill
	lw	s6, 12(a0)
	lw	s7, 24(a0)
	lw	s9, 28(a0)
	lw	s10, 32(a0)
	lbu	s11, 36(a0)
	lbu	s2, 37(a0)
	lw	s0, 0(a0)
	li	s1, 0
	mul	a0, s9, s7
	mul	s3, a0, s10
.LBB5_2:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	sw	s2, 12(sp)
	sw	s11, 8(sp)
	sw	s10, 4(sp)
	sw	s9, 0(sp)
	mv	a0, s0
	lw	a1, 24(sp)                      # 4-byte Folded Reload
	lw	a2, 20(sp)                      # 4-byte Folded Reload
	mv	a3, s6
	mv	a4, s1
	mv	a5, s8
	mv	a6, s4
	mv	a7, s7
	call	psroi_align_golden
	addi	s1, s1, 1
	add	s0, s0, s3
	bne	s5, s1, .LBB5_2
.LBB5_3:                                # %for.cond.cleanup
	lw	ra, 76(sp)                      # 4-byte Folded Reload
	lw	s0, 72(sp)                      # 4-byte Folded Reload
	lw	s1, 68(sp)                      # 4-byte Folded Reload
	lw	s2, 64(sp)                      # 4-byte Folded Reload
	lw	s3, 60(sp)                      # 4-byte Folded Reload
	lw	s4, 56(sp)                      # 4-byte Folded Reload
	lw	s5, 52(sp)                      # 4-byte Folded Reload
	lw	s6, 48(sp)                      # 4-byte Folded Reload
	lw	s7, 44(sp)                      # 4-byte Folded Reload
	lw	s8, 40(sp)                      # 4-byte Folded Reload
	lw	s9, 36(sp)                      # 4-byte Folded Reload
	lw	s10, 32(sp)                     # 4-byte Folded Reload
	lw	s11, 28(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 80
	ret
.Lfunc_end5:
	.size	psroi_pooling_align_golden, .Lfunc_end5-psroi_pooling_align_golden
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %entry
	addi	sp, sp, -64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	sw	s0, 56(sp)                      # 4-byte Folded Spill
	sw	s1, 52(sp)                      # 4-byte Folded Spill
	sw	s2, 48(sp)                      # 4-byte Folded Spill
	sw	s3, 44(sp)                      # 4-byte Folded Spill
	sw	s4, 40(sp)                      # 4-byte Folded Spill
	sw	s5, 36(sp)                      # 4-byte Folded Spill
	sw	s6, 32(sp)                      # 4-byte Folded Spill
	sw	s7, 28(sp)                      # 4-byte Folded Spill
	sw	s8, 24(sp)                      # 4-byte Folded Spill
	sw	s9, 20(sp)                      # 4-byte Folded Spill
	li	a0, 15
	lui	a1, %hi(src_arr_global)
	addi	s0, a1, %lo(src_arr_global)
	lui	a1, 88
	addi	a1, a1, 207
.LBB6_1:                                # %for.body.i
                                        # =>This Inner Loop Header: Depth=1
	addi	a2, a0, -15
	andi	a2, a2, 48
	add	a3, a0, s0
	sb	a2, -15(a3)
	addi	a2, a0, -14
	andi	a2, a2, 49
	sb	a2, -14(a3)
	addi	a2, a0, -13
	andi	a2, a2, 50
	sb	a2, -13(a3)
	addi	a2, a0, -12
	andi	a2, a2, 51
	sb	a2, -12(a3)
	addi	a2, a0, -11
	andi	a2, a2, 52
	sb	a2, -11(a3)
	addi	a2, a0, -10
	andi	a2, a2, 53
	sb	a2, -10(a3)
	addi	a2, a0, -9
	andi	a2, a2, 54
	sb	a2, -9(a3)
	addi	a2, a0, -8
	andi	a2, a2, 55
	sb	a2, -8(a3)
	addi	a2, a0, -7
	andi	a2, a2, 56
	sb	a2, -7(a3)
	addi	a2, a0, -6
	andi	a2, a2, 57
	sb	a2, -6(a3)
	addi	a2, a0, -5
	andi	a2, a2, 58
	sb	a2, -5(a3)
	addi	a2, a0, -4
	andi	a2, a2, 59
	sb	a2, -4(a3)
	addi	a2, a0, -3
	andi	a2, a2, 60
	sb	a2, -3(a3)
	addi	a2, a0, -2
	andi	a2, a2, 61
	sb	a2, -2(a3)
	addi	a2, a0, -1
	andi	a2, a2, 62
	sb	a2, -1(a3)
	andi	a2, a0, 63
	addi	a0, a0, 16
	sb	a2, 0(a3)
	bne	a0, a1, .LBB6_1
# %bb.2:                                # %for.body5.i.preheader
	lui	a0, %hi(rois_arr_global)
	addi	s2, a0, %lo(rois_arr_global)
	addi	a0, s2, 16
	lui	a1, 16
	addi	a1, a1, 1
	lui	a2, 176
	addi	a2, a2, 11
	lui	a3, 32
	addi	a3, a3, 2
	lui	a4, 256
	addi	a4, a4, 16
	addi	a5, s2, 1208
	addi	a5, a5, 1208
.LBB6_3:                                # %for.body5.i
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
	bne	a0, a5, .LBB6_3
# %bb.4:                                # %for.body.lr.ph.i
	li	s1, 0
	#APP
	csrr	s4, mcycle

	#NO_APP
	li	s5, 2
	li	s6, 40
	li	s7, 23
	lui	a0, %hi(out_arr_global)
	addi	s3, a0, %lo(out_arr_global)
	lui	a0, 2
	addi	s8, a0, -832
	li	s9, 49
.LBB6_5:                                # %for.body.i23
                                        # =>This Inner Loop Header: Depth=1
	sw	zero, 12(sp)
	sw	s5, 8(sp)
	sw	s6, 4(sp)
	li	a3, 300
	li	a5, 7
	li	a6, 7
	li	a7, 8
	sw	s7, 0(sp)
	mv	a0, s0
	mv	a1, s2
	mv	a2, s3
	mv	a4, s1
	call	psroi_align_golden
	addi	s1, s1, 1
	add	s0, s0, s8
	bne	s1, s9, .LBB6_5
# %bb.6:                                # %psroi_pooling_align_golden.exit
	#APP
	csrr	a0, mcycle

	#NO_APP
	sub	a1, a0, s4
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	call	printf
	li	a0, 0
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	lw	s1, 52(sp)                      # 4-byte Folded Reload
	lw	s2, 48(sp)                      # 4-byte Folded Reload
	lw	s3, 44(sp)                      # 4-byte Folded Reload
	lw	s4, 40(sp)                      # 4-byte Folded Reload
	lw	s5, 36(sp)                      # 4-byte Folded Reload
	lw	s6, 32(sp)                      # 4-byte Folded Reload
	lw	s7, 28(sp)                      # 4-byte Folded Reload
	lw	s8, 24(sp)                      # 4-byte Folded Reload
	lw	s9, 20(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
.Lfunc_end6:
	.size	main, .Lfunc_end6-main
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
