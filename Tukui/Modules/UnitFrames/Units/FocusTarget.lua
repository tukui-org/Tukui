local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]

function TukuiUnitFrames:FocusTarget()
	local DarkTheme = C["UnitFrames"].DarkTheme
	local HealthTexture = T.GetTexture(C["UnitFrames"].HealthTexture)
	local PowerTexture = T.GetTexture(C["UnitFrames"].PowerTexture)
	local CastTexture = T.GetTexture(C["UnitFrames"].CastTexture)
	local Font = T.GetFont(C["UnitFrames"].Font)

	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self:SetBackdrop(TukuiUnitFrames.Backdrop)
	self:SetBackdropColor(0, 0, 0)
	self:CreateShadow()

	local Health = CreateFrame("StatusBar", nil, self)
	Health:Height(22)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetStatusBarTexture(HealthTexture)

	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:SetAllPoints()
	Health.Background:SetTexture(0.1, 0.1, 0.1)

	Health.Value = Health:CreateFontString(nil, "OVERLAY")
	Health.Value:SetFontObject(Font)
	Health.Value:Point("LEFT", Health, "LEFT", 2, 0)

	Health.frequentUpdates = true
	
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

	Health.PostUpdate = TukuiUnitFrames.PostUpdateHealth

	if (C.UnitFrames.Smooth) then
		Health.Smooth = true
	end
	
	local Power = CreateFrame("StatusBar", nil, self)
	Power:Height(6)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	Power:SetStatusBarTexture(PowerTexture)
	
	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints()
	Power.Background:SetTexture(0.1, 0.1, 0.1)
	Power.Background.multiplier = 0.3
	
	Power.Value = Power:CreateFontString(nil, "OVERLAY")
	Power.Value:SetFontObject(Font)
	Power.Value:Point("RIGHT", Health, "RIGHT", -2, 0)

	Power.frequentUpdates = true
	
	if DarkTheme then
		Power.colorTapping = true
		Power.colorClass = true
		Power.colorClassNPC = true
		Power.colorClassPet = true
		Power.Background.multiplier = 0.1				
	else
		Power.colorPower = true
	end
	
	if C.UnitFrames.Smooth then
		Power.Smooth = true
	end

	Power.PostUpdate = TukuiUnitFrames.PostUpdatePower

	local Name = Health:CreateFontString(nil, "OVERLAY")
	Name:Point("CENTER", Health, "CENTER", 0, 0)
	Name:SetJustifyH("CENTER")
	Name:SetFontObject(Font)
	self:Tag(Name, "[Tukui:GetNameColor][Tukui:NameLong]")
	
	if (C.UnitFrames.FocusTargetAuras) then
		local Buffs = CreateFrame("Frame", self:GetName()..'Buffs', self)
		Buffs:SetHeight(26)
		Buffs:SetWidth(252)
		Buffs:Point("RIGHT", self, "LEFT", -4, 0)
		Buffs.size = 26
		Buffs.num = 3
		Buffs.spacing = 2
		Buffs.initialAnchor = "RIGHT"
		Buffs["growth-x"] = "LEFT"
		Buffs.PostCreateIcon = TukuiUnitFrames.PostCreateAura
		Buffs.PostUpdateIcon = TukuiUnitFrames.PostUpdateAura

		local Debuffs = CreateFrame("Frame", self:GetName()..'Debuffs', self)
		Debuffs:SetHeight(26)
		Debuffs:SetWidth(200)
		Debuffs:Point("LEFT", self, "RIGHT", 4, 0)
		Debuffs.size = 26
		Debuffs.num = 5
		Debuffs.spacing = 2
		Debuffs.initialAnchor = "LEFT"
		Debuffs["growth-x"] = "RIGHT"
		Debuffs.PostCreateIcon = TukuiUnitFrames.PostCreateAura
		Debuffs.PostUpdateIcon = TukuiUnitFrames.PostUpdateAura
	
		self.Debuffs = Debuffs
		self.Buffs = Buffs
	end

	if (C.UnitFrames.CastBar) then
		local CastBar = CreateFrame("StatusBar", nil, self)
		
		CastBar:SetPoint("LEFT", 0, 0)
		CastBar:SetPoint("RIGHT", -20, 0)
		CastBar:SetPoint("BOTTOM", 0, -22)
		CastBar:SetHeight(16)
		CastBar:SetStatusBarTexture(CastTexture)
		CastBar:SetFrameLevel(6)
		CastBar:SetBackdrop(TukuiUnitFrames.Backdrop)
		CastBar:SetBackdropColor(unpack(C.Medias.BackdropColor))
		CastBar:CreateShadow()
		
		CastBar.Time = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Time:SetFontObject(Font)
		CastBar.Time:Point("RIGHT", CastBar, "RIGHT", -4, 0)
		CastBar.Time:SetTextColor(0.84, 0.75, 0.65)
		CastBar.Time:SetJustifyH("RIGHT")

		CastBar.Text = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Text:SetFontObject(Font)
		CastBar.Text:Point("LEFT", CastBar, "LEFT", 4, 0)
		CastBar.Text:SetTextColor(0.84, 0.75, 0.65)
		CastBar.Text:SetWidth(166)
		CastBar.Text:SetJustifyH("LEFT")

		CastBar.Button = CreateFrame("Frame", nil, CastBar)
		CastBar.Button:Size(CastBar:GetHeight())
		CastBar.Button:SetPoint("LEFT", CastBar, "RIGHT", 4, 0)
		CastBar.Button:SetBackdrop(TukuiUnitFrames.Backdrop)
		CastBar.Button:SetBackdropColor(unpack(C.Medias.BackdropColor))
		CastBar.Button:CreateShadow()
		
		CastBar.Icon = CastBar.Button:CreateTexture(nil, "ARTWORK")
		CastBar.Icon:SetAllPoints()
		CastBar.Icon:SetTexCoord(unpack(T.IconCoord))

		CastBar.CustomTimeText = TukuiUnitFrames.CustomCastTimeText
		CastBar.CustomDelayText = TukuiUnitFrames.CustomCastDelayText
		CastBar.PostCastStart = TukuiUnitFrames.CheckCast
		CastBar.PostChannelStart = TukuiUnitFrames.CheckChannel

		self.Castbar = CastBar
		self.Castbar.Icon = CastBar.Icon
	end
	
	local RaidIcon = Health:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetSize(16, 16)
	RaidIcon:SetPoint("TOP", self, 0, 8)

	self.Health = Health
	self.Health.bg = Health.Background
	self.Power = Power
	self.Power.bg = Power.Background
	self.Name = Name
	self.RaidIcon = RaidIcon
end