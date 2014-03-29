-- clifunc.lua
-- Adding the basic functions for the CLI

local function printTable(h)
	for i in ipairs(h) do
		print(h[i])
	end
end

local function luaCMD(arg)
	local argString = ""
	for i in ipairs(arg) do
		argstring = argstring.. arg[i]
	end
	loadstring(argString)()
end

-- End clifunc.lua