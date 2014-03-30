-- cliextra.lua
-- Extra functions for the CLI

local function bootInit()
	exitFunc = boot
	running = false
end

addCMD("boot", bootInit)
addCMD("image", image)
addCMD("append", append)

cli() -- Run it!

-- End cliextra.lua