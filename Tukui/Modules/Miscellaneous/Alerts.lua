local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local Movers = T["Movers"]
local Alerts = CreateFrame("Frame")

function Alerts:UpdateAnchors()
	AlertFrame:ClearAllPoints()
	AlertFrame:SetPoint("CENTER", Alerts.Holder, "Center", 0, 0)
end

function Alerts:AddHooks()
	hooksecurefunc(AlertFrame, "UpdateAnchors", self.UpdateAnchors)
end

function Alerts:AddHolder()
	self.Holder = CreateFrame("Frame", "TukuiAlerts", UIParent)
	self.Holder:SetSize(200, 17)
	self.Holder:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 226)
end

function Alerts:Enable()
	self:AddHolder()
	self:AddHooks()
	
	Movers:RegisterFrame(self.Holder, "Alerts holder")
end

Miscellaneous.Alerts = Alerts