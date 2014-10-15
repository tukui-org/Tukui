-- NOTE: Please Fix me - TotemBar Position, when Shadow Orbs Bar is Shown!

local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "PRIEST") then
	return
end

TukuiUnitFrames.AddClassFeatures["PRIEST"] = function(self)
	local SOBar = CreateFrame("Frame", nil, self)
	local Shadow = self.Shadow

	-- Shadow Orbs Bar
	SOBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	SOBar:Size(250, 8)
	SOBar:SetBackdrop(TukuiUnitFrames.Backdrop)
	SOBar:SetBackdropColor(0, 0, 0)
	SOBar:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 5 do
		SOBar[i] = CreateFrame("StatusBar", nil, SOBar)
		SOBar[i]:Height(8)
		SOBar[i]:SetStatusBarTexture(C.Medias.Normal)

		if i == 1 then
			SOBar[i]:Width((250 / 5))
			SOBar[i]:Point("LEFT", SOBar, "LEFT", 0, 0)
		else
			SOBar[i]:Width((250 / 5) - 1)
			SOBar[i]:Point("LEFT", SOBar[i-1], "RIGHT", 1, 0)
		end
	end

	-- Shadow Effect Updates
	SOBar:SetScript("OnShow", function(self)
		TukuiUnitFrames.UpdateShadow(self, 12)
	end)

	SOBar:SetScript("OnHide", function(self)
		TukuiUnitFrames.UpdateShadow(self, 4)
	end)

	-- Register
	self.ShadowOrbsBar = SOBar

	if (C.UnitFrames.WeakBar) then
		-- Weakened Soul Bar
		local WSBar = CreateFrame("StatusBar", nil, self.Power)
		WSBar:SetAllPoints(self.Power)
		WSBar:SetStatusBarTexture(C.Medias.Normal)
		WSBar:GetStatusBarTexture():SetHorizTile(false)
		WSBar:SetBackdrop(TukuiUnitFrames.Backdrop)
		WSBar:SetBackdropColor(unpack(C["General"].BackdropColor))
		WSBar:SetStatusBarColor(0.75, 0.04, 0.04)

		-- Register
		self.WeakenedSoul = WSBar
	end

	-- Totem Bar (Lightwell)
	if (C.UnitFrames.TotemBar) then
		T["Colors"].totems[1] = { 238/255, 221/255,  130/255 }

		local TotemBar = self.Totems
		TotemBar[1]:ClearAllPoints()
		TotemBar[1]:SetAllPoints()

		for i = 2, MAX_TOTEMS do
			TotemBar[i]:Hide()
		end
		
		TotemBar:SetScript("OnShow", TukuiUnitFrames.UpdatePriestClassBars)
		TotemBar:SetScript("OnHide", TukuiUnitFrames.UpdatePriestClassBars)
	end
	
	if (C.UnitFrames.SerendipityBar) then
		local SerendipityBar = CreateFrame("Frame", nil, self)
		SerendipityBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
		SerendipityBar:Width(250)
		SerendipityBar:Height(8)
		SerendipityBar:SetBackdrop(TukuiUnitFrames.Backdrop)
		SerendipityBar:SetBackdropColor(0, 0, 0)

		for i = 1, 2 do
			SerendipityBar[i] = CreateFrame("StatusBar", nil, SerendipityBar)
			SerendipityBar[i]:Height(8)
			SerendipityBar[i]:SetStatusBarTexture(C.Medias.Normal)
			SerendipityBar[i]:Point("LEFT", (i == 1 and SerendipityBar) or (SerendipityBar[i-1]), (i == 1 and "LEFT") or ("RIGHT"), (i == 1 and 0) or 1, 0)
			SerendipityBar[i]:Width((i == 1 and 250 / 2) or (250 / 2 - 1))			
		end
		
		SerendipityBar:SetScript("OnShow", TukuiUnitFrames.UpdatePriestClassBars)
		SerendipityBar:SetScript("OnHide", TukuiUnitFrames.UpdatePriestClassBars)

		self.SerendipityBar = SerendipityBar	
	end
end