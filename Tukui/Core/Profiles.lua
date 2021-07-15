local T, C, L = select(2, ...):unpack()

local Profiles = CreateFrame("Frame", "TukuiProfiles", UIParent)
local LibDeflate = LibStub:GetLibrary("LibDeflate")
local LibSerialize = LibStub("LibSerialize")
local Prefix = "Tukui:Profile:"

--[[ TESTING CODE

Tukui:Profile:D54toPpqya0PymvQyKetGL6cdlAmg9NEaQJ8NIHgiWOly1mTmIdwAnZmLaBuchHEcmCe(DcA8emB9wyCJBTLACHRMV8n59EFA1IVJWzexFQ4(3AhiKeFFIKfgubwpmGIHomHNb0jCgT5NOOhJyx5L9nKW)3W1WUiuxNonAIwDB7EeonqQ0TTEzjadaaBRZagwPdpvEdjIWhtLn5KP0HCu3EzCQDug2wZkxaKbKmkbKaaA)P0fd)FEP(TBzNHuYo55p0svRzBDk4GxbGc)0ONpzbLN3qzKB)MLfpk3(HFLoOT(xXcJ46ejbrNlfZsPy0GrctSE81pq4epjLBI3UFRiM)it8wWwHzV75oyHqsNAIlcrSPut8(XompEOdniYeVlmfwwZDZnC(eLUsVb94QVNV4YjQsQsNuiBZQbuPKfmwurvTIBNWXoK5AF)d

-- TESTING CODE ]]

function Profiles:Export()
	local Settings = {}

	Settings.Variables = TukuiDatabase.Variables[T.MyRealm][T.MyName]
	Settings.Settings = TukuiDatabase.Settings[T.MyRealm][T.MyName]

	local Serialized = LibSerialize:Serialize(Settings)
	local Compressed = LibDeflate:CompressDeflate(Serialized)
	local Encoded = LibDeflate:EncodeForPrint(Compressed)
	local Result = Prefix..Encoded

	return Result
end

function Profiles:Import()
	local EditBox = self:GetParent().EditBox
	local Status = self:GetParent().Status
	local Code = EditBox:GetText()
	local LibCode = string.gsub(Code, Prefix, "")
	local Decoded = LibDeflate:DecodeForPrint(LibCode)
	local CurrentCode = self:GetParent():Export()

	if Code == CurrentCode then
		Status:SetText("|cffff0000SORRY, YOU ARE CURRENTLY USING THIS PROFILE|r")
	elseif Decoded then
		local Decompressed = LibDeflate:DecompressDeflate(Decoded)
		local Success, Table = LibSerialize:Deserialize(Decompressed)

		if Success then
			TukuiDatabase.Variables[T.MyRealm][T.MyName] = Table.Variables
			TukuiDatabase.Settings[T.MyRealm][T.MyName] = Table.Settings

			ReloadUI()
		else
			Status:SetText("|cffff0000SORRY, THIS CODE IS NOT VALID|r")
		end
	else
		Status:SetText("|cffff0000SORRY, THIS CODE IS NOT VALID|r")
	end
end

function Profiles:Toggle()
	if self:IsShown() then
		self:Hide()
	else
		self:Show()
		self.EditBox:SetText(self:Export())
	end
end

function Profiles:OnTextChanged()
	local Code = self:GetText()
	local Status = self:GetParent().Status
	local CurrentCode = self:GetParent():Export()

	if Code ~= CurrentCode then
		Status:SetText("YOU ARE CURRENTLY TRYING TO APPLY A NEW CODE")
	else
		Status:SetText("EXPORT CODE FOR "..T.RGBToHex(unpack(T.Colors.class[T.MyClass]))..string.upper(T.MyName).."|r")
	end
end

function Profiles:RestoreCode()
	local EditBox = self:GetParent().EditBox

	EditBox:SetText(self:GetParent():Export())
end

function Profiles:Enable()
	self:SetSize(600, 170)
	self:SetPoint("CENTER", UIParent, "CENTER", 0, 100)
	self:CreateBackdrop("Transparent")
	self:CreateShadow()
	self:EnableMouse(true)
	self:RegisterForDrag("LeftButton")
	self:SetMovable(true)
	self:SetUserPlaced(true)
	self:SetScript("OnDragStart", function()
		self:StartMoving()
	end)
	self:SetScript("OnDragStop", function()
		self:StopMovingOrSizing()
	end)

	self.Logo = self:CreateTexture(nil, "OVERLAY")
	self.Logo:SetSize(128, 128)
	self.Logo:SetTexture(C.Medias.Logo)
	self.Logo:SetPoint("TOP", self, "TOP", 0, 60)

	self.Title = self:CreateFontString(nil, "OVERLAY")
	self.Title:SetFont(C.Medias.Font, 16, "THINOUTLINE")
	self.Title:SetPoint("TOP", self, "TOP", 0, -86)
	self.Title:SetText("In this window, you will be able to export, import or share your profile.")

	self.Description = self:CreateFontString(nil, "OVERLAY")
	self.Description:SetFont(C.Medias.Font, 16, "THINOUTLINE")
	self.Description:SetPoint("TOP", self.Title, "TOP", 0, -18)
	self.Description:SetText("If you wish to use another profile, just replace the code below and hit apply.")

	self.Status = self:CreateFontString(nil, "OVERLAY")
	self.Status:SetFont(C.Medias.Font, 16, "THINOUTLINE")
	self.Status:SetPoint("TOP", self.Title, "TOP", 0, -60)
	self.Status:SetTextColor(1, .5, 0)

	self.EditBox = CreateFrame("EditBox", nil, self)
	self.EditBox:SetMultiLine(true)
	self.EditBox:SetCursorPosition(0)
	self.EditBox:EnableMouse(true)
	self.EditBox:SetAutoFocus(false)
	self.EditBox:SetFontObject(ChatFontNormal)
	self.EditBox:SetWidth(self:GetWidth() - 28)
	self.EditBox:SetHeight(250)
	self.EditBox:SetPoint("TOP", self, "BOTTOM", 0, 0)
	self.EditBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	self.EditBox:SetScript("OnTextChanged", Profiles.OnTextChanged)
	self.EditBox:CreateBackdrop()
	self.EditBox.Backdrop:SetPoint("TOPLEFT", -4, 4)
	self.EditBox.Backdrop:SetPoint("BOTTOMRIGHT", 4, -4)
	self.EditBox.Backdrop:SetBorderColor(1, 0.5, 0)
	self.EditBox:SetTextInsets(4, 4, 4, 4)
	self.EditBox.Backdrop:CreateShadow()

	self.Reset = CreateFrame("Button", nil, self)
	self.Reset:SetSize(self:GetWidth() / 3 - 14, 30)
	self.Reset:SkinButton()
	self.Reset:SetPoint("TOPLEFT", self.EditBox, "BOTTOMLEFT", -4, -28)
	self.Reset.Text = self.Reset:CreateFontString(nil, "OVERLAY")
	self.Reset.Text:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.Reset.Text:SetPoint("CENTER")
	self.Reset.Text:SetText("Display my code")
	self.Reset:SetScript("OnClick", Profiles.RestoreCode)
	self.Reset:CreateShadow()

	self.Close = CreateFrame("Button", nil, self)
	self.Close:SetSize(self:GetWidth() / 3 - 14, 30)
	self.Close:SkinButton()
	self.Close:SetPoint("TOP", self.EditBox, "BOTTOM", 0, -28)
	self.Close.Text = self.Close:CreateFontString(nil, "OVERLAY")
	self.Close.Text:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.Close.Text:SetPoint("CENTER")
	self.Close.Text:SetText(CLOSE)
	self.Close:SetScript("OnClick", function(self) self:GetParent():Hide() end)
	self.Close:CreateShadow()

	self.Apply = CreateFrame("Button", nil, self)
	self.Apply:SetSize(self:GetWidth() / 3 - 14, 30)
	self.Apply:SkinButton()
	self.Apply:SetPoint("TOPRIGHT", self.EditBox, "BOTTOMRIGHT", 4, -28)
	self.Apply.Text = self.Apply:CreateFontString(nil, "OVERLAY")
	self.Apply.Text:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.Apply.Text:SetPoint("CENTER")
	self.Apply.Text:SetText("Apply new code")
	self.Apply:SetScript("OnClick", Profiles.Import)
	self.Apply:CreateShadow()

	self.Backdrop:SetPoint("BOTTOM", self.Reset, "BOTTOM", 0, -10)
	self:Hide()
end

T["Profiles"] = Profiles