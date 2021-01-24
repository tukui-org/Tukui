local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local Movers = T["Movers"]
local RaidUtilities = CreateFrame("Frame", "TukuiRaidUtilities", UIParent)
local PreviousButton
local ButtonSize = 24
local StringSize = 14
local Prefix = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"

local Icons = {
	[1] = {Name = "Square", Icon = Prefix.."6:"..StringSize..":"..StringSize.."|t"},            -- Square
	[2] = {Name = "Triangle", Icon = Prefix.."4:"..StringSize..":"..StringSize.."|t"},          -- Triangle
	[3] = {Name = "Diamond", Icon = Prefix.."3:"..StringSize..":"..StringSize.."|t"},           -- Diamond
	[4] = {Name = "Cross", Icon = Prefix.."7:"..StringSize..":"..StringSize.."|t"},             -- Cross
	[5] = {Name = "Star", Icon = Prefix.."1:"..StringSize..":"..StringSize.."|t"},              -- Star
	[6] = {Name = "Circle", Icon = Prefix.."2:"..StringSize..":"..StringSize.."|t"},            -- Circle
	[7] = {Name = "Moon", Icon = Prefix.."5:"..StringSize..":"..StringSize.."|t"},              -- Moon
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
	Button.Backdrop.Text = Button.Backdrop:CreateFontString(nil, "ARTWORK")
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

function RaidUtilities:SetRaidTarget()
	SetRaidTarget("target", self.ID)
end

function RaidUtilities:SetCountdown()
	C_PartyInfo.DoCountdown(10)
end

function RaidUtilities:Disband()
	StaticPopup_Show("DISBAND_RAID")
end

function RaidUtilities:DisplayMessage()
	local Leader = UnitIsGroupLeader("player")
	local Assistant = UnitIsGroupAssistant("player")
	
	if Leader or Assistant then
		local Status = Leader and "leader" or "assistant"
		local InstanceType = select(2, GetInstanceInfo())
		
		if InstanceType ~= "pvp" and InstanceType ~= "arena" then
			T.Print("You are currently a |cff00ff00group " .. Status .. "|r")
			T.Print("You can toggle raid utilities with |cffff8800/tukui ru|r or |cffff8800/tukui markers|r")
			
			-- No need to display this message again
			self:UnregisterEvent("GROUP_ROSTER_UPDATE")
			self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		end
	end
end

function RaidUtilities:Enable()
	self:SetSize(450, (ButtonSize * 2) + (4 * 1))
	self:SetPoint("BOTTOMRIGHT", -40, 229)
	self:SetFrameStrata("BACKGROUND")
	self:Hide()
	
	for i = 1, #Icons do
		local Icon = Icons[i].Icon
		local Name = Icons[i].Name
		
		local Button = RaidUtilities:CreateBasicButton(self:GetName().."Button"..i, Icon, "Put a "..Icon.." on the ground")
		
		Button:SetAttribute("type", "macro")
		Button:SetAttribute("macrotext", format("/wm %d", i))
		
		if not PreviousButton then
			Button:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
		else
			Button:SetPoint("LEFT", PreviousButton, "RIGHT", 4, 0)
		end
		
		PreviousButton = Button
		
		local CancelButton = RaidUtilities:CreateBasicButton(self:GetName().."ButtonCancel"..i, PassIcon, "Clear ground marker "..Icon)
		CancelButton:SetAttribute("type", "macro")
		CancelButton:SetAttribute("macrotext", format("/cwm %d", i))
		CancelButton:SetPoint("TOP", Button, "BOTTOM", 0, -4)
		
		CancelButton.Backdrop.Marker = Button.Backdrop:CreateFontString(nil, "OVERLAY")
		CancelButton.Backdrop.Marker:SetFont(C.Medias.Font, 8)
		CancelButton.Backdrop.Marker:SetPoint("TOPRIGHT", CancelButton.Backdrop, "TOPRIGHT", -3, -3)
		CancelButton.Backdrop.Marker:SetText(Icon)
		
		if i == #Icons then
			local CancelAll = RaidUtilities:CreateBasicButton(self:GetName().."ButtonCancelAll", PassIcon, "Clear all ground markers")
			CancelAll:SetAttribute("type", "macro")
			CancelAll:SetAttribute("macrotext", "/cwm all")
			CancelAll:SetSize(ButtonSize, ButtonSize + ButtonSize + 4)
			CancelAll:SetPoint("TOPLEFT", PreviousButton, "TOPRIGHT", 4, 0)
			
			local RoleCheck = RaidUtilities:CreateBasicButton(self:GetName().."ButtonRoleCheck", "|TInterface\\LFGFrame\\LFGRole:14:14:0:0:64:16:32:48:0:16|t", "Let's do a Role check!")
			RoleCheck:SetScript("OnClick", InitiateRolePoll)
			RoleCheck:SetSize(ButtonSize, ButtonSize)
			RoleCheck:SetPoint("TOPLEFT", CancelAll, "TOPRIGHT", 13, 0)
			
			local Countdown = RaidUtilities:CreateBasicButton(self:GetName().."ButtonCountdown", "|TInterface\\Buttons\\JumpUpArrow:14:14:0:0|t", "Start a 10 second countdown")
			Countdown:SetScript("OnClick", RaidUtilities.SetCountdown)
			Countdown:SetSize(ButtonSize, ButtonSize)
			Countdown:SetPoint("TOPLEFT", RoleCheck, "TOPRIGHT", 4, 0)
			
			local ReadyCheck = RaidUtilities:CreateBasicButton(self:GetName().."ButtonReadyCheck", "|TInterface\\RaidFrame\\ReadyCheck-Ready:14:14:0:0|t", "Let's do a Ready Check!")
			ReadyCheck:SetScript("OnClick", DoReadyCheck)
			ReadyCheck:SetSize(ButtonSize, ButtonSize)
			ReadyCheck:SetPoint("BOTTOMLEFT", CancelAll, "BOTTOMRIGHT", 13, 0)
			
			local Disband = RaidUtilities:CreateBasicButton(self:GetName().."ButtonDisband", "|TInterface\\RaidFrame\\ReadyCheck-NotReady:14:14:0:0|t", "Disband the entire raid")
			Disband:SetScript("OnClick", RaidUtilities.Disband)
			Disband:SetSize(ButtonSize, ButtonSize)
			Disband:SetPoint("TOPLEFT", ReadyCheck, "TOPRIGHT", 4, 0)
			
			local Remove = RaidUtilities:CreateBasicButton(self:GetName().."ButtonTargetRemove", PassIcon, "Remove marker on current target (if any)")
			Remove:SetScript("OnClick", RaidUtilities.SetRaidTarget)
			Remove:SetSize(ButtonSize, ButtonSize + ButtonSize + 4)
			Remove:SetPoint("TOPLEFT", Countdown, "TOPRIGHT", 13, 0)
			Remove.ID = 0
			
			local Star = RaidUtilities:CreateBasicButton(self:GetName().."ButtonTargetStar", Icons[5].Icon, "Set "..Icons[5].Icon.." on current target")
			Star:SetScript("OnClick", RaidUtilities.SetRaidTarget)
			Star:SetSize(ButtonSize, ButtonSize)
			Star:SetPoint("TOPLEFT", Remove, "TOPRIGHT", 4, 0)
			Star.ID = 1
			
			local Circle = RaidUtilities:CreateBasicButton(self:GetName().."ButtonTargetCircle", Icons[6].Icon, "Set "..Icons[6].Icon.." on current target")
			Circle:SetScript("OnClick", RaidUtilities.SetRaidTarget)
			Circle:SetSize(ButtonSize, ButtonSize)
			Circle:SetPoint("TOPLEFT", Star, "TOPRIGHT", 4, 0)
			Circle.ID = 2
			
			local Diamond = RaidUtilities:CreateBasicButton(self:GetName().."ButtonTargetDiamond", Icons[3].Icon, "Set "..Icons[3].Icon.." on current target")
			Diamond:SetScript("OnClick", RaidUtilities.SetRaidTarget)
			Diamond:SetSize(ButtonSize, ButtonSize)
			Diamond:SetPoint("TOPLEFT", Circle, "TOPRIGHT", 4, 0)
			Diamond.ID = 3
			
			local Triangle = RaidUtilities:CreateBasicButton(self:GetName().."ButtonTargetTriangle", Icons[2].Icon, "Set "..Icons[2].Icon.." on current target")
			Triangle:SetScript("OnClick", RaidUtilities.SetRaidTarget)
			Triangle:SetSize(ButtonSize, ButtonSize)
			Triangle:SetPoint("TOPLEFT", Diamond, "TOPRIGHT", 4, 0)
			Triangle.ID = 4
			
			local Moon = RaidUtilities:CreateBasicButton(self:GetName().."ButtonTargetMoon", Icons[7].Icon, "Set "..Icons[7].Icon.." on current target")
			Moon:SetScript("OnClick", RaidUtilities.SetRaidTarget)
			Moon:SetSize(ButtonSize, ButtonSize)
			Moon:SetPoint("BOTTOMLEFT", Remove, "BOTTOMRIGHT", 4, 0)
			Moon.ID = 5
			
			local Square = RaidUtilities:CreateBasicButton(self:GetName().."ButtonTargetSquare", Icons[1].Icon, "Set "..Icons[1].Icon.." on current target")
			Square:SetScript("OnClick", RaidUtilities.SetRaidTarget)
			Square:SetSize(ButtonSize, ButtonSize)
			Square:SetPoint("TOPLEFT", Moon, "TOPRIGHT", 4, 0)
			Square.ID = 6
			
			local Cross = RaidUtilities:CreateBasicButton(self:GetName().."ButtonTargetCross", Icons[4].Icon, "Set "..Icons[4].Icon.." on current target")
			Cross:SetScript("OnClick", RaidUtilities.SetRaidTarget)
			Cross:SetSize(ButtonSize, ButtonSize)
			Cross:SetPoint("TOPLEFT", Square, "TOPRIGHT", 4, 0)
			Cross.ID = 7
			
			local Skull = RaidUtilities:CreateBasicButton(self:GetName().."ButtonTargetSkull", Icons[8].Icon, "Set "..Icons[8].Icon.." on current target")
			Skull:SetScript("OnClick", RaidUtilities.SetRaidTarget)
			Skull:SetSize(ButtonSize, ButtonSize)
			Skull:SetPoint("TOPLEFT", Cross, "TOPRIGHT", 4, 0)
			Skull.ID = 8
		end
	end
	
	self:RegisterEvent("GROUP_ROSTER_UPDATE")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:SetScript("OnEvent", self.DisplayMessage)
	
	Movers:RegisterFrame(self, "Raid Utilities")
end

Miscellaneous.RaidUtilities = RaidUtilities