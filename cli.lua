-- CLI.lua
-- Basic CLI, made for BoatLoader

local commands = {}

local function cliCMD(cmd)
	local command = {}
	for word in cmd:gmatch("%S+") do table.insert(command, word) end
	local shellArgs = {}
	local shellArgs = command
	if not (commands == nil or command[1] == nil) then
		local currentFunction = commands[command[1]]
		if type(currentFunction) == "function" then
			table.remove(shellArgs, 1)
			currentFunction(shellArgs)
		else
			print("Error: No such Command: "..command[1])
		end
	end
end

local function cliDoFile(file)
	--local handle = fs.open(file, fs.exists(file) and "a" or "w")
	local handle = fs.open(handle, "r")
	-- TODO
end

local function cliInit()
	-- LOOOOGOOOO!!!!
	local logo= "       __       \n    __ )_)__    \n    )_))_))_)   \n    _!__!__!_   \n  ~~\\______t/~~ \n  ~~~~~~~~~~~~~ \n  |BOATYLOADER| \n   \\--V1.0---/  \n"
	print(logo)
	-- Making functions available to the cli:
	commands["print"] = printTable
end


local function cli()
	cliInit()
	local running = true
	while running do
		write("-> ")
		local input = read()
		if not (input == "quit") then
			cliCMD(input)
		else
			running = false
		end
	end
end

-- End CLI.lua
cli()