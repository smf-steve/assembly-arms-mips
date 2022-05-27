.globl strlcat         
# int strlcat (byte *dst,  byte *src, int size);
                
                .include "macros/syscalls.s"
                .include "macros/subroutine.s"

#####################################################################################
.ent strlcat
strlcat:        nop                     # int strlcat   (byte *dst,  byte *src, int size){
                # v0: return
                # a0: dst
                # a1: src
                # a2: size, size -1
                # t0: (* dst)
                # t1: (* src)
                # t2: count

                li $v0, 0
                bne $a2, $zero, t_strlcat           # if (size == 0) return 0;
                  jr $ra

                # first find the end of dst
                li $t2, 0                           # count=0;
                addiu $a2, $a2, -1
t_strlcat:      bge $t2, $a2, n_strlcat             # for (; count < size -1; ) {
                  lb $t0, 0($a0)                    #   if ((*dst) == '\0')
                  beq $t0, $zero, n_strlcat         #     break;
                  addiu $a0, $a0, 1                 #   dst ++;
                  addiu $t2, $t2, 1                 #   count ++;
                  b t_strlcpy                       # }

n_strlcat:      bne $t0, $zero, d_strlcat           # if ((*dst) == '\0') {

                  subu $a2, $a2, $t2                #   count += strlcpy(dst, src, size-count);
                  jal strlcpy           
                  addu $t2, $t2, $v0                #   // bug:  count should be |dst| + |src|
                                                    #   // here: count is max (|dst| + |src|, size);
                                                    # } 
d_strlcat:      move $v0, $t2                       # return count;
                jr $ra      

.end strlcat                                        # }
#####################################################################################


# validate size-count in strlcpy

