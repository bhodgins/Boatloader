-- CLI.lua
-- Basic CLI, made for BoatLoader

local commands = {}

local function cli()
	cliInit()
	local running = true
	while running do
		if not (input == "quit") then
			write("> ")
			local input = read()
			cliCMD(input)
		else
			running = false
		end
	end
end

local function cliCMD(cmd)
	local command = {}
	for word in input:gmatch("%S+") do table.insert(command, word) end
	
		local shellArgs = {}
		for item in commands do
			if not item == 1 then
				table.insert(shellArgs, commands[item])
			end
		end
	local currentFunction = command[commands[1]]
	currentFunction(shellArgs)
end

local function cliDoFile(file)
	-- TODO
end

local function cliInit()
	-- Making functions available to the cli:
	commands["print"] = print
end

-- End CLI.lua