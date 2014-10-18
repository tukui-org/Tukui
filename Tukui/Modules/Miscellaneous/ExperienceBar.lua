local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local MaxLevel = MAX_PLAYER_LEVEL
local Experience = CreateFrame("Frame", nil, UIParent)
local HideTooltip = GameTooltip_Hide
local Panels = T["Panels"]
local Bars = 20

Experience.NumBars = 2
Experience.RestedColor = {75/255, 175/255, 76/255}
Experience.XPColor = {0/255, 144/255, 255/255}

function Experience:SetTooltip()
	local Current, Max = Experience:GetExperience()
	local Rested = GetXPExhaustion()
	
	if (self == Experience.XPBar1) then
		Panel = Panels.DataTextLeft
		GameTooltip:SetOwner(Panel, "ANCHOR_TOPLEFT", 0, 5)
	else
		Panel = Panels.DataTextRight
		GameTooltip:SetOwner(Panel, "ANCHOR_TOPRIGHT", 0, 5)
	end
	
	GameTooltip:AddLine(string.format("|cff4BAF4C"..XP..": %d / %d (%d%% - %d/%d)|r", Current, Max, Current / Max * 100, Bars - (Bars * (Max - Current) / Max), Bars))
	
	if Rested then
		GameTooltip:AddLine(string.format("|cff0090FF"..TUTORIAL_TITLE26..": +%d (%d%%)|r", Rested, Rested / Max * 100))
	end
	
	GameTooltip:Show()
end

function Experience:GetExperience()
	return UnitXP("player"), UnitXPMax("player")
end

function Experience:Update(event, owner)
	if (UnitLevel("player") == MaxLevel) then
		self:Disable()
		return
	end
	
	local Current, Max = self:GetExperience()
	local Rested = GetXPExhaustion()
	
	for i = 1, self.NumBars do
		self["XPBar"..i]:SetMinMaxValues(0, Max)
		self["XPBar"..i]:SetValue(Current)
		
		if Rested then
			self["RestedBar"..i]:SetMinMaxValues(0, Max)
			self["RestedBar"..i]:SetValue(Rested + Current)
		end
	end
end

function Experience:Create()
	if (UnitLevel("player") == MaxLevel) then
		return
	end
	
	for i = 1, self.NumBars do
		local XPBar = CreateFrame("StatusBar", nil, UIParent)
		local RestedBar = CreateFrame("StatusBar", nil, UIParent)
		
		XPBar:SetStatusBarTexture(C.Medias.Normal)
		XPBar:SetStatusBarColor(unpack(self.XPColor))
		XPBar:EnableMouse()
		XPBar:CreateBackdrop()
		XPBar:SetScript("OnEnter", Experience.SetTooltip)
		XPBar:SetScript("OnLeave", HideTooltip)
		
		RestedBar:SetStatusBarTexture(C.Medias.Normal)
		RestedBar:SetStatusBarColor(unpack(self.RestedColor))
		RestedBar:SetAllPoints(XPBar)
		RestedBar:SetOrientation(C.Chat.Background and "HORIZONTAL" or "Vertical")
		RestedBar:SetFrameLevel(XPBar:GetFrameLevel() - 1)
		RestedBar:SetAlpha(.5)
		
		if (C.Chat.Background) then
			XPBar:Size(Panels.LeftChatBG:GetWidth() - 4, 6)
			XPBar:Point("BOTTOM", i == 1 and Panels.LeftChatBG or Panels.RightChatBG, "TOP", 0, 4)
			XPBar:SetReverseFill(i == 2 and true)
			RestedBar:SetReverseFill(i == 2 and true)
		else
			XPBar:SetOrientation("Vertical")
			XPBar:Size(Panels.CubeLeft:GetWidth() - 4, Panels.LeftVerticalLine:GetHeight() - Panels.DataTextLeft:GetHeight() - 4)
			XPBar:Point("TOP", i == 1 and Panels.LeftVerticalLine or Panels.RightVerticalLine, "TOP", 0, -Panels.DataTextLeft:GetHeight() / 2)		
		end
		
		self["XPBar"..i] = XPBar
		self["RestedBar"..i] = RestedBar
	end
	
	self:RegisterEvent("PLAYER_XP_UPDATE")
	self:RegisterEvent("PLAYER_LEVEL_UP")
	self:RegisterEvent("UPDATE_EXHAUSTION")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_UPDATE_RESTING")
	
	self:SetScript("OnEvent", self.Update)
end

function Experience:Enable()
	self:Create()
end

function Experience:Disable()
	self:UnregisterAllEvents()
	
	for i = 1, self.NumBars do
		self["XPBar"..i]:Hide()
		self["RestedBar"..i]:Hide()
	end
end

Miscellaneous.Experience = Experience