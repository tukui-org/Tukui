local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]

function UnitFrames:Nameplates()
	local HealthTexture = T.GetTexture(C["Textures"].NPHealthTexture)
	local PowerTexture = T.GetTexture(C["Textures"].NPPowerTexture)
	local CastTexture = T.GetTexture(C["Textures"].NPCastTexture)
	local Font = T.GetFont(C["NamePlates"].Font)
	local NumDebuffsPerRow = math.ceil(C.NamePlates.Width / 26)

	self:SetScale(UIParent:GetEffectiveScale())
	self:SetSize(C.NamePlates.Width, C.NamePlates.Height)
	self:SetPoint("CENTER", 0, 0)

	self.Backdrop = CreateFrame("Frame", nil, self, "BackdropTemplate")
	self.Backdrop:SetAllPoints()
	self.Backdrop:SetFrameLevel(self:GetFrameLevel())
	self.Backdrop:SetBackdrop(UnitFrames.Backdrop)
	self.Backdrop:SetBackdropColor(0, 0, 0)

	self:CreateShadow()
	self.Shadow:SetFrameLevel(2)

	local Health = CreateFrame("StatusBar", nil, self)
	Health:SetFrameStrata(self:GetFrameStrata())
	Health:SetPoint("TOPLEFT")
	Health:SetHeight(C.NamePlates.Height - 5)
	Health:SetWidth(self:GetWidth())
	Health:SetStatusBarTexture(HealthTexture)

	Health.Background = Health:CreateTexture(nil, "BACKGROUND")
	Health.Background:SetTexture(HealthTexture)
    Health.Background:SetAllPoints(Health)
	Health.Background.multiplier = C.UnitFrames.StatusBarBackgroundMultiplier / 100

	Health.colorTapping = true
	Health.colorReaction = true
	Health.colorDisconnected = true
	Health.colorClass = true

	local Name = Health:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("BOTTOMLEFT", Health, "TOPLEFT", -2, 4)
	Name:SetJustifyH("LEFT")
	Name:SetFontObject(Font)

	self:Tag(Name, "[Tukui:Classification][Tukui:DiffColor][level] [Tukui:GetNameHostilityColor][Tukui:NameMedium]")

	local Power = CreateFrame("StatusBar", nil, self)
	Power:SetFrameStrata(self:GetFrameStrata())
	Power:SetHeight(4)
	Power:SetPoint("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:SetPoint("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	Power:SetStatusBarTexture(PowerTexture)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetTexture(PowerTexture)
	Power.Background:SetAllPoints(Power)
	Power.Background.multiplier = C.UnitFrames.StatusBarBackgroundMultiplier / 100

	Power.IsHidden = false
	Power.colorPower = true
	Power.PostUpdate = UnitFrames.DisplayNameplatePowerAndCastBar

	local Debuffs = CreateFrame("Frame", self:GetName().."Debuffs", self)
	Debuffs:SetHeight(24)
	Debuffs:SetWidth(self:GetWidth())
	Debuffs:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -6)
	Debuffs.size = 24
	Debuffs.num = NumDebuffsPerRow
	Debuffs.numRow = 1
	Debuffs.disableMouse = true
	Debuffs.spacing = 2
	Debuffs.initialAnchor = "BOTTOMLEFT"
	Debuffs["growth-y"] = "DOWN"
	Debuffs["growth-x"] = "RIGHT"
	Debuffs.PostCreateIcon = UnitFrames.PostCreateAura
	Debuffs.PostUpdateIcon = UnitFrames.PostUpdateAura
	Debuffs.onlyShowPlayer = C.NamePlates.OnlySelfDebuffs

	if C.NamePlates.NameplateCastBar then
		local CastBar = CreateFrame("StatusBar", "TukuiTargetCastBar", self)
		CastBar:SetFrameStrata(self:GetFrameStrata())
		CastBar:SetStatusBarTexture(CastTexture)
		CastBar:SetFrameLevel(6)
		CastBar:SetHeight(3)
		CastBar:SetAllPoints(Power)

		CastBar.Background = CastBar:CreateTexture(nil, "BORDER")
		CastBar.Background:SetPoint("LEFT")
		CastBar.Background:SetPoint("BOTTOM")
		CastBar.Background:SetPoint("RIGHT")
		CastBar.Background:SetPoint("TOP", 0, 1)
		CastBar.Background:SetTexture(CastTexture)
		CastBar.Background:SetVertexColor(0.15, 0.15, 0.15)

		CastBar.Button = CreateFrame("Frame", nil, CastBar)
		CastBar.Button:SetSize(self:GetHeight(), self:GetHeight())
		CastBar.Button:CreateBackdrop()
		CastBar.Button:CreateShadow()
		CastBar.Button:SetPoint("TOPRIGHT", self, "TOPLEFT", -6, 0)

		CastBar.Icon = CastBar.Button:CreateTexture(nil, "ARTWORK")
		CastBar.Icon:SetInside()
		CastBar.Icon:SetTexCoord(unpack(T.IconCoord))

		CastBar.Text = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Text:SetFontObject(Font)
		CastBar.Text:SetPoint("CENTER", CastBar)
		CastBar.Text:SetTextColor(0.84, 0.75, 0.65)
		CastBar.Text:SetWidth(C.NamePlates.Width)
		CastBar.Text:SetJustifyH("CENTER")

		CastBar.PostCastStart = UnitFrames.CheckInterrupt
		CastBar.PostCastInterruptible = UnitFrames.CheckInterrupt
		CastBar.PostCastNotInterruptible = UnitFrames.CheckInterrupt
		CastBar.PostChannelStart = UnitFrames.CheckInterrupt

		self.Castbar = CastBar
	end

	local RaidIcon = Health:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetSize(C.UnitFrames.RaidIconSize, C.UnitFrames.RaidIconSize)
	RaidIcon:SetPoint("LEFT", self, "RIGHT", 4, 0)
	RaidIcon:SetTexture([[Interface\AddOns\Tukui\Medias\Textures\Others\RaidIcons]])

	local Highlight = CreateFrame("Frame", nil, self, "BackdropTemplate")
	Highlight:SetBackdrop({edgeFile = C.Medias.Glow, edgeSize = C.NamePlates.HighlightSize})
	Highlight:SetOutside(self, C.NamePlates.HighlightSize, C.NamePlates.HighlightSize)
	Highlight:SetBackdropBorderColor(unpack(C.NamePlates.HighlightColor))
	Highlight:SetFrameLevel(0)
	Highlight:Hide()
	
	if C.NamePlates.QuestIcon then
		local QuestIcon = self:CreateTexture(nil, "OVERLAY")
		QuestIcon:SetSize(C.NamePlates.Height, C.NamePlates.Height)
		QuestIcon:SetPoint("LEFT", self, "RIGHT", 4, 0)
		
		self.QuestIcon = QuestIcon
	end

	self.Health = Health
	self.Health.bg = Health.Background
	self.Debuffs = Debuffs
	self.Name = Name
	self.Power = Power
	self.Power.bg = Power.Background
	self.RaidTargetIndicator = RaidIcon
	self.Highlight = Highlight

	self:RegisterEvent("PLAYER_TARGET_CHANGED", UnitFrames.Highlight, true)
	self:RegisterEvent("NAME_PLATE_UNIT_ADDED", UnitFrames.Highlight, true)
	self:RegisterEvent("NAME_PLATE_UNIT_REMOVED", UnitFrames.Highlight, true)

	-- Needed on nameplate else if will bug on AOE multi nameplates. (I'm not sure about this)
	self:EnableMouse(false)
	self.Health:EnableMouse(false)
	self.Power:EnableMouse(false)
end