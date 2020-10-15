local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "DRUID") then
	return
end

UnitFrames.AddClassFeatures["DRUID"] = function(self)
	local HealthTexture = T.GetTexture(C["Textures"].UFHealthTexture)
	local AdditionalPower = CreateFrame("StatusBar", self:GetName().."AdditionalPower", self.Health)
	
	AdditionalPower:SetHeight(6)
	AdditionalPower:SetPoint("BOTTOMLEFT", self.Health, "BOTTOMLEFT")
	AdditionalPower:SetPoint("BOTTOMRIGHT", self.Health, "BOTTOMRIGHT")
	AdditionalPower:SetStatusBarTexture(HealthTexture)
	AdditionalPower:SetFrameLevel(self.Health:GetFrameLevel() + 1)
	AdditionalPower:CreateBackdrop()
	AdditionalPower:SetStatusBarColor(unpack(T.Colors.power.MANA))
	AdditionalPower.Backdrop:SetOutside()

	AdditionalPower.Background = AdditionalPower:CreateTexture(nil, "ARTWORK")
	AdditionalPower.Background:SetAllPoints(AdditionalPower)
	AdditionalPower.Background:SetTexture(HealthTexture)
	AdditionalPower.Background:SetColorTexture(T.Colors.power.MANA[1], T.Colors.power.MANA[2], T.Colors.power.MANA[3], C.UnitFrames.StatusBarBackgroundMultiplier / 100)

	-- Register it with oUF
	self.AdditionalPower = AdditionalPower
end
