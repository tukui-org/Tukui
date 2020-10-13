-- Collect garbage while player is AFK. (hooray for free memory!)

local T = select(2, ...):unpack()
local GarbageCollection = CreateFrame("Frame")
local Miscellaneous = T["Miscellaneous"]

function GarbageCollection:OnEvent(event, unit)
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

function GarbageCollection:Enable()
	self:SetScript("OnEvent", self.OnEvent)
end

GarbageCollection:RegisterEvent("PLAYER_FLAGS_CHANGED")
GarbageCollection:RegisterEvent("PLAYER_ENTERING_WORLD")

Miscellaneous.GarbageCollection = GarbageCollection
