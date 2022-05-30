	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_f2p0_d2p0_c2p0_v1p0_zve32f1p0_zve32x1p0_zve64d1p0_zve64f1p0_zve64x1p0_zvl128b1p0_zvl32b1p0_zvl64b1p0"
	.option	nopic
	.file	"correlation_v1_golden.c"
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
	.globl	correlation_golden              # -- Begin function correlation_golden
	.p2align	1
	.type	correlation_golden,@function
correlation_golden:                     # @correlation_golden
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
	lw	a1, 4(a0)
	sw	a1, 12(sp)                      # 4-byte Folded Spill
	beqz	a1, .LBB2_2
# %bb.1:                                # %for.cond6.preheader.lr.ph
	lw	s9, 8(a0)
	lw	a3, 12(a0)
	seqz	a1, s9
	seqz	a2, a3
	or	a1, a1, a2
	beqz	a1, .LBB2_3
.LBB2_2:                                # %for.cond.cleanup
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
.LBB2_3:                                # %for.cond6.preheader.lr.ph.split.us.split.us
	lw	a6, 0(a0)
	lw	s8, 28(a0)
	lw	a1, 12(sp)                      # 4-byte Folded Reload
	mul	s1, s9, a1
	beqz	a6, .LBB2_20
# %bb.4:                                # %for.cond6.preheader.us.us.us.preheader
	li	t0, 0
	lw	t4, 16(a0)
	lw	s11, 20(a0)
	lw	t2, 24(a0)
	addi	a0, a6, -1
	andi	a2, a6, 3
	sltiu	s7, a0, 3
	andi	t5, a6, -4
	seqz	a7, a2
	addi	a0, a2, -1
	seqz	a0, a0
	sw	a0, 88(sp)                      # 4-byte Folded Spill
	addi	a0, a2, -2
	seqz	a0, a0
	sw	a0, 76(sp)                      # 4-byte Folded Spill
	slli	a0, s1, 1
	add	t6, s11, a0
	slli	t1, s1, 2
	add	s2, t2, a0
	add	s3, s11, s1
	add	s4, t2, s1
	add	a0, a0, s1
	add	s5, s11, a0
	add	ra, t2, a0
	mv	s10, t2
	mv	t3, s11
	sw	s9, 52(sp)                      # 4-byte Folded Spill
	sw	a7, 80(sp)                      # 4-byte Folded Spill
	j	.LBB2_6
.LBB2_5:                                # %for.cond6.for.cond.cleanup8_crit_edge.split.us.split.us.us.us.us
                                        #   in Loop: Header=BB2_6 Depth=1
	lw	t0, 48(sp)                      # 4-byte Folded Reload
	addi	t0, t0, 1
	lw	t6, 44(sp)                      # 4-byte Folded Reload
	add	t6, t6, s9
	lw	s2, 40(sp)                      # 4-byte Folded Reload
	add	s2, s2, s9
	lw	s3, 36(sp)                      # 4-byte Folded Reload
	add	s3, s3, s9
	lw	s4, 32(sp)                      # 4-byte Folded Reload
	add	s4, s4, s9
	lw	s5, 28(sp)                      # 4-byte Folded Reload
	add	s5, s5, s9
	lw	ra, 24(sp)                      # 4-byte Folded Reload
	add	ra, ra, s9
	lw	t3, 16(sp)                      # 4-byte Folded Reload
	add	t3, t3, s9
	lw	s10, 20(sp)                     # 4-byte Folded Reload
	add	s10, s10, s9
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	beq	t0, a0, .LBB2_2
.LBB2_6:                                # %for.cond6.preheader.us.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_8 Depth 2
                                        #       Child Loop BB2_11 Depth 3
                                        #         Child Loop BB2_15 Depth 4
	li	a5, 0
	sw	t0, 48(sp)                      # 4-byte Folded Spill
	mul	a0, t0, s9
	sw	a0, 56(sp)                      # 4-byte Folded Spill
	sw	s10, 20(sp)                     # 4-byte Folded Spill
	sw	t3, 16(sp)                      # 4-byte Folded Spill
	sw	ra, 24(sp)                      # 4-byte Folded Spill
	sw	s5, 28(sp)                      # 4-byte Folded Spill
	sw	s4, 32(sp)                      # 4-byte Folded Spill
	sw	s3, 36(sp)                      # 4-byte Folded Spill
	sw	s2, 40(sp)                      # 4-byte Folded Spill
	sw	t6, 44(sp)                      # 4-byte Folded Spill
	j	.LBB2_8
.LBB2_7:                                # %for.cond10.for.cond.cleanup12_crit_edge.split.us.us.us.us.us.us
                                        #   in Loop: Header=BB2_8 Depth=2
	addi	a5, a5, 1
	addi	t6, t6, 1
	lw	s2, 60(sp)                      # 4-byte Folded Reload
	addi	s2, s2, 1
	addi	s3, s3, 1
	lw	s4, 64(sp)                      # 4-byte Folded Reload
	addi	s4, s4, 1
	addi	s5, s5, 1
	lw	ra, 68(sp)                      # 4-byte Folded Reload
	addi	ra, ra, 1
	addi	t3, t3, 1
	lw	s10, 72(sp)                     # 4-byte Folded Reload
	addi	s10, s10, 1
	lw	s9, 52(sp)                      # 4-byte Folded Reload
	beq	a5, s9, .LBB2_5
.LBB2_8:                                # %for.cond10.preheader.us.us.us.us.us
                                        #   Parent Loop BB2_6 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_11 Depth 3
                                        #         Child Loop BB2_15 Depth 4
	li	a6, 0
	lw	a0, 56(sp)                      # 4-byte Folded Reload
	add	s6, a5, a0
	sw	s10, 72(sp)                     # 4-byte Folded Spill
	sw	ra, 68(sp)                      # 4-byte Folded Spill
	sw	s4, 64(sp)                      # 4-byte Folded Spill
	sw	s2, 60(sp)                      # 4-byte Folded Spill
	sw	a5, 84(sp)                      # 4-byte Folded Spill
	j	.LBB2_11
.LBB2_9:                                #   in Loop: Header=BB2_11 Depth=3
	li	s9, 0
.LBB2_10:                               # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us
                                        #   in Loop: Header=BB2_11 Depth=3
	mul	a0, s1, a6
	add	a0, a0, s6
	slli	a1, s9, 16
	srai	a1, a1, 16
	sra	a1, a1, t4
	add	a0, a0, s8
	sb	a1, 0(a0)
	addi	a6, a6, 1
	addi	s2, s2, -1
	addi	s4, s4, -1
	addi	ra, ra, -1
	addi	s10, s10, -1
	beq	a6, a3, .LBB2_7
.LBB2_11:                               # %for.body13.us.us.us.us.us.us
                                        #   Parent Loop BB2_6 Depth=1
                                        #     Parent Loop BB2_8 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_15 Depth 4
	bltu	a5, a6, .LBB2_9
# %bb.12:                               # %for.body20.us108.us.us.us.us.us.preheader
                                        #   in Loop: Header=BB2_11 Depth=3
	beqz	s7, .LBB2_14
# %bb.13:                               #   in Loop: Header=BB2_11 Depth=3
	li	a1, 0
	li	s9, 0
	beqz	a7, .LBB2_17
	j	.LBB2_10
.LBB2_14:                               # %for.body20.us108.us.us.us.us.us.preheader162
                                        #   in Loop: Header=BB2_11 Depth=3
	mv	t0, s1
	mv	a7, a3
	li	a3, 0
	li	a5, 0
	li	s9, 0
.LBB2_15:                               # %for.body20.us108.us.us.us.us.us
                                        #   Parent Loop BB2_6 Depth=1
                                        #     Parent Loop BB2_8 Depth=2
                                        #       Parent Loop BB2_11 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	add	a4, s10, a3
	lb	a4, 0(a4)
	add	a1, t3, a3
	lb	a1, 0(a1)
	add	s1, s4, a3
	lb	s1, 0(s1)
	add	s0, s3, a3
	lb	s0, 0(s0)
	mul	a1, a1, a4
	add	a1, a1, s9
	mul	a4, s0, s1
	add	s1, s2, a3
	lb	s1, 0(s1)
	add	s0, t6, a3
	lb	s0, 0(s0)
	add	a2, ra, a3
	lb	a2, 0(a2)
	add	a0, s5, a3
	lb	a0, 0(a0)
	add	a1, a1, a4
	mul	a4, s0, s1
	add	a1, a1, a4
	mul	a0, a0, a2
	add	s9, a0, a1
	addi	a5, a5, 4
	add	a3, a3, t1
	bne	a5, t5, .LBB2_15
# %bb.16:                               #   in Loop: Header=BB2_11 Depth=3
	mv	a1, t5
	mv	a3, a7
	mv	s1, t0
	lw	a7, 80(sp)                      # 4-byte Folded Reload
	lw	a5, 84(sp)                      # 4-byte Folded Reload
	bnez	a7, .LBB2_10
.LBB2_17:                               # %for.body20.us108.us.us.us.us.us.epil
                                        #   in Loop: Header=BB2_11 Depth=3
	mul	a0, s1, a1
	add	a0, a0, s6
	sub	a2, a0, a6
	add	a2, a2, t2
	lb	a2, 0(a2)
	add	a0, a0, s11
	lb	a0, 0(a0)
	mul	a0, a0, a2
	add	s9, s9, a0
	lw	a0, 88(sp)                      # 4-byte Folded Reload
	bnez	a0, .LBB2_10
# %bb.18:                               # %for.body20.us108.us.us.us.us.us.epil.1
                                        #   in Loop: Header=BB2_11 Depth=3
	addi	a0, a1, 1
	mul	a0, s1, a0
	add	a0, a0, s6
	sub	a2, a0, a6
	add	a2, a2, t2
	lb	a2, 0(a2)
	add	a0, a0, s11
	lb	a0, 0(a0)
	mul	a0, a0, a2
	add	s9, s9, a0
	lw	a0, 76(sp)                      # 4-byte Folded Reload
	bnez	a0, .LBB2_10
# %bb.19:                               # %for.body20.us108.us.us.us.us.us.epil.2
                                        #   in Loop: Header=BB2_11 Depth=3
	addi	a0, a1, 2
	mul	a0, s1, a0
	add	a0, a0, s6
	sub	a1, a0, a6
	add	a1, a1, t2
	lb	a1, 0(a1)
	add	a0, a0, s11
	lb	a0, 0(a0)
	mul	a0, a0, a1
	add	s9, s9, a0
	j	.LBB2_10
.LBB2_20:                               # %for.cond6.preheader.us.us.preheader
	li	s7, 0
	addi	a0, a3, -1
	andi	a1, a3, 3
	sltiu	t6, a0, 3
	andi	t2, a3, -4
	seqz	s2, a1
	addi	a0, a1, -1
	seqz	t4, a0
	addi	a0, a1, -2
	seqz	t3, a0
	slli	a0, s1, 1
	add	a6, s8, a0
	slli	s6, s1, 2
	add	t0, s8, s1
	add	a0, a0, s1
	add	t1, s8, a0
	mv	s4, s8
	j	.LBB2_22
.LBB2_21:                               # %for.cond6.for.cond.cleanup8_crit_edge.split.us.split.us141.us
                                        #   in Loop: Header=BB2_22 Depth=1
	addi	s7, s7, 1
	add	a6, a6, s9
	add	t0, t0, s9
	add	t1, t1, s9
	add	s4, s4, s9
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	beq	s7, a0, .LBB2_2
.LBB2_22:                               # %for.cond6.preheader.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_24 Depth 2
                                        #       Child Loop BB2_26 Depth 3
	li	s3, 0
	mul	t5, s7, s9
	mv	a2, s4
	mv	a1, t1
	mv	a5, t0
	mv	s0, a6
	j	.LBB2_24
.LBB2_23:                               # %for.cond10.for.cond.cleanup12_crit_edge.split.us125.us.us
                                        #   in Loop: Header=BB2_24 Depth=2
	addi	s3, s3, 1
	addi	s0, s0, 1
	addi	a5, a5, 1
	addi	a1, a1, 1
	addi	a2, a2, 1
	beq	s3, s9, .LBB2_21
.LBB2_24:                               # %for.cond10.preheader.us.us136.us
                                        #   Parent Loop BB2_22 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_26 Depth 3
	li	a3, 0
	bnez	t6, .LBB2_28
# %bb.25:                               # %for.body13.us118.us.us.preheader
                                        #   in Loop: Header=BB2_24 Depth=2
	li	a3, 0
	li	a0, 0
.LBB2_26:                               # %for.body13.us118.us.us
                                        #   Parent Loop BB2_22 Depth=1
                                        #     Parent Loop BB2_24 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	add	a4, a2, a3
	sb	zero, 0(a4)
	add	a4, a5, a3
	sb	zero, 0(a4)
	add	a4, s0, a3
	sb	zero, 0(a4)
	add	a4, a1, a3
	sb	zero, 0(a4)
	addi	a0, a0, 4
	add	a3, a3, s6
	bne	a0, t2, .LBB2_26
# %bb.27:                               #   in Loop: Header=BB2_24 Depth=2
	mv	a3, t2
.LBB2_28:                               # %for.cond10.for.cond.cleanup12_crit_edge.split.us125.us.us.unr-lcssa
                                        #   in Loop: Header=BB2_24 Depth=2
	bnez	s2, .LBB2_23
# %bb.29:                               # %for.body13.us118.us.us.epil
                                        #   in Loop: Header=BB2_24 Depth=2
	add	s5, s3, t5
	mul	a0, s1, a3
	add	a0, a0, s5
	add	a0, a0, s8
	sb	zero, 0(a0)
	bnez	t4, .LBB2_23
# %bb.30:                               # %for.body13.us118.us.us.epil.1
                                        #   in Loop: Header=BB2_24 Depth=2
	addi	a0, a3, 1
	mul	a0, s1, a0
	add	a0, a0, s5
	add	a0, a0, s8
	sb	zero, 0(a0)
	bnez	t3, .LBB2_23
# %bb.31:                               # %for.body13.us118.us.us.epil.2
                                        #   in Loop: Header=BB2_24 Depth=2
	addi	a0, a3, 2
	mul	a0, s1, a0
	add	a0, a0, s5
	add	a0, a0, s8
	sb	zero, 0(a0)
	j	.LBB2_23
.Lfunc_end2:
	.size	correlation_golden, .Lfunc_end2-correlation_golden
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %for.cond6.preheader.lr.ph.split.us.split.us.i
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
	li	t1, 0
	lui	a0, 7
	addi	s2, a0, 896
	lui	a0, 5
	addi	s11, a0, -768
	lui	a0, %hi(src0_arr_global)
	addi	t3, a0, %lo(src0_arr_global)
	lui	a0, %hi(src1_arr_global)
	addi	a6, a0, %lo(src1_arr_global)
	#APP
	rdcycle	a0

	#NO_APP
	sw	a0, 8(sp)                       # 4-byte Folded Spill
	li	t2, 88
	lui	a0, 2
	addi	s5, a0, 1664
	lui	a0, 140
	addi	ra, a0, -1792
	lui	a0, %hi(out_arr_global)
	addi	s7, a0, %lo(out_arr_global)
	lui	a0, 10
	addi	s3, a0, -1536
	li	t4, 2
	li	t5, 3
	li	t6, 4
	j	.LBB3_2
.LBB3_1:                                # %for.cond6.for.cond.cleanup8_crit_edge.split.us.split.us.us.us.us.i
                                        #   in Loop: Header=BB3_2 Depth=1
	addi	t1, t1, 1
	addi	t3, t3, 88
	addi	a6, a6, 88
	li	a0, 112
	beq	t1, a0, .LBB3_22
.LBB3_2:                                # %for.cond6.preheader.us.us.us.i
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_7 Depth 2
                                        #       Child Loop BB3_8 Depth 3
                                        #       Child Loop BB3_11 Depth 3
                                        #       Child Loop BB3_14 Depth 3
                                        #       Child Loop BB3_17 Depth 3
                                        #       Child Loop BB3_21 Depth 3
	li	s9, 0
	mul	s4, t1, t2
	mv	t0, a6
	mv	a7, t3
	j	.LBB3_7
.LBB3_3:                                # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i.1.thread
                                        #   in Loop: Header=BB3_7 Depth=2
	add	a0, s8, s7
	sb	zero, 0(a0)
	add	s8, s10, s11
.LBB3_4:                                # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i.2.thread
                                        #   in Loop: Header=BB3_7 Depth=2
	add	a0, s8, s7
	sb	zero, 0(a0)
	add	s8, s10, s2
.LBB3_5:                                # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i.3.thread
                                        #   in Loop: Header=BB3_7 Depth=2
	li	a0, 0
	add	a1, s8, s7
	sb	zero, 0(a1)
.LBB3_6:                                # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i.4
                                        #   in Loop: Header=BB3_7 Depth=2
	add	a1, s6, s3
	sb	a0, 0(a1)
	addi	s9, s9, 1
	addi	a7, a7, 1
	addi	t0, t0, 1
	beq	s9, t2, .LBB3_1
.LBB3_7:                                # %for.body20.us108.us.us.us.us.us.i.preheader
                                        #   Parent Loop BB3_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_8 Depth 3
                                        #       Child Loop BB3_11 Depth 3
                                        #       Child Loop BB3_14 Depth 3
                                        #       Child Loop BB3_17 Depth 3
                                        #       Child Loop BB3_21 Depth 3
	li	a0, 0
	li	s0, 0
	add	a4, a7, s5
	add	s1, t0, s5
.LBB3_8:                                # %for.body20.us108.us.us.us.us.us.i
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	add	a2, t0, a0
	lb	a2, 0(a2)
	add	a5, a7, a0
	lb	a5, 0(a5)
	add	a1, s1, a0
	lb	a1, 0(a1)
	add	a3, a4, a0
	lb	a3, 0(a3)
	mul	a2, a5, a2
	add	a2, a2, s0
	mul	a1, a3, a1
	add	a0, a0, s11
	add	s0, a1, a2
	bne	a0, ra, .LBB3_8
# %bb.9:                                # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i
                                        #   in Loop: Header=BB3_7 Depth=2
	add	s10, s9, s4
	add	s6, s10, s7
	sb	s0, 0(s6)
	add	s8, s10, s5
	beqz	s9, .LBB3_3
# %bb.10:                               # %for.body20.us108.us.us.us.us.us.i.1.preheader
                                        #   in Loop: Header=BB3_7 Depth=2
	li	s0, 0
	li	a0, 0
.LBB3_11:                               # %for.body20.us108.us.us.us.us.us.i.1
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	add	a1, t0, s0
	lb	a1, -1(a1)
	add	a2, a7, s0
	lb	a2, 0(a2)
	add	a3, s1, s0
	lb	a3, -1(a3)
	add	a5, a4, s0
	lb	a5, 0(a5)
	mul	a1, a2, a1
	add	a0, a0, a1
	mul	a1, a5, a3
	add	s0, s0, s11
	add	a0, a0, a1
	bne	s0, ra, .LBB3_11
# %bb.12:                               # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i.1
                                        #   in Loop: Header=BB3_7 Depth=2
	add	a1, s8, s7
	sb	a0, 0(a1)
	add	s8, s10, s11
	bltu	s9, t4, .LBB3_4
# %bb.13:                               # %for.body20.us108.us.us.us.us.us.i.2.preheader
                                        #   in Loop: Header=BB3_7 Depth=2
	li	s0, 0
	li	a0, 0
.LBB3_14:                               # %for.body20.us108.us.us.us.us.us.i.2
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	add	a1, t0, s0
	lb	a1, -2(a1)
	add	a2, a7, s0
	lb	a2, 0(a2)
	add	a3, s1, s0
	lb	a3, -2(a3)
	add	a5, a4, s0
	lb	a5, 0(a5)
	mul	a1, a2, a1
	add	a0, a0, a1
	mul	a1, a5, a3
	add	s0, s0, s11
	add	a0, a0, a1
	bne	s0, ra, .LBB3_14
# %bb.15:                               # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i.2
                                        #   in Loop: Header=BB3_7 Depth=2
	add	a1, s8, s7
	sb	a0, 0(a1)
	add	s8, s10, s2
	bltu	s9, t5, .LBB3_5
# %bb.16:                               # %for.body20.us108.us.us.us.us.us.i.3.preheader
                                        #   in Loop: Header=BB3_7 Depth=2
	li	a0, 0
	li	s0, 0
.LBB3_17:                               # %for.body20.us108.us.us.us.us.us.i.3
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	add	a1, t0, a0
	lb	a1, -3(a1)
	add	a2, a7, a0
	lb	a2, 0(a2)
	add	a3, s1, a0
	lb	a3, -3(a3)
	add	a5, a4, a0
	lb	a5, 0(a5)
	mul	a1, a2, a1
	add	a1, a1, s0
	mul	a2, a5, a3
	add	a0, a0, s11
	add	s0, a2, a1
	bne	a0, ra, .LBB3_17
# %bb.18:                               # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i.3
                                        #   in Loop: Header=BB3_7 Depth=2
	add	a0, s8, s7
	sb	s0, 0(a0)
	bgeu	s9, t6, .LBB3_20
# %bb.19:                               #   in Loop: Header=BB3_7 Depth=2
	li	a0, 0
	j	.LBB3_6
.LBB3_20:                               # %for.body20.us108.us.us.us.us.us.i.4.preheader
                                        #   in Loop: Header=BB3_7 Depth=2
	li	s0, 0
	li	a0, 0
.LBB3_21:                               # %for.body20.us108.us.us.us.us.us.i.4
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	add	a1, t0, s0
	lb	a1, -4(a1)
	add	a2, a7, s0
	lb	a2, 0(a2)
	add	a3, s1, s0
	lb	a3, -4(a3)
	add	a5, a4, s0
	lb	a5, 0(a5)
	mul	a1, a2, a1
	add	a0, a0, a1
	mul	a1, a5, a3
	add	s0, s0, s11
	add	a0, a0, a1
	bne	s0, ra, .LBB3_21
	j	.LBB3_6
.LBB3_22:                               # %correlation_golden.exit
	#APP
	rdcycle	a0

	#NO_APP
	lw	a1, 8(sp)                       # 4-byte Folded Reload
	sub	a1, a0, a1
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
	lw	s10, 16(sp)                     # 4-byte Folded Reload
	lw	s11, 12(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 64
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
