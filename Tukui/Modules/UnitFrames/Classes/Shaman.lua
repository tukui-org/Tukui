local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))
local Movers = T["Movers"]

if (Class ~= "SHAMAN") then
	return
end

UnitFrames.TotemColors = {
	[1] = {.58,.23,.10},
	[2] = {.23,.45,.13},
	[3] = {.19,.48,.60},
	[4] = {.42,.18,.74},
}

UnitFrames.AddClassFeatures["SHAMAN"] = function(self)
	
end
