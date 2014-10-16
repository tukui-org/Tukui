-- Collect garbage while player is AFK. (hooray for free memory!)

local T = select(2, ...):unpack()
local CollectGarbage = CreateFrame("Frame")
local Miscellaneous = T["Miscellaneous"]

function CollectGarbage:OnEvent(event, unit)
	if (event == "PLAYER_ENTERING_WORLD") then
		collectgarbage("collect")

		-- Just verifying that this clears the memory out :)
		local Memory = T["DataTexts"]:GetDataText("Memory")
		
		if (Memory and Memory.Enabled) then
			Memory:Update(10)
		end
		
		self:UnregisterEvent(event)
	else
		if (unit ~= "player") then
			return
		end
		
		if UnitIsAFK(unit) then
			collectgarbage("collect")
		end
	end
end

function CollectGarbage:Enable()
	self:SetScript("OnEvent", self.OnEvent)
end

CollectGarbage:RegisterEvent("PLAYER_FLAGS_CHANGED")
CollectGarbage:RegisterEvent("PLAYER_ENTERING_WORLD")

Miscellaneous.CollectGarbage = CollectGarbage