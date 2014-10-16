local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "MONK") then
	return
end

TukuiUnitFrames.AddClassFeatures["MONK"] = function(self)
	local Harmony = CreateFrame("Frame", nil, self)
	local Shadow = self.Shadow

	-- Harmony Bar
	Harmony:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	Harmony:Size(250, 8)
	Harmony:SetBackdrop(TukuiUnitFrames.Backdrop)
	Harmony:SetBackdropColor(0, 0, 0)
	Harmony:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 6 do
		Harmony[i] = CreateFrame("StatusBar", nil, Harmony)
		Harmony[i]:Height(8)
		Harmony[i]:SetStatusBarTexture(C.Medias.Normal)
	end

	-- Shadow Effect Updates
	Shadow:Point("TOPLEFT", -4, 12)

	-- Totem Bar (Black Ox / Jade Serpent Statue)
	if (C.UnitFrames.TotemBar) then
		T["Colors"].totems[1] = { 95/255, 222/255, 95/255 }

		local TotemBar = self.Totems
		TotemBar:ClearAllPoints()
		TotemBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 10)

		TotemBar[1]:ClearAllPoints()
		TotemBar[1]:SetAllPoints()

		for i = 2, MAX_TOTEMS do
			TotemBar[i]:Hide()
		end

		TotemBar:SetScript("OnShow", function(self)
			TukuiUnitFrames.UpdateShadow(self, 22)
		end)

		TotemBar:SetScript("OnHide", function(self)
			TukuiUnitFrames.UpdateShadow(self, 12)
		end)
	end

	-- Register
	self.HarmonyBar = Harmony
end