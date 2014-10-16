local T, C, L = select(2, ...):unpack()

local _G = _G
local unpack = unpack
local RaidColors = RAID_CLASS_COLORS
local Tooltip = CreateFrame("Frame")
local gsub, find, format = string.gsub, string.find, string.format
local Noop = function() end
local HealthBar = GameTooltipStatusBar
local CHAT_FLAG_AFK = CHAT_FLAG_AFK
local CHAT_FLAG_DND = CHAT_FLAG_DND
local LEVEL = LEVEL
local PVP_ENABLED = PVP_ENABLED
local BackdropColor = {0, 0, 0}
local Short = T.ShortValue
local ILevel, TalentSpec, LastUpdate = 0, "", 30
local InspectDelay = 0.2
local InspectFreq = 2

Tooltip.ItemRefTooltip = ItemRefTooltip

Tooltip.Tooltips = {
	GameTooltip,
	ItemRefShoppingTooltip1,
	ItemRefShoppingTooltip2,
	ItemRefShoppingTooltip3,
	ShoppingTooltip1,
	ShoppingTooltip2,
	ShoppingTooltip3,
	WorldMapTooltip,
	WorldMapCompareTooltip1,
	WorldMapCompareTooltip2,
	WorldMapCompareTooltip3,
	ItemRefTooltip,
}

Tooltip.Classification = {
	WorldBoss = "|cffAF5050Boss|r",
	RareElite = "|cffAF5050+ Rare|r",
	Elite = "|cffAF5050+|r",
	Rare = "|cffAF5050Rare|r",
}


function Tooltip:CreateAnchor()
	local DataTextRight = T["Panels"].DataTextRight
	local Movers = T["Movers"]
	
	local Anchor = CreateFrame("Frame", "TukuiTooltipAnchor", UIParent)
	Anchor:Size(200, DataTextRight:GetHeight() - 4)
	Anchor:SetFrameStrata("TOOLTIP")
	Anchor:SetFrameLevel(20)
	Anchor:SetClampedToScreen(true)
	Anchor:SetPoint("BOTTOMRIGHT", DataTextRight, 0, 2)
	Anchor:SetMovable(true)
	
	self.Anchor = Anchor
	
	Movers:RegisterFrame(Anchor)
end

function Tooltip:SetTooltipDefaultAnchor()
	local Anchor = Tooltip.Anchor
	
	self:SetOwner(Anchor)
	self:SetAnchorType("ANCHOR_TOPRIGHT", 0, 9)
end

function Tooltip:GetColor(unit)
	if (not unit) then
		return
	end
	
	if (UnitIsPlayer(unit) and not UnitHasVehicleUI(unit)) then
		local Class = select(2, UnitClass(unit))
		local Color = RaidColors[Class]
		
		if (not Color) then
			return
		end
		
		return "|c"..Color.colorStr, Color.r, Color.g, Color.b	
	else
		local Reaction = UnitReaction(unit, "player")
		local Color = T.Colors.reaction[Reaction]
		
		if (not Color) then
			return
		end
		
		local Hex = T.RGBToHex(unpack(Color))
		
		return Hex, Color.r, Color.g, Color.b		
	end
end

function Tooltip:OnTooltipSetUnit()
	local NumLines = self:NumLines()
	local GetMouseFocus = GetMouseFocus()
	local Unit = (select(2, self:GetUnit())) or (GetMouseFocus and GetMouseFocus:GetAttribute("unit"))
	
	if (not Unit) and (UnitExists("mouseover")) then
		Unit = "mouseover"
	end
	
	if (not Unit) then 
		self:Hide() 
		return
	end
	
	if (self:GetOwner() ~= UIParent and C.Tooltips.HideOnUnitFrames) then
		self:Hide()
		return
	end
	
	if (UnitIsUnit(Unit, "mouseover")) then
		Unit = "mouseover"
	end

	local Line1 = GameTooltipTextLeft1
	local Line2 = GameTooltipTextLeft2
	local Race = UnitRace(Unit)
	local Class = UnitClass(Unit)
	local Level = UnitLevel(Unit)
	local Guild = GetGuildInfo(Unit)
	local Name, Realm = UnitName(Unit)
	local CreatureType = UnitCreatureType(Unit)
	local Classification = UnitClassification(Unit)
	local Title = UnitPVPName(Unit)
	local R, G, B = GetQuestDifficultyColor(Level).r, GetQuestDifficultyColor(Level).g, GetQuestDifficultyColor(Level).b
	local Color = Tooltip:GetColor(Unit)
	local Health = UnitHealth(Unit)
	local MaxHealth = UnitHealthMax(Unit)
	
	if (not Color) then
		Color = "|CFFFFFFFF"
	end
	
	if (Title or Name) then
		if Realm then
			Line1:SetFormattedText("%s%s%s", Color, (Title or Name), Realm and Realm ~= "" and " - ".. Realm .."|r" or "|r")
		else
			Line1:SetFormattedText("%s%s%s", Color, (Title or Name), "|r")
		end
	end

	if (UnitIsPlayer(Unit) and UnitIsFriend("Player", Unit)) then
		if (C.Tooltips.ShowSpec) then
			local Talent = T.Tooltips.Talent
			
			ILevel = "..."
			TalentSpec = "..."
			
			if (Unit ~= "player") then
				Talent.CurrentGUID = UnitGUID(Unit)
				Talent.CurrentUnit = Unit
			
				for i, _ in pairs(Talent.Cache) do
					local Cache = Talent.Cache[i]

					if Cache.GUID == Talent.CurrentGUID then
						ILevel = Cache.ItemLevel or "..."
						TalentSpec = Cache.TalentSpec or "..."
						LastUpdate = Cache.LastUpdate and abs(Cache.LastUpdate - floor(GetTime())) or 30
					end
				end	
			
				if (Unit and (CanInspect(Unit))) and (not (InspectFrame and InspectFrame:IsShown())) then
					local LastInspectTime = GetTime() - Talent.LastInspectRequest
				
					Talent.NextUpdate = (LastInspectTime > InspectFreq) and InspectDelay or (InspectFreq - LastInspectTime + InspectDelay)
				
					Talent:Show()
				end
			else
				ILevel = Talent:GetItemLevel("player") or UNKNOWN
				TalentSpec = Talent:GetTalentSpec() or NONE
			end
		end
				
		if (UnitIsAFK(Unit)) then
			self:AppendText((" %s"):format(CHAT_FLAG_AFK))
		elseif UnitIsDND(Unit) then 
			self:AppendText((" %s"):format(CHAT_FLAG_DND))
		end
		
		local Offset = 2
		if Guild then
			Line2:SetFormattedText("%s", IsInGuild() and GetGuildInfo("player") == Guild and "|cff0090ff".. Guild .."|r" or "|cff00ff10".. Guild .."|r")
			Offset = Offset + 1
		end

		for i = Offset, NumLines do
			local Line = _G["GameTooltipTextLeft"..i]
			if (Line:GetText():find("^" .. LEVEL)) then
				if Race then
					Line:SetFormattedText("|cff%02x%02x%02x%s|r %s %s%s", R * 255, G * 255, B * 255, Level > 0 and Level or "??", Race, Color, Class .."|r")
				else
					Line:SetFormattedText("|cff%02x%02x%02x%s|r %s%s", R * 255, G * 255, B * 255, Level > 0 and Level or "??", Color, Class .."|r")
				end
				
				break
			end
		end
	end

	for i = 1, NumLines do
		local Line = _G["GameTooltipTextLeft"..i]
		local Text = Line:GetText()
		
		if (Text and Text == PVP_ENABLED) then
			Line:SetText()
			break
		end
	end
	
	if (UnitExists(Unit .. "target") and Unit ~= "player") then
		local Hex, R, G, B = Tooltip:GetColor(Unit .. "target")
		
		if (not R) and (not G) and (not B) then
			R, G, B = 1, 1, 1
		end
		
		GameTooltip:AddLine(UnitName(Unit .. "target"), R, G, B)
	end
	
	if (C["Tooltips"].UnitHealthText and Health and MaxHealth) then
		HealthBar.Text:SetText(Short(Health) .. " / " .. Short(MaxHealth))
	end
	
	if (C.Tooltips.ShowSpec and UnitIsPlayer(Unit) and UnitIsFriend("Player", Unit)) then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(STAT_AVERAGE_ITEM_LEVEL..": |cff3eea23"..ILevel.."|r")
		GameTooltip:AddLine(SPECIALIZATION..": |cff3eea23"..TalentSpec.."|r")
	end
	
	self.fadeOut = nil
end

function Tooltip:SetColor()
	local GetMouseFocus = GetMouseFocus()
	local Unit = (select(2, self:GetUnit())) or (GetMouseFocus and GetMouseFocus:GetAttribute("unit"))
	
	if (not Unit) and (UnitExists("mouseover")) then
		Unit = 'mouseover'
	end
	
	local Reaction = Unit and UnitReaction(Unit, "player")
	local Player = Unit and UnitIsPlayer(Unit)
	local Tapped = Unit and UnitIsTapped(Unit)
	local PlayerTapped = Unit and UnitIsTappedByPlayer(Unit)
	local Connected = Unit and UnitIsConnected(Unit)
	local Dead = Unit and UnitIsDead(Unit)
	local R, G, B
	
	self:SetBackdropColor(unpack(C["General"].BackdropColor))
	self:SetBackdropBorderColor(0, 0, 0)
	
	if Player then
		local Class = select(2, UnitClass(Unit))
		local Color = T.Colors.class[Class]
		R, G, B = Color[1], Color[2], Color[3]
		
		HealthBar:SetStatusBarColor(R, G, B)
		

		self:SetBackdropBorderColor(R, G, B)
		HealthBar.Backdrop:SetBackdropBorderColor(R, G, B)
	elseif Reaction then
		local Color = T.Colors.reaction[Reaction]
		R, G, B = Color[1], Color[2], Color[3]
		
		HealthBar:SetStatusBarColor(R, G, B)
		

		self:SetBackdropBorderColor(R, G, B)
		HealthBar.Backdrop:SetBackdropBorderColor(R, G, B)
	else
		local Link = select(2, self:GetItem())
		local Quality = Link and select(3, GetItemInfo(Link))
		
		if (Quality and Quality >= 2) then
			R, G, B = GetItemQualityColor(Quality)
			
			self:SetBackdropBorderColor(R, G, B)
		else
			HealthBar:SetStatusBarColor(unpack(C["General"].BorderColor))
			

			self:SetBackdropBorderColor(unpack(C["General"].BorderColor))
			HealthBar.Backdrop:SetBackdropBorderColor(unpack(C["General"].BorderColor))
		end
	end
end

function Tooltip:OnUpdate(elapsed)
	local Red, Green, Blue = self:GetBackdropColor()
	local Owner = self:GetOwner():GetName()
	local Anchor = self:GetAnchorType()
	
	-- This ensures that default anchored world frame tips have the proper color.
	if (Owner == "UIParent" and Anchor == "ANCHOR_CURSOR") and (Red ~= BackdropColor[1] or Green ~= BackdropColor[2] or Blue ~= BackdropColor[3]) then
		BackdropColor[1] = Red
		BackdropColor[2] = Green
		BackdropColor[3] = Blue
		self:SetBackdropColor(unpack(C["General"].BackdropColor))
		self:SetBackdropBorderColor(unpack(C["General"].BorderColor))
	end
end

function Tooltip:Skin()
	if (not self.IsSkinned) then
		self:SetTemplate()
		self.IsSkinned = true
	end

	Tooltip.SetColor(self)
end

function Tooltip:OnTooltipSetItem()
	if (IsShiftKeyDown() or IsAltKeyDown()) then
		local Item, Link = self:GetItem()
		local ItemCount = GetItemCount(Link)
		local ID = "|cFFCA3C3CID|r "..Link:match(":(%w+)")
		local Count = "|cFFCA3C3C"..TOTAL.."|r "..ItemCount
		
		self:AddLine(" ")
		self:AddDoubleLine(Link and Link ~= nil and ID, ItemCount and ItemCount > 1 and Count)
	end
end

function Tooltip:OnValueChanged()
	if (not C["Tooltips"].UnitHealthText) then
		return
	end

	local _, Max = HealthBar:GetMinMaxValues()
	local Value = HealthBar:GetValue()
	
	self.Text:SetText(Short(Value) .. " / " .. Short(Max))
end

function Tooltip:Enable()
	if (not C.Tooltips.Enable) then
		return
	end
	
	self:CreateAnchor()
	hooksecurefunc("GameTooltip_SetDefaultAnchor", self.SetTooltipDefaultAnchor)

	for _, Tooltip in pairs(Tooltip.Tooltips) do
		if Tooltip == GameTooltip then
			Tooltip:HookScript("OnTooltipSetUnit", self.OnTooltipSetUnit)
			Tooltip:HookScript("OnUpdate", self.OnUpdate)
			Tooltip:HookScript("OnTooltipSetItem", self.OnTooltipSetItem)
		end
		
		Tooltip:HookScript("OnShow", self.Skin)
	end
	
	HealthBar:SetStatusBarTexture(T.GetTexture(C["Tooltips"].HealthTexture))
	HealthBar:CreateBackdrop()
	HealthBar:SetScript("OnValueChanged", self.OnValueChanged)
	HealthBar:ClearAllPoints()
	HealthBar:Point("BOTTOMLEFT", HealthBar:GetParent(), "TOPLEFT", 2, 4)
	HealthBar:Point("BOTTOMRIGHT", HealthBar:GetParent(), "TOPRIGHT", -2, 4)
	
	if C["Tooltips"].UnitHealthText then
		HealthBar.Text = HealthBar:CreateFontString(nil, "OVERLAY")
		HealthBar.Text:SetFontObject(T.GetFont(C["Tooltips"].HealthFont))
		HealthBar.Text:SetFont(HealthBar.Text:GetFont(), 12, "THINOUTLINE")
		HealthBar.Text:SetShadowColor(0, 0, 0)
		HealthBar.Text:SetShadowOffset(1.25, -1.25)
		HealthBar.Text:Point("CENTER", HealthBar, "CENTER", 0, 6)
	end
end

T["Tooltips"] = Tooltip
