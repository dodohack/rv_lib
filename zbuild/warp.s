	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_a2p0_f2p0_d2p0_c2p0_v0p10"
	.option	nopic
	.file	"warp_v1_golden.c"
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
	.globl	warp_param_read                 # -- Begin function warp_param_read
	.p2align	2
	.type	warp_param_read,@function
warp_param_read:                        # @warp_param_read
# %bb.0:                                # %entry
	lui	a2, %hi(src_arr_global)
	addi	a2, a2, %lo(src_arr_global)
	sw	a2, 0(a0)
	lui	a2, %hi(offset_arr_global)
	addi	a2, a2, %lo(offset_arr_global)
	sw	a2, 4(a0)
	lui	a2, %hi(out_arr_global)
	addi	a2, a2, %lo(out_arr_global)
	sw	a2, 8(a0)
	lh	a2, 10(a1)
	sw	a2, 12(a0)
	lhu	a2, 8(a1)
	sw	a2, 16(a0)
	lh	a2, 14(a1)
	sw	a2, 20(a0)
	lhu	a1, 12(a1)
	sw	a1, 24(a0)
	ret
.Lfunc_end1:
	.size	warp_param_read, .Lfunc_end1-warp_param_read
                                        # -- End function
	.globl	warp_golden                     # -- Begin function warp_golden
	.p2align	2
	.type	warp_golden,@function
warp_golden:                            # @warp_golden
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
	lw	a1, 16(a0)
	sw	a1, 0(sp)                       # 4-byte Folded Spill
	beqz	a1, .LBB2_2
# %bb.1:                                # %for.cond5.preheader.lr.ph
	lw	t2, 20(a0)
	lw	a1, 12(a0)
	seqz	a2, t2
	seqz	a3, a1
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
.LBB2_3:                                # %for.cond5.preheader.us.us.preheader
	li	s6, 0
	li	a3, 0
	lw	a5, 24(a0)
	lw	t6, 0(a0)
	lw	t3, 4(a0)
	lw	s9, 8(a0)
	lw	a0, 0(sp)                       # 4-byte Folded Reload
	mul	t1, t2, a0
	mul	a7, t1, a1
	li	a0, 1
	sll	t0, a0, a5
	andi	a0, a1, 1
	addi	a2, a1, -1
	seqz	t4, a2
	seqz	t5, a0
	add	s3, s9, t1
	slli	s4, t1, 1
	andi	a0, a1, -2
	neg	s8, a0
	add	s2, t6, t1
	addi	s10, t1, -1
	lui	a0, 16
	addi	s11, a0, -1
	j	.LBB2_5
.LBB2_4:                                # %for.cond5.for.cond.cleanup7_crit_edge.split.us.us.us
                                        #   in Loop: Header=BB2_5 Depth=1
	lw	a3, 4(sp)                       # 4-byte Folded Reload
	addi	a3, a3, 1
	lw	s6, 8(sp)                       # 4-byte Folded Reload
	add	s6, s6, t2
	lw	a0, 0(sp)                       # 4-byte Folded Reload
	beq	a3, a0, .LBB2_2
.LBB2_5:                                # %for.cond5.preheader.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_9 Depth 2
                                        #       Child Loop BB2_14 Depth 3
	li	ra, 0
	sw	a3, 4(sp)                       # 4-byte Folded Spill
	mul	s5, a3, t2
	sw	s6, 8(sp)                       # 4-byte Folded Spill
	j	.LBB2_9
.LBB2_6:                                #   in Loop: Header=BB2_9 Depth=2
	li	a4, 0
	li	a1, 0
.LBB2_7:                                # %if.end.us.us.us.epil
                                        #   in Loop: Header=BB2_9 Depth=2
	slli	a2, a3, 16
	srli	a2, a2, 16
	sll	a3, s0, a5
	sub	a2, a2, a3
	sub	a3, t0, a2
	mul	a3, a4, a3
	mul	a1, a1, a2
	add	a1, a1, a3
	slli	a1, a1, 16
	srai	a1, a1, 16
	sra	a1, a1, a5
	add	a0, a0, s9
	sb	a1, 0(a0)
.LBB2_8:                                # %for.cond9.for.cond.cleanup11_crit_edge.us.us.us
                                        #   in Loop: Header=BB2_9 Depth=2
	addi	ra, ra, 1
	addi	s6, s6, 1
	beq	ra, t2, .LBB2_4
.LBB2_9:                                # %for.cond9.preheader.us.us.us
                                        #   Parent Loop BB2_5 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_14 Depth 3
	li	a0, 0
	add	s7, ra, s5
	slli	a1, s7, 1
	add	s0, t3, a1
	beqz	t4, .LBB2_11
# %bb.10:                               # %for.cond9.for.cond.cleanup11_crit_edge.us.us.us.unr-lcssa
                                        #   in Loop: Header=BB2_9 Depth=2
	bnez	t5, .LBB2_8
	j	.LBB2_26
.LBB2_11:                               # %for.body12.us.us.us.preheader
                                        #   in Loop: Header=BB2_9 Depth=2
	li	a0, 0
	mv	s1, s6
	j	.LBB2_14
.LBB2_12:                               #   in Loop: Header=BB2_14 Depth=3
	li	a2, 0
	li	a4, 0
.LBB2_13:                               # %if.end.us.us.us.1
                                        #   in Loop: Header=BB2_14 Depth=3
	and	a1, a1, s11
	sll	a3, a3, a5
	sub	a1, a1, a3
	sub	a3, t0, a1
	mul	a2, a2, a3
	mul	a1, a4, a1
	add	a1, a1, a2
	slli	a1, a1, 16
	srai	a1, a1, 16
	sra	a1, a1, a5
	add	a2, s3, s1
	sb	a1, 0(a2)
	addi	a0, a0, -2
	add	s1, s1, s4
	beq	s8, a0, .LBB2_25
.LBB2_14:                               # %for.body12.us.us.us
                                        #   Parent Loop BB2_5 Depth=1
                                        #     Parent Loop BB2_9 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	lh	a1, 0(s0)
	sra	a3, a1, a5
	not	a2, a3
	add	a2, a2, s1
	bgeu	a2, a7, .LBB2_17
# %bb.15:                               # %if.else.us.us.us
                                        #   in Loop: Header=BB2_14 Depth=3
	sub	a2, s1, a3
	bne	ra, a3, .LBB2_18
# %bb.16:                               #   in Loop: Header=BB2_14 Depth=3
	li	a6, 0
	j	.LBB2_19
.LBB2_17:                               #   in Loop: Header=BB2_14 Depth=3
	li	a4, 0
	li	a6, 0
	j	.LBB2_20
.LBB2_18:                               # %cond.true.us.us.us
                                        #   in Loop: Header=BB2_14 Depth=3
	add	a4, t6, a2
	lb	a6, -1(a4)
.LBB2_19:                               # %cond.end43.us.us.us
                                        #   in Loop: Header=BB2_14 Depth=3
	add	a2, a2, t6
	lb	a4, 0(a2)
.LBB2_20:                               # %if.end.us.us.us
                                        #   in Loop: Header=BB2_14 Depth=3
	slli	a1, a1, 16
	srli	a1, a1, 16
	sll	a2, a3, a5
	sub	a1, a1, a2
	sub	a2, t0, a1
	mul	a2, a4, a2
	mul	a1, a6, a1
	add	a1, a1, a2
	slli	a1, a1, 16
	srai	a1, a1, 16
	sra	a1, a1, a5
	add	a2, s9, s1
	sb	a1, 0(a2)
	lh	a1, 0(s0)
	sra	a3, a1, a5
	add	a2, s10, s1
	sub	a2, a2, a3
	bgeu	a2, a7, .LBB2_12
# %bb.21:                               # %if.else.us.us.us.1
                                        #   in Loop: Header=BB2_14 Depth=3
	sub	a2, s1, a3
	bne	ra, a3, .LBB2_23
# %bb.22:                               #   in Loop: Header=BB2_14 Depth=3
	li	a4, 0
	j	.LBB2_24
.LBB2_23:                               # %cond.true.us.us.us.1
                                        #   in Loop: Header=BB2_14 Depth=3
	add	a4, s2, a2
	lb	a4, -1(a4)
.LBB2_24:                               # %cond.end43.us.us.us.1
                                        #   in Loop: Header=BB2_14 Depth=3
	add	a2, a2, s2
	lb	a2, 0(a2)
	j	.LBB2_13
.LBB2_25:                               # %for.cond9.for.cond.cleanup11_crit_edge.us.us.us.unr-lcssa.loopexit
                                        #   in Loop: Header=BB2_9 Depth=2
	neg	a0, a0
	bnez	t5, .LBB2_8
.LBB2_26:                               # %for.body12.us.us.us.epil
                                        #   in Loop: Header=BB2_9 Depth=2
	lh	a3, 0(s0)
	sra	s0, a3, a5
	mul	a0, t1, a0
	add	a0, a0, s7
	sub	a4, a0, s0
	addi	a1, a4, -1
	bgeu	a1, a7, .LBB2_6
# %bb.27:                               # %if.else.us.us.us.epil
                                        #   in Loop: Header=BB2_9 Depth=2
	bne	ra, s0, .LBB2_29
# %bb.28:                               #   in Loop: Header=BB2_9 Depth=2
	li	a1, 0
	j	.LBB2_30
.LBB2_29:                               # %cond.true.us.us.us.epil
                                        #   in Loop: Header=BB2_9 Depth=2
	add	a1, a1, t6
	lb	a1, 0(a1)
.LBB2_30:                               # %cond.end43.us.us.us.epil
                                        #   in Loop: Header=BB2_9 Depth=2
	add	a2, t6, a4
	lb	a4, 0(a2)
	j	.LBB2_7
.Lfunc_end2:
	.size	warp_golden, .Lfunc_end2-warp_golden
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %for.cond5.preheader.lr.ph.i
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
	csrr	a0, vlenb
	slli	a0, a0, 4
	sub	sp, sp, a0
	li	a7, 0
	lui	a0, 2
	addi	a2, a0, 1664
	#APP
	csrr	a6, mcycle

	#NO_APP
	vsetvli	a0, zero, e32, m8, ta, mu
	vid.v	v8
	addi	a0, sp, 24
	vs8r.v	v8, (a0)                        # Unknown-size Folded Spill
	li	t1, 88
	lui	a0, %hi(src_arr_global)
	addi	t6, a0, %lo(src_arr_global)
	lui	a0, %hi(out_arr_global)
	addi	t3, a0, %lo(out_arr_global)
	lui	a0, %hi(offset_arr_global)
	addi	t4, a0, %lo(offset_arr_global)
	li	t0, 256
	li	s6, 58
	lui	a0, 140
	addi	s7, a0, -1792
	vsetvli	zero, zero, e16, m4, ta, mu
	vmv.v.i	v16, 0
	li	t2, 112
	j	.LBB3_2
.LBB3_1:                                # %for.cond5.for.cond.cleanup7_crit_edge.split.us.us.us.i
                                        #   in Loop: Header=BB3_2 Depth=1
	addi	a7, a7, 1
	beq	a7, t2, .LBB3_9
.LBB3_2:                                # %for.cond5.preheader.us.us.i
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_4 Depth 2
                                        #       Child Loop BB3_8 Depth 3
                                        #       Child Loop BB3_6 Depth 3
	li	s4, 0
	mul	s2, a7, t1
	addi	t5, s2, -1
	add	s3, s2, t6
	j	.LBB3_4
.LBB3_3:                                # %for.cond9.for.cond.cleanup11_crit_edge.us.us.us.i
                                        #   in Loop: Header=BB3_4 Depth=2
	addi	s4, s4, 1
	beq	s4, t1, .LBB3_1
.LBB3_4:                                # %for.cond9.preheader.us.us.us.i
                                        #   Parent Loop BB3_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_8 Depth 3
                                        #       Child Loop BB3_6 Depth 3
	add	a1, s2, s4
	slli	a0, a1, 1
	add	a0, a0, t4
	lhu	a4, 0(a0)
	add	s0, a1, t3
	slli	a0, a4, 16
	srai	s8, a0, 24
	andi	s5, a4, 255
	sub	s1, t0, s5
	vsetvli	zero, zero, e32, m8, ta, mu
	vmv.v.x	v8, a1
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	a0, a0, sp
	addi	a0, a0, 24
	vs8r.v	v8, (a0)                        # Unknown-size Folded Spill
	bne	s4, s8, .LBB3_7
# %bb.5:                                # %vector.body.preheader
                                        #   in Loop: Header=BB3_4 Depth=2
	li	a0, 0
	addi	a1, sp, 24
	vl8re8.v	v8, (a1)                        # Unknown-size Folded Reload
.LBB3_6:                                # %vector.body
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_4 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a1, s6, a0
	vsetvli	a1, a1, e32, m8, ta, mu
	vmv8r.v	v24, v8
	csrr	a3, vlenb
	slli	a3, a3, 3
	add	a3, a3, sp
	addi	a3, a3, 24
	vl8re8.v	v0, (a3)                        # Unknown-size Folded Reload
	vmadd.vx	v24, a2, v0
	vsub.vx	v24, v24, s4
	vadd.vi	v24, v24, -1
	vmsltu.vx	v0, v24, s7
	mul	a3, a0, a2
	add	a4, s3, a3
	vlse8.v	v20, (a4), a2, v0.t
	vsetvli	zero, zero, e16, m4, ta, mu
	vsext.vf2	v24, v20, v0.t
	vsetvli	a4, zero, e16, m4, ta, mu
	vmerge.vvm	v20, v16, v24, v0
	vsetvli	zero, a1, e16, m4, ta, mu
	vmul.vx	v20, v20, s1
	vsetvli	zero, zero, e8, m2, ta, mu
	vnsrl.wi	v24, v20, 8
	add	a3, a3, s0
	vsse8.v	v24, (a3), a2
	add	a0, a0, a1
	vsetvli	a3, zero, e32, m8, ta, mu
	vadd.vx	v8, v8, a1
	bne	a0, s6, .LBB3_6
	j	.LBB3_3
.LBB3_7:                                # %vector.ph51
                                        #   in Loop: Header=BB3_4 Depth=2
	li	a5, 0
	add	a4, t5, s4
	sub	a4, a4, s8
	sub	a1, a1, s8
	add	s9, a4, t6
	add	a1, a1, t6
	addi	a0, sp, 24
	vl8re8.v	v8, (a0)                        # Unknown-size Folded Reload
.LBB3_8:                                # %vector.body50
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_4 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a3, s6, a5
	vsetvli	a3, a3, e32, m8, ta, mu
	vmv8r.v	v0, v8
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	a0, a0, sp
	addi	a0, a0, 24
	vl8re8.v	v24, (a0)                       # Unknown-size Folded Reload
	vmadd.vx	v0, a2, v24
	vsub.vx	v0, v0, s8
	vadd.vi	v24, v0, -1
	vmsltu.vx	v0, v24, s7
	mul	a0, a5, a2
	add	a4, s9, a0
	vlse8.v	v20, (a4), a2, v0.t
	vsetvli	zero, zero, e16, m4, ta, mu
	vsext.vf2	v24, v20, v0.t
	add	a4, a1, a0
	vlse8.v	v20, (a4), a2, v0.t
	vsext.vf2	v28, v20, v0.t
	vsetvli	a4, zero, e16, m4, ta, mu
	vmerge.vvm	v20, v16, v28, v0
	vmerge.vvm	v24, v16, v24, v0
	vsetvli	zero, a3, e16, m4, ta, mu
	vmul.vx	v24, v24, s5
	vmacc.vx	v24, s1, v20
	vsetvli	zero, zero, e8, m2, ta, mu
	vnsrl.wi	v20, v24, 8
	add	a0, a0, s0
	vsse8.v	v20, (a0), a2
	add	a5, a5, a3
	vsetvli	a0, zero, e32, m8, ta, mu
	vadd.vx	v8, v8, a3
	bne	a5, s6, .LBB3_8
	j	.LBB3_3
.LBB3_9:                                # %warp_golden.exit
	#APP
	csrr	a0, mcycle

	#NO_APP
	sub	a1, a0, a6
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	call	printf
	li	a0, 0
	csrr	a1, vlenb
	slli	a1, a1, 4
	add	sp, sp, a1
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
	addi	sp, sp, 80
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

	.ident	"Terapines LTD zcc version 2.0.0 (https://www.terapines.com d82a1442dfd98f60f08014f36ba57878ee901dfd)"
	.section	".note.GNU-stack","",@progbits
