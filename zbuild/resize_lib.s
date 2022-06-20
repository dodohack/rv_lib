	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_a2p0_f2p0_d2p0_c2p0_v0p10"
	.option	nopic
	.file	"resize.c"
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
	.globl	resize_vec                      # -- Begin function resize_vec
	.p2align	2
	.type	resize_vec,@function
resize_vec:                             # @resize_vec
# %bb.0:                                # %entry
	addi	sp, sp, -2032
	sw	ra, 2028(sp)                    # 4-byte Folded Spill
	sw	s0, 2024(sp)                    # 4-byte Folded Spill
	sw	s1, 2020(sp)                    # 4-byte Folded Spill
	sw	s2, 2016(sp)                    # 4-byte Folded Spill
	sw	s3, 2012(sp)                    # 4-byte Folded Spill
	sw	s4, 2008(sp)                    # 4-byte Folded Spill
	sw	s5, 2004(sp)                    # 4-byte Folded Spill
	sw	s6, 2000(sp)                    # 4-byte Folded Spill
	sw	s7, 1996(sp)                    # 4-byte Folded Spill
	sw	s8, 1992(sp)                    # 4-byte Folded Spill
	sw	s9, 1988(sp)                    # 4-byte Folded Spill
	sw	s10, 1984(sp)                   # 4-byte Folded Spill
	sw	s11, 1980(sp)                   # 4-byte Folded Spill
	lui	a1, 1
	addi	a1, a1, -944
	sub	sp, sp, a1
	li	a1, 0
	lhu	a6, 0(a0)
	lhu	a7, 2(a0)
	lhu	s3, 4(a0)
	lw	s2, 8(a0)
	lw	s9, 12(a0)
	vsetvli	a0, zero, e16, m8, ta, mu
	vid.v	v8
	lui	a0, 1
	addi	a0, a0, 524
	add	t1, sp, a0
	li	a0, 256
.LBB2_1:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	slli	a2, a1, 1
	add	a2, a2, t1
	sub	a3, a0, a1
	vsetvli	a3, a3, e16, m8, ta, mu
	vse16.v	v8, (a2)
	add	a1, a1, a3
	vsetvli	a2, zero, e16, m8, ta, mu
	vadd.vx	v8, v8, a3
	bne	a1, a0, .LBB2_1
# %bb.2:                                # %for.body16.preheader
	li	a1, 0
	vid.v	v8
	lui	a2, 1
	addi	a2, a2, 12
	add	a5, sp, a2
.LBB2_3:                                # %vector.body432
                                        # =>This Inner Loop Header: Depth=1
	slli	a2, a1, 1
	add	a2, a2, a5
	sub	a3, a0, a1
	vsetvli	a3, a3, e16, m8, ta, mu
	vse16.v	v8, (a2)
	add	a1, a1, a3
	vsetvli	a2, zero, e16, m8, ta, mu
	vadd.vx	v8, v8, a3
	bne	a1, a0, .LBB2_3
# %bb.4:                                # %for.cond.cleanup15
	lui	a0, 16
	addi	s6, a0, -1
	slli	t0, s3, 1
	addi	a0, a0, -2
	and	t2, t0, a0
	slli	t6, a7, 1
	beqz	t2, .LBB2_7
# %bb.5:                                # %for.body38.preheader
	addi	t4, s3, -1
	addi	a3, sp, 12
	addi	a4, sp, 524
	lui	a0, 1
	addi	a0, a0, -2036
	add	s1, sp, a0
	lui	a0, 1
	addi	a0, a0, -1524
	add	s0, sp, a0
	li	t3, 128
	mv	a2, t0
.LBB2_6:                                # %for.body38
                                        # =>This Inner Loop Header: Depth=1
	and	a0, a2, s6
	vsetvli	a0, a0, e16, m2, ta, mu
	and	a1, a0, s6
	vsetvli	zero, a1, e16, m2, ta, mu
	vle16.v	v8, (a5)
	vsll.vi	v8, v8, 6
	vsrl.vi	v10, v8, 7
	vadd.vi	v12, v10, 1
	vminu.vx	v12, v12, t4
	vsll.vi	v14, v10, 7
	vsub.vv	v8, v8, v14
	vrsub.vx	v14, v8, t3
	vse16.v	v10, (s0)
	vse16.v	v12, (s1)
	vse16.v	v14, (a4)
	vse16.v	v8, (a3)
	slli	a1, a1, 1
	add	a5, a5, a1
	add	s0, s0, a1
	add	s1, s1, a1
	add	a4, a4, a1
	sub	a2, a2, a0
	and	a0, a2, s6
	add	a3, a3, a1
	bnez	a0, .LBB2_6
.LBB2_7:                                # %for.cond64.preheader
	slli	a0, t6, 16
	srli	t5, a0, 16
	beqz	t5, .LBB2_18
# %bb.8:                                # %for.body67.preheader
	addi	a3, a7, -1
	seqz	t2, t2
	seqz	t3, t5
	addi	a4, sp, 1036
	addi	a5, sp, 1548
	lui	a0, 1
	addi	a0, a0, -1012
	add	s1, sp, a0
	lui	a0, 1
	addi	a0, a0, -500
	add	s0, sp, a0
	li	a0, 128
.LBB2_9:                                # %for.body67
                                        # =>This Inner Loop Header: Depth=1
	and	a1, t6, s6
	vsetvli	a1, a1, e16, m2, ta, mu
	and	a2, a1, s6
	vsetvli	zero, a2, e16, m2, ta, mu
	vle16.v	v8, (t1)
	vsll.vi	v8, v8, 6
	vsrl.vi	v10, v8, 7
	vadd.vi	v12, v10, 1
	vminu.vx	v12, v12, a3
	vsll.vi	v14, v10, 7
	vsub.vv	v8, v8, v14
	vrsub.vx	v14, v8, a0
	vse16.v	v10, (s0)
	vse16.v	v12, (s1)
	vse16.v	v14, (a5)
	vse16.v	v8, (a4)
	slli	a2, a2, 1
	add	t1, t1, a2
	add	s0, s0, a2
	add	s1, s1, a2
	add	a5, a5, a2
	sub	t6, t6, a1
	and	a1, t6, s6
	add	a4, a4, a2
	bnez	a1, .LBB2_9
# %bb.10:                               # %for.cond95.preheader
	beqz	a6, .LBB2_18
# %bb.11:                               # %for.body99.lr.ph
	or	a0, t3, t2
	bnez	a0, .LBB2_18
# %bb.12:                               # %for.body99.us.preheader
	li	t1, 0
	mul	a7, s3, a7
	lui	a0, 1
	addi	a0, a0, -500
	add	t2, sp, a0
	lui	a0, 1
	addi	a0, a0, -1012
	add	t3, sp, a0
	addi	t4, sp, 1548
	addi	t6, sp, 1036
.LBB2_13:                               # %for.body99.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_14 Depth 2
                                        #       Child Loop BB2_15 Depth 3
	li	s5, 0
	mul	a0, a7, t1
	slli	a0, a0, 16
	srli	s4, a0, 16
.LBB2_14:                               # %for.body108.us399
                                        #   Parent Loop BB2_13 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_15 Depth 3
	li	s0, 0
	addi	s11, sp, 12
	addi	ra, sp, 524
	lui	a0, 1
	addi	a0, a0, -2036
	add	a2, sp, a0
	slli	a0, s5, 1
	add	a1, t2, a0
	lhu	a1, 0(a1)
	add	a4, t3, a0
	lhu	a4, 0(a4)
	lui	a3, 1
	addi	a3, a3, -1524
	add	a5, sp, a3
	mul	a1, a1, s3
	add	s10, a1, s4
	mul	a4, a4, s3
	add	a1, t4, a0
	lhu	s7, 0(a1)
	add	a0, a0, t6
	lhu	s8, 0(a0)
	add	a0, a4, s4
	add	a1, s2, s10
	add	a4, s2, a0
	mv	a0, t0
.LBB2_15:                               # %for.body138.us
                                        #   Parent Loop BB2_13 Depth=1
                                        #     Parent Loop BB2_14 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	and	s1, a0, s6
	vsetvli	s10, s1, e16, m2, ta, mu
	and	s1, s10, s6
	vsetvli	zero, s1, e16, m2, ta, mu
	vle16.v	v8, (a5)
	vle16.v	v10, (a2)
	vle16.v	v12, (ra)
	vle16.v	v14, (s11)
	vle8.v	v16, (a1)
	vle8.v	v17, (a4)
	vsetvli	zero, zero, e8, m1, ta, mu
	vwadd.vx	v18, v16, zero
	vwadd.vx	v20, v17, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	vsub.vx	v8, v8, s0
	vsub.vx	v10, v10, s0
	vrgather.vv	v16, v18, v8
	vrgather.vv	v22, v18, v10
	vrgather.vv	v18, v20, v8
	vrgather.vv	v8, v20, v10
	vmul.vv	v10, v16, v12
	vmul.vv	v12, v18, v12
	vsetvli	zero, zero, e16, m2, tu, mu
	vmacc.vv	v10, v22, v14
	vmacc.vv	v12, v8, v14
	vsetvli	zero, zero, e16, m2, ta, mu
	vsra.vi	v8, v10, 7
	vsra.vi	v10, v12, 7
	vmul.vx	v8, v8, s7
	vmul.vx	v10, v10, s8
	vadd.vv	v8, v8, v10
	vsetvli	zero, zero, e8, m1, ta, mu
	vnsra.wi	v10, v8, 7
	vse8.v	v10, (s9)
	slli	a3, s1, 1
	add	a5, a5, a3
	add	a2, a2, a3
	add	ra, ra, a3
	add	s11, s11, a3
	add	s9, s9, s1
	srli	a3, s1, 1
	add	a1, a1, a3
	add	a4, a4, a3
	sub	a0, a0, s10
	and	s1, a0, s6
	add	s0, s0, a3
	bnez	s1, .LBB2_15
# %bb.16:                               # %for.cond135.for.cond.cleanup137_crit_edge.us
                                        #   in Loop: Header=BB2_14 Depth=2
	addi	s5, s5, 1
	bne	s5, t5, .LBB2_14
# %bb.17:                               # %for.cond104.for.cond.cleanup107_crit_edge.split.us403
                                        #   in Loop: Header=BB2_13 Depth=1
	addi	t1, t1, 1
	bne	t1, a6, .LBB2_13
.LBB2_18:                               # %for.cond.cleanup98
	lui	a0, 1
	addi	a0, a0, -944
	add	sp, sp, a0
	lw	ra, 2028(sp)                    # 4-byte Folded Reload
	lw	s0, 2024(sp)                    # 4-byte Folded Reload
	lw	s1, 2020(sp)                    # 4-byte Folded Reload
	lw	s2, 2016(sp)                    # 4-byte Folded Reload
	lw	s3, 2012(sp)                    # 4-byte Folded Reload
	lw	s4, 2008(sp)                    # 4-byte Folded Reload
	lw	s5, 2004(sp)                    # 4-byte Folded Reload
	lw	s6, 2000(sp)                    # 4-byte Folded Reload
	lw	s7, 1996(sp)                    # 4-byte Folded Reload
	lw	s8, 1992(sp)                    # 4-byte Folded Reload
	lw	s9, 1988(sp)                    # 4-byte Folded Reload
	lw	s10, 1984(sp)                   # 4-byte Folded Reload
	lw	s11, 1980(sp)                   # 4-byte Folded Reload
	addi	sp, sp, 2032
	ret
.Lfunc_end2:
	.size	resize_vec, .Lfunc_end2-resize_vec
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %entry
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	lui	a0, 1792
	addi	a0, a0, 1
	sw	a0, 8(sp)
	li	a0, 88
	sh	a0, 12(sp)
	lui	a0, %hi(src_arr_global)
	addi	a0, a0, %lo(src_arr_global)
	sw	a0, 16(sp)
	lui	a0, %hi(out_arr_global)
	addi	a0, a0, %lo(out_arr_global)
	sw	a0, 20(sp)
	#APP
	csrr	s0, mcycle

	#NO_APP
	addi	a0, sp, 8
	call	resize_vec
	#APP
	csrr	a0, mcycle

	#NO_APP
	sub	a1, a0, s0
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	call	printf
	li	a0, 0
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
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
