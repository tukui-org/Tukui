local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local Experience = CreateFrame("Frame", nil, UIParent)
local Menu = CreateFrame("Frame", "TukuiExperienceMenu", UIParent, "UIDropDownMenuTemplate")
local HideTooltip = GameTooltip_Hide
local BarSelected
local Bars = 20

Experience.NumBars = 2
Experience.RestedColor = {75 / 255, 175 / 255, 76 / 255}
Experience.XPColor = {0 / 255, 144 / 255, 255 / 255}
Experience.PetXPColor = {255 / 255, 255 / 255, 105 / 255}
Experience.AZColor = {229 / 255, 204 / 255, 127 / 255}
Experience.HNColor = {222 / 255, 22 / 255, 22 / 255}

function Experience:SetTooltip()
	local BarType = self.BarType
	local Current, Max, Pts

	if (self == Experience.XPBar1) then
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", -1, 5)
	else
		GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT", 1, 5)
	end

	if BarType == "XP" then
		local Rested = GetXPExhaustion()
		local IsRested = GetRestState()

		Current, Max = Experience:GetExperience()

		if Max == 0 then
			return
		end

		GameTooltip:AddLine("|cff0090FF"..XP..": " .. Current .. " / " .. Max .. " (" .. floor(Current / Max * 100) .. "% - " .. floor(Bars - (Bars * (Max - Current) / Max)) .. "/" .. Bars .. ")|r")

		if (IsRested == 1 and Rested) then
			GameTooltip:AddLine("|cff4BAF4C"..TUTORIAL_TITLE26..": +" .. Rested .." (" .. floor(Rested / Max * 100) .. "%)|r")
		end
	elseif BarType == "PETXP" then
		Current, Max = GetPetExperience()

		if Max == 0 then
			return
		end

		GameTooltip:AddLine("|cffFFFF66Pet XP: " .. Current .. " / " .. Max .. " (" .. floor(Current / Max * 100) .. "% - " .. floor(Bars - (Bars * (Max - Current) / Max)) .. "/" .. Bars .. ")|r")
	elseif BarType == "AZERITE" then
		Current, Max, Level, Items = Experience:GetAzerite()

		if Max == 0 then
			return
		end

		local RemainingXP = Max - Current
		local AzeriteItem = Item:CreateFromItemLocation(Items)
		local ItemName = AzeriteItem:GetItemName()

		GameTooltip:AddDoubleLine(ItemName..' ('..Level..')', format(ISLANDS_QUEUE_WEEKLY_QUEST_PROGRESS, Current, Max), 0.90, 0.80, 0.50)
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine(AZERITE_POWER_TOOLTIP_BODY:format(ItemName))

		GameTooltip:Show()
	elseif BarType == "REP" then
		local Current, Max = Experience:GetReputation()
		local Name, ID = GetWatchedFactionInfo()
		local Colors = FACTION_BAR_COLORS
		local Hex = T.RGBToHex(Colors[ID].r, Colors[ID].g, Colors[ID].b)
		
		GameTooltip:AddLine(Hex..Name..": " .. Current .. " / " .. Max .. " (" .. floor(Current / Max * 100) .. "% - " .. floor(Bars - (Bars * (Max - Current) / Max)) .. "/" .. Bars .. ")|r")
	else
		local Level = UnitHonorLevel("player")

		Current, Max = Experience:GetHonor()

		if Max == 0 then
			GameTooltip:AddLine(PVP_HONOR_PRESTIGE_AVAILABLE)
			GameTooltip:AddLine(PVP_HONOR_XP_BAR_CANNOT_PRESTIGE_HERE)
		else
			GameTooltip:AddLine("|cffee2222"..HONOR..": " .. Current .. " / " .. Max .. " (" .. floor(Current / Max * 100) .. "% - " .. floor(Bars - (Bars * (Max - Current) / Max)) .. "/" .. Bars .. ")|r")
			GameTooltip:AddLine("|cffcccccc"..RANK..": " .. Level .. "|r")
		end
	end

	GameTooltip:Show()
end

function Experience:GetExperience()
	return UnitXP("player"), UnitXPMax("player")
end

function Experience:GetAzerite()
	local AzeriteItems = C_AzeriteItem.FindActiveAzeriteItem()
	local XP, TotalXP = C_AzeriteItem.GetAzeriteItemXPInfo(AzeriteItems)
	local Level = C_AzeriteItem.GetPowerLevel(AzeriteItems)

	return XP, TotalXP, Level, AzeriteItems
end

function Experience:GetHonor()
	return UnitHonor("player"), UnitHonorMax("player")
end

function Experience:GetReputation()
	local Name, ID, Min, Max, Value = GetWatchedFactionInfo()
	
	return Value, Max
end

function Experience:Update()
	local PlayerLevel = UnitLevel("player")
	local Current, Max
	local Rested = GetXPExhaustion()
	local IsRested = GetRestState()

	for i = 1, self.NumBars do
		local Bar = self["XPBar"..i]
		local RestedBar = self["RestedBar"..i]
		local r, g, b
		local BarType = Bar.BarType

		if BarType == "HONOR" then
			Current, Max = self:GetHonor()
		elseif BarType == "PETXP" then
			Current, Max = GetPetExperience()
		elseif BarType == "AZERITE" then
			Current, Max = self:GetAzerite()
		elseif BarType == "REP" then
			Current, Max = self:GetReputation()
		else
			Current, Max = self:GetExperience()
		end

		Bar:SetMinMaxValues(0, Max)
		Bar:SetValue(Current)

		if (BarType == "XP" and IsRested == 1 and Rested) then
			RestedBar:Show()
			RestedBar:SetMinMaxValues(0, Max)
			RestedBar:SetValue(Rested + Current)
		else
			RestedBar:Hide()
		end

		if BarType == "XP" then
			r, g, b = unpack(self.XPColor)
		elseif BarType == "PETXP" then
			r, g, b = unpack(self.PetXPColor)
		elseif BarType == "AZERITE" then
			r, g, b = unpack(self.AZColor)
		elseif BarType == "REP" then
			local Colors = FACTION_BAR_COLORS
			local ID = select(2, GetWatchedFactionInfo())
			
			r, g, b = Colors[ID].r, Colors[ID].g, Colors[ID].b
		else
			r, g, b = unpack(self.HNColor)
		end

		Bar:SetStatusBarColor(r, g, b)
	end
end

Experience.Menu = {
	{
		text = XP,
		func = function()
			BarSelected.BarType = "XP"
			
			Experience:Update()
		end,
		notCheckable = true
	},
	{
		text = HONOR,
		func = function()
			BarSelected.BarType = "HONOR"
			
			Experience:Update()
		end,
		notCheckable = true
	},
	{
		text = "Azerite",
		func = function()
			local AzeriteItem = C_AzeriteItem.FindActiveAzeriteItem()
			local InstanceType = select(2, IsInInstance())
			
			if AzeriteItem and InstanceType ~= "pvp" and InstanceType ~= "arena" then
				BarSelected.BarType = "AZERITE"

				Experience:Update()
			else
				T.Print("You currently don't have any item with azerith at the moment")
			end
		end,
		notCheckable = true
	},
	{
		text = PET.." "..XP,
		func = function()
			local HavePetXP = select(2, HasPetUI())
			
			if HavePetXP then
				BarSelected.BarType = "PETXP"

				Experience:Update()
			else
				T.Print("You don't have any pet with experience at the moment")
			end
		end,
		notCheckable = true
	},
	{
		text = REPUTATION,
		func = function()
			local IsTracked = GetWatchedFactionInfo()
			
			if IsTracked then
				BarSelected.BarType = "REP"
			
				Experience:Update()
			else
				T.Print("You don't have any reputation tracking enabled at the moment")
			end
		end,
		notCheckable = true
	},
}


function Experience:DisplayMenu()
	BarSelected = self
	
	EasyMenu(Experience.Menu, Menu, "cursor", 0, 0, "MENU")
end

function Experience:Create()
	for i = 1, self.NumBars do
		local XPBar = CreateFrame("StatusBar", "TukuiExperienceBar" .. i, UIParent)
		local RestedBar = CreateFrame("StatusBar", nil, XPBar)
		
		XPBar:SetStatusBarTexture(C.Medias.Normal)
		XPBar:EnableMouse()
		XPBar:SetFrameStrata("BACKGROUND")
		XPBar:SetFrameLevel(3)
		XPBar:CreateBackdrop()
		XPBar:SetScript("OnEnter", Experience.SetTooltip)
		XPBar:SetScript("OnLeave", HideTooltip)
		XPBar:SetScript("OnMouseUp", Experience.DisplayMenu)

		RestedBar:SetStatusBarTexture(C.Medias.Normal)
		RestedBar:SetFrameStrata("BACKGROUND")
		RestedBar:SetStatusBarColor(unpack(self.RestedColor))
		RestedBar:SetAllPoints(XPBar)
		RestedBar:SetOrientation("HORIZONTAL")
		RestedBar:SetFrameLevel(XPBar:GetFrameLevel() - 1)
		RestedBar:SetAlpha(.5)
		RestedBar:SetReverseFill(i == 2 and true)

		XPBar:SetSize(i == 1 and T.Chat.Panels.LeftChat:GetWidth() - 2 or T.Chat.Panels.RightChat:GetWidth() - 2, 6)
		XPBar:SetPoint("TOP", i == 1 and T.Chat.Panels.LeftChat or T.Chat.Panels.RightChat, 0, 10)
		XPBar:SetReverseFill(i == 2 and true)

		XPBar.Backdrop:SetFrameLevel(XPBar:GetFrameLevel() - 2)
		XPBar.Backdrop:SetOutside()
		XPBar.Backdrop:CreateShadow()
		
		if i == 1 then
			XPBar.BarType = "XP"
		else
			XPBar.BarType = "HONOR"
		end

		self["XPBar"..i] = XPBar
		self["RestedBar"..i] = RestedBar

		-- Add moving
		T.Movers:RegisterFrame(XPBar)
	end

	self:RegisterEvent("PLAYER_XP_UPDATE")
	self:RegisterEvent("PLAYER_LEVEL_UP")
	self:RegisterEvent("UPDATE_EXHAUSTION")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_UPDATE_RESTING")
	self:RegisterEvent("HONOR_XP_UPDATE")
	self:RegisterEvent("HONOR_LEVEL_UPDATE")
	self:RegisterEvent("AZERITE_ITEM_EXPERIENCE_CHANGED")
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	self:RegisterEvent("PLAYER_MONEY")
	self:RegisterEvent("UNIT_PET")
	self:RegisterEvent("UNIT_PET_EXPERIENCE")

	self:SetScript("OnEvent", self.Update)
end

function Experience:Enable()
	if not C.Misc.ExperienceEnable then
		return
	end

	if not self.XPBar1 then
		self:Create()
	end

	for i = 1, self.NumBars do
		if not self["XPBar"..i]:IsShown() then
			self["XPBar"..i]:Show()
		end

		if not self["RestedBar"..i]:IsShown() then
			self["RestedBar"..i]:Show()
		end
	end
end

function Experience:Disable()
	for i = 1, self.NumBars do
		if self["XPBar"..i]:IsShown() then
			self["XPBar"..i]:Hide()
		end

		if self["RestedBar"..i]:IsShown() then
			self["RestedBar"..i]:Hide()
		end
	end
end

Miscellaneous.Experience = Experience
