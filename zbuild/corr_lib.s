	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_f2p0_d2p0_c2p0_v1p0_zve32f1p0_zve32x1p0_zve64d1p0_zve64f1p0_zve64x1p0_zvl128b1p0_zvl32b1p0_zvl64b1p0"
	.option	nopic
	.file	"correlation.c"
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
	.globl	correlation_param_read          # -- Begin function correlation_param_read
	.p2align	1
	.type	correlation_param_read,@function
correlation_param_read:                 # @correlation_param_read
# %bb.0:                                # %entry
	lh	a2, 10(a1)
	sw	a2, 0(a0)
	lhu	a2, 8(a1)
	sw	a2, 4(a0)
	lh	a2, 14(a1)
	sw	a2, 8(a0)
	lhu	a2, 12(a1)
	sw	a2, 12(a0)
	lhu	a1, 16(a1)
	sw	a1, 16(a0)
	lui	a1, %hi(src0_arr_global)
	addi	a1, a1, %lo(src0_arr_global)
	sw	a1, 20(a0)
	lui	a1, %hi(src1_arr_global)
	addi	a1, a1, %lo(src1_arr_global)
	sw	a1, 24(a0)
	lui	a1, %hi(out_arr_global)
	addi	a1, a1, %lo(out_arr_global)
	sw	a1, 28(a0)
	ret
.Lfunc_end1:
	.size	correlation_param_read, .Lfunc_end1-correlation_param_read
                                        # -- End function
	.globl	correlation_vec                 # -- Begin function correlation_vec
	.p2align	1
	.type	correlation_vec,@function
correlation_vec:                        # @correlation_vec
# %bb.0:                                # %entry
	addi	sp, sp, -32
	sw	s0, 28(sp)                      # 4-byte Folded Spill
	sw	s1, 24(sp)                      # 4-byte Folded Spill
	sw	s2, 20(sp)                      # 4-byte Folded Spill
	sw	s3, 16(sp)                      # 4-byte Folded Spill
	sw	s4, 12(sp)                      # 4-byte Folded Spill
	sw	s5, 8(sp)                       # 4-byte Folded Spill
	lw	t0, 8(a0)
	vsetvli	a6, t0, e8, m2, ta, mu
	beqz	a6, .LBB2_26
# %bb.1:                                # %for.cond9.preheader.lr.ph
	lw	a7, 4(a0)
	beqz	a7, .LBB2_15
# %bb.2:                                # %for.cond9.preheader.lr.ph.split.us
	lw	t3, 12(a0)
	beqz	t3, .LBB2_19
# %bb.3:                                # %for.cond9.preheader.lr.ph.split.us.split.us
	lw	s2, 0(a0)
	lw	s3, 16(a0)
	lw	t5, 28(a0)
	seqz	a1, s2
	mul	a3, t0, a7
	bnez	a1, .LBB2_20
# %bb.4:                                # %for.cond9.preheader.us.us.us.preheader
	lw	t1, 20(a0)
	lw	t2, 24(a0)
	li	s5, 0
	mv	s4, t0
.LBB2_5:                                # %for.cond9.preheader.us.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_6 Depth 2
                                        #       Child Loop BB2_7 Depth 3
                                        #         Child Loop BB2_8 Depth 4
	li	t4, 0
	mv	a2, t2
	mv	t6, t1
.LBB2_6:                                # %for.cond12.preheader.us.us.us.us.us
                                        #   Parent Loop BB2_5 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_7 Depth 3
                                        #         Child Loop BB2_8 Depth 4
	li	s0, 0
	mul	a0, t4, t0
	add	s1, a0, s5
	mv	a1, t6
.LBB2_7:                                # %for.body15.us.us.us.us.us.us
                                        #   Parent Loop BB2_5 Depth=1
                                        #     Parent Loop BB2_6 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_8 Depth 4
	sub	a0, s4, s0
	vsetvli	a0, a0, e16, m4, ta, mu
	vmv.v.i	v8, 0
	mv	a5, s2
	mv	a0, s5
.LBB2_8:                                # %for.body29.us.us.us.us.us.us
                                        #   Parent Loop BB2_5 Depth=1
                                        #     Parent Loop BB2_6 Depth=2
                                        #       Parent Loop BB2_7 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	add	a4, a1, a0
	vsetvli	zero, zero, e8, m2, ta, mu
	vle8.v	v12, (a4)
	add	a4, a2, a0
	vle8.v	v14, (a4)
	vsetvli	zero, zero, e8, m2, tu, mu
	vwmacc.vv	v8, v14, v12
	addi	a5, a5, -1
	add	a0, a0, a3
	bnez	a5, .LBB2_8
# %bb.9:                                # %for.cond26.for.cond.cleanup28_crit_edge.us.us.us.us.us.us
                                        #   in Loop: Header=BB2_7 Depth=3
	mul	a0, s0, a3
	add	a0, a0, s1
	add	a0, a0, t5
	vsetvli	zero, zero, e8, m2, ta, mu
	vnsra.wx	v12, v8, s3
	add	a0, a0, s0
	vse8.v	v12, (a0)
	addi	s0, s0, 1
	addi	a1, a1, 1
	bne	s0, t3, .LBB2_7
# %bb.10:                               # %for.cond12.for.cond.cleanup14_crit_edge.split.us.us.us.us.us.us
                                        #   in Loop: Header=BB2_6 Depth=2
	addi	t4, t4, 1
	add	t6, t6, t0
	add	a2, a2, t0
	bne	t4, a7, .LBB2_6
# %bb.11:                               # %for.cond9.for.cond.cleanup10_crit_edge.split.us.split.us.us.us.us
                                        #   in Loop: Header=BB2_5 Depth=1
	add	s5, s5, a6
	sub	s4, s4, a6
	vsetvli	a6, s4, e8, m2, ta, mu
	bnez	a6, .LBB2_5
	j	.LBB2_26
.LBB2_12:                               # %for.cond9.preheader.1
                                        #   in Loop: Header=BB2_15 Depth=1
	sub	a0, a0, a1
	vsetvli	a1, a0, e8, m2, ta, mu
	beqz	a1, .LBB2_26
# %bb.13:                               # %for.cond9.preheader.2
                                        #   in Loop: Header=BB2_15 Depth=1
	sub	a0, a0, a1
	vsetvli	a1, a0, e8, m2, ta, mu
	beqz	a1, .LBB2_26
# %bb.14:                               # %for.cond9.preheader.3
                                        #   in Loop: Header=BB2_15 Depth=1
	sub	t0, a0, a1
	vsetvli	a6, t0, e8, m2, ta, mu
	beqz	a6, .LBB2_26
.LBB2_15:                               # %for.cond9.preheader
                                        # =>This Inner Loop Header: Depth=1
	sub	a0, t0, a6
	vsetvli	a1, a0, e8, m2, ta, mu
	bnez	a1, .LBB2_12
	j	.LBB2_26
.LBB2_16:                               # %for.cond9.preheader.us.1
                                        #   in Loop: Header=BB2_19 Depth=1
	sub	a0, a0, a1
	vsetvli	a1, a0, e8, m2, ta, mu
	beqz	a1, .LBB2_26
# %bb.17:                               # %for.cond9.preheader.us.2
                                        #   in Loop: Header=BB2_19 Depth=1
	sub	a0, a0, a1
	vsetvli	a1, a0, e8, m2, ta, mu
	beqz	a1, .LBB2_26
# %bb.18:                               # %for.cond9.preheader.us.3
                                        #   in Loop: Header=BB2_19 Depth=1
	sub	t0, a0, a1
	vsetvli	a6, t0, e8, m2, ta, mu
	beqz	a6, .LBB2_26
.LBB2_19:                               # %for.cond9.preheader.us
                                        # =>This Inner Loop Header: Depth=1
	sub	a0, t0, a6
	vsetvli	a1, a0, e8, m2, ta, mu
	bnez	a1, .LBB2_16
	j	.LBB2_26
.LBB2_20:                               # %for.cond9.preheader.us.us.preheader
	li	t1, 0
	addi	a1, a3, 1
	mv	a2, t0
.LBB2_21:                               # %for.cond9.preheader.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_22 Depth 2
                                        #       Child Loop BB2_23 Depth 3
	li	a3, 0
	add	s1, t5, t1
.LBB2_22:                               # %for.cond12.preheader.us.us138.us
                                        #   Parent Loop BB2_21 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_23 Depth 3
	mv	a5, a2
	mv	a4, s1
	mv	s0, t3
.LBB2_23:                               # %for.body15.us112.us.us
                                        #   Parent Loop BB2_21 Depth=1
                                        #     Parent Loop BB2_22 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vsetvli	a0, a5, e16, m4, ta, mu
	vmv.v.i	v8, 0
	vsetvli	zero, zero, e8, m2, ta, mu
	vnsra.wx	v12, v8, s3
	vse8.v	v12, (a4)
	addi	s0, s0, -1
	add	a4, a4, a1
	addi	a5, a5, -1
	bnez	s0, .LBB2_23
# %bb.24:                               # %for.cond12.for.cond.cleanup14_crit_edge.split.us121.us.us
                                        #   in Loop: Header=BB2_22 Depth=2
	addi	a3, a3, 1
	add	s1, s1, t0
	bne	a3, a7, .LBB2_22
# %bb.25:                               # %for.cond9.for.cond.cleanup10_crit_edge.split.us.split.us144.us
                                        #   in Loop: Header=BB2_21 Depth=1
	add	t1, t1, a6
	sub	a2, a2, a6
	vsetvli	a6, a2, e8, m2, ta, mu
	bnez	a6, .LBB2_21
.LBB2_26:                               # %for.cond.cleanup
	lw	s0, 28(sp)                      # 4-byte Folded Reload
	lw	s1, 24(sp)                      # 4-byte Folded Reload
	lw	s2, 20(sp)                      # 4-byte Folded Reload
	lw	s3, 16(sp)                      # 4-byte Folded Reload
	lw	s4, 12(sp)                      # 4-byte Folded Reload
	lw	s5, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end2:
	.size	correlation_vec, .Lfunc_end2-correlation_vec
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %entry
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	sw	s1, 36(sp)                      # 4-byte Folded Spill
	sw	s2, 32(sp)                      # 4-byte Folded Spill
	sw	s3, 28(sp)                      # 4-byte Folded Spill
	sw	s4, 24(sp)                      # 4-byte Folded Spill
	sw	s5, 20(sp)                      # 4-byte Folded Spill
	sw	s6, 16(sp)                      # 4-byte Folded Spill
	sw	s7, 12(sp)                      # 4-byte Folded Spill
	sw	s8, 8(sp)                       # 4-byte Folded Spill
	sw	s9, 4(sp)                       # 4-byte Folded Spill
	#APP
	rdcycle	a6

	#NO_APP
	li	t0, 88
	vsetvli	a7, t0, e8, m2, ta, mu
	beqz	a7, .LBB3_15
# %bb.1:                                # %for.cond9.preheader.us.us.us.i.preheader
	li	s7, 0
	lui	a0, %hi(src1_arr_global)
	addi	t1, a0, %lo(src1_arr_global)
	lui	a0, %hi(src0_arr_global)
	addi	s9, a0, %lo(src0_arr_global)
	lui	a1, 2
	addi	a0, a1, 1664
	lui	a2, %hi(out_arr_global)
	addi	t2, a2, %lo(out_arr_global)
	addi	t3, a1, 1665
	lui	a1, 5
	addi	t5, a1, -766
	lui	a1, 7
	addi	t6, a1, 899
	lui	a1, 10
	addi	s2, a1, -1532
	li	t4, 112
	li	s8, 88
.LBB3_2:                                # %for.cond9.preheader.us.us.us.i
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_3 Depth 2
                                        #       Child Loop BB3_4 Depth 3
                                        #       Child Loop BB3_6 Depth 3
                                        #       Child Loop BB3_8 Depth 3
                                        #       Child Loop BB3_10 Depth 3
                                        #       Child Loop BB3_12 Depth 3
	li	a2, 0
	addi	s3, s8, -1
	addi	s4, s8, -2
	addi	s5, s8, -3
	addi	s6, s8, -4
.LBB3_3:                                # %for.cond12.preheader.us.us.us.us.us.i
                                        #   Parent Loop BB3_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_4 Depth 3
                                        #       Child Loop BB3_6 Depth 3
                                        #       Child Loop BB3_8 Depth 3
                                        #       Child Loop BB3_10 Depth 3
                                        #       Child Loop BB3_12 Depth 3
	mul	a1, a2, t0
	add	s0, a1, s7
	add	a5, s0, t1
	add	a1, s0, s9
	vsetvli	a3, s8, e16, m4, ta, mu
	vmv.v.i	v8, 0
	li	a3, 58
	mv	a4, a5
.LBB3_4:                                # %for.body29.us.us.us.us.us.us.i
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_3 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vsetvli	zero, zero, e8, m2, ta, mu
	vle8.v	v12, (a1)
	vle8.v	v14, (a4)
	vsetvli	zero, zero, e8, m2, tu, mu
	vwmacc.vv	v8, v14, v12
	add	a1, a1, a0
	addi	a3, a3, -1
	add	a4, a4, a0
	bnez	a3, .LBB3_4
# %bb.5:                                # %for.cond26.for.cond.cleanup28_crit_edge.us.us.us.us.us.us.i
                                        #   in Loop: Header=BB3_3 Depth=2
	add	a1, s0, t2
	vsetvli	zero, zero, e8, m2, ta, mu
	vnsra.wi	v12, v8, 0
	vse8.v	v12, (a1)
	add	s0, s0, s9
	addi	a3, s0, 1
	vsetvli	a4, s3, e16, m4, ta, mu
	vmv.v.i	v8, 0
	li	a4, 58
	mv	s1, a5
.LBB3_6:                                # %for.body29.us.us.us.us.us.us.i.1
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_3 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vsetvli	zero, zero, e8, m2, ta, mu
	vle8.v	v12, (a3)
	vle8.v	v14, (s1)
	vsetvli	zero, zero, e8, m2, tu, mu
	vwmacc.vv	v8, v14, v12
	add	a3, a3, a0
	addi	a4, a4, -1
	add	s1, s1, a0
	bnez	a4, .LBB3_6
# %bb.7:                                # %for.cond26.for.cond.cleanup28_crit_edge.us.us.us.us.us.us.i.1
                                        #   in Loop: Header=BB3_3 Depth=2
	vsetvli	zero, zero, e8, m2, ta, mu
	vnsra.wi	v12, v8, 0
	add	a3, a1, t3
	vse8.v	v12, (a3)
	addi	a3, s0, 2
	vsetvli	a4, s4, e16, m4, ta, mu
	vmv.v.i	v8, 0
	li	a4, 58
	mv	s1, a5
.LBB3_8:                                # %for.body29.us.us.us.us.us.us.i.2
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_3 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vsetvli	zero, zero, e8, m2, ta, mu
	vle8.v	v12, (a3)
	vle8.v	v14, (s1)
	vsetvli	zero, zero, e8, m2, tu, mu
	vwmacc.vv	v8, v14, v12
	add	a3, a3, a0
	addi	a4, a4, -1
	add	s1, s1, a0
	bnez	a4, .LBB3_8
# %bb.9:                                # %for.cond26.for.cond.cleanup28_crit_edge.us.us.us.us.us.us.i.2
                                        #   in Loop: Header=BB3_3 Depth=2
	vsetvli	zero, zero, e8, m2, ta, mu
	vnsra.wi	v12, v8, 0
	add	a3, a1, t5
	vse8.v	v12, (a3)
	addi	a3, s0, 3
	vsetvli	a4, s5, e16, m4, ta, mu
	vmv.v.i	v8, 0
	li	a4, 58
	mv	s1, a5
.LBB3_10:                               # %for.body29.us.us.us.us.us.us.i.3
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_3 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vsetvli	zero, zero, e8, m2, ta, mu
	vle8.v	v12, (a3)
	vle8.v	v14, (s1)
	vsetvli	zero, zero, e8, m2, tu, mu
	vwmacc.vv	v8, v14, v12
	add	a3, a3, a0
	addi	a4, a4, -1
	add	s1, s1, a0
	bnez	a4, .LBB3_10
# %bb.11:                               # %for.cond26.for.cond.cleanup28_crit_edge.us.us.us.us.us.us.i.3
                                        #   in Loop: Header=BB3_3 Depth=2
	vsetvli	zero, zero, e8, m2, ta, mu
	vnsra.wi	v12, v8, 0
	add	a3, a1, t6
	vse8.v	v12, (a3)
	addi	a3, s0, 4
	vsetvli	a4, s6, e16, m4, ta, mu
	vmv.v.i	v8, 0
	li	a4, 58
.LBB3_12:                               # %for.body29.us.us.us.us.us.us.i.4
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_3 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vsetvli	zero, zero, e8, m2, ta, mu
	vle8.v	v12, (a3)
	vle8.v	v14, (a5)
	vsetvli	zero, zero, e8, m2, tu, mu
	vwmacc.vv	v8, v14, v12
	add	a3, a3, a0
	addi	a4, a4, -1
	add	a5, a5, a0
	bnez	a4, .LBB3_12
# %bb.13:                               # %for.cond26.for.cond.cleanup28_crit_edge.us.us.us.us.us.us.i.4
                                        #   in Loop: Header=BB3_3 Depth=2
	vsetvli	zero, zero, e8, m2, ta, mu
	vnsra.wi	v12, v8, 0
	add	a1, a1, s2
	addi	a2, a2, 1
	vse8.v	v12, (a1)
	bne	a2, t4, .LBB3_3
# %bb.14:                               # %for.cond9.for.cond.cleanup10_crit_edge.split.us.split.us.us.us.us.i
                                        #   in Loop: Header=BB3_2 Depth=1
	add	s7, s7, a7
	sub	s8, s8, a7
	vsetvli	a7, s8, e8, m2, ta, mu
	bnez	a7, .LBB3_2
.LBB3_15:                               # %correlation_vec.exit
	#APP
	rdcycle	a0

	#NO_APP
	sub	a1, a0, a6
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	call	printf
	li	a0, 0
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	lw	s1, 36(sp)                      # 4-byte Folded Reload
	lw	s2, 32(sp)                      # 4-byte Folded Reload
	lw	s3, 28(sp)                      # 4-byte Folded Reload
	lw	s4, 24(sp)                      # 4-byte Folded Reload
	lw	s5, 20(sp)                      # 4-byte Folded Reload
	lw	s6, 16(sp)                      # 4-byte Folded Reload
	lw	s7, 12(sp)                      # 4-byte Folded Reload
	lw	s8, 8(sp)                       # 4-byte Folded Reload
	lw	s9, 4(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
                                        # -- End function
	.type	src0_arr_global,@object         # @src0_arr_global
	.data
	.globl	src0_arr_global
	.p2align	2
src0_arr_global:
	.byte	1                               # 0x1
	.zero	571647
	.size	src0_arr_global, 571648

	.type	src1_arr_global,@object         # @src1_arr_global
	.globl	src1_arr_global
	.p2align	2
src1_arr_global:
	.byte	1                               # 0x1
	.zero	571647
	.size	src1_arr_global, 571648

	.type	out_arr_global,@object          # @out_arr_global
	.bss
	.globl	out_arr_global
	.p2align	2
out_arr_global:
	.zero	49280
	.size	out_arr_global, 49280

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.4,"aMS",@progbits,1
	.p2align	2
.L.str:
	.asciz	"correlation_58x112x88_test running cycles : %d.\n"
	.size	.L.str, 49

	.ident	"Terapines LTD zcc version 1.0.0 (https://www.terapines.com 9342a04ec5543841a5f8bc068eab6c665aba47ef)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym src0_arr_global
	.addrsig_sym src1_arr_global
	.addrsig_sym out_arr_global
