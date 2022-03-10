
OUTPUT_ARCH("riscv")
ENTRY(_start)

MEMORY{
    RAM     : ORIGIN = 0x80000000, LENGTH = 32M
    ICCM    : ORIGIN = 0xee000000, LENGTH = 0x80000
    DCCM    : ORIGIN = 0xf0040000, LENGTH = 0x10000
    CTL     : ORIGIN = 0xfffffff0, LENGTH = 16
}

SECTIONS {
    __stack_size = DEFINED(__stack_size) ? __stack_size : 2K;

    .text   : { *(.text_init) * (.text*) } > RAM
    text_end = .;

    .data   : { . = ALIGN(8); *(.*data) *(.rodata*) *(.sbss)} > RAM
    .bss    : { *(.bss)} > RAM
    data_end = .;

    . = ALIGN(8);
    PROVIDE( _end = .);
    PROVIDE( end = .);
    .stack ORIGIN(RAM) + LENGTH(RAM) - __stack_size :
    {
        PROVIDE( _heap_end = .);
        . += __stack_size;
        PROVIDE( _sp = .);
    } > RAM
}