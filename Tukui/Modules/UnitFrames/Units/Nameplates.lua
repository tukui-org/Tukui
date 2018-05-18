local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]

function TukuiUnitFrames:Nameplates()
	local HealthTexture = T.GetTexture(C["NamePlates"].Texture)
	local PowerTexture = T.GetTexture(C["NamePlates"].Texture)
	local CastTexture = T.GetTexture(C["NamePlates"].Texture)
	local Font = T.GetFont(C["NamePlates"].Font)

	self:SetScale(UIParent:GetEffectiveScale())
	self:SetBackdrop(TukuiUnitFrames.Backdrop)
	self:SetBackdropColor(0, 0, 0)
	self:CreateShadow()
	self:SetSize(C.NamePlates.Width, C.NamePlates.Height)
	self:SetPoint("CENTER", 0, 0)
	
	local Health = CreateFrame("StatusBar", nil, self)
	Health:SetFrameStrata(self:GetFrameStrata())
	Health:SetPoint("TOPLEFT")
	Health:SetHeight(C.NamePlates.Height - C.NamePlates.CastHeight - 1)
	Health:SetWidth(self:GetWidth())
	Health:SetStatusBarTexture(HealthTexture)

	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:SetAllPoints()
	Health.Background:SetColorTexture(.1, .1, .1)	
	
	Health.colorReaction = true
	Health.colorTapping = true
	Health.colorDisconnected = true
	Health.colorClass = true
	Health.Smooth = true
	
	local Name = Health:CreateFontString(nil, "OVERLAY")
	Name:Point("BOTTOMLEFT", Health, "TOPLEFT", -2, 4)
	Name:SetJustifyH("LEFT")
	Name:SetFontObject(Font)
	Name:SetFont(select(1, Name:GetFont()), 12, select(3, Name:GetFont()))
	
	self:Tag(Name, "[shortclassification][Tukui:DiffColor][level] [Tukui:GetNameColor][Tukui:NameLong]")
	
	local Power = CreateFrame("StatusBar", nil, self)
	Power:SetFrameStrata(self:GetFrameStrata())
	Power:Height(C.NamePlates.CastHeight)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	Power:SetStatusBarTexture(PowerTexture)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints()
	Power.Background:SetColorTexture(.1, .1, .1)

	Power.frequentUpdates = true
	Power.colorPower = true
	Power.Smooth = true
	
	local Debuffs = CreateFrame("Frame", self:GetName()..'Debuffs', self)
	Debuffs:SetHeight(C.NamePlates.Height)
	Debuffs:SetWidth(self:GetWidth())
	Debuffs:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -6)
	Debuffs.size = C.NamePlates.Height
	Debuffs.num = 36
	Debuffs.numRow = 9

	Debuffs.spacing = 2
	Debuffs.initialAnchor = "BOTTOMLEFT"
	Debuffs["growth-y"] = "DOWN"
	Debuffs["growth-x"] = "RIGHT"
	Debuffs.PostCreateIcon = TukuiUnitFrames.PostCreateAura
	Debuffs.PostUpdateIcon = TukuiUnitFrames.PostUpdateAura
	Debuffs.onlyShowPlayer = C.UnitFrames.OnlySelfDebuffs
	

	local CastBar = CreateFrame("StatusBar", "TukuiTargetCastBar", self)
	CastBar:SetFrameStrata(self:GetFrameStrata())
	CastBar:SetStatusBarTexture(CastTexture)
	CastBar:SetFrameLevel(6)
	CastBar:Height(C.NamePlates.CastHeight)
	CastBar:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	CastBar:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)

	CastBar.Background = CastBar:CreateTexture(nil, "BORDER")
	CastBar.Background:SetAllPoints(CastBar)
	CastBar.Background:SetTexture(CastTexture)
	CastBar.Background:SetVertexColor(0.15, 0.15, 0.15)

	CastBar.Button = CreateFrame("Frame", nil, CastBar)
	CastBar.Button:Size(self:GetHeight())
	CastBar.Button:SetTemplate()
	CastBar.Button:CreateShadow()
	CastBar.Button:Point("TOPRIGHT", self, "TOPLEFT", -6, 0)

	CastBar.Icon = CastBar.Button:CreateTexture(nil, "ARTWORK")
	CastBar.Icon:SetInside()
	CastBar.Icon:SetTexCoord(unpack(T.IconCoord))

	CastBar.PostCastStart = TukuiUnitFrames.CheckInterrupt
	CastBar.PostCastInterruptible = TukuiUnitFrames.CheckInterrupt
	CastBar.PostCastNotInterruptible = TukuiUnitFrames.CheckInterrupt
	CastBar.PostChannelStart = TukuiUnitFrames.CheckInterrupt
	
	local RaidIcon = Health:CreateTexture(nil, "OVERLAY")
	RaidIcon:Size(self:GetHeight())
	RaidIcon:Point("TOPLEFT", self, "TOPRIGHT", 4, 0)

	self.Castbar = CastBar
	self.Health = Health
	self.Buffs = Buffs
	self.Debuffs = Debuffs
	self.Name = Name
	self.Power = Power
	self.RaidTargetIndicator = RaidIcon
	
	self:RegisterEvent("PLAYER_TARGET_CHANGED", TukuiUnitFrames.HighlightPlate)
	self:RegisterEvent("NAME_PLATE_UNIT_ADDED", TukuiUnitFrames.HighlightPlate)
	self:RegisterEvent("NAME_PLATE_UNIT_REMOVED", TukuiUnitFrames.HighlightPlate)
end
