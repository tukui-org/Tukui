-- NOTE : Please Fix me - TotemBar Position, when Arcane Bar is Shown!

local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "MAGE") then
	return
end

TukuiUnitFrames.AddClassFeatures["MAGE"] = function(self)
	local ArcaneChargeBar = CreateFrame("Frame", self:GetName()..'ArcaneChargeBar', self)
	local PowerTexture = T.GetTexture(C["UnitFrames"].PowerTexture)

	-- Arcane Charges
	ArcaneChargeBar:SetFrameStrata(self:GetFrameStrata())
	ArcaneChargeBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	ArcaneChargeBar:Size(250, 8)
	ArcaneChargeBar:SetBackdrop(TukuiUnitFrames.Backdrop)
	ArcaneChargeBar:SetBackdropColor(0, 0, 0)
	ArcaneChargeBar:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 4 do
		ArcaneChargeBar[i] = CreateFrame("StatusBar", self:GetName()..'ArcaneCharge'..i, ArcaneChargeBar)
		ArcaneChargeBar[i]:Height(8)
		ArcaneChargeBar[i]:SetStatusBarTexture(PowerTexture)
		ArcaneChargeBar[i].bg = ArcaneChargeBar[i]:CreateTexture(nil, "ARTWORK")

		if i == 1 then
			ArcaneChargeBar[i]:Width((250 / 4) - 2)
			ArcaneChargeBar[i]:Point("LEFT", ArcaneChargeBar, "LEFT", 0, 0)
		else
			ArcaneChargeBar[i]:Width((250 / 4 - 1))
			ArcaneChargeBar[i]:Point("LEFT", ArcaneChargeBar[i-1], "RIGHT", 1, 0)
		end
	end

	ArcaneChargeBar:SetScript("OnShow", TukuiUnitFrames.UpdateMageClassBars)
	ArcaneChargeBar:SetScript("OnHide", TukuiUnitFrames.UpdateMageClassBars)

	-- Totem Bar (Rune of Power)
	if (C.UnitFrames.TotemBar) then
		T["Colors"].totems = {
			[1] = { 132/255, 112/255, 255/255 },
			[2] = { 132/255, 112/255, 255/255 },
		}

		local TotemBar = self.Totems
		for i = 1, 2 do
			TotemBar[i]:ClearAllPoints()
			TotemBar[i]:Height(8)

			if i == 1 then
				TotemBar[i]:Width((250 / 2) - 1)
				TotemBar[i]:SetPoint("LEFT", TotemBar, "LEFT", 0, 0)
			else
				TotemBar[i]:Width(250 / 2)
				TotemBar[i]:SetPoint("LEFT", TotemBar[i-1], "RIGHT", 1, 0)
			end
		end

		TotemBar[3]:Hide()
		TotemBar[4]:Hide()
		
		TotemBar:SetScript("OnShow", TukuiUnitFrames.UpdateMageClassBars)
		TotemBar:SetScript("OnHide", TukuiUnitFrames.UpdateMageClassBars)
	end

	-- Register
	self.ArcaneChargeBar = ArcaneChargeBar
end