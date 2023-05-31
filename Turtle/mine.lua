-- RUN COMMAND 'update' TO UPDATE THE SCRIPT FROM PASTEBIN

local function printUsage()
    print( "#######################################" )
    print( "# Usage:                              #" )
    print( "#  mine <distance> <height> <tunnel*> #" )
    print( "#######################################" )
end

-- LOAD USER INPUTS FROM ARGS
args = {...}

-- LOAD B API
os.loadAPI("B")

-- !!! DO NOT EDIT PAST HERE !!!

-- BOOLEAN
stringtoboolean = {
    ["true"] = true, 
    ["false"] = false,
    ["t"] = true, 
    ["f"] = false,
    ["1"] = true, 
    ["0"] = false,
}

-- CONVERT USER INPUT
local inputDistance = tonumber(args[1])
local inputHeight = tonumber(args[2])
local isTunneling = stringtoboolean[args[3]]

-- IF NILL TRUE
if args[3] == nil then
	isTunneling = false
end

-- CHECK INPUT
if args[1] == nil or args[2] == nil or type(inputDistance) ~= "number" or type(inputHeight) ~= "number" or not B.SetContains(stringtoboolean, args[3]) then
    printUsage()
end

-- USE FILTER
local useFilter = not isTunneling

-- DONT DROP
B.SetTorch(B.AddToSet(B.DontDrop, B.GetFirst(B.Torches, "minecraft:torch")))    -- TORCH
B.SetFloor(B.AddToSet(B.DontDrop, "minecraft:cobblestone"))                     -- "minecraft:cobblestone"
B.SetEnderChest(B.AddToSet(B.DontDrop, "EnderStorage:enderChest"))              -- "EnderStorage:enderChest"

-- NOISE FILTER
B.AddToSet(B.NoiseFilter, "minecraft:stone")		-- OVERWORLD
B.AddToSet(B.NoiseFilter, "minecraft:dirt") 		-- OVERWORLD
B.AddToSet(B.NoiseFilter, "minecraft:grass") 		-- OVERWORLD
B.AddToSet(B.NoiseFilter, "minecraft:netherrack") 	-- NETHER
B.AddToSet(B.NoiseFilter, "minecraft:bedrock") 		-- OVERWORLD & NETHER

-- EVERY DISTANCE DO
for distance = 1, inputDistance do
    -- PLACE TORCH AT START AND/OR EVERY 7 SQUARES
    local torchSlot = B.FindSlot(B.GetTorch())
    local hasTorches = torchSlot > 0;
    
    if hasTorches and (distance == 1 or math.fmod(distance - 1, 7) == 0) then
        B.Turn(B.Direction.LEFT)
        B.Turn(B.Direction.LEFT)
        B.Place(B.Direction.FORWARD, torchSlot)
        B.Turn(B.Direction.RIGHT)
        B.Turn(B.Direction.RIGHT)
    end
    
    -- TURN LEFT
    B.Turn(B.Direction.LEFT)
    
    -- DIG LEFT AND UP
    for height = 1, inputHeight do
        if height < inputHeight then
            B.Dig(B.Direction.FORWARD, useFilter)
            B.Dig(B.Direction.UP)
            B.Move(B.Direction.UP)
        end
        
        if height == inputHeight then
            B.Dig(B.Direction.FORWARD, useFilter)
            B.Dig(B.Direction.UP, true)
        end
    end
    
    -- TURN AROUND
    B.Turn(B.Direction.RIGHT)
    B.Turn(B.Direction.RIGHT)
    
    -- DIG RIGHT AND DOWN
    for height = 1, inputHeight do
        if height < inputHeight then
            B.Dig(B.Direction.FORWARD, useFilter)
            B.Move(B.Direction.DOWN)
        end
        
        if height == inputHeight then
            B.Dig(B.Direction.FORWARD, useFilter)
            B.Dig(B.Direction.DOWN, true)
            
            local floorSlot = B.FindSlot(B.GetFloor())
    		local hasFloor = floorSlot > 0;
            
            if hasFloor then
            	B.Place(B.Direction.DOWN, floorSlot)
            end
        end
    end
    
    -- TURN LEFT
    B.Turn(B.Direction.LEFT)
    
    -- MOVE FORWARD ONE SPACE
    if distance ~= inputDistance then
        B.Dig(B.Direction.FORWARD)
    	B.Move(B.Direction.FORWARD)
    end
end

-- RETURN TO BEGINNING
B.Move(B.Direction.UP)

-- TURN AROUND
B.Turn(B.Direction.RIGHT)
B.Turn(B.Direction.RIGHT)

for distance = 1, inputDistance - 1 do
    B.Move(B.Direction.FORWARD)
end

-- TURN AROUND
B.Turn(B.Direction.RIGHT)
B.Turn(B.Direction.RIGHT)

-- EMPTY INVENTORY
B.EmptyInventory(B.Direction.DOWN)

-- MOVE DOWN
B.Move(B.Direction.DOWN)