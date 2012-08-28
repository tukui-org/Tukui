local T, C, L, G = unpack(select(2, ...)) 

-- NOTE : I seriously dont know what is avoidance and how the fuck it work in MoP
-- If someone can look and update this datatext if value in game are not ok, it will be awesome!

--------------------------------------------------------------------
-- Player Avoidance
--------------------------------------------------------------------
if C["datatext"].avd and C["datatext"].avd > 0 then
	local dodge, parry, block, avoidance, targetlv, playerlv, basemisschance, leveldifference
	local Stat = CreateFrame("Frame", "TukuiStatAvoidance")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat.Option = C.datatext.avd
	Stat.Color1 = T.RGBToHex(unpack(C.media.datatextcolor1))
	Stat.Color2 = T.RGBToHex(unpack(C.media.datatextcolor2))
	G.DataText.Avoidance = Stat

	local Text  = Stat:CreateFontString("TukuiStatAvoidanceText", "OVERLAY")
	Text:SetFont(C.media.font, C["datatext"].fontsize)
	T.DataTextPosition(C["datatext"].avd, Text)
	G.DataText.Avoidance.Text = Text
	
	local targetlv, playerlv

	local function Update(self)
		local format = string.format
		targetlv, playerlv = UnitLevel("target"), UnitLevel("player")
		local basemisschance, leveldifference, avoidance
		
		if targetlv == -1 then
			basemisschance = (5 - (3*.2))  --Boss Value
			leveldifference = 3
		elseif targetlv > playerlv then
			basemisschance = (5 - ((targetlv - playerlv)*.2)) --Mobs above player level
			leveldifference = (targetlv - playerlv)
		elseif targetlv < playerlv and targetlv > 0 then
			basemisschance = (5 + ((playerlv - targetlv)*.2)) --Mobs below player level
			leveldifference = (targetlv - playerlv)
		else
			basemisschance = 5 --Sets miss chance of attacker level if no target exists, lv80=5, 81=4.2, 82=3.4, 83=2.6
			leveldifference = 0
		end
		
		if T.myrace == "NightElf" then
			basemisschance = basemisschance + 2
		end

		if leveldifference >= 0 then
			dodge = (GetDodgeChance()-leveldifference*.2)
			parry = (GetParryChance()-leveldifference*.2)
			block = (GetBlockChance()-leveldifference*.2)
			avoidance = (dodge+parry+block)
			Text:SetText(Stat.Color1..L.datatext_playeravd.."|r"..Stat.Color2..format("%.2f", avoidance).."|r")
		else
			dodge = (GetDodgeChance()+abs(leveldifference*.2))
			parry = (GetParryChance()+abs(leveldifference*.2))
			block = (GetBlockChance()+abs(leveldifference*.2))
			avoidance = (dodge+parry+block)
			Text:SetText(Stat.Color1..L.datatext_playeravd.."|r"..Stat.Color2..format("%.2f", avoidance).."|r")
		end

		--Setup Avoidance Tooltip
		self:SetAllPoints(Text)
	end


	Stat:RegisterEvent("UNIT_AURA")
	Stat:RegisterEvent("UNIT_INVENTORY_CHANGED")
	Stat:RegisterEvent("PLAYER_TARGET_CHANGED")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnEvent", Update)
	Stat:SetScript("OnEnter", function(self)
		if not InCombatLockdown() then
			local anchor, yoff = T.DataTextTooltipAnchor(Text)
			GameTooltip:SetOwner(self, anchor, 0, yoff)
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, T.mult)
			GameTooltip:ClearLines()
			if targetlv > 1 then
				GameTooltip:AddDoubleLine(L.datatext_avoidancebreakdown.." ("..L.datatext_lvl.." "..targetlv..")")
			elseif targetlv == -1 then
				GameTooltip:AddDoubleLine(L.datatext_avoidancebreakdown.." ("..L.datatext_boss..")")
			else
				GameTooltip:AddDoubleLine(L.datatext_avoidancebreakdown.." ("..L.datatext_lvl.." "..targetlv..")")
			end
			GameTooltip:AddDoubleLine(L.datatext_dodge,format("%.2f",dodge) .. "%",1,1,1,  1,1,1)
			GameTooltip:AddDoubleLine(L.datatext_parry,format("%.2f",parry) .. "%",1,1,1,  1,1,1)
			GameTooltip:AddDoubleLine(L.datatext_block,format("%.2f",block) .. "%",1,1,1,  1,1,1)
			GameTooltip:Show()
		end
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
end