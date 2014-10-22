local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "DRUID") then
	return
end

TukuiUnitFrames.AddClassFeatures["DRUID"] = function(self)
	local DruidMana = CreateFrame("StatusBar", nil, self.Health)
	local EclipseBar = CreateFrame("Frame", nil, self)
	local Font = T.GetFont(C["UnitFrames"].Font)

	-- Druid Mana
	DruidMana:Size(C.UnitFrames.Portrait and 214 or 250, 8)
	DruidMana:Point("BOTTOMLEFT", self.Health, "BOTTOMLEFT", 0, 0)
	DruidMana:SetStatusBarTexture(C.Medias.Normal)
	DruidMana:SetStatusBarColor(0.30, 0.52, 0.90)
	DruidMana:SetFrameLevel(self.Health:GetFrameLevel() + 3)
	DruidMana:SetBackdrop(TukuiUnitFrames.Backdrop)
	DruidMana:SetBackdropColor(0, 0, 0)
	DruidMana:SetBackdropBorderColor(0, 0, 0)

	DruidMana.Background = DruidMana:CreateTexture(nil, "BORDER")
	DruidMana.Background:SetAllPoints()
	DruidMana.Background:SetTexture(0.30, 0.52, 0.90, 0.2)

	-- Totem Bar (Wild Mushrooms)
	if (C.UnitFrames.TotemBar) then
		T["Colors"].totems = {
			[1] = { 95/255, 222/255, 95/255 },
			[2] = { 95/255, 222/255, 95/255 },
			[3] = { 95/255, 222/255, 95/255 },
		}

		local TotemBar = self.Totems
		for i = 1, 3 do
			TotemBar[i]:ClearAllPoints()
			TotemBar[i]:Height(8)
			TotemBar[i]:SetStatusBarColor(unpack(T["Colors"].totems[i]))
			
			if i == 1 then
				TotemBar[i]:Width((250 / 3) - 1)
				TotemBar[i]:SetPoint("LEFT", TotemBar, "LEFT", 0, 0)
			else
				TotemBar[i]:Width(250 / 3)
				TotemBar[i]:SetPoint("LEFT", TotemBar[i-1], "RIGHT", 1, 0)
			end
			
			TotemBar[i].OriginalWidth = TotemBar[i]:GetWidth()
		end

		TotemBar[4]:Hide()
		
		TotemBar:SetScript("OnShow", TukuiUnitFrames.UpdateDruidClassBars)
		TotemBar:SetScript("OnHide", TukuiUnitFrames.UpdateDruidClassBars)
	end
	
	EclipseBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	EclipseBar:SetFrameStrata("MEDIUM")
	EclipseBar:SetFrameLevel(8)
	EclipseBar:Size(250, 8)
	EclipseBar:SetBackdrop(TukuiUnitFrames.Backdrop)
	EclipseBar:SetBackdropColor(0, 0, 0)
	EclipseBar:SetBackdropBorderColor(0,0,0,0)
	EclipseBar:Hide()
	
	EclipseBar.LunarBar = CreateFrame("StatusBar", nil, EclipseBar)
	EclipseBar.LunarBar:SetPoint("LEFT", EclipseBar, "LEFT", 0, 0)
	EclipseBar.LunarBar:SetSize(EclipseBar:GetWidth(), EclipseBar:GetHeight())
	EclipseBar.LunarBar:SetStatusBarTexture(C.Medias.Normal)
	EclipseBar.LunarBar:SetStatusBarColor(.50, .52, .70)

	EclipseBar.SolarBar = CreateFrame("StatusBar", nil, EclipseBar)
	EclipseBar.SolarBar:SetPoint("LEFT", EclipseBar.LunarBar:GetStatusBarTexture(), "RIGHT", 0, 0)
	EclipseBar.SolarBar:SetSize(EclipseBar:GetWidth(), EclipseBar:GetHeight())
	EclipseBar.SolarBar:SetStatusBarTexture(C.Medias.Normal)
	EclipseBar.SolarBar:SetStatusBarColor(.80, .82,  .60)
	
	EclipseBar.Text = EclipseBar:CreateFontString(nil, "OVERLAY")
	EclipseBar.Text:SetPoint("TOP", self.Panel)
	EclipseBar.Text:SetPoint("BOTTOM", self.Panel)
	EclipseBar.Text:SetFontObject(Font)
	
	EclipseBar.PostUpdatePower = TukuiUnitFrames.EclipseDirection
	
	EclipseBar:SetScript("OnShow", TukuiUnitFrames.UpdateDruidClassBars)
	EclipseBar:SetScript("OnHide", TukuiUnitFrames.UpdateDruidClassBars)
	
	-- Register
	self.DruidMana = DruidMana
	self.DruidMana.bg = DruidMana.Background
	self.EclipseBar = EclipseBar
end