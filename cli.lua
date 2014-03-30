-- CLI.lua
-- Basic CLI, made for BoatLoader

local commands = {}
local exitFunc
local exitArgs

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
	if (type(cmdName) == "string" and type(cmd) == "function") then
		commands[cmdName] = cmd
	end
end

local function cliInit()
	-- LOOOOGOOOO!!!!
	local logo= "       __       \n    __ )_)__    \n    )_))_))_)   \n    _!__!__!_   \n  ~~\\______t/~~ \n  ~~~~~~~~~~~~~ \n  |BOATYLOADER| \n   \\--V1.0---/  \n"
	print(logo)
	-- Making functions available to the cli:
	addCMD("print", printTable)
	addCMD("do", cliDoFile)
	addCMD("lua", luaCMD)
end


local function cli(cmd)
	cliInit()
	if cmd then
		cli(cmd)
		cmd = nil
	else
		local running = true
		while running do
			write("-> ")
			local input = read()
			if input == "quit" then
				running = false
			elseif input == "help" then
				print("Available Functions: ")
				for i in pairs(commands) do
				   write(i .. ", ")
				end
				print("help and quit")
			else
				cliCMD(input)
			end
		end
		if exitFunc then
			local funcreturn = exitFunc(exitArgs)
			exitFunc = nil
			if funcreturn then
				if (funcreturn == "reboot" or funcreturn) then
					cliCMD("boot")
				elseif funcreturn == "bootloader" then
					cli()
					nativeShutdown()
				end
			else
				nativeShutdown()
			end
		end
	end
end

-- End CLI.lua
