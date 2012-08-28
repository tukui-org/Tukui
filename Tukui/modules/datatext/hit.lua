local T, C, L, G = unpack(select(2, ...)) 

--------------------------------------------------------------------
-- Player Hit
--------------------------------------------------------------------

-- Hit Rating
if not C["datatext"].hit == nil or C["datatext"].hit > 0 then
	local Stat = CreateFrame("Frame", "TukuiStatHit")
	Stat.Option = C.datatext.hit
	Stat.Color1 = T.RGBToHex(unpack(C.media.datatextcolor1))
	Stat.Color2 = T.RGBToHex(unpack(C.media.datatextcolor2))
	G.DataText.Hit = Stat

	local Text  = Stat:CreateFontString("TukuiStatHitText", "OVERLAY")
	Text:SetFont(C.media.font, C["datatext"].fontsize)
	T.DataTextPosition(C["datatext"].hit, Text)
	G.DataText.Hit.Text = Text

	local int = 1

	local function Update(self, t)		
		int = int - t
		if int < 0 then
			local base, posBuff, negBuff = UnitAttackPower("player")
			local effective = base + posBuff + negBuff
			local Rbase, RposBuff, RnegBuff = UnitRangedAttackPower("player")
			local Reffective = Rbase + RposBuff + RnegBuff

			local Rattackpwr = Reffective
			local spellpwr = GetSpellBonusDamage(7)
			local attackpwr = effective
			
			local cac = GetHitModifier() or 0
			local cast = GetSpellHitModifier() or 0
			
			if attackpwr > spellpwr and select(2, UnitClass("Player")) ~= "HUNTER" then
				Text:SetText(format(Stat.Color2.."%.2f%%|r ", GetCombatRatingBonus(6)+cac)..Stat.Color1..HIT.."|r")
			elseif select(2, UnitClass("Player")) == "HUNTER" then
				Text:SetText(format(Stat.Color2.."%.2f%%|r ", GetCombatRatingBonus(7)+cac)..Stat.Color1..HIT.."|r")
			else
				Text:SetText(format(Stat.Color2.."%.2f%%|r ", GetCombatRatingBonus(8)+cast)..Stat.Color1..HIT.."|r")
			end
			
			int = 1
		end
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end