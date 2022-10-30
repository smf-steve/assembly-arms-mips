.globl strnlen          # int strnlen   (byte *src,  int maxlen);
                
                .include "macros/syscalls.s"
                .include "macros/subroutine.s"

  
#####################################################################################
.ent strnlen    
strnlen:        nop                                 # int strnlen(byte * str, int max_length) {
                # v0: count
                # a0: src
                # a1: max_length
                # t0: (*src)
        
                li $v0, 0   # count=0;
  top:          bge $v0, $a1, done                  #   for (;count < max_length;) {
                  lbu $t0, 0($a0)                   #     if ((*str) == '\0')
                  beq $t0, $zero, done              #       break;
                addiu $a0, $a0, 1                   #     str++;
                addiu $v0, $v0, 1                   #     count++;
                b top                               
  done:         nop                                 #   }
                jr $ra                              #   return count
.end strnlen                                        # }
#####################################################################################
