local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "HUNTER") then
	return
end

UnitFrames.AddClassFeatures["HUNTER"] = function(self)

end
