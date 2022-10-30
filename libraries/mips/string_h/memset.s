.globl memset           
# byte * memset (byte *dst,  byte value, int length);

                .include "macros/syscalls.s"
                .include "macros/subroutine.s"



#####################################################################################
.ent memset 
# memset - fill a byte string with a byte value
memset:         nop                                 # void *memset(void *dst, byte value, int length) {
                # v0: dst
                # a0: dst
                # a1: value
                # a2: length
                # t0: c
        
                move $v0, $a0                       #   void * ret_val = dst;
                li $t0, 0                           #   c=0;
  top:          bge $t0, $a2, done                  #   for(;c < length;) {
                  sb $a1, 0($a0)                    #     ( * dst ) = value;
                  addiu $a0, $a0, 1                 #     dst++; 
                  addiu $t0, $t0, 1                 #     c++;
                  b t_memset                        #   }
  done:         jr $ra                              #   return ret_val; 
.end memset                                         # }
#####################################################################################
