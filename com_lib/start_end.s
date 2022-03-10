.pushsection .tohost,"aw",@progbits;
.align 6; .global tohost; tohost; .dword 0;
.align 6; .global fromhost; fromhost; .dword 0;
.popsection;

.attribute unaligned_access, 0
.attribute stack_align, 16
.text
.align 6
.globl _start
.type  _start, @function

_start:
    li t0, 0x300
    csrw    mstatus, t0
    # Set stack pointer.
    la sp, _sp
    call main

_end:
    li ra, 1
    halt:
        write_tohost:
            sw ra, tohost, t5
        self_loop:
            j self_loop
    .rept 10
    nop
    .endr