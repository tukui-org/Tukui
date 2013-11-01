-- this file is used when we find bug in default UI. We fix in this file.
local T, C, L, G = unpack(select(2, ...))

local function ForceTaintPopupHide()
	if T.patch == "5.4.1" then
		hooksecurefunc("StaticPopup_Show", function(which)
			if (which == "ADDON_ACTION_FORBIDDEN") then
				StaticPopup_Hide(which)
			end
		end)
	end
end

local Fixes = CreateFrame("Frame")
Fixes:RegisterEvent("PLAYER_ENTERING_WORLD")
Fixes:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		ForceTaintPopupHide()
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
end)

G.Misc.BlizzardFixes = Fixes