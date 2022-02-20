local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "DRUID") then
	return
end

UnitFrames.AddClassFeatures["DRUID"] = function(self)
	if T.Retail then
		return
	end

	local Texture = T.GetTexture(C["Textures"].UFPowerTexture)
	local DruidMana = CreateFrame("StatusBar", nil, self.Health)
	DruidMana:SetFrameStrata(self.Health:GetFrameStrata())
	DruidMana:SetHeight(self.Power:GetHeight())
	DruidMana:SetPoint("LEFT")
	DruidMana:SetPoint("RIGHT")
	DruidMana:SetPoint("BOTTOM")
	DruidMana:SetStatusBarTexture(Texture)
	DruidMana:SetStatusBarColor(T.Colors.power["MANA"][1], T.Colors.power["MANA"][2], T.Colors.power["MANA"][3])

	DruidMana.bg = DruidMana:CreateTexture(nil, "BACKGROUND")
	DruidMana.bg:SetPoint("LEFT")
	DruidMana.bg:SetPoint("RIGHT")
	DruidMana.bg:SetPoint("BOTTOM")
	DruidMana.bg:SetPoint("TOP", 0, 1)
	DruidMana.bg:SetColorTexture(T.Colors.power["MANA"][1] * .2, T.Colors.power["MANA"][2] * .2, T.Colors.power["MANA"][3] * .2)

	self.DruidMana = DruidMana
end
