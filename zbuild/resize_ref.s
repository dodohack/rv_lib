	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_a2p0_f2p0_d2p0_c2p0_v0p10"
	.option	nopic
	.file	"resize_ref.c"
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
	addi	sp, sp, -48
	sw	s0, 44(sp)                      # 4-byte Folded Spill
	sw	s1, 40(sp)                      # 4-byte Folded Spill
	sw	s2, 36(sp)                      # 4-byte Folded Spill
	sw	s3, 32(sp)                      # 4-byte Folded Spill
	sw	s4, 28(sp)                      # 4-byte Folded Spill
	sw	s5, 24(sp)                      # 4-byte Folded Spill
	sw	s6, 20(sp)                      # 4-byte Folded Spill
	sw	s7, 16(sp)                      # 4-byte Folded Spill
	sw	s8, 12(sp)                      # 4-byte Folded Spill
	sw	s9, 8(sp)                       # 4-byte Folded Spill
	lhu	a7, 0(a0)
	beqz	a7, .LBB2_16
# %bb.1:                                # %for.cond9.preheader.lr.ph
	lhu	a1, 2(a0)
	slli	a6, a1, 1
	slli	a2, a6, 16
	srli	a2, a2, 16
	beqz	a2, .LBB2_16
# %bb.2:                                # %for.cond9.preheader.lr.ph.split.us
	lhu	t2, 4(a0)
	slli	s4, t2, 1
	slli	a3, s4, 16
	srli	a3, a3, 16
	beqz	a3, .LBB2_11
# %bb.3:                                # %for.cond9.preheader.us.us.preheader
	li	t0, 0
	lw	a2, 8(a0)
	lw	s5, 12(a0)
	addi	t3, a1, -1
	addi	s6, t2, -1
	mul	t1, t2, a1
	li	t4, -128
	lui	a0, 16
	addi	a1, a0, -1
	and	s7, s4, a1
	and	t5, a6, a1
.LBB2_4:                                # %for.cond9.preheader.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_5 Depth 2
                                        #       Child Loop BB2_8 Depth 3
	li	t6, 0
	mul	s3, t1, t0
	mul	s2, t0, a6
.LBB2_5:                                # %for.body13.us.us.us
                                        #   Parent Loop BB2_4 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_8 Depth 3
	srli	a0, t6, 1
	andi	a0, a0, 511
	addi	a4, a0, 1
	mv	a3, t3
	blt	a4, t3, .LBB2_7
# %bb.6:                                # %for.body13.us.us.us
                                        #   in Loop: Header=BB2_5 Depth=2
	mv	a3, a4
.LBB2_7:                                # %for.body13.us.us.us
                                        #   in Loop: Header=BB2_5 Depth=2
	li	s1, 0
	slli	a4, t6, 6
	andi	s8, a4, 64
	sub	a5, t4, s8
	vsetvli	a4, zero, e16, m4, ta, mu
	vid.v	v8
	mul	a0, a0, t2
	add	a4, a0, s3
	mul	a0, t2, a3
	add	a0, a0, s3
	andi	s9, a5, 192
	add	a3, t6, s2
	mul	a3, a3, s4
.LBB2_8:                                # %for.body36.us.us.us
                                        #   Parent Loop BB2_4 Depth=1
                                        #     Parent Loop BB2_5 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	s0, s4, s1
	and	s0, s0, a1
	vsetvli	s0, s0, e16, m4, ta, mu
	vsll.vi	v16, v8, 6
	vsrl.vi	v20, v16, 7
	vadd.vi	v12, v20, 1
	vminu.vx	v12, v12, s6
	vsll.vi	v24, v20, 7
	vsub.vv	v16, v16, v24
	vsetvli	zero, s0, e8, m2, ta, mu
	vnsrl.wi	v24, v16, 0
	vrsub.vx	v16, v24, t4
	vsetvli	zero, zero, e16, m4, ta, mu
	vwaddu.vx	v0, v20, a4
	vsetvli	zero, zero, e8, m2, ta, mu
	vloxei32.v	v18, (a2), v0
	vsetvli	zero, zero, e16, m4, ta, mu
	vwaddu.vx	v0, v12, a4
	vsetvli	zero, zero, e8, m2, ta, mu
	vloxei32.v	v26, (a2), v0
	vsetvli	zero, zero, e16, m4, ta, mu
	vwaddu.vx	v0, v20, a0
	vsetvli	zero, zero, e8, m2, ta, mu
	vloxei32.v	v20, (a2), v0
	vsetvli	zero, zero, e16, m4, ta, mu
	vwaddu.vx	v0, v12, a0
	vsetvli	zero, zero, e8, m2, ta, mu
	vloxei32.v	v12, (a2), v0
	vwmulsu.vv	v28, v18, v16
	vwmulsu.vv	v0, v26, v24
	vsetvli	zero, zero, e16, m4, ta, mu
	vadd.vv	v28, v28, v0
	vsra.vi	v28, v28, 7
	vsetvli	zero, zero, e8, m2, ta, mu
	vwmulsu.vv	v0, v20, v16
	vwmulsu.vv	v16, v12, v24
	vsetvli	zero, zero, e16, m4, ta, mu
	vadd.vv	v12, v0, v16
	vsra.vi	v12, v12, 7
	vmul.vx	v16, v28, s9
	vmul.vx	v12, v12, s8
	vadd.vv	v12, v16, v12
	vsetvli	zero, zero, e8, m2, ta, mu
	vnsra.wi	v16, v12, 7
	vsetvli	zero, zero, e16, m4, ta, mu
	vwaddu.vx	v24, v8, a3
	vsetvli	zero, zero, e8, m2, ta, mu
	vsoxei32.v	v16, (s5), v24
	vsetvli	zero, zero, e16, m4, ta, mu
	add	s1, s1, s0
	and	a5, s1, a1
	vadd.vx	v8, v8, s0
	bltu	a5, s7, .LBB2_8
# %bb.9:                                # %for.cond32.for.cond.cleanup35_crit_edge.us.us.us
                                        #   in Loop: Header=BB2_5 Depth=2
	addi	t6, t6, 1
	and	a0, t6, a1
	bltu	a0, t5, .LBB2_5
# %bb.10:                               # %for.cond9.for.cond.cleanup12_crit_edge.split.us.us.us
                                        #   in Loop: Header=BB2_4 Depth=1
	addi	t0, t0, 1
	slli	a0, t0, 16
	srli	a0, a0, 16
	bltu	a0, a7, .LBB2_4
	j	.LBB2_16
.LBB2_11:                               # %for.cond9.preheader.lr.ph.split.us.split
	mul	a1, a2, a7
	addi	a2, a1, -1
	li	a3, 3
	andi	a0, a1, 2
	bltu	a2, a3, .LBB2_14
# %bb.12:                               # %for.cond9.preheader.lr.ph.split.us.split.new
	andi	a1, a1, -4
.LBB2_13:                               # %for.cond9.preheader.us
                                        # =>This Inner Loop Header: Depth=1
	vsetvli	a2, zero, e16, m4, ta, mu
	vsetvli	a2, zero, e16, m4, ta, mu
	vsetvli	a2, zero, e16, m4, ta, mu
	addi	a1, a1, -4
	vsetvli	a2, zero, e16, m4, ta, mu
	bnez	a1, .LBB2_13
.LBB2_14:                               # %for.cond.cleanup.loopexit.unr-lcssa
	beqz	a0, .LBB2_16
# %bb.15:                               # %for.cond9.preheader.us.epil
	vsetvli	a0, zero, e16, m4, ta, mu
	vsetvli	a0, zero, e16, m4, ta, mu
.LBB2_16:                               # %for.cond.cleanup
	lw	s0, 44(sp)                      # 4-byte Folded Reload
	lw	s1, 40(sp)                      # 4-byte Folded Reload
	lw	s2, 36(sp)                      # 4-byte Folded Reload
	lw	s3, 32(sp)                      # 4-byte Folded Reload
	lw	s4, 28(sp)                      # 4-byte Folded Reload
	lw	s5, 24(sp)                      # 4-byte Folded Reload
	lw	s6, 20(sp)                      # 4-byte Folded Reload
	lw	s7, 16(sp)                      # 4-byte Folded Reload
	lw	s8, 12(sp)                      # 4-byte Folded Reload
	lw	s9, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end2:
	.size	resize_golden_v2, .Lfunc_end2-resize_golden_v2
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %for.cond9.preheader.us.us.i
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	sw	s1, 20(sp)                      # 4-byte Folded Spill
	sw	s2, 16(sp)                      # 4-byte Folded Spill
	sw	s3, 12(sp)                      # 4-byte Folded Spill
	li	t0, 0
	#APP
	csrr	a6, mcycle

	#NO_APP
	li	t4, -128
	li	a7, 88
	li	t5, 176
	lui	a0, 16
	addi	a5, a0, -1
	li	t3, 87
	lui	a0, %hi(src_arr_global)
	addi	a3, a0, %lo(src_arr_global)
	lui	a0, %hi(out_arr_global)
	addi	t6, a0, %lo(out_arr_global)
	li	t1, 223
.LBB3_1:                                # %for.body13.us.us.us.i
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_4 Depth 2
	slli	t2, t0, 16
	srli	a1, t2, 17
	addi	s0, a1, 1
	li	a0, 111
	blt	a0, s0, .LBB3_3
# %bb.2:                                # %for.body13.us.us.us.i
                                        #   in Loop: Header=BB3_1 Depth=1
	li	s0, 111
.LBB3_3:                                # %for.body13.us.us.us.i
                                        #   in Loop: Header=BB3_1 Depth=1
	li	a0, 0
	slli	a2, t0, 6
	andi	s2, a2, 64
	sub	s1, t4, s2
	vsetvli	a4, zero, e16, m4, ta, mu
	vid.v	v8
	mul	a4, a1, a7
	mul	a1, s0, a7
	andi	s3, s1, 192
	mul	s1, t0, t5
.LBB3_4:                                # %for.body36.us.us.us.i
                                        #   Parent Loop BB3_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	sub	a2, t5, a0
	and	a2, a2, a5
	vsetvli	a2, a2, e16, m4, ta, mu
	vsll.vi	v16, v8, 6
	vsrl.vi	v20, v16, 7
	vadd.vi	v12, v20, 1
	vminu.vx	v12, v12, t3
	vsll.vi	v24, v20, 7
	vsub.vv	v16, v16, v24
	vsetvli	zero, a2, e8, m2, ta, mu
	vnsrl.wi	v24, v16, 0
	vrsub.vx	v16, v24, t4
	vsetvli	zero, zero, e16, m4, ta, mu
	vwaddu.vx	v0, v20, a4
	vsetvli	zero, zero, e8, m2, ta, mu
	vloxei32.v	v18, (a3), v0
	vsetvli	zero, zero, e16, m4, ta, mu
	vwaddu.vx	v0, v12, a4
	vsetvli	zero, zero, e8, m2, ta, mu
	vloxei32.v	v26, (a3), v0
	vsetvli	zero, zero, e16, m4, ta, mu
	vwaddu.vx	v0, v20, a1
	vsetvli	zero, zero, e8, m2, ta, mu
	vloxei32.v	v20, (a3), v0
	vsetvli	zero, zero, e16, m4, ta, mu
	vwaddu.vx	v0, v12, a1
	vsetvli	zero, zero, e8, m2, ta, mu
	vloxei32.v	v12, (a3), v0
	vwmulsu.vv	v28, v18, v16
	vwmulsu.vv	v0, v26, v24
	vsetvli	zero, zero, e16, m4, ta, mu
	vadd.vv	v28, v28, v0
	vsra.vi	v28, v28, 7
	vsetvli	zero, zero, e8, m2, ta, mu
	vwmulsu.vv	v0, v20, v16
	vwmulsu.vv	v16, v12, v24
	vsetvli	zero, zero, e16, m4, ta, mu
	vadd.vv	v12, v0, v16
	vsra.vi	v12, v12, 7
	vmul.vx	v16, v28, s3
	vmul.vx	v12, v12, s2
	vadd.vv	v12, v16, v12
	vsetvli	zero, zero, e8, m2, ta, mu
	vnsra.wi	v16, v12, 7
	vsetvli	zero, zero, e16, m4, ta, mu
	vwaddu.vx	v24, v8, s1
	vsetvli	zero, zero, e8, m2, ta, mu
	vsoxei32.v	v16, (t6), v24
	vsetvli	zero, zero, e16, m4, ta, mu
	add	a0, a0, a2
	and	s0, a0, a5
	vadd.vx	v8, v8, a2
	bltu	s0, t5, .LBB3_4
# %bb.5:                                # %for.cond32.for.cond.cleanup35_crit_edge.us.us.us.i
                                        #   in Loop: Header=BB3_1 Depth=1
	srli	a0, t2, 16
	addi	t0, t0, 1
	bltu	a0, t1, .LBB3_1
# %bb.6:                                # %resize_golden_v2.exit
	#APP
	csrr	a0, mcycle

	#NO_APP
	sub	a1, a0, a6
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	call	printf
	li	a0, 0
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	lw	s1, 20(sp)                      # 4-byte Folded Reload
	lw	s2, 16(sp)                      # 4-byte Folded Reload
	lw	s3, 12(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
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
