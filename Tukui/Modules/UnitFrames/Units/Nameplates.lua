local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]

function TukuiUnitFrames:Nameplates()
	
	local HealthTexture = T.GetTexture(C["UnitFrames"].HealthTexture)
	local PowerTexture = T.GetTexture(C["UnitFrames"].PowerTexture)
	local CastTexture = T.GetTexture(C["UnitFrames"].CastTexture)
	local Font = T.GetFont(C["UnitFrames"].Font)

	self:SetBackdrop(TukuiUnitFrames.Backdrop)
	self:SetBackdropColor(0, 0, 0)
	self:CreateShadow()
	self:SetSize(124, 15)
	self:SetPoint("CENTER", 0, 0)
	
	local Health = CreateFrame("StatusBar", nil, self)
	Health:SetFrameStrata(self:GetFrameStrata())
	Health:SetPoint("TOPLEFT")
	Health:SetHeight(10)
	Health:SetWidth(self:GetWidth())
	Health:SetStatusBarTexture(HealthTexture)

	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:SetAllPoints()
	Health.Background:SetColorTexture(.1, .1, .1)	
	
	Health.colorHealth = true
	Health.colorTapping = true
	Health.colorDisconnected = true
	Health.colorClass = true
	Health.Smooth = true
	
	local Name = Health:CreateFontString(nil, "OVERLAY")
	Name:Point("BOTTOMLEFT", Health, "TOPLEFT", -1, 4)
	Name:SetJustifyH("LEFT")
	Name:SetFontObject(Font)
	
	local Level = Health:CreateFontString(nil, "OVERLAY")
	Level:Point("BOTTOMRIGHT", Health, "TOPRIGHT", 2, 4)
	Level:SetJustifyH("RIGHT")
	Level:SetFontObject(Font)
	
	self:Tag(Name, "[Tukui:GetNameColor][Tukui:NameLong]")
	self:Tag(Level, "[shortclassification][Tukui:DiffColor][level]")
	
	local Power = CreateFrame("StatusBar", nil, self)
	Power:SetFrameStrata(self:GetFrameStrata())
	Power:Height(4)
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
	Debuffs:SetHeight(16)
	Debuffs:SetWidth(self:GetWidth())
	Debuffs:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -6)
	Debuffs.size = 16
	Debuffs.num = 36
	Debuffs.numRow = 9

	Debuffs.spacing = 2
	Debuffs.initialAnchor = "BOTTOMLEFT"
	Debuffs["growth-y"] = "DOWN"
	Debuffs["growth-x"] = "RIGHT"
	Debuffs.PostCreateIcon = TukuiUnitFrames.PostCreateAura
	Debuffs.onlyShowPlayer = C.UnitFrames.OnlySelfDebuffs
	

	local CastBar = CreateFrame("StatusBar", "TukuiTargetCastBar", self)
	CastBar:SetFrameStrata(self:GetFrameStrata())
	CastBar:SetStatusBarTexture(CastTexture)
	CastBar:SetFrameLevel(6)
	CastBar:Height(4)
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
	CastBar.Icon:SetAllPoints()
	CastBar.Icon:SetTexCoord(unpack(T.IconCoord))

	CastBar.PostCastStart = TukuiUnitFrames.CheckInterrupt
	CastBar.PostCastInterruptible = TukuiUnitFrames.CheckInterrupt
	CastBar.PostCastNotInterruptible = TukuiUnitFrames.CheckInterrupt
	CastBar.PostChannelStart = TukuiUnitFrames.CheckInterrupt

	self.Castbar = CastBar
	self.Health = Health
	self.Buffs = Buffs
	self.Debuffs = Debuffs
	self.Name = Name
	self.Power = Power
	
	self:RegisterEvent("PLAYER_TARGET_CHANGED", TukuiUnitFrames.HighlightPlate)
end
