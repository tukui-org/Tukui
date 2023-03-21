local T, C, L = unpack((select(2, ...)))

local Miscellaneous = T["Miscellaneous"]
local Tutorials = CreateFrame("Frame")

function Tutorials:OnEvent(event, addon)
	if addon ~= "Blizzard_NewPlayerExperience" then
		return
	end

	SetCVar("showTutorials", 0)
	NewPlayerExperience:Shutdown()
end

function Tutorials:Enable()
	self:RegisterEvent("ADDON_LOADED")
	self:SetScript("OnEvent", self.OnEvent)
end

Miscellaneous.Tutorials = Tutorials