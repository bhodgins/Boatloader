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
		elseif command[1] == "help" then
			print("Available Functions: ")
			local availableCommands = ""
			for l,n in ipairs() do
				availableCommands = availableCommands..n..", "
			end
			availableCommands = availableCommands.."help"
			print(availableCommands)
		else
			print("Error: No such Command: "..command[1])
		end
	end
end

local function cliDoFile(file)
	--local handle = fs.open(file, fs.exists(file) and "a" or "w")
	local handle = fs.open(file, "r")
	while not finished do
		line = handle.readLine()
		if not line == nil then
			cliCMD(line)
		else
			finished = true
		end
	end
end

local function addCMD(cmdName, cmd)
	if not cmdName == nil or cmd == nil then
		commands[cmdName] = cmd
	else
		if cmd == nil then
			print("Error: addCMD: cmd not set!")
		elseif cmdName == nil then
			print("Error: addCMD: cmdName not set!")
		end
	end
end

local function cliInit()
	-- LOOOOGOOOO!!!!
	local logo= "       __       \n    __ )_)__    \n    )_))_))_)   \n    _!__!__!_   \n  ~~\\______t/~~ \n  ~~~~~~~~~~~~~ \n  |BOATYLOADER| \n   \\--V1.0---/  \n"
	print(logo)
	-- Making functions available to the cli:
	addCMD("print", printTable)
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