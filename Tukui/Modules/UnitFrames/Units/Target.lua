local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]
local Movers = T["Movers"]
local Class = select(2, UnitClass("player"))

function UnitFrames:Target()
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
	Panel:CreateBackdrop()
	Panel:SetSize(250, 21)
	Panel:SetPoint("BOTTOM", self, "BOTTOM", 0, 0)
	Panel:SetFrameLevel(3)
	Panel.Backdrop:SetBorderColor(0, 0, 0, 0)

	local Health = CreateFrame("StatusBar", nil, self)
	Health:SetFrameStrata(self:GetFrameStrata())
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
	Health.colorTapping = true
	
	if C.NamePlates.Enable and C.NamePlates.ColorThreat then
		Health.colorThreat = C.NamePlates.ColorThreat
	end

	Health.PreUpdate = UnitFrames.PreUpdateHealth

	local Power = CreateFrame("StatusBar", nil, self)
	Power:SetFrameStrata(self:GetFrameStrata())
	Power:SetHeight(6)
	Power:SetPoint("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:SetPoint("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	Power:SetStatusBarTexture(PowerTexture)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetTexture(PowerTexture)
	Power.Background:SetAllPoints(Power)
	Power.Background.multiplier = C.UnitFrames.StatusBarBackgroundMultiplier / 100

	Power.frequentUpdates = true
	Power.colorPower = true
	
	if T.Retail then
		local AltPowerBar = CreateFrame("StatusBar", self:GetName().."AltPowerBar", Health)
		AltPowerBar:SetHeight(6)
		AltPowerBar:SetPoint("BOTTOMLEFT", Health, "BOTTOMLEFT")
		AltPowerBar:SetPoint("BOTTOMRIGHT", Health, "BOTTOMRIGHT")
		AltPowerBar:SetStatusBarTexture(HealthTexture)
		AltPowerBar:SetFrameLevel(Health:GetFrameLevel() + 1)
		AltPowerBar:CreateBackdrop()
		AltPowerBar.Backdrop:SetOutside()

		AltPowerBar.Background = AltPowerBar:CreateTexture(nil, "BORDER")
		AltPowerBar.Background:SetAllPoints(AltPowerBar)
		AltPowerBar.Background:SetTexture(HealthTexture)
		AltPowerBar.Background.multiplier = C.UnitFrames.StatusBarBackgroundMultiplier / 100

		AltPowerBar.colorSmooth = true
		
		self.AlternativePower = AltPowerBar
		self.AlternativePower.bg = AltPowerBar.Background
	end

	local Name = Panel:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("LEFT", Panel, "LEFT", 4, 0)
	Name:SetJustifyH("LEFT")
	Name:SetFontObject(Font)

	if (C.UnitFrames.CastBar) then
		local CastBar = CreateFrame("StatusBar", "TukuiTargetCastBar", self)
		CastBar:SetFrameStrata(self:GetFrameStrata())
		CastBar:SetStatusBarTexture(CastTexture)
		CastBar:SetFrameLevel(6)
		CastBar:SetInside(Panel)

		CastBar.Background = CastBar:CreateTexture(nil, "BORDER")
		CastBar.Background:SetAllPoints(CastBar)
		CastBar.Background:SetTexture(CastTexture)
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
			CastBar.Button:SetPoint("RIGHT", 46.5, 26.5)

			CastBar.Icon = CastBar.Button:CreateTexture(nil, "ARTWORK")
			CastBar.Icon:SetInside()
			CastBar.Icon:SetTexCoord(unpack(T.IconCoord))
		end

		if (C.UnitFrames.CastBarLatency) then
			CastBar.SafeZone = CastBar:CreateTexture(nil, "ARTWORK")
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
			CastBar:SetPoint("TOP", UIParent, "TOP", 0, -140)
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

			Movers:RegisterFrame(CastBar, "Target Cast Bar")
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
		Portrait:SetPoint("LEFT", self, "RIGHT", 10, 0)
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

	if (C.UnitFrames.TargetBuffs) then
		local Buffs = CreateFrame("Frame", self:GetName().."Buffs", self)

		Buffs:SetFrameStrata(self:GetFrameStrata())
		Buffs:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -1, 4)

		Buffs:SetHeight(28)
		Buffs:SetWidth(252)
		Buffs.size = 28
		Buffs.num = 40
		Buffs.numRow = 5
		Buffs.isAnimated = true
		Buffs.spacing = 4
		Buffs.initialAnchor = "TOPLEFT"
		Buffs.PostCreateIcon = UnitFrames.PostCreateAura
		Buffs.PostUpdateIcon = UnitFrames.PostUpdateAura
		Buffs.PostUpdate = C.UnitFrames.TargetDebuffs and UnitFrames.UpdateDebuffsHeaderPosition
		Buffs.onlyShowPlayer = C.UnitFrames.OnlySelfBuffs

		if C.UnitFrames.AurasBelow then
			Buffs:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, -32)
		end

		self.Buffs = Buffs
	end

	if (C.UnitFrames.TargetDebuffs) then
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
		Debuffs.onlyShowPlayer = C.UnitFrames.OnlySelfDebuffs

		if C.UnitFrames.AurasBelow then
			if not C.UnitFrames.TargetBuffs then
				Debuffs:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, -32)
			end

			Debuffs["growth-y"] = "DOWN"
		end

		self.Debuffs = Debuffs
	end

	if (C.UnitFrames.CombatLog) then
		local CombatFeedbackText = Health:CreateFontString(nil, "OVERLAY")
		CombatFeedbackText:SetFontObject(Font)
		CombatFeedbackText:SetFont(CombatFeedbackText:GetFont(), 14, "THINOUTLINE")
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

	local RaidIcon = Health:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetSize(C.UnitFrames.RaidIconSize, C.UnitFrames.RaidIconSize)
	RaidIcon:SetPoint("TOP", self, 0, C.UnitFrames.RaidIconSize / 2)
	RaidIcon:SetTexture([[Interface\AddOns\Tukui\Medias\Textures\Others\RaidIcons]])

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

	local Leader = Health:CreateTexture(nil, "OVERLAY", nil, 2)
	Leader:SetSize(14, 14)
	Leader:SetPoint("TOPLEFT", 2, 8)

	local MasterLooter = Health:CreateTexture(nil, "OVERLAY", nil, 2)
	MasterLooter:SetSize(14, 14)
	MasterLooter:SetPoint("TOPRIGHT", -2, 8)

	-- Enable smoothing bars animation?
	if C.UnitFrames.Smoothing then
		Health.smoothing = true
		Power.smoothing = true

		if self.HealthPrediction then
			self.HealthPrediction.smoothing = true
		end
	end

	self:Tag(Name, "[Tukui:Classification][Tukui:DiffColor][level] [Tukui:GetNameColor][Tukui:NameLong]")
	self:Tag(Health.Value, C.UnitFrames.TargetHealthTag.Value)
	self.Name = Name
	self.Panel = Panel
	self.Health = Health
	self.Health.bg = Health.Background
	self.Power = Power
	self.Power.bg = Power.Background
	self.RaidTargetIndicator = RaidIcon
	self.LeaderIndicator = Leader
	self.MasterLooterIndicator = MasterLooter
end
