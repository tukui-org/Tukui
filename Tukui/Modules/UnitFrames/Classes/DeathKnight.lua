local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "DEATHKNIGHT") then
	return
end

TukuiUnitFrames.AddClassFeatures["DEATHKNIGHT"] = function(self)
	local RunesBar = CreateFrame("Frame", self:GetName().."RuneBar", self)
	local Shadow = self.Shadow
	local PowerTexture = T.GetTexture(C["Textures"].UFPowerTexture)

	-- Runes
	RunesBar:SetFrameStrata(self:GetFrameStrata())
	RunesBar:SetFrameLevel(self:GetFrameLevel())
	RunesBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	RunesBar:Size(250, 8)
	RunesBar:SetBackdrop(TukuiUnitFrames.Backdrop)
	RunesBar:SetBackdropColor(0, 0, 0)
	RunesBar:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 6 do
		RunesBar[i] = CreateFrame("StatusBar", self:GetName().."Rune"..i, RunesBar)
		RunesBar[i]:Height(8)
		RunesBar[i]:SetStatusBarTexture(PowerTexture)
		RunesBar[i]:SetStatusBarColor(self.Power:GetStatusBarColor())
		
		RunesBar[i].bg = RunesBar[i]:CreateTexture(nil, "ARTWORK")
		RunesBar[i].bg:SetAllPoints(RunesBar[i])
		RunesBar[i].bg:SetTexture(PowerTexture)
		RunesBar[i].bg:SetAlpha(0.4)

		if i == 1 then
			RunesBar[i]:Width(40)
			RunesBar[i]:Point("LEFT", RunesBar, "LEFT", 0, 0)
		else
			RunesBar[i]:Width(41)
			RunesBar[i]:Point("LEFT", RunesBar[i-1], "RIGHT", 1, 0)
		end
	end
	
	RunesBar.PostUpdate = TukuiUnitFrames.RunesPostUpdate
	RunesBar.colorSpec = true

	-- Shadow Effect Updates
	Shadow:Point("TOPLEFT", -4, 12)

	-- Register
	self.Runes = RunesBar
end
