.globl memcmp
                .include "macros/syscalls.s"
                .include "macros/subroutine.s"

#####################################################################################
.ent memcmp
# memcmp -- compare byte string
memcmp:         nop                                 # int   memcmp(void *src1, void *src2, int length) {
                                                    # return positive: src > src2
                                                    # return zero:     src1 == src2
                                                    # return negative: src1 < src2
                # v0: ret_val
                # a0: src1
                # a1: src2
                # a2: length
                # t0: c
                # t1: *src1
                # t2: *src2
        
                li $v0, 0                           #  int ret_val = 0;
                                                    #
                                                    #  // Special Cases:
                                                    #  // 1. both strings are are the same -- return 0;
                                                    #  // 2. only one string is empty -- return 1 or -1;
                                                    #  // 3. search for the first difference
                                                    #
                                                    #
                bne $a0, $a1, n1                    #  if (src1 == src2)  return 0;   // both strings are the same
                  jr $ra    
n1:             bne $a0, $zero, n2                  #  if (src1 == NULL ) return -1;
                  li $v0, -1            
                  jr $ra    
n2:             bne $a1, $zero, n3                  #  if (src2 == NULL ) return 1;
                  li $v0, 1 
                  jr $ra    
                
n3:             li $t0, 0                           #  c=0;
for_top:       bge $t0, $a2, for_done               #  for(;c < length;) {
                   lbu $t1,0($a0)
                   lbu $t2,0($a1)
                   bne $t1, $t2, for_done           #    if ((* src1) != (* src2) )
                                                    #       break;
                addiu $a0, $a0, 1                   #    src1++;
                addiu $a1, $a1, 1                   #    src2++;
                addiu $0, $t0, 1                    #    c++;
                b top                               #  }
        
for_done:       subu $v0, $t1, $t2                  #  return (* src1) - (* src2); 
                jr $ra                              # }
.end memcmp     
#####################################################################################
