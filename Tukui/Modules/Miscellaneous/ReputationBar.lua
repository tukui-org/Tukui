local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local Reputation = CreateFrame("Frame", nil, UIParent)
local HideTooltip = GameTooltip_Hide
local Panels = T["Panels"]
local Bars = 20
local Colors = FACTION_BAR_COLORS

Reputation.NumBars = 2

function Reputation:SetTooltip()
	if (not GetWatchedFactionInfo()) then
		return
	end
	
	local Name, ID, Min, Max, Value = GetWatchedFactionInfo()

	if (self == Reputation.RepBar1) then
		GameTooltip:SetOwner(Panels.DataTextLeft, "ANCHOR_TOPLEFT", 0, 5)
	else
		GameTooltip:SetOwner(Panels.DataTextRight, "ANCHOR_TOPRIGHT", 0, 5)
	end
	
	GameTooltip:AddLine(string.format("%s (%s)", Name, _G["FACTION_STANDING_LABEL" .. ID]))
	GameTooltip:AddLine(string.format("%d / %d (%d%%)", Value - Min, Max - Min, (Value - Min) / (Max - Min) * 100))
	GameTooltip:Show()
end

function Reputation:Update()
	if GetWatchedFactionInfo() then
		self:Enable()
	else
		self:Disable()
		
		return
	end
	
	local Name, ID, Min, Max, Value = GetWatchedFactionInfo()
	
	for i = 1, self.NumBars do
		self["RepBar"..i]:SetMinMaxValues(Min, Max)
		self["RepBar"..i]:SetValue(Value)
		self["RepBar"..i]:SetStatusBarColor(Colors[ID].r, Colors[ID].g, Colors[ID].b)
	end
end

function Reputation:Create()
	for i = 1, self.NumBars do
		local RepBar = CreateFrame("StatusBar", nil, UIParent)
		
		RepBar:SetStatusBarTexture(C.Medias.Normal)
		RepBar:EnableMouse()
		RepBar:SetFrameStrata("MEDIUM")
		RepBar:SetFrameLevel(1)
		RepBar:CreateBackdrop()
		RepBar:SetScript("OnEnter", Reputation.SetTooltip)
		RepBar:SetScript("OnLeave", HideTooltip)
		
		if (C.Chat.Background) then
			RepBar:Size(Panels.LeftChatBG:GetWidth() - 4, 6)
			RepBar:Point("BOTTOM", i == 1 and Panels.LeftChatBG or Panels.RightChatBG, "TOP", 0, 4)
			RepBar:SetReverseFill(i == 2 and true)
		else
			RepBar:SetOrientation("Vertical")
			RepBar:Size(Panels.CubeLeft:GetWidth() - 4, Panels.LeftVerticalLine:GetHeight() - Panels.DataTextLeft:GetHeight() - 4)
			RepBar:Point("TOP", i == 1 and Panels.LeftVerticalLine or Panels.RightVerticalLine, "TOP", 0, -Panels.DataTextLeft:GetHeight() / 2)		
		end
		
		self["RepBar"..i] = RepBar
	end
	
	self:RegisterEvent("UPDATE_FACTION")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	
	self:SetScript("OnEvent", self.Update)
end

function Reputation:Enable()
	if not self.IsCreated then
		self:Create()
		
		self.IsCreated = true
	end
	
	for i = 1, self.NumBars do
		if not self["RepBar"..i]:IsShown() then
			self["RepBar"..i]:Show()
		end
	end
end

function Reputation:Disable()
	for i = 1, self.NumBars do
		if self["RepBar"..i]:IsShown() then
			self["RepBar"..i]:Hide()
		end
	end
end

Miscellaneous.Reputation = Reputation