## MIPS Implementation of a subset of routines defined by string.h 

## Testing:
##   * test code is located at the end of the file.
##   * uncomment the following line
.globl main

# The following subroutines are a subset of the string opererations.
.globl strlen           # int strlen    (byte *src);
.globl strnlen          # int strnlen   (byte *src,  int maxlen);


                
                .include "macros/syscalls.s"
                .include "macros/subroutine.s"



#####################################################################################
.ent strlcpy
strlcpy:        nop                             # int strlcpy (byte *dst,  char *src, int size){
                # v0: return
                # a0: dst
                # a1: src
                # a2: size, size -1
                # t0: (* dst)
                # t1: (* src)
                # t2: count
        
                li $v0, 0
                bne $a2, $zero, t_strlcpy       #  if (size == 0) return 0;
                  jr $ra
                                                    
                li $t2, 0                           # count=0;
                addiu $a2, $a2, -1
t_strlcpy:      bge $t2, $a2, d_strlcpy         # for (; count < size - 1;) {
                  lb $t1, 0($a1)                #    if ((*src) == '\0')
                  beq $t1, $zero, d_strlcpy     #      break;
                  sb $t1, 0($a0)                #    (* dst) = (* src);
                  addiu $a0, $a0, 1             #    dst++;
                  addiu $a1, $a1, 1             #    src++;
                  addiu $t2, $t2, 1             #    count++;
                b t_strlcpy                     #  }
        
d_strlcpy:      sb $zero, 0($a0)                #  (* dst) = '\0'; 
                jr $ra                          #  return count;
.end strlcpy            # }
#####################################################################################
