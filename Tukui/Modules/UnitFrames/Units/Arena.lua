local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]

function TukuiUnitFrames:Arena()
	local HealthTexture = T.GetTexture(C["Textures"].UFHealthTexture)
	local PowerTexture = T.GetTexture(C["Textures"].UFPowerTexture)
	local CastTexture = T.GetTexture(C["Textures"].UFCastTexture)
	local Font = T.GetFont(C["UnitFrames"].Font)

	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self:SetBackdrop(TukuiUnitFrames.Backdrop)
	self:SetBackdropColor(0, 0, 0)
	self:CreateShadow()
	self:SetAttribute("type2", "focus")

	local Health = CreateFrame("StatusBar", nil, self)
	Health:Height(22)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetStatusBarTexture(HealthTexture)

	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:SetAllPoints()
	Health.Background:SetColorTexture(.1, .1, .1)

	Health.Value = Health:CreateFontString(nil, "OVERLAY")
	Health.Value:SetFontObject(Font)
	Health.Value:Point("LEFT", 2, 0)

	Health.PostUpdate = TukuiUnitFrames.PostUpdateHealth

	Health.frequentUpdates = true
	Health.colorDisconnected = true
	Health.colorClass = true
	Health.colorReaction = true

	if (C.UnitFrames.Smooth) then
		Health.Smooth = true
	end

	if (C.UnitFrames.Smooth) then
		Health.Smooth = true
	end

	-- Power
	local Power = CreateFrame("StatusBar", nil, self)
	Power:Height(6)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	Power:SetStatusBarTexture(PowerTexture)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints(Power)
	Power.Background:SetColorTexture(.5, .5, .5)
	Power.Background.multiplier = 0.3

	Power.Value = Health:CreateFontString(nil, "OVERLAY")
	Power.Value:SetFontObject(Font)
	Power.Value:Point("RIGHT", -2, 0)

	Power.PostUpdate = TukuiUnitFrames.PostUpdatePower

	Power.frequentUpdates = true
	Power.colorPower = true

	if C.UnitFrames.Smooth then
		Power.Smooth = true
	end

	local Name = Health:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("CENTER", Health, "CENTER", 0, 0)
	Name:SetJustifyH("CENTER")
	Name:SetFontObject(Font)
	Name.frequentUpdates = 0.2

	if (C.UnitFrames.ArenaAuras) then
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
	end

	local SpecIcon = CreateFrame("Frame", nil, self)
	SpecIcon:Size(22)
	SpecIcon:SetPoint("RIGHT", self, "LEFT", -6, 0)
	SpecIcon:CreateBackdrop()
	SpecIcon.Backdrop:CreateShadow()

	local Trinket = CreateFrame("Frame", nil, self)
	Trinket:Size(22)
	Trinket:SetPoint("RIGHT", self, "LEFT", -34, 0)
	Trinket:CreateBackdrop()
	Trinket.Backdrop:CreateShadow()

	if (C.UnitFrames.CastBar) then
		local CastBar = CreateFrame("StatusBar", nil, self)

		CastBar:SetPoint("LEFT", 20, 0)
		CastBar:SetPoint("RIGHT", 0, 0)
		CastBar:SetPoint("BOTTOM", 0, -22)
		CastBar:SetHeight(16)
		CastBar:SetStatusBarTexture(CastTexture)
		CastBar:SetFrameLevel(6)
		CastBar:SetBackdrop(TukuiUnitFrames.Backdrop)
		CastBar:SetBackdropColor(unpack(C.General.BackdropColor))
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
		CastBar.Button:SetPoint("RIGHT", CastBar, "LEFT", -4, 0)
		CastBar.Button:SetBackdrop(TukuiUnitFrames.Backdrop)
		CastBar.Button:SetBackdropColor(unpack(C.General.BackdropColor))
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
	RaidIcon:SetTexture([[Interface\AddOns\Tukui\Medias\Textures\Others\RaidIcons]])

	self:Tag(Name, "[Tukui:GetNameColor][Tukui:NameLong]")
	self.Health = Health
	self.Health.bg = Health.Background
	self.Power = Power
	self.Power.bg = Power.Background
	self.Name = Name
	self.PVPSpecIcon = SpecIcon
	self.Trinket = Trinket
	self.RaidTargetIndicator = RaidIcon
end

function TukuiUnitFrames:CreateArenaPreparationFrames()
	local HealthTexture = T.GetTexture(C["Textures"].UFHealthTexture)
	local Font = T.GetFont(C["UnitFrames"].Font)
	local ArenaPreparation = {}

	for i = 1, 5 do
		local ArenaX = TukuiUnitFrames.Units.Arena[i]

		ArenaPreparation[i] = CreateFrame("Frame", nil, UIParent)
		ArenaPreparation[i]:SetAllPoints(ArenaX)
		ArenaPreparation[i]:SetBackdrop(TukuiUnitFrames.Backdrop)
		ArenaPreparation[i]:SetBackdropColor(0,0,0)

		ArenaPreparation[i]:CreateShadow()

		ArenaPreparation[i].Health = CreateFrame("StatusBar", nil, ArenaPreparation[i])
		ArenaPreparation[i].Health:SetAllPoints()
		ArenaPreparation[i].Health:SetStatusBarTexture(HealthTexture)
		ArenaPreparation[i].Health:SetStatusBarColor(0.2, 0.2, 0.2, 1)

		ArenaPreparation[i].SpecClass = ArenaPreparation[i].Health:CreateFontString(nil, "OVERLAY")
		ArenaPreparation[i].SpecClass:SetFontObject(Font)
		ArenaPreparation[i].SpecClass:SetPoint("CENTER")
		ArenaPreparation[i]:Hide()
	end

	TukuiUnitFrames.Units.ArenaPreparation = ArenaPreparation
end
