local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local Durability = CreateFrame("Button", nil, UIParent)
local TimerTracker = TimerTracker
local DurabilityFrame = DurabilityFrame

function Durability:OnShow()
	Durability.Warning:Show()
end

function Durability:OnHide()
	Durability.Warning:Hide()
end

function Durability:Enable()
	self.Warning = self:CreateFontString(nil, "OVERLAY")
	self.Warning:SetFontTemplate(C.Medias.Font, 18)
	self.Warning:SetPoint("TOP", UIParent, "TOP", 0, -8)
	self.Warning:SetText(L.Miscellaneous.Repair)
	self.Warning:SetTextColor(1, 0, 0)
	self.Warning:Hide()

	self:SetAllPoints(self.Warning)
	self:SetScript("OnClick", self.Hide)

	DurabilityFrame:SetAlpha(0)
	DurabilityFrame:Hide()
	DurabilityFrame:HookScript("OnShow", self.OnShow)
	DurabilityFrame:HookScript("OnHide", self.OnHide)
end

Miscellaneous.Durability = Durability
