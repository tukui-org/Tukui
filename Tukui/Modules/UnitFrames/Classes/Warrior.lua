local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "WARRIOR") then
	return
end

UnitFrames.AddClassFeatures["WARRIOR"] = function(self)

end
