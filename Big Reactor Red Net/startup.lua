-- ACCEPTS MESSAGES FROM DESTINATION AND STARTS OR STOP A CONNECTED REACTOR
local sideRednet = "top"
local sideReactor = "back"

-- REACTOR
local reactor = peripheral.wrap(sideReactor)

-- REDNET
rednet.open(sideRednet)
 
-- CONFIG.INI
local id_receiver = nil
local file = "config.ini"
local handle = fs.open(file, "r")

if not fs.exists(file) then
    error("Please edit config.ini line one should be the ID of the receiver.")
end

if handle then
    id_receiver = tonumber(handle.readLine())
    handle.close()
end
 
-- WAIT
while 1 do
    local id, text = rednet.receive()
    
    if id == id_receiver then
        print("[" .. textutils.formatTime(os.time(), false) .. "] Received [" .. id .. "->" .. os.getComputerID() .. "]: " .. text)
        
        
        if text == "start" then
            reactor.setActive(true)
        end
        
        if text == "stop" then
            reactor.setActive(false)
        end
    end
end