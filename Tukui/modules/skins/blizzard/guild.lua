local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	GuildFrame:StripTextures(true)
	GuildFrame:SetTemplate("Default")
	GuildFrame:CreateShadow("Default")
	GuildLevelFrame:Kill()
	
	T.SkinCloseButton(GuildMemberDetailCloseButton)
	T.SkinCloseButton(GuildFrameCloseButton)
	
	local striptextures = {
		"GuildNewPerksFrame",
		"GuildFrameInset",
		"GuildFrameBottomInset",
		"GuildAllPerksFrame",
		"GuildMemberDetailFrame",
		"GuildMemberNoteBackground",
		"GuildInfoFrameInfo",
		"GuildLogContainer",
		"GuildLogFrame",
		"GuildRewardsFrame",
		"GuildMemberOfficerNoteBackground",
		"GuildTextEditContainer",
		"GuildTextEditFrame",
		"GuildRecruitmentRolesFrame",
		"GuildRecruitmentAvailabilityFrame",
		"GuildRecruitmentInterestFrame",
		"GuildRecruitmentLevelFrame",
		"GuildRecruitmentCommentFrame",
		"GuildRecruitmentCommentInputFrame",
		"GuildInfoFrameApplicantsContainer",
		"GuildInfoFrameApplicants",
		"GuildNewsBossModel",
		"GuildNewsBossModelTextFrame",
		"GuildInfoFrameApplicantsContainerScrollBar",
	}
	GuildRewardsFrameVisitText:ClearAllPoints()
	GuildRewardsFrameVisitText:SetPoint("TOP", GuildRewardsFrame, "TOP", 0, 30)
	for _, frame in pairs(striptextures) do
		_G[frame]:StripTextures()
	end
	
	GuildNewsBossModel:CreateBackdrop("Default")
	GuildNewsBossModelTextFrame:CreateBackdrop("Default")
	GuildNewsBossModelTextFrame.backdrop:Point("TOPLEFT", GuildNewsBossModel.backdrop, "BOTTOMLEFT", 0, -1)
	GuildNewsBossModel:Point("TOPLEFT", GuildFrame, "TOPRIGHT", 4, -43)
	
	local buttons = {
		"GuildPerksToggleButton",
		"GuildMemberRemoveButton",
		"GuildMemberGroupInviteButton",
		"GuildAddMemberButton",
		"GuildViewLogButton",
		"GuildControlButton",
		"GuildRecruitmentListGuildButton",
		"GuildTextEditFrameAcceptButton",
		"GuildRecruitmentInviteButton",
		"GuildRecruitmentMessageButton",
		"GuildRecruitmentDeclineButton",
	}
	
	for i, button in pairs(buttons) do
		if i == 1 then
			T.SkinButton(_G[button])
		else
			T.SkinButton(_G[button], true)
		end
	end
	
	local checkbuttons = {
		"Quest", 
		"Dungeon",
		"Raid",
		"PvP",
		"RP",
		"Weekdays",
		"Weekends",
		"LevelAny",
		"LevelMax",
	}
	
	for _, frame in pairs(checkbuttons) do
		T.SkinCheckBox(_G["GuildRecruitment"..frame.."Button"])
	end
	
	T.SkinCheckBox(GuildRecruitmentTankButton:GetChildren())
	T.SkinCheckBox(GuildRecruitmentHealerButton:GetChildren())
	T.SkinCheckBox(GuildRecruitmentDamagerButton:GetChildren())
	
	for i=1,5 do
		T.SkinTab(_G["GuildFrameTab"..i])
	end
	GuildXPFrame:ClearAllPoints()
	GuildXPFrame:Point("TOP", GuildFrame, "TOP", 0, -40)
	
	T.SkinScrollBar(GuildPerksContainerScrollBar)
	
	GuildFactionBar:StripTextures()
	GuildFactionBar.progress:SetTexture(C["media"].normTex)
	GuildFactionBar:CreateBackdrop("Default")
	GuildFactionBar.backdrop:Point("TOPLEFT", GuildFactionBar.progress, "TOPLEFT", -2, 2)
	GuildFactionBar.backdrop:Point("BOTTOMRIGHT", GuildFactionBar, "BOTTOMRIGHT", -2, 0)
	
	GuildXPBarLeft:Kill()
	GuildXPBarRight:Kill()
	GuildXPBarMiddle:Kill()
	GuildXPBarBG:Kill()
	GuildXPBarShadow:Kill()
	GuildXPBarCap:Kill()
	GuildXPBar.progress:SetTexture(C["media"].normTex)
	GuildXPBar:CreateBackdrop("Default")
	GuildXPBar.backdrop:Point("TOPLEFT", GuildXPBar.progress, "TOPLEFT", -2, 2)
	GuildXPBar.backdrop:Point("BOTTOMRIGHT", GuildXPBar, "BOTTOMRIGHT", -2, 4)
	
	GuildLatestPerkButton:StripTextures()
	GuildLatestPerkButtonIconTexture:SetTexCoord(.08, .92, .08, .92)
	GuildLatestPerkButtonIconTexture:ClearAllPoints()
	GuildLatestPerkButtonIconTexture:Point("TOPLEFT", 2, -2)
	GuildLatestPerkButton:CreateBackdrop("Default")
	GuildLatestPerkButton.backdrop:Point("TOPLEFT", GuildLatestPerkButtonIconTexture, "TOPLEFT", -2, 2)
	GuildLatestPerkButton.backdrop:Point("BOTTOMRIGHT", GuildLatestPerkButtonIconTexture, "BOTTOMRIGHT", 2, -2)
	
	GuildNextPerkButton:StripTextures()
	GuildNextPerkButtonIconTexture:SetTexCoord(.08, .92, .08, .92)
	GuildNextPerkButtonIconTexture:ClearAllPoints()
	GuildNextPerkButtonIconTexture:Point("TOPLEFT", 2, -2)
	GuildNextPerkButton:CreateBackdrop("Default")
	GuildNextPerkButton.backdrop:Point("TOPLEFT", GuildNextPerkButtonIconTexture, "TOPLEFT", -2, 2)
	GuildNextPerkButton.backdrop:Point("BOTTOMRIGHT", GuildNextPerkButtonIconTexture, "BOTTOMRIGHT", 2, -2)
	
	--Guild Perk buttons list
	for i=1, 8 do
		local button = _G["GuildPerksContainerButton"..i]
		button:StripTextures()
		
		if button.icon then
			button.icon:SetTexCoord(.08, .92, .08, .92)
			button.icon:ClearAllPoints()
			button.icon:Point("TOPLEFT", 2, -2)
			button:CreateBackdrop("Default")
			button.backdrop:Point("TOPLEFT", button.icon, "TOPLEFT", -2, 2)
			button.backdrop:Point("BOTTOMRIGHT", button.icon, "BOTTOMRIGHT", 2, -2)
			button.icon:SetParent(button.backdrop)
		end
	end
	
	--Roster
	T.SkinScrollBar(GuildRosterContainerScrollBar)
	T.SkinCheckBox(GuildRosterShowOfflineButton)
	
	
	for i=1, 4 do
		_G["GuildRosterColumnButton"..i]:StripTextures(true)
	end
	
	T.SkinDropDownBox(GuildRosterViewDropdown, 200)
	
	for i=1, 14 do
		T.SkinButton(_G["GuildRosterContainerButton"..i.."HeaderButton"], true)
	end
	
	--Detail Frame
	GuildMemberDetailFrame:SetTemplate("Default")
	GuildMemberNoteBackground:SetTemplate("Default")
	GuildMemberOfficerNoteBackground:SetTemplate("Default")
	GuildMemberRankDropdown:SetFrameLevel(GuildMemberRankDropdown:GetFrameLevel() + 5)
	T.SkinDropDownBox(GuildMemberRankDropdown, 175)

	--News
	GuildNewsFrame:StripTextures()
	for i=1, 17 do
		_G["GuildNewsContainerButton"..i].header:Kill()
	end
	
	GuildNewsFiltersFrame:StripTextures()
	GuildNewsFiltersFrame:SetTemplate("Default")
	T.SkinCloseButton(GuildNewsFiltersFrameCloseButton)
	
	for i=1, 7 do
		T.SkinCheckBox(_G["GuildNewsFilterButton"..i])
	end
	
	GuildNewsFiltersFrame:Point("TOPLEFT", GuildFrame, "TOPRIGHT", 4, -20)
	T.SkinScrollBar(GuildNewsContainerScrollBar)
	
	--Info Frame
	T.SkinScrollBar(GuildInfoDetailsFrameScrollBar)
	T.SkinScrollBar(GuildInfoFrameApplicantsContainerScrollBar)
	
	for i=1, 3 do
		_G["GuildInfoFrameTab"..i]:StripTextures()
	end
	
	local backdrop1 = CreateFrame("Frame", nil, GuildInfoFrameInfo)
	backdrop1:SetTemplate("Default")
	backdrop1:SetFrameLevel(GuildInfoFrameInfo:GetFrameLevel() - 1)
	backdrop1:Point("TOPLEFT", GuildInfoFrameInfo, "TOPLEFT", 2, -22)
	backdrop1:Point("BOTTOMRIGHT", GuildInfoFrameInfo, "BOTTOMRIGHT", 0, 200)
	
	local backdrop2 = CreateFrame("Frame", nil, GuildInfoFrameInfo)
	backdrop2:SetTemplate("Default")
	backdrop2:SetFrameLevel(GuildInfoFrameInfo:GetFrameLevel() - 1)
	backdrop2:Point("TOPLEFT", GuildInfoFrameInfo, "TOPLEFT", 2, -158)
	backdrop2:Point("BOTTOMRIGHT", GuildInfoFrameInfo, "BOTTOMRIGHT", 0, 118)	

	local backdrop3 = CreateFrame("Frame", nil, GuildInfoFrameInfo)
	backdrop3:SetTemplate("Default")
	backdrop3:SetFrameLevel(GuildInfoFrameInfo:GetFrameLevel() - 1)
	backdrop3:Point("TOPLEFT", GuildInfoFrameInfo, "TOPLEFT", 2, -233)
	backdrop3:Point("BOTTOMRIGHT", GuildInfoFrameInfo, "BOTTOMRIGHT", 0, 3)	
	
	GuildRecruitmentCommentInputFrame:SetTemplate("Default")
	
	for _, button in next, GuildInfoFrameApplicantsContainer.buttons do
		button.selectedTex:Kill()
		button:GetHighlightTexture():Kill()
		button:SetBackdrop(nil)
	end
	
	--Text Edit Frame
	GuildTextEditFrame:SetTemplate("Default")
	T.SkinScrollBar(GuildTextEditScrollFrameScrollBar)
	GuildTextEditContainer:SetTemplate("Default")
	for i = 1, GuildTextEditFrame:GetNumChildren() do
		local child = select(i, GuildTextEditFrame:GetChildren())
		local point = select(1, child:GetPoint())
		if point == "TOPRIGHT" then
			T.SkinCloseButton(child)
		else
			T.SkinButton(child, true)
		end
	end

	--Guild Log
	T.SkinScrollBar(GuildLogScrollFrameScrollBar)
	GuildLogFrame:SetTemplate("Default")

	for i = 1, GuildLogFrame:GetNumChildren() do
		local child = select(i, GuildLogFrame:GetChildren())
		local point = select(1, child:GetPoint())
		if point == "TOPRIGHT" then
			T.SkinCloseButton(child)
		else
			T.SkinButton(child, true)
		end
	end
	
	--Rewards
	T.SkinScrollBar(GuildRewardsContainerScrollBar)
	
	for i=1, 8 do
		local button = _G["GuildRewardsContainerButton"..i]
		button:StripTextures()
		
		if button.icon then
			button.icon:SetTexCoord(.08, .92, .08, .92)
			button.icon:ClearAllPoints()
			button.icon:Point("TOPLEFT", 2, -2)
			button:CreateBackdrop("Default")
			button.backdrop:Point("TOPLEFT", button.icon, "TOPLEFT", -2, 2)
			button.backdrop:Point("BOTTOMRIGHT", button.icon, "BOTTOMRIGHT", 2, -2)
			button.icon:SetParent(button.backdrop)
		end
	end
end

T.SkinFuncs["Blizzard_GuildUI"] = LoadSkin