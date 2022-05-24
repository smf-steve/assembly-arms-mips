## MIPS Implementation of a subset of routines defined by string.h 

## Testing:
##   * test code is located at the end of the file.
##   * uncomment the following line
.globl main


# The following subroutines are all of the core memory operations
.globl memcpy           # byte * memcpy (byte *dst,  byte *src,  int length);
.globl memccpy          # byte * memccpy(byte *dst,  byte *src,  int last_char, int max_length);
.globl memmove          # byte * memmove(btye *dst,  byte *src,  int len);
.globl memcmp           # int    memcmp (byte *src1, byte *src2, int length);
.globl memchr           # byte * memchr (byte *src,  byte value, int max_length);
.globl memset           # byte * memset (byte *dst,  byte value, int length);

# The following subroutines are a subset of the string opererations.
.globl strlen           # int strlen    (byte *src);
.globl strnlen          # int strnlen   (byte *src,  int maxlen);

.globl strlcpy          # int strlcpy   (byte *dst,  char *src, int size);
.globl strlcat          # int strlcat   (byte *dst,  byte *src, int size);

.globl strcmp           # strcmp int strcmp(const char *s1, const char *s2);
.globl strncmp          # int strncmp(const char *s1, const char *s2, size_t n);

#.globl strchr          # char * strchr(const char *s, const int character);
#.globl strrchr         # char * strrchr(const char *s, const int character);
#.globl strbbrk         # char * strpbrk(const char *s1, const char *charset);

#.globl strstr          # char * strstr(const char *s1, const char *s2);
#.globl strcast         # char * strcasestr(const char *haystack, const char *needle);
#.globl strnstr         # char * strnstr(const char *haystack, const char *needle, size_t len);







##################
# Useful Macros

.macro args()
.end_macro
.macro args(%a0)
  move $a0, %a0
.end_macro
.macro args(%a0,%a1)
  move $a0, %a0
  move $a1, %a1
.end_macro
.macro args(%a0,%a1,%a2)
  move $a0, %a0
  move $a1, %a1
  move $a2, %a2
.end_macro
.macro args(%a0,%a1,%a2,%a3)
  move $a0, %a0
  move $a1, %a1
  move $a2, %a2
  move $a3, %a3
.end_macro

.macro push(%a0)
   addiu $sp, $sp, -4
   sw %a0, 0($sp)
.end_macro
.macro pop (%a0)
   lw %a0, 0($sp)
   addiu $sp, $sp, 4
.end_macro

.macro print_nl()
   li $a0, '\n'
   li $v0, 11
   syscall
.end_macro

.macro print_string(%s)
   move $a0, %s
   li $v0, 4
   syscall
.end_macro

.macro print_int(%s)
   move $a0, %s
   li $v0, 1
   syscall
.end_macro
####################



#####################################################################################
.ent memcpy
memcpy:     nop                     # void * memcpy(&dst, &src, length)
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
t_memcpy:   bge $t0, $a2, d_memcpy              # for(;c < length;) {
            lbu $t1, 0($a1)                     #   temp    = (* src);
            sb $t1, 0($a0)                      #   (* dst) = temp;
            addiu $a0, $a0, 1                   #   dst ++;
            addiu $a1, $a1, 1                   #   src ++;
            addiu $t0, $t0, 1                   #   c++;
            b t_memcpy
                           
d_memcpy:   nop                                 # }
            jr $ra                              # return;
.end memcpy
#####################################################################################


#####################################################################################
.ent memccpy
memccpy:    nop                                 # void * memccpy(&dst, &src, char_stop, max_length)
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
t_memccpy:  
            bge $t0, $a3, d_memccpy             # for(;c < length;) {
            lbu $t1, 0($a1)                     #   temp = (* src);
            sb $t1, 0($a0)                      #   (* dst) = temp;
            
            bne $t1, $a2, c_memccpy             #   if (temp == char_stop) {
            addiu $v0, $a0, 1                   #      ret_val = dst + 1
            jr $ra                              #      return;                                     
                                                #   }
 c_memccpy: addiu $a0, $a0, 1                   #   dst ++;
            addiu $a1, $a1, 1                   #   src ++;
            addiu $t0, $t0, 1                   #   c++;
            b t_memccpy 
                                    
d_memccpy:  nop                                 # }
            jr $ra                              # return ret_val;
.end memccpy
#####################################################################################




#####################################################################################
.ent memmove
   # memmove calls memcpy and it presumes that the $a registers are unaltered
   # This diverages from the MIPS subroutine calling convention

memmove:    nop                                 # void * memmove(&dst, &src, length)
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
reorder:      move $t1, $a1
              move $t2, $a0
            # b next

next:       add $t1, $t1, $a3                   # end = first + length;
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

separate:   nop                                 # dst = memcpy(dst, src, length);
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
done:       jr $ra                              # return dst;
                                                # }
.end memmove
#####################################################################################



#####################################################################################
.ent memchr
# memchr -- locate a byte in memory

memchr:     nop                                 # void * memchr(void *src, unsigned char value, int length) {
            # v0: address of the value found
            # a0: src
            # a1: value
            # a2: length
            # t0: c
            # t1: (*src)
            
            li $v0, 0                           # void * ret_val = NULL;
            li $t0, 0                           # c=0;
t_memchr:   bge $t0, $a2, d_memchr              # for(;c < length;) {
            lbu $t1, 0($a0)                     #
            bne $t1, $a1, n_memchr              #   if ( (* src) == value) {
              move $v0, $a0                     #      ret_val = src;
              b d_memchr                        #      break;
                                                #   }
n_memchr:   addiu $a0, $a0, 1                   #   src++; 
            addiu $t0, $t0, 1                   #   c++;
            b t_memchr                          # }
d_memchr:   
            jr $ra                              # return ret_val; 
.end memchr                                     # }
#####################################################################################


#####################################################################################
.ent memset 
# memset - fill a byte string with a byte value
memset:     nop                                 # void *memset(void *dst, byte value, int length) {
            # v0: dst
            # a0: dst
            # a1: value
            # a2: length
            # t0: c

            move $v0, $a0                       #   void * ret_val = dst;
            li $t0, 0                           #   c=0;
t_memset:   bge $t0, $a2, d_memset              #   for(;c < length;) {
              sb $a1, 0($a0)                    #     ( * dst ) = value;
              addiu $a0, $a0, 1                 #     dst++; 
              addiu $t0, $t0, 1                 #     c++;
              b t_memset                        #   }
d_memset:   jr $ra                              #   return ret_val; 
.end memset                                     # }
#####################################################################################



#####################################################################################
.ent memcmp
# memcmp -- compare byte string
memcmp:     nop                                 # int   memcmp(void *src1, void *src2, int length) {
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
n1:         bne $a0, $zero, n2                  #  if (src1 == NULL ) return -1;
              li $v0, -1            
              jr $ra    
n2:         bne $a1, $zero, n3                  #  if (src2 == NULL ) return 1;
              li $v0, 1 
              jr $ra    
            
n3:         li $t0, 0                           #  c=0;
t_memcmp:   bge $t0, $a2, d_memcmp              #  for(;c < length;) {
               lbu $t1,0($a0)
               lbu $t2,0($a1)
               bne $t1, $t2, d_memcmp           #    if ((* src1) != (* src2) )
                                                #       break;
            addiu $a0, $a0, 1                   #    src1++;
            addiu $a1, $a1, 1                   #    src2++;
            addiu $0, $t0, 1                    #    c++;
            b t_memcmp                          #  }

d_memcmp:   subu $v0, $t1, $t2                  #  return (* src1) - (* src2); 
            jr $ra                              # }
.end memcmp
#####################################################################################



#####################################################################################
.ent strlen
strlen:     nop                                 # int strlen(byte * str) {
            # v0: count                   
            # a0: str

            li $v0, 0,                          #   count = 0;
t_strlen:   lbu $at, 0($a0)                     #   while (*str != '\0') {
            beq $at, $zero, d_strlen            #     // branch: ! (*str != '\0')
              addiu $a0, $a0, 1                 #    str++;
              addiu $v0, $v0, 1                 #    count++;
            b t_strlen                          #   }
d_strlen:   jr $ra                              #   return count                                            
.end strlen                                     # }
#####################################################################################


#####################################################################################
.ent strnlen
strnlen:    nop                                 # int strnlen(byte * str, int max_length) {
            # v0: count
            # a0: src
            # a1: max_length
            # t0: (*src)

            li $v0, 0   # count=0;
t_strnlen:  bge $v0, $a1, d_strnlen             # for (;count < max_length;) {
              lbu $t0, 0($a0)                   #   if ((*str) == '\0')
              beq $t0, $zero, d_strnlen         #     break;
            addiu $a0, $a0, 1                   #   str++;
            addiu $v0, $v0, 1                   #   count++;
            b t_strnlen                         # }
d_strnlen:  jr $ra                              #   return count
.end strnlen                                    # }
#####################################################################################




#####################################################################################
.ent strlcpy
strlcpy:                # int strlcpy   (byte *dst,  char *src, int size){
            # v0: return
            # a0: dst
            # a1: src
            # a2: size, size -1
            # t0: (* dst)
            # t1: (* src)
            # t2: count

            li $v0, 0
            bne $a2, $zero, t_strlcpy           #  if (size == 0) return 0;
              jr $ra
                                                
            li $t2, 0                           # count=0;
            addiu $a2, $a2, -1
t_strlcpy:  bge $t2, $a2, d_strlcpy             # for (; count < size - 1;) {
              lb $t1, 0($a1)                    #    if ((*src) == '\0')
              beq $t1, $zero, d_strlcpy         #      break;
              sb $t1, 0($a0)                    #    (* dst) = (* src);
              addiu $a0, $a0, 1                 #    dst++;
              addiu $a1, $a1, 1                 #    src++;
              addiu $t2, $t2, 1                 #    count++;
            b t_strlcpy                         #  }

d_strlcpy:  sb $zero, 0($a0)                    #  (* dst) = '\0'; 
            jr $ra                              #  return count;
.end strlcpy            # }
#####################################################################################


#####################################################################################

.ent strlcat
strlcat:    nop                     # int strlcat   (byte *dst,  byte *src, int size){
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
t_strlcat:  bge $t2, $a2, n_strlcat             # for (; count < size -1; ) {
              lb $t0, 0($a0)                    #   if ((*dst) == '\0')
              beq $t0, $zero, n_strlcat         #     break;
              addiu $a0, $a0, 1                 #   dst ++;
              addiu $t2, $t2, 1                 #   count ++;
              b t_strlcpy                       # }

n_strlcat:  bne $t0, $zero, d_strlcat           # if ((*dst) == '\0') {

              subu $a2, $a2, $t2                #   count += strlcpy(dst, src, size-count);
              jal strlcpy           
              addu $t2, $t2, $v0                #   // bug:  count should be |dst| + |src|
                                                #   // here: count is max (|dst| + |src|, size);
                                                # } 
d_strlcat:  move $v0, $t2                       # return count;
            jr $ra      

.end strlcat            # }
#####################################################################################


# validate size-count in strlcpy







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
            print_string($s0)
            print_nl

            li $t0, 12
            addi $t3, $s0, 2        #   A+2
            args $s0, $t3, $t0      #   memcpy(A, A+2, 12)
            jal memcpy
            print_string($s0)
            print_nl

            li $t1, 20
            li $t4, '!'
            args $s0, $s2, $t4, $t1 #   memccpy(A, C, '!', 20);
            jal memccpy
            print_string($s0)
            print_nl


            li $t1, 20
            li $t4, '!'
            args $s0, $t4, $t1      #   p = memchr(A, '!', 20);
            jal memchr
            print_int($v0)
            print_nl

            li $t1, 20
            args $s0, $s3, $t1      #   memmove(A, D, 20);
            jal memmove
            print_string($s0)
            print_nl

            li $t1, 20
            li $t4, '!'
            args $s0, $t4, $t1      #   memset(A, '!', 20);
            jal memset
            print_string($s0)
            print_nl


            print_string($s3)
            print_nl
            print_string($s4)
            print_nl
            li $t1, 20
            args $s3, $s4, $t1      #   value = memcmp(D, E, 20);
            jal memcmp
            print_int($v0)
            print_nl

            args $s0                #   value = strlen(A);
            jal strlen
            print_int($v0)
            print_nl

            li $t1, 20
            args $s0, $t1           #   value = strnlen(A, 20);
            jal strnlen
            print_int($v0)
            print_nl

            li $t1, 20
            args $s0, $s5, $t1      #   strlcpy(A, "hello ", 20);
            jal strlcpy
            print_string($a0)
            print_nl

            li $t1, 20
            args $s0, $s6, $t1      #   strlcat(A, "string", 20);
            jal strlcat
            print_string($a0)
            print_nl




