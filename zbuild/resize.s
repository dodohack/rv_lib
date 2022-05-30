	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_f2p0_d2p0_c2p0_v1p0_zve32f1p0_zve32x1p0_zve64d1p0_zve64f1p0_zve64x1p0_zvl128b1p0_zvl32b1p0_zvl64b1p0"
	.option	nopic
	.file	"resize_v2_golden.c"
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
	.globl	resize_param_read               # -- Begin function resize_param_read
	.p2align	1
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
	.p2align	1
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
	sw	s10, 4(sp)                      # 4-byte Folded Spill
	sw	s11, 0(sp)                      # 4-byte Folded Spill
	lhu	a6, 0(a0)
	beqz	a6, .LBB2_2
# %bb.1:                                # %for.cond11.preheader.lr.ph
	lhu	a2, 2(a0)
	lhu	t5, 4(a0)
	slli	a1, a2, 1
	slli	a3, t5, 1
	lui	a4, 16
	addi	s4, a4, -1
	and	t2, a1, s4
	seqz	a1, t2
	and	s5, a3, s4
	seqz	a3, s5
	or	a1, a1, a3
	beqz	a1, .LBB2_3
.LBB2_2:                                # %for.cond.cleanup
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
	lw	s10, 4(sp)                      # 4-byte Folded Reload
	lw	s11, 0(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.LBB2_3:                                # %for.cond11.preheader.us.us.preheader
	li	a7, 0
	lw	a1, 8(a0)
	lw	t0, 12(a0)
	addi	t4, a2, -1
	mul	t1, t5, a2
	addi	s7, t5, -1
	mul	t3, t2, s5
	li	s3, 128
	j	.LBB2_5
.LBB2_4:                                # %for.cond11.for.cond.cleanup16_crit_edge.split.us.us.us
                                        #   in Loop: Header=BB2_5 Depth=1
	addi	a7, a7, 1
	add	t0, t0, t3
	beq	a7, a6, .LBB2_2
.LBB2_5:                                # %for.cond11.preheader.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_7 Depth 2
                                        #       Child Loop BB2_13 Depth 3
	li	s2, 0
	mul	t6, t1, a7
	mv	s6, t0
	j	.LBB2_7
.LBB2_6:                                # %for.cond70.for.cond.cleanup75_crit_edge.us.us.us
                                        #   in Loop: Header=BB2_7 Depth=2
	addi	s2, s2, 1
	add	s6, s6, s5
	beq	s2, t2, .LBB2_4
.LBB2_7:                                # %for.body17.us.us.us
                                        #   Parent Loop BB2_5 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_13 Depth 3
	srli	a0, s2, 1
	andi	a0, a0, 511
	blt	a0, t4, .LBB2_9
# %bb.8:                                # %for.body17.us.us.us
                                        #   in Loop: Header=BB2_7 Depth=2
	mv	a3, t4
	j	.LBB2_10
.LBB2_9:                                #   in Loop: Header=BB2_7 Depth=2
	addi	a3, a0, 1
.LBB2_10:                               # %for.body17.us.us.us
                                        #   in Loop: Header=BB2_7 Depth=2
	li	s1, 0
	slli	a2, s2, 6
	andi	a4, a2, 128
	add	a4, a4, a2
	andi	s8, a4, 192
	mul	a0, a0, t5
	add	s10, a0, t6
	and	a3, a3, s4
	mul	a3, a3, t5
	add	s11, a3, t6
	sub	a4, s3, a4
	andi	s9, a4, 192
	j	.LBB2_13
.LBB2_11:                               # %for.body76.us.us.us
                                        #   in Loop: Header=BB2_13 Depth=3
	mv	a4, s7
.LBB2_12:                               # %for.body76.us.us.us
                                        #   in Loop: Header=BB2_13 Depth=3
	slli	a2, s1, 6
	andi	a5, a2, 128
	add	a2, a2, a5
	andi	a5, a2, 192
	add	a0, s10, s0
	and	a4, a4, s4
	add	a3, a4, s10
	add	s0, s0, s11
	add	a3, a3, a1
	lb	a3, 0(a3)
	add	a4, a4, s11
	add	a0, a0, a1
	lb	a0, 0(a0)
	mul	a3, a3, a5
	sub	a2, s3, a2
	andi	a2, a2, 192
	mul	a0, a0, a2
	add	a4, a4, a1
	lb	a4, 0(a4)
	add	s0, s0, a1
	lb	s0, 0(s0)
	add	a0, a0, a3
	srli	a0, a0, 7
	mul	a3, a4, a5
	mul	a2, s0, a2
	add	a2, a2, a3
	srli	a2, a2, 7
	mul	a2, a2, s8
	mul	a0, a0, s9
	add	a0, a0, a2
	srli	a0, a0, 7
	add	a2, s6, s1
	addi	s1, s1, 1
	sb	a0, 0(a2)
	beq	s5, s1, .LBB2_6
.LBB2_13:                               # %for.body76.us.us.us
                                        #   Parent Loop BB2_5 Depth=1
                                        #     Parent Loop BB2_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	srli	a4, s1, 1
	andi	s0, a4, 511
	bge	s0, s7, .LBB2_11
# %bb.14:                               #   in Loop: Header=BB2_13 Depth=3
	addi	a4, s0, 1
	j	.LBB2_12
.Lfunc_end2:
	.size	resize_golden_v2, .Lfunc_end2-resize_golden_v2
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %for.cond11.preheader.us.us.preheader.i
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	sw	s1, 20(sp)                      # 4-byte Folded Spill
	sw	s2, 16(sp)                      # 4-byte Folded Spill
	sw	s3, 12(sp)                      # 4-byte Folded Spill
	sw	s4, 8(sp)                       # 4-byte Folded Spill
	sw	s5, 4(sp)                       # 4-byte Folded Spill
	li	t3, 0
	lui	a0, %hi(out_arr_global)
	addi	t6, a0, %lo(out_arr_global)
	#APP
	rdcycle	a6

	#NO_APP
	li	a7, 88
	lui	a0, 2
	addi	t2, a0, 1576
	li	t0, 111
	li	t5, 128
	lui	a0, %hi(src_arr_global)
	addi	a3, a0, %lo(src_arr_global)
	li	t4, 176
	li	t1, 224
	j	.LBB3_2
.LBB3_1:                                # %for.cond70.for.cond.cleanup75_crit_edge.us.us.us.i
                                        #   in Loop: Header=BB3_2 Depth=1
	addi	t3, t3, 1
	addi	t6, t6, 176
	beq	t3, t1, .LBB3_9
.LBB3_2:                                # %for.body17.us.us.us.i
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_7 Depth 2
	srli	a0, t3, 1
	andi	a0, a0, 511
	mul	s4, a0, a7
	bltu	a0, t0, .LBB3_4
# %bb.3:                                # %for.body17.us.us.us.i
                                        #   in Loop: Header=BB3_2 Depth=1
	mv	s5, t2
	j	.LBB3_5
.LBB3_4:                                #   in Loop: Header=BB3_2 Depth=1
	addi	s5, s4, 88
.LBB3_5:                                # %for.body17.us.us.us.i
                                        #   in Loop: Header=BB3_2 Depth=1
	li	a5, 0
	slli	a0, t3, 6
	andi	a2, a0, 128
	add	a2, a2, a0
	andi	s2, a2, 192
	sub	a2, t5, a2
	andi	s3, a2, 192
	j	.LBB3_7
.LBB3_6:                                # %for.body76.us.us.us.i
                                        #   in Loop: Header=BB3_7 Depth=2
	slli	a0, a5, 6
	andi	a2, a0, 128
	add	a0, a0, a2
	andi	a2, a0, 192
	add	a4, s4, s1
	add	a1, s0, s4
	add	s1, s1, s5
	add	a1, a1, a3
	lb	a1, 0(a1)
	add	s0, s0, s5
	add	a4, a4, a3
	lb	a4, 0(a4)
	mul	a1, a2, a1
	sub	a0, t5, a0
	andi	a0, a0, 192
	mul	a4, a0, a4
	add	s0, s0, a3
	lb	s0, 0(s0)
	add	s1, s1, a3
	lb	s1, 0(s1)
	add	a1, a1, a4
	srli	a1, a1, 7
	mul	a2, a2, s0
	mul	a0, a0, s1
	add	a0, a0, a2
	srli	a0, a0, 7
	mul	a0, a0, s2
	mul	a1, a1, s3
	add	a0, a0, a1
	srli	a0, a0, 7
	add	a1, t6, a5
	addi	a5, a5, 1
	sb	a0, 0(a1)
	beq	a5, t4, .LBB3_1
.LBB3_7:                                # %for.body76.us.us.us.i
                                        #   Parent Loop BB3_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	srli	s0, a5, 1
	andi	s1, s0, 511
	li	s0, 87
	bgeu	s1, s0, .LBB3_6
# %bb.8:                                #   in Loop: Header=BB3_7 Depth=2
	addi	s0, s1, 1
	j	.LBB3_6
.LBB3_9:                                # %for.cond11.for.cond.cleanup16_crit_edge.split.us.us.us.i
	#APP
	rdcycle	a0

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
	.addrsig
	.addrsig_sym src_arr_global
	.addrsig_sym out_arr_global
