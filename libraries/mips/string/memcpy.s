.globl memcpy           
# byte * memcpy (byte *dst,  byte *src,  int length);

                
                .include "macros/syscalls.s"
                .include "macros/subroutine.s"

#####################################################################################
.ent memcpy
memcpy:         nop                     # void * memcpy(&dst, &src, length)
                                    # note: NO check is made if the strings overlap
                # v0: dst (the original)
                # v1: <unaltered>
                # a0: dst
                # a1: src
                # a2: length
                # a3: <unaltered>
        
                # t0: c
                # t1: temp
        
                move $v0, $a0
                li $t0, 0                           # c=0
  top:          bge $t0, $a2, done                  # for(;c < length;) {
                  lbu $t1, 0($a1)                   #   temp    = (* src);
                  sb $t1, 0($a0)                    #   (* dst) = temp;
                  addiu $a0, $a0, 1                 #   dst ++;
                  addiu $a1, $a1, 1                 #   src ++;
                  addiu $t0, $t0, 1                 #   c++;
                b top
                               
  done:         nop                                 # }
                jr $ra                              # return;
.end memcpy     
#####################################################################################
        
