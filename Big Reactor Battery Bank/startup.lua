-- RELAY MESSAGES TO DESTINATION BASED ON ENERYGY LEVELS OF CONNECT DEVICE
local sideRednet = "top"
local sideBattery = "left"

-- BATTERY
local battery = peripheral.wrap(sideBattery)

rednet.open(sideRednet)

-- CONFIG.INI
local id_destination = nil
local file = "config.ini"
local handle = fs.open(file, "r")

if not fs.exists(file) then
    error("Please edit config.ini line one should be the ID of the destination.")
end

if handle then
    id_destination = tonumber(handle.readLine())
    handle.close()
end

function percent()
    return (battery.getEnergyStored() / battery.getMaxEnergyStored()) * 100
end

while 1 do
    print("[" .. textutils.formatTime(os.time(), false) .. "] Current Level: " .. string.format("%.0f%%", math.floor(percent() * 10) / 10))
    
    if percent() < 10 then
        local message = "start"
        
        rednet.send(id_destination, message)
        
        print("[" .. textutils.formatTime(os.time(), false) .. "] Sending [" .. os.getComputerID() .. "->" .. id_destination .. "]: " .. message)
    end
    
    if percent() > 80 then
        local message = "stop"
        
        rednet.send(id_destination, message)
        
        print("[" .. textutils.formatTime(os.time(), false) .. "] Sending [" .. os.getComputerID() .. "->" .. id_destination .. "]: " .. message)
    end
    
    sleep(10)
end