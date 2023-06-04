-- ACCEPTS TEXT COMMANDS FROM COMPUTER #X AND RUNS THEM AS A SHELL COMMAND
local side = "left"

rednet.open(side)

local accept = nil

-- CONFIG FILE
local file = "config.ini"

-- MAKE CONFIG FILE
if not fs.exists(file) then
    local lines = {}
    
    if os.getComputerLabel() == nil then
        print("Enter Computer Label:")
    	os.setComputerLabel(read())
    end
    
    print("Enter ID of your Pocket Computer:")
    lines[1] = read()
    
    local h = fs.open(file, "w" )
    
    for i = 1, #lines do
        h.writeLine(lines[i])
    end
    
    h.close()
end

-- READ CONFIG FILE
local handle = fs.open(file, "r")

if handle then
    -- USE EACH LINES
    accept = tonumber(handle.readLine())
    handle.close()
end

-- SPLIT STRING INTO TABLE
function Split(s, delimiter)
    result = {};
    
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    
    return result;
end

-- FUEL
print("[" .. textutils.formatTime(os.time(), false) .. "] Fuel: " .. turtle.getFuelLevel() .. "/" .. turtle.getFuelLimit())

-- WAIT FOR COMMANDS
while 1 do
    local id, text = rednet.receive()
    
    if id == accept then
        print("[" .. textutils.formatTime(os.time(), false) .. "] Received [" .. id .. "->" .. os.getComputerID() .. "]: " .. text)
        
        local args = Split(text, " ")
        
        -- UNPACKS TABLE AND RUNS AS SHELL
        shell.run(unpack(args))
    end
end
