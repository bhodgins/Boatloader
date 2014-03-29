-- clifunc.lua
-- Adding the basic functions for the CLI

local function printTable(h)
	for i in ipairs(h) do
		print(h[i])
	end
end

-- End clifunc.lua