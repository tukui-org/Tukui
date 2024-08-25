local T, C, L = unpack((select(2, ...)))

local UnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "PALADIN") then
	return
end

UnitFrames.AddClassFeatures["PALADIN"] = function(self)
	if T.Classic or not C.UnitFrames.ClassBar then
		return
	end

	local Bar = CreateFrame("Frame", self:GetName().."HolyPower", self.Health)
	local PowerTexture = T.GetTexture(C["Textures"].UFPowerTexture)
	local numMax = T.Retail and 5 or 3
	local barWidth = 250 / numMax

	-- Holy Power
	Bar:SetFrameLevel(self.Health:GetFrameLevel() + 1)
	Bar:SetHeight(6)
	Bar:SetPoint("BOTTOMLEFT", self.Health)
	Bar:SetPoint("BOTTOMRIGHT", self.Health)

	Bar:CreateBackdrop()
	Bar.Backdrop:SetOutside()

	for i = 1, numMax do
		Bar[i] = CreateFrame("StatusBar", self:GetName().."HolyPower"..i, Bar)
		Bar[i]:SetHeight(6)
		Bar[i]:SetStatusBarTexture(PowerTexture)
		Bar[i]:SetStatusBarColor(0.89, 0.88, 0.06)
		Bar[i]:SetAlpha(0.3)

		if i == 1 then
			Bar[i]:SetWidth(barWidth)
			Bar[i]:SetPoint("LEFT", Bar, "LEFT", 0, 0)
		else
			Bar[i]:SetWidth(barWidth - 1)
			Bar[i]:SetPoint("LEFT", Bar[i-1], "RIGHT", 1, 0)
		end
		
	end

	-- Register
	self.HolyPower = Bar
end
