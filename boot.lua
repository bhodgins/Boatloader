-- boot.lua
-- This file does the OS loading

local kernel
local osRoot

function boot() -- Takes no arguments, this is the start of the booting Process.
	local osConf
end

function kernel(arg) -- Set the kernel
	kernal = arg[1]
end

function setRoot(arg) -- Sets the Root, the Config will be in /.osconf ( <-- Where you can put stuff, you can execute before loading the OS )
	osRoot=arg[1]
end

-- End boot.lua