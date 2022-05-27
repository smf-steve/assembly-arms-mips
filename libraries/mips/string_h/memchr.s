.globl memchr

                .include "macros/syscalls.s"
                .include "macros/subroutine.s"

#####################################################################################
.ent memchr
# memchr -- locate a byte in memory

memchr:         nop                                 # void * memchr(void *src, unsigned char value, int length) {
                # v0: address of the value found
                # a0: src
                # a1: value
                # a2: length
                # t0: c
                # t1: (*src)
                
                li $v0, 0                           # void * ret_val = NULL;
                li $t0, 0                           # c=0;
  top:          bge $t0, $a2, done                  # for(;c < length;) {
                lbu $t1, 0($a0)                     #
                bne $t1, $a1, if_end                #   if ( (* src) == value) {
                  move $v0, $a0                     #      ret_val = src;
                  b d_memchr                        #      break;
                                                    #   }
  if_end:       addiu $a0, $a0, 1                   #   src++; 
                addiu $t0, $t0, 1                   #   c++;
                b t_memchr                          

  done:         nop                                 # }

                jr $ra                              # return ret_val; 
.end memchr                                     # }
#####################################################################################

