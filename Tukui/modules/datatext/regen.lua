local T, C, L, G = unpack(select(2, ...))
if not C["datatext"].regen or C["datatext"].regen == 0 then return end

local Stat = CreateFrame("Frame", "TukuiStatRegen")
Stat:SetFrameStrata("BACKGROUND")
Stat:SetFrameLevel(3)
Stat.Option = C.datatext.regen
Stat.Color1 = T.RGBToHex(unpack(C.media.datatextcolor1))
Stat.Color2 = T.RGBToHex(unpack(C.media.datatextcolor2))
G.DataText.Regen = Stat

local Text = Stat:CreateFontString("TukuiStatRegenText", "OVERLAY")
Text:SetFont(C["media"].font, C["datatext"].fontsize)
Text:SetShadowColor(0, 0, 0)
Text:SetShadowOffset(1.25, -1.25)
T.DataTextPosition(C["datatext"].regen, Text)
G.DataText.Regen.Text = Text

Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
Stat:RegisterEvent("PLAYER_REGEN_DISABLED")
Stat:RegisterEvent("PLAYER_REGEN_ENABLED")
Stat:RegisterEvent("UNIT_STATS")
Stat:RegisterEvent("UNIT_AURA")
Stat:SetScript("OnEvent", function(self)
	local regen
	local base, casting = GetManaRegen()

	if InCombatLockdown() then
		regen = floor(casting*5)
	else
		regen = floor(base*5)		
	end
	
	Text:SetText(Stat.Color2..regen.." "..MANA_REGEN_ABBR.."|r")
end)