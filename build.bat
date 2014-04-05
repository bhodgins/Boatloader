@echo off
if exist bios.lua del bios.lua

REM The order here is critical!
set SRCFILES=basic.lua clifunc.lua boot.lua cli.lua cliextra.lua
echo Building BoatLoader ...
for %%x in (%SRCFILES%) DO call :addfile %%x
echo Done!
goto end

:addfile
	type %1 >> bios.lua
	echo Adding %1 ...
exit /b

:end
