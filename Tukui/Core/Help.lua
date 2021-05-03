local T, C, L = select(2, ...):unpack()

local Help = CreateFrame("Frame", "TukuiHelp", UIParent)
local Texts = {}
local Count = 1

function Help:Enable()
	self:SetSize(900, 580)
	self:SetPoint("TOP", UIParent, "TOP", 0, -200)
	self:CreateBackdrop("Transparent")
	self:CreateShadow()
	
	self.Logo = self:CreateTexture(nil, "OVERLAY")
	self.Logo:SetSize(128, 128)
	self.Logo:SetTexture(C.Medias.Logo)
	self.Logo:SetPoint("TOP", self, "TOP", 0, 60)
	
	self.Title = self:CreateFontString(nil, "OVERLAY")
	self.Title:SetFont(C.Medias.Font, 16, "THINOUTLINE")
	self.Title:SetPoint("TOP", self, "TOP", 0, -86)
	self.Title:SetText("NEED HELP?")
	
	self.Description = self:CreateFontString(nil, "OVERLAY")
	self.Description:SetFont(C.Medias.Font, 16, "THINOUTLINE")
	self.Description:SetPoint("TOP", self.Title, "TOP", 0, -18)
	self.Description:SetText("Here the commands list...")

	self.Close = CreateFrame("Button", nil, self)
	self.Close:SetSize(24, 24)
	self.Close:SetPoint("TOPRIGHT", self, "TOPRIGHT", -28, -28)
	self.Close:SkinCloseButton()
	self.Close:SetScript("OnClick", function(self) self:GetParent():Hide() end)

	for Index, Value in pairs(L.Help) do
		Texts[Index] = self:CreateFontString(nil, "OVERLAY")
		Texts[Index]:SetFont(C.Medias.Font, 12, "THINOUTLINE")
		Texts[Index]:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 20, 23 * Count)
		Texts[Index]:SetText(Value)
		
		Count = Count + 1
	end
	
	self:Hide()
end

T["Help"] = Help
