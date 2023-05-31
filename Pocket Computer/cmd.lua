-- SENDS A TEXT STRING TO A TURTLES
-- pastebin get FnasVkam command

args = {...}

rednet.open("back")

local message = ""

for k,v in pairs(args) do
    message = message .. " " .. v
end

print("[" .. textutils.formatTime(os.time(), false) .. "] Sending [" .. os.getComputerID() .. "->*]: " .. message)

rednet.broadcast(message)
rednet.close()