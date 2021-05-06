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
Experience.AnimaColor = {153 / 255, 204 / 255, 255 / 255}

Experience.Menu = {
	{
		text = XP,
		func = function()
			BarSelected.BarType = "XP"
			
			Experience:Update()
			
			TukuiDatabase.Variables[T.MyRealm][T.MyName].Misc[BarSelected:GetName()] = BarSelected.BarType
		end,
		notCheckable = true
	},
	{
		text = REPUTATION,
		func = function()
			BarSelected.BarType = "REP"
			
			Experience:Update()

			TukuiDatabase.Variables[T.MyRealm][T.MyName].Misc[BarSelected:GetName()] = BarSelected.BarType
		end,
		notCheckable = true,
		disabled = true,
	},
	{
		text = PET.." "..XP,
		func = function()
			BarSelected.BarType = "PETXP"
			
			Experience:Update()

			TukuiDatabase.Variables[T.MyRealm][T.MyName].Misc[BarSelected:GetName()] = BarSelected.BarType
		end,
		notCheckable = true,
		disabled = true,
	},
}

Experience.MenuRetail = {
	{
		text = HONOR,
		func = function()
			BarSelected.BarType = "HONOR"
			
			Experience:Update()

			TukuiDatabase.Variables[T.MyRealm][T.MyName].Misc[BarSelected:GetName()] = BarSelected.BarType
		end,
		notCheckable = true
	},
	{
		text = "Azerite",
		func = function()
			BarSelected.BarType = "AZERITE"
			
			Experience:Update()
            
            TukuiDatabase.Variables[T.MyRealm][T.MyName].Misc[BarSelected:GetName()] = BarSelected.BarType
		end,
		notCheckable = true,
		disabled = true,
	},
	{
		text = "Anima",
		func = function()
			BarSelected.BarType = "ANIMA"
			
			Experience:Update()

			TukuiDatabase.Variables[T.MyRealm][T.MyName].Misc[BarSelected:GetName()] = BarSelected.BarType
		end,
		notCheckable = true,
		disabled = true,
	},
}

Experience.Standing = {
    [0] = UNKNOWN,
    [1] = FACTION_STANDING_LABEL1,
    [2] = FACTION_STANDING_LABEL2,
    [3] = FACTION_STANDING_LABEL3,
    [4] = FACTION_STANDING_LABEL4,
    [5] = FACTION_STANDING_LABEL5,
    [6] = FACTION_STANDING_LABEL6,
    [7] = FACTION_STANDING_LABEL7,
    [8] = FACTION_STANDING_LABEL8,
}

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

		GameTooltip:AddDoubleLine("|cff0090FF"..XP..":|r", Current .. " / " .. Max .. " (" .. floor(Current / Max * 100) .. "%)")

		if (IsRested == 1 and Rested) then
			GameTooltip:AddDoubleLine("|cff4BAF4C"..TUTORIAL_TITLE26..":|r", "+" .. Rested .." (" .. floor(Rested / Max * 100) .. "%)")
		end
	elseif BarType == "ANIMA" then
		Current, Max = Experience:GetAnima()
		
		if Max == 0 then
			return
		end
		
		local Level = C_CovenantSanctumUI.GetRenownLevel()
		
		GameTooltip:AddDoubleLine("|cffFF3333"..COVENANT_SANCTUM_TAB_RENOWN.." "..LEVEL..": ", Level)
		GameTooltip:AddDoubleLine("|cff99CCFF"..ANIMA_DIVERSION_CURRENCY_TOOLTIP_TITLE..": ", Current .. " / " .. Max .. " (" .. floor(Current / Max * 100) .. "%)")
	elseif BarType == "PETXP" then
		Current, Max = GetPetExperience()

		if Max == 0 then
			return
		end

		GameTooltip:AddDoubleLine("|cff0090FF"..PET.." "..XP..":|r", Current .. " / " .. Max .. " (" .. floor(Current / Max * 100) .. "%)")
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
	elseif BarType == "REP" then
		local Current, Max, Standing = Experience:GetReputation()
		local Name, ID = GetWatchedFactionInfo()
		local Colors = FACTION_BAR_COLORS
		local Hex = T.RGBToHex(Colors[ID].r, Colors[ID].g, Colors[ID].b)
		
		GameTooltip:AddLine(Name)
        GameTooltip:AddLine("|cffffffff" .. Current .. " / " .. Max .. "|r")
        GameTooltip:AddLine(Hex .. Standing .. "|r")
	else
		local Level = UnitHonorLevel("player")

		Current, Max = Experience:GetHonor()

		if Max == 0 then
			GameTooltip:AddLine(PVP_HONOR_PRESTIGE_AVAILABLE)
			GameTooltip:AddLine(PVP_HONOR_XP_BAR_CANNOT_PRESTIGE_HERE)
		else
			GameTooltip:AddDoubleLine("|cffee2222"..HONOR..":|r", Current .. " / " .. Max .. " (" .. floor(Current / Max * 100) .. "%)")
			GameTooltip:AddDoubleLine("|cffee2222"..RANK..":|r", Level)
		end
	end

	GameTooltip:Show()
end

function Experience:GetExperience()
	return UnitXP("player"), UnitXPMax("player")
end

function Experience:GetAzerite()
	local AzeriteItems = C_AzeriteItem.FindActiveAzeriteItem()
	local InBank = AzeriteUtil.IsAzeriteItemLocationBankBag(AzeriteItems)
	local XP, TotalXP, Level
	
	if InBank then
		XP, TotalXP = 0, 0
		Level = 0
	else
		XP, TotalXP = C_AzeriteItem.GetAzeriteItemXPInfo(AzeriteItems)
		Level = C_AzeriteItem.GetPowerLevel(AzeriteItems)
	end
	
	return XP, TotalXP, Level, AzeriteItems
end

function Experience:GetHonor()
	return UnitHonor("player"), UnitHonorMax("player")
end

function Experience:GetReputation()
	local Name, Standing, Min, Max, Value, Faction = GetWatchedFactionInfo()
    
    local BarMax = Max - Min
    local BarValue = Value - Min
    local BarStanding = Experience.Standing[Standing]
	
	return BarValue, BarMax, BarStanding
end

function Experience:GetAnima()
	local CurrencyID, MaxDisplayableValue = C_CovenantSanctumUI.GetAnimaInfo()
	local CurrencyInfo = C_CurrencyInfo.GetCurrencyInfo(CurrencyID)
	local Current = CurrencyInfo.quantity 
	local Max = CurrencyInfo.maxQuantity
	
	return Current, Max
end

function Experience:VerifyMenu()
	local AzeriteItem = T.Retail and C_AzeriteItem.FindActiveAzeriteItem()
	local Honor = T.Retail and UnitHonorLevel
	local HavePetXP = select(2, HasPetUI())
	local WatchedFaction = GetWatchedFactionInfo()
	local AnimaCurrency = T.Retail and C_CovenantSanctumUI.GetAnimaInfo()
	local AnimaCurrencyInfo = AnimaCurrency and C_CurrencyInfo.GetCurrencyInfo(AnimaCurrency)
	
	if WatchedFaction then
		Experience.Menu[2].disabled = false
	else
		Experience.Menu[2].disabled = true
	end

	if HavePetXP then
		Experience.Menu[3].disabled = false
	else
		Experience.Menu[3].disabled = true
	end
	
	if T.Retail then
		if Honor then
			Experience.Menu[4].disabled = false
		else
			Experience.Menu[4].disabled = true
		end

		if AzeriteItem then
			Experience.Menu[5].disabled = false
		else
			Experience.Menu[5].disabled = true
		end

		if AnimaCurrency and AnimaCurrencyInfo.quantity ~= 0 and AnimaCurrencyInfo.maxQuantity ~= 0 then
			Experience.Menu[6].disabled = false
		else
			Experience.Menu[6].disabled = true
		end
	end
end

function Experience:Update()
	local Current, Max
	local Rested = GetXPExhaustion()
	local IsRested = GetRestState()
	local AnimaCurrency = T.Retail and C_CovenantSanctumUI.GetAnimaInfo()
	local AnimaCurrencyInfo = AnimaCurrency and C_CurrencyInfo.GetCurrencyInfo(AnimaCurrency)
	local AzeriteItem = T.Retail and C_AzeriteItem.FindActiveAzeriteItem()
	local HavePetXP = select(2, HasPetUI())
	local WatchedFaction = GetWatchedFactionInfo()

	for i = 1, self.NumBars do
		local Bar = self["XPBar"..i]
		local RestedBar = self["RestedBar"..i]
		local R, G, B
		
		if (Bar.BarType == "AZERITE" and not AzeriteItem) or (Bar.BarType == "PETXP" and not HavePetXP) or (Bar.BarType == "REP" and not WatchedFaction) or (Bar.BarType == "ANIMA" and AnimaCurrency and AnimaCurrencyInfo.quantity == 0 and AnimaCurrencyInfo.maxQuantity == 0) then
			Bar.BarType = "XP"
		end

		if Bar.BarType == "HONOR" then
			Current, Max = self:GetHonor()
			
			R, G, B = unpack(self.HNColor)
		elseif Bar.BarType == "ANIMA" then
			Current, Max = Experience:GetAnima()
			
			R, G, B = unpack(self.AnimaColor)
		elseif Bar.BarType == "PETXP" then
			Current, Max = GetPetExperience()
			
			R, G, B = unpack(self.PetXPColor)
		elseif Bar.BarType == "AZERITE" then
			Current, Max = self:GetAzerite()
			
			R, G, B = unpack(self.AZColor)
		elseif Bar.BarType == "REP" then
			Current, Max = self:GetReputation()
			
			local Colors = FACTION_BAR_COLORS
			local ID = select(2, GetWatchedFactionInfo())
			
			R, G, B = Colors[ID].r, Colors[ID].g, Colors[ID].b
		else
			Current, Max = self:GetExperience()
			
			R, G, B = unpack(self.XPColor)
		end

		Bar:SetMinMaxValues(0, Max)
		Bar:SetValue(Current)

		if (Bar.BarType == "XP" and IsRested == 1 and Rested) then
			RestedBar:Show()
			RestedBar:SetMinMaxValues(0, Max)
			RestedBar:SetValue(Rested + Current)
		else
			RestedBar:Hide()
		end

		Bar:SetStatusBarColor(R, G, B)
	end
end

function Experience:DisplayMenu()
	BarSelected = self
	
	Experience:VerifyMenu()
	
	EasyMenu(Experience.Menu, Menu, "cursor", 0, 0, "MENU")
end

function Experience:Create()
	for i = 1, self.NumBars do
		local XPBar = CreateFrame("StatusBar", "TukuiExperienceBar" .. i, UIParent)
		local RestedBar = CreateFrame("StatusBar", nil, XPBar)
		local Data = TukuiDatabase.Variables[T.MyRealm][T.MyName]
		
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
		
		-- Default settings
		if Data.Misc["TukuiExperienceBar" .. i] then
			XPBar.BarType = Data.Misc["TukuiExperienceBar" .. i]
		else
			if i == 1 then
				XPBar.BarType = "XP"
			else
				if i == 2 and T.Retail then
					XPBar.BarType = "HONOR"
				else
					XPBar.BarType = "XP"
				end
			end
		end

		self["XPBar"..i] = XPBar
		self["RestedBar"..i] = RestedBar

		-- Add moving
		T.Movers:RegisterFrame(XPBar, "XP Bar #"..i)
	end

	self:RegisterEvent("PLAYER_XP_UPDATE")
	self:RegisterEvent("UPDATE_FACTION")
	self:RegisterEvent("PLAYER_LEVEL_UP")
	self:RegisterEvent("UPDATE_EXHAUSTION")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_UPDATE_RESTING")
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	self:RegisterEvent("PLAYER_MONEY")
	self:RegisterEvent("UNIT_PET")
	self:RegisterEvent("UNIT_PET_EXPERIENCE")
	self:RegisterEvent("BAG_UPDATE")
	
	if T.Retail then
		self:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
		self:RegisterEvent("HONOR_XP_UPDATE")
		self:RegisterEvent("HONOR_LEVEL_UPDATE")
		self:RegisterEvent("AZERITE_ITEM_EXPERIENCE_CHANGED")
	end

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
	
	if T.Retail then
		for _, Menu in pairs(Experience.MenuRetail) do
			table.insert(Experience.Menu, Menu)
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
