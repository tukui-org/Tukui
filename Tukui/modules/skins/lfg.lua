local T, C, L, G = unpack(select(2, ...))

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
		_G[v]:SkinCheckBox()
	end
	
	local backdrop = {
		"LookingForGuildInterestFrame",
		"LookingForGuildAvailabilityFrame",
		"LookingForGuildRolesFrame",
		"LookingForGuildCommentFrame",
	}
	
	for _, v in pairs(backdrop) do
		_G[v]:StripTextures()
	end
	
	-- have to skin these checkboxes seperate for some reason o_O
	LookingForGuildTankButton.checkButton:SkinCheckBox()
	LookingForGuildHealerButton.checkButton:SkinCheckBox()
	LookingForGuildDamagerButton.checkButton:SkinCheckBox()
	
	-- skinning other frames
	LookingForGuildFrameInset:StripTextures(false)
	LookingForGuildFrame:StripTextures()
	LookingForGuildFrame:SetTemplate("Default")
	LookingForGuildBrowseButton_LeftSeparator:Kill()
	LookingForGuildRequestButton_RightSeparator:Kill()
	LookingForGuildBrowseFrameContainerScrollBar:SkinScrollBar()
	LookingForGuildBrowseButton:SkinButton()
	LookingForGuildRequestButton:SkinButton()
	LookingForGuildFrameCloseButton:SkinCloseButton()
	LookingForGuildCommentInputFrame:CreateBackdrop("Default")
	LookingForGuildCommentInputFrame:StripTextures(false)
	
	-- skin container buttons on browse and request page
	for i = 1, 5 do
		local b = _G["LookingForGuildBrowseFrameContainerButton"..i]
		local t = _G["LookingForGuildAppsFrameContainerButton"..i]
		local r = _G["LookingForGuildBrowseFrameContainerButton"..i.."Pending"]
		b:SetBackdrop(nil)
		b:SetTemplate("Default")
		b:SetBackdropColor(0, 0, 0, 0)
		b:SetBackdropBorderColor(1, 0, 0, 0)
		b:StyleButton()
		t:SetBackdrop(nil)
		b.selectedTex:Kill()
		if r then
			r:StripTextures()
			r:SetTemplate("Transparent")
		end
		
		b.isSelected = false
	end

	-- skin apps request
	hooksecurefunc("LookingForGuild_Update", function(self, button)
		local s = GetRecruitingGuildSelection()
		local f = LookingForGuildBrowseFrameContainer
		local o = HybridScrollFrame_GetOffset(f)
		local b = f.buttons
		local nb = #b;
		local button, index
		
		for i = 1, nb do
			index = o + i
			button = b[i]
			if index == s then
				if not button.isSelected then
					button:SetBackdropBorderColor(1, 0, 0, 1)
					button:SetBackdropColor(1, 1, 1, .1)
					button.isSelected = true
				end
			else
				if button.isSelected then
					button:SetBackdropBorderColor(0, 0, 0, 0)
					button:SetBackdropColor(0, 0, 0, 0)
					button.isSelected = false
				end
			end
		end
	end)
	
	-- skin tabs
	for i= 1, 3 do
		_G["LookingForGuildFrameTab"..i]:SkinTab()
	end
	
	GuildFinderRequestMembershipFrame:StripTextures(true)
	GuildFinderRequestMembershipFrame:SetTemplate("Default")
	GuildFinderRequestMembershipFrameAcceptButton:SkinButton()
	GuildFinderRequestMembershipFrameCancelButton:SkinButton()
	GuildFinderRequestMembershipFrameInputFrame:StripTextures()
	GuildFinderRequestMembershipFrameInputFrame:SetTemplate("Default")

	-- skin apps request
	hooksecurefunc("LookingForGuildApps_Update", function()
		local f = LookingForGuildAppsFrameContainer
		local b = f.buttons
		local nb = #b
		local na = GetNumGuildMembershipRequests()
		local button
		
		for i = 1, nb do
			button = b[i]
			if not button.isSkinned then
				button:SetTemplate("Default")
				button:StyleButton()
				button.isSkinned = true
			end
		end
	end)
end

T.SkinFuncs["Blizzard_LookingForGuildUI"] = LoadSkin