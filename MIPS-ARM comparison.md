# MIPS Instruction Comparison to the ARM instructions: 

In this document, we provide a comparison of a subset of the MIPS instructions to their equivalent ARM instructions.  We also restrict our comparison to instructions associated with the main processor (e.g., floating point operations are not include.) associated with the main processor.  Moreover, we differ instructions that transfer data to and from either main memory and a co-processor.

The purpose of this document is to illustrate the difference instruction syntax and in the instruction encoding between MIPS and ARM. As such, we restrict our attention to the instructions common to both ISAs.  In general, the differences between the MIPS and ARM instructions, with respect to these instructions include:

   1. MIPS conforms to a three address format, whereas the ARM allows for four addresses.  <br>
   For the most part, we restrict our comparison to only operations that utilize at most three addresses.

   2. Each MIPS instruction is always executed, whereas ARM instructions are conditional executed. <br>
   We restrict our comparison to ARM instructions in which the conditional-execute (COND) field is set to ALWAY (1110). We do, however, include the Branch instructions, since the use of these conditional codes are germane to the proper execution of these instructions.

   3. MIPS provides unsigned instructions that are used to prevent a trap on overflow, whereas the ARM provides the COND codes in which the programmer is responsible for checking the values in the CPSR to determine if an overflow occurred. <br>
   The mnemonic for MIPS instructions are append with a "u" to indicated that an unsigned operation is to be performed.

   4. MIPS multiplication can use to specialized registers (hi and lo) to hold the a 64-bit result, whereas ARM multiplication can place the results into any general purpose operation.

   4. Is there a difference with signed extension of immediate values?

Note that there are difference in nomenclature within the literature for MIPS and ARM.  In this document, we have adopted and adapted the nomenclature for clarity in comparison. For example, we have relabeled the ARM encoding formats for this comparison. That is to say that the ARM literature presents this formats very differently.

We have classified these instructions as:

  1. Data Processing: Move, Comparison, Bitwise, Arithmetic, and Shifts
    * MIPS Syntax: 
      - {mnemonic} $rd, $rs, $rt          # Logical, Arithmetic, and Shifts
    * ARM Syntax: 
      - {mnemonic} rd, rt                 # Moves
      - {mnemonic} rd, rs, rt             # Logical and Arithmetic 
      - {mnemonic} rd, rs, {shift} rx     # Shifts (via a move operation with extended syntax)

  1. Multiple and Multiply Long
    * MIPS Syntax:
      - {mnemonic} $rd, $rs, $rt          # For 32-bit results
      - {mnemonic} $rs, $rt               # For 64-bit results
    * ARM Syntax:
      - {mnemonic} rd, rt, rs             # For 32-bit multiple
      - {mnemonic} rd, rt, rs, rx         # For 32-bit multiple-accumulate 
      - {mnemonic} rd, rt, rs             # For 64-bit multiple
      - {mnemonic} rd, rt, rs, rx         # For 64-bit multiple-accumulate 

  1. Control Flow: Branch and Jumps
    * MIPS Syntax: 
      - MNEMONIC $rs, $rt, imm 
      - MNEMONIC addr
    * ARM Syntax: B{L}{cond}


---
#ToDo Notes:

Is the move:  rd = (unsigned) imm
Load immediate signed extend


div rs, rt
divu rs, rt

div  rd, rs, rt pseudo
divu rd, rs, rt pseudo

mult rs, rt  0x18
multu        0x19

mul  rd, rs, rt 0x1c     0x02
mulo rd, rs, rt  pseud9
mulou rd, rs, rt pseu
madd rs, rt 0x1c 0x0
maddu rs, rt 0x1c 0x1
msub 0x4
msubu 0x5
rem rd, rs, rt psuedo
remu rd, rc, rt psuedo



Other
clz
clo
not  puedo instruction
abs
neg
ror pusdo
rol pusedu
---


## Syntax and Encoding Conventions:
Each section provides an subsection on the instruction format.  The format is provided by a table with heading values the denote the following information:
  * rd: the destination register
  * rs: the first source register
  * rt: the second source register or the target register
  * rx: the third source register used for shift operations
  * func: the function to be performed
  * shift: the encoding with a shift operations
  * imm: an immediate value
  	- MIPS: a 16-bit signed-extended value
  	- ARMS: a value that can be generated via ........
  * addr: 

Within each row, a set of characters is used to denote the type of value encoded.  Each character represents a single bit used within the encoding.
   * f:  the function to be performed
   * d:  the destination register
   * s:  the first source register
   * t:  the second source register
   * x:  the third source registers used for extend operations
   * i:  the immediate value
   * a:  the shift amount
   * m:  the shift method to be applied



| ISA   | TYPE | Op      | rs    | rt    | rd    | shift | func   |
|-------|------|---------|-------|-------|-------|-------|--------|
| MIPS  | R    | oo oooo | sssss | ttttt | ddddd | aaaaa | ffffff |

| ISA   | TYPE | op      | rs    | rt    | imm          |
|-------|------|---------|-------|-------|--------------|
| MIPS  | I    | 00 0000 | sssss | ttttt | iiii iiii iiii iiii |

| ISA   | TYPE | op      |  address                          |
|-------|------|---------|-----------------------------------|
| MIPS  | J    | 00 0000 | ii iiii iiii  iiii iiii iiii iiii |


| ISA  | TYPE | Cond | --- | L | Offset | 
|------|------|------|-----|---|------------------------------------|
| ARM  | B/L  | 1110 | 101 | 0 | iiii iiii iiii iiii iiii iiii iiii |

j
jal
b
bal



C/R:  Comparison with Registers
C/I:  Comparison with an Immediate

| ISA  | TYPE | COND | -- | I | Op     | S   | rs   | rd   | ----      | rt   | 
|------|------|------|----|---|--------|-----|------|------| ----------| ---- |
| ARM  | C/R  | 1110 | 00 | 0 | oooo   | 1   | ssss | dddd | 0000 0000 | tttt |

| ISA  | TYPE | COND | -- | I | Op     | S   | rs   | rd   | ---  | imm       |
|------|------|------|----|---|--------|-----|------|------|------|-----------|
| ARM  | C/I  | 1110 | 00 | 1 | oooo   | 1   | ssss | dddd | 0000 | iiii iiii |

D/R: Data Processig with Registers
D/I: Data Processing with an Immediate

| ISA  | TYPE | COND | -- | I | Op     | -   | rs   | rd   | -----     | rt   | 
|------|------|------|----|---|--------|-----|------|------| ----------| ---- |
| ARM  | D/R  | 1110 | 00 | 0 | oooo   | 0   | ssss | dddd | 0000 0000 | tttt |

| ISA  | TYPE | COND | -- | I | Op     | -   | rs   | rd   | ---- | imm       |
|------|------|------|----|---|--------|-----|------|------|------|-----------|
| ARM  | D/I  | 1110 | 00 | 1 | oooo   | 0   | ssss | dddd | 0000 | iiii iiii |


M: Multiplication 

| ISA  | Type | COND | -- | - | op | func | - | rd   | rx   | rt   |  --  | rs   |
|------|----- |------|----|---|----|------|---|------|------|------|------|------|
| ARM  | M    | 1110 | 00 | 0 | oo | ff   | 0 | dddd | xxxx | tttt | 1001 | ssss |



Shift/R: Shift with register
S/I: shift with immediate

| ISA  | TYPE | COND | -- | I | Op     | -   | --   | rd   | ----  | f  | - | rt   | 
|------|------|------|----|---|--------|-----|------|------| ------|----|---| ---- |
| ARM  | S/R  | 1110 | 00 | 0 | oooo   | 0   | 0000 | dddd | ssss0 | ff | 1 | tttt |
| ARM  | S/I  | 1110 | 00 | 1 | oooo   | 0   | 0000 | dddd | iiiii | ff | 0 | tttt |



## Data Processing Instructions:

### Move Operations


| Description            | Java            | MIPS          | ARM             |
|------------------------|-----------------|---------------|-----------------|
| Move                   | rd = rt         | move $rd, $rt | MOV rd, rt      |
| Load Immediate         | rd = imm        | li $rd, imm   | MOV rd, #imm    |
| Load Upper Immediate   | rd = imm << 16  | lui $rd, imm  | _none_          |
|------------------------|-----------------|---------------|-----------------|
| Move Negative          | rd = ~ rt       | _none_        | MVN rd, rt      |
| Move Negative w/imm    | rd = ~ imm      | _none_        | MVN rd, #imm    |
|------------------------|-----------------|---------------|-----------------|
| Load Address           | rd = &label     | la $rd,label  | LDR rd, =label  |
|------------------------|-----------------|---------------|-----------------|
| Move from hi register  | rd = hi         | mfhi $rd      | _none_          |
| Move to hi register    | hi = rs         | mfhi $rs      | _none_          |
| Move from lo register  | rd = lo         | mflo $rd      | _none_          |
| Move to lo register    | lo = rs         | mfhi $rs      | _none_          |



| MNEMONIC | op      |func     | ISA    | FORMAT |
|----------|--------:|---------|--------|--------|
| move     |         |         | MIPS   | pseudo |
| MOV      | 1101    |         | ARM    | D/x    |
| MVN      | 1111    |         | ARM    | D/x    |
| mfhi     | 00 0000 | 01 0000 | MIPS   | R      |
| mthi     | 00 0000 | 01 0001 | MIPS   | R      |
| mflo     | 00 0000 | 01 0010 | MIPS   | R      |
| mtlo     | 00 0000 | 01 0011 | MIPS   | R      |
| la       |         |         | MIPS   | pseudo | 
| LDR      |         |         | ARM    | pseudo |
| li       |         |         | MIPS   | pseudo |
| lui      | 00 1111 |         | MIPS   | I      | 


| Pseudo Instruction  |  Equivalent                |
|---------------------|----------------------------|
| move $rd, $rt       | addu $rd, $zero, $rt       |
|---------------------|----------------------------|
| la rd, label        | lui $at upper(label)       |
|                     | ori $rd, $at, lower(label) |
|---------------------|----------------------------|
| li rd, imm          | addiu $rd, $at, imm        |
|---------------------|----------------------------|
| LDR  RD, =label     |  ...                       |
|---------------------|----------------------------|



### Bitwise Operations (C bit is based upon results of barrel shifter)

| Description        | Java                | MIPS               | ARM              |
|--------------------|---------------------|--------------------|------------------|
| Complement         | rd = ~ rs           | not $rd, $rs       | MVN rd, rs       |
| Complement w/imm   | rd = ~ imm          | _none_             | MVN rd, #imm     |
|--------------------|---------------------|--------------------|------------------|
| And                | rd = rs & rt        | and $rd, $rs, $rt  | AND rd, rs, rt   |
| And w/imm          | rd = rs & imm       | andi $rd, $rt, imm | AND rd, rt, #imm |
|--------------------|---------------------|--------------------|------------------|
| Exclusive Or       | rd = rs ^ rt        | xor $rd, $rs, $rt  | EOR rd, rs, rt   |
| Exclusive Or w/imm | rd = rs ^ imm       | xori $rd, $rs, imm | EOR rd, rs, #imm |
|--------------------|---------------------|--------------------|------------------|
| Or                 | rd = rs \| rt       | or $rd, $rs, $rt   | OOR rd, rt, rt   |
| Or w/imm           | rd = rs \| imm      | ori $rd, $rs, imm  | OOR rd, rt, #imm |
|--------------------|---------------------|--------------------|------------------|
| Nor                | rd = ~ ( rs | rt )  | nor $rd, $rs, $rt  | _none_           |
| Nor w/imm          | rd = ~ ( rs | imm ) | _none_             | _none_           |
|--------------------|---------------------|--------------------|------------------|
| Bit Clear          | rd = rs & ( ~ rt )  | _none_             | BIC rd, rs, rt   |
| Bit Clear w/imm    | rd = rs & ( ~ imm ) | _none_             | BIC rd, rs, #imm |
|--------------------|---------------------|--------------------|------------------|
| Count leading 0's  |                     | clz $rd, $rs       | _none_           |
| Count leading 1's  |                     | clo $rd, $rs       | _none_           |
|--------------------|---------------------|--------------------|------------------|




| MNEMONIC | op      | func    | ISA  | FORMAT |
|----------|--------:|--------:|------|--------|
| and      | 00 0000 | 10 0100 | MIPS | R      |
| andi     | 00 1000 | 00 0000 | MIPS | I      |
| AND      |    0000 |         | ARM  | D/x    | 
| EOR      |    0001 |         | ARM  | D/x    |
| or       | 00 0000 | 10 0101 | MIPS | R      |
| ori      | 00 1101 | 00 0000 | MIPS | I      |
| OOR      |    1100 |         | MIPS | D/x    | 
| TEQ      |    1001 |         | ARM  | D/x    | 
| TST      |    1000 |         | ARM  | D/x    | 
| xor      | 00 0000 | 10 0110 | MIPS | R      |
| xori     | 00 1101 | 00 0000 | MIPS | I      |
| nor      | 00 0000 | 10 0111 | MIPS | R      |
| not      |         |         | MIPS | psuedo |
| MVN      | 1111    |         | ARM  | D/x    |
| BIC      | 1110    |         | ARM  | D/x    |
| clz      | 01 1100 | 01 1010 | MIPS | R      |
| clz      | 01 1100 | 01 1011 | MIPS | R      |


| Pseudo Instruction  | Equivalent                 |
|---------------------|----------------------------|
| not $rd, $rs          | nor $rd, $rs, $zero        |


### Arithmetic Operations (PCSR is based upon ALU)

| Description                  | Java                  | MIPS               | ARM              |
|------------------------------|-----------------------|--------------------|------------------|
| Addition                     | rd = rs + rt          | add $rd, $rs, $rt  | ADD rd, rs, rt   |
| Addition w/imm               | rd = rs + imm         | addi $rd, $rs, $rt | ADD rd, rs, #imm |
|------------------------------|-----------------------|--------------------|------------------|
| Subtraction                  | rd = rs - rt          | sub $rd, $rs, $rt  | SUB rd, rs, rt   |
| Subtraction w/imm            | rd = rt - imm         | _none_             | SUB rd, rs, #imm |
|------------------------------|-----------------------|--------------------|------------------|
| Reverse Subtract             | rd = rt - rs          | _none_             | RSB rd, rs, rt   |
| Reverse Subtract w/imm       | rd = imm - rs         | _none_             | RSB rd, rs, #imm |
|------------------------------|-----------------------|--------------------|------------------|
| Carry Addition               | rd = rs + rt + C      | _none_             | ADC rd, rs, rt   |
| Carry Addition Carry/imm     | rd = rs + imm + C     | _none_             | ADC rd, rs, #imm |
|------------------------------|-----------------------|--------------------|------------------|
| Carry Subtract               | rd = rs - rt - 1 + C  | _none_             | SBC rd, rs, rt   |
| Carry Subtract w/imm         | rd = rs - imm - 1 + C | _none_             | SBC rd, rs, #imm |
|------------------------------|-----------------------|--------------------|------------------|
| Carry Reverse Subtract       | rd = rt - rs - 1 + C  | _none_             | RSC rd, rs, rt   |
| Carry Reverse Subtract w/imm | rd = imm - rs - 1 + C | _none_             | RSC rd, rs, #imm |


| MNEMONIC | op      | func    | ISA  | FORMAT |
|----------|--------:|--------:|------|--------|
| add      | 00 0000 | 10 0000 | MIPS | R      |
| addu     | 00 0000 | 10 0010 | MIPS | R      |
| addi     | 00 1000 | 00 0000 | MIPS | I      |
| ADC      | 0101    |         | ARM  | D/x    | 
| ADD      | 0100    |         | ARM  | D/x    | 
| RSB      | 0011    |         | ARM  | D/x    |
| RSC      | 0111    |         | ARM  | D/x    | 
| SBC      | 0110    |         | ARM  | D/x    | 
| sub      | 10 0010 |         | MIPS | R      |
| SUB      | 0010    |         | ARM  | D/x    |




### Shift and Rotate Operations

| Description                  | Java                        | MIPS               | ARM              |
|------------------------------|-----------------------------|--------------------|------------------|
| Shift Left: Arithmetic       | rd = rt >>> rs              | srav $rd, $rt, $rs | ASL rd, rt, rs   |
| Shift Left: Arithmetic w/imm | rd = rt >>> imm             | sra $rd, $rt, imm  | ASL rd, rt, #imm |
|------------------------------|-----------------------------|--------------------|------------------|
| Shift Left: Logical          | rd = rt << rs               | sllv $rt, $rt, $rs | LSL rd, rt, rs   |
| Shift Left: Logical w/imm    | rd = rt << imm              | sll $rd, $rt, imm  | LSL rd, rt, #imm |
|------------------------------|-----------------------------|--------------------|------------------|
| Shift Right: Logical         | rd = rt >> rs               | srlv $rd, $rt, $rs | RSL rd, rt, rs   |
| Shift Right: Logical w/imm   | rd = rt >> imm              | srl $rd, $rt, imm  | RSL rd, rt, #imm |
|------------------------------|-----------------------------|--------------------|------------------|
| Shift Left: Arithmetic       | rd = rt >>> rs              | srav $rd, $rt, $rs | ASL rd, rt, rs   |
| Shift Left: Arithmetic w/imm | rd = rt >>> imm             | sra $rd, $rt, imm  | ASL rd, rt, #imm |
|------------------------------|-----------------------------|--------------------|------------------|
| Rotate Left                  | rd = rt << rs | rt >> rs    | rol $rd, $rs, $rt  | _none_           |
| Rotate Left w/imm            | rd = rt << imm | rt >> imm  | ror $rd, $rs, imm  | _none_           |
|------------------------------|-----------------------------|--------------------|------------------|
| Rotate Right                 | rd = rt << rs | rt >> rs    | ror $rd, $rs, $rt  | ROR rd, rt, rs   |
| Rotate Right w/imm           | rd = rt << imm | rt >> imm  | ror $rd, $rs, imm  | ROR rd, rt, #imm |
|------------------------------|-----------------------------|--------------------|------------------|
| Rotate Right Extended w/imm  | rd = C << 31 + rt >>1       | _none_             | RXR rd, rt       |


| MNEMONIC | op      |func     | ISA  | FORMAT |
|----------|--------:|--------:|------|--------|
| LSL      |    1101 |   00    | ARM  | psuedo |
| RSL      |    1101 |   01    | ARM  | psuedo |
| ASL      |    1101 |   10    | ARM  | psuedo |
| ROR      |    1101 |   11    | ARM  | psuedo |
| RXX      |    1101 |   11    | ARM  | psuedo |
| rol      |         |         | MIPS | psuedo |
| ror      |         |         | MIPS | psuedo |
| sll      | 00 0000 | 00 0000 | MIPS | R      |
| srl      | 00 0000 | 00 0010 | MIPS | R      | 
| sra      | 00 0000 | 00 0011 | MIPS | R      | 
| sllv     | 00 0000 | 00 0100 | MIPS | R      |
| srlv     | 00 0000 | 00 0110 | MIPS | R      | 
| srav     | 00 0000 | 00 0111 | MIPS | R      | 


| Pseudo Instruction  | Equivalent                 |
|---------------------|----------------------------|
| ASL rd, rt, op2     | MOV rd, rt, ASL op2        |
| LSL rd, rt, op2     | MOV rd, rt, LSL op2        |
| RSL rd, rt, op2     | MOV rd, rt, RSL op2        |
|---------------------|----------------------------|
| rol $rd, $rs, $rt   | subu $at, $0, $rt          |
|                     | srlv $ar, $rs, $at         |
|                     | sllv $rd, $rs, $3          |
|                     | or  $rd, $rd, $at          |
|---------------------|----------------------------|
| rol $rd, $rs, imm   | srl  $at, $rs, 32-imm      |
|                     | sll  $rd, $rs, imm         |
|                     | or   $rd, $rd, $at         |
|---------------------|----------------------------| 
| ror $rd, $rs, $rt   | subu $at, $0, $rt          |
|                     | sllv $ar, $rs, $at         |
|                     | srlv $rd, $rs, $3          |
|                     | or  $rd, $rd, $at          |
|---------------------|----------------------------|
| ror $rd, $rs, imm   | sll  $at, $rs, 32-imm      |
|                     | srl  $rd, $rs, imm         |
|                     | or   $rd, $rd, $at         |
|---------------------|----------------------------|
| ROR rd, rt, op2     | MOV rd, rt, ROR op2        |
| RXR rd, rt          | MOV rd, rt, ROR #0         |



## Multiple
Multiplication operations two types


### Multiply 32-bit Operations

| Description              | Java                | MIPS               | ARM        |
|--------------------------|---------------------|--------------------|------------|
| Multiply                 | rd = rs * rt        | mul $rd, $rs, $rt  | MUL rd, rs, rt |
| Multiply and Accumulate  | rd = rs * rt + rx   | _none_             | MLA rd, rs, rt, rx|
| Division                 | _R_ = rs / rt       | div $rs, $rt       | _none_ |
| Division (no overflow)   | _R_ = rs / rt       | divu $rs, $rt      | _none_ |
| Division                 | rd = rs / rt        | div $rd, $rs, $rt  | _none_ |
| Remainder                | rd = rs % rt        | rem $rd, $rs, $rt  | _none_ |


For the MIPS, there are two forms of division.  The first form is provided with two operands and yields two results.  The results that represent the quotient and the remainder are placed into the lo and hi registers, respectively.  The second form conforms to the three address format and is implemented as a pseudo instruction.


| MNEMONIC | op      | func    | FORMAT |
|----------|--------:|--------:|--------|
| mul      | 01 1000 | 00010   | R      |
| MUL      | 00      | 00      | M      |
| MLA      | 00      | 01      | M      |
| SMULL    | 01      | 00      | M      |
| UMULL    | 01      | 10      | M      |
| SMLAL    | 01      | 01      | M      |
| UMLAL    | 01      | 11      | M      |
| div      | 01 1010 |         | R      | 
| divu     | 01 1011 |         | R      | 


| mulo  $rd, $rs, $rt | pseudo  |   | MIPS |
| mulou $rd, $rs, $rt | pseudo  | 
| div   $rd, $rs, $rt | div $rs, $rt ; mflo $rd | 
| divu  $rd, $rs, $rt | divu $rs, $rt ; mflo $rd | 
| rem   $rd, $rs, $rt | div $rs, $rt ; mfhi $rd | 
| remu  $rd, $rs, $rt | divu $rs, $rt ; mfhi $rd | 


=====
### Multiply 64-bit Operations


| Description                    | Java                | MIPS            | ARM        |
|--------------------------------|---------------------|-----------------|------------|
| Signed Multiply                | _R_ = rs * rt       | mult $rs, $rt   | SMULL rd, rx rs, rt |
| Unsigned Multiply              | _R_ = rs * rt       | multu $rs, $rt  | UMULL rd, rx, rs, rt |
| Signed Multiply & Accumulate   | _R_ = _R_ + rs * rt | madd $rs, $rt   | SMLAL rd, rx, rs, rt |
| Unsigned Multiply & Accumulate | _R_ = _R_ + rs * rt | maddu $rs, $rt  | UMLAL rd, rx, rs, rt |
| Signed Multiply & Decumulate   | _R_ = _R_ - rs * rt | msub $rs, $rt   | _none_              |
| Unsigned Multiply & Decumulate | _R_ = _R_ - rs * rt | msubu $rs, $rt  | _none_  |

Registers are only 32-bits in length. As such, the 64-bit result _R_ is stored via two registers. MIPS uses the dedicated hi and lo registers for the result.  The ARM places the value within the rd, rx registers.



| MNEMONIC | op      | func     | ISA  |
|----------|--------:|---------:|------|
| mult      | 01 1000 | 1101     | ARM  |
| MULU      |
| MLA      | 


| mulo     | pseudo  |   | MIPS |
| mulou    | pseudo  | 
| div      | pseudo  |          | MIPS | 
| divu     | pseudo  |          | MIPS | 
| rem      | pseudo  |          | MIPS | 
| remu     | pseudo  |          | MIPS | 


mult rs, rt  0x18
multu        0x19

div rs, rt  0x1a R
divu rs, rt 0x19  R

madd rs, rt 0x1c 0x0
maddu rs, rt 0x1c 0x1
msub 0x4
msubu 0x5





## Control Flow


| ISA   | TYPE | op      |  address                          |
|-------|------|---------|-----------------------------------|
| MIPS  | J    | 00 0000 | ii iiii iiii  iiii iiii iiii iiii |


| ISA  | TYPE | Cond | --- | L | Offset | 
|------|------|------|-----|---|------------------------------------|
| ARM  | B/L  | 1110 | 101 | 0 | iiii iiii iiii iiii iiii iiii iiii |



### Unconditional Control Flow

| Description                     | Java                | MIPS            | ARM        |
|---------------------------------|---------------------|-----------------|------------|
| Unconditional Goto              | goto label          | j addr          | b addr     |
| Unconditional Goto              | goto label          | b offset        | b addr      |
| Unconditional Goto via Variable | _none_              | jr $rd          | bx rd      |
|---------------------------------|---------------------|-----------------|------------|
| Subroutine Call via Variable    | _none_              | jalr label      | ???           |
| Subroutine Call                 | A()                 | jal &A addr     | bl addr    |
| Subroutine Call                 | A()                 | bal &A offset   | bl label   |
|---------------------------------|---------------------|-----------------|------------|

### Conditional ~Control Flow~ Execution

On most processes, a set of conditional control-flow instructions are provided. These instructions perform 


to alter the current flow.  Such instructions forms some type of Bitwise or Arthimetic operation and based upon the results, a goto is performed.  This is the case w  For example,

    ```mips
    if ( A )
    ```


This is the case with the MIPS processor.  For the 


Traditionally, all instructions are executed based upon control flow.  A conditional control flow instruction can be performed to alter the current flow of a program.  E.g., 

   ```java
        if (A >= B) goto C;
   C:     max = A;  
          goto fi;   
   A:   // else
          max = B;
          goto fi
   fi:  
   ```



The ARM process, however, 


### Comparisons and Tests  
C: carry
N: negative
Z: zero
O: 

| Description            | Java                | MIPS                | ARM              |
|------------------------|---------------------|---------------------|------------------|
| Test Bits              | Z = ! (rs & rt)     | and $0, $rs, $rt    | TST rs, rt       |
| Test Bits w/imm        | Z = ! (rs & imm)    | andi $0, $rt, imm   | TST rs, #imm     |
|------------------------|---------------------|---------------------|------------------|
| Test Equality          | Z = !(rs ^ rt)      | xor $0, $rs, $rt    | TEQ rs, rt       |
| Test Equality w/imm    | Z = !(rs ^ imm)     | xori $0, $rs, imm   | TEQ rs, #imm     |
|------------------------|---------------------|---------------------|------------------|
| Compare Negative       | Z = !(rs + rt)      | addu $0, $rs, $rt   | CMN rs, rt       |
| Compare Negative w/imm | Z = !(rs + imm)     | addiu $0, $rs, imm  | CMN rs, #imm     |
|------------------------|---------------------|---------------------|------------------|
| Compare                | Z = !(rs - rt)      | subu $rd, $rs, $rt  | CMP rs, rt       |
| Compare w/imm          | Z = !(rs - imm)     | _none_              | CMP rs, #imm     |
|------------------------|---------------------|---------------------|------------------|


| MNEMONIC | op      |func     | ISA  | FORMAT |
|----------|--------:|--------:|------|--------|
| TST      |    1000 |         | ARM  | C/x    | 
| TEQ      |    1001 |         | ARM  | C/x    | 
| CMP      |    1010 |         | ARM  | C/x    | 
| CMN      |    1011 |         | ARM  | C/x    | 
| and      | 00 0000 | 10 0100 | MIPS | R      |
| andi     | 00 1100 | 00 0000 | MIPS | I      | 
| addu     | 00 0000 | 10 0001 | MIPS | R      |
| addiu    | 10 0001 | 00 0000 | MIPS | I      |
| subu     | 00 0000 | 10 0011 | MIPS | R      |
| andi     | 00 1000 | 00 0000 | MIPS | I      |
| xori     | 00 1101 | 00 0000 | MIPS | I      |
| xor      | 00 0000 | 10 0110 | MIPS | R      |


Set Less than: stl
Set Less than unsigned: stlu   
Set Less than immediate stli
Set Less than immediate unsigned stli

| Pseudo Instruction  | Equivalent                 |
|---------------------|----------------------------|
| 
slt rd = (rs == rt)? 1 : 0
stlu rd = (rs == rt)? 1 : 0
stli rd = (rs == imm)? 1 : 0
stliu rd = (rs == imm)? 1 : 0

seq  rd = (rs == op2)? 1 : 0
sge  rd = (rs >= op2)? 1 : 0 
sgeu rd = (rs >= op2)? 1 : 0
sgt  rd = (rs > op2)? 1 : 0
sgtu rd = (rs > op2)? 1 : 0
sneq rd = (rs != op2)? 1 : 0




### Comparison Based Control Flow

| Description                     | Java                | MIPS            | ARM        |
|---------------------------------|---------------------|-----------------|------------|
| Goto if rs == rt  |              | beq  $rs, $rt, label    |
| Goto if rs > rt   |              | bgt  $rs, $rt, label    |
| Goto if rs >= rt  |              | bge  $rs, $rt, label    |
| Goto if rs <= rt  |              | ble  $rs, $rt, label    |
| Goto if rs < rt   |              | blt  $rs, $rt, label    |
| Goto if rs != rt  |              | bne  $rs, $rt, label    |
| Goto if rs == 0   |              | beqz $rs, label         |
| Goto if rs > 0    |              | bgtz $rs, label         |
| Goto if rs >= 0   |              | bgez $rs, label         |
| Goto if rs <= 0   |              | blez $rs, label         |
| Goto if rs < 0    |              | bltz $rs, label         |
| Goto if rs != 0   |              | bne  $rs, label         |

| Subroutine Call if rs == rt  |   | beqal  $rs, $rt, label  |
| Subroutine Call if rs > rt   |   | bgtal  $rs, $rt, label  |
| Subroutine Call if rs >= rt  |   | bgeal  $rs, $rt, label  |
| Subroutine Call if rs <= rt  |   | bleal  $rs, $rt, label  |
| Subroutine Call if rs < rt   |   | bltal  $rs, $rt, label  |
| Subroutine Call if rs != rt  |   | bneal  $rs, $rt, label  |
| Subroutine Call if rs == 0   |   | beqzal $rs, label       |
| Subroutine Call if rs > 0    |   | bgtzal $rs, label       |
| Subroutine Call if rs >= 0   |   | bgezal $rs, label       |
| Subroutine Call if rs <= 0   |   | blezal $rs, label       |
| Subroutine Call if rs < 0    |   | bltzal $rs, label       |
| Subroutine Call if rs != 0   |   | bneal  $rs, label       |


### Conditional Instruction Execution 

On the ARM process, all instructions can be executed conditional. 


two instructions are required to perform a conditional goto.  The first command sets the values associated with the CSPR.  The next command A "branch" command is then used to 

or..


Conditional Execution...



These values are then check, and if set appropriately, a goto is 

with the CSPR.  The particular values are:
   * The C flag that indicates a carry 
   * the V flag that indicates an overflow occurs
   * the N flag that indicates the resulting value is n
Based upon the status of a previous operation 

|---------------------------------|---------------------|-----------------|------------|
| Branch if EQual |  _none_  | B.EQ addr 
| Branch if Not Equal |  _none_  | B.NE addr 
| Branch if Carry Set |  _none_  | B.CS addr 
| Branch if Carry Clear |  _none_  | B.CC addr 
| Branch if MInus |  _none_  | B.MI addr 
| Branch if PLus |  _none_  | B.PL addr 
| Branch if oVerFlow Set |  _none_  | B.VS addr 
| Branch if overFlow Set |  _none_  | B.VC addr 
| Branch if HIgher |  _none_  | B.HI addr 
| Branch if LesS |  _none_  | B.LS addr 
| Branch if GE |  _none_  | B.GE addr 
| Branch if Less T |  _none_  | B.LT addr 
| Branch if Greater Than |  _none_  | B.GT addr 
| Branch if Less than or Equal |  _none_  | B.LE addr 
| Branch ALways |  _none_  | B.AL addr 
 

| BEQ
|         |        |               | B.EQ addr |
|         |        |               | B.NE addr |
|         |        |               | B.CS addr |
|         |        |               | B.CC addr |
|         |        |               | B.MI addr |
|         |        |               | B.PL addr |
|         |        |               | B.VS addr |
|         |        |               | B.VC addr |
|         |        |               | B.HI addr |
|         |        |               | B.LS addr |
|         |        |               | B.GE addr |
|         |        |               | B.LT addr |
|         |        |               | B.GT addr |
|         |        |               | B.LE addr |
|         |        |               | B.AL addr |

|---------------|



bltz   00 0000  RI
bgez   00 0001  RI
bltzal 01 0000 
bgezal 01 0001


beq  $rs, $rt, offset
bgez $rs, $rt, offset


bgtz   rd >
blez   rd <=
bltz   rd < 0
bltzal rd < 0
bne    rd != rt

CMP rs, rt
BEQ



B{L}.EQ | 0000 | 1 if L | ARM  | 
B{L}.NE | 0001 | 1 if L | ARM  | 
B{L}.CS | 0010 | 1 if L | ARM  | 
B{L}.CC | 0011 | 1 if L | ARM  | 
B{L}.MI | 0100 | 1 if L | ARM  | 
B{L}.PL | 0101 | 1 if L | ARM  | 
B{L}.VS | 0110 | 1 if L | ARM  | 
B{L}.VC | 0111 | 1 if L | ARM  | 
B{L}.HI | 1000 | 1 if L | ARM  | 
B{L}.LS | 1001 | 1 if L | ARM  | 
B{L}.GE | 1010 | 1 if L | ARM  | 
B{L}.LT | 1011 | 1 if L | ARM  | 
B{L}.GT | 1100 | 1 if L | ARM  | 
B{L}.LE | 1101 | 1 if L | ARM  | 
B{L}.AL | 1110 | 1 if L | ARM  | 

b label  psuedo   beq $zero $zero offset
bal label BGEZAL $zero, offset

 Description                    | Java                | MIPS            | ARM        |
|-------------------------------|---------------------|-----------------|------------|
| Goto                          | goto addr         |    | |
| Register Goto ir      | goto rd           |  J
| Jump and Link     | _       | |  |
| Branch 
| Branch and Link
| Branch if equal
| Conditional Branch


| Branch if EQ | 0000 | 1 if L | ARM  | 
| Branch if NE | 0001 | 1 if L | ARM  | 
| Branch if CS | 0010 | 1 if L | ARM  | 
| Branch if CC | 0011 | 1 if L | ARM  | 
| Branch if MI | 0100 | 1 if L | ARM  | 
| Branch if PL | 0101 | 1 if L | ARM  | 
| Branch if VS | 0110 | 1 if L | ARM  | 
| Branch if VC | 0111 | 1 if L | ARM  | 
| Branch if HI | 1000 | 1 if L | ARM  | 
| Branch if LS | 1001 | 1 if L | ARM  | 
| Branch if GE | 1010 | 1 if L | ARM  | 
| Branch if LT | 1011 | 1 if L | ARM  | 
| Branch if GT | 1100 | 1 if L | ARM  | 
| Branch if LE | 1101 | 1 if L | ARM  | 
| Branch if AL | 1110 | 1 if L | ARM  | 
 














============

## General Syntax



This subset is restricted to the most common instructions.  The purpose of this document is 


MNEMONIC . COND . S  rd, rt, 

mips: op2 ->  $rt | number
arm:  op2 ->  [ rotate ] rt | [ shift ] #num

shift = { 
	LSR: logical shift right
	LSL: logical shift left
	ASR: arithmetic shift right
	ASL: arithmetic shift left == LSL
	ROR: rotate right
}

rotate = {
	LSR: logical shift right
	LSL: logical shift left
	ASR: arithmetic shift right
	ASL: arithmetic shift left == LSL
	ROR: rotate right	
	RXX: rotate right extended == ROR #0
}

# Logical/Arithmetic Operations
  1. ARM: MNEMONIC . COND . S    
  1. MIPS: MNEUMONIC . (u) 

--  the u just indicates don't trap on overflow ?


ARM:

Data Processing 
|COND |    | Imm | OpCode | Set | rs   | rd   | shift    | rt   | 
|xxxx | 00 | 0   | xxxx   | x   | xxxx | xxxx | xxxxx tt 0 | xxxx |

|cccc | 00 | 0   | oooo   | S   | ssss | dddd | aaaaa tt 0 | tttt |

|xxxx | 00 | 0   | xxxx   | x   | xxxx | xxxx | rrrr 0 tt 1 | xxxx |


Data Processing with immediate
|COND |    | Imm | OpCode | Set | rs   | rd   | rotate   | imm      | 
|xxxx | 00 | 1   | xxxx   | x   | xxxx | xxxx | xxxx     | xxxxxxxx |

The rotate field specifice a number the 
    iiii >> (rrrr << 1)

MOV rd, rs, ROR # 2b 11110





-------------

| Multiply (32) | rd = r1 * rt | mul | MUL   |
| Multiple and Add |  rd = rd * r1 + op2 | _none_ | MLA |
| Divide        | hi = r1 / rt, lo = r1 % rt | div  | _none_ |

| Multiple Long | {hi, lo} = r1 * rt | mult | MULL   |
| Multiple and Add |  {hi, lo} = rd * r1 + op2 | _none_ | MLAL |


  
