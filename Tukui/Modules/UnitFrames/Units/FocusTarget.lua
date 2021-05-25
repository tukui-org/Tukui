local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]

function UnitFrames:FocusTarget()
	local HealthTexture = T.GetTexture(C["Textures"].UFHealthTexture)
	local PowerTexture = T.GetTexture(C["Textures"].UFPowerTexture)
	local CastTexture = T.GetTexture(C["Textures"].UFCastTexture)
	local Font = T.GetFont(C["UnitFrames"].Font)

	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	
	self.Backdrop = CreateFrame("Frame", nil, self, "BackdropTemplate")
	self.Backdrop:SetAllPoints()
	self.Backdrop:SetFrameLevel(self:GetFrameLevel())
	self.Backdrop:SetBackdrop(UnitFrames.Backdrop)
	self.Backdrop:SetBackdropColor(0, 0, 0)
	self.Backdrop:CreateShadow()

	local Health = CreateFrame("StatusBar", nil, self)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetHeight(14)
	Health:SetStatusBarTexture(HealthTexture)

	Health.Background = Health:CreateTexture(nil, "BACKGROUND")
	Health.Background:SetTexture(HealthTexture)
	Health.Background:SetAllPoints(Health)
	Health.Background.multiplier = C.UnitFrames.StatusBarBackgroundMultiplier / 100
	
	Health.Value = Health:CreateFontString(nil, "OVERLAY")
	Health.Value:SetFontObject(Font)
	Health.Value:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 4)

	Health.colorDisconnected = true
	Health.colorClass = true
	Health.colorReaction = true

	-- Power
	local Power = CreateFrame("StatusBar", nil, self)
	Power:SetPoint("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:SetPoint("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	Power:SetPoint("BOTTOM", 0, 0)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetTexture(PowerTexture)
	Power.Background:SetAllPoints(Power)
	Power.Background.multiplier = C.UnitFrames.StatusBarBackgroundMultiplier / 100

	Power:SetStatusBarTexture(PowerTexture)

	Power.colorPower = true
	Power.isRaid = true

	local Name = Health:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("BOTTOMLEFT", Health, "TOPLEFT", -2, 4)
	Name:SetJustifyH("LEFT")
	Name:SetFontObject(Font)

	local RaidIcon = Health:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetSize(C.UnitFrames.RaidIconSize, C.UnitFrames.RaidIconSize)
	RaidIcon:SetPoint("TOP", self, 0, C.UnitFrames.RaidIconSize / 2)
	RaidIcon:SetTexture([[Interface\AddOns\Tukui\Medias\Textures\Others\RaidIcons]])
	
	if (C.UnitFrames.FocusAuras) then
		local Buffs = CreateFrame("Frame", self:GetName().."Buffs", self)
		local Debuffs = CreateFrame("Frame", self:GetName().."Debuffs", self)

		Buffs:SetFrameStrata(self:GetFrameStrata())
		Buffs:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -4)

		Buffs:SetHeight(20)
		Buffs:SetWidth(129)
		Buffs.size = 20
		Buffs.num = 3
		Buffs.numRow = 1

		Debuffs:SetFrameStrata(self:GetFrameStrata())
		Debuffs:SetHeight(20)
		Debuffs:SetWidth(129)
		Debuffs:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 0, -4)
		Debuffs.size = 20
		Debuffs.num = 4
		Debuffs.numRow = 1

		Buffs.spacing = 4
		Buffs.initialAnchor = "TOPLEFT"
		Buffs.PostCreateIcon = UnitFrames.PostCreateAura
		Buffs.PostUpdateIcon = UnitFrames.PostUpdateAura
		Buffs.onlyShowPlayer = C.UnitFrames.OnlySelfBuffs

		Debuffs.spacing = 4
		Debuffs.initialAnchor = "TOPRIGHT"
		Debuffs["growth-x"] = "LEFT"
		Debuffs.PostCreateIcon = UnitFrames.PostCreateAura
		Debuffs.PostUpdateIcon = UnitFrames.PostUpdateAura
		Debuffs.onlyShowPlayer = C.UnitFrames.OnlySelfDebuffs

		self.Buffs = Buffs
		self.Debuffs = Debuffs
	end
	
	-- Enable smoothing bars animation?
	if C.UnitFrames.Smoothing then
		Health.smoothing = true
		Power.smoothing = true

		if self.HealthPrediction then
			self.HealthPrediction.smoothing = true
		end
	end
	
	self:Tag(Name, "[Tukui:Classification][Tukui:DiffColor][level] [Tukui:GetNameColor][Tukui:NameMedium]")
	self:Tag(Health.Value, C.UnitFrames.FocusTargetHealthTag.Value)
	self.Health = Health
	self.Health.bg = Health.Background
	self.Power = Power
	self.Power.bg = Power.Background
	self.Name = Name
	self.RaidTargetIndicator = RaidIcon
	self.onUpdateFrequency = 0.1
end