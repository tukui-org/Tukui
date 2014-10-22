local T, C, L = select(2, ...):unpack()

local _G = _G
local unpack = unpack
local find, match = find, match
local WorldFrame = WorldFrame
local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local Hider
local Convert = T.RGBToHex
local Scale = T.Scale
local FrameNumber = 0
local NameplateParent = WorldFrame

local Plates = CreateFrame("Frame", nil, WorldFrame)

function Plates:GetColor()
	local Colors = T["Colors"]
	local Red, Green, Blue = self.Health:GetStatusBarColor()
	
	for Class, Color in pairs(RAID_CLASS_COLORS) do
		local R, G, B = floor(Red * 100 + 0.5) / 100, floor(Green * 100 + 0.5) / 100, floor(Blue * 100 + 0.5) / 100
		
		if RAID_CLASS_COLORS[Class].r == R and RAID_CLASS_COLORS[Class].g == G and RAID_CLASS_COLORS[Class].b == B then
			Red, Green, Blue = unpack(Colors.class[Class])
			
			self.IsClass = true
			self.IsFriend = false
			self.Class = Class
			
			return Red, Green, Blue
		end
	end
	
	if (Green + Blue == 0) then
		-- Hostile Health
		Red, Green, Blue = unpack(Colors.reaction[2])
		self.IsFriend = false
	elseif (Red + Blue == 0) then
		-- Friendly NPC
		Red, Green, Blue = unpack(Colors.reaction[5])
		self.IsFriend  = true
	elseif (Red + Green > 1.95) then
		-- Neutral NPC
		Red, Green, Blue = unpack(Colors.reaction[4])
		self.IsFriend  = false
	elseif (Red + Green == 0) then
		-- Friendly Player
		Red, Green, Blue = unpack(Colors.reaction[5])
		self.IsFriend  = true
	else
		self.IsFriend = false
	end
	
	self.IsClass = false
	self.Class = nil
	
	return Red, Green, Blue
end

function Plates:UpdateCastBar()
	local Minimum, Maximum = self:GetMinMaxValues()
	local Current = self:GetValue()
	
	self.NewCast:SetMinMaxValues(Minimum, Maximum)
	self.NewCast:SetValue(Current)
end

function Plates:CastOnShow()
	local Red, Blue, Green = self:GetStatusBarColor()

	self.NewCast:Show()
	self.NewCast:SetStatusBarColor(Red, Blue, Green)
	self.NewCast.Background:SetTexture(Red * .15, Blue * .15, Green * .15)
	self:SetScript("OnUpdate", Plates.UpdateCastBar)
end

function Plates:CastOnHide()
	self:SetScript("OnUpdate", nil)
	self.NewCast:Hide()
end

function Plates:CastOnHide()
	self.NewCast:Hide()
end

function Plates:OnShow()
	local Colors = T["Colors"]
	local Name = self.Name:GetText() or "Unknown"
	local Level = self.Level:GetText() or ""
	local Red, Green, Blue = Plates.GetColor(self)
	local LevelRed, LevelGreen, LevelBlue = self.Level:GetTextColor()
	local Hex = Convert(LevelRed, LevelGreen, LevelBlue)
	local Boss, Dragon = self.Boss, self.Dragon
	local Threat = self.Threat
	local IsInGroup = select(2, UnitClass(Name))
	
	if IsInGroup then
		-- Party/Raid members name will be class colored
		local Class = IsInGroup
		local R, G, B = unpack(Colors.class[Class])
		local Color = Convert(R, G, B)
		
		Name = Color .. Name .. "|r"
	end
	
	self.Health:ClearAllPoints()
	self.Health:SetPoint("TOP", self.NewPlate)
	self.Health:SetPoint("LEFT", self.NewPlate)
	self.Health:SetPoint("RIGHT", self.NewPlate)
	self.Health:SetHeight(Plates.PlateHeight)
	self.Health.NewTexture:SetVertexColor(Red, Green, Blue)
	self.Health.Background:SetTexture(Red * .15, Green * .15, Blue * .15)
	
	if Boss:IsShown() then
		Level = "??"
	elseif Dragon:IsShown() then
		Level = Level .. "+"
	end
	
	self.NewName:SetText(Hex .. Level .. "|r " .. Name)
	self.NewLevel = Hex .. Level .. "|r"
end

function Plates:UpdateHealthText()
	local MinHP, MaxHP = self.Health:GetMinMaxValues()
	local CurrentHP = self.Health:GetValue()

	self.Health.Text:SetText(T.ShortValue(CurrentHP).." / "..T.ShortValue(MaxHP))
end

function Plates:Skin(obj)
	local Plate = obj
	local Texture = T.GetTexture(C["NamePlates"].Texture)
	local Font = T.GetFont(C["NamePlates"].Font)
	local FontName, FontSize, FontFlags = _G[Font]:GetFont()
	local IsPixel = false

	if (Font == "TukuiPixelFont") then
		IsPixel = true
	end
	
	Plate.Bar, Plate.Frame = Plate:GetChildren()
	
	Plate.Health, Plate.Cast = Plate.Bar:GetChildren()
	Plate.Threat, Plate.Border, Plate.Highlight, Plate.Level, Plate.Boss, Plate.Raid, Plate.Dragon = Plate.Bar:GetRegions()
	Plate.Name = Plate.Frame:GetRegions()
	Plate.Health.Texture = Plate.Health:GetRegions()
	Plate.Cast.Texture, Plate.Cast.Border, Plate.Cast.Shield, Plate.Cast.Icon, Plate.Cast.Name, Plate.Cast.NameShadow = Plate.Cast:GetRegions()
	Plate.Cast.Icon.Layer, Plate.Cast.Icon.Level = Plate.Cast.Icon:GetDrawLayer()
	
	-- Create the Name Plate ...
	self.Container[Plate] = CreateFrame("Frame", nil, self)
	
	local NewPlate = self.Container[Plate]
	NewPlate:Size(self.PlateWidth, self.PlateHeight + self.PlateCastHeight + self.PlateSpacing)
	
	-- Reference
	-- NewPlate.BlizzardPlate = Plate
	Plate.NewPlate = NewPlate
	
	Plate.Frame:SetParent(Hider)
	
	-- Original Health
	Plate.Health:SetParent(NewPlate)
	Plate.Health.Texture = Plate.Health:GetStatusBarTexture()
	Plate.Health.Texture:SetTexture(nil)
	--Plate.Health:SetScript("OnChangedValue", Plates.UpdateHealthText)
	
	-- New Health
	Plate.Health.NewTexture = Plate.Health:CreateTexture(nil, "ARTWORK", nil, -6)
	Plate.Health.NewTexture:SetAllPoints(Plate.Health.Texture)
	Plate.Health.NewTexture:SetTexture(Texture)
	Plate.Health.NewTexture:SetVertexColor(0, 1, 0)
	
	-- Health Backdrop
	Plate.Health.Background = Plate.Health:CreateTexture(nil, "BACKGROUND")
	Plate.Health.Background:SetAllPoints()
	Plate.Health:CreateShadow()
	
	-- Textures
	Plate.Border:SetAlpha(0)
	Plate.Border:SetTexture(nil)
	Plate.Highlight:SetAlpha(0)
	Plate.Highlight:SetTexture(nil)
	Plate.Boss:SetAlpha(0)
	Plate.Boss:SetTexture(nil)
	Plate.Dragon:SetAlpha(0)
	Plate.Dragon:SetTexture(nil)
	Plate.Threat:SetAlpha(0)
	Plate.Threat:SetTexture(nil)
	
	-- Casting
	Plate.Cast:SetAlpha(0)
	Plate.Cast:SetFrameLevel(1)
	
	Plate.NewCast = CreateFrame("StatusBar", nil, Plate.Health)
	Plate.NewCast:SetStatusBarTexture(C.Medias.Normal)
	Plate.NewCast:SetMinMaxValues(0, 100)
	Plate.NewCast:SetHeight(Plates.PlateCastHeight)
	Plate.NewCast:SetWidth(C.NamePlates.Width)
	Plate.NewCast:SetPoint("TOP", Plate.Health, "BOTTOM", 0, -4)
	Plate.NewCast:SetValue(100)
	Plate.NewCast.Background = Plate.NewCast:CreateTexture(nil, "BACKGROUND")
	Plate.NewCast.Background:SetAllPoints()
	Plate.NewCast:CreateShadow()
	Plate.NewCast:Hide()
	
	Plate.Cast.Icon:SetTexCoord(unpack(T.IconCoord))
	Plate.Cast.Icon:Size(self.PlateHeight + self.PlateCastHeight + self.PlateSpacing)

	Plate.Cast.Icon.Backdrop = CreateFrame("Frame", nil, Plate.NewCast)
	Plate.Cast.Icon.Backdrop:SetFrameLevel(Plate.Cast:GetFrameLevel() - 1)
	Plate.Cast.Icon.Backdrop:SetAllPoints(Plate.Cast.Icon)
	Plate.Cast.Icon.Backdrop:CreateShadow()
	
	Plate.Cast.Icon:SetParent(Plate.NewCast)
	Plate.Cast.Icon:ClearAllPoints()
	Plate.Cast.Icon:SetPoint("TOPRIGHT", Plate.Health, "TOPLEFT", -4, 0)
	
	Plate.Cast.Name:SetParent(Plate.NewCast)
	Plate.Cast.Name:ClearAllPoints()
	Plate.Cast.Name:Point("BOTTOM", Plate.NewCast, 0, -9)
	Plate.Cast.Name:Point("LEFT", Plate.NewCast, 7, 0)
	Plate.Cast.Name:Point("RIGHT", Plate.NewCast, -7, 0)
	Plate.Cast.Name:SetFont(FontName, FontSize - (IsPixel and 2 or 4), FontFlags)
	Plate.Cast.Name:SetShadowColor(0, 0, 0, 0)
	
	Plate.Cast.NameShadow:SetParent(Plate.NewCast)
	Plate.Cast.NameShadow:ClearAllPoints()
	Plate.Cast.NameShadow:SetPoint("CENTER", Plate.Cast.Name, "CENTER", 0, -2)
	
	--[[
	Plate.Cast:SetParent(NewPlate)
	Plate.Cast:SetStatusBarTexture(Texture)
	Plate.Cast:CreateShadow()
	
	Plate.Cast.Background = Plate.Cast:CreateTexture(nil, "BACKGROUND")
	Plate.Cast.Background:SetAllPoints()
	
	Plate.Cast.Border:SetTexture(nil)
	
	Plate.Cast.Icon:SetTexCoord(unpack(T.IconCoord))
	Plate.Cast.Icon:Size(self.PlateHeight + self.PlateCastHeight + self.PlateSpacing)
	
	Plate.Cast.Icon.Backdrop = CreateFrame("Frame", nil, Plate.Cast)
	Plate.Cast.Icon.Backdrop:SetFrameLevel(Plate.Cast:GetFrameLevel() - 1)
	Plate.Cast.Icon.Backdrop:SetAllPoints(Plate.Cast.Icon)
	Plate.Cast.Icon.Backdrop:CreateShadow()
	
	Plate.Cast.Name:ClearAllPoints()
	Plate.Cast.Name:Point("BOTTOM", Plate.Cast, 0, -9)
	Plate.Cast.Name:Point("LEFT", Plate.Cast, 7, 0)
	Plate.Cast.Name:Point("RIGHT", Plate.Cast, -7, 0)
	Plate.Cast.Name:SetFont(FontName, FontSize - (IsPixel and 2 or 4), FontFlags)
	Plate.Cast.Name:SetShadowColor(0, 0, 0, 0)
	--]]
	
	Plate.Cast.Shield:SetTexture(nil) -- DON'T FORGET TO ADD "CHANGE COLOR" WHEN SHOW
	
	-- Level
	Plate.Level:SetParent(Hider)
	Plate.Level:Hide()
	
	-- Name
	Plate.NewName = NewPlate:CreateFontString(nil, "OVERLAY")
	Plate.NewName:SetPoint("BOTTOM", NewPlate, "TOP", 0, 2)
	Plate.NewName:SetPoint("LEFT", NewPlate, -2, 0)
	Plate.NewName:SetPoint("RIGHT", NewPlate, 2, 0)
	Plate.NewName:SetFont(FontName, FontSize - 2, FontFlags)
	
	-- Health Text
	if C.NamePlates.HealthText then
		Plate.Health.Text = Plate.Health:CreateFontString(nil, "OVERLAY")	
		Plate.Health.Text:SetFont(FontName, FontSize - 3, FontFlags)
		Plate.Health.Text:SetShadowColor(0, 0, 0, 0.4)
		Plate.Health.Text:SetPoint("CENTER", Plate.Health)
		Plate.Health.Text:SetTextColor(1,1,1)
		--Plate.Health.Text:SetShadowOffset(T.Mult, -T.Mult)
	end
	
	Plate.Cast.NewCast = Plate.NewCast
	
	-- OnShow Execution
	Plate:HookScript("OnShow", self.OnShow)
	Plate.Cast:HookScript("OnShow", self.CastOnShow)
	Plate.Cast:HookScript("OnHide", self.CastOnHide)
	self.OnShow(Plate)
	
	-- Tell Tukui that X nameplate is Skinned
	Plate.IsSkinned = true
end

function Plates:IsNamePlate(obj)
	local Object = obj
	local Name = Object:GetName()
	
	if (Name and Name:match("NamePlate")) then
		return true
	else
		return false
	end
end

function Plates:Search()
	local CurrentFrameNumber = WorldFrame:GetNumChildren()
	
	if (FrameNumber == CurrentFrameNumber) then
		return
	end
	
	for _, Object in pairs({WorldFrame:GetChildren()}) do
		local IsPlate = self.IsNamePlate(self, Object)
		
		if (not Object.IsSkinned and IsPlate) then
			self:Skin(Object)
		end
	end
	
	FrameNumber = CurrentFrameNumber
end

function Plates:UpdateAggro()
	if (self.Threat:IsShown()) then
		if (not self.IsAggroColored) then
			self.NewName:SetTextColor(1, 0, 0)
		
			self.IsAggroColored = true
		end
	else
		if (self.IsAggroColored) then
			self.NewName:SetTextColor(1, 1, 1)
			
			self.IsAggroColored = false
		end
	end
end

function Plates:Update()
	for Plate, NewPlate in pairs(self.Container) do
		if Plate:IsShown() then
			NewPlate:SetPoint("CENTER", NameplateParent, "BOTTOMLEFT", Plate:GetCenter())
			NewPlate:Show()
			
			if Plate:GetAlpha() == 1 then -- Is Targeted
				NewPlate:SetAlpha(1)
			else
				NewPlate:SetAlpha(C.NamePlates.NonTargetAlpha)
			end
			
			self.UpdateAggro(Plate)
			
			if C.NamePlates.HealthText then
				self.UpdateHealthText(Plate)
			end
		else
			NewPlate:Hide()
		end
	end
end

function Plates:OnUpdate(elapsed)
	self:Search()
	self:Update()
end

function Plates:Enable()
	if (not C.NamePlates.Enable) then
		return
	end
	
	CT_Viewport = IsAddOnLoaded("CT_Viewport")
	
	if CT_Viewport then
		NameplateParent = UIParent
	end

	Hider = T["Panels"].Hider
	
	SetCVar("bloatnameplates", 0)
	SetCVar("bloatthreat", 0)
	
	self:SetAllPoints()
	self.Container = {}
	self:SetScript("OnUpdate", self.OnUpdate)
	self.PlateWidth = C.NamePlates.Width
	self.PlateHeight = C.NamePlates.Height
	self.PlateCastHeight = C.NamePlates.CastHeight
	self.PlateSpacing = C.NamePlates.Spacing
	self.Backdrop = {
		bgFile = C.Medias.Blank,
		edgeFile = C.Medias.Blank,
		insets = {top = -T.Mult, left = -T.Mult, bottom = -T.Mult, right = -T.Mult},
	}
end

T["NamePlates"] = Plates