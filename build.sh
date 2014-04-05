#!/bin/sh
if [ -e bios.lua ]; then
	rm bios.lua
fi

# The order here is critical!
declare -a SRCFILES=('basic.lua' 'clifunc.lua' 'boot.lua' 'cli.lua' 'cliextra.lua')
echo Building BoatLoader ...
for file in ${SRCFILES[@]}; do
	cat ${file} >> bios.lua
	echo Adding ${file} ...
done
echo Done!
