#include <stdio.h>
#include <unistd.h>
typedef char byte;
typedef unsigned int word;

#define SET (1)
#define CLEAR (0)

// BUG:  There is currently no checks on buffer size


// Overview:
//   A primary routine to perform conversions with the C programming language is
//   the "snprintf" subroutine.  This subroutine is part of the "printf" family of
//   routines: printf, fprintf, sprintf, vaprintf, dprintf, etc. 
//  
//   In the file, we provide the C implementation of the snprintf subroutine along with
//   basic conversion routines.  We have chosen the "snprintf" routine because:
//
//     1. it can be used to implement most of the other subroutines within the family
//     2. a bound buffer is provided as an argument, as such
//        - internal memory management is not needed.
//
// Purpose:
//   * To provide a high-level pseudo-code for the corollary subroutines written in MIPS Assembly
//   * To provide the author a better understanding of Clib and its capabilities.
//
// "snprintf" General Usage:
//   snprintf is provided with a format string composed of zero or more directives. These
//   directives are prefixed with the percent (%) character. The following directives are of 
//   particular interest.
//
//   Integers:
//     %i: converts a 32-bit signed binary number to a decimal ASCII string
//
//     %u: converts a 32-bit unsigned binary number to a decimal ASCII string
//     %b: converts a 32-bit unsigned binary number to a binary ASCII string
//     %o: converts a 32-bit unsigned binary number to a octal ASCII string
//     %x: converts a 32-bit unsigned binary number to a hexadecimal ASCII string
//
//         The following modifiers are include in this implementation:
//           %#, applies to [box]: adds the C-standard prefix to identify the base, e.g. 0xF1A2C3E4
//           %+, applies to [di]: prepends a '+' for positive numbers, ' ' for zero. e.g., + 0xF1A2C3E4
//           % , applies to [diu]: prepends a ' ' for non-negative numbers
//
//     Addendum: An additional conversion is provided to present numbers in the base# form
//        - this leverages and extends the "#" modify.  
//        - when the "#" precedes a number (2..32), 
//          - the number defines the desired base
//          - the base# notation is used to present the signed number
//        - when the "#" precedes one of the following letters: [box], 
//          - the letter defines the desired base
//          - the C-standard prefix is used to present the unsigned number
// 
//     %#n: converts a 32-bit binary number to a based ASCII string
//        - this conversion is NOT provided by the C language
//        - the resulting unsigned value is prepended by "n#", e.g., 16# F1A2C3E4
//
//        - With the addition of a sub-modifier, the number is interpreted as a signed value
//          %#-n: prepends only a sign for negative numbers (default), e.g., 16# -F1A2C3E4
//          %# n: prepends an sign for negative numbers or a blank otherwise
//          %#+n: prepends an explicit sign for all numbers ('+', '-', or ' ')
//
//   %f:  converts a binary32 number to an ASCII string formatted as: [-]ddd.ddd
//   %e:  converts a binary32 number to an ASCII string formatted as: [-]d.ddde±dd
//   %p:  converts a binary32 number to an ASCII string formatted as: [-]0xh.hhhp[±]d
//
// Caveats:
//   Prefixes are always provided in lowercase form.  e.g., 0xFACE1234
//   Digits are always provided in uppercase form.
//


//  int snprintf(char * buffer, int size, int value);

int percent_i(char * buffer, int count, int value);

#define percent_d(b, c, v) percent_i(b, c, v)
#define percent_u(b, c, v) percent_unsigned_base(b, c, v, 10)
#define percent_x(b, c, v) percent_unsigned_base_2power(b, c, v, 4)
#define percent_o(b, c, v) percent_unsigned_base_2power(b, c, v, 3)
#define percent_b(b, c, v) percent_unsigned_base_2power(b, c, v, 1)

int percent_f(char * buffer, int count, int value);
int percent_e(char * buffer, int count, int value);
int percent_g(char * buffer, int count, int value);


////////////////////////////////////////////////////////////////////////
// Base subroutines:
#define digit2ascii(d)  (d >= 10) ? ((d - 10) + 'A') : (d + '0');

int percent_unsigned_base(char * buffer, int count, unsigned int value, int base);
  // Converts the value to the correct base
  // The calling function is responsible for adding the prefix

int percent_unsigned_base_2power(char * buffer, int count, unsigned int value, int power);
  // Converts the value to the base: 2^power
  // Specialized: uses shift/mask in lieu of div/mod

int percent_fractional(char * buffer, int count, int value, int base);


////////////////////////////////////////////////////////////////////////
// Modifiers

int modifier_plus_blank(char * buffer, int count, int value, int symbol);
   // Indicates that a positive number must have an explicit '+' or ' ' added

int modifier_sharp(char * buffer, int count, int sharp, int base);
   // Indicates that the alternative form of a prefix should be provided
   // sharp | base   || output
   //  ''   | 2,8,16 || '0b', '0o', '0x'
   //  '#'  | n      || 'n# '



////////////////////////////////////////////////////////////////////////
// Integer based conversions

int percent_i(char * buffer, int count, int value){
  int size = 0;

  if (value < 0) {
    buffer[0] = '-'; buffer++; size ++;
    value = ~ value + 1; 
  }
  size += percent_u(buffer, count - size, value);
  return size;
}




#define push(x)  sp++; (* sp) = x
#define pop(x)   x = (* sp); sp--

int percent_unsigned_base(char * buffer, int buf_len, unsigned int value, int base) {

    // use push and pop to place stuff on the stack...
    int count;
    int size;
    byte stack[32];       // extending the size of the call stack
    byte * sp = stack-1; 

    int digit;
  
    count = 0;
    do {
      digit = value % base;
      value = value / base;
      push(digit2ascii(digit));
      count++;

    } while (value != 0);
  
    size = count;
    do {
       pop((*buffer));
       count --;
       buffer++;
    } while (count > 0 );
  
   return size;
}


int percent_unsigned_base_2power(char * buffer, int buf_len, unsigned int value, int power) {
    // specialized routine to handle the power of 2 bases: heXidecimal, Octal, and Binary

    int count;
    int size;
    byte stack[32];     // If a 2^32 bit number, no more than 32 chars will be required       
    byte * sp = stack-1; // extending the size of the call stack

    int digit;

    int shift = power;
    int base = 1 << power;
    int mask = base -1 ; 

    count = 0;
    do {
      digit = value & mask;
      value = value >> shift;
      if (digit >= 10) {
        push( (byte)((digit - 10) + 'A'));
      } else {
        push( (byte) (digit + '0'));
      }
      count++;

    } while (value != 0);

    // Pop all the digits from the stack, to get the digits in the right order.
    size = count;
    do {
       pop((*buffer));
       buffer++;
       count --;
    } while (count > 0);
 
   return size;
}




////////////////////////////////////////////////////////////////////////
// Floating point based conversions

// binary32 format:
//    s - eeee eeee - mmm mmmm mmmm mmmm mmmm mmmm

#define expon_mask (0x7F800000)
  //     0 - 1111 1111 - 000 0000 0000 0000 0000 0000

#define bias (0x7F)
  //    s - 0111 1111 - mmm mmmm mmmm mmmm mmmm mmmm

#define mantissa_mask (0x007FFFFF)
  //     0 - 0000 0000 - 111 1111 1111 1111 1111 1111

#define one_bit (0x800000)
  //     s - eeee eee1 - 000 0000 0000 0000 0000 0000

#define binary32_sign(encoding)        (encoding < 0)? SET : CLEAR;             // MIPS instruction: slt 
#define binary32_expon(encoding)       ((encoding & expon_mask) >> 23) - bias;
#define binary32_significand(encoding) (encoding & mantissa_mask ) | one_bit;   // value x 2^ expon


#define directional_shift(val, shamt)  ((shamt) >= 0) ? val << (shamt) : val >> -(shamt)
    // whole part: (significand >> 23) << expon
    //   * conceptually shift the value to the right by 23
    //     to position the radix point to the right of the register
    //     * 0000 0000 1mmm mmmm mmmm mmmm mmmm mmmm | ---- ---- ---- ---- ---- ---- ---- ----
    //     * ---- ---- ---- ---- ---- ---0 0000 0001 | mmm mmmm mmmm mmmm mmmm mmmm xxxx xxxx x
    //   * then shift the value to the left by the value of the expon
    //   * i.e, significand << (expon - 23)

    // fract part:
    //   * conceptually shift the value to the left by 9
    //     to position the radix point to the left of the register
    //     *  ---- ---- ---- ---- ---- ---- ---- ---- | 0 0000 0001 mmm mmmm mmmm mmmm mmmm mmmm
    //     *  ---- ---- ---- ---- ---- ---0 0000 0001 | mmm mmmm mmmm mmmm mmmm mmmm xxxx xxxx x
    //   * then shift the value to to the left by the value of the expon
    //   * i.e., (significand << 9) << expon

//////////////////////////////////////////////////////////////////////////////////////

int percent_f(char * buffer, int buf_length, int float_encoding) {
  // Does not handle subnormal/infinity/nan
  // Steps:
  //   1. split the encoding into its parts: sign, expon, mantissa
  //   2. create the signficand (1.mantissa)
  //   2. shift by the exponent to obtain the whole_part and fract_part,
  //   3. convert from binary to decimal

  // BUG:  the |exponent| can be greater than 32. 
  //       in this case, the approach to shift the registers does not work...
  //       I presume the C language first converts the value to a double double
  int count;
  int negative;
  int expon;
  int significand;
  word whole_part;
  word fract_part;


  decompose:
    negative = binary32_sign(float_encoding);
    expon    = binary32_expon(float_encoding);
    significand    = binary32_significand(float_encoding);

 
    whole_part = directional_shift(significand, expon - 23);
    fract_part = directional_shift(significand, expon + 9);

 convert:  // syntax:  [+-] d+ '.' d+
     count = 0;

     buffer[0] = (negative)? '-' : '+';
     count ++;

     count += percent_unsigned_base(buffer+count, buf_length-count, whole_part, 10);

     buffer[count] = '.';
     count ++;

     count += percent_fractional(buffer+count, buf_length-count, fract_part, 10);

  done:
     return count;

}



int percent_fractional(char * buffer, int buf_length, int value, int base){
  // Converts the fractional part of a number to the desired base

  // The routine uses multiplication of a 32-bit number to yield a 64-bit number.
  // This 64-bit number should be viewed as:  hi.lo  (e.g., 4.34567)
  // The "hi" 32-bits holds the whole portion of the number
  //   - which represents the digit just processed (e.g., 4)
  // The "lo" 32-bits holds the value the fractional portion of the number
  //   - which represents the left justified value of "value" (e.g, 34567)

    int count = 0;
    unsigned int fraction = (unsigned int) value;
    do {
      int digit;
      unsigned long int hi_lo;                 // MIPS hi/lo register

      hi_lo    = (long int) fraction * base;
      fraction = hi_lo & 0x00000000FFFFFFFF;   // MIPS instruction: mfhi value
      digit    = hi_lo >> 32;                  // MIPS instruction: mflo digit

      buffer[count] = digit2ascii(digit);
      count ++;
    } while (fraction != 0);
    return count;
}





int modifier_sharp(char * buffer, int count, int sharp, int base) {
   // Indicates that the alternative form of a prefix should be provided
   // sharp | base   || output
   //  ''   | 2,8,16 || '0b', '0o', '0x'
   //  '#'  | n      || 'n# '
  int size = 0;

  if (sharp == '#') {
    size += percent_u(buffer, count, base);
    buffer[size] = '#'; size++;
    buffer[size] = ' '; size++;
  } else {
    buffer[0] = '0'; size++;
    switch (base) {
      case 'b' : buffer[size] = 'b'; break;
      case 'o' : buffer[size] = 'o'; break;
      case 'x' : buffer[size] = 'x'; break;
    }
    size++;
  }
  return size;
}


int modifier_plus_blank(char * buffer, int count, int value, int symbol){
  // Indicates that a positive number must have an explicit '+' or ' ' added
  int size = 0;

  if (value == 0) {
    // Override the symbol if the value is equal to zero
    symbol = ' ';
  }
  if (value >= 0) {
    buffer[0] = symbol;
    size ++;
  } 
  return size;
}




///////////////////////////////////////////////////////////////////////////////////////
// Testing Routines:
//

// This file provides the C routines necessary to perform 
// the conversion of // binary32 to ASCII decimal.

char buff[30];
union {
  float f;
  int i;
} x;


int main() {

  int size;

  x.f = 4294967297.0;
  size = percent_f(buff, 10, x.i);
  write(1, buff, size);
  printf("\n");

  x.i = 23456;
  size = percent_d(buff, 10, x.i);
  write(1, buff, size);
  printf("\n");

  size = percent_x(buff, 10, x.i);
  write(1, buff, size);
  printf("\n");

  x.f = 12345678910112354667.123456754334567743;
      //12345679395506094080.000000
  printf("%f\n", x.f);

  size = percent_f(buff, 10, x.i);
  write(1, buff, size);
  printf("\n");

  return 0;
}


