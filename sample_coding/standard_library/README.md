# Standard Library

The C language defined a number of routines that have become the defacto standard for performing basic operations.

In this directory, we provide the implementation of these libraries in the following languagues:

1. The C programming language, i.e., a high-level assembly language
1. The MIPS programming language
1. The ARM programming language


---
# Reference
In this section, we provide the declaration for all of the subroutines defined by the various _de facto_ standard.

## \#include <stdlib.h>

the following are conversion routines defined whithin "stdio.h"

```c
double    atof(const char *);
int       atoi(const char *);
long      atol(const char *);
long long atoll(const char *);
```


## \#include <string.h>

The following memory related subroutines are define within "string.h"

```c
// memchr -- set a byte in memory
void    *memchr(const void *__s, int __c, size_t __n);
// memset - locate a byte in memory
void    *memset(void *__b, int __c, size_t __len);

// memcpy, memccpy, memmove -- move bytes within memory
void * memcpy(void *restrict dst, const void *restrict src, size_t n);
void * memccpy(void *restrict dst, const void *restrict src, int c, size_t n);
void * memmove(void *dst, const void *src, size_t len);

// memcmp -- compare bytes in memory
int      memcmp(const void *__s1, const void *__s2, size_t __n);
```

The following string related subroutines are defined within "string.h"

```c
//      strlen, strnlen – find length of string
size_t strlen(const char *s);
size_t strnlen(const char *s, size_t maxlen);

//     strcat, strncat – concatenate strings
char * strcat(char *restrict s1, const char *restrict s2);
char * strncat(char *restrict s1, const char *restrict s2, size_t len);

//  strstr, strcasestr, strnstr – locate a substring in a string
char * strstr(const char *s1, const char *s2);
char * strcasestr(const char *haystack, const char *needle);
char * strnstr(const char *haystack, const char *needle, size_t len);

// stpcpy, stpncpy, strcpy, strncpy – copy strings
char * stpcpy(char *dst, const char *src);
char * stpncpy(char *dst, const char *src, size_t len);
char * strcpy(char *restrict s1, const char *restrict s2);
char * strncpy(char *restrict s1, const char *restrict s2, size_t len);

// strspn, strcspn – span a string
size_t strspn(const char *s1, const char *s2);
size_t strcspn(const char *s1, const char *s2);

// strchr, strrchr – locate character in string
char * strchr(const char *s, int c);
char * strrchr(const char *s, int c);

// strcmp, strncmp – compare strings
int strcmp(const char *s1, const char *s2);
int strncmp(const char *s1, const char *s2, size_t n);

//perror, strerror, strerror_r, sys_errlist, sys_nerr – system error messages
char * strerror(int errnum);

// strsep -- string separator
// strpbrk – locate multiple characters in string
char * strsep(char **stringp, const char *delim);
    //  (obsolete) char * strtok(char *restrict s1, const char *restrict s2);
char * strpbrk(const char *s1, const char *s2);

```

