local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))
local Movers = T["Movers"]

if (Class ~= "SHAMAN") then
	return
end

TukuiUnitFrames.AddClassFeatures["SHAMAN"] = function(self)

end
