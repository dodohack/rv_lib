	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0_v0p10_zvlsseg0p10"
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
	sext.w	a0, a0
	ret
.Lfunc_end0:
	.size	read_rdcycle, .Lfunc_end0-read_rdcycle
                                        # -- End function
	.globl	correlation_param_read          # -- Begin function correlation_param_read
	.p2align	1
	.type	correlation_param_read,@function
correlation_param_read:                 # @correlation_param_read
# %bb.0:                                # %entry
	lwu	a2, 8(a1)
	sraiw	a3, a2, 16
	sd	a3, 0(a0)
	lui	a3, 16
	addiw	a3, a3, -1
	and	a2, a2, a3
	sd	a2, 8(a0)
	lwu	a2, 12(a1)
	sraiw	a4, a2, 16
	sd	a4, 16(a0)
	and	a2, a2, a3
	sd	a2, 24(a0)
	lhu	a1, 16(a1)
	sd	a1, 32(a0)
	lui	a1, %hi(src0_arr_global)
	addi	a1, a1, %lo(src0_arr_global)
	sd	a1, 40(a0)
	lui	a1, %hi(src1_arr_global)
	addi	a1, a1, %lo(src1_arr_global)
	sd	a1, 48(a0)
	lui	a1, %hi(out_arr_global)
	addi	a1, a1, %lo(out_arr_global)
	sd	a1, 56(a0)
	ret
.Lfunc_end1:
	.size	correlation_param_read, .Lfunc_end1-correlation_param_read
                                        # -- End function
	.globl	correlation_golden              # -- Begin function correlation_golden
	.p2align	1
	.type	correlation_golden,@function
correlation_golden:                     # @correlation_golden
# %bb.0:                                # %entry
	addi	sp, sp, -32
	sd	s0, 24(sp)                      # 8-byte Folded Spill
	sd	s1, 16(sp)                      # 8-byte Folded Spill
	csrr	a1, vlenb
	addi	a2, zero, 27
	mul	a1, a1, a2
	sub	sp, sp, a1
	ld	t4, 24(a0)
	ld	a6, 8(a0)
	ld	t0, 16(a0)
	seqz	a1, t4
	seqz	a2, a6
	seqz	a3, t0
	or	a2, a2, a3
	or	a1, a1, a2
	bnez	a1, .LBB2_18
# %bb.1:                                # %for.cond6.preheader.lr.ph.split.us.split.us
	ld	a2, 0(a0)
	ld	t2, 56(a0)
	mul	t6, t0, a6
	beqz	a2, .LBB2_12
# %bb.2:                                # %for.cond6.preheader.us.us.us.preheader
	mv	a7, zero
	ld	t1, 32(a0)
	ld	a3, 40(a0)
	ld	a0, 48(a0)
	vsetvli	a1, zero, e16, m2, ta, mu
	vmv.v.i	v26, 0
	csrr	a1, vlenb
	add	a1, a1, sp
	addi	a1, a1, 16
	vs2r.v	v26, (a1)                       # Unknown-size Folded Spill
	vsetvli	zero, zero, e64, m8, ta, mu
	vid.v	v8
	csrr	a1, vlenb
	slli	a4, a1, 1
	add	a1, a1, a4
	add	a1, a1, sp
	addi	a1, a1, 16
	vs8r.v	v8, (a1)                        # Unknown-size Folded Spill
	vmset.m	v16
	vsetvli	zero, zero, e32, m4, ta, mu
	vid.v	v20
	vsetivli	zero, 1, e16, m1, ta, mu
	vmv.v.i	v25, 0
	addi	a1, sp, 16
	vs1r.v	v25, (a1)                       # Unknown-size Folded Spill
	j	.LBB2_4
.LBB2_3:                                # %for.cond6.for.cond.cleanup8_crit_edge.split.us.split.us.us.us.us
                                        #   in Loop: Header=BB2_4 Depth=1
	addi	a7, a7, 1
	beq	a7, a6, .LBB2_18
.LBB2_4:                                # %for.cond6.preheader.us.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_6 Depth 2
                                        #       Child Loop BB2_8 Depth 3
                                        #         Child Loop BB2_10 Depth 4
	mv	t5, zero
	mul	t3, a7, t0
	j	.LBB2_6
.LBB2_5:                                # %for.cond10.for.cond.cleanup12_crit_edge.split.us.us.us.us.us.us
                                        #   in Loop: Header=BB2_6 Depth=2
	addi	t5, t5, 1
	beq	t5, t0, .LBB2_3
.LBB2_6:                                # %for.cond10.preheader.us.us.us.us.us
                                        #   Parent Loop BB2_4 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_8 Depth 3
                                        #         Child Loop BB2_10 Depth 4
	mv	a1, zero
	add	a4, t5, t3
	j	.LBB2_8
.LBB2_7:                                # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us
                                        #   in Loop: Header=BB2_8 Depth=3
	mul	s0, t6, a1
	add	s0, s0, a4
	sraw	a5, a5, t1
	add	s0, s0, t2
	addi	a1, a1, 1
	sb	a5, 0(s0)
	beq	a1, t4, .LBB2_5
.LBB2_8:                                # %for.body13.us.us.us.us.us.us
                                        #   Parent Loop BB2_4 Depth=1
                                        #     Parent Loop BB2_6 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_10 Depth 4
	mv	a5, zero
	bltu	t5, a1, .LBB2_7
# %bb.9:                                # %vector.ph
                                        #   in Loop: Header=BB2_8 Depth=3
	vsetvli	s0, zero, e16, m2, tu, mu
	csrr	s0, vlenb
	add	s0, s0, sp
	addi	s0, s0, 16
	vl2re8.v	v26, (s0)                       # Unknown-size Folded Reload
	vmv.s.x	v26, zero
	csrr	s0, vlenb
	slli	s1, s0, 1
	add	s0, s0, s1
	add	s0, s0, sp
	addi	s0, s0, 16
	vl8re8.v	v8, (s0)                        # Unknown-size Folded Reload
.LBB2_10:                               # %vector.body
                                        #   Parent Loop BB2_4 Depth=1
                                        #     Parent Loop BB2_6 Depth=2
                                        #       Parent Loop BB2_8 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	sd	a6, 8(sp)
	csrr	a6, vlenb
	addi	s0, zero, 19
	mul	a6, a6, s0
	add	a6, a6, sp
	addi	a6, a6, 16
	vs2r.v	v26, (a6)                       # Unknown-size Folded Spill
	sub	s0, a2, a5
	vsetvli	s0, s0, e16, m2, ta, mu
	vsetvli	s1, zero, e64, m8, ta, mu
	vmv.v.x	v24, a4
	vsetvli	zero, s0, e64, m8, ta, mu
	vmacc.vx	v24, t6, v8
	vsub.vx	v0, v24, a1
	csrr	a6, vlenb
	addi	s1, zero, 11
	mul	a6, a6, s1
	add	a6, a6, sp
	addi	a6, a6, 16
	vs8r.v	v0, (a6)                        # Unknown-size Folded Spill
	vsetvli	zero, zero, e8, m1, ta, mu
	vmv1r.v	v0, v16
	vmv1r.v	v1, v16
	vmv4r.v	v4, v20
	csrr	a6, vlenb
	addi	s1, zero, 11
	mul	a6, a6, s1
	add	a6, a6, sp
	addi	a6, a6, 16
	vl8re8.v	v16, (a6)                       # Unknown-size Folded Reload
	vloxei64.v	v2, (a0), v16, v0.t
	vmv4r.v	v20, v4
	vmv1r.v	v16, v1
	vmv1r.v	v0, v1
	vloxei64.v	v3, (a3), v24, v0.t
	vwadd.vx	v26, v2, zero
	vwadd.vx	v28, v3, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	csrr	a6, vlenb
	addi	s1, zero, 19
	mul	a6, a6, s1
	add	a6, a6, sp
	addi	a6, a6, 16
	vl2re8.v	v30, (a6)                       # Unknown-size Folded Reload
	vmadd.vv	v28, v26, v30
	csrr	s1, vlenb
	addi	a6, zero, 19
	mul	s1, s1, a6
	ld	a6, 8(sp)
	add	s1, s1, sp
	addi	s1, s1, 16
	vl2re8.v	v26, (s1)                       # Unknown-size Folded Reload
	vsetvli	s1, zero, e32, m4, ta, mu
	vmsltu.vx	v0, v4, s0
	vsetvli	zero, zero, e16, m2, ta, mu
	vmerge.vvm	v26, v26, v28, v0
	add	a5, a5, s0
	vsetvli	zero, zero, e64, m8, ta, mu
	vadd.vx	v8, v8, s0
	bne	a5, a2, .LBB2_10
# %bb.11:                               # %middle.block
                                        #   in Loop: Header=BB2_8 Depth=3
	vsetvli	zero, zero, e16, m2, ta, mu
	addi	a5, sp, 16
	vl1r.v	v25, (a5)                       # Unknown-size Folded Reload
	vredsum.vs	v25, v26, v25
	vmv.x.s	a5, v25
	j	.LBB2_7
.LBB2_12:                               # %for.cond6.preheader.us.us.preheader
	mv	a0, zero
	vsetvli	a1, zero, e64, m8, ta, mu
	vid.v	v8
	csrr	a1, vlenb
	addi	a2, zero, 19
	mul	a1, a1, a2
	add	a1, a1, sp
	addi	a1, a1, 16
	vs8r.v	v8, (a1)                        # Unknown-size Folded Spill
	vmset.m	v0
	vsetvli	zero, zero, e8, m1, ta, mu
	vmv.v.i	v25, 0
.LBB2_13:                               # %for.cond6.preheader.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_14 Depth 2
                                        #       Child Loop BB2_15 Depth 3
	mv	a1, zero
	mul	a2, a0, t0
.LBB2_14:                               # %vector.ph169
                                        #   Parent Loop BB2_13 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_15 Depth 3
	mv	a3, zero
	add	a4, a1, a2
	csrr	a5, vlenb
	addi	a7, zero, 19
	mul	a5, a5, a7
	add	a5, a5, sp
	addi	a5, a5, 16
	vl8re8.v	v16, (a5)                       # Unknown-size Folded Reload
.LBB2_15:                               # %vector.body168
                                        #   Parent Loop BB2_13 Depth=1
                                        #     Parent Loop BB2_14 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a5, t4, a3
	vsetvli	a5, a5, e8, m1, ta, mu
	vsetvli	s1, zero, e64, m8, ta, mu
	vmv.v.x	v8, a4
	vsetvli	zero, a5, e64, m8, ta, mu
	vmacc.vx	v8, t6, v16
	vsetvli	zero, zero, e8, m1, ta, mu
	vsoxei64.v	v25, (t2), v8, v0.t
	add	a3, a3, a5
	vsetvli	s1, zero, e64, m8, ta, mu
	vadd.vx	v16, v16, a5
	bne	a3, t4, .LBB2_15
# %bb.16:                               # %for.cond10.for.cond.cleanup12_crit_edge.split.us125.us.us
                                        #   in Loop: Header=BB2_14 Depth=2
	addi	a1, a1, 1
	bne	a1, t0, .LBB2_14
# %bb.17:                               # %for.cond6.for.cond.cleanup8_crit_edge.split.us.split.us140.us
                                        #   in Loop: Header=BB2_13 Depth=1
	addi	a0, a0, 1
	bne	a0, a6, .LBB2_13
.LBB2_18:                               # %for.cond.cleanup
	csrr	a0, vlenb
	addi	a1, zero, 27
	mul	a0, a0, a1
	add	sp, sp, a0
	ld	s1, 16(sp)                      # 8-byte Folded Reload
	ld	s0, 24(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end2:
	.size	correlation_golden, .Lfunc_end2-correlation_golden
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %for.cond6.preheader.lr.ph.split.us.split.us.i
	addi	sp, sp, -80
	sd	ra, 72(sp)                      # 8-byte Folded Spill
	sd	s0, 64(sp)                      # 8-byte Folded Spill
	sd	s1, 56(sp)                      # 8-byte Folded Spill
	sd	s2, 48(sp)                      # 8-byte Folded Spill
	sd	s3, 40(sp)                      # 8-byte Folded Spill
	sd	s4, 32(sp)                      # 8-byte Folded Spill
	sd	s5, 24(sp)                      # 8-byte Folded Spill
	sd	s6, 16(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	addi	a1, zero, 22
	mul	a0, a0, a1
	sub	sp, sp, a0
	mv	a7, zero
	lui	a0, 7
	addiw	t1, a0, 896
	lui	a0, 5
	addiw	t2, a0, -768
	#APP
	rdcycle	a6

	#NO_APP
	vsetvli	a0, zero, e64, m8, ta, mu
	vid.v	v8
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, a0, sp
	addi	a0, a0, 16
	vs8r.v	v8, (a0)                        # Unknown-size Folded Spill
	addi	t0, zero, 88
	vsetvli	zero, zero, e16, m2, ta, mu
	vmv.v.i	v4, 0
	addi	a5, zero, 58
	vmset.m	v1
	lui	a0, 2
	addiw	a0, a0, 1664
	lui	a1, %hi(src1_arr_global)
	addi	a1, a1, %lo(src1_arr_global)
	lui	a2, %hi(src0_arr_global)
	addi	a4, a2, %lo(src0_arr_global)
	vsetvli	zero, zero, e32, m4, ta, mu
	vid.v	v12
	lui	a2, %hi(out_arr_global)
	addi	s4, a2, %lo(out_arr_global)
	lui	a2, 10
	addiw	s2, a2, -1536
	addi	t3, zero, 112
	addi	t4, zero, 2
	addi	t5, zero, 3
	addi	t6, zero, 4
	csrr	a2, vlenb
	addi	a3, zero, 10
	mul	a2, a2, a3
	add	a2, a2, sp
	addi	a2, a2, 16
	vs4r.v	v12, (a2)                       # Unknown-size Folded Spill
	addi	a2, sp, 16
	vs2r.v	v4, (a2)                        # Unknown-size Folded Spill
	j	.LBB3_2
.LBB3_1:                                # %for.cond6.for.cond.cleanup8_crit_edge.split.us.split.us.us.us.us.i
                                        #   in Loop: Header=BB3_2 Depth=1
	addi	a7, a7, 1
	beq	a7, t3, .LBB3_24
.LBB3_2:                                # %for.cond6.preheader.us.us.us.i
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_7 Depth 2
                                        #       Child Loop BB3_8 Depth 3
                                        #       Child Loop BB3_11 Depth 3
                                        #       Child Loop BB3_14 Depth 3
                                        #       Child Loop BB3_18 Depth 3
                                        #       Child Loop BB3_21 Depth 3
	mv	s5, zero
	mul	s3, a7, t0
	j	.LBB3_7
.LBB3_3:                                # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i.1.thread
                                        #   in Loop: Header=BB3_7 Depth=2
	add	a2, s6, s4
	sb	zero, 0(a2)
	add	s6, a3, t2
	addi	a2, sp, 16
	vl2re8.v	v4, (a2)                        # Unknown-size Folded Reload
.LBB3_4:                                # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i.2.thread
                                        #   in Loop: Header=BB3_7 Depth=2
	add	a2, s6, s4
	sb	zero, 0(a2)
	add	s6, a3, t1
.LBB3_5:                                # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i.3.thread
                                        #   in Loop: Header=BB3_7 Depth=2
	mv	a2, zero
	add	s0, s6, s4
	sb	zero, 0(s0)
.LBB3_6:                                # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i.4
                                        #   in Loop: Header=BB3_7 Depth=2
	add	a3, a3, s4
	add	a3, a3, s2
	addi	s5, s5, 1
	sb	a2, 0(a3)
	beq	s5, t0, .LBB3_1
.LBB3_7:                                # %for.body20.us108.us.us.us.us.us.i.preheader
                                        #   Parent Loop BB3_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_8 Depth 3
                                        #       Child Loop BB3_11 Depth 3
                                        #       Child Loop BB3_14 Depth 3
                                        #       Child Loop BB3_18 Depth 3
                                        #       Child Loop BB3_21 Depth 3
	mv	a2, zero
	vsetvli	zero, zero, e16, m2, tu, mu
	vmv2r.v	v8, v4
	vmv.s.x	v8, zero
	add	a3, s5, s3
	csrr	s0, vlenb
	slli	s0, s0, 1
	add	s0, s0, sp
	addi	s0, s0, 16
	vl8re8.v	v16, (s0)                       # Unknown-size Folded Reload
.LBB3_8:                                # %vector.body162
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	s1, a5, a2
	vsetvli	s1, s1, e16, m2, ta, mu
	vsetvli	s0, zero, e64, m8, ta, mu
	vmv1r.v	v10, v1
	vmv.v.x	v0, a3
	vsetvli	zero, s1, e64, m8, ta, mu
	vmv8r.v	v24, v16
	csrr	s0, vlenb
	addi	s6, zero, 14
	mul	s0, s0, s6
	add	s0, s0, sp
	addi	s0, s0, 16
	vs8r.v	v0, (s0)                        # Unknown-size Folded Spill
	vmadd.vx	v24, a0, v0
	vmv1r.v	v1, v10
	vsetvli	zero, zero, e8, m1, ta, mu
	vmv1r.v	v0, v10
	vloxei64.v	v10, (a1), v24, v0.t
	vmv1r.v	v0, v1
	vloxei64.v	v11, (a4), v24, v0.t
	vwaddu.vx	v26, v10, zero
	vwaddu.vx	v28, v11, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	vmadd.vv	v28, v26, v8
	vsetvli	s0, zero, e32, m4, ta, mu
	vmsltu.vx	v0, v12, s1
	vsetvli	zero, zero, e16, m2, ta, mu
	vmerge.vvm	v8, v8, v28, v0
	add	a2, a2, s1
	vsetvli	zero, zero, e64, m8, ta, mu
	vadd.vx	v16, v16, s1
	bne	a2, a5, .LBB3_8
# %bb.9:                                # %middle.block160
                                        #   in Loop: Header=BB3_7 Depth=2
	vsetivli	zero, 1, e16, m1, ta, mu
	vmv.v.i	v6, 0
	vsetvli	a2, zero, e16, m2, ta, mu
	vredsum.vs	v25, v8, v6
	vmv.x.s	a2, v25
	add	s0, a3, s4
	sb	a2, 0(s0)
	add	s6, a3, a0
	beqz	s5, .LBB3_3
# %bb.10:                               # %vector.ph132
                                        #   in Loop: Header=BB3_7 Depth=2
	mv	a2, zero
	vsetvli	zero, zero, e16, m2, tu, mu
	addi	s0, sp, 16
	vl2re8.v	v4, (s0)                        # Unknown-size Folded Reload
	vmv2r.v	v2, v4
	vmv.s.x	v2, zero
	vsetvli	zero, zero, e64, m8, ta, mu
	vid.v	v24
.LBB3_11:                               # %vector.body131
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	s0, a5, a2
	vsetvli	s0, s0, e16, m2, ta, mu
	vsetvli	s1, zero, e8, m1, ta, mu
	vmset.m	v0
	vsetvli	zero, s0, e64, m8, ta, mu
	vmv8r.v	v8, v24
	csrr	s1, vlenb
	addi	ra, zero, 14
	mul	s1, s1, ra
	add	s1, s1, sp
	addi	s1, s1, 16
	vl8re8.v	v16, (s1)                       # Unknown-size Folded Reload
	vmadd.vx	v8, a0, v16
	vadd.vi	v16, v8, -1
	vsetvli	zero, zero, e8, m1, ta, mu
	vloxei64.v	v7, (a1), v16, v0.t
	vloxei64.v	v16, (a4), v8, v0.t
	csrr	s1, vlenb
	addi	ra, zero, 10
	mul	s1, s1, ra
	add	s1, s1, sp
	addi	s1, s1, 16
	vl4re8.v	v12, (s1)                       # Unknown-size Folded Reload
	vwaddu.vx	v8, v7, zero
	vwaddu.vx	v10, v16, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	vmadd.vv	v10, v8, v2
	vsetvli	s1, zero, e32, m4, ta, mu
	vmsltu.vx	v0, v12, s0
	vsetvli	zero, zero, e16, m2, ta, mu
	vmerge.vvm	v2, v2, v10, v0
	add	a2, a2, s0
	vsetvli	zero, zero, e64, m8, ta, mu
	vadd.vx	v24, v24, s0
	bne	a2, a5, .LBB3_11
# %bb.12:                               # %middle.block129
                                        #   in Loop: Header=BB3_7 Depth=2
	vsetvli	zero, zero, e16, m2, ta, mu
	vredsum.vs	v25, v2, v6
	vmv.x.s	a2, v25
	add	s0, s6, s4
	sb	a2, 0(s0)
	add	s6, a3, t2
	bltu	s5, t4, .LBB3_4
# %bb.13:                               # %vector.ph101
                                        #   in Loop: Header=BB3_7 Depth=2
	mv	a2, zero
	vsetvli	zero, zero, e16, m2, tu, mu
	vmv2r.v	v2, v4
	vmv.s.x	v2, zero
	vsetvli	zero, zero, e64, m8, ta, mu
	vid.v	v8
.LBB3_14:                               # %vector.body100
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	s0, a5, a2
	vsetvli	s0, s0, e16, m2, ta, mu
	vsetvli	s1, zero, e8, m1, ta, mu
	vmset.m	v0
	vsetvli	zero, s0, e64, m8, ta, mu
	vmv8r.v	v24, v8
	csrr	s1, vlenb
	addi	ra, zero, 14
	mul	s1, s1, ra
	add	s1, s1, sp
	addi	s1, s1, 16
	vl8re8.v	v16, (s1)                       # Unknown-size Folded Reload
	vmadd.vx	v24, a0, v16
	vadd.vi	v16, v24, -2
	vsetvli	zero, zero, e8, m1, ta, mu
	vloxei64.v	v7, (a1), v16, v0.t
	vloxei64.v	v16, (a4), v24, v0.t
	vwaddu.vx	v26, v7, zero
	vwaddu.vx	v28, v16, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	vmadd.vv	v28, v26, v2
	vsetvli	s1, zero, e32, m4, ta, mu
	csrr	s1, vlenb
	addi	ra, zero, 10
	mul	s1, s1, ra
	add	s1, s1, sp
	addi	s1, s1, 16
	vl4re8.v	v16, (s1)                       # Unknown-size Folded Reload
	vmsltu.vx	v0, v16, s0
	vsetvli	zero, zero, e16, m2, ta, mu
	vmerge.vvm	v2, v2, v28, v0
	add	a2, a2, s0
	vsetvli	zero, zero, e64, m8, ta, mu
	vadd.vx	v8, v8, s0
	bne	a2, a5, .LBB3_14
# %bb.15:                               # %middle.block98
                                        #   in Loop: Header=BB3_7 Depth=2
	vsetvli	zero, zero, e16, m2, ta, mu
	vredsum.vs	v25, v2, v6
	vmv.x.s	a2, v25
	add	s0, s6, s4
	sb	a2, 0(s0)
	add	s6, a3, t1
	bgeu	s5, t5, .LBB3_17
# %bb.16:                               #   in Loop: Header=BB3_7 Depth=2
	csrr	a2, vlenb
	addi	s0, zero, 10
	mul	a2, a2, s0
	add	a2, a2, sp
	addi	a2, a2, 16
	vl4re8.v	v12, (a2)                       # Unknown-size Folded Reload
	j	.LBB3_5
.LBB3_17:                               # %vector.ph70
                                        #   in Loop: Header=BB3_7 Depth=2
	mv	a2, zero
	vsetvli	zero, zero, e16, m2, tu, mu
	vmv2r.v	v2, v4
	vmv.s.x	v2, zero
	vsetvli	zero, zero, e64, m8, ta, mu
	vid.v	v8
.LBB3_18:                               # %vector.body69
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	s0, a5, a2
	vsetvli	s0, s0, e16, m2, ta, mu
	vsetvli	s1, zero, e8, m1, ta, mu
	vmset.m	v0
	vsetvli	zero, s0, e64, m8, ta, mu
	vmv8r.v	v24, v8
	csrr	s1, vlenb
	addi	ra, zero, 14
	mul	s1, s1, ra
	add	s1, s1, sp
	addi	s1, s1, 16
	vl8re8.v	v16, (s1)                       # Unknown-size Folded Reload
	vmadd.vx	v24, a0, v16
	vadd.vi	v16, v24, -3
	vsetvli	zero, zero, e8, m1, ta, mu
	vloxei64.v	v7, (a1), v16, v0.t
	vloxei64.v	v16, (a4), v24, v0.t
	vwaddu.vx	v26, v7, zero
	vwaddu.vx	v28, v16, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	vmadd.vv	v28, v26, v2
	vsetvli	s1, zero, e32, m4, ta, mu
	csrr	s1, vlenb
	addi	ra, zero, 10
	mul	s1, s1, ra
	add	s1, s1, sp
	addi	s1, s1, 16
	vl4re8.v	v16, (s1)                       # Unknown-size Folded Reload
	vmsltu.vx	v0, v16, s0
	vsetvli	zero, zero, e16, m2, ta, mu
	vmerge.vvm	v2, v2, v28, v0
	add	a2, a2, s0
	vsetvli	zero, zero, e64, m8, ta, mu
	vadd.vx	v8, v8, s0
	bne	a2, a5, .LBB3_18
# %bb.19:                               # %middle.block67
                                        #   in Loop: Header=BB3_7 Depth=2
	vsetvli	zero, zero, e16, m2, ta, mu
	vredsum.vs	v25, v2, v6
	vmv.x.s	a2, v25
	add	s0, s6, s4
	sb	a2, 0(s0)
	mv	a2, zero
	bltu	s5, t6, .LBB3_23
# %bb.20:                               # %vector.ph
                                        #   in Loop: Header=BB3_7 Depth=2
	vsetvli	zero, zero, e16, m2, tu, mu
	vmv2r.v	v2, v4
	vmv.s.x	v2, zero
	vsetvli	zero, zero, e64, m8, ta, mu
	vid.v	v8
.LBB3_21:                               # %vector.body
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	s0, a5, a2
	vsetvli	s0, s0, e16, m2, ta, mu
	vsetvli	s1, zero, e8, m1, ta, mu
	vmset.m	v0
	vsetvli	zero, s0, e64, m8, ta, mu
	vmv8r.v	v24, v8
	csrr	s1, vlenb
	addi	s6, zero, 14
	mul	s1, s1, s6
	add	s1, s1, sp
	addi	s1, s1, 16
	vl8re8.v	v16, (s1)                       # Unknown-size Folded Reload
	vmadd.vx	v24, a0, v16
	vadd.vi	v16, v24, -4
	vsetvli	zero, zero, e8, m1, ta, mu
	vloxei64.v	v7, (a1), v16, v0.t
	vloxei64.v	v16, (a4), v24, v0.t
	vwaddu.vx	v26, v7, zero
	vwaddu.vx	v28, v16, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	vmadd.vv	v28, v26, v2
	vsetvli	s1, zero, e32, m4, ta, mu
	csrr	s1, vlenb
	addi	s6, zero, 10
	mul	s1, s1, s6
	add	s1, s1, sp
	addi	s1, s1, 16
	vl4re8.v	v16, (s1)                       # Unknown-size Folded Reload
	vmsltu.vx	v0, v16, s0
	vsetvli	zero, zero, e16, m2, ta, mu
	vmerge.vvm	v2, v2, v28, v0
	add	a2, a2, s0
	vsetvli	zero, zero, e64, m8, ta, mu
	vadd.vx	v8, v8, s0
	bne	a2, a5, .LBB3_21
# %bb.22:                               # %middle.block
                                        #   in Loop: Header=BB3_7 Depth=2
	vsetvli	zero, zero, e16, m2, ta, mu
	vredsum.vs	v25, v2, v6
	vmv.x.s	a2, v25
.LBB3_23:                               # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i.4
                                        #   in Loop: Header=BB3_7 Depth=2
	csrr	s0, vlenb
	addi	s1, zero, 10
	mul	s0, s0, s1
	add	s0, s0, sp
	addi	s0, s0, 16
	vl4re8.v	v12, (s0)                       # Unknown-size Folded Reload
	j	.LBB3_6
.LBB3_24:                               # %correlation_golden.exit
	#APP
	rdcycle	a0

	#NO_APP
	subw	a1, a0, a6
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	call	printf
	mv	a0, zero
	csrr	a1, vlenb
	addi	a2, zero, 22
	mul	a1, a1, a2
	add	sp, sp, a1
	ld	s6, 16(sp)                      # 8-byte Folded Reload
	ld	s5, 24(sp)                      # 8-byte Folded Reload
	ld	s4, 32(sp)                      # 8-byte Folded Reload
	ld	s3, 40(sp)                      # 8-byte Folded Reload
	ld	s2, 48(sp)                      # 8-byte Folded Reload
	ld	s1, 56(sp)                      # 8-byte Folded Reload
	ld	s0, 64(sp)                      # 8-byte Folded Reload
	ld	ra, 72(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 80
	ret
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
                                        # -- End function
	.type	src0_arr_global,@object         # @src0_arr_global
	.data
	.globl	src0_arr_global
	.p2align	3
src0_arr_global:
	.byte	1                               # 0x1
	.zero	571647
	.size	src0_arr_global, 571648

	.type	src1_arr_global,@object         # @src1_arr_global
	.globl	src1_arr_global
	.p2align	3
src1_arr_global:
	.byte	1                               # 0x1
	.zero	571647
	.size	src1_arr_global, 571648

	.type	out_arr_global,@object          # @out_arr_global
	.bss
	.globl	out_arr_global
	.p2align	3
out_arr_global:
	.zero	49280
	.size	out_arr_global, 49280

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.8,"aMS",@progbits,1
	.p2align	3
.L.str:
	.asciz	"correlation_58x112x88_test running cycles : %d.\n"
	.size	.L.str, 49

	.ident	"Terapines LTD zcc version 1.0.0 (https://www.terapines.com 153ecb6322f1f09cb4ffa189f112fa2836ff5f3b)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym src0_arr_global
	.addrsig_sym src1_arr_global
	.addrsig_sym out_arr_global
