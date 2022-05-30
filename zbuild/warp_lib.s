	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_f2p0_d2p0_c2p0_v1p0_zve32f1p0_zve32x1p0_zve64d1p0_zve64f1p0_zve64x1p0_zvl128b1p0_zvl32b1p0_zvl64b1p0"
	.option	nopic
	.file	"warp.c"
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
	.globl	warp_param_read                 # -- Begin function warp_param_read
	.p2align	1
	.type	warp_param_read,@function
warp_param_read:                        # @warp_param_read
# %bb.0:                                # %entry
	lh	a2, 10(a1)
	sw	a2, 0(a0)
	lhu	a2, 8(a1)
	sw	a2, 4(a0)
	lh	a2, 14(a1)
	sw	a2, 8(a0)
	lhu	a1, 12(a1)
	sw	a1, 12(a0)
	lui	a1, %hi(src_arr_global)
	addi	a1, a1, %lo(src_arr_global)
	sw	a1, 16(a0)
	lui	a1, %hi(offset_arr_global)
	addi	a1, a1, %lo(offset_arr_global)
	sw	a1, 20(a0)
	lui	a1, %hi(out_arr_global)
	addi	a1, a1, %lo(out_arr_global)
	sw	a1, 24(a0)
	ret
.Lfunc_end1:
	.size	warp_param_read, .Lfunc_end1-warp_param_read
                                        # -- End function
	.globl	warp_vec                        # -- Begin function warp_vec
	.p2align	1
	.type	warp_vec,@function
warp_vec:                               # @warp_vec
# %bb.0:                                # %entry
	addi	sp, sp, -144
	sw	s0, 140(sp)                     # 4-byte Folded Spill
	sw	s1, 136(sp)                     # 4-byte Folded Spill
	sw	s2, 132(sp)                     # 4-byte Folded Spill
	sw	s3, 128(sp)                     # 4-byte Folded Spill
	lw	t3, 0(a0)
	lw	a6, 4(a0)
	lw	a7, 8(a0)
	lw	t5, 16(a0)
	lw	s2, 20(a0)
	lw	t6, 24(a0)
	li	a1, 7
	mv	s3, sp
	li	a2, 135
.LBB2_1:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	addi	a0, a1, -7
	add	a3, s3, a1
	sb	a0, -7(a3)
	addi	a0, a1, -6
	sb	a0, -6(a3)
	addi	a0, a1, -5
	sb	a0, -5(a3)
	addi	a0, a1, -4
	sb	a0, -4(a3)
	addi	a0, a1, -3
	sb	a0, -3(a3)
	addi	a0, a1, -2
	sb	a0, -2(a3)
	addi	a0, a1, -1
	sb	a0, -1(a3)
	sb	a1, 0(a3)
	addi	a0, a1, 1
	sb	a0, 1(a3)
	addi	a0, a1, 2
	sb	a0, 2(a3)
	addi	a0, a1, 3
	sb	a0, 3(a3)
	addi	a0, a1, 4
	sb	a0, 4(a3)
	addi	a0, a1, 5
	sb	a0, 5(a3)
	addi	a0, a1, 6
	sb	a0, 6(a3)
	addi	a0, a1, 7
	sb	a0, 7(a3)
	addi	a0, a1, 8
	addi	a1, a1, 16
	sb	a0, 8(a3)
	bne	a1, a2, .LBB2_1
# %bb.2:                                # %for.cond8.preheader
	beqz	a6, .LBB2_11
# %bb.3:                                # %for.cond13.preheader.lr.ph
	beqz	a7, .LBB2_11
# %bb.4:                                # %for.cond13.preheader.lr.ph.split
	beqz	t3, .LBB2_12
# %bb.5:                                # %for.cond13.preheader.us143.preheader
	li	t0, 0
	mul	a1, a7, a6
	neg	t1, a7
	mul	a2, t3, a6
	li	a3, 1
	sub	a2, a3, a2
	mul	t2, a7, a2
	mul	a2, t3, a7
	mul	a2, a2, a6
	neg	t4, a2
.LBB2_6:                                # %for.cond13.preheader.us143
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_7 Depth 2
                                        #       Child Loop BB2_8 Depth 3
	mv	a3, a7
.LBB2_7:                                # %for.body15.us.us
                                        #   Parent Loop BB2_6 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_8 Depth 3
	vsetvli	a5, a3, e16, m4, ta, mu
	vle16.v	v8, (s2)
	vsetvli	zero, zero, e8, m2, ta, mu
	vnsra.wi	v12, v8, 8
	vsetvli	zero, zero, e16, m4, ta, mu
	vsll.vi	v16, v8, 8
	vsetvli	zero, zero, e8, m2, ta, mu
	vle8.v	v8, (s3)
	li	a2, 0
	mv	s0, t6
	mv	s1, t5
	vnsra.wi	v10, v16, 8
	vsub.vv	v12, v8, v12
	vadd.vi	v14, v12, -1
	vmsgt.vi	v8, v12, -1
	vmsgt.vi	v9, v14, -1
	vmv.v.i	v16, 0
	mv	a4, t3
.LBB2_8:                                # %for.body20.us.us
                                        #   Parent Loop BB2_6 Depth=1
                                        #     Parent Loop BB2_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	add	a0, s1, a2
	vle8.v	v18, (a0)
	vsetvli	zero, zero, e8, m2, tu, mu
	vmv2r.v	v20, v16
	vmv1r.v	v0, v8
	vrgather.vv	v20, v18, v12, v0.t
	vmv2r.v	v22, v16
	vmv1r.v	v0, v9
	vrgather.vv	v22, v18, v14, v0.t
	vsetvli	zero, zero, e16, m4, ta, mu
	vsext.vf2	v24, v20
	vsll.vi	v24, v24, 8
	vsetvli	zero, zero, e8, m2, ta, mu
	vsub.vv	v18, v22, v20
	vsetvli	zero, zero, e8, m2, tu, mu
	vwmacc.vv	v24, v18, v10
	vsetvli	zero, zero, e8, m2, ta, mu
	vnsra.wi	v18, v24, 8
	add	a0, s0, a2
	vse8.v	v18, (a0)
	addi	a4, a4, -1
	add	a2, a2, a1
	bnez	a4, .LBB2_8
# %bb.9:                                # %for.cond16.for.cond.cleanup19_crit_edge.us.us
                                        #   in Loop: Header=BB2_7 Depth=2
	add	a0, s1, t4
	add	t5, a0, a2
	add	a0, s0, t4
	add	t6, a0, a2
	add	s3, s3, a5
	slli	a0, a5, 1
	sub	a3, a3, a5
	add	s2, s2, a0
	bnez	a3, .LBB2_7
# %bb.10:                               # %for.cond13.for.cond.cleanup14_crit_edge.split.us.us
                                        #   in Loop: Header=BB2_6 Depth=1
	add	a0, s1, t2
	add	t5, a0, a2
	add	a0, s0, t2
	add	t6, a0, a2
	addi	t0, t0, 1
	add	s3, s3, t1
	bne	t0, a6, .LBB2_6
.LBB2_11:                               # %for.cond.cleanup11
	lw	s0, 140(sp)                     # 4-byte Folded Reload
	lw	s1, 136(sp)                     # 4-byte Folded Reload
	lw	s2, 132(sp)                     # 4-byte Folded Reload
	lw	s3, 128(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 144
	ret
.LBB2_12:                               # %for.cond13.preheader.preheader
	addi	a1, a6, -1
	li	a2, 3
	andi	a0, a6, 3
	bgeu	a1, a2, .LBB2_30
.LBB2_13:                               # %for.cond.cleanup11.loopexit.unr-lcssa
	beqz	a0, .LBB2_11
# %bb.14:                               # %for.body15.epil.preheader
	mv	a1, a7
.LBB2_15:                               # %for.body15.epil
                                        # =>This Inner Loop Header: Depth=1
	vsetvli	a2, a1, e8, m2, ta, mu
	sub	a1, a1, a2
	beqz	a1, .LBB2_19
# %bb.16:                               # %for.body15.1.epil
                                        #   in Loop: Header=BB2_15 Depth=1
	vsetvli	a2, a1, e8, m2, ta, mu
	sub	a1, a1, a2
	beqz	a1, .LBB2_19
# %bb.17:                               # %for.body15.2.epil
                                        #   in Loop: Header=BB2_15 Depth=1
	vsetvli	a2, a1, e8, m2, ta, mu
	sub	a1, a1, a2
	beqz	a1, .LBB2_19
# %bb.18:                               # %for.body15.3.epil
                                        #   in Loop: Header=BB2_15 Depth=1
	vsetvli	a2, a1, e8, m2, ta, mu
	sub	a1, a1, a2
	bnez	a1, .LBB2_15
.LBB2_19:                               # %for.cond13.for.cond.cleanup14_crit_edge.split.epil
	li	a1, 1
	beq	a0, a1, .LBB2_11
# %bb.20:                               # %for.body15.epil.1.preheader
	mv	a1, a7
.LBB2_21:                               # %for.body15.epil.1
                                        # =>This Inner Loop Header: Depth=1
	vsetvli	a2, a1, e8, m2, ta, mu
	sub	a1, a1, a2
	beqz	a1, .LBB2_25
# %bb.22:                               # %for.body15.1.epil.1
                                        #   in Loop: Header=BB2_21 Depth=1
	vsetvli	a2, a1, e8, m2, ta, mu
	sub	a1, a1, a2
	beqz	a1, .LBB2_25
# %bb.23:                               # %for.body15.2.epil.1
                                        #   in Loop: Header=BB2_21 Depth=1
	vsetvli	a2, a1, e8, m2, ta, mu
	sub	a1, a1, a2
	beqz	a1, .LBB2_25
# %bb.24:                               # %for.body15.3.epil.1
                                        #   in Loop: Header=BB2_21 Depth=1
	vsetvli	a2, a1, e8, m2, ta, mu
	sub	a1, a1, a2
	bnez	a1, .LBB2_21
.LBB2_25:                               # %for.cond13.for.cond.cleanup14_crit_edge.split.epil.1
	li	a1, 2
	beq	a0, a1, .LBB2_11
.LBB2_26:                               # %for.body15.epil.2
                                        # =>This Inner Loop Header: Depth=1
	vsetvli	a0, a7, e8, m2, ta, mu
	sub	a0, a7, a0
	beqz	a0, .LBB2_11
# %bb.27:                               # %for.body15.1.epil.2
                                        #   in Loop: Header=BB2_26 Depth=1
	vsetvli	a1, a0, e8, m2, ta, mu
	sub	a0, a0, a1
	beqz	a0, .LBB2_11
# %bb.28:                               # %for.body15.2.epil.2
                                        #   in Loop: Header=BB2_26 Depth=1
	vsetvli	a1, a0, e8, m2, ta, mu
	sub	a0, a0, a1
	beqz	a0, .LBB2_11
# %bb.29:                               # %for.body15.3.epil.2
                                        #   in Loop: Header=BB2_26 Depth=1
	vsetvli	a1, a0, e8, m2, ta, mu
	sub	a7, a0, a1
	bnez	a7, .LBB2_26
	j	.LBB2_11
.LBB2_30:                               # %for.cond13.preheader.preheader.new
	li	a2, 0
	andi	a3, a6, -4
	j	.LBB2_32
.LBB2_31:                               # %for.cond13.for.cond.cleanup14_crit_edge.split.3
                                        #   in Loop: Header=BB2_32 Depth=1
	addi	a2, a2, 4
	beq	a2, a3, .LBB2_13
.LBB2_32:                               # %for.cond13.preheader
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_33 Depth 2
                                        #     Child Loop BB2_38 Depth 2
                                        #     Child Loop BB2_43 Depth 2
                                        #     Child Loop BB2_48 Depth 2
	mv	a1, a7
.LBB2_33:                               # %for.body15
                                        #   Parent Loop BB2_32 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vsetvli	a4, a1, e8, m2, ta, mu
	sub	a1, a1, a4
	beqz	a1, .LBB2_37
# %bb.34:                               # %for.body15.1
                                        #   in Loop: Header=BB2_33 Depth=2
	vsetvli	a4, a1, e8, m2, ta, mu
	sub	a1, a1, a4
	beqz	a1, .LBB2_37
# %bb.35:                               # %for.body15.2
                                        #   in Loop: Header=BB2_33 Depth=2
	vsetvli	a4, a1, e8, m2, ta, mu
	sub	a1, a1, a4
	beqz	a1, .LBB2_37
# %bb.36:                               # %for.body15.3
                                        #   in Loop: Header=BB2_33 Depth=2
	vsetvli	a4, a1, e8, m2, ta, mu
	sub	a1, a1, a4
	bnez	a1, .LBB2_33
.LBB2_37:                               # %for.cond13.for.cond.cleanup14_crit_edge.split
                                        #   in Loop: Header=BB2_32 Depth=1
	mv	a1, a7
.LBB2_38:                               # %for.body15.1166
                                        #   Parent Loop BB2_32 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vsetvli	a4, a1, e8, m2, ta, mu
	sub	a1, a1, a4
	beqz	a1, .LBB2_42
# %bb.39:                               # %for.body15.1.1
                                        #   in Loop: Header=BB2_38 Depth=2
	vsetvli	a4, a1, e8, m2, ta, mu
	sub	a1, a1, a4
	beqz	a1, .LBB2_42
# %bb.40:                               # %for.body15.2.1
                                        #   in Loop: Header=BB2_38 Depth=2
	vsetvli	a4, a1, e8, m2, ta, mu
	sub	a1, a1, a4
	beqz	a1, .LBB2_42
# %bb.41:                               # %for.body15.3.1
                                        #   in Loop: Header=BB2_38 Depth=2
	vsetvli	a4, a1, e8, m2, ta, mu
	sub	a1, a1, a4
	bnez	a1, .LBB2_38
.LBB2_42:                               # %for.cond13.for.cond.cleanup14_crit_edge.split.1
                                        #   in Loop: Header=BB2_32 Depth=1
	mv	a1, a7
.LBB2_43:                               # %for.body15.2169
                                        #   Parent Loop BB2_32 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vsetvli	a4, a1, e8, m2, ta, mu
	sub	a1, a1, a4
	beqz	a1, .LBB2_47
# %bb.44:                               # %for.body15.1.2
                                        #   in Loop: Header=BB2_43 Depth=2
	vsetvli	a4, a1, e8, m2, ta, mu
	sub	a1, a1, a4
	beqz	a1, .LBB2_47
# %bb.45:                               # %for.body15.2.2
                                        #   in Loop: Header=BB2_43 Depth=2
	vsetvli	a4, a1, e8, m2, ta, mu
	sub	a1, a1, a4
	beqz	a1, .LBB2_47
# %bb.46:                               # %for.body15.3.2
                                        #   in Loop: Header=BB2_43 Depth=2
	vsetvli	a4, a1, e8, m2, ta, mu
	sub	a1, a1, a4
	bnez	a1, .LBB2_43
.LBB2_47:                               # %for.cond13.for.cond.cleanup14_crit_edge.split.2
                                        #   in Loop: Header=BB2_32 Depth=1
	mv	a1, a7
.LBB2_48:                               # %for.body15.3172
                                        #   Parent Loop BB2_32 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vsetvli	a4, a1, e8, m2, ta, mu
	sub	a1, a1, a4
	beqz	a1, .LBB2_31
# %bb.49:                               # %for.body15.1.3
                                        #   in Loop: Header=BB2_48 Depth=2
	vsetvli	a4, a1, e8, m2, ta, mu
	sub	a1, a1, a4
	beqz	a1, .LBB2_31
# %bb.50:                               # %for.body15.2.3
                                        #   in Loop: Header=BB2_48 Depth=2
	vsetvli	a4, a1, e8, m2, ta, mu
	sub	a1, a1, a4
	beqz	a1, .LBB2_31
# %bb.51:                               # %for.body15.3.3
                                        #   in Loop: Header=BB2_48 Depth=2
	vsetvli	a4, a1, e8, m2, ta, mu
	sub	a1, a1, a4
	bnez	a1, .LBB2_48
	j	.LBB2_31
.Lfunc_end2:
	.size	warp_vec, .Lfunc_end2-warp_vec
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %entry
	addi	sp, sp, -144
	sw	ra, 140(sp)                     # 4-byte Folded Spill
	#APP
	rdcycle	a6

	#NO_APP
	li	a0, 7
	addi	t3, sp, 12
	li	a1, 135
.LBB3_1:                                # %for.body.i
                                        # =>This Inner Loop Header: Depth=1
	addi	a2, a0, -7
	add	a3, t3, a0
	sb	a2, -7(a3)
	addi	a2, a0, -6
	sb	a2, -6(a3)
	addi	a2, a0, -5
	sb	a2, -5(a3)
	addi	a2, a0, -4
	sb	a2, -4(a3)
	addi	a2, a0, -3
	sb	a2, -3(a3)
	addi	a2, a0, -2
	sb	a2, -2(a3)
	addi	a2, a0, -1
	sb	a2, -1(a3)
	sb	a0, 0(a3)
	addi	a2, a0, 1
	sb	a2, 1(a3)
	addi	a2, a0, 2
	sb	a2, 2(a3)
	addi	a2, a0, 3
	sb	a2, 3(a3)
	addi	a2, a0, 4
	sb	a2, 4(a3)
	addi	a2, a0, 5
	sb	a2, 5(a3)
	addi	a2, a0, 6
	sb	a2, 6(a3)
	addi	a2, a0, 7
	sb	a2, 7(a3)
	addi	a2, a0, 8
	addi	a0, a0, 16
	sb	a2, 8(a3)
	bne	a0, a1, .LBB3_1
# %bb.2:                                # %for.cond13.preheader.us143.i.preheader
	li	t1, 0
	lui	a0, %hi(out_arr_global)
	addi	t4, a0, %lo(out_arr_global)
	lui	a0, %hi(offset_arr_global)
	addi	a3, a0, %lo(offset_arr_global)
	lui	a0, %hi(src_arr_global)
	addi	t5, a0, %lo(src_arr_global)
	lui	a0, 2
	addi	a4, a0, 1664
	lui	a0, 1048436
	addi	t2, a0, 1792
	addi	t0, a0, 1880
	li	a7, 112
.LBB3_3:                                # %for.cond13.preheader.us143.i
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_4 Depth 2
                                        #       Child Loop BB3_5 Depth 3
	li	a0, 88
.LBB3_4:                                # %for.body15.us.us.i
                                        #   Parent Loop BB3_3 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_5 Depth 3
	vsetvli	t6, a0, e16, m4, ta, mu
	vle16.v	v8, (a3)
	vsetvli	zero, zero, e8, m2, ta, mu
	vnsra.wi	v12, v8, 8
	vsetvli	zero, zero, e16, m4, ta, mu
	vsll.vi	v16, v8, 8
	vsetvli	zero, zero, e8, m2, ta, mu
	vle8.v	v8, (t3)
	vnsra.wi	v10, v16, 8
	vsub.vv	v12, v8, v12
	vadd.vi	v14, v12, -1
	vmsgt.vi	v8, v12, -1
	vmsgt.vi	v9, v14, -1
	vmv.v.i	v16, 0
	li	a1, 58
	mv	a5, t5
	mv	a2, t4
.LBB3_5:                                # %for.body20.us.us.i
                                        #   Parent Loop BB3_3 Depth=1
                                        #     Parent Loop BB3_4 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vle8.v	v18, (a5)
	vsetvli	zero, zero, e8, m2, tu, mu
	vmv2r.v	v20, v16
	vmv1r.v	v0, v8
	vrgather.vv	v20, v18, v12, v0.t
	vmv2r.v	v22, v16
	vmv1r.v	v0, v9
	vrgather.vv	v22, v18, v14, v0.t
	vsetvli	zero, zero, e16, m4, ta, mu
	vsext.vf2	v24, v20
	vsll.vi	v24, v24, 8
	vsetvli	zero, zero, e8, m2, ta, mu
	vsub.vv	v18, v22, v20
	vsetvli	zero, zero, e8, m2, tu, mu
	vwmacc.vv	v24, v18, v10
	vsetvli	zero, zero, e8, m2, ta, mu
	vnsra.wi	v18, v24, 8
	vse8.v	v18, (a2)
	add	a5, a5, a4
	addi	a1, a1, -1
	add	a2, a2, a4
	bnez	a1, .LBB3_5
# %bb.6:                                # %for.cond16.for.cond.cleanup19_crit_edge.us.us.i
                                        #   in Loop: Header=BB3_4 Depth=2
	add	t5, a5, t2
	add	t4, a2, t2
	add	t3, t3, t6
	slli	a1, t6, 1
	sub	a0, a0, t6
	add	a3, a3, a1
	bnez	a0, .LBB3_4
# %bb.7:                                # %for.cond13.for.cond.cleanup14_crit_edge.split.us.us.i
                                        #   in Loop: Header=BB3_3 Depth=1
	add	t5, a5, t0
	add	t4, a2, t0
	addi	t1, t1, 1
	addi	t3, t3, -88
	bne	t1, a7, .LBB3_3
# %bb.8:                                # %warp_vec.exit
	#APP
	rdcycle	a0

	#NO_APP
	sub	a1, a0, a6
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	call	printf
	li	a0, 0
	lw	ra, 140(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 144
	ret
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
                                        # -- End function
	.type	src_arr_global,@object          # @src_arr_global
	.data
	.globl	src_arr_global
	.p2align	2
src_arr_global:
	.byte	2                               # 0x2
	.zero	571647
	.size	src_arr_global, 571648

	.type	offset_arr_global,@object       # @offset_arr_global
	.globl	offset_arr_global
	.p2align	2
offset_arr_global:
	.half	256                             # 0x100
	.zero	19710
	.size	offset_arr_global, 19712

	.type	out_arr_global,@object          # @out_arr_global
	.bss
	.globl	out_arr_global
	.p2align	2
out_arr_global:
	.zero	571648
	.size	out_arr_global, 571648

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.4,"aMS",@progbits,1
	.p2align	2
.L.str:
	.asciz	"warp_58x112x88 running cycles : %d.\n"
	.size	.L.str, 37

	.ident	"Terapines LTD zcc version 1.0.0 (https://www.terapines.com 9342a04ec5543841a5f8bc068eab6c665aba47ef)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym src_arr_global
	.addrsig_sym offset_arr_global
	.addrsig_sym out_arr_global
