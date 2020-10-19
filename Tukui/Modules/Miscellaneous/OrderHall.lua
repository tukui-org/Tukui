local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local OrderHall = CreateFrame("Frame")

function OrderHall:OnEvent(event, addon)
	if addon ~= "Blizzard_OrderHallUI" then
		return
	end

	local Frame = OrderHallCommandBar

	Frame:Kill()

	self:UnregisterAllEvents()
end

function OrderHall:Enable()
	self:RegisterEvent("ADDON_LOADED")
	self:SetScript("OnEvent", self.OnEvent)
end

Miscellaneous.OrderHall = OrderHall

