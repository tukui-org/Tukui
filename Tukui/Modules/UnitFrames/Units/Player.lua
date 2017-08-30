local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Movers = T["Movers"]
local Class = select(2, UnitClass("player"))

function TukuiUnitFrames:Player()
	local HealthTexture = T.GetTexture(C["UnitFrames"].HealthTexture)
	local PowerTexture = T.GetTexture(C["UnitFrames"].PowerTexture)
	local CastTexture = T.GetTexture(C["UnitFrames"].CastTexture)
	local Font = T.GetFont(C["UnitFrames"].Font)
	local DarkTheme = C["UnitFrames"].DarkTheme

	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self:SetBackdrop(TukuiUnitFrames.Backdrop)
	self:SetBackdropColor(0, 0, 0)
	self:CreateShadow()

	local Panel = CreateFrame("Frame", nil, self)
	Panel:SetFrameStrata(self:GetFrameStrata())
	Panel:SetFrameLevel(2)
	Panel:SetTemplate()
	Panel:Size(250, 21)
	Panel:Point("BOTTOM", self, "BOTTOM", 0, 0)
	Panel:SetBackdropBorderColor(C["General"].BorderColor[1] * 0.7, C["General"].BorderColor[2] * 0.7, C["General"].BorderColor[3] * 0.7)

	local Health = CreateFrame("StatusBar", nil, self)
	Health:SetFrameStrata(self:GetFrameStrata())
	Health:SetFrameLevel(4)
	Health:Height(26)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetStatusBarTexture(HealthTexture)

	Health.Background = Health:CreateTexture(nil, "BACKGROUND")
	Health.Background:SetAllPoints()
	Health.Background:SetColorTexture(.1, .1, .1)

	Health.Value = Health:CreateFontString(nil, "OVERLAY")
	Health.Value:SetFontObject(Font)
	Health.Value:Point("RIGHT", Panel, "RIGHT", -4, 0)

	if DarkTheme then
		Health.colorTapping = false
		Health.colorDisconnected = false
		Health.colorClass = false
		Health:SetStatusBarColor(0.2, 0.2, 0.2, 1)
		Health.Background:SetVertexColor(0, 0, 0, 1)
	else
		Health.colorTapping = true
		Health.colorDisconnected = true
		Health.colorClass = true
		Health.colorReaction = true
	end

	if (C.UnitFrames.Smooth) then
		Health.Smooth = true
	end

	Health.frequentUpdates = true

	Health.PostUpdate = TukuiUnitFrames.PostUpdateHealth

	local Power = CreateFrame("StatusBar", nil, self)
	Power:SetFrameStrata(self:GetFrameStrata())
	Power:SetFrameLevel(4)
	Power:Height(8)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	Power:SetStatusBarTexture(PowerTexture)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints()
	Power.Background:SetColorTexture(.4, .4, .4)
	Power.Background.multiplier = 0.3

	Power.Value = Power:CreateFontString(nil, "OVERLAY")
	Power.Value:SetFontObject(Font)
	Power.Value:Point("LEFT", Panel, "LEFT", 4, 0)

	Power.frequentUpdates = true

	if DarkTheme then
		Power.colorTapping = true
		Power.colorClass = true
		Power.Background.multiplier = 0.1
	else
		Power.colorPower = true
	end

	if (C.UnitFrames.Smooth) then
		Power.Smooth = true
	end

	Power.Prediction = CreateFrame("StatusBar", nil, Power)
	Power.Prediction:SetReverseFill(true)
	Power.Prediction:SetPoint("TOP")
	Power.Prediction:SetPoint("BOTTOM")
	Power.Prediction:SetPoint("RIGHT", Power:GetStatusBarTexture(), "RIGHT")
	Power.Prediction:SetWidth(C.UnitFrames.Portrait and 214 or 250)
	Power.Prediction:SetStatusBarTexture(PowerTexture)
	Power.Prediction:SetStatusBarColor(1, 1, 1, .3)

	Power.PostUpdate = TukuiUnitFrames.PostUpdatePower

	-- Additional Power
	local AdditionalPower = CreateFrame("StatusBar", self:GetName()..'AdditionalPower', Health)
	AdditionalPower:SetFrameStrata(self:GetFrameStrata())
	AdditionalPower:Size(C.UnitFrames.Portrait and 214 or 250, 8)
	AdditionalPower:Point("BOTTOMLEFT", Health, "BOTTOMLEFT", 0, 0)
	AdditionalPower:SetStatusBarTexture(PowerTexture)
	AdditionalPower:SetStatusBarColor(unpack(T.Colors.power["MANA"]))
	AdditionalPower:SetFrameLevel(Health:GetFrameLevel() + 3)
	AdditionalPower:SetBackdrop(TukuiUnitFrames.Backdrop)
	AdditionalPower:SetBackdropColor(0, 0, 0)
	AdditionalPower:SetBackdropBorderColor(0, 0, 0)

	AdditionalPower.frequentUpdates = true

	AdditionalPower.Background = AdditionalPower:CreateTexture(nil, "BORDER")
	AdditionalPower.Background:SetAllPoints()
	AdditionalPower.Background:SetColorTexture(0.30, 0.52, 0.90, 0.2)

	AdditionalPower.Prediction = CreateFrame("StatusBar", nil, AdditionalPower)
	AdditionalPower.Prediction:SetReverseFill(true)
	AdditionalPower.Prediction:SetPoint("TOP")
	AdditionalPower.Prediction:SetPoint("BOTTOM")
	AdditionalPower.Prediction:SetPoint("RIGHT", AdditionalPower:GetStatusBarTexture(), "RIGHT")
	AdditionalPower.Prediction:SetWidth(C.UnitFrames.Portrait and 214 or 250)
	AdditionalPower.Prediction:SetStatusBarTexture(PowerTexture)
	AdditionalPower.Prediction:SetStatusBarColor(1, 1, 1, .3)

	if C.UnitFrames.Portrait then
		local Portrait = CreateFrame("PlayerModel", nil, Health)
		Portrait:SetFrameStrata(self:GetFrameStrata())
		Portrait:Size(Health:GetHeight() + Power:GetHeight() + 1)
		Portrait:SetPoint("TOPLEFT", self, "TOPLEFT", 0 ,0)
		Portrait:SetBackdrop(TukuiUnitFrames.Backdrop)
		Portrait:SetBackdropColor(0, 0, 0)
		Portrait:CreateBackdrop()

		Portrait.Backdrop:SetOutside(Portrait, -1, 1)
		Portrait.Backdrop:SetBackdropBorderColor(unpack(C["General"].BorderColor))

		Health:ClearAllPoints()
		Health:SetPoint("TOPLEFT", Portrait:GetWidth() + 1, 0)
		Health:SetPoint("TOPRIGHT")

		self.Portrait = Portrait
	end

	local Combat = Health:CreateTexture(nil, "OVERLAY", 1)
	Combat:Size(19, 19)
	Combat:Point("LEFT", 0, 1)
	Combat:SetVertexColor(0.69, 0.31, 0.31)

	local Status = Panel:CreateFontString(nil, "OVERLAY", 1)
	Status:SetFontObject(Font)
	Status:Point("CENTER", Panel, "CENTER", 0, 0)
	Status:SetTextColor(0.69, 0.31, 0.31)
	Status:Hide()

	local Leader = Health:CreateTexture(nil, "OVERLAY", 2)
	Leader:Size(14, 14)
	Leader:Point("TOPLEFT", 2, 8)

	local MasterLooter = Health:CreateTexture(nil, "OVERLAY", 2)
	MasterLooter:Size(14, 14)
	MasterLooter:Point("TOPRIGHT", -2, 8)

	if (C.UnitFrames.CastBar) then
		local CastBar = CreateFrame("StatusBar", "TukuiPlayerCastBar", self)
		CastBar:SetFrameStrata(self:GetFrameStrata())
		CastBar:SetStatusBarTexture(CastTexture)
		CastBar:SetFrameLevel(6)
		CastBar:SetInside(Panel)

		CastBar.Background = CastBar:CreateTexture(nil, "BORDER")
		CastBar.Background:SetAllPoints(CastBar)
		CastBar.Background:SetTexture(C.Medias.Normal)
		CastBar.Background:SetVertexColor(0.15, 0.15, 0.15)

		CastBar.Time = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Time:SetFontObject(Font)
		CastBar.Time:Point("RIGHT", Panel, "RIGHT", -4, 0)
		CastBar.Time:SetTextColor(0.84, 0.75, 0.65)
		CastBar.Time:SetJustifyH("RIGHT")

		CastBar.Text = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Text:SetFontObject(Font)
		CastBar.Text:Point("LEFT", Panel, "LEFT", 4, 0)
		CastBar.Text:SetTextColor(0.84, 0.75, 0.65)
		CastBar.Text:SetWidth(166)
		CastBar.Text:SetJustifyH("LEFT")

		if (C.UnitFrames.CastBarIcon) then
			CastBar.Button = CreateFrame("Frame", nil, CastBar)
			CastBar.Button:Size(26)
			CastBar.Button:SetTemplate()
			CastBar.Button:CreateShadow()
			CastBar.Button:Point("LEFT", -46.5, 26.5)

			CastBar.Icon = CastBar.Button:CreateTexture(nil, "ARTWORK")
			CastBar.Icon:SetInside()
			CastBar.Icon:SetTexCoord(unpack(T.IconCoord))
		end

		if (C.UnitFrames.CastBarLatency) then
			CastBar.SafeZone = CastBar:CreateTexture(nil, "ARTWORK")
			CastBar.SafeZone:SetTexture(CastTexture)
			CastBar.SafeZone:SetVertexColor(0.69, 0.31, 0.31, 0.75)
		end

		CastBar.CustomTimeText = TukuiUnitFrames.CustomCastTimeText
		CastBar.CustomDelayText = TukuiUnitFrames.CustomCastDelayText
		CastBar.PostCastStart = TukuiUnitFrames.CheckCast
		CastBar.PostChannelStart = TukuiUnitFrames.CheckChannel

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
			CastBar.Time:Point("RIGHT", CastBar, "RIGHT", -4, 0)

			CastBar.Text:ClearAllPoints()
			CastBar.Text:Point("LEFT", CastBar, "LEFT", 4, 0)

			Movers:RegisterFrame(CastBar)
		end

		self.Castbar = CastBar
	end

	if (C.UnitFrames.CombatLog) then
		local CombatFeedbackText = Health:CreateFontString(nil, "OVERLAY", 7)
		CombatFeedbackText:SetFontObject(Font)
		CombatFeedbackText:SetFont(CombatFeedbackText:GetFont(), 16, "THINOUTLINE")
		CombatFeedbackText:SetPoint("CENTER", 0, 1)
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

	if (C.UnitFrames.HealBar) then
		local FirstBar = CreateFrame("StatusBar", nil, Health)
		FirstBar:SetFrameStrata(self:GetFrameStrata())
		FirstBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		FirstBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		FirstBar:SetWidth(250)
		FirstBar:SetStatusBarTexture(HealthTexture)
		FirstBar:SetStatusBarColor(0, 0.3, 0.15, 1)
		FirstBar:SetMinMaxValues(0,1)

		local SecondBar = CreateFrame("StatusBar", nil, Health)
		SecondBar:SetFrameStrata(self:GetFrameStrata())
		SecondBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		SecondBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		SecondBar:SetWidth(250)
		SecondBar:SetStatusBarTexture(HealthTexture)
		SecondBar:SetStatusBarColor(0, 0.3, 0, 1)

		local ThirdBar = CreateFrame("StatusBar", nil, Health)
		ThirdBar:SetFrameStrata(self:GetFrameStrata())
		ThirdBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		ThirdBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		ThirdBar:SetWidth(250)
		ThirdBar:SetStatusBarTexture(HealthTexture)
		ThirdBar:SetStatusBarColor(0.3, 0.3, 0, 1)

		ThirdBar:SetFrameLevel(Health:GetFrameLevel())
		SecondBar:SetFrameLevel(ThirdBar:GetFrameLevel() + 1)
		FirstBar:SetFrameLevel(ThirdBar:GetFrameLevel() + 2)

		self.HealPrediction = {
			myBar = FirstBar,
			otherBar = SecondBar,
			absorbBar = ThirdBar,
			maxOverflow = 1,
		}
	end

	if (C.UnitFrames.TotemBar) then
		local Bar = CreateFrame("Frame", nil, self)
		Bar:SetFrameStrata(self:GetFrameStrata())
		Bar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 5)
		Bar:Size(250, 8)

		Bar.activeTotems = 0
		Bar.Override = TukuiUnitFrames.UpdateTotemOverride

		-- Totem Bar
		for i = 1, MAX_TOTEMS do
			Bar[i] = CreateFrame("StatusBar", "TukuiTotemBarSlot"..i, Bar)
			Bar[i]:Height(16)
			Bar[i]:SetStatusBarTexture(PowerTexture)
			Bar[i]:EnableMouse(true)
			Bar[i]:SetFrameLevel(Health:GetFrameLevel())
			Bar[i]:CreateShadow()
			Bar[i]:IsMouseEnabled(true)

			if i == 1 then
				Bar[i]:Width((250 / 4) - 2)
				Bar[i]:Point("BOTTOMLEFT", Bar, "BOTTOMLEFT", 0, 0)
			else
				Bar[i]:Width((250 / 4) - 4)
				Bar[i]:Point("BOTTOMLEFT", Bar[i-1], "BOTTOMRIGHT", 4, 0)
			end

			Bar[i]:SetMinMaxValues(0, 1)

			Bar[i].Icon = Bar[i]:CreateTexture(nil, "BORDER")
			Bar[i].Icon:SetAllPoints()
			Bar[i].Icon:SetAlpha(1)
			Bar[i].Icon:Size(Bar[i]:GetWidth(), Bar[i]:GetWidth())
			Bar[i].Icon:SetTexCoord(0.05, 0.95, 0.3, 0.7)
		end

		self.Totems = Bar
	end

	if (C.UnitFrames.ComboBar) and (Class == "ROGUE" or Class == "DRUID") then
		local ComboPoints = CreateFrame("Frame", self:GetName()..'ComboPointsBar', self)
		ComboPoints:SetFrameStrata(self:GetFrameStrata())
		ComboPoints:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
		ComboPoints:Width(250)
		ComboPoints:Height(8)
		ComboPoints:SetBackdrop(TukuiUnitFrames.Backdrop)
		ComboPoints:SetBackdropColor(0, 0, 0)
		ComboPoints:SetBackdropBorderColor(unpack(C["General"].BorderColor))

		for i = 1, 8 do
			ComboPoints[i] = CreateFrame("StatusBar", nil, ComboPoints)
			ComboPoints[i]:Height(8)
			ComboPoints[i]:SetStatusBarTexture(PowerTexture)

			if i == 1 then
				ComboPoints[i]:Point("LEFT", ComboPoints, "LEFT", 0, 0)
				ComboPoints[i]:Width(250 / 8 + 2)

				ComboPoints[i].Anticipation = ComboPoints[i]:GetWidth()
				ComboPoints[i].Deeper = 250 / 6
				ComboPoints[i].None = 250 / 5
			else
				ComboPoints[i]:Point("LEFT", ComboPoints[i - 1], "RIGHT", 1, 0)
				ComboPoints[i]:Width(250 / 8 - 1)

				ComboPoints[i].Anticipation = ComboPoints[i]:GetWidth()
				ComboPoints[i].Deeper = 250 / 6 - 1
				ComboPoints[i].None = 250 / 5 - 1
			end
		end

		ComboPoints:SetScript("OnShow", function(self)
			TukuiUnitFrames.UpdateShadow(self, 12)
			TukuiUnitFrames.UpdateBuffsHeaderPosition(self, 14)
		end)

		ComboPoints:SetScript("OnHide", function(self)
			TukuiUnitFrames.UpdateShadow(self, 4)
			TukuiUnitFrames.UpdateBuffsHeaderPosition(self, 4)
		end)

		self.ComboPointsBar = ComboPoints
	end

	local RaidIcon = Health:CreateTexture(nil, "OVERLAY", 7)
	RaidIcon:SetSize(16, 16)
	RaidIcon:SetPoint("TOP", self, 0, 8)

	local Threat = Health:CreateTexture(nil, "OVERLAY")
	Threat.Override = TukuiUnitFrames.UpdateThreat

	self:HookScript("OnEnter", TukuiUnitFrames.MouseOnPlayer)
	self:HookScript("OnLeave", TukuiUnitFrames.MouseOnPlayer)

	-- Register with oUF
	self.Panel = Panel
	self.Health = Health
	self.Health.bg = Health.Background
	self.Power = Power
	self.Power.bg = Power.Background
	self.Combat = Combat
	self.Status = Status
	self.Leader = Leader
	self.MasterLooter = MasterLooter
	self.RaidIcon = RaidIcon
	self.Threat = Threat
	self.PowerPrediction = {}
	self.PowerPrediction.mainBar = Power.Prediction
	self.AdditionalPower = AdditionalPower
	self.AdditionalPower.bg = AdditionalPower.Background
	self.PowerPrediction.altBar = AdditionalPower.Prediction

	-- Classes
	TukuiUnitFrames.AddClassFeatures[Class](self)
end
