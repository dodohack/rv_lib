	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_a2p0_f2p0_d2p0_c2p0_v0p10"
	.option	nopic
	.file	"resize_v2_golden.c"
	.globl	read_rdcycle                    # -- Begin function read_rdcycle
	.p2align	2
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
	.globl	resize_param_read               # -- Begin function resize_param_read
	.p2align	2
	.type	resize_param_read,@function
resize_param_read:                      # @resize_param_read
# %bb.0:                                # %entry
	lw	a2, 8(a1)
	slli	a3, a2, 16
	srli	a2, a2, 16
	or	a2, a2, a3
	sw	a2, 0(a0)
	lhu	a1, 14(a1)
	sh	a1, 4(a0)
	lui	a1, %hi(src_arr_global)
	addi	a1, a1, %lo(src_arr_global)
	sw	a1, 8(a0)
	lui	a1, %hi(out_arr_global)
	addi	a1, a1, %lo(out_arr_global)
	sw	a1, 12(a0)
	ret
.Lfunc_end1:
	.size	resize_param_read, .Lfunc_end1-resize_param_read
                                        # -- End function
	.globl	resize_golden_v2                # -- Begin function resize_golden_v2
	.p2align	2
	.type	resize_golden_v2,@function
resize_golden_v2:                       # @resize_golden_v2
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
	sw	s10, 16(sp)                     # 4-byte Folded Spill
	sw	s11, 12(sp)                     # 4-byte Folded Spill
	lhu	a1, 0(a0)
	sw	a1, 8(sp)                       # 4-byte Folded Spill
	beqz	a1, .LBB2_2
# %bb.1:                                # %for.cond9.preheader.lr.ph
	lhu	a1, 2(a0)
	lhu	t6, 4(a0)
	slli	a2, a1, 1
	slli	t1, t6, 1
	lui	a3, 16
	addi	s4, a3, -1
	and	t2, a2, s4
	seqz	a2, t2
	and	s8, t1, s4
	seqz	a3, s8
	or	a2, a2, a3
	beqz	a2, .LBB2_3
.LBB2_2:                                # %for.cond.cleanup
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
	lw	s10, 16(sp)                     # 4-byte Folded Reload
	lw	s11, 12(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
.LBB2_3:                                # %for.cond9.preheader.us.us.preheader
	li	a7, 0
	li	t0, 0
	lw	a3, 8(a0)
	lw	t4, 12(a0)
	addi	s2, a1, -1
	mul	t3, t6, a1
	addi	s10, t6, -1
	slli	a0, t3, 2
	sw	a0, 4(sp)                       # 4-byte Folded Spill
	li	s7, -128
	j	.LBB2_5
.LBB2_4:                                # %for.cond9.for.cond.cleanup12_crit_edge.split.us.us.us
                                        #   in Loop: Header=BB2_5 Depth=1
	addi	t0, t0, 1
	slli	a0, t0, 16
	srli	a0, a0, 16
	lw	a1, 4(sp)                       # 4-byte Folded Reload
	add	a7, a7, a1
	lw	a1, 8(sp)                       # 4-byte Folded Reload
	bgeu	a0, a1, .LBB2_2
.LBB2_5:                                # %for.cond9.preheader.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_7 Depth 2
                                        #       Child Loop BB2_11 Depth 3
	li	s6, 0
	mul	s3, t3, t0
	mv	s5, a7
	j	.LBB2_7
.LBB2_6:                                # %for.cond47.for.cond.cleanup50_crit_edge.us.us.us
                                        #   in Loop: Header=BB2_7 Depth=2
	addi	s6, s6, 1
	add	s5, s5, t1
	beq	s6, t2, .LBB2_4
.LBB2_7:                                # %for.body13.us.us.us
                                        #   Parent Loop BB2_5 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_11 Depth 3
	srli	a0, s6, 1
	andi	a1, a0, 511
	addi	a0, a1, 1
	mv	s9, s2
	blt	s2, a0, .LBB2_9
# %bb.8:                                # %for.body13.us.us.us
                                        #   in Loop: Header=BB2_7 Depth=2
	mv	s9, a0
.LBB2_9:                                # %for.body13.us.us.us
                                        #   in Loop: Header=BB2_7 Depth=2
	li	s1, 0
	and	a0, s5, s4
	add	s11, t4, a0
	slli	a0, s6, 6
	andi	a6, a0, 64
	sub	ra, s7, a6
	mul	a0, a1, t6
	add	a0, a0, s3
	and	t5, a0, s4
	mul	a0, t6, s9
	add	a0, a0, s3
	and	s9, a0, s4
	j	.LBB2_11
.LBB2_10:                               # %for.body51.us.us.us
                                        #   in Loop: Header=BB2_11 Depth=3
	slli	s0, s1, 6
	andi	s0, s0, 64
	sub	a5, s7, s0
	add	a2, a0, t5
	slli	a4, a4, 16
	srli	a4, a4, 16
	add	a1, a4, t5
	add	a1, a1, a3
	lb	a1, 0(a1)
	add	a2, a2, a3
	lb	a2, 0(a2)
	add	a0, a0, s9
	add	a4, a4, s9
	mul	a1, a1, s0
	mul	a2, a2, a5
	add	a1, a1, a2
	add	a2, a3, a4
	lb	a2, 0(a2)
	add	a0, a0, a3
	lb	a0, 0(a0)
	slli	a1, a1, 24
	srai	a1, a1, 24
	mul	a2, a2, s0
	mul	a0, a0, a5
	add	a0, a0, a2
	slli	a0, a0, 24
	srai	a0, a0, 24
	srli	a0, a0, 7
	and	a0, a0, a6
	srli	a1, a1, 7
	and	a1, a1, ra
	andi	a1, a1, 255
	add	a0, a0, a1
	srli	a0, a0, 7
	add	a1, s11, s1
	addi	s1, s1, 1
	sb	a0, 0(a1)
	beq	s8, s1, .LBB2_6
.LBB2_11:                               # %for.body51.us.us.us
                                        #   Parent Loop BB2_5 Depth=1
                                        #     Parent Loop BB2_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	srli	a0, s1, 1
	andi	a0, a0, 511
	addi	a4, a0, 1
	blt	a4, s10, .LBB2_10
# %bb.12:                               # %for.body51.us.us.us
                                        #   in Loop: Header=BB2_11 Depth=3
	mv	a4, s10
	j	.LBB2_10
.Lfunc_end2:
	.size	resize_golden_v2, .Lfunc_end2-resize_golden_v2
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %for.cond9.preheader.us.us.i
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	sw	s1, 4(sp)                       # 4-byte Folded Spill
	sw	s2, 0(sp)                       # 4-byte Folded Spill
	li	t0, 0
	#APP
	csrr	a6, mcycle

	#NO_APP
	vsetvli	a0, zero, e16, m2, ta, mu
	vid.v	v10
	li	t4, -128
	li	a7, 88
	li	t5, 176
	li	t2, 86
	li	t3, 64
	lui	a0, %hi(src_arr_global)
	addi	a3, a0, %lo(src_arr_global)
	vsetvli	zero, zero, e8, m1, ta, mu
	vmv.v.i	v9, 0
	lui	a0, %hi(out_arr_global)
	addi	t6, a0, %lo(out_arr_global)
	li	t1, 224
.LBB3_1:                                # %for.body13.us.us.us.i
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_4 Depth 2
	srli	a0, t0, 1
	andi	a1, a0, 511
	addi	s0, a1, 1
	li	a0, 111
	blt	s0, a0, .LBB3_3
# %bb.2:                                # %for.body13.us.us.us.i
                                        #   in Loop: Header=BB3_1 Depth=1
	li	s0, 111
.LBB3_3:                                # %for.body13.us.us.us.i
                                        #   in Loop: Header=BB3_1 Depth=1
	li	a5, 0
	slli	a0, t0, 6
	andi	a0, a0, 64
	sub	s2, t4, a0
	mul	a4, a1, a7
	mul	a1, s0, a7
	mul	s0, t0, t5
	vmv2r.v	v12, v10
.LBB3_4:                                # %vector.body
                                        #   Parent Loop BB3_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	sub	s1, t5, a5
	vsetvli	s1, s1, e16, m2, ta, mu
	vsll.vi	v14, v12, 6
	vsrl.vi	v16, v14, 7
	vsetvli	zero, zero, e32, m4, ta, mu
	vzext.vf2	v20, v16
	vmin.vx	v16, v20, t2
	vadd.vi	v16, v16, 1
	vsetvli	zero, zero, e8, m1, ta, mu
	vnsrl.wx	v8, v14, zero
	vand.vx	v8, v8, t3
	vrsub.vx	v14, v8, t4
	vsetvli	zero, zero, e32, m4, ta, mu
	vadd.vx	v24, v20, a4
	vadd.vx	v28, v16, a4
	vadd.vx	v20, v20, a1
	vadd.vx	v16, v16, a1
	add	a2, a5, s0
	vsetvli	zero, zero, e8, m1, ta, mu
	vluxei32.v	v15, (a3), v24
	vluxei32.v	v24, (a3), v28
	vluxei32.v	v25, (a3), v20
	vluxei32.v	v20, (a3), v16
	vmul.vv	v15, v14, v15
	vmacc.vv	v15, v8, v24
	vmul.vv	v14, v14, v25
	vmacc.vv	v14, v8, v20
	vmslt.vx	v0, v14, zero
	vmslt.vx	v8, v15, zero
	vmerge.vxm	v14, v9, a0, v0
	vmv.v.v	v0, v8
	vmerge.vxm	v8, v9, s2, v0
	vwaddu.vv	v16, v14, v8
	vnsrl.wi	v8, v16, 7
	add	a2, a2, t6
	vse8.v	v8, (a2)
	add	a5, a5, s1
	vsetvli	a2, zero, e16, m2, ta, mu
	vadd.vx	v12, v12, s1
	bne	a5, t5, .LBB3_4
# %bb.5:                                # %for.cond47.for.cond.cleanup50_crit_edge.us.us.us.i
                                        #   in Loop: Header=BB3_1 Depth=1
	addi	t0, t0, 1
	bne	t0, t1, .LBB3_1
# %bb.6:                                # %resize_golden_v2.exit
	#APP
	csrr	a0, mcycle

	#NO_APP
	sub	a1, a0, a6
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	call	printf
	li	a0, 0
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	lw	s1, 4(sp)                       # 4-byte Folded Reload
	lw	s2, 0(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
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
	.zero	9855
	.size	src_arr_global, 9856

	.type	out_arr_global,@object          # @out_arr_global
	.bss
	.globl	out_arr_global
	.p2align	2
out_arr_global:
	.zero	39424
	.size	out_arr_global, 39424

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.4,"aMS",@progbits,1
	.p2align	2
.L.str:
	.asciz	"resize_1x112x88 running cycles : %d.\n"
	.size	.L.str, 38

	.ident	"Terapines LTD zcc version 2.0.0 (https://www.terapines.com d82a1442dfd98f60f08014f36ba57878ee901dfd)"
	.section	".note.GNU-stack","",@progbits
