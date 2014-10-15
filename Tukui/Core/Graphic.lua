local T, C = select(2, ...):unpack()

----------------------------------------------------------------
-- This script will adjust resolution for optimal graphic
----------------------------------------------------------------

-- ReloadUI need to be done even if we keep aspect ratio
local function NeedReloadUI()
	local ResolutionDropDown = Display_ResolutionDropDown
	local X, Y = ResolutionDropDown:getValues()
	local OldRatio = T.Round(T.ScreenWidth / T.ScreenHeight, 2)
	local NewRatio = T.Round(X / Y, 2)
	local OldReso = T.Resolution
	local NewReso = X.."x"..Y

	if (OldRatio == NewRatio) and (OldReso ~= NewReso) then
		ReloadUI()
	end
end

-- Optimize graphic after we enter world
local Graphic = CreateFrame("Frame")
Graphic:RegisterEvent("PLAYER_ENTERING_WORLD")
Graphic:SetScript("OnEvent", function(self, event)
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

	VideoOptionsFrameOkay:HookScript("OnClick", NeedReloadUI)
	VideoOptionsFrameApply:HookScript("OnClick", NeedReloadUI)
	
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)