# stdlib.h

The "string.h" header file defines a number of subroutines for the manipulation of strings.  In addition, it includes a number of subroutines related to bytes within memory.

In this directory, we provide the implementation of the core set of these subroutines.

## Status:
   1. C functions defined
   1. MIPS subroutines defined
   1. ~ARM subroutines defined~


## Snprintf:
Although not part of the stdlib.h (but included in stdio.h), the snprintf routine is used to overarching driver for the routines in this section.
I.e., this section is really all about conversions.




## Conversion related subroutines:
```c

// Convert from ASCII to ...
// - 

// to 2's complement
long long  strtonum(const char *__numstr, long long __minval, long long __maxval, const char **__errstrp)
  // int  atoi(const char *);
  // long atol(const char *);

unsigned  strtoumax(const char *restrict str, char **restrict endptr, int base);

long          strtol(const char *__str, char **__endptr, int __base);
long long     strtoll(const char *__str, char **__endptr, int __base);
               strtoq(const char *__str, char **__endptr, int __base);

unsigned long strtoul(const char *__str, char **__endptr, int __base);
unsigned      strtoull(const char *__str, char **__endptr, int __base);
unsigned      strtouq(const char *__str, char **__endptr, int __base);



// to binary64
double  atof(const char *);
double  strtod(const char *, char ** endpoint);
float   strtof(const char *, char ** endpoint);

// Note implemented, deprecated use snprintf
// char  *ecvt(double, int, int *__restrict, int *__restrict); /* LEGACY */
// char  *fcvt(double, int, int *__restrict, int *__restrict); /* LEGACY */
// char  *gcvt(double, int, char *); /* LEGACY */



// Convert from 32-bit to radix64, which is not base64
char  *l64a(long);
long   a64l(const char *);


// .. from 2's complement to binary encoding
   int  abs(int);
   long labs(long);
```

# Environment related subroutines

```c
char  *getenv(const char *);
int  unsetenv(const char *);

// Not Implemented
// int  putenv(char *) __DARWIN_ALIAS(putenv);
// int  setenv(const char * __name, const char * __value, int __overwrite) __DARWIN_ALIAS(setenv);
```
##

 








