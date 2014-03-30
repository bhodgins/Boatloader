-- clifunc.lua
-- Adding the basic functions for the CLI

local function printTable(h)
	for i in ipairs(h) do
		print(h[i])
	end
end

local function luaCMD(arg)
	local argString = ""
	for i in pairs(arg) do
		argstring = argstring..arg[i]
	end
	loadstring(argString)()
end

function startupCreator(file)
	fs.delete(file)
	print("Hello!\nThis is the Setup of BoatLoader!\n")
	sleep(1)
	local success = false
	local path = "/"
	while not success do
		print("Please Input the desired Profile, or type new:")
		print("Available Profiles: craftos")
		profileSelection = read()
		if profileSelection == "craftos" or "" then
			path = "/rom/programs/shell"
			print("You choose CraftOS!")
			success = true
		elseif profileSelection == "new" then
			local exists = false
			while not exists do
				print("Please Input a valid path to the BootImage:")
				bootImageInput = read()
				if fs.exists(bootImageInput) then
					path = bootImageInput
					exists = true
				end
			end
			-- TODO: Add arg setup
		end
	end
	local fileContent = "print Booting...\nimage "..path.."\nboot"
	local h = fs.open(file, "w")
	h.write(fileContent)
	h.close()
end

-- End clifunc.lua