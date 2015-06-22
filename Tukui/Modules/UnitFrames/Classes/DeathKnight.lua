local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "DEATHKNIGHT") then
	return
end

TukuiUnitFrames.AddClassFeatures["DEATHKNIGHT"] = function(self)
	local RunesBar = CreateFrame("Frame", self:GetName()..'RuneBar', self)
	local Shadow = self.Shadow
	local PowerTexture = T.GetTexture(C["UnitFrames"].PowerTexture)

	-- Runes
	RunesBar:SetFrameStrata(self:GetFrameStrata())
	RunesBar:SetFrameLevel(self:GetFrameLevel())
	RunesBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	RunesBar:Size(250, 8)
	RunesBar:SetBackdrop(TukuiUnitFrames.Backdrop)
	RunesBar:SetBackdropColor(0, 0, 0)
	RunesBar:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 6 do
		RunesBar[i] = CreateFrame("StatusBar", self:GetName()..'Rune'..i, RunesBar)
		RunesBar[i]:Height(8)
		RunesBar[i]:SetStatusBarTexture(PowerTexture)

		if i == 1 then
			RunesBar[i]:Width(40)
			RunesBar[i]:Point("LEFT", RunesBar, "LEFT", 0, 0)
		else
			RunesBar[i]:Width(41)
			RunesBar[i]:Point("LEFT", RunesBar[i-1], "RIGHT", 1, 0)
		end
	end

	-- Shadow Effect Updates
	Shadow:Point("TOPLEFT", -4, 12)

	-- Totem Bar (Risen Ally - Raise Dead)
	if (C.UnitFrames.TotemBar) then
		T["Colors"].totems[1] = {0.60, 0.40, 0}

		local TotemBar = self.Totems
		TotemBar:ClearAllPoints()
		TotemBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 10)

		TotemBar[1]:ClearAllPoints()
		TotemBar[1]:SetAllPoints()

		for i = 2, MAX_TOTEMS do
			TotemBar[i]:Hide()
		end

		TotemBar:SetScript("OnShow", function(self)
			TukuiUnitFrames.UpdateShadow(self, 22)
		end)

		TotemBar:SetScript("OnHide", function(self)
			TukuiUnitFrames.UpdateShadow(self, 12)
		end)
	end

	-- Register
	self.Runes = RunesBar
end