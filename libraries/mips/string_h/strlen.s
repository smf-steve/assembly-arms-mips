.globl strlen           # int strlen    (byte *src);

                .include "macros/syscalls.s"
                .include "macros/subroutine.s"


        
#####################################################################################
.ent strlen     
strlen:         nop                                 # int strlen(byte * str) {
                # v0: count                   
                # a0: str
                        
                li $v0, 0,                          #   count = 0;
  top:          lbu $at, 0($a0)                     #   while (*str != '\0') {
                beq $at, $zero, done                #     // branch: ! (*str != '\0')
                  addiu $a0, $a0, 1                 #    str++;
                  addiu $v0, $v0, 1                 #    count++;
                b top     
  done:         nop                                 #   }
                jr $ra                              #   return count                                            
.end strlen                                         # }
#####################################################################################
        
  