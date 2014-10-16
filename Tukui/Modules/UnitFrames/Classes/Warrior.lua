local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

TukuiUnitFrames.AddClassFeatures = {}

if (Class ~= "WARRIOR") then
	return
end

TukuiUnitFrames.AddClassFeatures["WARRIOR"] = function(self)
	-- Totem Bar (Demoralizing / Mocking / Skull Banner)
	if (C.UnitFrames.TotemBar) then
		T["Colors"].totems[1] = { 205/255, 92/255, 92/255 }

		local TotemBar = self.Totems
		TotemBar[1]:ClearAllPoints()
		TotemBar[1]:SetAllPoints()

		for i = 2, MAX_TOTEMS do
			TotemBar[i]:Hide()
		end
	end
end