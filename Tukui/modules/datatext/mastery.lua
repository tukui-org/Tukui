local T, C, L, G = unpack(select(2, ...)) 
--------------------------------------------------------------------
-- Mastery
----------------------------------------------------------------

if not C["datatext"].mastery == nil or C["datatext"].mastery > 0 then
	local Stat = CreateFrame("Frame", "TukuiStatMastery")
	Stat.Option = C.datatext.mastery
	Stat.Color1 = T.RGBToHex(unpack(C.media.datatextcolor1))
	Stat.Color2 = T.RGBToHex(unpack(C.media.datatextcolor2))
	G.DataText.Mastery = Stat

	local Text  = Stat:CreateFontString("TukuiStatMasteryText", "OVERLAY")
	Text:SetFont(C.media.font, C["datatext"].fontsize)
	T.DataTextPosition(C["datatext"].mastery, Text)
	G.DataText.Mastery.Text = Text

	local int = 1
	
	local function Update(self, t)
		int = int - t
		if int < 0 then
			Text:SetText(Stat.Color1..STAT_MASTERY..":|r "..Stat.Color2..GetCombatRating(26).."|r")
			int = 1
		end
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end