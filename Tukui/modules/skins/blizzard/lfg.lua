local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	local checkbox = {
		"LookingForGuildPvPButton",
		"LookingForGuildWeekendsButton",
		"LookingForGuildWeekdaysButton",
		"LookingForGuildRPButton",
		"LookingForGuildRaidButton",
		"LookingForGuildQuestButton",
		"LookingForGuildDungeonButton",
	}
	-- skin checkboxes
	for _, v in pairs(checkbox) do
		T.SkinCheckBox(_G[v])
	end
	

	-- have to skin these checkboxes seperate for some reason o_O
	T.SkinCheckBox(LookingForGuildTankButton.checkButton)
	T.SkinCheckBox(LookingForGuildHealerButton.checkButton)
	T.SkinCheckBox(LookingForGuildDamagerButton.checkButton)
	
	-- skinning other frames
	LookingForGuildFrameInset:StripTextures(false)
	LookingForGuildFrame:StripTextures()
	LookingForGuildFrame:SetTemplate("Default")
	LookingForGuildBrowseButton_LeftSeparator:Kill()
	LookingForGuildRequestButton_RightSeparator:Kill()
	T.SkinScrollBar(LookingForGuildBrowseFrameContainerScrollBar)
	T.SkinButton(LookingForGuildBrowseButton)
	T.SkinButton(LookingForGuildRequestButton)
	T.SkinCloseButton(LookingForGuildFrameCloseButton)
	LookingForGuildCommentInputFrame:CreateBackdrop("Default")
	LookingForGuildCommentInputFrame:StripTextures(false)
	
	-- skin container buttons on browse and request page
	for i = 1, 5 do
		local b = _G["LookingForGuildBrowseFrameContainerButton"..i]
		local t = _G["LookingForGuildAppsFrameContainerButton"..i]
		b:SetBackdrop(nil)
		t:SetBackdrop(nil)
	end
	
	-- skin tabs
	for i= 1, 3 do
		T.SkinTab(_G["LookingForGuildFrameTab"..i])
	end
	
	GuildFinderRequestMembershipFrame:StripTextures(true)
	GuildFinderRequestMembershipFrame:SetTemplate("Default")
	T.SkinButton(GuildFinderRequestMembershipFrameAcceptButton)
	T.SkinButton(GuildFinderRequestMembershipFrameCancelButton)
	GuildFinderRequestMembershipFrameInputFrame:StripTextures()
	GuildFinderRequestMembershipFrameInputFrame:SetTemplate("Default")		
end

T.SkinFuncs["Blizzard_LookingForGuildUI"] = LoadSkin