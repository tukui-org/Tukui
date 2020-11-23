local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "DEATHKNIGHT") then
	return
end

UnitFrames.AddClassFeatures["DEATHKNIGHT"] = function(self)
	if not C.UnitFrames.ClassBar then
		return
	end
	
	local RunesBar = CreateFrame("Frame", self:GetName().."RuneBar", self.Health)
	local PowerTexture = T.GetTexture(C["Textures"].UFPowerTexture)

	-- Runes
	RunesBar:SetFrameLevel(self.Health:GetFrameLevel() + 1)
	RunesBar:SetHeight(6)
	RunesBar:SetPoint("BOTTOMLEFT", self.Health)
	RunesBar:SetPoint("BOTTOMRIGHT", self.Health)
	
	RunesBar:CreateBackdrop()
	RunesBar.Backdrop:SetOutside()

	for i = 1, 6 do
		RunesBar[i] = CreateFrame("StatusBar", self:GetName().."Rune"..i, RunesBar)
		RunesBar[i]:SetHeight(4)
		RunesBar[i]:SetStatusBarTexture(PowerTexture)
		RunesBar[i]:SetStatusBarColor(self.Power:GetStatusBarColor())

		RunesBar[i].bg = RunesBar[i]:CreateTexture(nil, "BACKGROUND")
		RunesBar[i].bg:SetAllPoints(RunesBar[i])
		RunesBar[i].bg:SetTexture(PowerTexture)
		RunesBar[i].bg:SetAlpha(0.4)

		if i == 1 then
			RunesBar[i]:SetWidth(250 / 6)
			RunesBar[i]:SetPoint("LEFT", RunesBar, "LEFT", 0, 0)
		else
			RunesBar[i]:SetWidth((250 / 6) - 1)
			RunesBar[i]:SetPoint("LEFT", RunesBar[i-1], "RIGHT", 1, 0)
		end
	end

	RunesBar.PostUpdate = UnitFrames.RunesPostUpdate
	RunesBar.colorSpec = true

	-- Register
	self.Runes = RunesBar
end
