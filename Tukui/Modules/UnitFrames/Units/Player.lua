local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]
local Movers = T["Movers"]
local Class = select(2, UnitClass("player"))

function UnitFrames:Player()
	local HealthTexture = T.GetTexture(C["Textures"].UFHealthTexture)
	local PowerTexture = T.GetTexture(C["Textures"].UFPowerTexture)
	local CastTexture = T.GetTexture(C["Textures"].UFCastTexture)
	local Font = T.GetFont(C["UnitFrames"].Font)

	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self:CreateShadow()

	self.Backdrop = CreateFrame("Frame", nil, self, "BackdropTemplate")
	self.Backdrop:SetAllPoints()
	self.Backdrop:SetFrameLevel(self:GetFrameLevel())
	self.Backdrop:SetBackdrop(UnitFrames.Backdrop)
	self.Backdrop:SetBackdropColor(0, 0, 0)

	local Panel = CreateFrame("Frame", nil, self)
	Panel:SetFrameStrata(self:GetFrameStrata())
	Panel:SetFrameLevel(3)
	Panel:CreateBackdrop()
	Panel:SetSize(250, 21)
	Panel:SetPoint("BOTTOM", self, "BOTTOM", 0, 0)
	Panel.Backdrop:SetBorderColor(0, 0, 0, 0)

	local Health = CreateFrame("StatusBar", nil, self)
	Health:SetFrameStrata(self:GetFrameStrata())
	Health:SetFrameLevel(4)
	Health:SetHeight(28)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetStatusBarTexture(HealthTexture)

	Health.Background = Health:CreateTexture(nil, "BACKGROUND")
	Health.Background:SetTexture(HealthTexture)
	Health.Background:SetAllPoints(Health)
	Health.Background.multiplier = C.UnitFrames.StatusBarBackgroundMultiplier / 100

	Health.Value = Health:CreateFontString(nil, "OVERLAY")
	Health.Value:SetFontObject(Font)
	Health.Value:SetPoint("RIGHT", Panel, "RIGHT", -4, 0)

	Health.colorDisconnected = true
	Health.colorClass = true
	Health.colorReaction = true

	local Power = CreateFrame("StatusBar", nil, self)
	Power:SetFrameStrata(self:GetFrameStrata())
	Power:SetFrameLevel(4)
	Power:SetHeight(6)
	Power:SetPoint("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:SetPoint("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	Power:SetStatusBarTexture(PowerTexture)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetTexture(PowerTexture)
	Power.Background:SetAllPoints(Power)
	Power.Background.multiplier = C.UnitFrames.StatusBarBackgroundMultiplier / 100

	Power.Value = Power:CreateFontString(nil, "OVERLAY")
	Power.Value:SetFontObject(Font)
	Power.Value:SetPoint("LEFT", Panel, "LEFT", 4, 0)

	Power.frequentUpdates = true
	Power.colorPower = true

	local Prediction = CreateFrame("StatusBar", nil, Power)
	Prediction:SetReverseFill(true)
	Prediction:SetPoint("TOP")
	Prediction:SetPoint("BOTTOM")
	Prediction:SetPoint("RIGHT", Power:GetStatusBarTexture(), "RIGHT")
	Prediction:SetWidth(250)
	Prediction:SetStatusBarTexture(PowerTexture)
	Prediction:SetStatusBarColor(1, 1, 1, .3)

	if T.Retail then
		local AdditionalPower = CreateFrame("StatusBar", self:GetName().."AdditionalPower", Health)
		AdditionalPower:SetHeight(6)
		AdditionalPower:SetPoint("BOTTOMLEFT", Health, "BOTTOMLEFT")
		AdditionalPower:SetPoint("BOTTOMRIGHT", Health, "BOTTOMRIGHT")
		AdditionalPower:SetStatusBarTexture(HealthTexture)
		AdditionalPower:SetFrameLevel(Health:GetFrameLevel() + 1)
		AdditionalPower:CreateBackdrop()
		AdditionalPower:SetStatusBarColor(unpack(T.Colors.power.MANA))
		AdditionalPower.Backdrop:SetOutside()

		AdditionalPower.Background = AdditionalPower:CreateTexture(nil, "BORDER")
		AdditionalPower.Background:SetAllPoints(AdditionalPower)
		AdditionalPower.Background:SetTexture(HealthTexture)
		AdditionalPower.Background:SetColorTexture(T.Colors.power.MANA[1], T.Colors.power.MANA[2], T.Colors.power.MANA[3], C.UnitFrames.StatusBarBackgroundMultiplier / 100)

		self.AdditionalPower = AdditionalPower
	end

	Power.PostUpdate = UnitFrames.PostUpdatePower

	local Name = Panel:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("LEFT", Panel, "LEFT", 4, 0)
	Name:SetJustifyH("LEFT")
	Name:SetFontObject(Font)
	Name:SetAlpha(0)

	if C.UnitFrames.PlayerAuraBars then
		local AuraBars = CreateFrame("Frame", self:GetName().."AuraBars", self)

		AuraBars:SetHeight(10)
		AuraBars:SetWidth(250)
		AuraBars:SetPoint("TOPLEFT", 0, 12)
		AuraBars.auraBarTexture = HealthTexture
		AuraBars.PostCreateBar = UnitFrames.PostCreateAuraBar
		AuraBars.onlyShowPlayer = C.UnitFrames.OnlySelfBuffs
		AuraBars.gap = 2
		AuraBars.width = 231
		AuraBars.height = 17
		AuraBars.spellNameObject = Font
		AuraBars.spellTimeObject = Font

		T.Movers:RegisterFrame(AuraBars, "Player Aura Bars")

		self.AuraBars = AuraBars
	else
		if (C.UnitFrames.PlayerBuffs) then
			local Buffs = CreateFrame("Frame", self:GetName().."Buffs", self)

			Buffs:SetFrameStrata(self:GetFrameStrata())
			Buffs:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -1, 4)

			Buffs:SetHeight(28)
			Buffs:SetWidth(252)
			Buffs.size = 28
			Buffs.num = 40
			Buffs.numRow = 5

			Buffs.spacing = 4
			Buffs.initialAnchor = "TOPLEFT"
			Buffs.PostCreateIcon = UnitFrames.PostCreateAura
			Buffs.PostUpdateIcon = UnitFrames.PostUpdateAura
			Buffs.PostUpdate = C.UnitFrames.PlayerDebuffs and UnitFrames.UpdateDebuffsHeaderPosition
			Buffs.onlyShowPlayer = C.UnitFrames.OnlySelfBuffs
			Buffs.isCancellable = true

			if C.UnitFrames.AurasBelow then
				Buffs:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, -32)
			end

			self.Buffs = Buffs
		end

		if (C.UnitFrames.PlayerDebuffs) then
			local Debuffs = CreateFrame("Frame", self:GetName().."Debuffs", self)

			Debuffs:SetFrameStrata(self:GetFrameStrata())
			Debuffs:SetHeight(28)
			Debuffs:SetWidth(252)

			if self.Buffs then
				Debuffs:SetPoint("BOTTOMLEFT", Buffs, "TOPLEFT", 0, 18)
			else
				Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 1, 4)
			end

			Debuffs.size = 28
			Debuffs.num = 40
			Debuffs.numRow = 5

			Debuffs.spacing = 4
			Debuffs.initialAnchor = "TOPRIGHT"
			Debuffs["growth-y"] = "UP"
			Debuffs["growth-x"] = "LEFT"
			Debuffs.PostCreateIcon = UnitFrames.PostCreateAura
			Debuffs.PostUpdateIcon = UnitFrames.PostUpdateAura

			if C.UnitFrames.AurasBelow then
				if not C.UnitFrames.PlayerBuffs then
					Debuffs:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, -32)
				end

				Debuffs["growth-y"] = "DOWN"
			end

			self.Debuffs = Debuffs
		end
	end

	local Combat = Health:CreateTexture(nil, "OVERLAY", nil, 1)
	Combat:SetSize(19, 19)
	Combat:SetPoint("LEFT", 0, 1)
	Combat:SetVertexColor(0.69, 0.31, 0.31)

	local Status = Panel:CreateFontString(nil, "OVERLAY", nil, 1)
	Status:SetFontObject(Font)
	Status:SetPoint("CENTER", Panel, "CENTER", 0, 0)
	Status:SetTextColor(0.69, 0.31, 0.31)
	Status:Hide()

	local Leader = Health:CreateTexture(nil, "OVERLAY", nil, 2)
	Leader:SetSize(14, 14)
	Leader:SetPoint("TOPLEFT", 2, 8)

	local MasterLooter = Health:CreateTexture(nil, "OVERLAY", nil, 2)
	MasterLooter:SetSize(14, 14)
	MasterLooter:SetPoint("TOPRIGHT", -2, 8)

	if (C.UnitFrames.CastBar) then
		local CastBar = CreateFrame("StatusBar", "TukuiPlayerCastBar", self)
		CastBar:SetFrameStrata(self:GetFrameStrata())
		CastBar:SetStatusBarTexture(CastTexture)
		CastBar:SetFrameLevel(6)
		CastBar:SetInside(Panel, 0, 0)

		CastBar.Background = CastBar:CreateTexture(nil, "BORDER")
		CastBar.Background:SetAllPoints(CastBar)
		CastBar.Background:SetTexture(C.Medias.Normal)
		CastBar.Background:SetVertexColor(0.15, 0.15, 0.15)

		CastBar.Time = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Time:SetFontObject(Font)
		CastBar.Time:SetPoint("RIGHT", Panel, "RIGHT", -4, 0)
		CastBar.Time:SetTextColor(0.84, 0.75, 0.65)
		CastBar.Time:SetJustifyH("RIGHT")

		CastBar.Text = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Text:SetFontObject(Font)
		CastBar.Text:SetPoint("LEFT", Panel, "LEFT", 4, 0)
		CastBar.Text:SetTextColor(0.84, 0.75, 0.65)
		CastBar.Text:SetWidth(166)
		CastBar.Text:SetJustifyH("LEFT")

		CastBar.Spark = CastBar:CreateTexture(nil, "OVERLAY")
		CastBar.Spark:SetSize(8, CastBar:GetHeight())
		CastBar.Spark:SetBlendMode("ADD")
		CastBar.Spark:SetPoint("CENTER", CastBar:GetStatusBarTexture(), "RIGHT", 0, 0)

		if (C.UnitFrames.CastBarIcon) then
			CastBar.Button = CreateFrame("Frame", nil, CastBar)
			CastBar.Button:SetSize(26, 26)
			CastBar.Button:CreateBackdrop()
			CastBar.Button:CreateShadow()
			CastBar.Button:SetPoint("LEFT", -46.5, 26.5)

			CastBar.Icon = CastBar.Button:CreateTexture(nil, "ARTWORK")
			CastBar.Icon:SetInside()
			CastBar.Icon:SetTexCoord(unpack(T.IconCoord))
		end

		if (C.UnitFrames.CastBarLatency) then
			CastBar.SafeZone = CastBar:CreateTexture(nil, "OVERLAY")
			CastBar.SafeZone:SetTexture(CastTexture)
			CastBar.SafeZone:SetVertexColor(0.69, 0.31, 0.31, 0.75)
		end

		CastBar.CustomTimeText = UnitFrames.CustomCastTimeText
		CastBar.CustomDelayText = UnitFrames.CustomCastDelayText
		CastBar.PostCastStart = UnitFrames.CheckCast
		CastBar.PostChannelStart = UnitFrames.CheckChannel

		if (C.UnitFrames.UnlinkCastBar) then
			CastBar:ClearAllPoints()
			CastBar:SetWidth(200)
			CastBar:SetHeight(23)
			CastBar:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 220)
			CastBar:CreateShadow()

			if (C.UnitFrames.CastBarIcon) then
				CastBar.Icon:ClearAllPoints()
				CastBar.Icon:SetPoint("RIGHT", CastBar, "LEFT", -8, 0)
				CastBar.Icon:SetSize(CastBar:GetHeight(), CastBar:GetHeight())

				CastBar.Button:ClearAllPoints()
				CastBar.Button:SetAllPoints(CastBar.Icon)
			end

			CastBar.Time:ClearAllPoints()
			CastBar.Time:SetPoint("RIGHT", CastBar, "RIGHT", -4, 0)

			CastBar.Text:ClearAllPoints()
			CastBar.Text:SetPoint("LEFT", CastBar, "LEFT", 4, 0)

			Movers:RegisterFrame(CastBar, "Player Cast Bar")
		end

		self.Castbar = CastBar
	end

	if C.UnitFrames.Portrait then
		local Portrait = CreateFrame("Frame", nil, self)

		if C.UnitFrames.Portrait2D then
			Portrait.Texture = Portrait:CreateTexture(nil, "OVERLAY")
			Portrait.Texture:SetTexCoord(0.1,0.9,0.1,0.9)
		else
			Portrait.Texture = CreateFrame("PlayerModel", nil, Portrait)
		end

		Portrait:SetSize(57, 57)
		Portrait:SetPoint("RIGHT", self, "LEFT", -10, 0)
		Portrait:CreateBackdrop()
		Portrait:CreateShadow()

		Portrait.Backdrop:SetOutside()

		Portrait.Texture:SetAllPoints(Portrait)

		if (C.UnitFrames.CastBar and C.UnitFrames.CastBarIcon) and not (C.UnitFrames.UnlinkCastBar) then
			self.Castbar.Icon:ClearAllPoints()
			self.Castbar.Icon:SetAllPoints(Portrait)
		end

		self.Portrait = Portrait.Texture
		self.Portrait.Backdrop = Portrait.Backdrop
		self.Portrait.Shadow = Portrait.Shadow
	end

	if (C.UnitFrames.CombatLog) then
		local CombatFeedbackText = Health:CreateFontString(nil, "OVERLAY", 7)
		CombatFeedbackText:SetFont(select(1, _G[Font]:GetFont()), 14, "THINOUTLINE")
		CombatFeedbackText:SetPoint("CENTER", 0, -1)
		CombatFeedbackText.colors = {
			DAMAGE = {0.69, 0.31, 0.31},
			CRUSHING = {0.69, 0.31, 0.31},
			CRITICAL = {0.69, 0.31, 0.31},
			GLANCING = {0.69, 0.31, 0.31},
			STANDARD = {0.84, 0.75, 0.65},
			IMMUNE = {0.84, 0.75, 0.65},
			ABSORB = {0.84, 0.75, 0.65},
			BLOCK = {0.84, 0.75, 0.65},
			RESIST = {0.84, 0.75, 0.65},
			MISS = {0.84, 0.75, 0.65},
			HEAL = {0.33, 0.59, 0.33},
			CRITHEAL = {0.33, 0.59, 0.33},
			ENERGIZE = {0.31, 0.45, 0.63},
			CRITENERGIZE = {0.31, 0.45, 0.63},
		}

		self.CombatFeedbackText = CombatFeedbackText
	end

	if (C.UnitFrames.ComboBar) and (Class == "ROGUE" or Class == "DRUID") then
		local ComboPoints = CreateFrame("Frame", self:GetName().."ComboPointsBar", self)

		ComboPoints:SetHeight(6)
		ComboPoints:SetPoint("TOPLEFT", Health)
		ComboPoints:SetPoint("TOPRIGHT", Health)
		ComboPoints:SetFrameLevel(Health:GetFrameLevel() + 1)

		ComboPoints:CreateBackdrop()
		ComboPoints.Backdrop:SetOutside()

		for i = 1, 6 do
			local SizeFor5 = ceil(250 / 5)
			local SizeFor6 = ceil(250 / 6)

			ComboPoints[i] = CreateFrame("StatusBar", nil, ComboPoints)
			ComboPoints[i]:SetHeight(8)
			ComboPoints[i]:SetStatusBarTexture(PowerTexture)

			if i == 1 then
				ComboPoints[i]:SetPoint("LEFT", ComboPoints, "LEFT", 0, 0)
				ComboPoints[i]:SetWidth(SizeFor6 - 2)

				ComboPoints[i].Size6Points = SizeFor6 - 2
				ComboPoints[i].Size5Points = SizeFor5
			else
				ComboPoints[i]:SetWidth(SizeFor6 - 1)
				ComboPoints[i]:SetPoint("LEFT", ComboPoints[i - 1], "RIGHT", 1, 0)

				ComboPoints[i].Size6Points = SizeFor6 - 1
				ComboPoints[i].Size5Points = SizeFor5 - 1
			end
		end

		self.ComboPointsBar = ComboPoints
	end

	local RaidIcon = Health:CreateTexture(nil, "OVERLAY", nil, 7)
	RaidIcon:SetSize(C.UnitFrames.RaidIconSize, C.UnitFrames.RaidIconSize)
	RaidIcon:SetPoint("TOP", self, 0, C.UnitFrames.RaidIconSize / 2)
	RaidIcon:SetTexture([[Interface\AddOns\Tukui\Medias\Textures\Others\RaidIcons]])

	local RestingIndicator = Health:CreateTexture(nil, "OVERLAY", nil, 7)
	RestingIndicator:SetTexture([[Interface\AddOns\Tukui\Medias\Textures\Others\Resting]])
	RestingIndicator:SetSize(24, 24)
	RestingIndicator:SetPoint("LEFT", Health, "LEFT", 4, 0)

	if C.UnitFrames.ScrollingCombatText then
		local DamageFont = T.GetFont(C.UnitFrames.ScrollingCombatTextFont)
		local DamageFontPath, DamageFontSize, DamageFontFlag = _G[DamageFont]:GetFont()

		local ScrollingCombatText = CreateFrame("Frame", "TukuiPlayerFrameScrollingCombatText", UIParent)
		ScrollingCombatText:SetSize(32, 32)
		ScrollingCombatText:SetPoint("CENTER", 0, -200)
		ScrollingCombatText.scrollTime = C.UnitFrames.ScrollingCombatTextDisplayTime
		ScrollingCombatText.font = DamageFontPath
		ScrollingCombatText.fontHeight = C.UnitFrames.ScrollingCombatTextFontSize
		ScrollingCombatText.radius = C.UnitFrames.ScrollingCombatTextRadius
		ScrollingCombatText.fontFlags = DamageFontFlag
		ScrollingCombatText.useCLEU = C.UnitFrames.ScrollingCombatTextIcon and true or false
		ScrollingCombatText.format = "%1$s |T%2$s:0:0:0:0:64:64:4:60:4:60|t"
		ScrollingCombatText.animationsByEvent = {
			["ABSORB"] = C.UnitFrames.ScrollingCombatTextAnim.Value,
			["BLOCK"] = C.UnitFrames.ScrollingCombatTextAnim.Value,
			["DEFLECT"] = C.UnitFrames.ScrollingCombatTextAnim.Value,
			["DODGE"] = C.UnitFrames.ScrollingCombatTextAnim.Value,
			["ENERGIZE"] = C.UnitFrames.ScrollingCombatTextAnim.Value,
			["EVADE"] = C.UnitFrames.ScrollingCombatTextAnim.Value,
			["HEAL"] = C.UnitFrames.ScrollingCombatTextAnim.Value,
			["IMMUNE"] = C.UnitFrames.ScrollingCombatTextAnim.Value,
			["INTERRUPT"] = C.UnitFrames.ScrollingCombatTextAnim.Value,
			["MISS"] = C.UnitFrames.ScrollingCombatTextAnim.Value,
			["PARRY"] = C.UnitFrames.ScrollingCombatTextAnim.Value,
			["REFLECT"] = C.UnitFrames.ScrollingCombatTextAnim.Value,
			["RESIST"] = C.UnitFrames.ScrollingCombatTextAnim.Value,
			["WOUND"] = C.UnitFrames.ScrollingCombatTextAnim.Value,
			["COMBAT"   ] = C.UnitFrames.ScrollingCombatTextAnim.Value,
		}

		for i = 1, 6 do
			ScrollingCombatText[i] = ScrollingCombatText:CreateFontString("TukuiPlayerFrameScrollingCombatTextFont" .. i, "OVERLAY")
		end

		self.FloatingCombatFeedback = ScrollingCombatText

		T.Movers:RegisterFrame(ScrollingCombatText, "Scrolling Combat Text")
	end

	if (T.Classic or T.BCC) and C.UnitFrames.PowerTick then
		local EnergyManaRegen = CreateFrame("StatusBar", nil, Power)

		EnergyManaRegen:SetFrameLevel(Power:GetFrameLevel() + 3)
		EnergyManaRegen:SetAllPoints()
		EnergyManaRegen.Spark = EnergyManaRegen:CreateTexture(nil, "OVERLAY")

		self.EnergyManaRegen = EnergyManaRegen
	end

	self:HookScript("OnEnter", UnitFrames.ShowWarMode)
	self:HookScript("OnLeave", UnitFrames.ShowWarMode)

	if C.UnitFrames.HealComm then
		local myBar = CreateFrame("StatusBar", nil, Health)
		local otherBar = CreateFrame("StatusBar", nil, Health)
		local absorbBar = CreateFrame("StatusBar", nil, Health)

		myBar:SetFrameLevel(Health:GetFrameLevel())
		myBar:SetStatusBarTexture(HealthTexture)
		myBar:SetPoint("TOP")
		myBar:SetPoint("BOTTOM")
		myBar:SetPoint("LEFT", Health:GetStatusBarTexture(), "RIGHT")
		myBar:SetWidth(250)
		myBar:SetStatusBarColor(unpack(C.UnitFrames.HealCommSelfColor))
		myBar:SetMinMaxValues(0, 1)
		myBar:SetValue(0)

		otherBar:SetFrameLevel(Health:GetFrameLevel())
		otherBar:SetPoint("TOP")
		otherBar:SetPoint("BOTTOM")
		otherBar:SetPoint("LEFT", myBar:GetStatusBarTexture(), "RIGHT")
		otherBar:SetWidth(250)
		otherBar:SetStatusBarTexture(HealthTexture)
		otherBar:SetStatusBarColor(unpack(C.UnitFrames.HealCommOtherColor))
		otherBar:SetMinMaxValues(0, 1)
		otherBar:SetValue(0)

		absorbBar:SetFrameLevel(Health:GetFrameLevel())
		absorbBar:SetPoint("TOP")
		absorbBar:SetPoint("BOTTOM")
		absorbBar:SetPoint("LEFT", otherBar:GetStatusBarTexture(), "RIGHT")
		absorbBar:SetWidth(250)
		absorbBar:SetStatusBarTexture(HealthTexture)
		absorbBar:SetStatusBarColor(unpack(C.UnitFrames.HealCommAbsorbColor))
		absorbBar:SetMinMaxValues(0, 1)
		absorbBar:SetValue(0)

		local HealthPrediction = {
			myBar = myBar,
			otherBar = otherBar,
			absorbBar = absorbBar,
			maxOverflow = 1,
		}

		self.HealthPrediction = HealthPrediction
	end

	if (C.UnitFrames.TotemBar) then
		local Bar = CreateFrame("Frame", "TukuiTotemBar", self)

		if C.UnitFrames.TotemBarStyle.Value == "On Screen" then
			Bar:SetFrameStrata(self:GetFrameStrata())
			Bar:SetPoint("CENTER", UIParent, "CENTER", 0, -250)
			Bar:SetSize(140, 32)

			-- Totem Bar
			for i = 1, MAX_TOTEMS do
				Bar[i] = CreateFrame("Button", "TukuiTotemBarSlot"..i, Bar)
				Bar[i]:CreateBackdrop()
				Bar[i]:SetHeight(32)
				Bar[i]:SetWidth(32)

				Bar[i].Backdrop:SetParent(Bar)
				Bar[i].Backdrop:SetFrameLevel(Bar[i]:GetFrameLevel() - 1)
				Bar[i].Backdrop:CreateShadow()

				Bar[i].Backdrop.BackgroundTexture = Bar[i].Backdrop:CreateTexture(nil, "OVERLAY", 1)
				Bar[i].Backdrop.BackgroundTexture:SetAllPoints(Bar[i].Backdrop)
				Bar[i].Backdrop.BackgroundTexture:SetTexture(C.Medias.Blank)
				Bar[i].Backdrop.BackgroundTexture:SetVertexColor(unpack(T.Colors.totems[i]))

				Bar[i].Text = Bar[i]:CreateFontString(nil, "OVERLAY")
				Bar[i].Text:SetPoint("CENTER", 1, 0)
				Bar[i].Text:SetFontTemplate(C.Medias.Font, 16)

				if i == 1 then
					Bar[i]:SetPoint("TOPLEFT", Bar, "TOPLEFT", 0, 0)
				else
					Bar[i]:SetPoint("LEFT", Bar[i-1], "RIGHT", 4, 0)
				end

				Bar[i].Icon = Bar[i]:CreateTexture(nil, "BORDER", 7)
				Bar[i].Icon:SetInside()
				Bar[i].Icon:SetAlpha(1)
				Bar[i].Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

				Bar[i].Cooldown = CreateFrame("Cooldown", nil, Bar[i], "CooldownFrameTemplate")
				Bar[i].Cooldown:SetInside()
				Bar[i].Cooldown:SetFrameLevel(Bar[i]:GetFrameLevel())
			end

			Movers:RegisterFrame(Bar, "Totem Bar")
		elseif C.UnitFrames.TotemBarStyle.Value == "On Player" then
			Bar:SetPoint("TOPLEFT", self, "TOPLEFT", -1, 10)
			Bar:SetFrameStrata(Health:GetFrameStrata())
			Bar:SetFrameLevel(Health:GetFrameLevel() + 3)
			Bar:SetSize(252, 10)
			Bar:CreateBackdrop()

			for i = 1, 4 do
				local r, g, b = unpack(T.Colors.totems[i])

				Bar[i] = CreateFrame("StatusBar", self:GetName().."Totem"..i, Bar)
				Bar[i]:SetStatusBarTexture(HealthTexture)
				Bar[i]:SetStatusBarColor(r, g, b)
				Bar[i]:SetMinMaxValues(0, 1)
				Bar[i]:SetValue(0)

				if i == 1 then
					Bar[i]:SetPoint("TOPLEFT", Bar, "TOPLEFT", 1, -1)
					Bar[i]:SetSize(61, 8)
				else
					Bar[i]:SetPoint("TOPLEFT", Bar[i-1], "TOPRIGHT", 1, 0)
					Bar[i]:SetSize(62, 8)
				end

				Bar[i].Background = Bar[i]:CreateTexture(nil, "BORDER")
				Bar[i].Background:SetParent(Bar)
				Bar[i].Background:SetAllPoints(Bar[i])
				Bar[i].Background:SetTexture(HealthTexture)
				Bar[i].Background:SetVertexColor(r, g, b)
				Bar[i].Background:SetAlpha(.15)
			end

			self.Shadow:SetPoint("TOPLEFT", -4, 12)

			if self.AuraBars then
				self.AuraBars:ClearAllPoints()
				self.AuraBars:SetPoint("TOPLEFT", 0, 22)
			elseif self.Buffs then
				self.Buffs:ClearAllPoints()
				self.Buffs:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 13)
			end
		end

		if not T.Classic then
			-- To allow right-click destroy totem.
			TotemFrame:SetParent(UIParent)
		end

		self.Totems = Bar
		self.Totems.Override = UnitFrames.UpdateTotemOverride
	end

	local Status = Health:CreateTexture(nil, "OVERLAY", nil, 7)
	Status:SetTexture("Interface\\PvPRankBadges\\PvPRank"..T.MyFaction)
	Status:SetSize(24, 24)
	Status:SetPoint("LEFT", Health, "LEFT", 4, 0)
	Status:Hide()

	self:HookScript("OnEnter", UnitFrames.ShowWarMode)
	self:HookScript("OnLeave", UnitFrames.ShowWarMode)

	-- Register with oUF
	self:Tag(Name, "[Tukui:Classification][Tukui:DiffColor][level] [Tukui:GetNameColor][Tukui:NameLong]")
	self:Tag(Health.Value, C.UnitFrames.PlayerHealthTag.Value)
	self.Panel = Panel
	self.Health = Health
	self.Health.bg = Health.Background
	self.Power = Power
	self.PowerPrediction = {}
	self.PowerPrediction.mainBar = Prediction
	self.Name = Name
	self.Power.bg = Power.Background
	self.CombatIndicator = Combat
	self.Status = Status
	self.LeaderIndicator = Leader
	self.MasterLooterIndicator = MasterLooter
	self.RaidTargetIndicator = RaidIcon
	self.RestingIndicator = RestingIndicator

	-- Enable smoothing bars animation?
	if C.UnitFrames.Smoothing then
		Health.smoothing = true
		Power.smoothing = true

		if self.HealthPrediction then
			self.HealthPrediction.smoothing = true
		end
	end

	-- Classes
	UnitFrames.AddClassFeatures[Class](self)

	if C.UnitFrames.OOCNameLevel then
		self:RegisterEvent("PLAYER_REGEN_ENABLED", UnitFrames.DisplayPlayerAndPetNames, true)
		self:RegisterEvent("PLAYER_REGEN_DISABLED", UnitFrames.DisplayPlayerAndPetNames, true)

		UnitFrames.DisplayPlayerAndPetNames(self, "PLAYER_REGEN_ENABLED")
	end
end
