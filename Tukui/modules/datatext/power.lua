local T, C, L, G = unpack(select(2, ...)) 

--------------------------------------------------------------------
-- player power (attackpower or power depending on what you have more of)
--------------------------------------------------------------------

if C["datatext"].power and C["datatext"].power > 0 then
	local Stat = CreateFrame("Frame", "TukuiStatPower")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat.Option = C.datatext.power
	Stat.Color1 = T.RGBToHex(unpack(C.media.datatextcolor1))
	Stat.Color2 = T.RGBToHex(unpack(C.media.datatextcolor2))
	G.DataText.Power = Stat

	local Text  = Stat:CreateFontString("TukuiStatPowerText", "OVERLAY")
	Text:SetFont(C.media.font, C["datatext"].fontsize)
	T.DataTextPosition(C["datatext"].power, Text)
	G.DataText.Power.Text = Text

	local int = 1

	local function Update(self, t)
		int = int - t
		local base, posBuff, negBuff = UnitAttackPower("player")
		local effective = base + posBuff + negBuff
		local Rbase, RposBuff, RnegBuff = UnitRangedAttackPower("player")
		local Reffective = Rbase + RposBuff + RnegBuff


		healpwr = GetSpellBonusHealing()

		Rattackpwr = Reffective
		spellpwr2 = GetSpellBonusDamage(7)
		attackpwr = effective

		if healpwr > spellpwr2 then
			spellpwr = healpwr
		else
			spellpwr = spellpwr2
		end

		if attackpwr > spellpwr and select(2, UnitClass("Player")) ~= "HUNTER" then
			pwr = attackpwr
			tp_pwr = L.datatext_playerap
		elseif select(2, UnitClass("Player")) == "HUNTER" then
			pwr = Reffective
			tp_pwr = L.datatext_playerap
		else
			pwr = spellpwr
			tp_pwr = L.datatext_playersp
		end
		if int < 0 then
			Text:SetText(Stat.Color2..pwr.." |r".. Stat.Color1..tp_pwr.."|r")      
			int = 1
		end
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end