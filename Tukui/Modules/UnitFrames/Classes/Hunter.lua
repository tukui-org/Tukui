local T, C, L = unpack((select(2, ...)))

local UnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "HUNTER") then
	return
end

UnitFrames.AddClassFeatures["HUNTER"] = function(self)

end
