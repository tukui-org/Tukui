local T, C, L = unpack((select(2, ...)))

local UnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "DEMONHUNTER") then
	return
end

UnitFrames.AddClassFeatures["DEMONHUNTER"] = function(self)

end
