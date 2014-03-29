#!/bin/sh
rm bios.lua
echo "" > bios.lua

# The order here is critical!:
declare -a SRCFILES=('basic.lua' 'clifunc.lua' 'boot.lua' 'cli.lua' 'cliextra.lua')
echo "building..."
for file in ${SRCFILES[@]}
do
	cat ${file} >> bios.lua
	echo "\n" >> bios.lua
	echo ${file}
done
