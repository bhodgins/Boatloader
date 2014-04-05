-- basic.lua
-- Implements CC's Basic functions.
-- Credit: Dan200

-- CraftOS Keys API:
-- Minecraft key code bindings
-- See http://www.minecraftwiki.net/wiki/Key_codes for more info

local nothing = 42
local tKeys = {
	nil,	 	"one", 		"two", 		"three", 	"four",-- 1
	"five", 	"six", 		"seven", 	"eight", 	"nine",-- 6
	"zero", 	"minus", 	"equals", 	"backspace","tab",	-- 11
	"q", 		"w", 		"e", 		"r",		"t",	-- 16
	"y",		"u",		"i",		"o",		"p",	-- 21
	"leftBracket","rightBracket","enter","leftCtrl","a",			-- 26
	"s",		"d",		"f",		"g",		"h",	-- 31
	"j",		"k",		"l",		"semiColon","apostrophe",	-- 36
	"grave",	"leftShift","backslash","z",		"x",		-- 41
	"c",		"v",		"b",		"n",		"m",	-- 46
	"comma",	"period",	"slash",	"rightShift","multiply",-- 51
	"leftAlt",	"space",	"capsLock",	"f1",		"f2",	-- 56
	"f3",		"f4",		"f5",		"f6",		"f7",	-- 61
	"f8",		"f9",		"f10",		"numLock",	"scollLock",	-- 66	
	"numPad7",	"numPad8",	"numPad9",	"numPadSubtract","numPad4",	-- 71
	"numPad5",	"numPad6",	"numPadAdd","numPad1",	"numPad2",	-- 76
	"numPad3",	"numPad0",	"numPadDecimal",nil,	nil,		-- 81
	nil,	 	"f11",		"f12",		nil,		nil,	-- 86
	nil,		nil,		nil,		nil,		nil,	-- 91
	nil,		nil,		nil,		nil,		"f13",	-- 96
	"f14",		"f15",		nil,		nil,		nil,	-- 101
	nil,		nil,		nil,		nil,		nil,	-- 106
	nil,		"kana",		nil,		nil,		nil,	-- 111
	nil,		nil,		nil,		nil,		nil,	-- 116	
	"convert",	nil,		"noconvert",nil,		"yen",	-- 121
	nil,		nil,		nil,		nil,		nil,	-- 126
	nil,		nil,		nil,		nil,		nil,	-- 131
	nil,		nil,		nil,		nil,		nil,	-- 136
	"numPadEquals",nil,		nil,		"cimcumflex","at",	-- 141
	"colon",	"underscore","kanji",	"stop",		"ax",		-- 146
	nil,		"numPadEnter","rightCtrl",nil,		nil,		-- 151
	nil,		nil,		nil,		nil,		nil,	-- 156
	nil,		nil,		nil,		nil,		nil,	-- 161
	nil,		nil,		nil,		nil,		nil,	-- 166
	nil,		nil,		nil,		nil,		nil,	-- 171
	nil,		nil,		nil,		"numPadComma",nil,	-- 176
	"numPadDivide",nil,		nil,		"rightAlt",	nil,	-- 181
	nil,		nil,		nil,		nil,		nil,	-- 186
	nil,		nil,		nil,		nil,		nil,	-- 191
	nil,		"pause",	nil,		"home",		"up",	-- 196
	"pageUp",	nil,		"left",		nil,		"right",-- 201
	nil,		"end",		"down",		"pageDown",	"insert",		-- 206
	"delete"								-- 211
}

local keys = getfenv()
for nKey, sKey in pairs( tKeys ) do
	keys[sKey] = nKey
end
keys["return"] = keys.enter

function getName( _nKey )
	return tKeys[ _nKey ]
end


function print( ... )
	local nLinesPrinted = 0
	for n,v in ipairs( { ... } ) do
		nLinesPrinted = nLinesPrinted + write( tostring( v ) )
	end
	nLinesPrinted = nLinesPrinted + write( "\n" )
	return nLinesPrinted
end

function printError( ... )
	if term.isColour() then
		term.setTextColour( colours.red )
	end
	print( ... )
	term.setTextColour( colours.white )
end

function read( _sReplaceChar, _tHistory )
	term.setCursorBlink( true )

    local sLine = ""
	local nHistoryPos = nil
	local nPos = 0
    if _sReplaceChar then
		_sReplaceChar = string.sub( _sReplaceChar, 1, 1 )
	end
	
	local w, h = term.getSize()
	local sx, sy = term.getCursorPos()	
	
	local function redraw( _sCustomReplaceChar )
		local nScroll = 0
		if sx + nPos >= w then
			nScroll = (sx + nPos) - w
		end
			
		term.setCursorPos( sx, sy )
		local sReplace = _sCustomReplaceChar or _sReplaceChar
		if sReplace then
			term.write( string.rep( sReplace, string.len(sLine) - nScroll ) )
		else
			term.write( string.sub( sLine, nScroll + 1 ) )
		end
		term.setCursorPos( sx + nPos - nScroll, sy )
	end
	
	while true do
		local sEvent, param = os.pullEvent()
		if sEvent == "char" then
			sLine = string.sub( sLine, 1, nPos ) .. param .. string.sub( sLine, nPos + 1 )
			nPos = nPos + 1
			redraw()
			
		elseif sEvent == "key" then
		    if param == keys.enter then
				-- Enter
				break
				
			elseif param == keys.left then
				-- Left
				if nPos > 0 then
					nPos = nPos - 1
					redraw()
				end
				
			elseif param == keys.right then
				-- Right				
				if nPos < string.len(sLine) then
					redraw(" ")
					nPos = nPos + 1
					redraw()
				end
			
			elseif param == keys.up or param == keys.down then
                -- Up or down
				if _tHistory then
					redraw(" ")
					if param == keys.up then
						-- Up
						if nHistoryPos == nil then
							if #_tHistory > 0 then
								nHistoryPos = #_tHistory
							end
						elseif nHistoryPos > 1 then
							nHistoryPos = nHistoryPos - 1
						end
					else
						-- Down
						if nHistoryPos == #_tHistory then
							nHistoryPos = nil
						elseif nHistoryPos ~= nil then
							nHistoryPos = nHistoryPos + 1
						end						
					end
					if nHistoryPos then
                    	sLine = _tHistory[nHistoryPos]
                    	nPos = string.len( sLine ) 
                    else
						sLine = ""
						nPos = 0
					end
					redraw()
                end
			elseif param == keys.backspace then
				-- Backspace
				if nPos > 0 then
					redraw(" ")
					sLine = string.sub( sLine, 1, nPos - 1 ) .. string.sub( sLine, nPos + 1 )
					nPos = nPos - 1					
					redraw()
				end
			elseif param == keys.home then
				-- Home
				redraw(" ")
				nPos = 0
				redraw()		
			elseif param == keys.delete then
				if nPos < string.len(sLine) then
					redraw(" ")
					sLine = string.sub( sLine, 1, nPos ) .. string.sub( sLine, nPos + 2 )				
					redraw()
				end
			elseif param == keys["end"] then
				-- End
				redraw(" ")
				nPos = string.len(sLine)
				redraw()
			end
		end
	end
	
	term.setCursorBlink( false )
	term.setCursorPos( w + 1, sy )
	print()
	
	return sLine
end

function os.unloadAPI( _sName )
	if _sName ~= "_G" and type(_G[_sName]) == "table" then
		_G[_sName] = nil
	end
end

function os.sleep( _nTime )
	sleep( _nTime )
end

local nativeShutdown = os.shutdown
function os.shutdown()
	nativeShutdown()
	while true do
		coroutine.yield()
	end
end

local nativeReboot = os.reboot
function os.reboot()
	nativeReboot()
	while true do
		coroutine.yield()
	end
end

loadfile = function( _sFile )
	local file = fs.open( _sFile, "r" )
	if file then
		local func, err = loadstring( file.readAll(), fs.getName( _sFile ) )
		file.close()
		return func, err
	end
	return nil, "File not found"
end

dofile = function( _sFile )
	local fnFile, e = loadfile( _sFile )
	if fnFile then
		setfenv( fnFile, getfenv(2) )
		return fnFile()
	else
		error( e, 2 )
	end
end

-- Install the rest of the OS api
function os.run( _tEnv, _sPath, ... )
    local tArgs = { ... }
    local fnFile, err = loadfile( _sPath )
    if fnFile then
        local tEnv = _tEnv
        --setmetatable( tEnv, { __index = function(t,k) return _G[k] end } )
		setmetatable( tEnv, { __index = _G } )
        setfenv( fnFile, tEnv )
        local ok, err = pcall( function()
        	fnFile( unpack( tArgs ) )
        end )
        if not ok then
        	if err and err ~= "" then
	        	printError( err )
	        end
        	return false
        end
        return true
    end
    if err and err ~= "" then
		printError( err )
	end
    return false
end

local nativegetmetatable = getmetatable
local nativetype = type
local nativeerror = error
function getmetatable( _t )
	if nativetype( _t ) == "string" then
		nativeerror( "Attempt to access string metatable", 2 )
		return nil
	end
	return nativegetmetatable( _t )
end

local tAPIsLoading = {}
function os.loadAPI( _sPath )
	local sName = fs.getName( _sPath )
	if tAPIsLoading[sName] == true then
		printError( "API "..sName.." is already being loaded" )
		return false
	end
	tAPIsLoading[sName] = true
		
	local tEnv = {}
	setmetatable( tEnv, { __index = _G } )
	local fnAPI, err = loadfile( _sPath )
	if fnAPI then
		setfenv( fnAPI, tEnv )
		fnAPI()
	else
		printError( err )
        tAPIsLoading[sName] = nil
		return false
	end
	
	local tAPI = {}
	for k,v in pairs( tEnv ) do
		tAPI[k] =  v
	end
	
	_G[sName] = tAPI	
	tAPIsLoading[sName] = nil
	return true
end

function os.pullEventRaw( _sFilter )
	return coroutine.yield( _sFilter )
end

function os.pullEvent( _sFilter )
	local eventData = { os.pullEventRaw( _sFilter ) }
	if eventData[1] == "terminate" then
		error( "Terminated", 0 )
	end
	return unpack( eventData )
end

-- Install globals
function sleep( _nTime )
    local timer = os.startTimer( _nTime )
	repeat
		local sEvent, param = os.pullEvent( "timer" )
	until param == timer
end

function write( sText )
	local w,h = term.getSize()		
	local x,y = term.getCursorPos()
	
	local nLinesPrinted = 0
	local function newLine()
		if y + 1 <= h then
			term.setCursorPos(1, y + 1)
		else
			term.setCursorPos(1, h)
			term.scroll(1)
		end
		x, y = term.getCursorPos()
		nLinesPrinted = nLinesPrinted + 1
	end
	
	-- Print the line with proper word wrapping
	while string.len(sText) > 0 do
		local whitespace = string.match( sText, "^[ \t]+" )
		if whitespace then
			-- Print whitespace
			term.write( whitespace )
			x,y = term.getCursorPos()
			sText = string.sub( sText, string.len(whitespace) + 1 )
		end
		
		local newline = string.match( sText, "^\n" )
		if newline then
			-- Print newlines
			newLine()
			sText = string.sub( sText, 2 )
		end
		
		local text = string.match( sText, "^[^ \t\n]+" )
		if text then
			sText = string.sub( sText, string.len(text) + 1 )
			if string.len(text) > w then
				-- Print a multiline word				
				while string.len( text ) > 0 do
					if x > w then
						newLine()
					end
					term.write( text )
					text = string.sub( text, (w-x) + 2 )
					x,y = term.getCursorPos()
				end
			else
				-- Print a word normally
				if x + string.len(text) - 1 > w then
					newLine()
				end
				term.write( text )
				x,y = term.getCursorPos()
			end
		end
	end
	
	return nLinesPrinted
end

-- End basic.lua
