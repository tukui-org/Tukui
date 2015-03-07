local T, C, L = select(2, ...):unpack()

local _G = _G
local unpack = unpack
local RaidColors = RAID_CLASS_COLORS
local Tooltip = CreateFrame("Frame")
local gsub, find, format = string.gsub, string.find, string.format
local HealthBar = GameTooltipStatusBar
local CHAT_FLAG_AFK = CHAT_FLAG_AFK
local CHAT_FLAG_DND = CHAT_FLAG_DND
local LEVEL = LEVEL
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

local Classification = {
	worldboss = "|cffAF5050B |r",
	rareelite = "|cffAF5050R+ |r",
	elite = "|cffAF5050+ |r",
	rare = "|cffAF5050R |r",
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

function Tooltip:SetTooltipDefaultAnchor(parent)
	local Anchor = Tooltip.Anchor
	
	if (C.Tooltips.MouseOver) then
		if (parent ~= UIParent) then
			self:SetOwner(Anchor)
			self:SetAnchorType("ANCHOR_TOPRIGHT", 0, 9)
		else
			self:SetOwner(parent, "ANCHOR_CURSOR")
		end	
	else
		self:SetOwner(Anchor)
		self:SetAnchorType("ANCHOR_TOPRIGHT", 0, 9)
	end
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
	local Guild, GuildRankName, _, GuildRealm = GetGuildInfo(Unit)
	local Name, Realm = UnitName(Unit)
	local CreatureType = UnitCreatureType(Unit)
	local CreatureClassification = UnitClassification(Unit)
	local Relationship = UnitRealmRelationship(Unit);
	local Title = UnitPVPName(Unit)
	local Color = Tooltip:GetColor(Unit)
	local R, G, B = GetQuestDifficultyColor(Level).r, GetQuestDifficultyColor(Level).g, GetQuestDifficultyColor(Level).b
	
	if (not Color) then
		Color = "|CFFFFFFFF"
	end
	
	if (UnitIsPlayer(Unit)) then
		if Title then
			Name = Title
		end
				
		if(Realm and Realm ~= "") then
			if IsShiftKeyDown() then
				Name = Name.."-"..Realm
			elseif(Relationship == LE_REALM_RELATION_COALESCED) then
				Name = Name..FOREIGN_SERVER_LABEL
			elseif(Relationship == LE_REALM_RELATION_VIRTUAL) then
				Name = Name..INTERACTIVE_SERVER_LABEL
			end
		end
	end
	
	if Name then
		Line1:SetFormattedText("%s%s%s", Color, Name, "|r")
	end
	
	if (UnitIsPlayer(Unit) and UnitIsFriend("player", Unit)) then
		if (C.Tooltips.ShowSpec and IsAltKeyDown()) then
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
	end
	
	local Offset = 2
	if ((UnitIsPlayer(Unit) and Guild)) then
		if(GuildRealm and IsShiftKeyDown()) then
			Guild = Guild.."-"..GuildRealm
		end
	
		Line2:SetFormattedText("%s", IsInGuild() and GetGuildInfo("player") == Guild and "|cff0090ff".. Guild .."|r" or "|cff00ff10".. Guild .."|r")
		Offset = Offset + 1
	end
	
	for i = Offset, NumLines do
		local Line = _G["GameTooltipTextLeft"..i]
		if (Line:GetText():find("^" .. LEVEL)) then
			if (UnitIsPlayer(Unit) and Race) then
				Line:SetFormattedText("|cff%02x%02x%02x%s|r %s %s%s", R * 255, G * 255, B * 255, Level > 0 and Level or "|cffAF5050??|r", Race, Color, Class .."|r")
			else
				Line:SetFormattedText("|cff%02x%02x%02x%s|r %s%s", R * 255, G * 255, B * 255, Level > 0 and Level or "|cffAF5050??|r", Classification[CreatureClassification] or "", CreatureType or "" .."|r")
			end
			
			break
		end
	end
	
	if (UnitExists(Unit .. "target")) then
		local Hex, R, G, B = Tooltip:GetColor(Unit .. "target")
		
		if (not R) and (not G) and (not B) then
			R, G, B = 1, 1, 1
		end
		
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(UnitName(Unit .. "target"), R, G, B)
	end
	
	if (C["Tooltips"].UnitHealthText and Health and MaxHealth) then
		HealthBar.Text:SetText(Short(Health) .. " / " .. Short(MaxHealth))
	end
	
	if (C.Tooltips.ShowSpec and UnitIsPlayer(Unit) and UnitIsFriend("player", Unit) and IsAltKeyDown()) then
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
	
	self:SetBackdropColor(unpack(C["General"].BackdropColor))
	self:SetBackdropBorderColor(unpack(C["General"].BorderColor))
	
	local Reaction = Unit and UnitReaction(Unit, "player")
	local Player = Unit and UnitIsPlayer(Unit)
	local Tapped = Unit and UnitIsTapped(Unit)
	local PlayerTapped = Unit and UnitIsTappedByPlayer(Unit)
	local QuestMOB = Unit and UnitIsTappedByAllThreatList(Unit)
	local Friend = Unit and UnitIsFriend("player", Unit)
	local R, G, B
	
	if Tapped and not PlayerTapped and not QuestMOB then
		local Color = T.Colors
		
		HealthBar:SetStatusBarColor(unpack(Color.tapped))
		HealthBar.Backdrop:SetBackdropBorderColor(unpack(Color.tapped))
		self:SetBackdropBorderColor(unpack(Color.tapped))
	elseif Player and Friend then
		local Class = select(2, UnitClass(Unit))
		local Color = T.Colors.class[Class]
		
		R, G, B = Color[1], Color[2], Color[3]
		HealthBar:SetStatusBarColor(R, G, B)
		HealthBar.Backdrop:SetBackdropBorderColor(R, G, B)
		self:SetBackdropBorderColor(R, G, B)
	elseif Reaction then
		local Color = T.Colors.reaction[Reaction]
		
		R, G, B = Color[1], Color[2], Color[3]
		HealthBar:SetStatusBarColor(R, G, B)
		HealthBar.Backdrop:SetBackdropBorderColor(R, G, B)
		self:SetBackdropBorderColor(R, G, B)
	else
		local Link = select(2, self:GetItem())
		local Quality = Link and select(3, GetItemInfo(Link))

		if (Quality and Quality >= 2) then
			R, G, B = GetItemQualityColor(Quality)
			self:SetBackdropBorderColor(R, G, B)
		else
			local Color = T.Colors
			
			HealthBar:SetStatusBarColor(unpack(Color.reaction[5]))
			HealthBar.Backdrop:SetBackdropBorderColor(unpack(C["General"].BorderColor))
			self:SetBackdropBorderColor(unpack(C["General"].BorderColor))
		end
	end
end

function Tooltip:OnUpdate(elapsed)
	local Owner = self:GetOwner()

	if (not Owner) then
		return
	end
    
    if (Owner:IsForbidden()) then
        return
    end
	
	local Owner = self:GetOwner():GetName()
	local Anchor = self:GetAnchorType()

	-- This ensures that default anchored world frame tips have the proper color.
	if (Owner == "UIParent" and Anchor == "ANCHOR_CURSOR") then
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
	if IsShiftKeyDown() then
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
	
	local unit = select(2, self:GetParent():GetUnit())
	if(not unit) then
		local GMF = GetMouseFocus()
		if(GMF and GMF:GetAttribute("unit")) then
			unit = GMF:GetAttribute("unit")
		end
	end
	
	local _, Max = HealthBar:GetMinMaxValues()
	local Value = HealthBar:GetValue()
	if (Max == 1) then
		self.Text:Hide()
	else
		self.Text:Show()
	end
	
	if (Value == 0 or (unit and UnitIsDeadOrGhost(unit))) then
		self.Text:SetText(DEAD)
	else
		self.Text:SetText(Short(Value) .. " / " .. Short(Max))
	end
end

function Tooltip:Enable()
	if (not C.Tooltips.Enable) then
		return
	end
	
	self:CreateAnchor()
	
	hooksecurefunc("GameTooltip_SetDefaultAnchor", self.SetTooltipDefaultAnchor)
	
	for _, Tooltip in pairs(Tooltip.Tooltips) do
		if Tooltip == GameTooltip then
			Tooltip:HookScript("OnUpdate", self.OnUpdate)
			Tooltip:HookScript("OnTooltipSetUnit", self.OnTooltipSetUnit)
			Tooltip:HookScript("OnTooltipSetItem", self.OnTooltipSetItem)
		end
		
		Tooltip:HookScript("OnShow", self.Skin)
	end
	
	ItemRefCloseButton:SkinCloseButton()
	
	HealthBar:SetScript("OnValueChanged", self.OnValueChanged)
	HealthBar:SetStatusBarTexture(T.GetTexture(C["Tooltips"].HealthTexture))
	HealthBar:CreateBackdrop()
	HealthBar:ClearAllPoints()
	HealthBar:Point("BOTTOMLEFT", HealthBar:GetParent(), "TOPLEFT", 2, 4)
	HealthBar:Point("BOTTOMRIGHT", HealthBar:GetParent(), "TOPRIGHT", -2, 4)
	
	if C["Tooltips"].UnitHealthText then
		HealthBar.Text = HealthBar:CreateFontString(nil, "OVERLAY")
		HealthBar.Text:SetFontObject(T.GetFont(C["Tooltips"].HealthFont))
		HealthBar.Text:Point("CENTER", HealthBar, "CENTER", 0, 6)
	end
end

T["Tooltips"] = Tooltip