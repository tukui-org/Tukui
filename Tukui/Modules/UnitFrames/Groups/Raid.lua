local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

function TukuiUnitFrames:Raid()
	local DarkTheme = C["UnitFrames"].DarkTheme
	local HealthTexture = T.GetTexture(C["Raid"].HealthTexture)
	local PowerTexture = T.GetTexture(C["Raid"].PowerTexture)
	local Font = T.GetFont(C["Raid"].Font)
	local HealthFont = T.GetFont(C["Raid"].HealthFont)

	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self:SetBackdrop(TukuiUnitFrames.Backdrop)
	self:SetBackdropColor(0, 0, 0)
	self:CreateShadow()
	
	local Health = CreateFrame("StatusBar", nil, self)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:Height(28)
	Health:SetStatusBarTexture(HealthTexture)
	
	if C.Raid.VerticalHealth then
		Health:SetOrientation("VERTICAL")
	end
	
	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:SetAllPoints()
	Health.Background:SetTexture(.1, .1, .1)
	
	if C.Raid.ShowHealthText then
		Health.Value = Health:CreateFontString(nil, "OVERLAY")
		Health.Value:SetFontObject(HealthFont)
		Health.Value:Point("CENTER", Health, 0, 0)
	
		Health.PostUpdate = TukuiUnitFrames.PostUpdateHealth
	end
	
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
	
	if (C.UnitFrames.Smooth) then
		Health.Smooth = true
	end
	
	-- AuraWatch requires this handle ASAP
	self.Health = Health
	
	-- Power
	local Power = CreateFrame("StatusBar", nil, self)
	Power:Height(3)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	
	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints(Power)
	Power.Background:SetTexture(0.1, 0.1, 0.1)
	Power.Background.multiplier = 0.3
	
	Power:SetStatusBarTexture(PowerTexture)
	
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
	
	if (C.UnitFrames.Smooth) then
		Health.Smooth = true
	end
	
	local Panel = CreateFrame("Frame", nil, self)
	Panel:Point("TOPLEFT", Power, "BOTTOMLEFT", 0, -1)
	Panel:Point("TOPRIGHT", Power, "BOTTOMRIGHT", 0, -1)
	Panel:SetPoint("BOTTOM", 0, 0)
	Panel:SetTemplate()
	Panel:SetBackdropBorderColor(C["General"].BorderColor[1] * 0.7, C["General"].BorderColor[2] * 0.7, C["General"].BorderColor[3] * 0.7)
	
	local Name = Panel:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("CENTER")
	Name:SetFontObject(Font)
	
	local ReadyCheck = Power:CreateTexture(nil, "OVERLAY")
	ReadyCheck:Height(12)
	ReadyCheck:Width(12)
	ReadyCheck:SetPoint("CENTER")

	local LFDRole = Health:CreateTexture(nil, "OVERLAY")
	LFDRole:SetInside(Panel)
	LFDRole:SetTexture(0, 0, 0, 0)
	LFDRole.Override = TukuiUnitFrames.SetGridGroupRole
	
	local RaidIcon = Health:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetSize(16, 16)
	RaidIcon:SetPoint("TOP", self, 0, 8)
	
	if C["Raid"].ShowRessurection then
		local ResurrectIcon = Health:CreateTexture(nil, "OVERLAY")
		ResurrectIcon:Size(16)
		ResurrectIcon:SetPoint("CENTER")
		
		self.ResurrectIcon = ResurrectIcon
	end
	
	local Range = {
		insideAlpha = 1, 
		outsideAlpha = C["Raid"].RangeAlpha,
	}
	
	if (C.Raid.HealBar) then
		local FirstBar = CreateFrame("StatusBar", nil, Health)
		local SecondBar = CreateFrame("StatusBar", nil, Health)
		local ThirdBar = CreateFrame("StatusBar", nil, Health)
		
		FirstBar:Width(66)
		FirstBar:Height(28)
		FirstBar:SetStatusBarTexture(C.Medias.Normal)
		FirstBar:SetStatusBarColor(0, 0.3, 0.15, 1)
		FirstBar:SetMinMaxValues(0,1)
		
		SecondBar:Width(66)
		SecondBar:Height(28)
		SecondBar:SetStatusBarTexture(C.Medias.Normal)
		SecondBar:SetStatusBarColor(0, 0.3, 0, 1)
			
		ThirdBar:Width(66)
		ThirdBar:Height(28)
		ThirdBar:SetStatusBarTexture(C.Medias.Normal)
		ThirdBar:SetStatusBarColor(0.3, 0.3, 0, 1)
		
		if C.Raid.VerticalHealth then
			FirstBar:SetOrientation("VERTICAL")
			SecondBar:SetOrientation("VERTICAL")
			ThirdBar:SetOrientation("VERTICAL")
			
			FirstBar:SetPoint("BOTTOM", Health:GetStatusBarTexture(), "TOP", 0, 0)
			SecondBar:SetPoint("BOTTOM", Health:GetStatusBarTexture(), "TOP", 0, 0)
			ThirdBar:SetPoint("BOTTOM", Health:GetStatusBarTexture(), "TOP", 0, 0)
		else
			FirstBar:SetPoint("LEFT", Health:GetStatusBarTexture(), "RIGHT", 0, 0)
			SecondBar:SetPoint("LEFT", Health:GetStatusBarTexture(), "RIGHT", 0, 0)
			ThirdBar:SetPoint("LEFT", Health:GetStatusBarTexture(), "RIGHT", 0, 0)			
		end
		
		ThirdBar:SetFrameLevel(Health:GetFrameLevel() - 2)
		SecondBar:SetFrameLevel(ThirdBar:GetFrameLevel() + 1)
		FirstBar:SetFrameLevel(ThirdBar:GetFrameLevel() + 2)
		
		self.HealPrediction = {
			myBar = FirstBar,
			otherBar = SecondBar,
			absorbBar = ThirdBar,
			maxOverflow = 1,
		}
	end
	
	-- AuraWatch (corner and center icon)
	if C["Raid"].AuraWatch then
		TukuiUnitFrames:CreateAuraWatch(self)
		
        local RaidDebuffs = CreateFrame("Frame", nil, self)
        RaidDebuffs:SetHeight(22)
        RaidDebuffs:SetWidth(22)
        RaidDebuffs:SetPoint("CENTER", Health)
        RaidDebuffs:SetFrameStrata("HIGH")
        RaidDebuffs:SetBackdrop(TukuiUnitFrames.Backdrop)
        RaidDebuffs:SetBackdropColor(0, 0, 0)
        RaidDebuffs:SetTemplate()
        RaidDebuffs:CreateShadow()

        RaidDebuffs.icon = RaidDebuffs:CreateTexture(nil, "OVERLAY")
        RaidDebuffs.icon:SetTexCoord(.1, .9, .1, .9)
        RaidDebuffs.icon:SetInside(RaidDebuffs)

        RaidDebuffs.cd = CreateFrame("Cooldown", nil, RaidDebuffs)
        RaidDebuffs.cd:SetAllPoints(RaidDebuffs)
        RaidDebuffs.cd:SetHideCountdownNumbers(true)

        RaidDebuffs.ShowDispelableDebuff = true
        RaidDebuffs.FilterDispelableDebuff = true
        RaidDebuffs.MatchBySpellName = true
    	RaidDebuffs.ShowBossDebuff = true
    	RaidDebuffs.BossDebuffPriority = 5

        RaidDebuffs.count = RaidDebuffs:CreateFontString(nil, "OVERLAY")
        RaidDebuffs.count:SetFont(C.Medias.Font, 12, "OUTLINE")
        RaidDebuffs.count:SetPoint("BOTTOMRIGHT", RaidDebuffs, "BOTTOMRIGHT", 2, 0)
        RaidDebuffs.count:SetTextColor(1, .9, 0)

        RaidDebuffs.SetDebuffTypeColor = RaidDebuffs.SetBackdropBorderColor
        
        self.RaidDebuffs = RaidDebuffs
	end
	
	if (Class == "PRIEST" and C.UnitFrames.WeakBar) then
		-- Weakened Soul Bar
		local WSBar = CreateFrame("StatusBar", nil, Power)
		WSBar:SetAllPoints(Power)
		WSBar:SetStatusBarTexture(C.Medias.Normal)
		WSBar:GetStatusBarTexture():SetHorizTile(false)
		WSBar:SetBackdrop(TukuiUnitFrames.Backdrop)
		WSBar:SetBackdropColor(unpack(C["General"].BackdropColor))
		WSBar:SetStatusBarColor(0.75, 0.04, 0.04)

		-- Register
		self.WeakenedSoul = WSBar
	end
	
	local Threat = Health:CreateTexture(nil, "OVERLAY")
	Threat.Override = TukuiUnitFrames.UpdateThreat
	
	if C.Raid.Highlight then
		local Highlight = CreateFrame("Frame", nil, self)
		Highlight:SetPoint("TOPLEFT", self, "TOPLEFT")
		Highlight:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
		Highlight:SetBackdrop(TukuiUnitFrames.HighlightBorder)
		Highlight:SetFrameLevel(0)
		Highlight:Hide()
		
		self:RegisterEvent("PLAYER_TARGET_CHANGED", TukuiUnitFrames.Highlight)
		self:RegisterEvent("RAID_ROSTER_UPDATE", TukuiUnitFrames.Highlight)
		self:RegisterEvent("PLAYER_FOCUS_CHANGED", TukuiUnitFrames.Highlight)
		
		self.Highlight = Highlight
	end
	
	self:Tag(Name, "[Tukui:GetNameColor][Tukui:NameShort]")
	self.Health.bg = Health.Background
	self.Power = Power
	self.Power.bg = Power.Background
	self.Panel = Panel
	self.Name = Name
	self.ReadyCheck = ReadyCheck
	self.LFDRole = LFDRole
	self.Range = Range
	self.RaidIcon = RaidIcon
	self.Threat = Threat
end