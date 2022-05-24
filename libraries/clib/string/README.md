# String.h

The "string.h" header file defines a number of subroutines for the manipulation of strings.  In addition, it includes a number of subroutines related to bytes within memory.

In this directory, we provide the implementation of the core set of these subroutines.

## Status:
   1. C functions defined
   1. MIPS subroutines defined
   1. ~ARM subroutines defined~

## String related subroutines:

```c

// Determine the length of string
// -
int strlen(char *s);
int strnlen(char *s, int maxlen);

// Size-bounded string copying and concatenation
// -
int strlcpy(char * restrict dst, const char * restrict src, size_t dstsize);
  // The following are NOT implemented, use strlcpy instead:
  //   char * stpcpy(char * dst, const char * src);
  //   char * stpncpy(char * dst, const char * src, size_t len);
  //   char * strcpy(char * dst, const char * src);
  //   char * strncpy(char * dst, const char * src, size_t len);
int strlcat(char * restrict dst, const char * restrict src, size_t dstsize);
  // The following are NOT implemented, use strlcat instead:
  //   char * strcat(char *restrict s1, const char *restrict s2);
  //   char * strncat(char *restrict s1, const char *restrict s2, size_t n);

// Compare strings
// -
int strcmp(const char *s1, const char *s2);
int strncmp(const char *s1, const char *s2, size_t n);

// Locate character within a string
// - 
char * strchr(const char *s, const int character);
char * strrchr(const char *s, const int character);
char * strpbrk(const char *s1, const char *charset);

// Locate a substring within a string
// -
char * strstr(const char *s1, const char *s2);
char * strcasestr(const char *haystack, const char *needle);
char * strnstr(const char *haystack, const char *needle, size_t len);

```

## Byte related subroutines:

```c
// Move bytes within memory
// -
&byte memcpy (byte &dst, byte &src, int length);
&byte memccpy(byte &dst, byte &src, int char_stop, int maxlen);
&byte memmove(byte &dst, byte &src, int length);


// Compare bytes in memory
// -
int   memcmp(byt *src1, byte *src2, int length);
  // returns zero if identical
  // 

// Locate a byte within memory
// -
byte * memchr(byte *src, byte value, int max_length);

// Fill memory locations with a byte
// -
byte *memset(byte *dst, byte value, int length);

```

