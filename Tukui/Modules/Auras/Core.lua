local T, C, L = select(2, ...):unpack()

local TukuiAuras = CreateFrame("Frame")

function TukuiAuras:Enable()
	self:DisableBlizzardAuras()
	self:CreateHeaders()
	
	local EnterWorld = CreateFrame("Frame")
	EnterWorld:RegisterEvent("PLAYER_ENTERING_WORLD")
	EnterWorld:SetScript("OnEvent", function(self, event)
		TukuiAuras:OnEnterWorld()
	end)
end

T["Auras"] = TukuiAuras