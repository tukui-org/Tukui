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

	Health.PostUpdate = UnitFrames.PostUpdateHealth

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

	Power.Prediction = CreateFrame("StatusBar", nil, Power)
	Power.Prediction:SetReverseFill(true)
	Power.Prediction:SetPoint("TOP")
	Power.Prediction:SetPoint("BOTTOM")
	Power.Prediction:SetPoint("RIGHT", Power:GetStatusBarTexture(), "RIGHT")
	Power.Prediction:SetWidth(250)
	Power.Prediction:SetStatusBarTexture(PowerTexture)
	Power.Prediction:SetStatusBarColor(1, 1, 1, .3)

	Power.PostUpdate = UnitFrames.PostUpdatePower

	local Name = Panel:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("LEFT", Panel, "LEFT", 4, 0)
	Name:SetJustifyH("LEFT")
	Name:SetFontObject(Font)
	Name:SetAlpha(0)

	if C.UnitFrames.PlayerAuras and C.UnitFrames.PlayerAuraBars then
		local Gap = (T.MyClass == "ROGUE" or T.MyClass == "DRUID") and 8 or 0
		local AuraBars = CreateFrame("Frame", self:GetName().."AuraBars", self)

		AuraBars:SetHeight(10)
		AuraBars:SetWidth(250)
		AuraBars:SetPoint("TOPLEFT", 0, 12 + Gap)
		AuraBars.auraBarTexture = HealthTexture
		AuraBars.PostCreateBar = UnitFrames.PostCreateAuraBar
		AuraBars.onlyShowPlayer = C.UnitFrames.OnlySelfBuffs
		AuraBars.gap = 2
		AuraBars.width = 231
		AuraBars.height = 17
		AuraBars.spellNameObject = Font
		AuraBars.spellTimeObject = Font

		T.Movers:RegisterFrame(AuraBars)

		self.AuraBars = AuraBars
	elseif (C.UnitFrames.PlayerAuras) then
		local Buffs = CreateFrame("Frame", self:GetName().."Buffs", self)
		local Debuffs = CreateFrame("Frame", self:GetName().."Debuffs", self)

		Buffs:SetFrameStrata(self:GetFrameStrata())
		Buffs:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -1, 4)

		Buffs:SetHeight(28)
		Buffs:SetWidth(252)
		Buffs.size = 28
		Buffs.num = 32
		Buffs.numRow = 4

		Debuffs:SetFrameStrata(self:GetFrameStrata())
		Debuffs:SetHeight(28)
		Debuffs:SetWidth(252)
		Debuffs:SetPoint("BOTTOMLEFT", Buffs, "TOPLEFT", 0, 18)
		Debuffs.size = 28
		Debuffs.num = 16
		Debuffs.numRow = 2

		Buffs.spacing = 4
		Buffs.initialAnchor = "TOPLEFT"
		Buffs.PostCreateIcon = UnitFrames.PostCreateAura
		Buffs.PostUpdateIcon = UnitFrames.PostUpdateAura
		Buffs.PostUpdate = UnitFrames.UpdateDebuffsHeaderPosition
		Buffs.onlyShowPlayer = C.UnitFrames.OnlySelfBuffs
		Buffs.isCancellable = true

		Debuffs.spacing = 4
		Debuffs.initialAnchor = "TOPRIGHT"
		Debuffs["growth-y"] = "UP"
		Debuffs["growth-x"] = "LEFT"
		Debuffs.PostCreateIcon = UnitFrames.PostCreateAura
		Debuffs.PostUpdateIcon = UnitFrames.PostUpdateAura

		if C.UnitFrames.AurasBelow then
			Buffs:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, -32)
			Debuffs["growth-y"] = "DOWN"
		end

		self.Buffs = Buffs
		self.Debuffs = Debuffs
	end

	local Combat = Health:CreateTexture(nil, "OVERLAY", 1)
	Combat:SetSize(19, 19)
	Combat:SetPoint("LEFT", 0, 1)
	Combat:SetVertexColor(0.69, 0.31, 0.31)

	local Status = Panel:CreateFontString(nil, "OVERLAY", 1)
	Status:SetFontObject(Font)
	Status:SetPoint("CENTER", Panel, "CENTER", 0, 0)
	Status:SetTextColor(0.69, 0.31, 0.31)
	Status:Hide()

	local Leader = Health:CreateTexture(nil, "OVERLAY", 2)
	Leader:SetSize(14, 14)
	Leader:SetPoint("TOPLEFT", 2, 8)

	local MasterLooter = Health:CreateTexture(nil, "OVERLAY", 2)
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

			Movers:RegisterFrame(CastBar)
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

	if (C.UnitFrames.ComboBar) and (Class == "ROGUE" or Class == "DRUID") then
		local ComboPoints = CreateFrame("Frame", self:GetName().."ComboPointsBar", self)
		
		ComboPoints:SetHeight(6)
		ComboPoints:SetPoint("BOTTOMLEFT", Health)
		ComboPoints:SetPoint("BOTTOMRIGHT", Health)
		ComboPoints:SetFrameLevel(Health:GetFrameLevel() + 1)
		
		ComboPoints:CreateBackdrop()
		ComboPoints.Backdrop:SetOutside()

		for i = 1, 5 do
			ComboPoints[i] = CreateFrame("StatusBar", nil, ComboPoints)
			ComboPoints[i]:SetHeight(6)
			ComboPoints[i]:SetStatusBarTexture(PowerTexture)

			if i == 1 then
				ComboPoints[i]:SetPoint("LEFT", ComboPoints, "LEFT", 0, 0)
				ComboPoints[i]:SetWidth((250 / 5))
			else
				ComboPoints[i]:SetWidth((250 / 5) - 1)
				ComboPoints[i]:SetPoint("LEFT", ComboPoints[i - 1], "RIGHT", 1, 0)
			end
		end

		self.ComboPointsBar = ComboPoints
	end

	local RaidIcon = Health:CreateTexture(nil, "OVERLAY", 7)
	RaidIcon:SetSize(C.UnitFrames.RaidIconSize, C.UnitFrames.RaidIconSize)
	RaidIcon:SetPoint("TOP", self, 0, C.UnitFrames.RaidIconSize / 2)
	RaidIcon:SetTexture([[Interface\AddOns\Tukui\Medias\Textures\Others\RaidIcons]])

	local RestingIndicator = Panel:CreateTexture(nil, "OVERLAY", 7)
	RestingIndicator:SetTexture([[Interface\AddOns\Tukui\Medias\Textures\Others\Resting]])
	RestingIndicator:SetSize(20, 20)
	RestingIndicator:SetPoint("CENTER", Panel, "CENTER", 0, 0)

	if C.UnitFrames.ScrollingCombatText then
		local DamageFont = T.GetFont(C.UnitFrames.ScrollingCombatTextFont)
		local DamageFontPath, DamageFontSize, DamageFontFlag = _G[DamageFont]:GetFont()

		local ScrollingCombatText = CreateFrame("Frame", "TukuiPlayerFrameScrollingCombatText", UIParent)
		ScrollingCombatText:SetSize(32, 32)
		ScrollingCombatText:SetPoint("CENTER", 0, -(T.ScreenHeight / 8))
		ScrollingCombatText.scrollTime = 1.5
		ScrollingCombatText.font = DamageFontPath
		ScrollingCombatText.fontHeight = C.UnitFrames.ScrollingCombatTextFontSize
		ScrollingCombatText.radius = 100
		ScrollingCombatText.fontFlags = DamageFontFlag

		for i = 1, 6 do
			ScrollingCombatText[i] = ScrollingCombatText:CreateFontString("TukuiPlayerFrameScrollingCombatTextFont" .. i, "OVERLAY")
		end

		self.FloatingCombatFeedback = ScrollingCombatText

		T.Movers:RegisterFrame(ScrollingCombatText)
	end

	if C.UnitFrames.HealComm then
		local myBar = CreateFrame("StatusBar", nil, Health)
		local otherBar = CreateFrame("StatusBar", nil, Health)

		myBar:SetFrameLevel(Health:GetFrameLevel())
		myBar:SetStatusBarTexture(HealthTexture)
		myBar:SetPoint("TOP")
		myBar:SetPoint("BOTTOM")
		myBar:SetPoint("LEFT", Health:GetStatusBarTexture(), "RIGHT")
		myBar:SetWidth(250)
		myBar:SetStatusBarColor(unpack(C.UnitFrames.HealCommSelfColor))

		otherBar:SetFrameLevel(Health:GetFrameLevel())
		otherBar:SetPoint("TOP")
		otherBar:SetPoint("BOTTOM")
		otherBar:SetPoint("LEFT", myBar:GetStatusBarTexture(), "RIGHT")
		otherBar:SetWidth(250)
		otherBar:SetStatusBarTexture(HealthTexture)
		otherBar:SetStatusBarColor(unpack(C.UnitFrames.HealCommOtherColor))

		local HealthPrediction = {
			myBar = myBar,
			otherBar = otherBar,
			maxOverflow = 1,
		}

		self.HealthPrediction = HealthPrediction
	end
	
	if (C.UnitFrames.TotemBar) then
		local Bar = CreateFrame("Frame", "TukuiTotemBar", self)
		
		Bar:SetFrameStrata(self:GetFrameStrata())
		Bar:SetPoint("TOPLEFT", Minimap, "BOTTOMLEFT", -1, -42)
		Bar:SetSize(Minimap:GetWidth(), 16)

		Bar.Override = UnitFrames.UpdateTotemOverride

		-- Totem Bar
		for i = 1, MAX_TOTEMS do
			Bar[i] = CreateFrame("Button", "TukuiTotemBarSlot"..i, Bar)
			Bar[i]:CreateBackdrop()
			Bar[i]:SetHeight(32)
			Bar[i]:SetWidth(32)
			Bar[i]:SetFrameLevel(Health:GetFrameLevel())
			Bar[i]:CreateShadow()
			
			Bar[i].Text = Bar[i]:CreateFontString(nil, "OVERLAY")
			Bar[i].Text:SetPoint("CENTER", 1, 0)
			Bar[i].Text:SetFontTemplate(C.Medias.Font, 16)

			if i == 1 then
				Bar[i]:SetPoint("BOTTOMRIGHT", Bar, "BOTTOMRIGHT", 0, 0)
			else
				Bar[i]:SetPoint("BOTTOMRIGHT", Bar[i-1], "BOTTOMRIGHT", -36, 0)
			end

			Bar[i].Icon = Bar[i]:CreateTexture(nil, "BORDER")
			Bar[i].Icon:SetInside()
			Bar[i].Icon:SetAlpha(1)
			Bar[i].Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

			Bar[i].Cooldown = CreateFrame("Cooldown", nil, Bar[i], "CooldownFrameTemplate")
			Bar[i].Cooldown:SetInside()
			Bar[i].Cooldown:SetFrameLevel(Bar[i]:GetFrameLevel())
		end

		Movers:RegisterFrame(Bar)

		-- To allow right-click destroy totem.
		TotemFrame:SetParent(UIParent)

		self.Totems = Bar
	end


	self:HookScript("OnEnter", UnitFrames.MouseOnPlayer)
	self:HookScript("OnLeave", UnitFrames.MouseOnPlayer)

	-- Register with oUF
	self:Tag(Name, "[Tukui:GetNameColor][Tukui:NameLong] [Tukui:Classification][Tukui:DiffColor][level]")
	self.Panel = Panel
	self.Health = Health
	self.Health.bg = Health.Background
	self.Power = Power
	self.Name = Name
	self.Power.bg = Power.Background
	self.CombatIndicator = Combat
	self.Status = Status
	self.LeaderIndicator = Leader
	self.MasterLooterIndicator = MasterLooter
	self.RaidTargetIndicator = RaidIcon
	self.PowerPrediction = {}
	self.PowerPrediction.mainBar = Power.Prediction
	self.RestingIndicator = RestingIndicator

	-- Classes
	UnitFrames.AddClassFeatures[Class](self)

	if C.UnitFrames.OOCNameLevel then
		self:RegisterEvent("PLAYER_REGEN_ENABLED", UnitFrames.DisplayPlayerAndPetNames, true)
		self:RegisterEvent("PLAYER_REGEN_DISABLED", UnitFrames.DisplayPlayerAndPetNames, true)

		UnitFrames.DisplayPlayerAndPetNames(self, "PLAYER_REGEN_ENABLED")
	end
end
