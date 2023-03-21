local T, C, L = unpack((select(2, ...)))

local Miscellaneous = T["Miscellaneous"]
local Movers = T["Movers"]
local VehicleIndicator = CreateFrame("Frame")

function VehicleIndicator:SetPosition()
	local Indicator = VehicleSeatIndicator
	local Holder = TukuiVehicleIndicator
	
	Indicator:ClearAllPoints()
	Indicator:SetAllPoints(Holder)
end

function VehicleIndicator:Enable()
	local Indicator = VehicleSeatIndicator
	local Holder = CreateFrame("Frame", "TukuiVehicleIndicator", UIParent)
	
	Holder:SetSize(Indicator:GetSize())
	Holder:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 300)	

	Indicator:SetParent(Holder)
	Indicator:ClearAllPoints()
	Indicator:SetPoint("CENTER", Holder)
	Indicator:SetFrameStrata("BACKGROUND")
	
	hooksecurefunc(VehicleSeatIndicator, "SetPoint", VehicleIndicator.SetPosition)

	Movers:RegisterFrame(Holder, "Vehicle Indicator")
end

Miscellaneous.VehicleIndicator = VehicleIndicator