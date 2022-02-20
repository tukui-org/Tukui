local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]
local Popups = T["Popups"]
local Tracking = CreateFrame("Frame", "TukuiTracking", UIParent)

Popups.Popup["TRACKING_ADD_PVE"] = {
	Question = "Which spell id would you like to add?",
	Answer1 = ACCEPT,
	Answer2 = CANCEL,
	Function1 = function(self)
		local Parent = self:GetParent()
		local SpellID = tonumber(Parent.EditBox:GetText())
		local Table = TukuiDatabase.Variables[T.MyRealm][T.MyName].Tracking.PvE
		local Name, Rank, Icon, CastTime, MinRange, MaxRange, ID = GetSpellInfo(SpellID)
		local Values = {["enable"] = true, ["priority"] = 1, ["stackThreshold"] = 0}
		local TrackingTitle = "|CFF00FF00[DEBUFF TRACKING] |r"
		local PVETitle = "|CFF567AFF[PVE] |r"

		if Name then
			if Table[SpellID] then
				T.Print(TrackingTitle..PVETitle.."Sorry, |CFFFFFF00"..Name.."|r is already tracked")
			else
				T.Print(TrackingTitle..PVETitle.."You have added |CFFFFFF00"..Name.."|r")
				
				Table[SpellID] = Values
				
				Tracking.PVE.Text:SetText(Name)
				Tracking.PVE.Icon.Texture:SetTexture(Icon)
				Tracking.PVE.SpellID = SpellID
				
				UnitFrames:UpdateRaidDebuffIndicator()
			end
		else
			T.Print(TrackingTitle..PVETitle.."Sorry, this spell id doesn't exist")
		end
	end,
	EditBox = true,
}

Popups.Popup["TRACKING_ADD_PVP"] = {
	Question = "Which spell id would you like to add?",
	Answer1 = ACCEPT,
	Answer2 = CANCEL,
	Function1 = function(self)
		local Parent = self:GetParent()
		local SpellID = tonumber(Parent.EditBox:GetText())
		local Table = TukuiDatabase.Variables[T.MyRealm][T.MyName].Tracking.PvP
		local Name, Rank, Icon, CastTime, MinRange, MaxRange, ID = GetSpellInfo(SpellID)
		local Values = {["enable"] = true, ["priority"] = 1, ["stackThreshold"] = 0}
		local TrackingTitle = "|CFF00FF00[DEBUFF TRACKING] |r"
		local PVPTitle = "|CFFFF5252[PVP] |r"

		if Name then
			if Table[SpellID] then
				T.Print(TrackingTitle..PVPTitle.."Sorry, |CFFFFFF00"..Name.."|r is already tracked")
			else
				T.Print(TrackingTitle..PVPTitle.."You have added |CFFFFFF00"..Name.."|r")
				
				Table[SpellID] = Values
				
				Tracking.PVP.Text:SetText(Name)
				Tracking.PVP.Icon.Texture:SetTexture(Icon)
				Tracking.PVP.SpellID = SpellID
				
				UnitFrames:UpdateRaidDebuffIndicator()
			end
		else
			T.Print(TrackingTitle..PVPTitle.."Sorry, this spell id doesn't exist")
		end
	end,
	EditBox = true,
}

function Tracking:GetSpell(button, cat)
	local Count = 0
	local ID = button.ID
	local Table = TukuiDatabase.Variables[T.MyRealm][T.MyName].Tracking[cat]
	
	for SpellID, Values in pairs(Table) do
		Count = Count + 1

		if Count == ID then
			local Name, Rank, IconPath, CastTime, MinRange, MaxRange, ID = GetSpellInfo(SpellID)

			return SpellID, Name, IconPath
		end
	end
end

function Tracking:RemoveSpell()
	local Cat = self.Cat
	local SpellID = self.SpellID
	local Table = TukuiDatabase.Variables[T.MyRealm][T.MyName].Tracking[Cat]
	
	if SpellID and Table[SpellID] then
		Table[SpellID] = nil
		
		UnitFrames:UpdateRaidDebuffIndicator()
		
		self.ID = 0
		self.Next:Click()
	end
end

function Tracking:Update()
	local Button = self:GetParent()
	local Cat = Button.Cat
	local ID = Button.ID
	local Texture = self.Texture:GetTexture()
	local Icon = Button.Icon.Texture
	local Text = Button.Text
	local CurrentID = ID
	
	if self.Decrease then
		Button.ID = Button.ID - 1
	else
		Button.ID = Button.ID + 1
	end

	local SpellID, Name, IconPath = Tracking:GetSpell(Button, Cat)

	if Name and IconPath then
		Text:SetText(Name)
		Icon:SetTexture(IconPath)
		
		Button.SpellID = SpellID
	else
		Button.ID = CurrentID
	end
	
	if Button.ID == 0 then
		Icon:SetTexture([[Interface\Icons\Inv_misc_questionmark]])
		Text:SetText("|cffff8800This list is currently empty!|r")
	end
end

function Tracking:Toggle()
	if self:IsShown() then
		self:Hide()
	else
		self:Show()
	end
end

function Tracking:Enable()
	self:SetSize(460, 280)
	self:SetPoint("CENTER", UIParent, "CENTER", 0, 64)
	self:CreateBackdrop("Transparent")
	self:CreateShadow()
	
	self.Logo = self:CreateTexture(nil, "OVERLAY")
	self.Logo:SetSize(128, 128)
	self.Logo:SetTexture(C.Medias.Logo)
	self.Logo:SetPoint("TOP", self, "TOP", 0, 60)
	
	self.TitlePVE = self:CreateFontString(nil, "OVERLAY")
	self.TitlePVE:SetFont(C.Medias.Font, 16, "THINOUTLINE")
	self.TitlePVE:SetPoint("TOP", self, "TOP", 0, -86)
	self.TitlePVE:SetText("PvE Debuffs to track")
	
	self.PVE = CreateFrame("Button", nil, self)
	self.PVE:SetSize(300, 32)
	self.PVE:SetPoint("TOP", self.TitlePVE, "BOTTOM", 18, -10)
	self.PVE:SkinButton()
	self.PVE:CreateShadow()
	self.PVE:SetScript("OnClick", self.RemoveSpell)
	self.PVE.ID = 0
	self.PVE.Cat = "PvE"
	
	self.PVE.Text = self.PVE:CreateFontString(nil, "OVERLAY")
	self.PVE.Text:SetFont(C.Medias.Font, 14, "THINOUTLINE")
	self.PVE.Text:SetPoint("LEFT", 10, 0)
	
	self.PVE.Icon = CreateFrame("Frame", nil, self.PVE)
	self.PVE.Icon:SetSize(32, 32)
	self.PVE.Icon:SetPoint("RIGHT", self.PVE, "LEFT", -4, 0)
	self.PVE.Icon:CreateBackdrop()
	self.PVE.Icon:CreateShadow()
	
	self.PVE.Icon.Texture = self.PVE.Icon:CreateTexture(nil, "OVERLAY")
	self.PVE.Icon.Texture:SetAllPoints()
	self.PVE.Icon.Texture:SetTexCoord(unpack(T.IconCoord))
	
	self.PVE.Previous = CreateFrame("Button", nil, self.PVE)
	self.PVE.Previous:SetSize(32, 32)
	self.PVE.Previous:SetPoint("RIGHT", self.PVE, "LEFT", -40, 0)
	self.PVE.Previous:SkinButton()
	self.PVE.Previous:CreateShadow()
	self.PVE.Previous:SetScript("OnClick", self.Update)
	
	self.PVE.Previous.Texture = self.PVE.Previous:CreateTexture(nil, "OVERLAY")
	self.PVE.Previous.Texture:SetSize(16, 16)
	self.PVE.Previous.Texture:SetPoint("CENTER")
	self.PVE.Previous.Texture:SetTexture(C.Medias.ArrowUp)
	self.PVE.Previous.Decrease = true
	SetClampedTextureRotation(self.PVE.Previous.Texture, 270)
	
	self.PVE.Next = CreateFrame("Button", nil, self.PVE)
	self.PVE.Next:SetSize(32, 32)
	self.PVE.Next:SetPoint("LEFT", self.PVE, "RIGHT", 4, 0)
	self.PVE.Next:SkinButton()
	self.PVE.Next:CreateShadow()
	self.PVE.Next:SetScript("OnClick", self.Update)
	
	self.PVE.Next.Texture = self.PVE.Next:CreateTexture(nil, "OVERLAY")
	self.PVE.Next.Texture:SetSize(16, 16)
	self.PVE.Next.Texture:SetPoint("CENTER")
	self.PVE.Next.Texture:SetTexture(C.Medias.ArrowDown)
	SetClampedTextureRotation(self.PVE.Next.Texture, 270)
	
	self.PVE.Add = CreateFrame("Button", nil, self)
	self.PVE.Add:SetSize(self:GetWidth() / 2 - 4, 24)
	self.PVE.Add:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -4)
	self.PVE.Add:SkinButton()
	self.PVE.Add:CreateShadow()
	self.PVE.Add:SetScript("OnClick", function() Popups.ShowPopup("TRACKING_ADD_PVE") end)
	
	self.PVE.Add.Text = self.PVE.Add:CreateFontString(nil, "OVERLAY")
	self.PVE.Add.Text:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.PVE.Add.Text:SetPoint("CENTER")
	self.PVE.Add.Text:SetText("Add a pve debuff to track")
	
	self.TitlePVP = self:CreateFontString(nil, "OVERLAY")
	self.TitlePVP:SetFont(C.Medias.Font, 16, "THINOUTLINE")
	self.TitlePVP:SetPoint("TOP", self.TitlePVE, "TOP", 0, -86)
	self.TitlePVP:SetText("PvP Debuffs to track")
	
	self.PVP = CreateFrame("Button", nil, self)
	self.PVP:SetSize(300, 32)
	self.PVP:SetPoint("TOP", self.TitlePVP, "BOTTOM", 18, -10)
	self.PVP:SkinButton()
	self.PVP:CreateShadow()
	self.PVP:SetScript("OnClick", self.RemoveSpell)
	self.PVP.ID = 0
	self.PVP.Cat = "PvP"
	
	self.PVP.Text = self.PVP:CreateFontString(nil, "OVERLAY")
	self.PVP.Text:SetFont(C.Medias.Font, 14, "THINOUTLINE")
	self.PVP.Text:SetPoint("LEFT", 10, 0)
	
	self.PVP.Icon = CreateFrame("Frame", nil, self.PVP)
	self.PVP.Icon:SetSize(32, 32)
	self.PVP.Icon:SetPoint("RIGHT", self.PVP, "LEFT", -4, 0)
	self.PVP.Icon:CreateBackdrop()
	self.PVP.Icon:CreateShadow()
	
	self.PVP.Icon.Texture = self.PVP.Icon:CreateTexture(nil, "OVERLAY")
	self.PVP.Icon.Texture:SetAllPoints()
	self.PVP.Icon.Texture:SetTexCoord(unpack(T.IconCoord))
	self.PVP.Icon.Texture:SetTexture([[Interface\Icons\Inv_misc_questionmark]])
	
	self.PVP.Previous = CreateFrame("Button", nil, self.PVP)
	self.PVP.Previous:SetSize(32, 32)
	self.PVP.Previous:SetPoint("RIGHT", self.PVP, "LEFT", -40, 0)
	self.PVP.Previous:SkinButton()
	self.PVP.Previous:CreateShadow()
	self.PVP.Previous:SetScript("OnClick", self.Update)
	
	self.PVP.Previous.Texture = self.PVP.Previous:CreateTexture(nil, "OVERLAY")
	self.PVP.Previous.Texture:SetSize(16, 16)
	self.PVP.Previous.Texture:SetPoint("CENTER")
	self.PVP.Previous.Texture:SetTexture(C.Medias.ArrowUp)
	self.PVP.Previous.Decrease = true
	SetClampedTextureRotation(self.PVP.Previous.Texture, 270)
	
	self.PVP.Next = CreateFrame("Button", nil, self.PVP)
	self.PVP.Next:SetSize(32, 32)
	self.PVP.Next:SetPoint("LEFT", self.PVP, "RIGHT", 4, 0)
	self.PVP.Next:SkinButton()
	self.PVP.Next:CreateShadow()
	self.PVP.Next:SetScript("OnClick", self.Update)
	
	self.PVP.Next.Texture = self.PVP.Next:CreateTexture(nil, "OVERLAY")
	self.PVP.Next.Texture:SetSize(16, 16)
	self.PVP.Next.Texture:SetPoint("CENTER")
	self.PVP.Next.Texture:SetTexture(C.Medias.ArrowDown)
	SetClampedTextureRotation(self.PVP.Next.Texture, 270)
	
	self.PVP.Add = CreateFrame("Button", nil, self)
	self.PVP.Add:SetSize(self:GetWidth() / 2 - 4, 24)
	self.PVP.Add:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 0, -4)
	self.PVP.Add:SkinButton()
	self.PVP.Add:CreateShadow()
	self.PVP.Add:SetScript("OnClick", function() Popups.ShowPopup("TRACKING_ADD_PVP") end)
	
	self.PVP.Add.Text = self.PVP.Add:CreateFontString(nil, "OVERLAY")
	self.PVP.Add.Text:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.PVP.Add.Text:SetPoint("CENTER")
	self.PVP.Add.Text:SetText("Add a pvp debuff to track")

	self.Close = CreateFrame("Button", nil, self)
	self.Close:SetSize(24, 24)
	self.Close:SetPoint("TOPRIGHT", self, "TOPRIGHT", -20, -20)
	self.Close:SkinCloseButton()
	self.Close:SetScript("OnClick", function(self) self:GetParent():Hide() end)
	
	self.Footer = self:CreateFontString(nil, "OVERLAY")
	self.Footer:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.Footer:SetPoint("BOTTOM", 0, 18)
	self.Footer:SetText("To remove a debuff from the list, select with arrow and click on name")
	
	-- Init
	self.PVE.Next:Click()
	self.PVP.Next:Click()
	self:Hide()
end

T["UnitFrames"]["Tracking"] = Tracking