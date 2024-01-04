#! /bin/bash

for ((x=0 ; x <= 0xFFF; x++)) ; do
	string=$(printf "0x%08x" $x)
   grep --silent "$string" immediates 
   if [[ $? != 0 ]] ; then 
      echo $(( string ))
   fi
done