-- RUN COMMAND 'update' TO UPDATE THE SCRIPT FROM PASTEBIN
 
local function printUsage()
    print( "##########################################" )
    print( "# Usage:                                 #" )
    print( "#   move <direction> <distance> <height> #" )
    print( "#   direction = U,D,L,R,F,B              #" )
    print( "#   direction = MU,MD,MF                 #" )
    print( "#   distance = ∞                         #" )
    print( "#   height >= 2                          #" )
    print( "##########################################" )
end
 
-- LOAD USER INPUTS FROM ARGS
args = {...}

-- LOAD B API
os.loadAPI("B")
 
-- CONVERT USER INPUT
local inputDir = string.lower(tostring(args[1]))
local inputDistance = tonumber(args[2])
local inputHeight = tonumber(args[3])

-- FIRST ITEM IN SLOT IS SET TO FLOOR
for slot = 1,16 do
    local data = turtle.getItemDetail(slot)

    if data then
        B.SetFloor(B.AddToSet(B.DontDrop, data.name))
        break 
    end
end
 
-- !!! DO NOT EDIT PAST HERE !!!

if inputDir == "up" then
    for d = 1,inputDistance do
        B.Dig(B.Direction.UP)
        B.Move(B.Direction.UP)
    end
elseif inputDir == "down" then
    for d = 1,inputDistance do
    	B.Dig(B.Direction.DOWN)
    	B.Move(B.Direction.DOWN)
    end
elseif inputDir == "left" then
    for d = 1,inputDistance do
    	B.Turn(B.Direction.LEFT)
    end
elseif inputDir == "right" then
    for d = 1,inputDistance do
    	B.Turn(B.Direction.RIGHT)
    end
elseif inputDir == "forward" then
    for d = 1,inputDistance do
    	B.Dig(B.Direction.FORWARD)
    	B.Move(B.Direction.FORWARD)
    end
elseif inputDir == "backward" then
    for d = 1,inputDistance do
    	B.Move(B.Direction.BACKWARD)
    end
elseif inputDir == "makefloor" then
    for d = 1,inputDistance do
        B.Dig(B.Direction.DOWN)

        local floorSlot = B.FindSlot(B.GetFloor())
        local hasFloor = floorSlot > 0;

        if hasFloor then
            B.Place(B.Direction.DOWN, floorSlot)
        end

        B.Dig(B.Direction.FORWARD)
        B.Move(B.Direction.FORWARD)
    end
elseif inputDir == "makewall" then
    for h = 1,inputHeight do
        B.Move(B.Direction.UP)
        
        for d = 1,inputDistance do
            B.Dig(B.Direction.DOWN)

            local floorSlot = B.FindSlot(B.GetFloor())
            local hasFloor = floorSlot > 0;

            if hasFloor then
                B.Place(B.Direction.DOWN, floorSlot)
            end

            if d ~= inputDistance then
            	B.Dig(B.Direction.FORWARD)
            	B.Move(B.Direction.FORWARD)
            end
        end
        
        B.Turn(B.Direction.LEFT)
        B.Turn(B.Direction.LEFT)
    end
end