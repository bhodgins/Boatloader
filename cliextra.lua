-- cliextra.lua
-- Extra functions for the CLI

local function bootInit()
	exitFunc = boot
	running = false
end

addCMD("boot", bootInit)
addCMD("image", image)
addCMD("append", append)

cliInit() -- Run it!

-- End cliextra.lua
