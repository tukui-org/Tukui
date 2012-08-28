local T, C, L, G = unpack(select(2, ...)) 
--------------------------------------------------------------------
-- player Armor
--------------------------------------------------------------------

if C["datatext"].armor and C["datatext"].armor > 0 then
	local effectiveArmor
	
	local Stat = CreateFrame("Frame", "TukuiStatArmor")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat.Option = C.datatext.armor
	Stat.Color1 = T.RGBToHex(unpack(C.media.datatextcolor1))
	Stat.Color2 = T.RGBToHex(unpack(C.media.datatextcolor2))
	G.DataText.Armor = Stat

	local Text  = Stat:CreateFontString("TukuiStatArmorText", "OVERLAY")
	Text:SetFont(C.media.font, C["datatext"].fontsize)
	T.DataTextPosition(C["datatext"].armor, Text)
	G.DataText.Armor.Text = Text

	local function Update(self)
		effectiveArmor = select(2, UnitArmor("player"))
		Text:SetText(Stat.Color2..(effectiveArmor).."|r "..Stat.Color1..L.datatext_armor.."|r")
		--Setup Armor Tooltip
		self:SetAllPoints(Text)
	end

	Stat:RegisterEvent("UNIT_INVENTORY_CHANGED")
	Stat:RegisterEvent("UNIT_AURA")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnMouseDown", function() ToggleCharacter("PaperDollFrame") end)
	Stat:SetScript("OnEvent", Update)
	Stat:SetScript("OnEnter", function(self)
		if not InCombatLockdown() then
			local anchor, panel, xoff, yoff = T.DataTextTooltipAnchor(Text)	
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(L.datatext_mitigation)
			local lv = 83
			local mitigation = (effectiveArmor/(effectiveArmor+(467.5*lv-22167.5)))
			for i = 1, 4 do
				local format = string.format
				if mitigation > .75 then
					mitigation = .75
				end
				GameTooltip:AddDoubleLine(lv,format("%.2f", mitigation*100) .. "%",1,1,1)
				lv = lv - 1
			end
			if UnitLevel("target") > 0 and UnitLevel("target") < UnitLevel("player") then
				if mitigation > .75 then
					mitigation = .75
				end
				GameTooltip:AddDoubleLine(UnitLevel("target"),format("%.2f", mitigation*100) .. "%",1,1,1)
			end
			GameTooltip:Show()
		end
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
end