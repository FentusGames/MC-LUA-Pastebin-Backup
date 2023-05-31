-- RELAY MESSAGES FROM RECEIVER TO DESTINATION
local sideRednet = "top"

-- REDNET
rednet.open(sideRednet)

-- CONFIG.INI
local id_receiver = nil
local id_destination = nil
local file = "config.ini"
local handle = fs.open(file, "r")

if not fs.exists(file) then
    error("Please edit config.ini line one should be the ID of the receiver and line two should be the ID of the destination.")
end

if handle then
    id_receiver = tonumber(handle.readLine())
    id_destination = tonumber(handle.readLine())
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

while 1 do
    local id, text = rednet.receive()
    
    local args = Split(text, " ")
    
    if id == id_receiver then
        print("[" .. textutils.formatTime(os.time(), false) .. "] Received [" .. id .. "->" .. os.getComputerID() .. "]: " .. text)
        
        local message = unpack(args)
        
    	rednet.send(id_destination, message)
        
        print("[" .. textutils.formatTime(os.time(), false) .. "] Sending [" .. os.getComputerID() .. "->" .. id_destination .. "]: " .. message)
    end
end