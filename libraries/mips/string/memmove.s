.globl memmove          # byte * memmove(btye *dst,  byte *src,  int len);


                .include "macros/syscalls.s"
                .include "macros/subroutine.s"

#####################################################################################
.ent memmove
   # memmove calls memcpy and it presumes that the $a registers are unaltered
   # This diverages from the MIPS subroutine calling convention

memmove:        nop                                 # void * memmove(&dst, &src, length)
                                                # Note: Address overlapping string
                # v0: ret_val (dst)
                # v1: <unaltered>
                # a0: dst
                # a1: src
                # a2: length
                # t0: overlap
                
                # Non-leaf node (i.e., it makes subroutine calls)
                # Only $a0 is overwritten
                # Hence save: ra, sp, a0, $t0
        
                # Steps:
                #   1. Determine if the strings overlap.
                #   2. If overlap
                #      * allocate stack space
                #      * memcpy "src" onto the stack
                #      * reset the value of "src"
                #   3. memcpy "src" into "dst"
                #   4. If overlap
                #      * deallocate stack space
        
        
                ##########################################################
                #   1. Determine if the strings overlap.
                #      t1: first, end
                #      t2: second
                li $t0, 0                           # overlap = FALSE
                bgt $a0, $a1, reorder               # first, second = order(dst, src);   
                  move $t1, $a0
                  move $t2, $a1
                b next
reorder:          move $t1, $a1
                  move $t2, $a0
                # b next
        
next:           add $t1, $t1, $a3                   # end = first + length;
                sge $t0, $t1, $t2                   # overlap = (end >= second);
                ##########################################################
        
                ##########################################################
                #   2. If overlap
                #      t3: temp
                bne $t0, $zero, separate            # if ( overlap ) {
                  addiu $t3, $sp, -1                #   temp = alloca(length);
                  subu $sp, $sp, $a3
        
                  nop                               #   src  = memcpy(temp, src, length);
                  push $ra                          #        // save registers
                  push $sp                          #
                  push $a0  
                  push $t0  
                  move $a0, $t3                     #       // marshall inputs
                  jal memcpy                        #       // update the PC and $ra
                  pop $t0                           #       // restore registers
                  pop $a0   
                  pop $sp                           #          
                  pop $ra                           #  
                  move $a1, $v0                     #       // demarshall outputs
                nop                                 # }
        
separate:       nop                                 # dst = memcpy(dst, src, length);
                push $sp                            #     // save registers
                push $ra                            #     
                # move $a0, $a0, etc.               #     // marshall inputs
                jal memcpy                          #     // update the PC and $ra
                pop $ra                             #     // restore registers         
                pop $sp
                # move $v0, $v0                     #     // demarshall outputs
                
                bne $t0, $zero, done                # if ( overlap ) {                  
                addu $sp, $sp, $a3                  #    ;  // deallocate stack space
                                                    # }
done:           jr $ra                              # return dst;
                                                # }
.end memmove
#####################################################################################

