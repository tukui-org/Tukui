local T, C, L = select(2, ...):unpack()

local Status = CreateFrame("Frame", "TukuiStatus", UIParent)

function Status:AddonsCheck()
	for i = 1, GetNumAddOns() do
		local Name = GetAddOnInfo(i)
		if ((Name ~= "Tukui" and Name ~= "Tukui_Config") and IsAddOnLoaded(Name)) then
			return "Yes"
		end
	end

	return "No"
end

function Status:ShowWindow()
	self:Show()
	self:Size(300, 430)
	self:SetPoint("CENTER")
	self:SetTemplate("Transparent")
	self:CreateShadow()

	self.Logo = Status:CreateTexture(nil, "OVERLAY")
	self.Logo:Size(256, 128)
	self.Logo:SetTexture(C.Medias.Logo)
	self.Logo:Point("TOP", Status, "TOP", -8, 68)

	self.Title = self:CreateFontString(nil, "OVERLAY")
	self.Title:SetFont(C.Medias.Font, 16, "THINOUTLINE")
	self.Title:SetPoint("TOP", 0, -66)
	self.Title:SetText("DEBUG STATUS WINDOW")

	self.Version = self:CreateFontString(nil, "OVERLAY")
	self.Version.Value = T.Version
	self.Version:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.Version:SetPoint("TOP", self.Title, 0, -40)
	self.Version:SetText("Tukui Version: "..self.Version.Value)

	self.Addons = self:CreateFontString(nil, "OVERLAY")
	self.Addons.Value = self.AddonsCheck()
	self.Addons:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.Addons:SetPoint("TOP", self.Version, 0, -20)
	self.Addons:SetText("Other AddOns Enabled: "..self.Addons.Value)

	self.UIScale = self:CreateFontString(nil, "OVERLAY")
	self.UIScale.Value = C.General.Scaling.Value.." ("..T.UIScale..")"
	self.UIScale:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.UIScale:SetPoint("TOP", self.Addons, 0, -20)
	self.UIScale:SetText("Scaling: "..self.UIScale.Value)

	self.WoWBuild = self:CreateFontString(nil, "OVERLAY")
	self.WoWBuild.Value = T.WoWPatch.." ("..T.WoWBuild..")"
	self.WoWBuild:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.WoWBuild:SetPoint("TOP", self.UIScale, 0, -20)
	self.WoWBuild:SetText("Version of WoW: "..self.WoWBuild.Value)

	self.Language = self:CreateFontString(nil, "OVERLAY")
	self.Language.Value = GetLocale()
	self.Language:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.Language:SetPoint("TOP", self.WoWBuild, 0, -20)
	self.Language:SetText("Language: "..self.Language.Value)

	self.Resolution = self:CreateFontString(nil, "OVERLAY")
	self.Resolution.Value = T.Resolution
	self.Resolution:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.Resolution:SetPoint("TOP", self.Language, 0, -20)
	self.Resolution:SetText("Resolution: "..self.Resolution.Value)

	self.Mac = self:CreateFontString(nil, "OVERLAY")
	self.Mac.Value = IsMacClient() == 1 and "Yes" or "No"
	self.Mac:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.Mac:SetPoint("TOP", self.Resolution, 0, -20)
	self.Mac:SetText("Mac client: "..self.Mac.Value)

	self.Faction = self:CreateFontString(nil, "OVERLAY")
	self.Faction.Value = UnitFactionGroup("player")
	self.Faction:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.Faction:SetPoint("TOP", self.Mac, 0, -20)
	self.Faction:SetText("Faction: "..self.Faction.Value)

	self.Race = self:CreateFontString(nil, "OVERLAY")
	self.Race.Value = select(2, UnitRace("player"))
	self.Race:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.Race:SetPoint("TOP", self.Faction, 0, -20)
	self.Race:SetText("Race: "..self.Race.Value)

	self.Class = self:CreateFontString(nil, "OVERLAY")
	self.Class.Value = select(2, UnitClass("player"))
	self.Class:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.Class:SetPoint("TOP", self.Race, 0, -20)
	self.Class:SetText("Class: "..self.Class.Value)

	self.Spec = self:CreateFontString(nil, "OVERLAY")
	self.Spec.Value = select(2, GetSpecializationInfo(GetSpecialization()))
	self.Spec:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.Spec:SetPoint("TOP", self.Class, 0, -20)
	self.Spec:SetText("Specialization: "..self.Spec.Value)

	self.Level = self:CreateFontString(nil, "OVERLAY")
	self.Level.Value = UnitLevel("player")
	self.Level:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.Level:SetPoint("TOP", self.Spec, 0, -20)
	self.Level:SetText("Level: "..self.Level.Value)

	self.Zone = self:CreateFontString(nil, "OVERLAY")
	self.Zone.Value = GetZoneText()
	self.Zone:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.Zone:SetPoint("TOP", self.Level, 0, -20)
	self.Zone:SetText("Current zone: "..self.Zone.Value)

	self.Close = CreateFrame("Button", nil, self)
	self.Close:Size(120, 30)
	self.Close:SetTemplate()
	self.Close:SetPoint("TOP", self.Zone, 0, -40)
	self.Close.Text = self.Close:CreateFontString(nil, "OVERLAY")
	self.Close.Text:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.Close.Text:SetPoint("CENTER")
	self.Close.Text:SetText(CLOSE)
	self.Close:SetScript("OnClick", function(self) self:GetParent():Hide() end)
end
