#!/bin/sh
echo "" > bios.lua

# The order here is critical!:
declare -a SRCFILES=('basic.lua' 'cli.lua')
for file in ${SRCFILES[@]}
do
	cat ${file} >> bios.lua
	echo -e "\n" >> bios.lua
done

