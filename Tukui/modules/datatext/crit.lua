local T, C, L, G = unpack(select(2, ...)) 
--------------------------------------------------------------------
-- Crit (Spell or Melee.. or ranged)
--------------------------------------------------------------------

if C["datatext"].crit and C["datatext"].crit > 0 then
	local Stat = CreateFrame("Frame", "TukuiStatCrit")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat.Option = C.datatext.crit
	Stat.Color1 = T.RGBToHex(unpack(C.media.datatextcolor1))
	Stat.Color2 = T.RGBToHex(unpack(C.media.datatextcolor2))
	G.DataText.Crit = Stat

	local Text  = Stat:CreateFontString("TukuiStatCritText", "OVERLAY")
	Text:SetFont(C.media.font, C["datatext"].fontsize)
	T.DataTextPosition(C["datatext"].crit, Text)
	G.DataText.Crit.Text = Text

	local int = 1

	local function Update(self, t)
		int = int - t
		local meleecrit = GetCritChance()
		local spellcrit = GetSpellCritChance(1)
		local rangedcrit = GetRangedCritChance()
		local CritChance
		if spellcrit > meleecrit then
			CritChance = spellcrit
		elseif select(2, UnitClass("Player")) == "HUNTER" then    
			CritChance = rangedcrit
		else
			CritChance = meleecrit
		end
		if int < 0 then
			Text:SetText(Stat.Color2..format("%.2f", CritChance) .. "%|r"..Stat.Color1..L.datatext_playercrit.."|r")
			int = 1
		end     
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end