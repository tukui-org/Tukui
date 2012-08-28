local T, C, L, G = unpack(select(2, ...))

if not C["actionbar"].enable == true then
	TukuiPetBar:Hide()
	TukuiBar5:Hide()
	TukuiBar6:Hide()
	TukuiBar7:Hide()
	TukuiBar5ButtonTop:Hide()
	TukuiBar5ButtonBottom:Hide()
	return
end

---------------------------------------------------------------------------
-- Manage all others stuff for actionbars
---------------------------------------------------------------------------

T.CreatePopup["TUKUI_FIX_AB"] = {
	question = L.popup_fix_ab,
	answer1 = ACCEPT,
	answer2 = CANCEL,
	function1 = ReloadUI,
}

local TukuiOnLogon = CreateFrame("Frame")
TukuiOnLogon:RegisterEvent("PLAYER_ENTERING_WORLD")
TukuiOnLogon:SetScript("OnEvent", function(self, event)	
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	
	-- look if our 4 bars are enabled because some people disable them with others UI 
	-- even if Tukui have been already installed and they don't know how to restore them.
	local installed = TukuiDataPerChar.install
	if installed then
		local b1, b2, b3, b4 = GetActionBarToggles()
		if (not b1 or not b2 or not b3 or not b4) then
			SetActionBarToggles(1, 1, 1, 1)
			T.ShowPopup("TUKUI_FIX_AB")
		end
	end
end)
G.ActionBars.EnterWorld = TukuiOnLogon