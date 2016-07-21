local T, C, L = select(2, ...):unpack()

--[[
C["NamePlates"] = {
	["Enable"] = true,
	["Width"] = 150,
	["Height"] = 6,
	["CastHeight"] = 4,
	["Spacing"] = 4,
	["NonTargetAlpha"] = .5,
	["Texture"] = "Tukui",
	["Font"] = "Tukui Outline",
	["NameTextColor"] = true,
}
--]]

local _G = _G
local unpack = unpack
local Plates = CreateFrame("Frame", nil, WorldFrame)
local Noop = function() end

function Plates:GetClassification(unit)
	local CreatureClassification = UnitClassification(unit)
	local String = ""
	
	if CreatureClassification == "elite" then
		String = "[E]"
	elseif CreatureClassification == "rare" then
		String = "[R]"
	elseif CreatureClassification == "rareelite" then
		String = "[R+]"
	elseif CreatureClassification == "worldboss" then
		String = "[WB]"
	end
	
	return String
end

function Plates:SetName()
	local Text = self:GetText()

	if Text then
		local Unit = self:GetParent().unit
		local Class = select(2, UnitClass(Unit))
		local Level = UnitLevel(Unit)
		local LevelColor = GetQuestDifficultyColor(Level)
		local LevelHexColor = T.RGBToHex(LevelColor.r, LevelColor.g, LevelColor.b)
		local IsFriend = UnitIsFriend("player", Unit)
		local NameColor = IsFriend and T.Colors.reaction[5] or T.Colors.reaction[1]
		local NameHexColor = T.RGBToHex(NameColor[1], NameColor[2], NameColor[3])
		local Elite = Plates:GetClassification(Unit)

		if Level < 0 then
			Level = ""
		else
			Level = "[".. Level.. "]"
		end
	
		self:SetText("|cffff0000".. Elite .."|r" .. LevelHexColor .. Level .."|r "..NameHexColor.. Text .."|r")
	end
end

function Plates:ColorHealth()
	if (self:GetName() and string.find(self:GetName(), "NamePlate")) then
		local r, g, b

		if not UnitIsConnected(self.unit) then
			r, g, b = unpack(T.Colors.disconnected)
		else
			if UnitIsPlayer(self.unit) then
				local Class = select(2, UnitClass(self.unit))
					
				r, g, b = unpack(T.Colors.class[Class])
			else
				if (UnitIsFriend("player", self.unit)) then
					r, g, b = unpack(T.Colors.reaction[5])
				else
					local Reaction = UnitReaction("player", self.unit)

					r, g, b = unpack(T.Colors.reaction[Reaction])
				end
			end
		end

		self.healthBar:SetStatusBarColor(r, g, b)
	end
end

function Plates:SetCastingIcon()
	local Icon = self.Icon
	local Texture = Icon:GetTexture()
	local Backdrop = self.IconBackdrop
	local IconTexture = self.IconTexture
	
	if Texture then
		Backdrop:SetAlpha(1)
		IconTexture:SetTexture(Texture)
	else
		Backdrop:SetAlpha(0)
		Icon:SetTexture(nil)		
	end
end

function Plates:SetupPlate(options)
	if self.IsEdited then
		return
	end

	local HealthBar = self.healthBar
	local Highlight = self.selectionHighlight
	local Aggro = self.aggroHighlight
	local CastBar = self.castBar
	local CastBarIcon = self.castBar.Icon
	local Shield = self.castBar.BorderShield
	local Flash = self.castBar.Flash
	local Spark = self.castBar.Spark
	local Name = self.name
	local Texture = T.GetTexture(C["NamePlates"].Texture)
	local Font = T.GetFont(C["NamePlates"].Font)
	local FontName, FontSize, FontFlags = _G[Font]:GetFont()

	-- HEALTHBAR
	HealthBar:SetStatusBarTexture(Texture)
	HealthBar.background:ClearAllPoints()
	HealthBar.background:SetInside(0, 0)
	HealthBar:CreateShadow()
	HealthBar.border:SetAlpha(0)

	-- CASTBAR
	CastBar:SetStatusBarTexture(Texture)
	CastBar.background:ClearAllPoints()
	CastBar.background:SetInside(0, 0)
	CastBar:CreateShadow()
	
	if CastBar.border then
		CastBar.border:SetAlpha(0)
	end
	
	CastBar.SetStatusBarTexture = function() end
	
	CastBar.IconBackdrop = CreateFrame("Frame", nil, CastBar)
	CastBar.IconBackdrop:SetSize(CastBar.Icon:GetSize())
	CastBar.IconBackdrop:SetPoint("TOPRIGHT", HealthBar, "TOPLEFT", -4, 0)
	CastBar.IconBackdrop:SetBackdrop({bgFile = C.Medias.Blank})
	CastBar.IconBackdrop:SetBackdropColor(unpack(C.Medias.BackdropColor))
	CastBar.IconBackdrop:CreateShadow()
	CastBar.IconBackdrop:SetFrameLevel(CastBar:GetFrameLevel() - 1 or 0)
	
	CastBar.Icon:SetParent(T.Panels.Hider)
	
	CastBar.IconTexture = CastBar:CreateTexture(nil, "OVERLAY")
	CastBar.IconTexture:SetTexCoord(.08, .92, .08, .92)
	CastBar.IconTexture:SetParent(CastBar.IconBackdrop)
	CastBar.IconTexture:SetAllPoints(CastBar.IconBackdrop)

	CastBar.Text:SetFont(FontName, 9, "OUTLINE")
	
	CastBar.startCastColor.r, CastBar.startCastColor.g, CastBar.startCastColor.b = unpack(Plates.Options.CastBarColors.StartNormal)
	CastBar.startChannelColor.r, CastBar.startChannelColor.g, CastBar.startChannelColor.b = unpack(Plates.Options.CastBarColors.StartChannel)
	CastBar.failedCastColor.r, CastBar.failedCastColor.g, CastBar.failedCastColor.b = unpack(Plates.Options.CastBarColors.Failed)
	CastBar.nonInterruptibleColor.r, CastBar.nonInterruptibleColor.g, CastBar.nonInterruptibleColor.b = unpack(Plates.Options.CastBarColors.NonInterrupt)
	CastBar.finishedCastColor.r, CastBar.finishedCastColor.g, CastBar.finishedCastColor.b = unpack(Plates.Options.CastBarColors.Success)
	
	CastBar:HookScript("OnShow", Plates.SetCastingIcon)
	
	-- UNIT NAME
	Name:SetFont(FontName, 10) -- if we add outline, it cause lag? WTF?
	Name:SetShadowColor(0, 0, 0)
	Name:SetShadowOffset(1.25, -1.25)
	hooksecurefunc(Name, "Show", Plates.SetName)
	
	-- WILL DO A BETTER VISUAL FOR THIS LATER
	Highlight:Kill()
	Shield:Kill()
	Aggro:Kill()
	Flash:Kill()
	Spark:Kill()
	
	self.IsEdited = true
end

function Plates:Enable()
	local Enabled = C.NamePlates.Enable
	
	if not Enabled then
		return
	end
	
	self:RegisterOptions()
	
	DefaultCompactNamePlateFriendlyFrameOptions = Plates.Options.Friendly
	DefaultCompactNamePlateEnemyFrameOptions = Plates.Options.Enemy
	DefaultCompactNamePlatePlayerFrameOptions = Plates.Options.Player
	DefaultCompactNamePlateFrameSetUpOptions = Plates.Options.Size
	DefaultCompactNamePlatePlayerFrameSetUpOptions = Plates.Options.PlayerSize
	
	if ClassNameplateManaBarFrame then
		ClassNameplateManaBarFrame.Border:SetAlpha(0)
		ClassNameplateManaBarFrame:SetStatusBarTexture(C.Medias.Normal)
		ClassNameplateManaBarFrame.ManaCostPredictionBar:SetTexture(C.Medias.Normal)
		ClassNameplateManaBarFrame:SetBackdrop({bgFile = C.Medias.Blank})
		ClassNameplateManaBarFrame:SetBackdropColor(.2, .2, .2)
		ClassNameplateManaBarFrame:CreateShadow()
	end
	
	hooksecurefunc("DefaultCompactNamePlateFrameSetupInternal", self.SetupPlate)
	hooksecurefunc("CompactUnitFrame_UpdateHealthColor", self.ColorHealth)
	
	-- Disable Blizzard rescale
	NamePlateDriverFrame.UpdateNamePlateOptions = Noop
	
	-- Make sure nameplates are always scaled at 1
	SetCVar("NamePlateVerticalScale", "1")
	SetCVar("NamePlateHorizontalScale", "1")
	
	-- Hide the option to rescale, because we will do it from Tukui settings.
	InterfaceOptionsNamesPanelUnitNameplatesMakeLarger:Hide()
	
	-- Set the Width of NamePlate
	C_NamePlate.SetNamePlateOtherSize(C.NamePlates.Width, 45)
end

T["NamePlates"] = Plates
