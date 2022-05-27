## MIPS Implementation of a subset of routines defined by string.h 

## Testing:
##   * test code is located at the end of the file.
##   * uncomment the following line
.globl main

# The following subroutines are not written yet
#.globl strcmp           # strcmp int strcmp(const char *s1, const char *s2);
#.globl strncmp          # int strncmp(const char *s1, const char *s2, size_t n);

#.globl strchr          # char * strchr(const char *s, const int character);
#.globl strrchr         # char * strrchr(const char *s, const int character);
#.globl strbbrk         # char * strpbrk(const char *s1, const char *charset);

#.globl strstr          # char * strstr(const char *s1, const char *s2);
#.globl strcast         # char * strcasestr(const char *haystack, const char *needle);
#.globl strnstr         # char * strnstr(const char *haystack, const char *needle, size_t len);



                
                .include "macros/syscalls.s"
                .include "macros/subroutine.s"





####################################
### Debugging Code

            .data
            .align 3
A:          .ascii "AaXXAAaAaAAaAaAAaAaA000000000"
            .align 3
B:          .asciiz "BbBbBbBbBbBbBbBbBbBb000000000"
            .align 3
C:          .asciiz "CcCcCcCcC!  cCcCcCcCc00000000"
            .align 3
D:          .asciiz "DdDdDdDdDdDd0dDdDdDd000000000"
            .align 3
E:          .asciiz "DdDdDdDdDdDd9!  DdDd911111111"
            .align 3
p:          .word
value:      .word 0

hello:      .asciiz "hello "
string:     .asciiz "string"


            .text
main:       nop                     # int main(void) {
            la $s0, A
            la $s1, B
            la $s2, C
            la $s3, D
            la $s4, E
            la $s5, hello
            la $s6, string
            li $t0, 12
            li $t1, 20
            li $t4, '!'

            args $s0, $s1, $t0      #   memcpy(A, B, 12);
            jal memcpy
            print_s $s0
            print_ci '\n'

            li $t0, 12
            addi $t3, $s0, 2        #   A+2
            args $s0, $t3, $t0      #   memcpy(A, A+2, 12)
            jal memcpy
            print_s $s0
            print_ci '\n'

            li $t1, 20
            li $t4, '!'
            args $s0, $s2, $t4, $t1 #   memccpy(A, C, '!', 20);
            jal memccpy
            print_s $s0
            print_ci '\n'


            li $t1, 20
            li $t4, '!'
            args $s0, $t4, $t1      #   p = memchr(A, '!', 20);
            jal memchr
            print_d $v0
            print_ci '\n'

            li $t1, 20
            args $s0, $s3, $t1      #   memmove(A, D, 20);
            jal memmove
            print_s $s0
            print_ci '\n'

            li $t1, 20
            li $t4, '!'
            args $s0, $t4, $t1      #   memset(A, '!', 20);
            jal memset
            print_s $s0
            print_ci '\n'


            print_s $s3
            print_ci '\n'
            print_s $s4
            print_ci '\n'
            li $t1, 20
            args $s3, $s4, $t1      #   value = memcmp(D, E, 20);
            jal memcmp
            print_d $v0
            print_ci '\n'

            args $s0                #   value = strlen(A);
            jal strlen
            print_d $v0
            print_ci '\n'

            li $t1, 20
            args $s0, $t1           #   value = strnlen(A, 20);
            jal strnlen
            print_d $v0
            print_ci '\n'

            li $t1, 20
            args $s0, $s5, $t1      #   strlcpy(A, "hello ", 20);
            jal strlcpy
            print_s $a0
            print_ci '\n'

            li $t1, 20
            args $s0, $s6, $t1      #   strlcat(A, "string", 20);
            jal strlcat
            print_s $a0
            print_ci '\n'




