local T, C, L = select(2, ...):unpack()

----------------------------------------------------------------
-- This script will adjust resolution for optimal graphic
----------------------------------------------------------------

local Popups = T["Popups"]
local RequireRestart = false

Popups.Popup["CLIENT_RESTART"] = {
	Question = L.Others.ResolutionChanged,
	Answer1 = ACCEPT,
	Answer2 = CANCEL,
	Function1 = function(self)
		ForceQuit()
	end,
	Function2 = function(self)
		RequireRestart = false
	end,
}

-- Optimize graphic after we enter world
local Graphic = CreateFrame("Frame")
Graphic:RegisterEvent("PLAYER_ENTERING_WORLD")
Graphic:SetScript("OnEvent", function(self, event)
	if (event == "DISPLAY_SIZE_CHANGED") then
		if not RequireRestart then
			Popups.ShowPopup("CLIENT_RESTART")
		end
			
		RequireRestart = true
	else
		local UseUIScale = GetCVar("useUiScale")

		if (UseUIScale ~= "1") then
			SetCVar("useUiScale", 1)
		end

		if (format("%.2f", GetCVar("uiScale")) ~= format("%.2f", C.General.UIScale)) then
			SetCVar("uiScale", C.General.UIScale)
		end

		-- Allow 4K and WQHD Resolution to have an UIScale lower than 0.64, which is
		-- the lowest value of UIParent scale by default
		if (C.General.UIScale < 0.64) then
			UIParent:SetScale(C.General.UIScale)
		end

		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		self:RegisterEvent("DISPLAY_SIZE_CHANGED")
	end
end)
