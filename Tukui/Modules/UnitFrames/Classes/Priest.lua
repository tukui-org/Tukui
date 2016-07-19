-- NOTE: Please Fix me - TotemBar Position, when Shadow Orbs Bar is Shown!

local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "PRIEST") then
	return
end

TukuiUnitFrames.AddClassFeatures["PRIEST"] = function(self)

end
