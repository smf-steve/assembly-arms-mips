.globl memccpy
# void * memccpy(&dst, &src, char_stop, max_length)

                .include "macros/syscalls.s"
                .include "macros/subroutine.s"

        
#####################################################################################
.ent memccpy    
memccpy:        nop                                 # void * memccpy(&dst, &src, char_stop, max_length)
                                                    # note:  NO check is made if the strings overlap
        
                # v0: ret_val 
                # v1: <unaltered>                   
                # a0: &dst
                # a1: &src
                # a2: char_stop
                # a3: max_length
                # t0: c
        
                li $v0, 0                           # retval = NULL;   
                li $t0, 0                           # c=0;
      
    top:        bge $t0, $a3, done                  # for(;c < length;) {
                  lbu $t1, 0($a1)                   #   temp = (* src);
                  sb $t1, 0($a0)                    #   (* dst) = temp;
                
                  bne $t1, $a2, end_if              #   if (temp == char_stop) {
                    addiu $v0, $a0, 1               #      ret_val = dst + 1
                    jr $ra                          #      return;                                     
   end_if:        nop                               #   }

                  addiu $a0, $a0, 1                 #   dst ++;
                  addiu $a1, $a1, 1                 #   src ++;
                  addiu $t0, $t0, 1                 #   c++;
                b top 
                                        
done:           nop                                 # }
                jr $ra                              # return ret_val;
.end memccpy
#####################################################################################

