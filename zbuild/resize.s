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
	lhu	a1, 0(a0)
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	beqz	a1, .LBB2_2
# %bb.1:                                # %for.cond9.preheader.lr.ph
	lhu	a7, 2(a0)
	lhu	s3, 4(a0)
	slli	a1, a7, 1
	slli	t2, s3, 1
	lui	a2, 16
	addi	s5, a2, -1
	and	t5, a1, s5
	seqz	a1, t5
	and	s9, t2, s5
	seqz	a2, s9
	or	a1, a1, a2
	beqz	a1, .LBB2_3
.LBB2_2:                                # %for.cond.cleanup
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
.LBB2_3:                                # %for.cond9.preheader.us.us.preheader
	li	s6, 0
	li	a2, 0
	lw	a4, 8(a0)
	lw	s2, 12(a0)
	addi	t3, a7, -1
	mul	a0, s3, a7
	addi	s10, s3, -1
	sw	a0, 12(sp)                      # 4-byte Folded Spill
	slli	a0, a0, 2
	sw	a0, 8(sp)                       # 4-byte Folded Spill
	li	s8, -128
	j	.LBB2_5
.LBB2_4:                                # %for.cond9.for.cond.cleanup12_crit_edge.split.us.us.us
                                        #   in Loop: Header=BB2_5 Depth=1
	lw	a2, 20(sp)                      # 4-byte Folded Reload
	addi	a2, a2, 1
	slli	a0, a2, 16
	srli	a0, a0, 16
	lw	s6, 24(sp)                      # 4-byte Folded Reload
	lw	a1, 8(sp)                       # 4-byte Folded Reload
	add	s6, s6, a1
	lw	a1, 16(sp)                      # 4-byte Folded Reload
	bgeu	a0, a1, .LBB2_2
.LBB2_5:                                # %for.cond9.preheader.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_7 Depth 2
                                        #       Child Loop BB2_12 Depth 3
	li	s7, 0
	sw	a2, 20(sp)                      # 4-byte Folded Spill
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	mul	s4, a0, a2
	sw	s6, 24(sp)                      # 4-byte Folded Spill
	j	.LBB2_7
.LBB2_6:                                # %for.cond47.for.cond.cleanup50_crit_edge.us.us.us
                                        #   in Loop: Header=BB2_7 Depth=2
	addi	s7, s7, 1
	add	s6, s6, t2
	beq	s7, t5, .LBB2_4
.LBB2_7:                                # %for.body13.us.us.us
                                        #   Parent Loop BB2_5 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_12 Depth 3
	srli	a0, s7, 1
	andi	s0, a0, 511
	addi	a2, s0, 1
	bltu	a2, a7, .LBB2_9
# %bb.8:                                # %for.body13.us.us.us
                                        #   in Loop: Header=BB2_7 Depth=2
	mv	a2, t3
.LBB2_9:                                # %for.body13.us.us.us
                                        #   in Loop: Header=BB2_7 Depth=2
	li	a0, 0
	and	a1, s6, s5
	add	s11, s2, a1
	slli	a1, s7, 6
	andi	t0, a1, 64
	sub	ra, s8, t0
	mul	a1, s0, s3
	add	a1, a1, s4
	and	t1, a1, s5
	mul	a1, a2, s3
	add	a1, a1, s4
	and	a2, a1, s5
	j	.LBB2_12
.LBB2_10:                               # %for.body51.us.us.us
                                        #   in Loop: Header=BB2_12 Depth=3
	mv	a5, s10
.LBB2_11:                               # %for.body51.us.us.us
                                        #   in Loop: Header=BB2_12 Depth=3
	slli	s1, a0, 6
	andi	s1, s1, 64
	sub	a6, s8, s1
	add	t6, a1, t1
	slli	a5, a5, 16
	srli	a5, a5, 16
	add	t4, a5, t1
	add	a3, a4, t4
	lb	a3, 0(a3)
	add	s0, a4, t6
	lb	s0, 0(s0)
	add	a1, a1, a2
	add	a5, a5, a2
	mul	a3, a3, s1
	mul	s0, s0, a6
	add	a3, a3, s0
	add	a5, a5, a4
	lb	a5, 0(a5)
	add	a1, a1, a4
	lb	a1, 0(a1)
	slli	a3, a3, 24
	srai	a3, a3, 24
	mul	a5, a5, s1
	mul	a1, a1, a6
	add	a1, a1, a5
	slli	a1, a1, 24
	srai	a1, a1, 24
	srli	a1, a1, 7
	and	a1, a1, t0
	srli	a3, a3, 7
	and	a3, a3, ra
	andi	a3, a3, 255
	add	a1, a1, a3
	srli	a1, a1, 7
	add	a3, s11, a0
	addi	a0, a0, 1
	sb	a1, 0(a3)
	beq	s9, a0, .LBB2_6
.LBB2_12:                               # %for.body51.us.us.us
                                        #   Parent Loop BB2_5 Depth=1
                                        #     Parent Loop BB2_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	srli	a1, a0, 1
	andi	a1, a1, 511
	bge	a1, s10, .LBB2_10
# %bb.13:                               #   in Loop: Header=BB2_12 Depth=3
	addi	a5, a1, 1
	j	.LBB2_11
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
	sw	s4, 8(sp)                       # 4-byte Folded Spill
	sw	s5, 4(sp)                       # 4-byte Folded Spill
	sw	s6, 0(sp)                       # 4-byte Folded Spill
	li	t4, 0
	lui	a0, %hi(out_arr_global)
	addi	s2, a0, %lo(out_arr_global)
	#APP
	csrr	a6, mcycle

	#NO_APP
	li	t5, -128
	li	a7, 88
	lui	a0, 2
	addi	t1, a0, 1576
	li	t0, 111
	lui	a0, 16
	addi	t3, a0, -8
	lui	a0, %hi(src_arr_global)
	addi	a0, a0, %lo(src_arr_global)
	li	t6, 176
	li	t2, 224
	j	.LBB3_2
.LBB3_1:                                # %for.cond47.for.cond.cleanup50_crit_edge.us.us.us.i
                                        #   in Loop: Header=BB3_2 Depth=1
	addi	t4, t4, 1
	addi	s2, s2, 176
	beq	t4, t2, .LBB3_9
.LBB3_2:                                # %for.body13.us.us.us.i
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_7 Depth 2
	srli	a1, t4, 1
	andi	a1, a1, 511
	mul	s5, a1, a7
	bltu	a1, t0, .LBB3_4
# %bb.3:                                # %for.body13.us.us.us.i
                                        #   in Loop: Header=BB3_2 Depth=1
	mv	a2, t1
	j	.LBB3_5
.LBB3_4:                                #   in Loop: Header=BB3_2 Depth=1
	addi	a2, s5, 88
.LBB3_5:                                # %for.body13.us.us.us.i
                                        #   in Loop: Header=BB3_2 Depth=1
	li	a1, 0
	slli	a3, t4, 6
	andi	s4, a3, 64
	sub	s3, t5, s4
	and	s6, a2, t3
	j	.LBB3_7
.LBB3_6:                                # %for.body51.us.us.us.i
                                        #   in Loop: Header=BB3_7 Depth=2
	slli	a5, a1, 6
	andi	a5, a5, 64
	sub	a3, t5, a5
	add	a4, s1, s5
	add	s0, a2, s5
	add	s0, s0, a0
	lb	s0, 0(s0)
	add	a4, a4, a0
	lb	a4, 0(a4)
	add	s1, s1, s6
	add	a2, a2, s6
	mul	s0, a5, s0
	mul	a4, a3, a4
	add	a4, a4, s0
	add	a2, a2, a0
	lb	a2, 0(a2)
	add	s0, s1, a0
	lb	s0, 0(s0)
	slli	a4, a4, 24
	srai	a4, a4, 24
	mul	a2, a5, a2
	mul	a3, a3, s0
	add	a2, a2, a3
	slli	a2, a2, 24
	srai	a2, a2, 24
	srli	a2, a2, 7
	and	a2, a2, s4
	srli	a3, a4, 7
	and	a3, a3, s3
	andi	a3, a3, 255
	add	a2, a2, a3
	srli	a2, a2, 7
	add	a3, s2, a1
	addi	a1, a1, 1
	sb	a2, 0(a3)
	beq	a1, t6, .LBB3_1
.LBB3_7:                                # %for.body51.us.us.us.i
                                        #   Parent Loop BB3_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	srli	a2, a1, 1
	andi	s1, a2, 511
	li	a2, 87
	bgeu	s1, a2, .LBB3_6
# %bb.8:                                #   in Loop: Header=BB3_7 Depth=2
	addi	a2, s1, 1
	j	.LBB3_6
.LBB3_9:                                # %resize_golden_v2.exit
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
	lw	s4, 8(sp)                       # 4-byte Folded Reload
	lw	s5, 4(sp)                       # 4-byte Folded Reload
	lw	s6, 0(sp)                       # 4-byte Folded Reload
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

	.ident	"Terapines LTD zcc version 1.0.0 (https://www.terapines.com 9342a04ec5543841a5f8bc068eab6c665aba47ef)"
	.section	".note.GNU-stack","",@progbits
