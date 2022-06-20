	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_a2p0_f2p0_d2p0_c2p0_v0p10"
	.option	nopic
	.file	"correlation_ref.c"
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
	.globl	correlation_param_read          # -- Begin function correlation_param_read
	.p2align	2
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
	.p2align	2
	.type	correlation_golden,@function
correlation_golden:                     # @correlation_golden
# %bb.0:                                # %entry
	addi	sp, sp, -16
	sw	s0, 12(sp)                      # 4-byte Folded Spill
	sw	s1, 8(sp)                       # 4-byte Folded Spill
	sw	s2, 4(sp)                       # 4-byte Folded Spill
	sw	s3, 0(sp)                       # 4-byte Folded Spill
	lw	a6, 12(a0)
	beqz	a6, .LBB2_2
# %bb.1:                                # %for.cond6.preheader.lr.ph
	lw	a7, 4(a0)
	lw	t1, 8(a0)
	seqz	a1, a7
	seqz	a2, t1
	or	a1, a1, a2
	beqz	a1, .LBB2_3
.LBB2_2:                                # %for.cond.cleanup
	lw	s0, 12(sp)                      # 4-byte Folded Reload
	lw	s1, 8(sp)                       # 4-byte Folded Reload
	lw	s2, 4(sp)                       # 4-byte Folded Reload
	lw	s3, 0(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.LBB2_3:                                # %for.cond6.preheader.lr.ph.split.us.split.us
	lw	a2, 0(a0)
	lw	t0, 28(a0)
	lw	t3, 16(a0)
	mul	a1, t1, a7
	beqz	a2, .LBB2_14
# %bb.4:                                # %for.cond6.preheader.us.us.us.preheader
	lw	s2, 20(a0)
	lw	s3, 24(a0)
	li	a3, 0
                                        # implicit-def: $v8
	j	.LBB2_6
.LBB2_5:                                # %for.cond6.for.cond.cleanup8_crit_edge.split.us.split.us.us.us.us
                                        #   in Loop: Header=BB2_6 Depth=1
	addi	a3, a3, 1
	beq	a3, a6, .LBB2_2
.LBB2_6:                                # %for.cond6.preheader.us.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_8 Depth 2
                                        #       Child Loop BB2_10 Depth 3
                                        #         Child Loop BB2_12 Depth 4
	li	t2, 0
	mul	t4, a1, a3
	j	.LBB2_8
.LBB2_7:                                # %for.cond10.for.cond.cleanup12_crit_edge.split.us.us.us.us.us.us
                                        #   in Loop: Header=BB2_8 Depth=2
	addi	t2, t2, 1
	beq	t2, a7, .LBB2_5
.LBB2_8:                                # %for.cond10.preheader.us.us.us.us.us
                                        #   Parent Loop BB2_6 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_10 Depth 3
                                        #         Child Loop BB2_12 Depth 4
	li	t6, 0
	mul	t5, t2, t1
	j	.LBB2_10
.LBB2_9:                                # %if.end.us.us.us.us.us.us
                                        #   in Loop: Header=BB2_10 Depth=3
	add	a0, a5, t4
	sra	a4, s0, t3
	add	a0, a0, t0
	addi	t6, t6, 1
	sb	a4, 0(a0)
	beq	t6, t1, .LBB2_7
.LBB2_10:                               # %for.body13.us.us.us.us.us.us
                                        #   Parent Loop BB2_6 Depth=1
                                        #     Parent Loop BB2_8 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_12 Depth 4
	add	a5, t6, t5
	li	s0, 0
	bltu	t6, a3, .LBB2_9
# %bb.11:                               # %if.then.us.us.us.us.us.us
                                        #   in Loop: Header=BB2_10 Depth=3
	vsetivli	zero, 1, e16, m1, tu, mu
	vmv.s.x	v8, zero
.LBB2_12:                               # %for.body21.us.us.us.us.us.us
                                        #   Parent Loop BB2_6 Depth=1
                                        #     Parent Loop BB2_8 Depth=2
                                        #       Parent Loop BB2_10 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	sub	s1, a2, s0
	vsetvli	s1, s1, e8, m4, ta, mu
	mul	a4, a1, s0
	add	a4, a4, a5
	sub	a0, a4, a3
	add	a4, a4, s2
	vlse8.v	v12, (a4), a1
	add	a0, a0, s3
	vlse8.v	v16, (a0), a1
	vwmul.vv	v24, v12, v16
	vsetvli	zero, s1, e16, m8, tu, mu
	add	s0, s0, s1
	vredsum.vs	v8, v24, v8
	bltu	s0, a2, .LBB2_12
# %bb.13:                               # %for.cond18.for.cond.cleanup20_crit_edge.us.us.us.us.us.us
                                        #   in Loop: Header=BB2_10 Depth=3
	vmv.x.s	s0, v8
	j	.LBB2_9
.LBB2_14:                               # %for.cond6.preheader.us.us.preheader
	li	a0, 0
                                        # implicit-def: $v8
	j	.LBB2_16
.LBB2_15:                               # %for.cond6.for.cond.cleanup8_crit_edge.split.us.split.us159.us
                                        #   in Loop: Header=BB2_16 Depth=1
	addi	a0, a0, 1
	add	t0, t0, a1
	beq	a0, a6, .LBB2_2
.LBB2_16:                               # %for.cond6.preheader.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_18 Depth 2
                                        #       Child Loop BB2_21 Depth 3
	li	a2, 0
	mv	a3, t0
	j	.LBB2_18
.LBB2_17:                               # %for.cond10.for.cond.cleanup12_crit_edge.split.us136.us.us
                                        #   in Loop: Header=BB2_18 Depth=2
	addi	a2, a2, 1
	add	a3, a3, t1
	beq	a2, a7, .LBB2_15
.LBB2_18:                               # %for.cond10.preheader.us.us153.us
                                        #   Parent Loop BB2_16 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_21 Depth 3
	li	a4, 0
	j	.LBB2_21
.LBB2_19:                               # %if.then.us127.us.us
                                        #   in Loop: Header=BB2_21 Depth=3
	vsetivli	zero, 1, e16, m1, tu, mu
	vmv.s.x	v8, zero
	vmv.x.s	a5, v8
.LBB2_20:                               # %if.end.us128.us.us
                                        #   in Loop: Header=BB2_21 Depth=3
	sra	a5, a5, t3
	add	s1, a3, a4
	addi	a4, a4, 1
	sb	a5, 0(s1)
	beq	t1, a4, .LBB2_17
.LBB2_21:                               # %for.body13.us121.us.us
                                        #   Parent Loop BB2_16 Depth=1
                                        #     Parent Loop BB2_18 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	bgeu	a4, a0, .LBB2_19
# %bb.22:                               #   in Loop: Header=BB2_21 Depth=3
	li	a5, 0
	j	.LBB2_20
.Lfunc_end2:
	.size	correlation_golden, .Lfunc_end2-correlation_golden
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %for.cond6.preheader.lr.ph.split.us.split.us.i
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	sw	s1, 4(sp)                       # 4-byte Folded Spill
	sw	s2, 0(sp)                       # 4-byte Folded Spill
	li	t0, 0
	lui	a0, 2
	addi	a1, a0, 1664
	#APP
	csrr	a6, mcycle

	#NO_APP
	li	t1, 88
	li	s2, 58
	lui	a0, %hi(src0_arr_global)
	addi	a4, a0, %lo(src0_arr_global)
	lui	a0, %hi(src1_arr_global)
	addi	a5, a0, %lo(src1_arr_global)
	lui	a0, %hi(out_arr_global)
	addi	t5, a0, %lo(out_arr_global)
	li	a7, 112
                                        # implicit-def: $v8
.LBB3_1:                                # %for.cond10.preheader.us.us.us.us.us.i
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_2 Depth 2
                                        #       Child Loop BB3_3 Depth 3
	li	t3, 0
	mul	t2, t0, t1
.LBB3_2:                                # %if.then.us.us.us.us.us.us.i
                                        #   Parent Loop BB3_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_3 Depth 3
	li	a0, 0
	add	a2, t3, t2
	vsetivli	zero, 1, e16, m1, tu, mu
	vmv.s.x	v8, zero
.LBB3_3:                                # %for.body21.us.us.us.us.us.us.i
                                        #   Parent Loop BB3_1 Depth=1
                                        #     Parent Loop BB3_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a3, s2, a0
	vsetvli	a3, a3, e8, m4, ta, mu
	mul	s0, a0, a1
	add	s0, s0, a2
	add	s1, s0, a4
	vlse8.v	v12, (s1), a1
	add	s1, s0, a5
	vlse8.v	v16, (s1), a1
	vwmul.vv	v24, v12, v16
	vsetvli	zero, a3, e16, m8, tu, mu
	add	a0, a0, a3
	vredsum.vs	v8, v24, v8
	bltu	a0, s2, .LBB3_3
# %bb.4:                                # %if.end.us.us.us.us.us.us.i
                                        #   in Loop: Header=BB3_2 Depth=2
	vmv.x.s	a0, v8
	add	a2, a2, t5
	addi	t3, t3, 1
	sb	a0, 0(a2)
	bne	t3, t1, .LBB3_2
# %bb.5:                                # %for.cond10.for.cond.cleanup12_crit_edge.split.us.us.us.us.us.us.i
                                        #   in Loop: Header=BB3_1 Depth=1
	addi	t0, t0, 1
	bne	t0, a7, .LBB3_1
# %bb.6:                                # %for.cond10.preheader.us.us.us.us.us.i.1.preheader
	li	t0, 0
	j	.LBB3_8
.LBB3_7:                                # %for.cond10.for.cond.cleanup12_crit_edge.split.us.us.us.us.us.us.i.1
                                        #   in Loop: Header=BB3_8 Depth=1
	addi	t0, t0, 1
	beq	t0, a7, .LBB3_14
.LBB3_8:                                # %for.cond10.preheader.us.us.us.us.us.i.1
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_10 Depth 2
                                        #       Child Loop BB3_12 Depth 3
	li	t3, 0
	mul	t2, t0, t1
	j	.LBB3_10
.LBB3_9:                                # %if.end.us.us.us.us.us.us.i.1
                                        #   in Loop: Header=BB3_10 Depth=2
	add	a0, a0, a1
	add	a0, a0, t5
	addi	t3, t3, 1
	sb	a2, 0(a0)
	beq	t3, t1, .LBB3_7
.LBB3_10:                               # %for.body13.us.us.us.us.us.us.i.1
                                        #   Parent Loop BB3_8 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_12 Depth 3
	add	a0, t3, t2
	li	a2, 0
	beqz	t3, .LBB3_9
# %bb.11:                               # %if.then.us.us.us.us.us.us.i.1
                                        #   in Loop: Header=BB3_10 Depth=2
	vsetivli	zero, 1, e16, m1, tu, mu
	vmv.s.x	v8, zero
.LBB3_12:                               # %for.body21.us.us.us.us.us.us.i.1
                                        #   Parent Loop BB3_8 Depth=1
                                        #     Parent Loop BB3_10 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a3, s2, a2
	vsetvli	a3, a3, e8, m4, ta, mu
	mul	s1, a2, a1
	add	s1, s1, a0
	add	s0, s1, a4
	vlse8.v	v12, (s0), a1
	add	s1, s1, a5
	addi	s1, s1, -1
	vlse8.v	v16, (s1), a1
	vwmul.vv	v24, v12, v16
	vsetvli	zero, a3, e16, m8, tu, mu
	add	a2, a2, a3
	vredsum.vs	v8, v24, v8
	bltu	a2, s2, .LBB3_12
# %bb.13:                               # %for.cond18.for.cond.cleanup20_crit_edge.us.us.us.us.us.us.i.1
                                        #   in Loop: Header=BB3_10 Depth=2
	vmv.x.s	a2, v8
	j	.LBB3_9
.LBB3_14:                               # %for.cond10.preheader.us.us.us.us.us.i.2.preheader
	li	t0, 0
	lui	a0, 5
	addi	t3, a0, -768
	li	t2, 2
	j	.LBB3_16
.LBB3_15:                               # %for.cond10.for.cond.cleanup12_crit_edge.split.us.us.us.us.us.us.i.2
                                        #   in Loop: Header=BB3_16 Depth=1
	addi	t0, t0, 1
	beq	t0, a7, .LBB3_22
.LBB3_16:                               # %for.cond10.preheader.us.us.us.us.us.i.2
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_18 Depth 2
                                        #       Child Loop BB3_20 Depth 3
	li	t6, 0
	mul	t4, t0, t1
	j	.LBB3_18
.LBB3_17:                               # %if.end.us.us.us.us.us.us.i.2
                                        #   in Loop: Header=BB3_18 Depth=2
	add	a0, a0, t3
	add	a0, a0, t5
	addi	t6, t6, 1
	sb	a2, 0(a0)
	beq	t6, t1, .LBB3_15
.LBB3_18:                               # %for.body13.us.us.us.us.us.us.i.2
                                        #   Parent Loop BB3_16 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_20 Depth 3
	add	a0, t6, t4
	li	a2, 0
	bltu	t6, t2, .LBB3_17
# %bb.19:                               # %if.then.us.us.us.us.us.us.i.2
                                        #   in Loop: Header=BB3_18 Depth=2
	vsetivli	zero, 1, e16, m1, tu, mu
	vmv.s.x	v8, zero
.LBB3_20:                               # %for.body21.us.us.us.us.us.us.i.2
                                        #   Parent Loop BB3_16 Depth=1
                                        #     Parent Loop BB3_18 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a3, s2, a2
	vsetvli	a3, a3, e8, m4, ta, mu
	mul	s0, a2, a1
	add	s0, s0, a0
	add	s1, s0, a4
	vlse8.v	v12, (s1), a1
	add	s0, s0, a5
	addi	s0, s0, -2
	vlse8.v	v16, (s0), a1
	vwmul.vv	v24, v12, v16
	vsetvli	zero, a3, e16, m8, tu, mu
	add	a2, a2, a3
	vredsum.vs	v8, v24, v8
	bltu	a2, s2, .LBB3_20
# %bb.21:                               # %for.cond18.for.cond.cleanup20_crit_edge.us.us.us.us.us.us.i.2
                                        #   in Loop: Header=BB3_18 Depth=2
	vmv.x.s	a2, v8
	j	.LBB3_17
.LBB3_22:                               # %for.cond10.preheader.us.us.us.us.us.i.3.preheader
	li	t0, 0
	lui	a0, 7
	addi	t3, a0, 896
	li	t2, 3
	j	.LBB3_24
.LBB3_23:                               # %for.cond10.for.cond.cleanup12_crit_edge.split.us.us.us.us.us.us.i.3
                                        #   in Loop: Header=BB3_24 Depth=1
	addi	t0, t0, 1
	beq	t0, a7, .LBB3_30
.LBB3_24:                               # %for.cond10.preheader.us.us.us.us.us.i.3
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_26 Depth 2
                                        #       Child Loop BB3_28 Depth 3
	li	t6, 0
	mul	t4, t0, t1
	j	.LBB3_26
.LBB3_25:                               # %if.end.us.us.us.us.us.us.i.3
                                        #   in Loop: Header=BB3_26 Depth=2
	add	a0, a0, t3
	add	a0, a0, t5
	addi	t6, t6, 1
	sb	a2, 0(a0)
	beq	t6, t1, .LBB3_23
.LBB3_26:                               # %for.body13.us.us.us.us.us.us.i.3
                                        #   Parent Loop BB3_24 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_28 Depth 3
	add	a0, t6, t4
	li	a2, 0
	bltu	t6, t2, .LBB3_25
# %bb.27:                               # %if.then.us.us.us.us.us.us.i.3
                                        #   in Loop: Header=BB3_26 Depth=2
	vsetivli	zero, 1, e16, m1, tu, mu
	vmv.s.x	v8, zero
.LBB3_28:                               # %for.body21.us.us.us.us.us.us.i.3
                                        #   Parent Loop BB3_24 Depth=1
                                        #     Parent Loop BB3_26 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a3, s2, a2
	vsetvli	a3, a3, e8, m4, ta, mu
	mul	s0, a2, a1
	add	s0, s0, a0
	add	s1, s0, a4
	vlse8.v	v12, (s1), a1
	add	s0, s0, a5
	addi	s0, s0, -3
	vlse8.v	v16, (s0), a1
	vwmul.vv	v24, v12, v16
	vsetvli	zero, a3, e16, m8, tu, mu
	add	a2, a2, a3
	vredsum.vs	v8, v24, v8
	bltu	a2, s2, .LBB3_28
# %bb.29:                               # %for.cond18.for.cond.cleanup20_crit_edge.us.us.us.us.us.us.i.3
                                        #   in Loop: Header=BB3_26 Depth=2
	vmv.x.s	a2, v8
	j	.LBB3_25
.LBB3_30:                               # %for.cond10.preheader.us.us.us.us.us.i.4.preheader
	li	t0, 0
	lui	a0, 10
	addi	t3, a0, -1536
	li	t2, 4
	j	.LBB3_32
.LBB3_31:                               # %for.cond10.for.cond.cleanup12_crit_edge.split.us.us.us.us.us.us.i.4
                                        #   in Loop: Header=BB3_32 Depth=1
	addi	t0, t0, 1
	beq	t0, a7, .LBB3_38
.LBB3_32:                               # %for.cond10.preheader.us.us.us.us.us.i.4
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_34 Depth 2
                                        #       Child Loop BB3_36 Depth 3
	li	t6, 0
	mul	t4, t0, t1
	j	.LBB3_34
.LBB3_33:                               # %if.end.us.us.us.us.us.us.i.4
                                        #   in Loop: Header=BB3_34 Depth=2
	add	a0, a0, t3
	add	a0, a0, t5
	addi	t6, t6, 1
	sb	a2, 0(a0)
	beq	t6, t1, .LBB3_31
.LBB3_34:                               # %for.body13.us.us.us.us.us.us.i.4
                                        #   Parent Loop BB3_32 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_36 Depth 3
	add	a0, t6, t4
	li	a2, 0
	bltu	t6, t2, .LBB3_33
# %bb.35:                               # %if.then.us.us.us.us.us.us.i.4
                                        #   in Loop: Header=BB3_34 Depth=2
	vsetivli	zero, 1, e16, m1, tu, mu
	vmv.s.x	v8, zero
.LBB3_36:                               # %for.body21.us.us.us.us.us.us.i.4
                                        #   Parent Loop BB3_32 Depth=1
                                        #     Parent Loop BB3_34 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a3, s2, a2
	vsetvli	a3, a3, e8, m4, ta, mu
	mul	s0, a2, a1
	add	s0, s0, a0
	add	s1, s0, a4
	vlse8.v	v12, (s1), a1
	add	s0, s0, a5
	addi	s0, s0, -4
	vlse8.v	v16, (s0), a1
	vwmul.vv	v24, v12, v16
	vsetvli	zero, a3, e16, m8, tu, mu
	add	a2, a2, a3
	vredsum.vs	v8, v24, v8
	bltu	a2, s2, .LBB3_36
# %bb.37:                               # %for.cond18.for.cond.cleanup20_crit_edge.us.us.us.us.us.us.i.4
                                        #   in Loop: Header=BB3_34 Depth=2
	vmv.x.s	a2, v8
	j	.LBB3_33
.LBB3_38:                               # %for.cond6.for.cond.cleanup8_crit_edge.split.us.split.us.us.us.us.i.4
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

	.ident	"Terapines LTD zcc version 2.0.0 (https://www.terapines.com d82a1442dfd98f60f08014f36ba57878ee901dfd)"
	.section	".note.GNU-stack","",@progbits
