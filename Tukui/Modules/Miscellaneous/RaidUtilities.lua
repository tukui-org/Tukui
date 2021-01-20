local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local Movers = T["Movers"]
local RaidUtilities = CreateFrame("Frame", "TukuiRaidUtilities", UIParent)
local PreviousButton
local ButtonSize = 24
local StringSize = 14
local Prefix = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"

local Icons = {
	[1] = {Name = "Star", Icon = Prefix.."1:"..StringSize..":"..StringSize.."|t"},              -- Star
	[2] = {Name = "Circle", Icon = Prefix.."2:"..StringSize..":"..StringSize.."|t"},            -- Circle
	[3] = {Name = "Diamond", Icon = Prefix.."3:"..StringSize..":"..StringSize.."|t"},           -- Diamond
	[4] = {Name = "Triangle", Icon = Prefix.."4:"..StringSize..":"..StringSize.."|t"},          -- Triangle
	[5] = {Name = "Moon", Icon = Prefix.."5:"..StringSize..":"..StringSize.."|t"},              -- Moon
	[6] = {Name = "Square", Icon = Prefix.."6:"..StringSize..":"..StringSize.."|t"},            -- Square
	[7] = {Name = "Cross", Icon = Prefix.."7:"..StringSize..":"..StringSize.."|t"},             -- Cross
	[8] = {Name = "Skull", Icon = Prefix.."8:"..StringSize..":"..StringSize.."|t"},             -- Skull
}

local PassIcon = "|TInterface\\Buttons\\UI-GroupLoot-Pass-Up:"..StringSize..":"..StringSize..":0:0|t"

function RaidUtilities:OnEnter()
	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	GameTooltip:AddLine(self.Tooltip)
	GameTooltip:Show()
end

function RaidUtilities:CreateBasicButton(name, text, tooltip)
	local Button = CreateFrame("Button", name, self, "SecureActionButtonTemplate, UIPanelButtonTemplate")
	
	Button.Tooltip = tooltip
	Button:SetWidth(ButtonSize)
	Button:SetHeight(ButtonSize)
	Button:SetScript("OnEnter", RaidUtilities.OnEnter)
	Button:SetScript("OnLeave", GameTooltip_Hide)
	Button:CreateBackdrop()
	Button:CreateShadow()
	
	Button.Backdrop:SetFrameLevel(Button:GetFrameLevel() + 1)
	Button.Backdrop.Text = Button.Backdrop:CreateFontString(nil, "OVERLAY")
	Button.Backdrop.Text:SetFont(C.Medias.Font, StringSize)
	Button.Backdrop.Text:SetPoint("CENTER", Button.Backdrop, "CENTER", 0, 0)
	Button.Backdrop.Text:SetText(text)
	
	return Button
end

function RaidUtilities:Toggle()
	if InCombatLockdown() then
		T.Print(ERR_NOT_IN_COMBAT)
		
		return
	end
	
	if (self:IsShown()) then
		self:Hide()
	else
		self:Show()
	end
end

function RaidUtilities:Enable()
	self:SetSize((ButtonSize * 11) + (4 * 10), (ButtonSize * 2) + (4 * 1))
	self:SetPoint("BOTTOMRIGHT", -186, 230)
	
	for i = 1, #Icons do
		local Icon = Icons[i].Icon
		local Name = Icons[i].Name
		
		local Button = RaidUtilities:CreateBasicButton(self:GetName().."Button"..i, Icon, Name)
		
		Button:SetAttribute("type", "macro")
		Button:SetAttribute("macrotext", format("/wm %d", i))
		
		if not PreviousButton then
			Button:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
		else
			Button:SetPoint("LEFT", PreviousButton, "RIGHT", 4, 0)
		end
		
		PreviousButton = Button

		local CancelButton = RaidUtilities:CreateBasicButton(self:GetName().."ButtonCancel"..i, PassIcon, "Clear "..Name)
		CancelButton:SetAttribute("type", "macro")
		CancelButton:SetAttribute("macrotext", format("/cwm %d", i))
		CancelButton:SetPoint("TOP", Button, "BOTTOM", 0, -4)
		
		if i == #Icons then
			local CancelAll = RaidUtilities:CreateBasicButton(self:GetName().."ButtonCancelAll", PassIcon, "Clear all world markers")
			CancelAll:SetAttribute("type", "macro")
			CancelAll:SetAttribute("macrotext", "/cwm all")
			CancelAll:SetSize(ButtonSize, ButtonSize + ButtonSize + 4)
			CancelAll:SetPoint("TOPLEFT", PreviousButton, "TOPRIGHT", 4, 0)
			
			local RoleCheck = RaidUtilities:CreateBasicButton(self:GetName().."ButtonRoleCheck", "|TInterface\\LFGFrame\\LFGRole:14:14:0:0:64:16:32:48:0:16|t", "Role check")
			RoleCheck:SetScript("OnClick", InitiateRolePoll)
			RoleCheck:SetSize(ButtonSize, ButtonSize)
			RoleCheck:SetPoint("TOPLEFT", CancelAll, "TOPRIGHT", 4, 0)
			
			local RaidToParty = RaidUtilities:CreateBasicButton(self:GetName().."ButtonRaidToParty", "|TInterface\\GroupFrame\\UI-Group-AssistantIcon:14:14:0:0|t", "Raid to Party")
			RaidToParty:SetScript("OnClick", ConvertToParty)
			RaidToParty:SetSize(ButtonSize, ButtonSize)
			RaidToParty:SetPoint("TOPLEFT", RoleCheck, "TOPRIGHT", 4, 0)
			
			local ReadyCheck = RaidUtilities:CreateBasicButton(self:GetName().."ButtonReadyCheck", "|TInterface\\RaidFrame\\ReadyCheck-Ready:14:14:0:0|t", "Ready Check")
			ReadyCheck:SetScript("OnClick", DoReadyCheck)
			ReadyCheck:SetSize(ButtonSize, ButtonSize)
			ReadyCheck:SetPoint("BOTTOMLEFT", CancelAll, "BOTTOMRIGHT", 4, 0)
			
			local PartyToRaid = RaidUtilities:CreateBasicButton(self:GetName().."ButtonPartyToRaid", "|TInterface\\GroupFrame\\UI-Group-LeaderIcon:14:14:0:0|t", "Party to Raid")
			PartyToRaid:SetScript("OnClick", ConvertToRaid)
			PartyToRaid:SetSize(ButtonSize, ButtonSize)
			PartyToRaid:SetPoint("TOPLEFT", ReadyCheck, "TOPRIGHT", 4, 0)
		end
	end
	
	Movers:RegisterFrame(self, "Raid Utilities")
end

Miscellaneous.RaidUtilities = RaidUtilities