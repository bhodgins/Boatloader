-- CLI.lua
-- Basic CLI, made for BoatLoader

local function cli(commands)
	
	local running = true
	while running do
		local input = read()
		command = {}
		for word in input:gmatch("%S+") do table.insert(commands, word) end
		if not (commands[1] == "quit") then
			local shellArgs
			for item in commands do
				if not item == 1 then
					
				else
					table.insert(commands[item])
				end
			end
			local currentFunction = command[commands[1]]
			currentFunction[shellArgs]
		else
			running = false
		end
	end
end
-- End CLI.lua