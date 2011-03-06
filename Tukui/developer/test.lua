local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

local beta = CreateFrame("Frame")
beta:RegisterEvent("PLAYER_ENTERING_WORLD")
beta:SetScript("OnEvent", function(self, event)
	print("|CFFFF0000THIS IS A BETA VERSION OF TUKUI FOR 4.1.0 PTR ONLY|r")
	SetCVar("scriptErrors", 1) -- force it for development
end)