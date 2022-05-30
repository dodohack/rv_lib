#ifndef __PLATFORM_H
#define __PLATFORM_H

#include <riscv_vector.h>

int read_rdcycle(){
    int tmp_cycle = 0;
    asm __volatile__("rdinstret %[dst01]\n" : [dst01]"=r"(tmp_cycle) : :"memory");
    //asm __volatile__("rdcycle %[dst01]\n" : [dst01]"=r"(tmp_cycle) : :"memory");
    //asm __volatile__("csrr %[dst01], mcycle\n" : [dst01]"=r"(tmp_cycle) : :"memory");
    return tmp_cycle;
}

#endif
