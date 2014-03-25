-- CLI.lua
-- Basic CLI, made for BoatLoader

local commands = {}

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
	--local handle = fs.open(file, fs.exists(file) and "a" or "w")
	local handle = fs.open(handle, "r")
	-- TODO
end

local function cliInit()
	-- LOOOOGOOOO!!!!
	local logo= "       _~       \n    _~ )_)_~    \n    )_))_))_)   \n    _!__!__!_   \n  ~~\\______t/~~ \n  ~~~~~~~~~~~~~ \n  |BOATYLOADER| \n   \\——V1.0——-/  \n"
	print(logo)
	-- Making functions available to the cli:
	commands["print"] = print
end

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

-- End CLI.lua
cli()