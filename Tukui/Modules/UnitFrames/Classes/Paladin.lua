local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "PALADIN") then
	return
end

TukuiUnitFrames.AddClassFeatures["PALADIN"] = function(self)
	local HPBar = CreateFrame("Frame", self:GetName().."HolyPower", self)
	local Shadow = self.Shadow
	local PowerTexture = T.GetTexture(C["Textures"].UFPowerTexture)

	-- Holy Power
	HPBar:SetFrameStrata(self:GetFrameStrata())
	HPBar:SetFrameLevel(self:GetFrameLevel())
	HPBar:SetHeight(8)
	HPBar:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	HPBar:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 0, 1)
	HPBar:SetBackdrop(TukuiUnitFrames.Backdrop)
	HPBar:SetBackdropColor(0, 0, 0)
	HPBar:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 5 do
		HPBar[i] = CreateFrame("StatusBar", self:GetName().."HolyPower"..i, HPBar)
		HPBar[i]:SetHeight(8)
		HPBar[i]:SetStatusBarTexture(PowerTexture)
		HPBar[i]:SetStatusBarColor(0.89, 0.88, 0.06)

		if i == 1 then
			HPBar[i]:SetWidth(50)
			HPBar[i]:SetPoint("LEFT", HPBar, "LEFT", 0, 0)
		else
			HPBar[i]:SetWidth(49)
			HPBar[i]:SetPoint("LEFT", HPBar[i-1], "RIGHT", 1, 0)
		end
	end

	-- Shadow Effect Updates
	HPBar:SetScript("OnShow", function(self)
		TukuiUnitFrames.UpdateShadow(self, 12)
	end)

	HPBar:SetScript("OnHide", function(self)
		TukuiUnitFrames.UpdateShadow(self, 4)
	end)

	-- Register
	self.HolyPower = HPBar
end
