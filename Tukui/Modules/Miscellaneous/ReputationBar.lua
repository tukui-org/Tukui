local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local Reputation = CreateFrame("Frame", nil, UIParent)
local HideTooltip = GameTooltip_Hide
local Bars = 20
local Colors = FACTION_BAR_COLORS

Reputation.NumBars = 2

function Reputation:SetTooltip()
	if (not GetWatchedFactionInfo()) then
		return
	end

	local Name, ID, Min, Max, Value = GetWatchedFactionInfo()

	if (self == Reputation.RepBar1) then
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", -1, 5)
	else
		GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT", 1, 5)
	end

	GameTooltip:AddLine(string.format("%s (%s)", Name, _G["FACTION_STANDING_LABEL" .. ID]))

	if (Min ~= Max) and (Min >= 0) then
		local Val1 = Value - Min
		local Val2 = Max - Min
		local Val3 = (Value - Min) / (Max - Min) * 100

		GameTooltip:AddLine(Val1 .. " / " .. Val2 .. " (" .. floor(Val3) .. "%)")
	end

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
		local XPBar1 = T.Miscellaneous.Experience.XPBar1
		local XPBar2 = T.Miscellaneous.Experience.XPBar2

		RepBar:SetStatusBarTexture(C.Medias.Normal)
		RepBar:EnableMouse()
		RepBar:SetFrameStrata("BACKGROUND")
		RepBar:SetFrameLevel(5)
		RepBar:CreateBackdrop()
		RepBar:CreateShadow()
		RepBar:SetScript("OnEnter", Reputation.SetTooltip)
		RepBar:SetScript("OnLeave", HideTooltip)
		RepBar:SetSize(i == 1 and T.Chat.Panels.LeftChat:GetWidth() - 2 or T.Chat.Panels.RightChat:GetWidth() - 2, 6)
		RepBar:SetPoint("TOP", i == 1 and T.Chat.Panels.LeftChat or T.Chat.Panels.RightChat, 0, 21)
		RepBar:SetReverseFill(i == 2 and true)
		
		RepBar.Backdrop:SetOutside()
		RepBar.Backdrop:CreateShadow()
		
		RepBar.Backdrop.Shadow:Hide()

		self["RepBar"..i] = RepBar
	end

	self:RegisterEvent("UPDATE_FACTION")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	self:SetScript("OnEvent", self.Update)
end

function Reputation:Enable()
	if not C.Misc.ExperienceEnable then
		return
	end

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
