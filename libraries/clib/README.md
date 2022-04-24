# Standard Library

An ISA defines the OS interface but it does not define a set of useful subroutines in which a programmer can use.  As such the assembly-level program is left to their own devices to develop such subroutines.

Whereas, different programming languages either define these subroutines as part of the core language or there is a large number of _de facto_ standard libraries in which the programmer can use.

Most of these standard libraries are based --in part-- upon the standard libraries that emerged from the C programming community. As such these libraries form a foundation for which all our programs are built upone.

While other programming languages may provide the subroutines in a different manner, the underlying implementation of these subroutines *at the assembly level* are essentially the same.  For example, Java provides the "length()" method to determine the length associated with a string object, e.g., ``int len = x.length()``. This method is based upon the C library "strlen()" subroutine, e.g., ``int len = strlen(x)``

Within the standard library for C, a number of routines are declared within the following header files:

1. stdio.h:
1. stdlib.h:
1. string.h:

In this directory, we provide the implementation of a subset of these subroutines in the following programming languages:

1. The C programming language, i.e., a high-level assembly language
1. The MIPS programming language
1. The ARM programming language

The purpose for these implementation include:

1. to provide a comparison between MIPS and ARM assemble programs,
1. to utilize the implementation as a teaching tool,
1. to provide MIPS/ARM programmers with a set of useful subroutines to build upon.



---
# Reference
In this section, we provide the declaration for all of the subroutines defined by the various _de facto_ standard.  The prototypes are defined, however, using the Rust system.

## \#include <stdlib.h>

the following are conversion routines defined whithin "stdio.h"

```c
double    atof(const char *);
int       atoi(const char *);
long      atol(const char *);
long long atoll(const char *);
```


## \#include <string.h>

### Memory related subroutines:

This seems redundent and unncessary..
Just refere the reader to the specifc file that contains the declarations.

For the xxxx.c files, add the C prototypes
For the xxxx.m files, add all of the .globls uptop....



```c
// memcpy, memccpy, memmove -- move bytes within memory
&byte memcpy (byte &dst, byte &src, int length);
&byte memccpy(byte &dst, byte &src, int char_stop, int maxlen);
&byte memmove(byte &dst, byte &src, int length);


// memchr -- set a byte in memory
byte * memchr(byte *src, byte value, int max_length);

// memset - locate a byte in memory
byte *memset(byte *dst, byte value, int length);

// memcmp -- compare bytes in memory
int   memcmp(byt *src1, byte *src2, int length);
```

### String related subroutines:

```c
//      strlen, strnlen – find length of string
int strlen(char *s);
int strnlen(char *s, int maxlen);



int      strlcpy(char * restrict dst, const char * restrict src, size_t dstsize);

     size_t
     strlcat(char * restrict dst, const char * restrict src, size_t dstsize);




// strcmp, strncmp – compare strings
int strcmp(const char *s1, const char *s2);
int strncmp(const char *s1, const char *s2, size_t n);


// strchr, 
strrchr – locate character in string
char * strchr(const char *s, int c);
char * strrchr(const char *s, int c);

// strpbrk – locate multiple characters in string
char * strpbrk(const char *s1, const char *s2);

//  strstr, strcasestr, strnstr – locate a substring in a string
char * strstr(const char *s1, const char *s2);
char * strcasestr(const char *haystack, const char *needle);
char * strnstr(const char *haystack, const char *needle, size_t len);




```

