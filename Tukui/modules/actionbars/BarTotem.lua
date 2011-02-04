local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
if C["actionbar"].enable ~= true then return end

-- we just use default totem bar for shaman
-- we parent it to our shapeshift bar.
-- This is approx the same script as it was in WOTLK Tukui version.

if T.myclass == "SHAMAN" then
	if MultiCastActionBarFrame then
		MultiCastActionBarFrame:SetScript("OnUpdate", nil)
		MultiCastActionBarFrame:SetScript("OnShow", nil)
		MultiCastActionBarFrame:SetScript("OnHide", nil)
		MultiCastActionBarFrame:SetParent(TukuiShiftBar)
		MultiCastActionBarFrame:ClearAllPoints()
		MultiCastActionBarFrame:Point("BOTTOMLEFT", TukuiShiftBar, -3, 23)
 
		hooksecurefunc("MultiCastActionButton_Update",function(actionbutton) if not InCombatLockdown() then actionbutton:SetAllPoints(actionbutton.slotButton) end end)
 
		MultiCastActionBarFrame.SetParent = T.dummy
		MultiCastActionBarFrame.SetPoint = T.dummy
		MultiCastRecallSpellButton.SetPoint = T.dummy
	end
end