local T, C, L = select(2, ...):unpack()
local AddOn, Plugin = ...
local oUF = Plugin.oUF or oUF
local Noop = function() end
local UnitFrames = T["UnitFrames"]
local HealComm, CheckRange
local myGUID = UnitGUID("player")

if not T.Retail then
	HealComm = LibStub("LibHealComm-4.0")
end

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

UnitFrames.oUF = oUF
UnitFrames.Units = {}
UnitFrames.Headers = {}
UnitFrames.AddClassFeatures = {}

function UnitFrames:DisableBlizzard()
	if not C.UnitFrames.Enable then
		return
	end

	if C["Raid"].Enable and CompactRaidFrameManager then
		-- Disable Blizzard Raid Frames.
		CompactRaidFrameManager:SetParent(T.Hider)
		CompactRaidFrameManager:UnregisterAllEvents()
		CompactRaidFrameManager:Hide()

		CompactRaidFrameContainer:SetParent(T.Hider)
		CompactRaidFrameContainer:UnregisterAllEvents()
		CompactRaidFrameContainer:Hide()

		-- Hide Raid Interface Options.
		InterfaceOptionsFrameCategoriesButton11:SetHeight(0.00001)
		InterfaceOptionsFrameCategoriesButton11:SetAlpha(0)
	end
end

function UnitFrames:ShortValue()
	if self <= 999 then
		return self
	end

	local Value

	if self >= 1000000 then
		Value = format("%.1fm", self / 1000000)
		return Value
	elseif self >= 1000 then
		Value = format("%.1fk", self / 1000)
		return Value
	end
end

function UnitFrames:UTF8Sub(i, dots)
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

function UnitFrames:ShowWarMode()
	local Status = self.Status
	local MouseOver = GetMouseFocus()
	local IsPvP = C_PvP.IsWarModeDesired and C_PvP.IsWarModeDesired or UnitIsPVP("player")

	if (IsPvP) and (MouseOver == self) and (not InCombatLockdown()) then
		Status:Show()

		if self.RestingIndicator then
			self.RestingIndicator:SetAlpha(0)
		end
	else
		Status:Hide()

		if self.RestingIndicator then
			self.RestingIndicator:SetAlpha(1)
		end
	end
end

function UnitFrames:Highlight()
	local Highlight = self.Highlight or self.Shadow

	if not Highlight then
		return
	end

	if UnitIsUnit("target", self.unit) then
		if self.Highlight then
			Highlight:Show()
		else
			Highlight:SetBackdropBorderColor(1, 1, 0, 1)
		end
	else
		if self.Highlight then
			Highlight:Hide()
		else
			Highlight:SetBackdropBorderColor(0, 0, 0, 1)
		end
	end
end

function UnitFrames:UpdateNameplateClassIcon()
	if UnitIsPlayer(self.unit) then
		local Class = select(2, UnitClass(self.unit))

		if Class then
			local Left, Right, Top, Bottom = unpack(CLASS_ICON_TCOORDS[Class])

			-- Remove borders on icon
			Left = Left + (Right - Left) * 0.075
			Right = Right - (Right - Left) * 0.075
			Top = Top + (Bottom - Top) * 0.075
			Bottom = Bottom - (Bottom - Top) * 0.075

			self.ClassIcon.Texture:SetTexCoord(Left, Right, Top, Bottom)
			self.ClassIcon:SetAlpha(1)
		end
	else
		self.ClassIcon:SetAlpha(0)
	end
end

function UnitFrames:PostCreateAuraBar(bar)
	if not bar.Backdrop then
		bar:CreateBackdrop("Transparent")
		bar.Backdrop:CreateShadow()

		bar.IconBackdrop = CreateFrame("Frame", nil, bar)
		bar.IconBackdrop:SetAllPoints(bar.icon)
		bar.IconBackdrop:CreateShadow()
	end
end

function UnitFrames:UpdateBuffsHeaderPosition(height)
	local Frame = self:GetParent()
	local Buffs = Frame.Buffs

	if not Buffs then
		return
	end

	Buffs:ClearAllPoints()
	Buffs:SetPoint("BOTTOMLEFT", Frame, "TOPLEFT", -1, height)
end

function UnitFrames:UpdateDebuffsHeaderPosition()
	local NumBuffs = self.visibleBuffs
	local PerRow = self.numRow
	local Size = self.size
	local Row = math.ceil((NumBuffs / 8))
	local Parent = self:GetParent()
	local Debuffs = Parent.Debuffs
	local Spacing = Debuffs.spacing
	local Y = Size * Row
	local Addition = (Spacing * Row)

	if NumBuffs == 0 then
		Addition = 0
	end

	Debuffs:ClearAllPoints()

	if C.UnitFrames.AurasBelow then
		Debuffs:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, -Y - Addition)
	else
		Debuffs:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, Y + Addition)
	end
end

function UnitFrames:CustomCastTimeText(duration)
	local Value = format("%.1f / %.1f", self.channeling and duration or self.max - duration, self.max)

	self.Time:SetText(Value)
end

function UnitFrames:CustomCastDelayText(duration)
	local Value = format("%.1f |cffaf5050%s %.1f|r", self.channeling and duration or self.max - duration, self.channeling and "- " or "+", self.delay)

	self.Time:SetText(Value)
end

function UnitFrames:SetStatusCastBarColor(unit)
	if (unit == "vehicle") then
		unit = "player"
	end

	if (self.notInterruptible) then
		self:SetStatusBarColor(unpack(C.UnitFrames.NotInterruptibleColor))
	elseif (self.casting) then
		self:SetStatusBarColor(unpack(C.UnitFrames.CastingColor))
	elseif (self.channeling) then
		self:SetStatusBarColor(unpack(C.UnitFrames.ChannelingColor))
	else
		self:SetStatusBarColor(1, 1, 1)
	end

	if C.NamePlates.ClassIcon and unit:find("nameplate") and self.Button and self.Button.Shadow then
		self.Button.Shadow:SetBackdropBorderColor(self:GetStatusBarColor())
	end
end

-- Deprecated, CheckInterrupt was renamed to SetStatusCastBarColor and will be removed soon
UnitFrames.CheckInterrupt = UnitFrames.SetStatusCastBarColor

function UnitFrames:CheckCast(unit, name, rank, castid)
	UnitFrames.SetStatusCastBarColor(self, unit)
end

function UnitFrames:CheckChannel(unit, name, rank)
	UnitFrames.SetStatusCastBarColor(self, unit)
end

function UnitFrames:PreUpdateHealth(unit)
	if C["UnitFrames"].TargetEnemyHostileColor then
		if UnitIsEnemy(unit, "player") then
			self.colorClass = false
		else
			self.colorClass = true
		end
	end
end

function UnitFrames:DisplayPlayerAndPetNames(event)
	if event == "PLAYER_REGEN_DISABLED" then
		self.Power.Value:Show()
		self.Name:SetAlpha(0)

		if self.unit == "pet" then
			self.Health.Value:Show()
		end
	else
		self.Power.Value:Hide()
		self.Name:SetAlpha(1)

		if self.unit == "pet" then
			self.Health.Value:Hide()
		end
	end
end

function UnitFrames:PostUpdateHealth(unit, min, max)
	if (not self.Value) then
		return
	end

	if (not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit)) then
		if (not UnitIsConnected(unit)) then
			self.Value:SetText("|cffD7BEA5"..FRIENDS_LIST_OFFLINE.."|r")
		elseif (UnitIsDead(unit)) then
			self.Value:SetText("|cffD7BEA5"..DEAD.."|r")
		elseif (UnitIsGhost(unit)) then
			self.Value:SetText("|cffD7BEA5"..L.UnitFrames.Ghost.."|r")
		end
	else
		local IsRaid = string.match(self:GetParent():GetName(), "Button") or false

		if (IsRaid) and (min == max) then
			self.Value:SetText("")
		else
			local r, g, b = T.ColorGradient(min, max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)

			self.Value:SetFormattedText("|cff%02x%02x%02x%s|r", r * 255, g * 255, b * 255, UnitFrames.ShortValue(min))
		end
	end
end

function UnitFrames:PostUpdatePower(unit, current, min, max)
	if (not self.Value) then
		return
	end

	local Parent = self:GetParent()
	local pType, pToken = UnitPowerType(unit)
	local Colors = T["Colors"]
	local Color = Colors.power[pToken]

	if Color then
		self.Value:SetTextColor(Color[1], Color[2], Color[3])
	end

	if (UnitIsDead(unit) or UnitIsGhost(unit)) then
		self.Value:SetText("")
	else
		self.Value:SetText(UnitFrames.ShortValue(current))
	end
end

function UnitFrames:SetAuraTimer(elapsed)
	if (self.TimeLeft) then
		self.Elapsed = (self.Elapsed or 0) + elapsed

		if self.Elapsed >= 0.1 then
			self.TimeLeft = self.TimeLeft - self.Elapsed

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
			end

			self.Elapsed = 0
		end
	end
end

function UnitFrames:CancelPlayerBuff(index)
	if InCombatLockdown() then
		return
	end

	CancelUnitBuff("player", self.index)
end

function UnitFrames:PostCreateAura(button, unit)
	-- Set "self.Buffs.isCancellable" to true to a buffs frame to be able to cancel click
	local isCancellable = button:GetParent().isCancellable
	local isAnimated = C.UnitFrames.FlashRemovableBuffs and button:GetParent().isAnimated

	-- Right-click-cancel script
	if isCancellable then
		-- Add a button.index to allow CancelUnitAura to work with player
		local Name = button:GetName()
		local Index = Name:gsub("%D+" , "")

		button.index = tonumber(Index)
		button:SetScript("OnMouseUp", UnitFrames.CancelPlayerBuff)
	end

	-- Skin aura button
	button:CreateBackdrop("Default")

	if not button:GetParent().IsRaid then
		button:CreateShadow()
	end

	button.cd.noOCC = true
	button.cd.noCooldownCount = true
	button.cd:SetReverse(true)
	button.cd:ClearAllPoints()
	button.cd:SetInside()
	button.cd:SetHideCountdownNumbers(true)

	button.Remaining = button.cd:CreateFontString(nil, "OVERLAY")
	button.Remaining:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	button.Remaining:SetPoint("CENTER", 1, 0)

	button.icon:SetInside()
	button.icon:SetTexCoord(unpack(T.IconCoord))
	button.icon:SetDrawLayer("ARTWORK")

	button.count:SetPoint("BOTTOMRIGHT", 3, -3)
	button.count:SetJustifyH("RIGHT")
	button.count:SetFont(C.Medias.Font, 9, "THICKOUTLINE")
	button.count:SetTextColor(0.84, 0.75, 0.65)

	if isAnimated then
		button.Animation = button:CreateAnimationGroup()
		button.Animation:SetLooping("BOUNCE")

		button.Animation.FadeOut = button.Animation:CreateAnimation("Alpha")
		button.Animation.FadeOut:SetFromAlpha(1)
		button.Animation.FadeOut:SetToAlpha(.7)
		button.Animation.FadeOut:SetDuration(.15)
		button.Animation.FadeOut:SetSmoothing("IN_OUT")
	end
end

function UnitFrames:PostUpdateAura(unit, button, index, offset, filter, isDebuff, duration, timeLeft)
	local Name, _, _, DType, Duration, ExpirationTime, UnitCaster, IsStealable, _, SpellID = UnitAura(unit, index, button.filter)

	if button then
		if(button.filter == "HARMFUL") then
			if C.UnitFrames.DesaturateDebuffs and (not UnitIsFriend("player", unit) and not button.isPlayer) then
				button.icon:SetDesaturated(true)
				button.Backdrop:SetBorderColor(unpack(C["General"].BorderColor))
			else
				local color = DebuffTypeColor[DType] or DebuffTypeColor.none
				button.icon:SetDesaturated(false)
				button.Backdrop:SetBorderColor(color.r * 0.8, color.g * 0.8, color.b * 0.8)
			end
		else
			if button.Animation then
				if (IsStealable or DType == "Magic") and UnitIsEnemy("player", unit) then
					if not button.Animation:IsPlaying() then
						button.Animation:Play()

						button.Backdrop:SetBorderColor(0.2, 0.6, 1)
					end
				else
					if button.Animation:IsPlaying() then
						button.Animation:Stop()

						button.Backdrop:SetBorderColor(unpack(C["General"].BorderColor))
					end
				end
			end
		end

		if button.Remaining then
			local Size = button:GetSize()

			if (Duration and Duration > 0 and Size > 20) then
				button.Remaining:Show()

				button:SetScript("OnUpdate", UnitFrames.SetAuraTimer)
			else
				button.Remaining:Hide()

				button:SetScript("OnUpdate", nil)
			end
		end

		if (button.cd) then
			if (Duration and Duration > 0) then
				button.cd:SetCooldown(ExpirationTime - Duration, Duration)
				button.cd:Show()
			else
				button.cd:Hide()
			end
		end

		button.Duration = Duration
		button.TimeLeft = ExpirationTime
		button.Elapsed = GetTime()
	end
end

function UnitFrames:DesaturateBuffs(unit, button)
	if button.icon then
		button.icon:SetDesaturated(not button.isPlayer)
	end
end

function UnitFrames:Update()
	for _, element in ipairs(self.__elements) do
		element(self, "UpdateElement", self.unit)
	end
end

function UnitFrames:BuffIsStealable(unit, button, name, texture, count, debuffType)
	-- We want to use this custom filter for mythic+, bg, arena
	local IsPlayer = UnitIsPlayer(unit) or false
	local InInstance, InstanceType = IsInInstance()

	if ((InstanceType == "pvp" or InstanceType == "arena") and debuffType == "Magic") or (not IsPlayer and debuffType == "Magic") then
		return true
	end
end

function UnitFrames:DisplayNameplatePowerAndCastBar(unit, cur, min, max)
	if not unit then
		unit = self:GetParent().unit
	end

	if not unit then
		return
	end

	if not cur then
		cur, max = UnitPower(unit), UnitPowerMax(unit)
	end

	local CurrentPower = cur
	local MaxPower = max
	local Nameplate = self:GetParent()
	local PowerBar = Nameplate.Power
	local Health = Nameplate.Health
	local IsPowerHidden = PowerBar.IsHidden
	local CastBar = Nameplate.Castbar

	if (CurrentPower and CurrentPower == 0) and (MaxPower and MaxPower == 0) then
		if (not IsPowerHidden) then
			Health:ClearAllPoints()
			Health:SetAllPoints()

			PowerBar:SetAlpha(0)
			PowerBar.IsHidden = true

			if CastBar then
				CastBar:ClearAllPoints()
				CastBar:SetSize(Health:GetWidth(), PowerBar:GetHeight())
				CastBar:SetPoint("BOTTOM", Health, "BOTTOM", 0, 0)
			end
		end
	else
		if IsPowerHidden then
			Health:ClearAllPoints()
			Health:SetPoint("TOPLEFT")
			Health:SetPoint("TOPRIGHT")
			Health:SetHeight(Nameplate:GetHeight() - PowerBar:GetHeight() - 1)

			if CastBar then
				CastBar:ClearAllPoints()
				CastBar:SetAllPoints(PowerBar)
			end

			PowerBar:SetAlpha(1)
			PowerBar.IsHidden = false
		end
	end
end

function UnitFrames:RunesPostUpdate(runemap)
	local Bar = self
	local RuneMap = runemap

	for i, RuneID in next, RuneMap do
		local IsReady = select(3, GetRuneCooldown(RuneID))

		if IsReady then
			Bar[i]:SetAlpha(1)
		else
			Bar[i]:SetAlpha(0.5)
		end
	end
end

function UnitFrames:UpdateTotemTimer(elapsed)
	self.Elapsed = (self.Elapsed and self.Elapsed or 0) - elapsed

	if self.Elapsed < 0 then
		local TimeLeft = math.ceil(self.Duration - (GetTime() - self.Start))

		if TimeLeft > -.5 then
			self:SetMinMaxValues(0, self.Duration)
			self:SetValue(TimeLeft)
		else
			self:SetValue(0, 1)
		end

		self.Elapsed = 0.5
	end
end

function UnitFrames:UpdateTotemOverride(event, slot)
	if slot > 4 then
		return
	end

	local Bar = self.Totems

	if Bar.PreUpdate then Bar:PreUpdate(slot) end

	local Totem = Bar[slot]
	local HaveTotem, Name, Start, Duration, Icon = GetTotemInfo(slot)
	local SpellID = select(7, GetSpellInfo(Name))

	local Colors = T["Colors"]

	if (HaveTotem) then
		Totem.Slot = slot
		Totem.Duration = Duration
		Totem.Start = Start
		Totem:Show()

		if (Totem.Icon) then
			Totem.Icon:SetTexture(Icon)
		end

		if (Totem.Cooldown) then
			Totem.Cooldown:SetCooldown(Start, Duration)
		end

		if Totem.SetValue then
			Totem:SetScript("OnUpdate", UnitFrames.UpdateTotemTimer)
		end

		-- Workaround to allow right-click destroy totem
		for i = 1, 4 do
			local BlizzardTotem = _G["TotemFrameTotem"..i]
			local Cooldown = _G["TotemFrameTotem"..i.."IconCooldown"]

			if BlizzardTotem:IsShown() then
				local Where = BlizzardTotem.slot

				BlizzardTotem:ClearAllPoints()
				BlizzardTotem:SetAllPoints(Bar[Where])
				BlizzardTotem:SetAlpha(0)

				Cooldown:SetAlpha(0)
			end
		end

		--Totem:SetScript("OnUpdate", UnitFrames.UpdateTotemTimer)
	else
		Totem:Hide()

		if Totem.Icon then
			Totem.Icon:SetTexture(nil)
		end

		if Totem.SetValue then
			Totem:SetScript("OnUpdate", nil)
		end
	end

	if Bar.PostUpdate then
		return Bar:PostUpdate(slot, HaveTotem, Name, Start, Duration, Icon)
	end
end

function UnitFrames:GetPartyFramesAttributes()
	return
		"TukuiParty",
		nil,
		"custom [@raid6,exists] hide; [@raid1,exists] show; [@party1,exists] show; hide",
		"oUF-initialConfigFunction", [[
			local header = self:GetParent()
			self:SetWidth(header:GetAttribute("initial-width"))
			self:SetHeight(header:GetAttribute("initial-height"))
		]],
		"initial-width", 180,
		"initial-height", 24,
		"showSolo", false,
		"showParty", true,
		"showPlayer", C["Party"].ShowPlayer,
		"showRaid", true,
		"groupFilter", "1,2,3,4,5,6,7,8",
		"groupingOrder", "1,2,3,4,5,6,7,8",
		"groupBy", "GROUP",
		"yOffset", -50
end

function UnitFrames:GetPetPartyFramesAttributes()
	return
		"TukuiPartyPet",
		"SecureGroupPetHeaderTemplate",
		"custom [@raid6,exists] hide; [@raid1,exists] show; [@party1,exists] show; hide",
		"oUF-initialConfigFunction", [[
			local header = self:GetParent()
			self:SetWidth(header:GetAttribute("initial-width"))
			self:SetHeight(header:GetAttribute("initial-height"))
		]],
		"initial-width", 180,
		"initial-height", 24,
		"showSolo", false,
		"showParty", true,
		"showPlayer", C["Party"].ShowPlayer,
		"showRaid", true,
		"groupFilter", "1,2,3,4,5,6,7,8",
		"groupingOrder", "1,2,3,4,5,6,7,8",
		"groupBy", "GROUP",
		"yOffset", -50
end

function UnitFrames:GetRaidFramesAttributes()
	local Properties = C.Party.Enable and "custom [@raid21,exists] hide; [@raid6,exists] show; hide" or "custom [@raid21,exists] hide; [@raid6,exists] show; [@party1,exists] show; hide"

	return
		"TukuiRaid",
		nil,
		Properties,
		"oUF-initialConfigFunction", [[
			local header = self:GetParent()
			self:SetWidth(header:GetAttribute("initial-width"))
			self:SetHeight(header:GetAttribute("initial-height"))
		]],
		"initial-width", C.Raid.WidthSize,
		"initial-height", C.Raid.HeightSize,
		"showParty", true,
		"showRaid", true,
		"showPlayer", true,
		"showSolo", true,
		"xoffset", C.Raid.Padding,
		"yOffset", -C.Raid.Padding,
		"point", "TOP",
		"groupFilter", "1,2,3,4,5,6,7,8",
		"groupingOrder", "1,2,3,4,5,6,7,8",
		"groupBy", C["Raid"].GroupBy.Value,
		"maxColumns", math.ceil(40 / 5),
		"unitsPerColumn", C["Raid"].MaxUnitPerColumn,
		"columnSpacing", C.Raid.Padding,
		"columnAnchorPoint", "LEFT"
end

function UnitFrames:GetBigRaidFramesAttributes()
	local Properties = "custom [@raid21,exists] show; hide"

	return
		"TukuiRaid40",
		nil,
		Properties,
		"oUF-initialConfigFunction", [[
			local header = self:GetParent()
			self:SetWidth(header:GetAttribute("initial-width"))
			self:SetHeight(header:GetAttribute("initial-height"))
		]],
		"initial-width", C.Raid.Raid40WidthSize,
		"initial-height", C.Raid.Raid40HeightSize,
		"showParty", true,
		"showRaid", true,
		"showPlayer", true,
		"showSolo", true,
		"xoffset", C.Raid.Padding40,
		"yOffset", -C.Raid.Padding40,
		"point", "TOP",
		"groupFilter", "1,2,3,4,5,6,7,8",
		"groupingOrder", "1,2,3,4,5,6,7,8",
		"groupBy", C["Raid"].GroupBy.Value,
		"maxColumns", math.ceil(40 / 5),
		"unitsPerColumn", C["Raid"].Raid40MaxUnitPerColumn,
		"columnSpacing", C.Raid.Padding40,
		"columnAnchorPoint", "LEFT"
end

function UnitFrames:GetPetRaidFramesAttributes()
	local Properties = C.Party.Enable and "custom [@raid21,exists] hide; [@raid6,exists] show; hide" or "custom [@raid21,exists] hide; [@raid6,exists] show; [@party1,exists] show; hide"

	return
		"TukuiRaidPet",
		"SecureGroupPetHeaderTemplate",
		Properties,
		"showParty", C["Raid"].ShowPets,
		"showRaid", C["Raid"].ShowPets,
		"showPlayer", true,
		"showSolo", true,
		"maxColumns", math.ceil(40 / 5),
		"point", "TOP",
		"unitsPerColumn", C["Raid"].MaxUnitPerColumn,
		"columnSpacing", C.Raid.Padding,
		"columnAnchorPoint", "LEFT",
		"yOffset", -C.Raid.Padding,
		"xOffset", C.Raid.Padding,
		"initial-width", C.Raid.WidthSize,
		"initial-height", C.Raid.HeightSize,
		"oUF-initialConfigFunction", [[
			local header = self:GetParent()
			self:SetWidth(header:GetAttribute("initial-width"))
			self:SetHeight(header:GetAttribute("initial-height"))
		]]
end

function UnitFrames:GetBigPetRaidFramesAttributes()
	local Properties = "custom [@raid21,exists] show; hide"

	return
		"TukuiRaid40Pet",
		"SecureGroupPetHeaderTemplate",
		Properties,
		"showParty", C["Raid"].ShowPets,
		"showRaid", C["Raid"].ShowPets,
		"showPlayer", true,
		"showSolo", true,
		"maxColumns", math.ceil(40 / 5),
		"point", "TOP",
		"unitsPerColumn", C["Raid"].Raid40MaxUnitPerColumn,
		"columnSpacing", C.Raid.Padding40,
		"columnAnchorPoint", "LEFT",
		"yOffset", -C.Raid.Padding40,
		"xOffset", C.Raid.Padding40,
		"initial-width", C.Raid.Raid40WidthSize,
		"initial-height", C.Raid.Raid40HeightSize,
		"oUF-initialConfigFunction", [[
			local header = self:GetParent()
			self:SetWidth(header:GetAttribute("initial-width"))
			self:SetHeight(header:GetAttribute("initial-height"))
		]]
end

function UnitFrames:Style(unit)
	if (not unit) then
		return
	end

	local Parent = self:GetParent():GetName()

	if (unit == "player") then
		UnitFrames.Player(self)
	elseif (unit == "target") then
		UnitFrames.Target(self)
	elseif (unit == "targettarget") then
		UnitFrames.TargetOfTarget(self)
	elseif (unit == "pet") then
		UnitFrames.Pet(self)
	elseif (unit == "focus") then
		UnitFrames.Focus(self)
	elseif (unit == "focustarget")  then
		UnitFrames.FocusTarget(self)
	elseif (unit:find("raid")) or (unit:find("raidpet")) then
		if Parent:match("Party") then
			UnitFrames.Party(self)
		else
			UnitFrames.Raid(self)
		end
	elseif unit:find("boss%d") then
		UnitFrames.Boss(self)
	elseif unit:find("arena%d") then
		UnitFrames.Arena(self)
	elseif unit:match("nameplate") then
		UnitFrames.Nameplates(self)
	end

	return self
end

function UnitFrames:CreateUnits()
	local Movers = T["Movers"]

	if C.UnitFrames.Enable then
		local Player = oUF:Spawn("player", "TukuiPlayerFrame")
		Player:SetPoint("BOTTOM", T.PetHider, "BOTTOM", -235, 102)
		Player:SetParent(T.PetHider)
		Player:SetSize(250, 57)

		local Target = oUF:Spawn("target", "TukuiTargetFrame")
		Target:SetPoint("BOTTOM", T.PetHider, "BOTTOM", 235, 102)
		Target:SetParent(T.PetHider)
		Target:SetSize(250, 57)

		local TargetOfTarget = oUF:Spawn("targettarget", "TukuiTargetTargetFrame")
		TargetOfTarget:SetPoint("BOTTOM", T.PetHider, "BOTTOM", 0, 102)
		TargetOfTarget:SetParent(T.PetHider)
		TargetOfTarget:SetSize(130, 36)

		local Pet = oUF:Spawn("pet", "TukuiPetFrame")
		Pet:SetParent(T.PetHider)
		Pet:SetPoint("BOTTOM", T.PetHider, "BOTTOM", 0, 176)
		Pet:SetSize(130, 36)

		local Focus = oUF:Spawn("focus", "TukuiFocusFrame")
		Focus:SetPoint("BOTTOM", T.PetHider, "BOTTOM", -279, 316)
		Focus:SetParent(T.PetHider)
		Focus:SetSize(164, 20)

		local FocusTarget = oUF:Spawn("focustarget", "TukuiFocusTargetFrame")
		FocusTarget:SetPoint("BOTTOM", Focus, "TOP", 0, 62)
		FocusTarget:SetParent(T.PetHider)
		FocusTarget:SetSize(164, 20)

		self.Units.Player = Player
		self.Units.Target = Target
		self.Units.TargetOfTarget = TargetOfTarget
		self.Units.Pet = Pet
		self.Units.Focus = Focus
		self.Units.FocusTarget = FocusTarget

		if C.Party.Enable then
			local Party = oUF:SpawnHeader(UnitFrames:GetPartyFramesAttributes())

			Party:SetParent(T.PetHider)
			Party:SetPoint("LEFT", T.PetHider, "LEFT", 28, 0)

			if C.Party.ShowPets then
				local Pet = oUF:SpawnHeader(UnitFrames:GetPetPartyFramesAttributes())
				Pet:SetParent(T.PetHider)
				Pet:SetPoint("TOPLEFT", T.PetHider, "TOPLEFT", 28, -28)

				UnitFrames.Headers.RaidPet = Pet

				Movers:RegisterFrame(Pet, "Pet")
			end

			UnitFrames.Headers.Party = Party

			Movers:RegisterFrame(Party, "Party")
		end

		if C.Raid.Enable then
			local Raid = oUF:SpawnHeader(UnitFrames:GetRaidFramesAttributes())
			Raid:SetParent(T.PetHider)
			Raid:SetPoint("LEFT", T.PetHider, "LEFT", 28, 100)

			if C.Raid.ShowPets then
				local Pet = oUF:SpawnHeader(UnitFrames:GetPetRaidFramesAttributes())
				Pet:SetParent(T.PetHider)
				Pet:SetPoint("TOPLEFT", Raid, "TOPRIGHT", C.Raid.Padding, 0)

				UnitFrames.Headers.RaidPet = Pet

				Movers:RegisterFrame(Pet, "Raid Pets")
			end

			local Raid40 = oUF:SpawnHeader(UnitFrames:GetBigRaidFramesAttributes())
			Raid40:SetParent(T.PetHider)
			Raid40:SetPoint("TOPLEFT", T.PetHider, "TOPLEFT", 30, -30)

			if C.Raid.ShowPets then
				local Pet40 = oUF:SpawnHeader(UnitFrames:GetBigPetRaidFramesAttributes())
				Pet40:SetParent(T.PetHider)
				Pet40:SetPoint("TOPLEFT", Raid40, "TOPRIGHT", C.Raid.Padding40, 0)

				UnitFrames.Headers.Raid40Pet = Pet40

				Movers:RegisterFrame(Pet40, "Raid 26/40 Pets")
			end

			UnitFrames.Headers.Raid = Raid
			UnitFrames.Headers.Raid40 = Raid40

			Movers:RegisterFrame(Raid, "Raid")
			Movers:RegisterFrame(Raid40, "Raid 26/40")
		end

		if (C.UnitFrames.Arena) then
			local Arena = {}

			for i = 1, 5 do
				Arena[i] = oUF:Spawn("arena"..i, "TukuiArenaFrame"..i)
				Arena[i]:SetParent(T.PetHider)
				if (i == 1) then
					Arena[i]:SetPoint("BOTTOM", T.PetHider, "BOTTOM", 279, 316)
				else
					Arena[i]:SetPoint("BOTTOM", Arena[i - 1], "TOP", 0, 62)
				end
				Arena[i]:SetSize(164, 20)

				if i == 1 then
					Movers:RegisterFrame(Arena[i], "Arena Frames")
				end
			end

			self.Units.Arena = Arena

			SetCVar("showArenaEnemyFrames", 0)
		end


		if (C.UnitFrames.Boss) then
			local Boss = {}

			for i = 1, 5 do
				Boss[i] = oUF:Spawn("boss"..i, "TukuiBossFrame"..i)
				Boss[i]:SetParent(T.PetHider)
				if (i == 1) then
					Boss[i]:SetPoint("BOTTOM", T.PetHider, "BOTTOM", 279, 316)
				else
					Boss[i]:SetPoint("BOTTOM", Boss[i - 1], "TOP", 0, 62)
				end
				Boss[i]:SetSize(164, 20)

				if i == 1 then
					Movers:RegisterFrame(Boss[i], "Boss Frames")
				end
			end

			self.Units.Boss = Boss
		end

		Movers:RegisterFrame(Player, "Player")
		Movers:RegisterFrame(Target, "Target")
		Movers:RegisterFrame(TargetOfTarget, "Target of Target")
		Movers:RegisterFrame(Pet, "Pet")
		Movers:RegisterFrame(Focus, "Focus")
		Movers:RegisterFrame(FocusTarget, "Focus Target")
	end

	if C.NamePlates.Enable then
		if T.Retail then
			local PersonalResource = ClassNameplateManaBarFrame

			-- No need for this bar, already included with oUF
			PersonalResource:SetAlpha(0)
		end

		-- Add threat colors (https://wowpedia.fandom.com/wiki/API_UnitThreatSituation)
		oUF.colors.threat = {
			[0] = C.NamePlates.AggroColor1,
			[1] = C.NamePlates.AggroColor2,
			[2] = C.NamePlates.AggroColor3,
			[3] = C.NamePlates.AggroColor4,
		}

		oUF:SpawnNamePlates("Tukui", nil, UnitFrames.NameplatesVariables)
	end
end

function UnitFrames:UpdateRaidDebuffIndicator()
	local ORD = Plugin.oUF_RaidDebuffs or oUF_RaidDebuffs

	if (ORD) then
		local _, InstanceType = IsInInstance()

		ORD:ResetDebuffData()

		if (InstanceType == "party" or InstanceType == "raid") then
			if C.Raid.DebuffWatchDefault then
				ORD:RegisterDebuffs(UnitFrames.Debuffs.PvE.spells)
			end

			ORD:RegisterDebuffs(TukuiDatabase.Variables[T.MyRealm][T.MyName].Tracking.PvE)
		else
			if C.Raid.DebuffWatchDefault then
				ORD:RegisterDebuffs(UnitFrames.Debuffs.PvP.spells)
			end

			ORD:RegisterDebuffs(TukuiDatabase.Variables[T.MyRealm][T.MyName].Tracking.PvP)
		end
	end
end

function UnitFrames:Enable()
	-- Enable HealComm lib
	if not T.Retail and C.UnitFrames.HealComm then
		HealComm:PLAYER_LOGIN()
	end

	-- Security for Nameplates
	if IsAddOnLoaded("Plater") then
		-- Force Tukui nameplates OFF if running plater, because causing issues
		C.NamePlates.Enable = false
	end

	self.Backdrop = {
		bgFile = C.Medias.Blank,
		insets = {top = -1, left = -1, bottom = -1, right = -1}
	}

	self.HighlightBorder = {
		bgFile = "Interface\\Buttons\\WHITE8x8",
		insets = {top = -2, left = -2, bottom = -2, right = -2}
	}

	self.NameplatesVariables = {
		nameplateMaxAlpha = 1,
		nameplateMinAlpha = C.NamePlates.NotSelectedAlpha / 100,
		nameplateSelectedAlpha = 1,
		nameplateNotSelectedAlpha = C.NamePlates.NotSelectedAlpha / 100,
		nameplateOccludedAlphaMult = 1,
		nameplateMaxAlphaDistance = 0,
		nameplateMaxScale = 1,
		nameplateMinScale = 1,
		nameplateSelectedScale = C.NamePlates.SelectedScale / 100,
		nameplateMaxDistance = T.Retail and 61 or 41
	}

	oUF:RegisterStyle("Tukui", UnitFrames.Style)
	oUF:SetActiveStyle("Tukui")

	self:DisableBlizzard()
	self:CreateUnits()

	if (C.Raid.DebuffWatch) then
		local ORD = Plugin.oUF_RaidDebuffs or oUF_RaidDebuffs
		local RaidDebuffs = CreateFrame("Frame")

		RaidDebuffs:RegisterEvent("PLAYER_ENTERING_WORLD")
		RaidDebuffs:SetScript("OnEvent", UnitFrames.UpdateRaidDebuffIndicator)

		if (ORD) then
			ORD.ShowDispellableDebuff = true
			ORD.FilterDispellableDebuff = true
			ORD.MatchBySpellName = false
		end

		self.Tracking:Enable()
	end

	-- Overwrite oUF Pet Battle frame visibility
	RegisterStateDriver(Tukui_PetBattleFrameHider, "visibility", "hide")
end
