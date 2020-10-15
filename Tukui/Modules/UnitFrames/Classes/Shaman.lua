local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))
local Movers = T["Movers"]

if (Class ~= "SHAMAN") then
	return
end

UnitFrames.TotemColors = {
	[1] = {.58,.23,.10},
	[2] = {.23,.45,.13},
	[3] = {.19,.48,.60},
	[4] = {.42,.18,.74},
}

UnitFrames.AddClassFeatures["SHAMAN"] = function(self)
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
