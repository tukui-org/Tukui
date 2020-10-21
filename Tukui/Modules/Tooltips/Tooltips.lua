local T, C, L = select(2, ...):unpack()

local Tooltip = T["Tooltips"]
local HealthBar = GameTooltipStatusBar

local Classification = {
	worldboss = "|cffAF5050B |r",
	rareelite = "|cffAF5050R+ |r",
	elite = "|cffAF5050+ |r",
	rare = "|cffAF5050R |r",
}

function Tooltip:CreateAnchor()
	self.Anchor = CreateFrame("Frame", "TukuiTooltipAnchor", UIParent)
	self.Anchor:SetSize(200, 21)
	self.Anchor:SetFrameStrata("TOOLTIP")
	self.Anchor:SetFrameLevel(20)
	self.Anchor:SetClampedToScreen(true)
	self.Anchor:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -28, 211)
	self.Anchor:SetMovable(true)
end

function Tooltip:SetTooltipDefaultAnchor(parent)
	local Anchor = Tooltip.Anchor

	if (C.Tooltips.MouseOver) then
		if (parent ~= UIParent) then
			self:ClearAllPoints()
			self:SetPoint("BOTTOMRIGHT", Anchor, "TOPRIGHT", 0, 9)
		else
			self:SetOwner(parent, "ANCHOR_CURSOR")
		end
	else
		self:ClearAllPoints()
		self:SetPoint("BOTTOMRIGHT", Anchor, "TOPRIGHT", 0, 9)
	end
end

function Tooltip:GetTextColor(unit)
	if (not unit) then
		return
	end

	if (UnitIsPlayer(unit)) then
		local Class = select(2, UnitClass(unit))
		local Color = T.Colors.class[Class]

		if (not Color) then
			return
		end
		
		local Hex = T.RGBToHex(unpack(T.Colors.class[Class]))

		return Hex, Color.r, Color.g, Color.b
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
	local Unit = (select(2, self:GetUnit())) or (GetMouseFocus and GetMouseFocus.GetAttribute and GetMouseFocus:GetAttribute("unit"))

	if (not Unit) and (UnitExists("mouseover")) then
		Unit = "mouseover"
	end

	if (not Unit) then
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
	local Color = Tooltip:GetTextColor(Unit) or "|CFFFFFFFF"
	local R, G, B = GetQuestDifficultyColor(Level).r, GetQuestDifficultyColor(Level).g, GetQuestDifficultyColor(Level).b

	if (UnitIsPlayer(Unit)) then
		if Title then
			Name = Title
		end
	end

	if Name then
		if (UnitIsPlayer(Unit) and Guild) then
			Guild = " |cff00ff00["..Guild.."]|r"
		else
			Guild = ""
		end

		Line1:SetFormattedText("%s%s%s", Color, Name, "|r")
	end

	if (UnitIsPlayer(Unit) and UnitIsFriend("player", Unit)) then
		if (UnitIsAFK(Unit)) then
			self:AppendText((" %s"):format(CHAT_FLAG_AFK))
		elseif UnitIsDND(Unit) then
			self:AppendText((" %s"):format(CHAT_FLAG_DND))
		end
	end

	local Offset = 2

	for i = Offset, NumLines do
		local Line = _G["GameTooltipTextLeft"..i]
		
		if (Line and Line:GetText() and Line:GetText():find("^" .. LEVEL)) then
			if (UnitIsPlayer(Unit) and Race) then
				Line:SetFormattedText("|cff%02x%02x%02x%s|r %s %s%s", R * 255, G * 255, B * 255, Level > 0 and Level or "|cffAF5050??|r", Race, Color, Class .."|r")
			else
				Line:SetFormattedText("|cff%02x%02x%02x%s|r %s%s", R * 255, G * 255, B * 255, Level > 0 and Level or "|cffAF5050??|r", Classification[CreatureClassification] or "", CreatureType or "" .."|r")
			end

			break
		end
	end

	if (UnitExists(Unit .. "target")) then
		local UnitTarget = Unit.."target"
		local Class = select(2, UnitClass(UnitTarget))
		local Reaction = UnitReaction(UnitTarget, "player")
		local R, G, B

		if (UnitIsPlayer(UnitTarget)) then
			R, G, B = unpack(T.Colors.class[Class])
		elseif Reaction then
			R, G, B = unpack(T.Colors.reaction[Reaction])
		else
			R, G, B = 1, 1, 1
		end

		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(UnitName(Unit .. "target"), R, G, B)
	end

	if (C["Tooltips"].UnitHealthText) then
		Tooltip.SetHealthValue(HealthBar, Unit)
	end
end

function Tooltip:SetUnitBorderColor()
	local Unit = self
	local R, G, B
	local GameTooltip = GameTooltip
	
	local Reaction = Unit and UnitReaction(Unit, "player")
	local Player = Unit and UnitIsPlayer(Unit)
	local Friend = Unit and UnitIsFriend("player", Unit)

	if Player and Friend then
		local Class = select(2, UnitClass(Unit))
		local Color = T.Colors.class[Class]

		R, G, B = Color[1], Color[2], Color[3]

		HealthBar:SetStatusBarColor(R, G, B)
		HealthBar.Backdrop:SetBorderColor(R, G, B)

		GameTooltip.Backdrop:SetBorderColor(R, G, B)
	elseif Reaction then
		local Color = T.Colors.reaction[Reaction]

		R, G, B = Color[1], Color[2], Color[3]

		HealthBar:SetStatusBarColor(R, G, B)
		HealthBar.Backdrop:SetBorderColor(R, G, B)

		GameTooltip.Backdrop:SetBorderColor(R, G, B)
	end
end

function Tooltip:Skin(style)
	if (not self.IsSkinned) then
		if self ~= GameTooltipTooltip then
			self:CreateBackdrop()
			self:CreateShadow()
		end
		
		self.IsSkinned = true
	end
	
	local Link = select(2, self:GetItem())
	local R, G, B
	local Backdrop = self.Backdrop
	
	if Backdrop then
		if Link then
			local Quality = select(3, GetItemInfo(Link))

			if Quality then
				R, G, B = GetItemQualityColor(Quality)
			else
				R, G, B = unpack(C["General"].BorderColor)
			end

			Backdrop:SetBorderColor(R, G, B)
		else
			Backdrop:SetBorderColor(unpack(C["General"].BorderColor))
		end
	end
	
	self:ClearBackdrop()
end

function Tooltip:SkinHealthBar()
	HealthBar:SetScript("OnValueChanged", self.OnValueChanged)
	HealthBar:SetStatusBarTexture(T.GetTexture(C["Textures"].TTHealthTexture))
	HealthBar:CreateBackdrop()
	HealthBar:ClearAllPoints()
	HealthBar:SetPoint("BOTTOMLEFT", HealthBar:GetParent(), "TOPLEFT", 0, 4)
	HealthBar:SetPoint("BOTTOMRIGHT", HealthBar:GetParent(), "TOPRIGHT", 0, 4)
	HealthBar.Backdrop:CreateShadow()
	
	if C["Tooltips"].UnitHealthText then
		HealthBar.Text = HealthBar:CreateFontString(nil, "OVERLAY")
		HealthBar.Text:SetFontObject(T.GetFont(C["Tooltips"].HealthFont))
		HealthBar.Text:SetPoint("CENTER", HealthBar, "CENTER", 0, 6)
	end
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

function Tooltip:SetHealthValue(unit)
	if (UnitIsDeadOrGhost(unit)) then
		self.Text:SetText(DEAD)
	else
		local Health, MaxHealth = UnitHealth(unit), UnitHealthMax(unit)
		local String = (Health and MaxHealth and (floor(Health / MaxHealth * 100) .. "%")) or "???"

		self.Text:SetText(String)
	end
end

function Tooltip:OnValueChanged()
	if (not C["Tooltips"].UnitHealthText) then
		return
	end

	local unit = select(2, self:GetParent():GetUnit())

	if (not unit) then
		local GMF = GetMouseFocus()

		if (GMF and GMF.GetAttribute and GMF:GetAttribute("unit")) then
			unit = GMF:GetAttribute("unit")
		end
	end

	if not unit then
		return
	end

	Tooltip.SetHealthValue(HealthBar, unit)
end

function Tooltip:HideInCombat(event)
	if (event == "PLAYER_REGEN_DISABLED" or InCombatLockdown()) then
		GameTooltip_Hide()
	end
end

function Tooltip:SetCompareItemBorderColor(anchorFrame)
	for i = 1, 2 do
		local TT = _G["ShoppingTooltip"..i]

		if TT:IsShown() then
			local FrameLevel = GameTooltip:GetFrameLevel()
			local Item = TT:GetItem()

			if FrameLevel == TT:GetFrameLevel() then
				TT:SetFrameLevel(i + 1)
			end

			if Item then
				local Quality = select(3, GetItemInfo(Item))

				if Quality then
					local R, G, B = GetItemQualityColor(Quality)

					TT.Backdrop:SetBorderColor(R, G, B)
				else
					TT.Backdrop:SetBorderColor(unpack(C["General"].BorderColor))
				end
			end
		end
	end
end

function Tooltip:AddHooks()
	hooksecurefunc("SharedTooltip_SetBackdropStyle", self.Skin)
	hooksecurefunc("GameTooltip_SetDefaultAnchor", self.SetTooltipDefaultAnchor)
	hooksecurefunc("GameTooltip_ShowCompareItem", self.SetCompareItemBorderColor)
	hooksecurefunc("GameTooltip_UnitColor", self.SetUnitBorderColor)

	GameTooltip:HookScript("OnTooltipSetUnit", self.OnTooltipSetUnit)
	GameTooltip:HookScript("OnTooltipSetItem", self.OnTooltipSetItem)
end

function Tooltip:Enable()
	if (not C.Tooltips.Enable) then
		return
	end

	self:CreateAnchor()
	self:AddHooks()
	self:SkinHealthBar()

	--ItemRefCloseButton:SkinCloseButton()

	if C.Tooltips.HideInCombat then
		self:RegisterEvent("PLAYER_REGEN_DISABLED")
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")

		self:SetScript("OnEvent", Tooltip.HideInCombat)
	end

	if C.Tooltips.AlwaysCompareItems then
		SetCVar("alwaysCompareItems", 1)
	else
		SetCVar("alwaysCompareItems", 0)
	end
	
	Tooltip.Skin(GameTooltip)
	
	T.Movers:RegisterFrame(self.Anchor)
end
