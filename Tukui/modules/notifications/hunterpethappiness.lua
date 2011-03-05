local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
if T.myclass ~= "HUNTER" then return end
 
local PetHappiness = CreateFrame("Frame")
PetHappiness.happiness = GetPetHappiness()

local OnEvent = function(self, event, unit, power)
	local happiness = GetPetHappiness()
	local hunterPet = select(2, HasPetUI())
	if event == "UNIT_POWER" and unit == "pet" and power == "HAPPINESS" and happiness and hunterPet and self.happiness ~= happiness then
		-- happiness has changed
		self.happiness = happiness
		if happiness == 1 then
			DEFAULT_CHAT_FRAME:AddMessage(L.hunter_unhappy, 1, 0, 0)
		elseif happiness == 2 then
			DEFAULT_CHAT_FRAME:AddMessage(L.hunter_content, 1, 1, 0)
		elseif happiness == 3 then
			DEFAULT_CHAT_FRAME:AddMessage(L.hunter_happy, 0, 1, 0)
		end
	elseif event == "UNIT_PET" then
		self.happiness = happiness
		if happiness == 1 then
			DEFAULT_CHAT_FRAME:AddMessage(L.hunter_unhappy, 1, 0, 0)
		end
	end
end
PetHappiness:RegisterEvent("UNIT_POWER")
PetHappiness:RegisterEvent("UNIT_PET")
PetHappiness:SetScript("OnEvent", OnEvent)
