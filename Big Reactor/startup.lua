-- BASIC SMALL REACTOR
local reactor = peripheral.wrap("back")

local startup = 8000000
local shutdown = 9000000

-- LOOP
while 1 do
    -- STARTUP
    if reactor.getEnergyStored() < startup then
        reactor.setActive(true)  
    end

    -- SHUTDOWN
    if reactor.getEnergyStored() > shutdown then
        reactor.setActive(false)
    end

    -- WAIT TIME
    sleep(5)
end
