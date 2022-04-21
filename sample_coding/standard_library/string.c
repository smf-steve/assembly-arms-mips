void * memcpy(char * dst, char *src, int length) {
  // Note: NO check is made if the strings overlap
  //       This is "mem" copy and not "string" copy

  char * original_dst;
  int c;

  // Written via the pointer approach
  original_dst = dst;
  for(c=0; c < length, c++) {
    (* dst) = (* src);
    dst++, src++;
    c++;
  }
  return original_dst;

  // Written via the array approach
  // for(c=0; c < length, c++) {
  //   dst[c] = src[c];
  //   if (src[c] == char_last) {
  //      ret_val = &dst + c;
  //      break;
  //   }
  //   c++;
  // }
  // 
  // return ret_val;
 }


void * memccpy(char * dst, char *src, char char_last, int length) {
  // Note: NO checks are made for the NULL character
  //       This is "mem" copy and not "string" copy

  // If the "char_last" is not within the string NULL is returned
  // If the "char_last" is encountered during the operation
  //   -- the character is copied into dst
  //   -- the copy operation then stops 
  //   -- the address of the character after "char_last" is returned
  //
  // From the man page:
  //     * If the character c (as converted to an unsigned char) occurs 
  //       in the string src,
  //     * the copy stops and a pointer to the byte 
  //     * "after the copy of c" in the string dst is returned.

  int c;
  int ret_val = NULL;

  // Written via the pointer approach
  for(c=0; c < length, c++) {
    (* dst) = (* src);
    if ( (* dst) == char_last) {
       ret_val = dst + 1
       return;
    }
    dst++, src++;
    c++;
  }
  return ret_val;  

  // Written via the array approach
  // for(c=0; c < length, c++) {
  //   dst[c] = src[c];
  //   if (src[c] == char_last) {
  //      ret_val = &dst + c;
  //      break;
  //   }
  //   c++;
  // }
  // 
  // return ret_val;
 }
 

void * memmove(byte * dst, byte *src, int length) {
  // Returns dst

  // Steps:
  //   1. Determine if the strings overlap.
  //   2. If overlap
  //      * allocate stack space
  //      * memcpy "src" onto the stack
  //      * reset the value of "src"
  //   3. memcpy "src" into "dst"
  //   4. If overlap
  //      * deallocate stack space

  byte overlap = FALSE;
  {
    byte * first;  // the address of the first string in memory
    byte * second;
    byte * end;

    // first, second = order(dst, src);
       first  = (dst < src) ? dst : src; // the "min" macro
       second = (dst < src) ? src : dst; // the "max" macro
    end = first + length;
    overlap = (end >= length);
  }
  if ( overlap ) {
    byte * temp;
    temp = alloca(length);
    src  = memcpy(temp, src, length);
  }
  dst = memcpy(dst, src, length);
  if ( overlap ) {
     ;  // deallocate stack space
  }
  return dst;
}
