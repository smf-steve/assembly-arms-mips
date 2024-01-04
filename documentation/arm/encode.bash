#!/bin/bash

(( imm_max   = 0xFF         ))
(( rot_max   = 0xF          ))

(( top_eight = 0xFF000000   ))

(( max_32    = 0xFFFFFFFF   ))
(( msb_32    = 0x80000000   ))
(( lower     = max_32       ))
(( upper     = max_32 << 32 ))

function rol () {
	value="$1"
	amount="$2"

	(( x = value << amount ))
	(( y = value >> (32 - amount) ))
	echo $(( (x | y ) & lower ))
}

function ror () {
	value="$1"
	amount="$2"

	(( x = value >> amount ))
	(( y = value << (32 - amount) ))
	echo $(( (x | y ) & lower ))
}


## Presume we have a 64-bit word
function encode_arm_immediate () {

    # Obtain the 32-bit equivalent number
    (( x = imm & upper ))
    (( x == upper ||  x == 0 )) || { echo "Not a 32-bit number" >&2 ; return 1; }
    (( imm = imm & lower ))

    (( mask = imm_max ))
    for (( c=0 ; c < 32 ; c +=2 )) ; do
       (( t = mask & imm ))
:       printf "0x%08x\n" $imm
:       printf "0x%08x\n" $mask
:       printf "0x%08x\n\n" $t
       if (( t == imm )) ; then 
       	  v=$(ror imm c)
       	  (( c = ((32 - c) >> 1 )))  # divide the count in half
       	  echo $c $v
       	  break;
       fi 
       mask=$(rol mask 2)
    done
}
