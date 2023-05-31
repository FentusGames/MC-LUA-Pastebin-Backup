-- ENUMS
Yield = 0.1

Direction = {
    FORWARD = 0,
    BACKWARD = 1,
    UP = 2,
    DOWN = 3,
    LEFT = 4,
    RIGHT = 5,
}

-- API
Floor = nil
Torch = nil
EnderChest = nil

-- DATA TABLES
NoiseFilter = {}
DontDrop = {}
Torches = {}

function AddToSet(t, key)
    t[key] = true
    return key
end

function RemoveFromSet(t, key)
    t[key] = nil
end

function SetContains(t, key)
    return t[key] ~= nil
end

function SetFloor(name)
    Floor = name
end

function SetTorch(name)
    Torch = name
end

function SetEnderChest(name)
    EnderChest = name
end

function GetFloor()
    return Floor
end

function GetTorch()
    return Torch
end

function GetEnderChest()
    return EnderChest
end

-- DEFAULT DATA
AddToSet(NoiseFilter, "ComputerCraft:CC-TurtleAdvanced")
AddToSet(NoiseFilter, "minecraft:torch")
AddToSet(NoiseFilter, "TConstruct:decoration.stonetorch")
AddToSet(NoiseFilter, "CarpentersBlocks:blockCarpentersTorch")
AddToSet(NoiseFilter, "ExtraUrilities:magnumTorch")
AddToSet(NoiseFilter, "GalacticraftCore:tile.glowstoneTorch")
AddToSet(NoiseFilter, "PassiveTorch:torch")
AddToSet(NoiseFilter, "PorjectE:interdiction_torch")
AddToSet(NoiseFilter, "arsmagica2:VinteumTorch")
AddToSet(NoiseFilter, "chisel:torch1")
AddToSet(NoiseFilter, "chisel:torch2")
AddToSet(NoiseFilter, "chisel:torch3")
AddToSet(NoiseFilter, "chisel:torch4")
AddToSet(NoiseFilter, "chisel:torch5")
AddToSet(NoiseFilter, "chisel:torch6")
AddToSet(NoiseFilter, "chisel:torch7")
AddToSet(NoiseFilter, "chisel:torch8")
AddToSet(NoiseFilter, "chisel:torch9")
AddToSet(NoiseFilter, "chisel:torch10")

-- INVENTORY ITEMS AND SLOTS
AddToSet(DontDrop, "ComputerCraft:CC-TurtleAdvanced")
AddToSet(DontDrop, "minecraft:torch")
AddToSet(DontDrop, "TConstruct:decoration.stonetorch")
AddToSet(DontDrop, "CarpentersBlocks:blockCarpentersTorch")
AddToSet(DontDrop, "ExtraUrilities:magnumTorch")
AddToSet(DontDrop, "GalacticraftCore:tile.glowstoneTorch")
AddToSet(DontDrop, "PassiveTorch:torch")
AddToSet(DontDrop, "PorjectE:interdiction_torch")
AddToSet(DontDrop, "arsmagica2:VinteumTorch")
AddToSet(DontDrop, "chisel:torch1")
AddToSet(DontDrop, "chisel:torch2")
AddToSet(DontDrop, "chisel:torch3")
AddToSet(DontDrop, "chisel:torch4")
AddToSet(DontDrop, "chisel:torch5")
AddToSet(DontDrop, "chisel:torch6")
AddToSet(DontDrop, "chisel:torch7")
AddToSet(DontDrop, "chisel:torch8")
AddToSet(DontDrop, "chisel:torch9")
AddToSet(DontDrop, "chisel:torch10")

-- TORCHES
AddToSet(Torches, "minecraft:torch")
AddToSet(Torches, "TConstruct:decoration.stonetorch")
AddToSet(Torches, "CarpentersBlocks:blockCarpentersTorch")
AddToSet(Torches, "ExtraUrilities:magnumTorch")
AddToSet(Torches, "GalacticraftCore:tile.glowstoneTorch")
AddToSet(Torches, "PassiveTorch:torch")
AddToSet(Torches, "PorjectE:interdiction_torch")
AddToSet(Torches, "arsmagica2:VinteumTorch")
AddToSet(Torches, "chisel:torch1")
AddToSet(Torches, "chisel:torch2")
AddToSet(Torches, "chisel:torch3")
AddToSet(Torches, "chisel:torch4")
AddToSet(Torches, "chisel:torch5")
AddToSet(Torches, "chisel:torch6")
AddToSet(Torches, "chisel:torch7")
AddToSet(Torches, "chisel:torch8")
AddToSet(Torches, "chisel:torch9")
AddToSet(Torches, "chisel:torch10")

function FindSlot(name)
    for slot = 1,16 do
    	local data = turtle.getItemDetail(slot)
    
        if data then
            if data.name == name then
                return slot
            end
        end
    end
    
    return 0
end

function GetFirst(t, default)
    -- LOCATE FIRST TORCHE AND USE IT
    for slot = 1,16 do
        local data = turtle.getItemDetail(slot)

        if data then
            if SetContains(t, data.name) then
                return data.name
            end
        end
    end
    
    return default
end

function IsInventoryFull()
    for slot = 1,16 do
        if turtle.getItemCount(slot) == 0 then
            return false
        end
    end
    
    return true
end

function Place(direction, slot)
    if direction == Direction.FORWARD then
        turtle.select(slot)
        turtle.place()
        sleep(Yield)
    elseif direction == Direction.UP then
        turtle.select(slot)
        turtle.placeUp()
        sleep(Yield)
    elseif direction == Direction.DOWN then
        turtle.select(slot)
        turtle.placeDown()
        sleep(Yield)
    end
end

function Drop(direction)
   if direction == Direction.FORWARD then
		turtle.drop(64)
	elseif direction == Direction.UP then
		turtle.dropUp(64);
	elseif direction == Direction.DOWN then
		turtle.dropDown(64);
	end
end

function DropAll(direction)
    local SlotFilter = {}
    
    for key, value in pairs(DontDrop) do
        AddToSet(SlotFilter, FindSlot(key))
    end
    
    for slot = 1,16 do
        if not SetContains(SlotFilter, slot) then
            local data = turtle.getItemDetail(slot)

            if data then
                turtle.select(slot)
                Drop(direction)
            end
        end
    end
end

function EmptyInventory(direction)
    local enderSlot = B.FindSlot(EnderChest)
    local hasEnder = enderSlot > 0;

    if hasEnder then
        Place(direction, enderSlot)
        DropAll(direction)
        Dig(direction)
    end
end

function Move(direction)
	if direction == Direction.FORWARD then
		turtle.forward()
		sleep(Yield)
	elseif direction == Direction.BACKWARD then
		turtle.back();
		sleep(Yield)
	elseif direction == Direction.UP then
		turtle.up();
		sleep(Yield)
	elseif direction == Direction.DOWN then
		turtle.down();
		sleep(Yield)
	end
end

function Turn(direction)
	if direction == Direction.LEFT then
		turtle.turnLeft()
		sleep(Yield)
	elseif direction == Direction.RIGHT then
		turtle.turnRight()
		sleep(Yield)
	end
end

function ForceDig(direction)
    if direction == Direction.FORWARD then
        while turtle.detect() do
            if turtle.dig() then
                sleep(Yield)
                if IsInventoryFull() then
                    EmptyInventory(direction)
                end
            end
        end
    elseif direction == Direction.UP then
        while turtle.detectUp() do
            if turtle.digUp() then
                sleep(Yield)
                if IsInventoryFull() then
                    EmptyInventory(direction)
                end
            end
        end
    elseif direction == Direction.DOWN then
        while turtle.detectDown() do
            if turtle.digDown() then
                sleep(Yield)
                if IsInventoryFull() then
                    EmptyInventory(direction)
                end
            end
        end
    end
end

function Dig(direction, filter)
    if filter == nil then filter = false end
    
    if direction == Direction.FORWARD then
        if filter then
            local success, data = turtle.inspect()
            if success then
                if not SetContains(NoiseFilter, data.name) then
                    ForceDig(direction)
                end
            end
        else
            ForceDig(direction)
        end
    elseif direction == Direction.UP then
        if filter then
            local success, data = turtle.inspectUp()
            if success then
                if not SetContains(NoiseFilter, data.name) then
                    ForceDig(direction)
                end
            end
        else
            ForceDig(direction)
        end
    elseif direction == Direction.DOWN then
        if filter then
            local success, data = turtle.inspectDown()
            if success then
                if not SetContains(NoiseFilter, data.name) then
                    ForceDig(direction)
                end
            end
        else
            ForceDig(direction)
        end
    end
end