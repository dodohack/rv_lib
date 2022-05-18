	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0_v0p10_zvlsseg0p10"
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
	sext.w	a0, a0
	ret
.Lfunc_end0:
	.size	read_rdcycle, .Lfunc_end0-read_rdcycle
                                        # -- End function
	.globl	resize_param_read               # -- Begin function resize_param_read
	.p2align	1
	.type	resize_param_read,@function
resize_param_read:                      # @resize_param_read
# %bb.0:                                # %entry
	lwu	a2, 8(a1)
	slli	a3, a2, 16
	srli	a2, a2, 16
	or	a2, a2, a3
	sw	a2, 0(a0)
	lh	a1, 14(a1)
	sh	a1, 4(a0)
	lui	a1, %hi(src_arr_global)
	addi	a1, a1, %lo(src_arr_global)
	sd	a1, 8(a0)
	lui	a1, %hi(out_arr_global)
	addi	a1, a1, %lo(out_arr_global)
	sd	a1, 16(a0)
	ret
.Lfunc_end1:
	.size	resize_param_read, .Lfunc_end1-resize_param_read
                                        # -- End function
	.globl	resize_golden_v2                # -- Begin function resize_golden_v2
	.p2align	1
	.type	resize_golden_v2,@function
resize_golden_v2:                       # @resize_golden_v2
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
	lhu	a2, 0(a0)
	lhu	a1, 2(a0)
	lhu	t5, 4(a0)
	sd	a2, 24(sp)                      # 8-byte Folded Spill
	seqz	a3, a2
	slli	t1, a1, 1
	slli	s5, t5, 1
	lui	a2, 16
	addiw	a4, a2, -2
	and	a5, t1, a4
	and	t3, s5, a4
	seqz	a4, t3
	sd	a5, 16(sp)                      # 8-byte Folded Spill
	seqz	a5, a5
	or	a3, a3, a5
	or	a3, a3, a4
	beqz	a3, .LBB2_2
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
.LBB2_2:                                # %for.cond11.preheader.us.us.preheader
	mv	a4, zero
	mv	a3, zero
	ld	t2, 8(a0)
	ld	s6, 16(a0)
	addi	t4, a1, -1
	mulw	a0, t5, a1
	sd	a0, 8(sp)                       # 8-byte Folded Spill
	addi	s7, t5, -1
	addiw	t0, a2, -1
	addi	s4, zero, -128
	j	.LBB2_4
.LBB2_3:                                # %for.cond11.for.cond.cleanup16_crit_edge.split.us.us.us
                                        #   in Loop: Header=BB2_4 Depth=1
	ld	a3, 32(sp)                      # 8-byte Folded Reload
	addi	a3, a3, 1
	and	a4, a3, t0
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	bgeu	a4, a0, .LBB2_1
.LBB2_4:                                # %for.cond11.preheader.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_6 Depth 2
                                        #       Child Loop BB2_12 Depth 3
	sd	a3, 32(sp)                      # 8-byte Folded Spill
	mv	t6, zero
	ld	a0, 8(sp)                       # 8-byte Folded Reload
	mulw	s3, a0, a4
	ld	a0, 16(sp)                      # 8-byte Folded Reload
	mulw	s2, a4, a0
	j	.LBB2_6
.LBB2_5:                                # %for.cond73.for.cond.cleanup78_crit_edge.us.us.us
                                        #   in Loop: Header=BB2_6 Depth=2
	addi	t6, t6, 1
	and	a0, t6, t0
	and	a1, t1, t0
	bgeu	a0, a1, .LBB2_3
.LBB2_6:                                # %for.body17.us.us.us
                                        #   Parent Loop BB2_4 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_12 Depth 3
	and	a0, t6, t0
	srli	a1, a0, 1
	andi	a1, a1, 511
	blt	a1, t4, .LBB2_8
# %bb.7:                                # %for.body17.us.us.us
                                        #   in Loop: Header=BB2_6 Depth=2
	mv	a4, t4
	j	.LBB2_9
.LBB2_8:                                #   in Loop: Header=BB2_6 Depth=2
	addi	a4, a1, 1
.LBB2_9:                                # %for.body17.us.us.us
                                        #   in Loop: Header=BB2_6 Depth=2
	mv	s1, zero
	slli	a2, t6, 6
	slli	s0, a1, 7
	sub	a2, a2, s0
	andi	s8, a2, 192
	sub	s0, s4, a2
	mul	a1, a1, t5
	addw	s11, a1, s3
	and	a1, a4, t0
	mul	a1, a1, t5
	addw	ra, a1, s3
	add	a0, a0, s2
	mulw	s9, a0, t3
	andi	s10, s0, 192
	j	.LBB2_12
.LBB2_10:                               # %for.body79.us.us.us
                                        #   in Loop: Header=BB2_12 Depth=3
	mv	a1, s7
.LBB2_11:                               # %for.body79.us.us.us
                                        #   in Loop: Header=BB2_12 Depth=3
	slli	a2, s1, 6
	slli	a4, a0, 7
	sub	a2, a2, a4
	andi	a4, a2, 192
	sub	a2, s4, a2
	add	a6, s11, a0
	and	a1, a1, t0
	add	a7, a1, s11
	add	a0, a0, ra
	add	a1, a1, ra
	slli	a5, a7, 32
	srli	a5, a5, 32
	add	a5, a5, t2
	lb	a5, 0(a5)
	slli	a3, a6, 32
	srli	a3, a3, 32
	add	a3, a3, t2
	lb	a3, 0(a3)
	add	s0, s0, s9
	mul	a5, a5, a4
	andi	a2, a2, 192
	mul	a3, a3, a2
	slli	a1, a1, 32
	srli	a1, a1, 32
	add	a1, a1, t2
	lb	a1, 0(a1)
	slli	a0, a0, 32
	srli	a0, a0, 32
	add	a0, a0, t2
	lb	a0, 0(a0)
	add	a3, a3, a5
	srli	a3, a3, 7
	mul	a1, a1, a4
	mul	a0, a0, a2
	add	a0, a0, a1
	srli	a0, a0, 7
	mul	a0, a0, s8
	mul	a1, a3, s10
	add	a0, a0, a1
	srli	a0, a0, 7
	slli	a1, s0, 32
	srli	a1, a1, 32
	add	a1, a1, s6
	addi	s1, s1, 1
	and	a2, s1, t0
	and	a3, s5, t0
	sb	a0, 0(a1)
	bgeu	a2, a3, .LBB2_5
.LBB2_12:                               # %for.body79.us.us.us
                                        #   Parent Loop BB2_4 Depth=1
                                        #     Parent Loop BB2_6 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	and	s0, s1, t0
	srli	a0, s0, 1
	andi	a0, a0, 511
	bge	a0, s7, .LBB2_10
# %bb.13:                               #   in Loop: Header=BB2_12 Depth=3
	addi	a1, a0, 1
	j	.LBB2_11
.Lfunc_end2:
	.size	resize_golden_v2, .Lfunc_end2-resize_golden_v2
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %for.cond11.preheader.us.us.i
	addi	sp, sp, -80
	sd	ra, 72(sp)                      # 8-byte Folded Spill
	sd	s0, 64(sp)                      # 8-byte Folded Spill
	sd	s1, 56(sp)                      # 8-byte Folded Spill
	sd	s2, 48(sp)                      # 8-byte Folded Spill
	sd	s3, 40(sp)                      # 8-byte Folded Spill
	sd	s4, 32(sp)                      # 8-byte Folded Spill
	sd	s5, 24(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	addi	a1, zero, 30
	mul	a0, a0, a1
	sub	sp, sp, a0
	mv	t2, zero
	#APP
	rdcycle	a6

	#NO_APP
	vsetvli	a0, zero, e16, m2, ta, mu
	vid.v	v26
	addi	a0, sp, 24
	vs2r.v	v26, (a0)                       # Unknown-size Folded Spill
	csrr	t6, vlenb
	vsetvli	zero, zero, e64, m8, ta, mu
	vid.v	v8
	addi	a7, zero, 88
	addi	s2, zero, 176
	addi	s3, zero, -128
	lui	a0, 2
	addiw	t1, a0, 1576
	addi	t0, zero, 222
	vmset.m	v2
	addi	t3, zero, 174
	addi	a0, zero, 87
	vsetvli	zero, zero, e32, m4, ta, mu
	vmv.v.x	v4, a0
	addi	t5, zero, 192
	lui	a0, %hi(src_arr_global)
	addi	a1, a0, %lo(src_arr_global)
	lui	a0, %hi(out_arr_global)
	addi	s4, a0, %lo(out_arr_global)
	addi	t4, zero, 224
	csrr	a0, vlenb
	addi	a2, zero, 6
	mul	a0, a0, a2
	add	a0, a0, sp
	addi	a0, a0, 24
	vs8r.v	v8, (a0)                        # Unknown-size Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, a0, sp
	addi	a0, a0, 24
	vs4r.v	v4, (a0)                        # Unknown-size Folded Spill
.LBB3_1:                                # %for.body17.us.us.us.i
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_5 Depth 2
	slli	a0, t2, 48
	srli	a3, a0, 49
	mul	a0, a3, a7
	bltu	t2, t0, .LBB3_3
# %bb.2:                                # %for.body17.us.us.us.i
                                        #   in Loop: Header=BB3_1 Depth=1
	mv	a2, t1
	j	.LBB3_4
.LBB3_3:                                #   in Loop: Header=BB3_1 Depth=1
	addi	a2, a0, 88
.LBB3_4:                                # %for.body17.us.us.us.i
                                        #   in Loop: Header=BB3_1 Depth=1
	mv	s0, zero
	slli	a3, a3, 7
	slli	a4, t2, 6
	sub	a3, a4, a3
	mul	s5, t2, s2
	sub	a4, s3, a3
	andi	a4, a4, 192
	andi	a5, a3, 192
	addi	a3, sp, 24
	vl2re8.v	v18, (a3)                       # Unknown-size Folded Reload
	vmv2r.v	v16, v18
.LBB3_5:                                # %vector.body
                                        #   Parent Loop BB3_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vsetvli	zero, zero, e64, m8, ta, mu
	vadd.vx	v24, v8, s0
	sub	a3, s2, s0
	vsetvli	a3, a3, e8, m1, ta, mu
	vsetvli	zero, a3, e16, m2, ta, mu
	vsrl.vi	v12, v16, 1
	vwaddu.vx	v8, v12, zero
	vsetvli	zero, zero, e32, m4, ta, mu
	vadd.vi	v20, v8, 1
	vsetvli	zero, zero, e64, m8, ta, mu
	vmsltu.vx	v0, v24, t3
	vsetvli	zero, zero, e32, m4, ta, mu
	vmerge.vvm	v28, v4, v20, v0
	vsetvli	zero, zero, e16, m2, ta, mu
	vsll.vi	v26, v18, 6
	vmacc.vx	v26, s3, v12
	vand.vx	v12, v26, t5
	vwaddu.vx	v4, v12, zero
	csrr	s1, vlenb
	addi	ra, zero, 14
	mul	s1, s1, ra
	add	s1, s1, sp
	addi	s1, s1, 24
	vs4r.v	v4, (s1)                        # Unknown-size Folded Spill
	vsetvli	zero, zero, e8, m1, ta, mu
	vnsrl.wi	v25, v26, 0
	vrsub.vx	v20, v25, s3
	vsetvli	zero, zero, e32, m4, ta, mu
	vadd.vx	v24, v8, a0
	vmv1r.v	v21, v2
	vadd.vx	v0, v28, a0
	vadd.vx	v8, v8, a2
	csrr	s1, vlenb
	addi	ra, zero, 26
	mul	s1, s1, ra
	add	s1, s1, sp
	addi	s1, s1, 24
	vs4r.v	v8, (s1)                        # Unknown-size Folded Spill
	vadd.vx	v28, v28, a2
	csrr	s1, vlenb
	addi	ra, zero, 22
	mul	s1, s1, ra
	add	s1, s1, sp
	addi	s1, s1, 24
	vs4r.v	v28, (s1)                       # Unknown-size Folded Spill
	vwaddu.vx	v8, v0, zero
	vmv1r.v	v2, v21
	vsetvli	zero, zero, e8, m1, ta, mu
	vmv1r.v	v0, v21
	vloxei64.v	v21, (a1), v8, v0.t
	vwadd.vx	v8, v21, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	vwadd.vx	v28, v8, zero
	vsetvli	zero, zero, e32, m4, ta, mu
	vwaddu.vx	v8, v24, zero
	vsetvli	zero, zero, e8, m1, ta, mu
	vmv1r.v	v0, v2
	vloxei64.v	v25, (a1), v8, v0.t
	vwadd.vx	v26, v25, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	vwadd.vx	v8, v26, zero
	vsetvli	zero, zero, e8, m1, ta, mu
	vwaddu.vx	v26, v20, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	vwaddu.vx	v12, v26, zero
	vsetvli	zero, zero, e32, m4, ta, mu
	vmul.vv	v8, v12, v8
	vmacc.vv	v8, v4, v28
	vsra.vi	v28, v8, 7
	csrr	s1, vlenb
	addi	ra, zero, 18
	mul	s1, s1, ra
	add	s1, s1, sp
	addi	s1, s1, 24
	vs4r.v	v28, (s1)                       # Unknown-size Folded Spill
	csrr	s1, vlenb
	addi	ra, zero, 22
	mul	s1, s1, ra
	add	s1, s1, sp
	addi	s1, s1, 24
	vl4re8.v	v8, (s1)                        # Unknown-size Folded Reload
	vwaddu.vx	v24, v8, zero
	csrr	s1, vlenb
	slli	s1, s1, 1
	add	s1, s1, sp
	addi	s1, s1, 24
	vl4re8.v	v4, (s1)                        # Unknown-size Folded Reload
	vsetvli	zero, zero, e8, m1, ta, mu
	vloxei64.v	v20, (a1), v24, v0.t
	vwadd.vx	v26, v20, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	vwadd.vx	v20, v26, zero
	vsetvli	zero, zero, e32, m4, ta, mu
	csrr	s1, vlenb
	addi	ra, zero, 26
	mul	s1, s1, ra
	add	s1, s1, sp
	addi	s1, s1, 24
	vl4re8.v	v8, (s1)                        # Unknown-size Folded Reload
	vwaddu.vx	v24, v8, zero
	vsetvli	zero, zero, e8, m1, ta, mu
	vloxei64.v	v1, (a1), v24, v0.t
	vwadd.vx	v26, v1, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	vwadd.vx	v28, v26, zero
	vsetvli	zero, zero, e32, m4, ta, mu
	vmul.vv	v28, v12, v28
	csrr	s1, vlenb
	addi	ra, zero, 14
	mul	s1, s1, ra
	add	s1, s1, sp
	addi	s1, s1, 24
	vl4re8.v	v8, (s1)                        # Unknown-size Folded Reload
	vmacc.vv	v28, v8, v20
	vsra.vi	v28, v28, 7
	vmul.vx	v28, v28, a5
	csrr	s1, vlenb
	addi	ra, zero, 18
	mul	s1, s1, ra
	add	s1, s1, sp
	addi	s1, s1, 24
	vl4re8.v	v8, (s1)                        # Unknown-size Folded Reload
	vmacc.vx	v28, a4, v8
	csrr	s1, vlenb
	addi	ra, zero, 6
	mul	s1, s1, ra
	add	s1, s1, sp
	addi	s1, s1, 24
	vl8re8.v	v8, (s1)                        # Unknown-size Folded Reload
	vsrl.vi	v28, v28, 7
	vsetvli	zero, zero, e16, m2, ta, mu
	vnsrl.wi	v26, v28, 0
	vsetvli	zero, zero, e8, m1, ta, mu
	vnsrl.wi	v25, v26, 0
	add	s1, s5, s0
	add	s1, s1, s4
	vse8.v	v25, (s1)
	add	s0, s0, a3
	vsetvli	s1, zero, e16, m2, ta, mu
	vadd.vx	v16, v16, t6
	vadd.vx	v18, v18, a3
	bne	s0, s2, .LBB3_5
# %bb.6:                                # %for.cond73.for.cond.cleanup78_crit_edge.us.us.us.i
                                        #   in Loop: Header=BB3_1 Depth=1
	addi	t2, t2, 1
	bne	t2, t4, .LBB3_1
# %bb.7:                                # %resize_golden_v2.exit
	#APP
	rdcycle	a0

	#NO_APP
	subw	a1, a0, a6
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	call	printf
	mv	a0, zero
	csrr	a1, vlenb
	addi	a2, zero, 30
	mul	a1, a1, a2
	add	sp, sp, a1
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
	.type	src_arr_global,@object          # @src_arr_global
	.data
	.globl	src_arr_global
	.p2align	3
src_arr_global:
	.byte	2                               # 0x2
	.zero	9855
	.size	src_arr_global, 9856

	.type	out_arr_global,@object          # @out_arr_global
	.bss
	.globl	out_arr_global
	.p2align	3
out_arr_global:
	.zero	39424
	.size	out_arr_global, 39424

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.8,"aMS",@progbits,1
	.p2align	3
.L.str:
	.asciz	"resize_1x112x88 running cycles : %d.\n"
	.size	.L.str, 38

	.ident	"Terapines LTD zcc version 1.0.0 (https://www.terapines.com 153ecb6322f1f09cb4ffa189f112fa2836ff5f3b)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym src_arr_global
	.addrsig_sym out_arr_global
