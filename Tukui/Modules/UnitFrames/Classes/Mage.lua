-- NOTE : Please Fix me - TotemBar Position, when Arcane Bar is Shown!

local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "MAGE") then
	return
end

TukuiUnitFrames.AddClassFeatures["MAGE"] = function(self)
	local ArcaneChargeBar = CreateFrame("Frame", self:GetName().."ArcaneChargeBar", self)
	local PowerTexture = T.GetTexture(C["Textures"].UFPowerTexture)
	local Shadow = self.Shadow

	-- Arcane Charges
	ArcaneChargeBar:SetFrameStrata(self:GetFrameStrata())
	ArcaneChargeBar:SetHeight(8)
	ArcaneChargeBar:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	ArcaneChargeBar:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 0, 1)
	ArcaneChargeBar:SetBackdrop(TukuiUnitFrames.Backdrop)
	ArcaneChargeBar:SetBackdropColor(0, 0, 0)
	ArcaneChargeBar:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 4 do
		ArcaneChargeBar[i] = CreateFrame("StatusBar", self:GetName().."ArcaneCharge"..i, ArcaneChargeBar)
		ArcaneChargeBar[i]:SetHeight(8)
		ArcaneChargeBar[i]:SetStatusBarTexture(PowerTexture)

		if i == 1 then
			ArcaneChargeBar[i]:SetWidth((250 / 4) - 1)
			ArcaneChargeBar[i]:SetPoint("LEFT", ArcaneChargeBar, "LEFT", 0, 0)
		else
			ArcaneChargeBar[i]:SetWidth((250 / 4 - 1))
			ArcaneChargeBar[i]:SetPoint("LEFT", ArcaneChargeBar[i-1], "RIGHT", 1, 0)
		end
	end
	
	-- Shadow Effect Updates
	Shadow:Point("TOPLEFT", -4, 12)
	
	ArcaneChargeBar:SetScript("OnShow", function(self)
		TukuiUnitFrames.UpdateShadow(self, 12)
	end)

	ArcaneChargeBar:SetScript("OnHide", function(self)
		TukuiUnitFrames.UpdateShadow(self, 4)
	end)

	-- Register
	self.ArcaneChargeBar = ArcaneChargeBar
end
