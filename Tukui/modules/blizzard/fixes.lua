-- this file is used when we find bug in default UI. We fix in this file.
local T, C, L, G = unpack(select(2, ...))

local function LoadTalentFix()
	T.CreatePopup["TUKUI_TALENT_FIX"] = {
		question = L.UI_Talent_Change_Bug,
		answer1 = ACCEPT,
		answer2 = CANCEL,
		function1 = ReloadUI,
	}

	local function TalentFix()
		if INSPECTED_UNIT then
			if InspectFrame and InspectFrame:IsShown() then HideUIPanel(InspectFrame) end
			HideUIPanel(PlayerTalentFrame)
			for i = 1, 4 do
				local p = _G["StaticPopup"..i]
				p:Hide()
			end
			T.ShowPopup("TUKUI_TALENT_FIX")
		end
	end

	for i = 1, MAX_NUM_TALENT_TIERS do
		local row = _G["PlayerTalentFrameTalentsTalentRow"..i]

		for j = 1, NUM_TALENT_COLUMNS do
			local bu = _G["PlayerTalentFrameTalentsTalentRow"..i.."Talent"..j]

			bu:HookScript("OnClick", TalentFix)
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_TalentUI" then
		LoadTalentFix()
	end
end)