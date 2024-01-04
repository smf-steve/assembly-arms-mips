#! /bin/bash

# This program is used to enumarate all of the values that 
# can be generated by the Arm Immediate value.
# E.g. #7  is encode as a 
#     - 8 bit immediate value
#     - 4 bit ror value

# Since the shell:
#   - uses a 64 bit value, whereas Arm uses 32 bits
#   - does not suport rotate right
# We store the value of the immediate as follows:
#   | xxxx xxxx xxxx xxxx | xxxx xxxx iiii iiii || xxxx xxxx xxxx xxxx | xxxx xxxx iiii iiii |
#
# We perform a rotate right (>>) and then mask the lower 32 bits to obtain value
# We then perform sign extention


(( imm_max = 0xFF ))
(( rot_max = 0xF ))
(( max_32 = 0xFFFFFFFF ))
(( msb_32 = 0x80000000 ))
(( upper  = max_32 << 32 ))

for (( imm = 0 ; imm <= imm_max ; imm ++ )) ; do 
  (( value = imm << 32 | imm ))
  for (( rot = 0 ; rot <= rot_max ; rot ++ )) ; do
    (( value = value >> 2 ))
    (( output = value & max_32 ))
    if (( output & msb_32 )) ; then
      : printf "0x%08x\n" $(( upper | output ))   # a negative number
      printf "%d\n" $(( upper | output ))   # a negative number
    else
      : printf "0x%08x\n" $(( output ))
      printf "%d\n" $(( output ))
    fi
  done
done