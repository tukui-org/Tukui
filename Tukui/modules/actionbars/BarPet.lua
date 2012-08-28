local T, C, L, G = unpack(select(2, ...)) 
if not C["actionbar"].enable == true then return end

---------------------------------------------------------------------------
-- setup PetActionBar
---------------------------------------------------------------------------

local bar = TukuiPetBar
local link = TukuiLineToPetActionBarBackground
link:SetAlpha(.8)
	
bar:RegisterEvent("PLAYER_LOGIN")
bar:RegisterEvent("PLAYER_CONTROL_LOST")
bar:RegisterEvent("PLAYER_CONTROL_GAINED")
bar:RegisterEvent("PLAYER_ENTERING_WORLD")
bar:RegisterEvent("PLAYER_FARSIGHT_FOCUS_CHANGED")
bar:RegisterEvent("PET_BAR_UPDATE")
bar:RegisterEvent("PET_BAR_UPDATE_USABLE")
bar:RegisterEvent("PET_BAR_UPDATE_COOLDOWN")
bar:RegisterEvent("PET_BAR_HIDE")
bar:RegisterEvent("UNIT_PET")
bar:RegisterEvent("UNIT_FLAGS")
bar:RegisterEvent("UNIT_AURA")
bar:SetScript("OnEvent", function(self, event, arg1)
	if event == "PLAYER_LOGIN" then	
		PetActionBarFrame:UnregisterEvent("PET_BAR_SHOWGRID")
		PetActionBarFrame:UnregisterEvent("PET_BAR_HIDEGRID")
		PetActionBarFrame.showgrid = 1
		
		local button		
		for i = 1, 10 do
			button = _G["PetActionButton"..i]
			button:ClearAllPoints()
			button:SetParent(TukuiPetBar)

			button:SetSize(T.petbuttonsize, T.petbuttonsize)
			if i == 1 then
				button:SetPoint("TOPLEFT", T.buttonspacing,-T.buttonspacing)
			else
				button:SetPoint("TOP", _G["PetActionButton"..(i - 1)], "BOTTOM", 0, -T.buttonspacing)
			end
			button:Show()
			self:SetAttribute("addchild", button)
			
			G.ActionBars.Pet["Button"..i] = button
		end
		RegisterStateDriver(self, "visibility", "[pet,novehicleui,nobonusbar:5] show; hide")
		hooksecurefunc("PetActionBar_Update", T.PetBarUpdate)
	elseif event == "PET_BAR_UPDATE" or event == "UNIT_PET" and arg1 == "player" 
	or event == "PLAYER_CONTROL_LOST" or event == "PLAYER_CONTROL_GAINED" or event == "PLAYER_FARSIGHT_FOCUS_CHANGED" or event == "UNIT_FLAGS"
	or arg1 == "pet" and (event == "UNIT_AURA") then
		T.PetBarUpdate()
	elseif event == "PET_BAR_UPDATE_COOLDOWN" then
		PetActionBar_UpdateCooldowns()
	else
		T.StylePet()
	end
end)

RegisterStateDriver(bar, "visibility", "[vehicleui][petbattle][overridebar] hide; show")