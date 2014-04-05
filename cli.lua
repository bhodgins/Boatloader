-- cli.lua
-- Basic CLI, made for BoatLoader

local running = true
local commands = {}
local exitFunc = nativeShutdown
local exitArgs = nil

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
	if handle == nil then return false end
	for line in handle.readLine do
		cliCMD(line)
	end
	handle.close()
	return true
end

local function addCMD(cmdName, cmd)
	if (type(cmdName) == "string" and type(cmd) == "function") then
		commands[cmdName] = cmd
	end
end

local function exitHandeler()
	local funcreturn = nil
	funcreturn = exitFunc(exitArgs)
	if not funcreturn == nil then
		if (funcreturn == "reboot" or funcreturn == true) then
			cliCMD("boot")
		elseif funcreturn == "bootloader" then
			cli()
		end
	else
		nativeShutdown()
	end
end

local function cli(cmd)
	if cmd then
		cli(cmd)
		cmd = nil
	else
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
	end
	exitHandeler()
end

local function cliInit()
	-- LOOOOGOOOO!!!!
	local logo= "       __       \n    __ )_)__    \n    )_))_))_)   \n    _!__!__!_   \n  ~~\\______t/~~ \n  ~~~~~~~~~~~~~ \n  |BOATYLOADER| \n   \\--V1.0---/  \n"
	print(logo)
	-- Making functions available to the cli:
	addCMD("print", printTable)
	addCMD("do", cliDoFile)
	addCMD("lua", luaCMD)
	if not (fs.exists("/.boot") and fs.isDir("/.boot")) then
		fs.makeDir("/.boot")
	end
	if fs.exists("/.boot/autorun") then
		cliDoFile("/.boot/autorun")
	else
		startupCreator("/.boot/autorun")
		os.shutdown()
	end
	cli()
end

-- End cli.lua
