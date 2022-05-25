# Assembly-ARM and MIPS: Documentation, Libraries, and Comparison

## Description:
   A repository that contains documentation related to both the ARM and MIPS ISA, along with library that contains the implementation of basic subroutines.

---
## Status:
   * Under Initial Development

## Scope:
   * Current focus is on developing C and MIPS code for the basic routines
   * These routines are focused on memory and string operations

---
## Goals:
   1. To provide a set of basic library-level routines to be used within learning projects.
      * The SPIM and MARS simulator provide support for OS calls, but do not provide a library of standard subroutines (e.g., \<string.h\>) written in MIPS.

   1. To provide exemplar implementations of these library level in three different languages:
      1. C Code (used as a reference source)
      1. MIPS Assembly Code
      1. Arm Assembly Code

   1. To provide a collection of reference documents[^1] related to both the MIPS and the ARM ISA. [^1]: Possible published else.

   1. To provide additional documentation providing a comparison between the two ISAs.

   1. To serve as a vehicle to compare the MIPS and ARM ISA.


## File structure
   * documentation/
     - documents that are either ISAs neutral or compare the two ISAs
     * arm/
     * mips/
   * libraries/
     * arm/
       * macros/
       1. \<subroutine 1\>.s
       1. \<subroutine 2\>.s
     * mips/
       - macros/
       1. \<subroutine 1\>.s
       1. \<subroutine 2\>.s



