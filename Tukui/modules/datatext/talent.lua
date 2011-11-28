local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

if C.datatext.talent and C.datatext.talent > 0 then
	local Stat = CreateFrame("Frame", "TukuiStatTalent")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat.Option = C.datatext.talent
	Stat.Color1 = T.RGBToHex(unpack(C.media.datatextcolor1))
	Stat.Color2 = T.RGBToHex(unpack(C.media.datatextcolor2))
 
	local Text = Stat:CreateFontString("TukuiStatTalentText", "OVERLAY")
	Text:SetFont(C.media.font, C["datatext"].fontsize)
	T.PP(C.datatext.talent, Text)
 
	local function Update(self)
		if not GetPrimaryTalentTree() then
			Text:SetText(L.datatext_notalents) 
		else
			local majorTree = GetPrimaryTalentTree()
			local tree1num = select(5,GetTalentTabInfo(1))
			local tree2num = select(5,GetTalentTabInfo(2))
			local tree3num = select(5,GetTalentTabInfo(3))
			local tree = select(2,GetTalentTabInfo(majorTree)) or ""
			Text:SetText(Stat.Color1..tree..":|r "..Stat.Color2..tree1num.."/"..tree2num.."/"..tree3num.."|r")
		end
		self:SetAllPoints(Text)
	end
 
	Stat:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	Stat:RegisterEvent("CONFIRM_TALENT_WIPE")
	Stat:RegisterEvent("PLAYER_TALENT_UPDATE")
	Stat:SetScript("OnEvent", Update)
	Stat:SetScript("OnEnter", function(self)
		if not InCombatLockdown() then
			local anchor, panel, xoff, yoff = T.DataTextTooltipAnchor(Text)	
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()
			
			local c = GetActiveTalentGroup(false,false)
			local group1tree1 = select(5,GetTalentTabInfo(1,false,false,1))
			local group1tree2 = select(5,GetTalentTabInfo(2,false,false,1))
			local group1tree3 = select(5,GetTalentTabInfo(3,false,false,1))
			local majorTree1 = GetPrimaryTalentTree(false,false,1)
			local hs = (GetNumTalentGroups() == 2 and GetPrimaryTalentTree(false,false,2))
			local group2tree1 = hs and select(5,GetTalentTabInfo(1,false,false,2))
			local group2tree2 = hs and select(5,GetTalentTabInfo(2,false,false,2))
			local group2tree3 = hs and select(5,GetTalentTabInfo(3,false,false,2))
			local majorTree2 = 0
			if hs then
				majorTree2 = GetPrimaryTalentTree(false,false,2)
			end
			
			local green = "|cff00ff00("..ACTIVE_PETS..")"
			local red = "|cffff0000 "
			if majorTree1 and group1tree1 and group1tree2 and group1tree3 then
				GameTooltip:AddDoubleLine("|cffffff00"..COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATESPEC1 ..":|r " .. select(2,GetTalentTabInfo(majorTree1)).." ("..group1tree1.."/"..group1tree2.."/"..group1tree3..")",(c == 1 and green or red) .. "|r",1,1,1)
			end
			if majorTree2 and group2tree1 and group2tree2 and group2tree3 then
				GameTooltip:AddDoubleLine("|cffffff00"..COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATESPEC2 ..":|r ".. select(2,GetTalentTabInfo(majorTree2)).." ("..group2tree1.."/"..group2tree2.."/"..group2tree3..")",(c == 2 and green or red) .. "|r",1,1,1)
			end

			GameTooltip:Show()
		end
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Stat:SetScript("OnMouseDown", function()
		c = GetActiveTalentGroup(false,false)
		SetActiveTalentGroup(c == 1 and 2 or 1)
	end)
end