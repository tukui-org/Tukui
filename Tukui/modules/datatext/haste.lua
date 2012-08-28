local T, C, L, G = unpack(select(2, ...)) 
--------------------------------------------------------------------
-- player haste
--------------------------------------------------------------------

if C["datatext"].haste and C["datatext"].haste > 0 then
	local Stat = CreateFrame("Frame", "TukuiStatHaste")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat.Option = C.datatext.haste
	Stat.Color1 = T.RGBToHex(unpack(C.media.datatextcolor1))
	Stat.Color2 = T.RGBToHex(unpack(C.media.datatextcolor2))
	G.DataText.Haste = Stat

	local Text  = Stat:CreateFontString("TukuiStatHasteText", "OVERLAY")
	Text:SetFont(C.media.font, C["datatext"].fontsize)
	T.DataTextPosition(C["datatext"].haste, Text)
	G.DataText.Haste.Text = Text

	local int = 1

	local function Update(self, t)
		local spellhaste = GetCombatRating(20)
		local rangedhaste = GetCombatRating(19)
		local attackhaste = GetCombatRating(18)
		
		if attackhaste > spellhaste and select(2, UnitClass("Player")) ~= "HUNTER" then
			haste = attackhaste
		elseif select(2, UnitClass("Player")) == "HUNTER" then
			haste = rangedhaste
		else
			haste = spellhaste
		end
		
		int = int - t
		if int < 0 then
			Text:SetText(Stat.Color2..haste.."|r "..Stat.Color1..L.datatext_playerhaste.."|r")
			int = 1
		end     
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end