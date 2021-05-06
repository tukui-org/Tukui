local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "MAGE") then
	return
end

UnitFrames.AddClassFeatures["MAGE"] = function(self)
	if not T.Retail or not C.UnitFrames.ClassBar then
		return
	end
	
	local ArcaneChargeBar = CreateFrame("Frame", self:GetName().."ArcaneChargeBar", self.Health)
	local PowerTexture = T.GetTexture(C["Textures"].UFPowerTexture)

	-- Arcane Charges
	ArcaneChargeBar:SetFrameStrata(self:GetFrameStrata())
	ArcaneChargeBar:SetHeight(6)
	ArcaneChargeBar:SetPoint("BOTTOMLEFT", self.Health)
	ArcaneChargeBar:SetPoint("BOTTOMRIGHT", self.Health)
	
	ArcaneChargeBar:CreateBackdrop()
	ArcaneChargeBar.Backdrop:SetOutside()

	for i = 1, 4 do
		ArcaneChargeBar[i] = CreateFrame("StatusBar", self:GetName().."ArcaneCharge"..i, ArcaneChargeBar)
		ArcaneChargeBar[i]:SetHeight(6)
		ArcaneChargeBar[i]:SetStatusBarTexture(PowerTexture)

		if i == 1 then
			ArcaneChargeBar[i]:SetWidth(61)
			ArcaneChargeBar[i]:SetPoint("LEFT", ArcaneChargeBar, "LEFT", 0, 0)
		else
			ArcaneChargeBar[i]:SetWidth(62)
			ArcaneChargeBar[i]:SetPoint("LEFT", ArcaneChargeBar[i-1], "RIGHT", 1, 0)
		end
	end

	-- Register
	self.ArcaneChargeBar = ArcaneChargeBar
end
