#!/bin/sh
echo "" > bios.lua

# The order here is critical!:
declare -a SRCFILES=('basic.lua' 'clifunc.lua' 'boot.lua' 'cli.lua')
echo "building..."
for file in ${SRCFILES[@]}
do
	cat ${file} >> bios.lua
	echo -e "\n" >> bios.lua
	echo ${file}
done
