	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0_v0p10_zvlsseg0p10"
	.option	nopic
	.file	"warp_v1_golden.c"
	.globl	read_rdcycle                    # -- Begin function read_rdcycle
	.p2align	1
	.type	read_rdcycle,@function
read_rdcycle:                           # @read_rdcycle
# %bb.0:                                # %entry
	#APP
	rdcycle	a0

	#NO_APP
	sext.w	a0, a0
	ret
.Lfunc_end0:
	.size	read_rdcycle, .Lfunc_end0-read_rdcycle
                                        # -- End function
	.globl	warp_param_read                 # -- Begin function warp_param_read
	.p2align	1
	.type	warp_param_read,@function
warp_param_read:                        # @warp_param_read
# %bb.0:                                # %entry
	lui	a2, %hi(src_arr_global)
	addi	a2, a2, %lo(src_arr_global)
	sd	a2, 0(a0)
	lui	a2, %hi(offset_arr_global)
	addi	a2, a2, %lo(offset_arr_global)
	sd	a2, 8(a0)
	lui	a2, %hi(out_arr_global)
	addi	a2, a2, %lo(out_arr_global)
	sd	a2, 16(a0)
	lwu	a2, 8(a1)
	sraiw	a3, a2, 16
	sd	a3, 24(a0)
	lui	a3, 16
	addiw	a3, a3, -1
	and	a2, a2, a3
	sd	a2, 32(a0)
	lwu	a1, 12(a1)
	sraiw	a2, a1, 16
	sd	a2, 40(a0)
	and	a1, a1, a3
	sd	a1, 48(a0)
	ret
.Lfunc_end1:
	.size	warp_param_read, .Lfunc_end1-warp_param_read
                                        # -- End function
	.globl	warp_golden                     # -- Begin function warp_golden
	.p2align	1
	.type	warp_golden,@function
warp_golden:                            # @warp_golden
# %bb.0:                                # %entry
	addi	sp, sp, -144
	sd	ra, 136(sp)                     # 8-byte Folded Spill
	sd	s0, 128(sp)                     # 8-byte Folded Spill
	sd	s1, 120(sp)                     # 8-byte Folded Spill
	sd	s2, 112(sp)                     # 8-byte Folded Spill
	sd	s3, 104(sp)                     # 8-byte Folded Spill
	sd	s4, 96(sp)                      # 8-byte Folded Spill
	sd	s5, 88(sp)                      # 8-byte Folded Spill
	sd	s6, 80(sp)                      # 8-byte Folded Spill
	sd	s7, 72(sp)                      # 8-byte Folded Spill
	sd	s8, 64(sp)                      # 8-byte Folded Spill
	sd	s9, 56(sp)                      # 8-byte Folded Spill
	sd	s10, 48(sp)                     # 8-byte Folded Spill
	sd	s11, 40(sp)                     # 8-byte Folded Spill
	ld	a2, 24(a0)
	ld	a3, 32(a0)
	ld	t3, 40(a0)
	seqz	a1, a2
	sd	a3, 8(sp)                       # 8-byte Folded Spill
	seqz	a3, a3
	seqz	a4, t3
	or	a3, a3, a4
	or	a1, a1, a3
	beqz	a1, .LBB2_2
.LBB2_1:                                # %for.cond.cleanup
	ld	s11, 40(sp)                     # 8-byte Folded Reload
	ld	s10, 48(sp)                     # 8-byte Folded Reload
	ld	s9, 56(sp)                      # 8-byte Folded Reload
	ld	s8, 64(sp)                      # 8-byte Folded Reload
	ld	s7, 72(sp)                      # 8-byte Folded Reload
	ld	s6, 80(sp)                      # 8-byte Folded Reload
	ld	s5, 88(sp)                      # 8-byte Folded Reload
	ld	s4, 96(sp)                      # 8-byte Folded Reload
	ld	s3, 104(sp)                     # 8-byte Folded Reload
	ld	s2, 112(sp)                     # 8-byte Folded Reload
	ld	s1, 120(sp)                     # 8-byte Folded Reload
	ld	s0, 128(sp)                     # 8-byte Folded Reload
	ld	ra, 136(sp)                     # 8-byte Folded Reload
	addi	sp, sp, 144
	ret
.LBB2_2:                                # %for.cond5.preheader.us.us.preheader
	mv	s7, zero
	mv	a3, zero
	ld	a5, 48(a0)
	ld	a4, 0(a0)
	ld	t4, 8(a0)
	ld	s10, 16(a0)
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	mul	t2, t3, a0
	mul	a7, t2, a2
	addi	a0, zero, 1
	sllw	t0, a0, a5
	andi	a0, a2, 1
	addi	a1, a2, -1
	seqz	t5, a1
	andi	s11, a2, -2
	seqz	t6, a0
	add	s4, s10, t2
	slli	s5, t2, 1
	addi	s9, t2, -1
	add	s2, a4, s9
	sd	a4, 32(sp)                      # 8-byte Folded Spill
	addi	s3, a4, -1
	lui	a0, 16
	addiw	t1, a0, -1
	j	.LBB2_4
.LBB2_3:                                # %for.cond5.for.cond.cleanup7_crit_edge.split.us.us.us
                                        #   in Loop: Header=BB2_4 Depth=1
	ld	a3, 16(sp)                      # 8-byte Folded Reload
	addi	a3, a3, 1
	ld	s7, 24(sp)                      # 8-byte Folded Reload
	add	s7, s7, t3
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	beq	a3, a0, .LBB2_1
.LBB2_4:                                # %for.cond5.preheader.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_8 Depth 2
                                        #       Child Loop BB2_13 Depth 3
	mv	ra, zero
	sd	a3, 16(sp)                      # 8-byte Folded Spill
	mul	s6, a3, t3
	sd	s7, 24(sp)                      # 8-byte Folded Spill
	j	.LBB2_8
.LBB2_5:                                #   in Loop: Header=BB2_8 Depth=2
	mv	a4, zero
	mv	a1, zero
.LBB2_6:                                # %if.end.us.us.us.epil
                                        #   in Loop: Header=BB2_8 Depth=2
	and	a2, s1, t1
	sllw	a3, a3, a5
	sub	a2, a2, a3
	slli	a3, a2, 48
	srai	a3, a3, 48
	sub	a2, t0, a2
	slli	a2, a2, 48
	srai	a2, a2, 48
	mul	a2, a4, a2
	mul	a1, a1, a3
	add	a1, a1, a2
	sraw	a1, a1, a5
	add	a0, a0, s10
	sb	a1, 0(a0)
.LBB2_7:                                # %for.cond9.for.cond.cleanup11_crit_edge.us.us.us
                                        #   in Loop: Header=BB2_8 Depth=2
	addi	ra, ra, 1
	addi	s7, s7, 1
	beq	ra, t3, .LBB2_3
.LBB2_8:                                # %for.cond9.preheader.us.us.us
                                        #   Parent Loop BB2_4 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_13 Depth 3
	mv	a0, zero
	add	s8, ra, s6
	slli	a1, s8, 1
	add	s1, t4, a1
	beqz	t5, .LBB2_10
# %bb.9:                                # %for.cond9.for.cond.cleanup11_crit_edge.us.us.us.unr-lcssa
                                        #   in Loop: Header=BB2_8 Depth=2
	bnez	t6, .LBB2_7
	j	.LBB2_25
.LBB2_10:                               # %for.body12.us.us.us.preheader
                                        #   in Loop: Header=BB2_8 Depth=2
	mv	a0, zero
	mv	a3, s7
	j	.LBB2_13
.LBB2_11:                               #   in Loop: Header=BB2_13 Depth=3
	mv	a2, zero
	mv	a4, zero
.LBB2_12:                               # %if.end.us.us.us.1
                                        #   in Loop: Header=BB2_13 Depth=3
	and	a1, a1, t1
	sllw	s0, s0, a5
	sub	a1, a1, s0
	slli	s0, a1, 48
	srai	s0, s0, 48
	sub	a1, t0, a1
	slli	a1, a1, 48
	srai	a1, a1, 48
	mul	a1, a2, a1
	mul	a2, a4, s0
	add	a1, a1, a2
	sraw	a1, a1, a5
	add	a2, s4, a3
	sb	a1, 0(a2)
	addi	a0, a0, 2
	add	a3, a3, s5
	beq	a0, s11, .LBB2_24
.LBB2_13:                               # %for.body12.us.us.us
                                        #   Parent Loop BB2_4 Depth=1
                                        #     Parent Loop BB2_8 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	lh	a6, 0(s1)
	sraw	s0, a6, a5
	not	a1, s0
	add	a1, a1, a3
	bgeu	a1, a7, .LBB2_16
# %bb.14:                               # %if.else.us.us.us
                                        #   in Loop: Header=BB2_13 Depth=3
	sub	a2, a3, s0
	bne	ra, s0, .LBB2_17
# %bb.15:                               #   in Loop: Header=BB2_13 Depth=3
	mv	a1, zero
	j	.LBB2_18
.LBB2_16:                               #   in Loop: Header=BB2_13 Depth=3
	mv	a4, zero
	mv	a1, zero
	j	.LBB2_19
.LBB2_17:                               # %cond.true.us.us.us
                                        #   in Loop: Header=BB2_13 Depth=3
	add	a1, s3, a2
	lb	a1, 0(a1)
.LBB2_18:                               # %cond.end45.us.us.us
                                        #   in Loop: Header=BB2_13 Depth=3
	add	a2, a2, s3
	lb	a4, 1(a2)
.LBB2_19:                               # %if.end.us.us.us
                                        #   in Loop: Header=BB2_13 Depth=3
	and	a2, a6, t1
	sllw	s0, s0, a5
	sub	a2, a2, s0
	slli	s0, a2, 48
	srai	s0, s0, 48
	sub	a2, t0, a2
	slli	a2, a2, 48
	srai	a2, a2, 48
	mul	a2, a4, a2
	mul	a1, a1, s0
	add	a1, a1, a2
	sraw	a1, a1, a5
	add	a2, s10, a3
	sb	a1, 0(a2)
	lh	a1, 0(s1)
	sraw	s0, a1, a5
	add	a2, s9, a3
	sub	a2, a2, s0
	bgeu	a2, a7, .LBB2_11
# %bb.20:                               # %if.else.us.us.us.1
                                        #   in Loop: Header=BB2_13 Depth=3
	sub	a2, a3, s0
	bne	ra, s0, .LBB2_22
# %bb.21:                               #   in Loop: Header=BB2_13 Depth=3
	mv	a4, zero
	j	.LBB2_23
.LBB2_22:                               # %cond.true.us.us.us.1
                                        #   in Loop: Header=BB2_13 Depth=3
	add	a4, s2, a2
	lb	a4, 0(a4)
.LBB2_23:                               # %cond.end45.us.us.us.1
                                        #   in Loop: Header=BB2_13 Depth=3
	add	a2, a2, s2
	lb	a2, 1(a2)
	j	.LBB2_12
.LBB2_24:                               #   in Loop: Header=BB2_8 Depth=2
	mv	a0, s11
	bnez	t6, .LBB2_7
.LBB2_25:                               # %for.body12.us.us.us.epil
                                        #   in Loop: Header=BB2_8 Depth=2
	lh	s1, 0(s1)
	sraw	a3, s1, a5
	mul	a0, t2, a0
	add	a0, a0, s8
	sub	a2, a0, a3
	addi	a1, a2, -1
	bgeu	a1, a7, .LBB2_5
# %bb.26:                               # %if.else.us.us.us.epil
                                        #   in Loop: Header=BB2_8 Depth=2
	bne	ra, a3, .LBB2_28
# %bb.27:                               #   in Loop: Header=BB2_8 Depth=2
	mv	a1, zero
	ld	a4, 32(sp)                      # 8-byte Folded Reload
	j	.LBB2_29
.LBB2_28:                               # %cond.true.us.us.us.epil
                                        #   in Loop: Header=BB2_8 Depth=2
	ld	a4, 32(sp)                      # 8-byte Folded Reload
	add	a1, a1, a4
	lb	a1, 0(a1)
.LBB2_29:                               # %cond.end45.us.us.us.epil
                                        #   in Loop: Header=BB2_8 Depth=2
	add	a2, a2, a4
	lb	a4, 0(a2)
	j	.LBB2_6
.Lfunc_end2:
	.size	warp_golden, .Lfunc_end2-warp_golden
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %entry
	addi	sp, sp, -64
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	sd	s0, 48(sp)                      # 8-byte Folded Spill
	sd	s1, 40(sp)                      # 8-byte Folded Spill
	sd	s2, 32(sp)                      # 8-byte Folded Spill
	sd	s3, 24(sp)                      # 8-byte Folded Spill
	sd	s4, 16(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	slli	a1, a0, 4
	add	a0, a0, a1
	sub	sp, sp, a0
	mv	a7, zero
	#APP
	rdcycle	a6

	#NO_APP
	vsetvli	a0, zero, e64, m8, ta, mu
	vid.v	v8
	addi	a0, sp, 16
	vs8r.v	v8, (a0)                        # Unknown-size Folded Spill
	addi	t1, zero, 88
	lui	a0, %hi(offset_arr_global)
	addi	t3, a0, %lo(offset_arr_global)
	addi	t0, zero, 256
	addi	t6, zero, 58
	vmset.m	v25
	csrr	a0, vlenb
	slli	a0, a0, 3
	add	a0, a0, sp
	addi	a0, a0, 16
	vs1r.v	v25, (a0)                       # Unknown-size Folded Spill
	lui	a0, 2
	addiw	s2, a0, 1664
	lui	a0, 140
	addiw	s3, a0, -1792
	lui	a0, %hi(src_arr_global)
	addi	a4, a0, %lo(src_arr_global)
	vsetvli	zero, zero, e16, m2, ta, mu
	vmv.v.i	v4, 0
	lui	a0, %hi(out_arr_global)
	addi	a2, a0, %lo(out_arr_global)
	addi	t2, zero, 112
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
	mv	t5, zero
	mul	t4, a7, t1
	j	.LBB3_4
.LBB3_3:                                # %for.cond9.for.cond.cleanup11_crit_edge.us.us.us.i
                                        #   in Loop: Header=BB3_4 Depth=2
	addi	t5, t5, 1
	beq	t5, t1, .LBB3_1
.LBB3_4:                                # %for.cond9.preheader.us.us.us.i
                                        #   Parent Loop BB3_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_8 Depth 3
                                        #       Child Loop BB3_6 Depth 3
	add	a3, t5, t4
	slli	a0, a3, 1
	add	a0, a0, t3
	lhu	a0, 0(a0)
	slli	a5, a0, 48
	srai	s4, a5, 56
	andi	s1, a0, 255
	sub	a5, t0, s1
	mv	a0, zero
	addi	a1, sp, 16
	bne	t5, s4, .LBB3_7
# %bb.5:                                # %vector.ph
                                        #   in Loop: Header=BB3_4 Depth=2
	vl8re8.v	v16, (a1)                       # Unknown-size Folded Reload
.LBB3_6:                                # %vector.body
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_4 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a1, t6, a0
	vsetvli	a1, a1, e8, m1, ta, mu
	vsetvli	s0, zero, e64, m8, ta, mu
	vmv.v.x	v8, a3
	vsetvli	zero, a1, e64, m8, ta, mu
	vmacc.vx	v8, s2, v16
	csrr	s0, vlenb
	slli	s1, s0, 3
	add	s0, s0, s1
	add	s0, s0, sp
	addi	s0, s0, 16
	vs8r.v	v8, (s0)                        # Unknown-size Folded Spill
	vsub.vx	v24, v8, t5
	vadd.vi	v8, v24, -1
	vmsltu.vx	v0, v8, s3
	vsetvli	zero, zero, e8, m1, ta, mu
	vloxei64.v	v8, (a4), v24, v0.t
	vwcvt.x.x.v	v26, v8, v0.t
	vsetvli	s0, zero, e16, m2, ta, mu
	vmerge.vvm	v26, v4, v26, v0
	vsetvli	zero, a1, e16, m2, ta, mu
	vwaddu.vx	v28, v26, zero
	vsetvli	zero, zero, e32, m4, ta, mu
	vmul.vx	v28, v28, a5
	vsrl.vi	v28, v28, 8
	vsetvli	zero, zero, e16, m2, ta, mu
	vnsrl.wi	v26, v28, 0
	vsetvli	zero, zero, e8, m1, ta, mu
	vnsrl.wi	v25, v26, 0
	csrr	s0, vlenb
	slli	s0, s0, 3
	add	s0, s0, sp
	addi	s0, s0, 16
	vl1r.v	v0, (s0)                        # Unknown-size Folded Reload
	csrr	s0, vlenb
	slli	s1, s0, 3
	add	s0, s0, s1
	add	s0, s0, sp
	addi	s0, s0, 16
	vl8re8.v	v8, (s0)                        # Unknown-size Folded Reload
	vsoxei64.v	v25, (a2), v8, v0.t
	add	a0, a0, a1
	vsetvli	s0, zero, e64, m8, ta, mu
	vadd.vx	v16, v16, a1
	bne	a0, t6, .LBB3_6
	j	.LBB3_3
.LBB3_7:                                # %vector.ph51
                                        #   in Loop: Header=BB3_4 Depth=2
	vl8re8.v	v24, (a1)                       # Unknown-size Folded Reload
.LBB3_8:                                # %vector.body50
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_4 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a1, t6, a0
	vsetvli	a1, a1, e8, m1, ta, mu
	vsetvli	s0, zero, e8, m1, ta, mu
	vmset.m	v2
	vsetvli	zero, zero, e64, m8, ta, mu
	vmv.v.x	v8, a3
	vsetvli	zero, a1, e64, m8, ta, mu
	vmacc.vx	v8, s2, v24
	csrr	s0, vlenb
	slli	ra, s0, 3
	add	s0, s0, ra
	add	s0, s0, sp
	addi	s0, s0, 16
	vs8r.v	v8, (s0)                        # Unknown-size Folded Spill
	vsub.vx	v16, v8, s4
	vadd.vi	v8, v16, -1
	vmsltu.vx	v0, v8, s3
	vsetvli	zero, zero, e8, m1, ta, mu
	vloxei64.v	v3, (a4), v8, v0.t
	vwcvt.x.x.v	v8, v3, v0.t
	vloxei64.v	v10, (a4), v16, v0.t
	vwcvt.x.x.v	v12, v10, v0.t
	vsetvli	s0, zero, e16, m2, ta, mu
	vmerge.vvm	v10, v4, v12, v0
	vmerge.vvm	v8, v4, v8, v0
	vsetvli	zero, a1, e16, m2, ta, mu
	vwaddu.vx	v12, v10, zero
	vmv2r.v	v0, v4
	vwaddu.vx	v4, v8, zero
	vsetvli	zero, zero, e32, m4, ta, mu
	vmul.vx	v8, v4, s1
	vmv2r.v	v4, v0
	vmacc.vx	v8, a5, v12
	vsrl.vi	v8, v8, 8
	vsetvli	zero, zero, e16, m2, ta, mu
	vnsrl.wi	v12, v8, 0
	vsetvli	zero, zero, e8, m1, ta, mu
	vnsrl.wi	v8, v12, 0
	vmv1r.v	v0, v2
	csrr	s0, vlenb
	slli	ra, s0, 3
	add	s0, s0, ra
	add	s0, s0, sp
	addi	s0, s0, 16
	vl8re8.v	v16, (s0)                       # Unknown-size Folded Reload
	vsoxei64.v	v8, (a2), v16, v0.t
	add	a0, a0, a1
	vsetvli	s0, zero, e64, m8, ta, mu
	vadd.vx	v24, v24, a1
	bne	a0, t6, .LBB3_8
	j	.LBB3_3
.LBB3_9:                                # %warp_golden.exit
	#APP
	rdcycle	a0

	#NO_APP
	subw	a1, a0, a6
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	call	printf
	mv	a0, zero
	csrr	a1, vlenb
	slli	a2, a1, 4
	add	a1, a1, a2
	add	sp, sp, a1
	ld	s4, 16(sp)                      # 8-byte Folded Reload
	ld	s3, 24(sp)                      # 8-byte Folded Reload
	ld	s2, 32(sp)                      # 8-byte Folded Reload
	ld	s1, 40(sp)                      # 8-byte Folded Reload
	ld	s0, 48(sp)                      # 8-byte Folded Reload
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 64
	ret
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
                                        # -- End function
	.type	src_arr_global,@object          # @src_arr_global
	.data
	.globl	src_arr_global
	.p2align	3
src_arr_global:
	.byte	2                               # 0x2
	.zero	571647
	.size	src_arr_global, 571648

	.type	offset_arr_global,@object       # @offset_arr_global
	.globl	offset_arr_global
	.p2align	3
offset_arr_global:
	.half	256                             # 0x100
	.zero	19710
	.size	offset_arr_global, 19712

	.type	out_arr_global,@object          # @out_arr_global
	.bss
	.globl	out_arr_global
	.p2align	3
out_arr_global:
	.zero	571648
	.size	out_arr_global, 571648

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.8,"aMS",@progbits,1
	.p2align	3
.L.str:
	.asciz	"warp_58x112x88 running cycles : %d.\n"
	.size	.L.str, 37

	.ident	"Terapines LTD zcc version 1.0.0 (https://www.terapines.com 153ecb6322f1f09cb4ffa189f112fa2836ff5f3b)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym src_arr_global
	.addrsig_sym offset_arr_global
	.addrsig_sym out_arr_global
