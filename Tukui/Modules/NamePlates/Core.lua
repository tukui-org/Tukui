local T, C, L = select(2, ...):unpack()

local _G = _G
local unpack = unpack
local match, gsub = match, gsub
local WorldFrame = WorldFrame
local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local FACTION_BAR_COLORS = FACTION_BAR_COLORS

local Hider
local Convert = T.RGBToHex
local Scale = T.Scale
local NameplateParent = WorldFrame
local NamePlateIndex

local IsInGroup = IsInGroup

local Plates = CreateFrame("Frame", nil, WorldFrame)

function Plates:GetColor()
	local Colors = T["Colors"]

	local Red, Green, Blue = self.Health:GetStatusBarColor()

	for Class, _ in pairs(RAID_CLASS_COLORS) do
		local AltBlue = Blue

		if Class == "MONK" then
			AltBlue = AltBlue - 0.01
		end

		if RAID_CLASS_COLORS[Class].r == Red and RAID_CLASS_COLORS[Class].g == Green and RAID_CLASS_COLORS[Class].b == AltBlue then
			Red, Green, Blue = unpack(Colors.class[Class])
			return Red, Green, Blue
		end
	end

	if (Red + Blue + Blue) == 1.59 then			-- Tapped
		Red, Green, Blue = unpack(Colors.tapped)
	elseif Green + Blue == 0 then				-- Hostile
		Red, Green, Blue = unpack(Colors.reaction[2])
	elseif Red + Blue == 0 then					-- Friendly NPC
		Red, Green, Blue = unpack(Colors.reaction[5])
	elseif Red + Green > 1.95 then				-- Neutral NPC
		Red, Green, Blue = unpack(Colors.reaction[4])
	elseif Red + Green == 0 then				-- Friendly Player
		Red, Green, Blue = unpack(Colors.reaction[5])
	end

	return Red, Green, Blue
end

function Plates:UpdateCastBar()
	local Red, Blue, Green = self:GetStatusBarColor()
	local Minimum, Maximum = self:GetMinMaxValues()
	local Current = self:GetValue()
	local Shield = self.Shield

	if Shield:IsShown() then
		self.NewCast:SetStatusBarColor(222/255, 95/255, 95/255)
		self.NewCast.Background:SetTexture((222/255) * .15, (95/255) * .15, (95/255) * .15)
	else
		self.NewCast:SetStatusBarColor(Red, Blue, Green)
		self.NewCast.Background:SetTexture(Red * .15, Blue * .15, Green * .15)	
	end

	self.NewCast:SetMinMaxValues(Minimum, Maximum)
	self.NewCast:SetValue(Current)
end

function Plates:CastOnShow()
	self.NewCast:Show()
end

function Plates:CastOnHide()
	self.NewCast:Hide()
end

function Plates:OnShow()
	if not self:IsShown() then
		return
	end

	local Name = self.Name:GetText() or "Unknown"
	local Level = self.Level:GetText() or ""
	local LevelRed, LevelGreen, LevelBlue = self.Level:GetTextColor()
	local Hex = Convert(LevelRed, LevelGreen, LevelBlue)
	local Boss, Dragon = self.Boss, self.Dragon

	if Boss:IsShown() then
		Level = "??"
	elseif Dragon:IsShown() then
		Level = Level .. "+"
	end

	self.NewName:SetText(Hex .. Level .. "|r " .. Name)
end

function Plates:UpdateHealth()
	self.NewHealth:SetMinMaxValues(self:GetMinMaxValues())
	self.NewHealth:SetValue(self:GetValue())
end

function Plates:UpdateHealthColor()
	if not self:IsShown() then
		return
	end

	local Red, Green, Blue = Plates.GetColor(self)

	if IsInGroup() then
		local Name = self.Name:GetText() or "Unknown"
		Name = gsub(Name, ' %(.%)$', '')			-- X-Realm Fix
		local Class = select(2, UnitClass(Name))
		if Class then
			if C.NamePlates.NameTextColor then
				self.NewName:SetTextColor(unpack(T["Colors"].class[Class]))
			else
				Red, Green, Blue = unpack(T["Colors"].class[Class])
			end
		end
	end

	self.NewPlate.Health:SetStatusBarColor(Red, Green, Blue)
	self.NewPlate.Health.Background:SetTexture(Red * .15, Green * .15, Blue * .15)
end

function Plates:UpdateHealthText()
	local MinHP, MaxHP = self.Health:GetMinMaxValues()
	local CurrentHP = self.Health:GetValue()

	self.NewPlate.Health.Text:SetText(T.ShortValue(CurrentHP).." / "..T.ShortValue(MaxHP))
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

	self.Container[Plate] = CreateFrame("Frame", nil, self)

	local NewPlate = self.Container[Plate]
	NewPlate:Size(self.PlateWidth, self.PlateHeight + self.PlateCastHeight + self.PlateSpacing)
	NewPlate:SetFrameStrata("BACKGROUND")
	NewPlate:SetFrameLevel(2)

	-- Reference
	NewPlate.BlizzardPlate = Plate
	Plate.NewPlate = NewPlate

	Plate.Frame:SetParent(Hider)
	Plate.Level:SetParent(Hider)
	Plate.Health:SetParent(Hider)
	Plate.Cast:SetAlpha(0)

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

	NewPlate.Health = CreateFrame("StatusBar", nil, NewPlate)
	NewPlate.Health:Size(self.PlateWidth, self.PlateHeight)
	NewPlate.Health:SetStatusBarTexture(Texture)
	NewPlate.Health:SetPoint("CENTER", 0, 4)
	NewPlate.Health:CreateShadow()

	NewPlate.Health.Background = NewPlate.Health:CreateTexture(nil, "BACKGROUND", nil, -8)
	NewPlate.Health.Background:SetTexture(Texture)
	NewPlate.Health.Background:SetAllPoints()

	-- Casting

	NewPlate.Cast = CreateFrame("StatusBar", nil, NewPlate.Health)
	NewPlate.Cast:SetStatusBarTexture(Texture)
	NewPlate.Cast:SetMinMaxValues(0, 100)
	NewPlate.Cast:SetHeight(Plates.PlateCastHeight)
	NewPlate.Cast:SetWidth(C.NamePlates.Width)
	NewPlate.Cast:SetPoint("TOP", NewPlate.Health, "BOTTOM", 0, -4)
	NewPlate.Cast:SetValue(100)
	NewPlate.Cast.Background = NewPlate.Cast:CreateTexture(nil, "BACKGROUND")
	NewPlate.Cast.Background:SetAllPoints()
	NewPlate.Cast:CreateShadow()
	NewPlate.Cast:Hide()

	Plate.Cast.Icon:SetTexCoord(unpack(T.IconCoord))
	Plate.Cast.Icon:Size(self.PlateHeight + self.PlateCastHeight + self.PlateSpacing)
	Plate.Cast.Icon:SetParent(NewPlate.Cast)
	Plate.Cast.Icon:ClearAllPoints()
	Plate.Cast.Icon:SetPoint("TOPRIGHT", NewPlate.Health, "TOPLEFT", -4, 0)

	Plate.Cast.Icon.Backdrop = CreateFrame("Frame", nil, NewPlate.Cast)
	Plate.Cast.Icon.Backdrop:SetFrameLevel(NewPlate.Cast:GetFrameLevel() - 1)
	Plate.Cast.Icon.Backdrop:SetAllPoints(Plate.Cast.Icon)
	Plate.Cast.Icon.Backdrop:CreateShadow()

	Plate.Cast.Name:SetParent(NewPlate.Cast)
	Plate.Cast.Name:ClearAllPoints()
	Plate.Cast.Name:Point("BOTTOM", NewPlate.Cast, 0, -9)
	Plate.Cast.Name:Point("LEFT", NewPlate.Cast, 7, 0)
	Plate.Cast.Name:Point("RIGHT", NewPlate.Cast, -7, 0)
	Plate.Cast.Name:SetFont(FontName, FontSize - (IsPixel and 2 or 4), FontFlags)
	Plate.Cast.Name:SetShadowColor(0, 0, 0, 0)

	Plate.Cast.NameShadow:SetParent(NewPlate.Cast)
	Plate.Cast.NameShadow:ClearAllPoints()
	Plate.Cast.NameShadow:SetPoint("CENTER", Plate.Cast.Name, "CENTER", 0, -2)
	Plate.Cast.Shield:SetTexture(nil)

	-- Name
	Plate.NewName = NewPlate:CreateFontString(nil, "OVERLAY")
	Plate.NewName:SetPoint("BOTTOM", NewPlate, "TOP", 0, 2)
	Plate.NewName:SetPoint("LEFT", NewPlate, -2, 0)
	Plate.NewName:SetPoint("RIGHT", NewPlate, 2, 0)
	Plate.NewName:SetFont(FontName, FontSize - 2, FontFlags)

	if C.NamePlates.HealthText then
		NewPlate.Health.Text = NewPlate.Health:CreateFontString(nil, "OVERLAY")	
		NewPlate.Health.Text:SetFont(FontName, FontSize - 3, FontFlags)
		NewPlate.Health.Text:SetShadowColor(0, 0, 0, 0.4)
		NewPlate.Health.Text:SetPoint("CENTER", NewPlate.Health)
		NewPlate.Health.Text:SetTextColor(1, 1, 1)
	end

	Plate.Cast.NewCast = NewPlate.Cast
	Plate.Health.NewHealth = NewPlate.Health

	-- OnShow Execution
	self.OnShow(Plate)
	Plate:HookScript("OnShow", self.OnShow)
	Plate.Health:HookScript('OnValueChanged', self.UpdateHealth)
	Plate.Cast:HookScript("OnShow", self.CastOnShow)
	Plate.Cast:HookScript("OnHide", self.CastOnHide)
	Plate.Cast:HookScript("OnValueChanged", self.UpdateCastBar)

	-- Tell Tukui that X nameplate is Skinned
	Plate.IsSkinned = true
	NamePlateIndex = NamePlateIndex + 1
end

function Plates:Search()
	if not NamePlateIndex then
		for _, BlizzardPlate in next, {WorldFrame:GetChildren()} do
			local Name = BlizzardPlate:GetName()
			if Name and match(Name, "^NamePlate%d+$") then
				NamePlateIndex = gsub(Name,"NamePlate","")
				break
			end
		end
	else
		local BlizzardPlate = _G["NamePlate"..NamePlateIndex]
		if BlizzardPlate and not BlizzardPlate.IsSkinned then
			self:Skin(BlizzardPlate)
		end
	end
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
			NewPlate:Hide()
			NewPlate:SetPoint("CENTER", NameplateParent, "BOTTOMLEFT", Plate:GetCenter())
			NewPlate:Show()

			if Plate:GetAlpha() == 1 then
				NewPlate:SetAlpha(1)
			else
				NewPlate:SetAlpha(C.NamePlates.NonTargetAlpha)
			end

			self.UpdateAggro(Plate)
			self.UpdateHealthColor(Plate)
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

	if IsAddOnLoaded("CT_Viewport") then
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