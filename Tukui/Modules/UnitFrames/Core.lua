local T, C, L = select(2, ...):unpack()
local AddOn, Plugin = ...
local oUF = Plugin.oUF or oUF
local Panels = T["Panels"]
local Noop = function() end
local TukuiUnitFrames = CreateFrame("Frame")

-- Lib globals
local strfind = strfind
local format = format
local floor = floor

-- WoW globals (I don't really wanna import all the funcs we use here, so localize the ones called a LOT, like in Health/Power functions)
local UnitIsEnemy = UnitIsEnemy
local UnitIsPlayer = UnitIsPlayer
local UnitIsFriend = UnitIsFriend
local UnitIsConnected = UnitIsConnected
local UnitPlayerControlled = UnitPlayerControlled
local UnitIsGhost = UnitIsGhost
local UnitIsDead = UnitIsDead
local UnitPowerType = UnitPowerType
local Class = select(2, UnitClass("player"))

TukuiUnitFrames.Units = {}
TukuiUnitFrames.Headers = {}
TukuiUnitFrames.Framework = TukuiUnitFrameFramework

TukuiUnitFrames.RaidBuffsTracking = {
	PRIEST = {
		{6788, "TOPRIGHT", {1, 0, 0}, true},	  -- Weakened Soul
		{33076, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},  -- Prayer of Mending
		{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}},     -- Renew
		{17, "TOPLEFT", {0.81, 0.85, 0.1}, true}, -- Power Word: Shield
	},
	DRUID = {
		{774, "TOPLEFT", {0.8, 0.4, 0.8}},      -- Rejuvenation
		{8936, "TOPRIGHT", {0.2, 0.8, 0.2}},    -- Regrowth
		{33763, "BOTTOMLEFT", {0.4, 0.8, 0.2}}, -- Lifebloom
		{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}},  -- Wild Growth
	},
	PALADIN = {
		{53563, "TOPRIGHT", {0.7, 0.3, 0.7}},	        -- Beacon of Light
		{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true}, 	-- Hand of Protection
		{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},	-- Hand of Freedom
		{1038, "BOTTOMRIGHT", {0.93, 0.75, 0}, true},	-- Hand of Salvation
		{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},	-- Hand of Sacrifice
		{114163, "TOPLEFT", {0.81, 0.85, 0.1}, true},	-- Eternal Flame
		{20925, "TOPLEFT", {0.81, 0.85, 0.1}, true},	-- Sacred Shield
	},
	SHAMAN = {
		{61295, "TOPLEFT", {0.7, 0.3, 0.7}},     -- Riptide
		{974, "TOPRIGHT", {0.2, 0.7, 0.2}},      -- Earth Shield
	},
	MONK = {
		{119611, "TOPLEFT", {0.8, 0.4, 0.8}},	 -- Renewing Mist
		{116849, "TOPRIGHT", {0.2, 0.8, 0.2}},	 -- Life Cocoon
		{124682, "BOTTOMLEFT", {0.4, 0.8, 0.2}}, -- Enveloping Mist
		{124081, "BOTTOMRIGHT", {0.7, 0.4, 0}},  -- Zen Sphere
	},
	ALL = {
		{14253, "RIGHT", {0, 1, 0}}, -- Abolish Poison
	},
}

TukuiUnitFrames.RaidBuffsTrackingPosition = {
	TOPLEFT = {6, 1},
	TOPRIGHT = {-6, 1},
	BOTTOMLEFT = {6, 1},
	BOTTOMRIGHT = {-6, 1},
	LEFT = {6, 1},
	RIGHT = {-6, 1},
	TOP = {0, 0},
	BOTTOM = {0, 0},
}

function TukuiUnitFrames:DisableBlizzard()
	for i = 1, MAX_BOSS_FRAMES do
		local Boss = _G["Boss"..i.."TargetFrame"]
		local Health = _G["Boss"..i.."TargetFrame".."HealthBar"]
		local Power = _G["Boss"..i.."TargetFrame".."ManaBar"]
		
		Boss:UnregisterAllEvents()
		Boss.Show = Noop
		Boss:Hide()
		
		Health:UnregisterAllEvents()
		Power:UnregisterAllEvents()
	end
	
	if C["Raid"].Enable then
		InterfaceOptionsFrameCategoriesButton11:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton11:SetAlpha(0)
		
		CompactRaidFrameManager:SetParent(Panels.Hider)
		CompactUnitFrameProfiles:UnregisterAllEvents()
		
		for i = 1, MAX_PARTY_MEMBERS do
			local PartyMember = _G["PartyMemberFrame" .. i]
			local Health = _G["PartyMemberFrame" .. i .. "HealthBar"]
			local Power = _G["PartyMemberFrame" .. i .. "ManaBar"]
			local Pet = _G["PartyMemberFrame" .. i .."PetFrame"]
			local PetHealth = _G["PartyMemberFrame" .. i .."PetFrame" .. "HealthBar"]
			
			PartyMember:UnregisterAllEvents()
			PartyMember:SetParent(Panels.Hider)
			PartyMember:Hide()
			Health:UnregisterAllEvents()
			Power:UnregisterAllEvents()
			
			Pet:UnregisterAllEvents()
			Pet:SetParent(Panels.Hider)
			PetHealth:UnregisterAllEvents()
			
			HidePartyFrame()
			ShowPartyFrame = Noop
			HidePartyFrame = Noop
		end
	end
	
	InterfaceOptionsFrameCategoriesButton9:SetHeight(0.00001)
	InterfaceOptionsFrameCategoriesButton9:SetAlpha(0)
	InterfaceOptionsFrameCategoriesButton10:SetHeight(0.00001)
	InterfaceOptionsFrameCategoriesButton10:SetAlpha(0)
end

function TukuiUnitFrames:ShortValue()
	if self <= 999 then
		return self
	end

	local Value

	if self >= 1000000 then
		Value = format("%.1fm", self/1000000)
		return Value
	elseif self >= 1000 then
		Value = format("%.1fk", self/1000)
		return Value
	end
end

function TukuiUnitFrames:UTF8Sub(i, dots)
	if not self then return end

	local Bytes = self:len()
	if (Bytes <= i) then
		return self
	else
		local Len, Pos = 0, 1
		while(Pos <= Bytes) do
			Len = Len + 1
			local c = self:byte(Pos)
			if (c > 0 and c <= 127) then
				Pos = Pos + 1
			elseif (c >= 192 and c <= 223) then
				Pos = Pos + 2
			elseif (c >= 224 and c <= 239) then
				Pos = Pos + 3
			elseif (c >= 240 and c <= 247) then
				Pos = Pos + 4
			end
			if (Len == i) then break end
		end

		if (Len == i and Pos <= Bytes) then
			return self:sub(1, Pos - 1)..(dots and "..." or "")
		else
			return self
		end
	end
end

function TukuiUnitFrames:MouseOnPlayer()
	local Status = self.Status
	local MouseOver = GetMouseFocus()

	if (MouseOver == self) then
		Status:Show()

		if (UnitIsPVP("player")) then
			Status:SetText("PVP")
		end
	else
		Status:Hide()
		Status:SetText()
	end
end

function TukuiUnitFrames:UpdateShadow(height)
	local Frame = self:GetParent()
	local Shadow = Frame.Shadow
	
	if not Shadow then
		return
	end
	
	Shadow:Point("TOPLEFT", -4, height)
end

function TukuiUnitFrames:UpdateBuffsHeaderPosition(height)
	local Frame = self:GetParent()
	local Buffs = Frame.Buffs

	if not Buffs then
		return
	end

	Buffs:ClearAllPoints() 
	Buffs:Point("BOTTOMLEFT", Frame, "TOPLEFT", 0, height)
end

function TukuiUnitFrames:UpdateDebuffsHeaderPosition()
	local NumBuffs = self.visibleBuffs
	local PerRow = self.numRow
	local Size = self.size
	local Row = math.ceil((NumBuffs / PerRow))
	local Parent = self:GetParent()
	local Debuffs = Parent.Debuffs
	local Y = Size * Row
	local Addition = Size
	
	if NumBuffs == 0 then
		Addition = 0
	end
	
	Debuffs:ClearAllPoints() 
	Debuffs:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", -2, Y + Addition)
end

function TukuiUnitFrames:CustomCastTimeText(duration)
	local Value = format("%.1f / %.1f", self.channeling and duration or self.max - duration, self.max)

	self.Time:SetText(Value)
end

function TukuiUnitFrames:CustomCastDelayText(duration)
	local Value = format("%.1f |cffaf5050%s %.1f|r", self.channeling and duration or self.max - duration, self.channeling and "- " or "+", self.delay)

	self.Time:SetText(Value)
end

function TukuiUnitFrames:CheckInterrupt(unit)
	if (unit == "vehicle") then
		unit = "player"
	end

	if (self.interrupt and UnitCanAttack("player", unit)) then
		self:SetStatusBarColor(1, 0, 0, 0.5)
	else
		self:SetStatusBarColor(0.31, 0.45, 0.63, 0.5)
	end
end

function TukuiUnitFrames:CheckCast(unit, name, rank, castid)
	TukuiUnitFrames.CheckInterrupt(self, unit)
end

function TukuiUnitFrames:CheckChannel(unit, name, rank)
	TukuiUnitFrames.CheckInterrupt(self, unit)
end

function TukuiUnitFrames:UpdateNamePosition()
	if (self.Power.Value:GetText() and UnitIsEnemy("player", "target")) then
		self.Name:ClearAllPoints()
		self.Name:SetPoint("CENTER", self.Panel, "CENTER", 0, 0)
	else
		self.Name:ClearAllPoints()
		self.Power.Value:SetAlpha(0)
		self.Name:SetPoint("LEFT", self.Panel, "LEFT", 4, 0)
	end
end

function TukuiUnitFrames:UpdateThreat(event, unit)
	if (not unit) or (not C.UnitFrames.Threat) then
		return
	end

	local Colors = T["Colors"]
	local Status = UnitThreatSituation(unit)
	local Health = self.Health
	local Class = select(2, UnitClass(unit))
	local Color = not UnitIsPlayer(unit) and Colors.reaction[5] or C["UnitFrames"].DarkTheme and {0.2, 0.2, 0.2} or Colors.class[Class] or {0, 0, 0}
	
	if (not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit)) then
		Health:SetStatusBarColor(unpack(Colors.disconnected))
	elseif Status and Status > 0 then
		Health:SetStatusBarColor(1, 0, 0)
	else
		Health:SetStatusBarColor(Color[1], Color[2], Color[3])
	end
end

function TukuiUnitFrames:PostUpdateHealth(unit, min, max)
	if (not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit)) then
		if (not UnitIsConnected(unit)) then
			self.Value:SetText("|cffD7BEA5"..FRIENDS_LIST_OFFLINE.."|r")
		elseif (UnitIsDead(unit)) then
			self.Value:SetText("|cffD7BEA5"..DEAD.."|r")
		elseif (UnitIsGhost(unit)) then
			self.Value:SetText("|cffD7BEA5"..L.UnitFrames.Ghost.."|r")
		end
	else
		local r, g, b
		local IsRaid = string.match(self:GetParent():GetName(), "Button") or false
		
		if (IsRaid) then
			TukuiUnitFrames.UpdateThreat(self:GetParent(), nil, unit)
			
			if (unit == "player") then
				unit = raid
			end
		end
		
		if (C["UnitFrames"].DarkTheme ~= true and C["UnitFrames"].TargetEnemyHostileColor and unit == "target" and UnitIsEnemy(unit, "player") and UnitIsPlayer(unit)) or (C["UnitFrames"].DarkTheme ~= true and unit == "target" and not UnitIsPlayer(unit) and UnitIsFriend(unit, "player")) then
			local Colors = T["Colors"]
			local Color = Colors.reaction[UnitReaction(unit, "player")]
			
			if Color then 
				r, g, b = Color[1], Color[2], Color[3]
				self:SetStatusBarColor(r, g, b)
			else
				r, g, b = 75/255,  175/255, 76/255
				self:SetStatusBarColor(r, g, b)
			end
		end

		if (min ~= max) then
			r, g, b = T.ColorGradient(min, max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
			if (unit == "player" and self:GetAttribute("normalUnit") ~= "pet") then
				self.Value:SetFormattedText("|cffAF5050%d|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", min, r * 255, g * 255, b * 255, floor(min / max * 100))
			elseif (unit == "target" or (unit and strfind(unit, "boss%d"))) then
				self.Value:SetFormattedText("|cffAF5050%s|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", TukuiUnitFrames.ShortValue(min), r * 255, g * 255, b * 255, floor(min / max * 100))
			elseif (unit and strfind(unit, "arena%d")) or (unit == "focus") or (unit == "focustarget") then
				self.Value:SetText("|cff559655"..TukuiUnitFrames.ShortValue(min).."|r")
			else
				self.Value:SetText("|cffff2222-"..TukuiUnitFrames.ShortValue(max-min).."|r")
			end
		else
			if (unit == "player" and self:GetAttribute("normalUnit") ~= "pet") then
				self.Value:SetText("|cff559655"..max.."|r")
			elseif (unit == "target" or unit == "focus"  or unit == "focustarget" or (unit and strfind(unit, "arena%d"))) then
				self.Value:SetText("|cff559655"..TukuiUnitFrames.ShortValue(max).."|r")
			else
				self.Value:SetText(" ")
			end
		end
	end
end

function TukuiUnitFrames:PostUpdatePower(unit, min, max)
	local Parent = self:GetParent()
	local pType, pToken = UnitPowerType(unit)
	local Colors = T["Colors"]
	local Color = Colors.power[pToken]

	if Color then
		self.Value:SetTextColor(Color[1], Color[2], Color[3])
	end

	if (not UnitIsPlayer(unit) and not UnitPlayerControlled(unit) or not UnitIsConnected(unit)) then
		self.Value:SetText()
	elseif (UnitIsDead(unit) or UnitIsGhost(unit)) then
		self.Value:SetText()
	else
		if (min ~= max) then
			if (pType == 0) then
				if (unit == "target") then
					self.Value:SetFormattedText("%d%% |cffD7BEA5-|r %s", floor(min / max * 100), TukuiUnitFrames.ShortValue(max - (max - min)))
				elseif (unit == "player" and Parent:GetAttribute("normalUnit") == "pet" or unit == "pet") then
					self.Value:SetFormattedText("%d%%", floor(min / max * 100))
				elseif (unit and strfind(unit, "arena%d")) or unit == "focus" or unit == "focustarget" then
					self.Value:SetText(TukuiUnitFrames.ShortValue(min))
				else
					self.Value:SetFormattedText("%d%% |cffD7BEA5-|r %d", floor(min / max * 100), max - (max - min))
				end
			else
				self.Value:SetText(max - (max - min))
			end
		else
			if (unit == "pet" or unit == "target" or unit == "focus" or unit == "focustarget" or (unit and strfind(unit, "arena%d"))) then
				self.Value:SetText(TukuiUnitFrames.ShortValue(min))
			else
				self.Value:SetText(min)
			end
		end
	end

	if (Parent.Name and unit == "target") then
		TukuiUnitFrames.UpdateNamePosition(Parent)
	end
end

function TukuiUnitFrames:UpdateTotemTimer(elapsed)
	self.TimeLeft = self.TimeLeft - elapsed

	if self.TimeLeft > 0 then
		self:SetValue(self.TimeLeft)
	else
		self:SetValue(0)
		self:SetScript("OnUpdate", nil)
	end
end

local function hasbit(x, p)
	return x % (p + p) >= p
end

local function setbit(x, p)
	return hasbit(x, p) and x or x + p
end

local function clearbit(x, p)
	return hasbit(x, p) and x - p or x
end

function TukuiUnitFrames:UpdateTotemOverride(event, slot)
	local Bar = self.Totems
	local Priorities = Bar.__map

	if Bar.PreUpdate then Bar:PreUpdate(Priorities[slot]) end

	local Totem = Bar[Priorities[slot]]
	local HaveTotem, Name, Start, Duration, Icon = GetTotemInfo(slot)
	local Colors = T["Colors"]
	
	if (not Colors.totems[slot]) then
		return
	end
	
	local R, G, B = unpack(Colors.totems[slot])
	
	if (HaveTotem) then
		Totem.TimeLeft = (Start + Duration) - GetTime()
		Totem:SetMinMaxValues(0, Duration)
		Totem:SetScript("OnUpdate", TukuiUnitFrames.UpdateTotemTimer)
		Totem:SetStatusBarColor(R, G, B)

		Bar.activeTotems = setbit(Bar.activeTotems, 2 ^ (slot - 1))
	else
		Totem:SetValue(0)
		Totem:SetScript("OnUpdate", nil)

		Bar.activeTotems = clearbit(Bar.activeTotems, 2 ^ (slot - 1))
	end
	
	if Totem.bg then
		local Multiplier = Totem.bg.multiplier or 0.3
		
		R, G, B = R * Multiplier, G * Multiplier, B * Multiplier
		
		Totem.bg:SetVertexColor(R, G, B)
	end

	if Bar.activeTotems > 0 then
		Bar:Show()
	else
		Bar:Hide()
	end

	if Bar.PostUpdate then
		return Bar:PostUpdate(Priorities[slot], HaveTotem, Name, Start, Duration, Icon)
	end
end

function TukuiUnitFrames:CreateAuraTimer(elapsed)
	if (self.TimeLeft) then
		self.Elapsed = (self.Elapsed or 0) + elapsed

		if self.Elapsed >= 0.1 then
			if not self.First then
				self.TimeLeft = self.TimeLeft - self.Elapsed
			else
				self.TimeLeft = self.TimeLeft - GetTime()
				self.First = false
			end

			if self.TimeLeft > 0 then
				local Time = T.FormatTime(self.TimeLeft)
				self.Remaining:SetText(Time)
				
				if self.TimeLeft <= 5 then
					self.Remaining:SetTextColor(0.99, 0.31, 0.31)
				else
					self.Remaining:SetTextColor(1, 1, 1)
				end
			else
				self.Remaining:Hide()
				self:SetScript("OnUpdate", nil)
			end

			self.Elapsed = 0
		end
	end
end

function TukuiUnitFrames:PostCreateAura(button)
	button:SetTemplate("Default")
	button:CreateShadow()

	button.Remaining = button:CreateFontString(nil, "OVERLAY")
	button.Remaining:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	button.Remaining:Point("CENTER", 1, 0)

	button.cd.noOCC = true
	button.cd.noCooldownCount = true
	button.cd:SetReverse()
	button.cd:SetFrameLevel(button:GetFrameLevel() + 1)
	button.cd:ClearAllPoints()
	button.cd:SetInside()
	button.cd:SetHideCountdownNumbers(true)

	button.icon:SetInside()
	button.icon:SetTexCoord(unpack(T.IconCoord))
	button.icon:SetDrawLayer("ARTWORK")

	button.count:Point("BOTTOMRIGHT", 3, 3)
	button.count:SetJustifyH("RIGHT")
	button.count:SetFont(C.Medias.Font, 9, "THICKOUTLINE")
	button.count:SetTextColor(0.84, 0.75, 0.65)

	button.OverlayFrame = CreateFrame("Frame", nil, button, nil)
	button.OverlayFrame:SetFrameLevel(button.cd:GetFrameLevel() + 1)
	button.overlay:SetParent(button.OverlayFrame)
	button.count:SetParent(button.OverlayFrame)
	button.Remaining:SetParent(button.OverlayFrame)
	
	button.Animation = button:CreateAnimationGroup()
	button.Animation:SetLooping("BOUNCE")

	button.Animation.FadeOut = button.Animation:CreateAnimation("Alpha")
	button.Animation.FadeOut:SetChange(-.9)
	button.Animation.FadeOut:SetDuration(.6)
	button.Animation.FadeOut:SetSmoothing("IN_OUT")
end

function TukuiUnitFrames:PostUpdateAura(unit, button, index, offset, filter, isDebuff, duration, timeLeft)
	local _, _, _, _, DType, Duration, ExpirationTime, UnitCaster, IsStealable = UnitAura(unit, index, button.filter)

	if button then
		if(button.filter == "HARMFUL") then
			if(not UnitIsFriend("player", unit) and button.owner ~= "player" and button.owner ~= "vehicle") then
				button.icon:SetDesaturated(true)
				button:SetBackdropBorderColor(unpack(C["General"].BorderColor))
			else
				local color = DebuffTypeColor[DType] or DebuffTypeColor.none
				button.icon:SetDesaturated(false)
				button:SetBackdropBorderColor(color.r * 0.8, color.g * 0.8, color.b * 0.8)
			end
		else
			if (IsStealable or DType == "Magic") and not UnitIsFriend("player", unit) and not button.Animation.Playing then
				button.Animation:Play()
				button.Animation.Playing = true
			else
				button.Animation:Stop()
				button.Animation.Playing = false
			end
		end

		if Duration and Duration > 0 then
			button.Remaining:Show()
		else
			button.Remaining:Hide()
		end

		button.Duration = Duration
		button.TimeLeft = ExpirationTime
		button.First = true
		button:SetScript("OnUpdate", TukuiUnitFrames.CreateAuraTimer)
	end
end

function TukuiUnitFrames:SetGridGroupRole()
	local LFDRole = self.LFDRole
	local Role = UnitGroupRolesAssigned(self.unit)
	
	if Role == "TANK" then
		LFDRole:SetTexture(67/255, 110/255, 238/255,.3)
		LFDRole:Show()
	elseif Role == "HEALER" then
		LFDRole:SetTexture(130/255,  255/255, 130/255, .15)
		LFDRole:Show()
	elseif Role == "DAMAGER" then
		LFDRole:SetTexture(176/255, 23/255, 31/255, .27)
		LFDRole:Show()
	else
		LFDRole:Hide()
	end
end

function TukuiUnitFrames:CreateAuraWatchIcon(icon)
	icon:SetTemplate()
	icon.icon:Point("TOPLEFT", 1, -1)
	icon.icon:Point("BOTTOMRIGHT", -1, 1)
	icon.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	icon.icon:SetDrawLayer("ARTWORK")
	
	if (icon.cd) then
		icon.cd:SetHideCountdownNumbers(true)
		icon.cd:SetReverse(true)
	end
	
	icon.overlay:SetTexture()
end

-- create the icon
function TukuiUnitFrames:CreateAuraWatch(frame)
	local Auras = CreateFrame("Frame", nil, frame)
	Auras:SetPoint("TOPLEFT", frame.Health, 2, -2)
	Auras:SetPoint("BOTTOMRIGHT", frame.Health, -2, 2)
	Auras.presentAlpha = 1
	Auras.missingAlpha = 0
	Auras.icons = {}
	Auras.PostCreateIcon = TukuiUnitFrames.CreateAuraWatchIcon

	if (not C["Raid"].AuraWatchTimers) then
		Auras.hideCooldown = true
	end

	local buffs = {}

	if (TukuiUnitFrames.RaidBuffsTracking["ALL"]) then
		for key, value in pairs(TukuiUnitFrames.RaidBuffsTracking["ALL"]) do
			tinsert(buffs, value)
		end
	end

	if (TukuiUnitFrames.RaidBuffsTracking[Class]) then
		for key, value in pairs(TukuiUnitFrames.RaidBuffsTracking[Class]) do
			tinsert(buffs, value)
		end
	end
	
	-- Cornerbuffs
	if buffs then
		for key, spell in pairs(buffs) do
			local Icon = CreateFrame("Frame", nil, Auras)
			Icon.spellID = spell[1]
			Icon.anyUnit = spell[4]
			Icon:Width(6)
			Icon:Height(6)
			Icon:SetPoint(spell[2], 0, 0)
			
			local Texture = Icon:CreateTexture(nil, "OVERLAY")
			Texture:SetAllPoints(Icon)
			Texture:SetTexture(C.Medias.Blank)
			
			if (spell[3]) then
				Texture:SetVertexColor(unpack(spell[3]))
			else
				Texture:SetVertexColor(0.8, 0.8, 0.8)
			end
			
			local Count = Icon:CreateFontString(nil, "OVERLAY")
			Count:SetFont(C.Medias.Font, 8, "THINOUTLINE")
			Count:SetPoint("CENTER", unpack(TukuiUnitFrames.RaidBuffsTrackingPosition[spell[2]]))
			Icon.count = Count
			
			Auras.icons[spell[1]] = Icon
		end
	end

	frame.AuraWatch = Auras
end

function TukuiUnitFrames:EclipseDirection()
	local Power = UnitPower("Player", SPELL_POWER_ECLIPSE)
	
	if (Power < 0) then
			self.Text:SetText("|cffE5994C"..L.UnitFrames.Starfire.."|r")
	elseif (Power > 0) then
			self.Text:SetText("|cff4478BC"..L.UnitFrames.Wrath.."|r")
	else
			self.Text:SetText("")
	end
end

function TukuiUnitFrames:UpdateBossAltPower(minimum, current, maximum)
	if (not current) or (not maximum) then return end
	
	local r, g, b = T.ColorGradient(current, maximum, 0, .8 ,0 ,.8 ,.8 ,0 ,.8 ,0 ,0)
	
	self:SetStatusBarColor(r, g, b)
end

function TukuiUnitFrames:Update()
	for _, element in ipairs(self.__elements) do
		element(self, "UpdateElement", self.unit)
	end
end

function TukuiUnitFrames:UpdatePriestClassBars()
	local Frame = self:GetParent()
	local Serendipity = Frame.SerendipityBar
	local Totems = Frame.Totems
	local Shadow = Frame.Shadow

	if (Serendipity and Serendipity:IsShown()) and (Totems and Totems:IsShown()) then
		Shadow:Point("TOPLEFT", -4, 21)
		
		Serendipity:ClearAllPoints()
		Serendipity:Point("BOTTOMLEFT", Frame, "TOPLEFT", 0, 10)		
	elseif (Serendipity and Serendipity:IsShown()) or (Totems and Totems:IsShown()) then
		Shadow:Point("TOPLEFT", -4, 12)
		
		Serendipity:ClearAllPoints()
		Serendipity:Point("BOTTOMLEFT", Frame, "TOPLEFT", 0, 1)
	else
		Shadow:Point("TOPLEFT", -4, 4)
	end
end

function TukuiUnitFrames:UpdateMageClassBars()
	local Frame = self:GetParent()
	local Arcane = Frame.ArcaneChargeBar
	local Totems = Frame.Totems
	local Shadow = Frame.Shadow

	if (Arcane and Arcane:IsShown()) and (Totems and Totems:IsShown()) then
		Shadow:Point("TOPLEFT", -4, 21)
		
		Totems:ClearAllPoints()
		Totems:Point("BOTTOMLEFT", Frame, "TOPLEFT", 0, 10)		
	elseif (Arcane and Arcane:IsShown()) or (Totems and Totems:IsShown()) then
		Shadow:Point("TOPLEFT", -4, 12)
		
		Totems:ClearAllPoints()
		Totems:Point("BOTTOMLEFT", Frame, "TOPLEFT", 0, 1)
	else
		Shadow:Point("TOPLEFT", -4, 4)
	end
end

function TukuiUnitFrames:UpdateDruidClassBars()
	local Frame = self:GetParent()
	local EclipseBar = Frame.EclipseBar
	local Totems = Frame.Totems
	local Shadow = Frame.Shadow
	local Spec = GetSpecialization() -- 4 = heal, 1 = balance
	
	if (Spec == 1) then
		Totems[1]:SetWidth(Totems[1].OriginalWidth)
		Totems[2]:Show()
		Totems[3]:Show()
	elseif (Spec == 4) then
		Totems[1]:SetWidth(Frame:GetWidth())
		Totems[2]:Hide()
		Totems[3]:Hide()	
	end

	if (EclipseBar and EclipseBar:IsShown()) and (Totems and Totems:IsShown()) then
		Shadow:Point("TOPLEFT", -4, 21)
		
		Totems:ClearAllPoints()
		Totems:Point("BOTTOMLEFT", Frame, "TOPLEFT", 0, 10)		
	elseif (EclipseBar and EclipseBar:IsShown()) or (Totems and Totems:IsShown()) then
		Shadow:Point("TOPLEFT", -4, 12)
		
		Totems:ClearAllPoints()
		Totems:Point("BOTTOMLEFT", Frame, "TOPLEFT", 0, 1)
	else
		Shadow:Point("TOPLEFT", -4, 4)
	end
end

function TukuiUnitFrames:GetPartyFramesAttributes()
	return
		"TukuiParty",
		nil,
		"custom [@raid6,exists] hide;show", 
		"oUF-initialConfigFunction", [[
			local header = self:GetParent()
			self:SetWidth(header:GetAttribute("initial-width"))
			self:SetHeight(header:GetAttribute("initial-height"))
		]],
		"initial-width", C.Party.Portrait and T.Scale(162) or T.Scale(206),
		"initial-height", C.Party.Portrait and T.Scale(24) or T.Scale(40),
		"showSolo", false,
		"showParty", true, 
		"showPlayer", C["Party"].ShowPlayer,
		"showRaid", true,
		"groupFilter", "1,2,3,4,5,6,7,8", 
		"groupingOrder", "1,2,3,4,5,6,7,8", 
		"groupBy", "GROUP", 
		"yOffset", T.Scale(-66)	
end

function TukuiUnitFrames:GetRaidFramesAttributes()
	local Properties = C.Party.Enable and "custom [@raid6,exists] show;hide" or "solo,party,raid"
	
	return
		"TukuiRaid", 
		nil, 
		Properties,
		"oUF-initialConfigFunction", [[
			local header = self:GetParent()
			self:SetWidth(header:GetAttribute("initial-width"))
			self:SetHeight(header:GetAttribute("initial-height"))
		]],
		"initial-width", T.Scale(66),
		"initial-height", T.Scale(50),
		"showParty", true,
		"showRaid", true,
		"showPlayer", true,
		"showSolo", false,
		"xoffset", T.Scale(4),
		"yOffset", T.Scale(-4),
		"point", "TOP",
		"groupFilter", "1,2,3,4,5,6,7,8",
		"groupingOrder", "1,2,3,4,5,6,7,8",
		"groupBy", C["Raid"].GroupBy.Value,
		"maxColumns", math.ceil(40/5),
		"unitsPerColumn", C["Raid"].MaxUnitPerColumn,
		"columnSpacing", T.Scale(4),
		"columnAnchorPoint", "LEFT"
end

function TukuiUnitFrames:GetPetRaidFramesAttributes()
	local Properties = C.Party.Enable and "custom [@raid6,exists] show;hide" or "solo,party,raid"
	
	return
		"TukuiRaidPet", 
		"SecureGroupPetHeaderTemplate", 
		Properties,
		"showParty", false,
		"showRaid", C["Raid"].ShowPets,
		"showSolo", false,
		"maxColumns", math.ceil(40/5),
		"point", "TOP",
		"unitsPerColumn", C["Raid"].MaxUnitPerColumn,
		"columnSpacing", T.Scale(4),
		"columnAnchorPoint", "LEFT",
		"yOffset", T.Scale(-4),
		"xOffset", T.Scale(4),
		"initial-width", T.Scale(66),
		"initial-height", T.Scale(50),
		"oUF-initialConfigFunction", [[
			local header = self:GetParent()
			self:SetWidth(header:GetAttribute("initial-width"))
			self:SetHeight(header:GetAttribute("initial-height"))
		]]
end

function TukuiUnitFrames:Style(unit)
	if (not unit) then
		return
	end
	
	local Parent = self:GetParent():GetName()
	
	if (unit == "player") then
		TukuiUnitFrames.Player(self)
	elseif (unit == "target") then
		TukuiUnitFrames.Target(self)
	elseif (unit == "targettarget") then
		TukuiUnitFrames.TargetOfTarget(self)
	elseif (unit == "pet") then
		TukuiUnitFrames.Pet(self)
	elseif (unit == "focus") then
		TukuiUnitFrames.Focus(self)
	elseif (unit == "focustarget") then
		TukuiUnitFrames.FocusTarget(self)
	elseif unit:find("arena%d") then
		TukuiUnitFrames.Arena(self)
	elseif unit:find("boss%d") then
		TukuiUnitFrames.Boss(self)
	elseif (unit:find("raid") or unit:find("raidpet")) then
		if Parent:match("Party") then
			TukuiUnitFrames.Party(self)
		else
			TukuiUnitFrames.Raid(self)
		end
	end
	
	return self
end

function TukuiUnitFrames:CreateAnchor()
	local Anchor = CreateFrame("Frame", "TukuiActionBarAnchor", UIParent)
	Anchor:Size(768, 66)
	Anchor:SetPoint("BOTTOM", UIParent, 0, 14)

	TukuiUnitFrames.Anchor = Anchor
end

function TukuiUnitFrames:CreateUnits()
	local Movers = T["Movers"]
	
	local Player = oUF:Spawn("player")
	Player:SetPoint("BOTTOMLEFT", TukuiUnitFrames.Anchor, "TOPLEFT", 0, 8)
	Player:SetParent(Panels.PetBattleHider)
	Player:Size(250, 57)

	local Target = oUF:Spawn("target")
	Target:SetPoint("BOTTOMRIGHT", TukuiUnitFrames.Anchor, "TOPRIGHT", 0, 8)
	Target:SetParent(Panels.PetBattleHider)
	Target:Size(250, 57)

	local TargetOfTarget = oUF:Spawn("targettarget")
	TargetOfTarget:SetPoint("BOTTOM", TukuiUnitFrames.Anchor, "TOP", 0, 8)
	TargetOfTarget:SetParent(Panels.PetBattleHider)
	TargetOfTarget:Size(129, 36)

	local Pet = oUF:Spawn("pet")
	Pet:SetParent(Panels.PetBattleHider)
	Pet:SetPoint("BOTTOM", TukuiUnitFrames.Anchor, "TOP", 0, 49)
	Pet:Size(129, 36)

	local Focus = oUF:Spawn("focus")
	Focus:SetPoint("BOTTOMLEFT", TukuiUnitFrames.Anchor, "TOPLEFT", 0, 300)
	Focus:SetParent(Panels.PetBattleHider)
	Focus:Size(200, 29)

	local FocusTarget = oUF:Spawn("focustarget")
	FocusTarget:SetPoint("BOTTOM", Focus, "TOP", 0, 35)
	FocusTarget:SetParent(Panels.PetBattleHider)
	FocusTarget:Size(200, 29)
	
	self.Units.Player = Player
	self.Units.Target = Target
	self.Units.TargetOfTarget = TargetOfTarget
	self.Units.Pet = Pet
	self.Units.Focus = Focus
	self.Units.FocusTarget = FocusTarget
	
	if (C.UnitFrames.Arena) then
		local Arena = {}
	
		for i = 1, 5 do
			Arena[i] = oUF:Spawn("arena"..i, nil)
			Arena[i]:SetParent(Panels.PetBattleHider)
			if (i == 1) then
				Arena[i]:SetPoint("BOTTOMRIGHT", TukuiUnitFrames.Anchor, "TOPRIGHT", 0, 300)
			else
				Arena[i]:SetPoint("BOTTOM", Arena[i-1], "TOP", 0, 35)
			end
			Arena[i]:Size(200, 29)
		
			Movers:RegisterFrame(Arena[i])
		end
	
		self.Units.Arena = Arena
	
		self:CreateArenaPreparationFrames()
	end
	
	if (C.UnitFrames.Boss) then
		local Boss = {}
		
		for i = 1, 5 do
			Boss[i] = oUF:Spawn("boss"..i, nil)
			Boss[i]:SetParent(Panels.PetBattleHider)
			if (i == 1) then
				Boss[i]:SetPoint("BOTTOMRIGHT", TukuiUnitFrames.Anchor, "TOPRIGHT", 0, 300)
			else
				Boss[i]:SetPoint("BOTTOM", Boss[i-1], "TOP", 0, 35)             
			end
			Boss[i]:Size(200, 29)
		
			Movers:RegisterFrame(Boss[i])
		end
	
		self.Units.Boss = Boss
	end
	
	if C.Party.Enable then
		local Gap = C.Party.Portrait and 74 or 30
		
		local Party = oUF:SpawnHeader(TukuiUnitFrames:GetPartyFramesAttributes())
		Party:SetParent(Panels.PetBattleHider)
		Party:Point("TOPLEFT", UIParent, "TOPLEFT", Gap, -(T.ScreenHeight / 4))
		
		TukuiUnitFrames.Headers.Party = Party
		
		Movers:RegisterFrame(Party)
	end
	
	if C.Raid.Enable then
		local Raid = oUF:SpawnHeader(TukuiUnitFrames:GetRaidFramesAttributes())
		Raid:SetParent(Panels.PetBattleHider)
		Raid:Point("TOPLEFT", UIParent, "TOPLEFT", 30, -30)
		
		if C.Raid.ShowPets then
			local Pet = oUF:SpawnHeader(TukuiUnitFrames:GetPetRaidFramesAttributes())
			Pet:SetParent(Panels.PetBattleHider)
			Pet:Point("TOPLEFT", Raid, "TOPRIGHT", 4, 0)
			
			TukuiUnitFrames.Headers.RaidPet = Pet
			Movers:RegisterFrame(Pet)
		end
		
		TukuiUnitFrames.Headers.Raid = Raid
		Movers:RegisterFrame(Raid)
	end
	
	Movers:RegisterFrame(Player)
	Movers:RegisterFrame(Target)
	Movers:RegisterFrame(TargetOfTarget)
	Movers:RegisterFrame(Pet)
	Movers:RegisterFrame(Focus)
	Movers:RegisterFrame(FocusTarget)
end

function TukuiUnitFrames:ShowArenaPreparation()
	local NumOpps = GetNumArenaOpponentSpecs()

	for i = 1, 5 do
		local Frame = self.Units.ArenaPreparation[i]

		if (i <= NumOpps) then
			local SpecID = GetArenaOpponentSpec(i)

			if (SpecID and SpecID > 0) then
				local _, Spec, _, _, _, _, Class = GetSpecializationInfoByID(SpecID)
				
				if (Class) then
					Frame.SpecClass:SetText(Spec.."  -  "..LOCALIZED_CLASS_NAMES_MALE[Class])
			
					if (not C.UnitFrames.DarkTheme) then
						local Color = self.Units.Arena[i].colors.class[Class]
				
						Frame.Health:SetStatusBarColor(unpack(Color))
					end
				else
					Frame.Health:SetStatusBarColor(0.2, 0.2, 0.2, 1)
				end

				Frame:Show()
			else
				Frame:Hide()
			end
		else
			Frame:Hide()
		end
	end
end

function TukuiUnitFrames:HideArenaPreparation()
	for i = 1, 5 do
		local Frame = self.Units.ArenaPreparation[i]
		
		Frame:Hide()
	end
end

function TukuiUnitFrames:OnEvent(event)
	if (event == "ARENA_OPPONENT_UPDATE") then
		self:HideArenaPreparation()
	else
		self:ShowArenaPreparation()
	end
end

function TukuiUnitFrames:Enable()
	if (not C.UnitFrames.Enable) then
		return
	end
	
	self.Backdrop = {
		bgFile = C.Medias.Blank,
		insets = {top = -T.Mult, left = -T.Mult, bottom = -T.Mult, right = -T.Mult},
	}
	
	oUF:RegisterStyle("Tukui", TukuiUnitFrames.Style)
	
	self:DisableBlizzard()
	self:CreateAnchor()
	self:CreateUnits()
	
	-- Arena Preparation
	if (C.UnitFrames.Arena) then
		self:RegisterEvent("PLAYER_ENTERING_WORLD")
		self:RegisterEvent("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
		self:RegisterEvent("ARENA_OPPONENT_UPDATE")	
		self:SetScript("OnEvent", self.OnEvent)
	end
end

T["UnitFrames"] = TukuiUnitFrames