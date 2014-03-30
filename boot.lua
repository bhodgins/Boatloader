-- boot.lua
-- This file does the OS loading

local bootImage
local bootParams = {}

function boot() -- Takes no arguments, this is the start of the booting Process.
   local osConf
   local u = {}

   if not bootImage then
      print("boot: No image specified")
      return false
   end
   
   -- Make a copy of _G:
   for k, v in pairs(_G) do u[k] = v end
   local newEnv = setmetatable(u, getmetatable(_G))
   
   -- TODO: patch fs API?
   
   local funFile, error = loadfile(bootImage)
   if error and error ~= "" then
      print(error)
   end

   if funFile then
      local env = newEnv -- from env.lua
      setfenv( funFile, env)
      local success, error = pcall(function() funFile(unpack(bootParams)) end)
      if not success then
	 if error and error ~= "" then
	    print(error)
	 end
	 return false
      end
      return false
   end
end

function image(arg) -- Set the boot image / kernel
   bootImage = arg[1]
end

function append( ... ) -- passes params to the kernel
   bootParams = { ... }
end

-- End boot.lua
