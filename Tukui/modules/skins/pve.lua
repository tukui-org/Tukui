local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	local NumTabs = 3
	
	PVEFrame:StripTextures()
	PVEFrame:StripTextures()
	PVEFrameLeftInset:StripTextures()

	PVEFrameBg:Hide()
	PVEFrameTitleBg:Hide()
	PVEFramePortrait:Hide()
	PVEFramePortraitFrame:Hide()
	PVEFrameTopRightCorner:Hide()
	PVEFrameTopBorder:Hide()
	PVEFrameLeftInsetBg:Hide()
	PVEFrame.shadows:Hide()

	GroupFinderFrameGroupButton1.icon:SetTexture("Interface\\Icons\\INV_Helmet_08")
	GroupFinderFrameGroupButton2.icon:SetTexture("Interface\\Icons\\inv_helmet_06")
	GroupFinderFrameGroupButton3.icon:SetTexture("Interface\\Icons\\Icon_Scenarios")
	if T.toc > 50300 then
		NumTabs = 4
		GroupFinderFrameGroupButton4.icon:SetTexture("Interface\\Icons\\Icon_Scenarios")
	end

	for i = 1, NumTabs do
		local bu = GroupFinderFrame["groupButton"..i]

		bu.ring:Hide()
		bu.bg:SetTexture("")
		bu.bg:SetAllPoints()

		bu:CreateBackdrop()
		bu:StyleButton()

		bu.icon:SetTexCoord(.08, .92, .08, .92)
		bu.icon:SetPoint("LEFT", bu, "LEFT")
		bu.icon:SetDrawLayer("OVERLAY")
		bu.icon:Size(40)
		bu.icon:ClearAllPoints()
		bu.icon:SetPoint("LEFT", 10, 0)
		bu.border = CreateFrame("Frame", nil, bu)
		bu.border:CreateBackdrop("Default")
		bu.border.backdrop:Point("TOPLEFT", bu.icon, -2, 2)
		bu.border.backdrop:Point("BOTTOMRIGHT", bu.icon, 2, -2)
	end

	PVEFrame:CreateBackdrop("Default")
	PVEFrameTab1:SkinTab()
	PVEFrameTab2:SkinTab()
	PVEFrameCloseButton:SkinCloseButton()
	
	-- Dungeon finder
	LFDQueueFrameFindGroupButton:StripTextures()
	LFDQueueFrameFindGroupButton:SkinButton()
				
	LFDParentFrame:StripTextures()
	LFDParentFrameInset:StripTextures()
	local function ReskinRewards()
		LFDQueueFrame:StripTextures()
		
		for i = 1, LFD_MAX_REWARDS do
			local button = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i]
			local icon = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."IconTexture"]

			if button then
				if not button.reskinned then				
					local cta = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."ShortageBorder"]
					local count = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."Count"]
					local na = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."NameFrame"]

					icon:SetTexCoord(.08, .92, .08, .92)
					icon:SetDrawLayer("OVERLAY")
					count:SetDrawLayer("OVERLAY")
					na:SetTexture(0, 0, 0, .25)
					na:SetSize(118, 39)
					cta:SetAlpha(0)
					
					button:StripTextures()
					
					button.border = CreateFrame("Frame", nil, button)
					button.border:CreateBackdrop("Default")
					button.border.backdrop:Point("TOPLEFT", icon, -2, 2)
					button.border.backdrop:Point("BOTTOMRIGHT", icon, 2, -2)
					button.border.backdrop:SetBackdropColor(0, 0, 0, 0)

					button.reskinned = true
				end
			end
		end
	end

	hooksecurefunc("LFDQueueFrameRandom_UpdateFrame", ReskinRewards)

	for i = 1, NUM_LFD_CHOICE_BUTTONS do
		_G["LFDQueueFrameSpecificListButton"..i].enableButton:SkinCheckBox()
	end	

	for i = 1, NUM_LFR_CHOICE_BUTTONS do
		local bu = _G["LFRQueueFrameSpecificListButton"..i].enableButton
		bu:SkinCheckBox()
		bu.SetNormalTexture = T.dummy
		bu.SetPushedTexture = T.dummy
	end
	
	LFDQueueFrameTypeDropDown:SkinDropDownBox()
	LFDQueueFrameRandomScrollFrameChildFrameBonusRepFrame.ChooseButton:SkinButton()

	-- Raid Finder
	RaidFinderFrame:StripTextures()
	RaidFinderFrameBottomInset:StripTextures()
	RaidFinderFrameRoleInset:StripTextures()
	RaidFinderFrameBottomInsetBg:Hide()
	RaidFinderFrameBtnCornerRight:Hide()
	RaidFinderFrameButtonBottomBorder:Hide()
	RaidFinderQueueFrameSelectionDropDown:SkinDropDownBox()
	RaidFinderFrameFindRaidButton:StripTextures()
	RaidFinderFrameFindRaidButton:SkinButton()
	RaidFinderQueueFrame:StripTextures()
	RaidFinderQueueFrameBackground:SetAlpha(0)
	RaidFinderQueueFramePartyBackfillBackfillButton:SkinButton()
	RaidFinderQueueFramePartyBackfillNoBackfillButton:SkinButton()

	for i = 1, LFD_MAX_REWARDS do
		local button = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i]
		local icon = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i.."IconTexture"]

		if button then
			if not button.reskinned then
				local cta = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i.."ShortageBorder"]
				local count = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i.."Count"]
				local na = _G["RaidFinderQueueFrameScrollFrameChildFrameItem"..i.."NameFrame"]

				icon:SetTexCoord(.08, .92, .08, .92)
				icon:SetDrawLayer("OVERLAY")
				count:SetDrawLayer("OVERLAY")
				na:SetTexture(0, 0, 0, .25)
				na:SetSize(118, 39)
				cta:SetAlpha(0)
				
				button:StripTextures()
				
				button.border = CreateFrame("Frame", nil, button)
				button.border:CreateBackdrop("Default")
				button.border.backdrop:Point("TOPLEFT", icon, -2, 2)
				button.border.backdrop:Point("BOTTOMRIGHT", icon, 2, -2)
				button.border.backdrop:SetBackdropColor(0, 0, 0, 0)

				button.reskinned = true
			end
		end
	end

	-- Scenario finder
	ScenarioFinderFrameInset:DisableDrawLayer("BORDER")
	ScenarioFinderFrame.TopTileStreaks:Hide()
	ScenarioFinderFrameBtnCornerRight:Hide()
	ScenarioFinderFrameButtonBottomBorder:Hide()
	ScenarioQueueFrame.Bg:Hide()
	ScenarioFinderFrameInset:GetRegions():Hide()
	
	ScenarioQueueFrameFindGroupButton:StripTextures()
	ScenarioQueueFrameFindGroupButton:SkinButton()
	ScenarioQueueFrameTypeDropDown:SkinDropDownBox()
	
	local function SkinScenarioCheckBox()
		if NUM_SCENARIO_CHOICE_BUTTONS then
			for i = 1, NUM_SCENARIO_CHOICE_BUTTONS do
				local button = _G["ScenarioQueueFrameSpecificButton"..i]
				if button and not button.isSkinned then
					button.enableButton:SkinCheckBox()
					button.isSkinned = true
				end
			end
		end
	end
	hooksecurefunc("ScenarioQueueFrameSpecific_Update", SkinScenarioCheckBox)
	
	local function SkinScenarioRewards()
		for i = 1, 4 do
			local b = _G["ScenarioQueueFrameRandomScrollFrameChildFrameItem"..i]
			if b and not b.isSkinned then
				local icon = b.icon
				local icontexture = icon:GetTexture()
				icon:SetTexCoord(.1,.9,.1,.9)
				icon:SetDrawLayer("OVERLAY")
				b:StripTextures()
				icon:SetTexture(icontexture)
				b.isSkinned = true
				
				b.border = CreateFrame("Frame", nil, b)
				b.border:SetOutside(icon)
				b.border:SetTemplate()
				b.border:SetBackdropColor(0,0,0,0)
			end
		end
	end
	hooksecurefunc("ScenarioQueueFrameRandom_UpdateFrame", SkinScenarioRewards)

	-- Raid frame (social frame)
	RaidFrameRaidBrowserButton:SetTemplate("Default")
	RaidFrameAllAssistCheckButton:SkinCheckBox()

	-- Looking for raid
	LFRBrowseFrameRoleInset:DisableDrawLayer("BORDER")
	RaidBrowserFrameBg:Hide()
	LFRQueueFrameSpecificListScrollFrameScrollBackgroundTopLeft:Hide()
	LFRQueueFrameSpecificListScrollFrameScrollBackgroundBottomRight:Hide()
	LFRBrowseFrameRoleInsetBg:Hide()

	for i = 1, 14 do
		if i ~= 6 and i ~= 8 then
			select(i, RaidBrowserFrame:GetRegions()):Hide()
		end
	end

	RaidBrowserFrame:CreateBackdrop()
	RaidBrowserFrame:CreateBackdrop()
	RaidBrowserFrameCloseButton:SkinCloseButton()
	LFRQueueFrameSpecificListScrollFrameScrollBar:SkinScrollBar()
	LFRQueueFrameCommentScrollFrameScrollBar:SkinScrollBar()
	LFRQueueFrameFindGroupButton:SkinButton()
	LFRQueueFrameAcceptCommentButton:SkinButton()
	
	for i = 1, 2 do
		local tab = _G["LFRParentFrameSideTab"..i]		
		select(1, tab:GetRegions()):Hide()

		tab:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
		tab:GetNormalTexture():ClearAllPoints()
		tab:GetNormalTexture():Point("TOPLEFT", 2, -2)
		tab:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)

		tab:CreateBackdrop("Default")
		tab.backdrop:SetAllPoints()
		tab:StyleButton()
		
		local point, relatedTo, point2, x, y = tab:GetPoint()
		if i == 1 then
			tab:Point(point, relatedTo, point2, 3, 2)
		end
	end
	
	for i = 1, 7 do
		local h = _G["LFRBrowseFrameColumnHeader"..i]
		select(1, h:GetRegions()):Hide()
		select(2, h:GetRegions()):Hide()
		select(3, h:GetRegions()):Hide()
		h:StyleButton()
	end
	
	LFRBrowseFrame:StripTextures()
	LFRBrowseFrameSendMessageButton:SkinButton()
	LFRBrowseFrameInviteButton:SkinButton()
	LFRBrowseFrameRefreshButton:SkinButton()
	LFRBrowseFrameRaidDropDown:SkinDropDownBox()

	local StripAllTextures = {
		"LFDQueueFrameSpecific",
		"LFDQueueFrameRandom",
		"LFDQueueFrameRandomScrollFrame",
		"LFDDungeonReadyDialog",
		"LFGDungeonReadyDialog",
	}

	local KillTextures = {
		"LFDQueueFrameBackground",
		"LFDParentFrameInset",
		"LFDParentFrameEyeFrame",
		"LFDDungeonReadyDialogBackground",
		"LFGDungeonReadyDialogBackground",
	}
	
	local buttons = {
		"LFDQueueFramePartyBackfillBackfillButton",
		"LFDQueueFramePartyBackfillNoBackfillButton",
	}

	local checkButtons = {
		"LFDQueueFrameRoleButtonTank",
		"LFDQueueFrameRoleButtonHealer",
		"LFDQueueFrameRoleButtonDPS",
		"LFDQueueFrameRoleButtonLeader",
		"RaidFinderQueueFrameRoleButtonTank",
		"RaidFinderQueueFrameRoleButtonHealer",
		"RaidFinderQueueFrameRoleButtonDPS",
		"RaidFinderQueueFrameRoleButtonLeader",
	}

	for _, object in pairs(checkButtons) do
		_G[object]:GetChildren():SetFrameLevel(_G[object]:GetChildren():GetFrameLevel() + 2)
		_G[object]:GetChildren():SkinCheckBox()
	end

	for _, object in pairs(StripAllTextures) do
		if _G[object] then _G[object]:StripTextures() end
	end

	for _, texture in pairs(KillTextures) do
		if _G[texture] then _G[texture]:Kill() end
	end

	for i = 1, #buttons do
		_G[buttons[i]]:StripTextures()
		_G[buttons[i]]:SkinButton()
	end	

	for i= 1,15 do
		_G["LFDQueueFrameSpecificListButton"..i.."EnableButton"]:SkinCheckBox()
	end

	LFDQueueFrameSpecificListScrollFrame:StripTextures()
	LFDQueueFrameSpecificListScrollFrame:Height(LFDQueueFrameSpecificListScrollFrame:GetHeight() - 8)
	LFDQueueFrameTypeDropDown:Point("RIGHT",-10,0)
	LFDQueueFrameSpecificListScrollFrameScrollBar:SkinScrollBar()
	
	LFGDungeonReadyPopup:SetTemplate("Default")
	LFGDungeonReadyPopup:CreateShadow("Default")
	LFGDungeonReadyDialog.SetBackdrop = T.dummy
	LFGDungeonReadyDialog.filigree:SetAlpha(0)
	LFGDungeonReadyDialog.bottomArt:SetAlpha(0)
	LFGDungeonReadyDialogLeaveQueueButton:SkinButton()
	LFGDungeonReadyDialogEnterDungeonButton:SkinButton()
	LFGDungeonReadyDialogCloseButton:SkinCloseButton()
	LFGDungeonReadyDialogCloseButton.t:SetText("_")
	LFGDungeonReadyStatus:SetTemplate("Transparent")
	LFGDungeonReadyStatusCloseButton:SkinCloseButton()
	LFGDungeonReadyStatusCloseButton.t:SetText("_")
	PVEFrameTab1:Point("BOTTOMLEFT", PVEFrame, "BOTTOMLEFT", 19, -32)
	RaidFinderQueueFrameCooldownFrame:Point("BOTTOMRIGHT", RaidFinderQueueFrame, "BOTTOMRIGHT", -6, 28)
	LFDQueueFrameTypeDropDown:ClearAllPoints()
	LFDQueueFrameTypeDropDown:Point("TOPRIGHT", LFDQueueFrame, "TOPRIGHT", -10, -111)
	RaidFinderQueueFrameSelectionDropDown:ClearAllPoints()
	RaidFinderQueueFrameSelectionDropDown:Point("TOPRIGHT", RaidFinderQueueFrame, "TOPRIGHT", -10, -109)
	ScenarioQueueFrameRandomScrollFrameChildFrameBonusRepFrame.ChooseButton:SkinButton()
	LFDQueueFrameRandomScrollFrameScrollBar:StripTextures()
	LFDQueueFrameRandomScrollFrameScrollBar:SkinScrollBar()
	
	-- Flex
	if T.toc > 50300 then
		FlexRaidFrame:StripTextures()
		FlexRaidFrameStartRaidButton:StripTextures()
		FlexRaidFrameStartRaidButton:SkinButton()
		FlexRaidFrameBottomInset:StripTextures()
		FlexRaidFrameScrollFrame:StripTextures()
		FlexRaidFrameScrollFrameScrollBar:StripTextures()
		FlexRaidFrameScrollFrameScrollBar:SkinScrollBar()
		FlexRaidFrameSelectionDropDown:SkinDropDownBox()
	end
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)

local function LoadSecondarySkin()
	ChallengesFrameInset:StripTextures()
	ChallengesFrameInsetBg:Hide()
	ChallengesFrameDetails.bg:Hide()
	ChallengesFrameLeaderboard:StripTextures()
	ChallengesFrameLeaderboard:SkinButton()
	select(2, ChallengesFrameDetails:GetRegions()):Hide()
	select(9, ChallengesFrameDetails:GetRegions()):Hide()
	select(10, ChallengesFrameDetails:GetRegions()):Hide()
	select(11, ChallengesFrameDetails:GetRegions()):Hide()
	ChallengesFrameDungeonButton1:SetPoint("TOPLEFT", ChallengesFrame, "TOPLEFT", 8, -83)

	for i = 1, 9 do
		local bu = ChallengesFrame["button"..i]
		bu:SkinButton()
		bu:StyleButton()
		bu:SetHighlightTexture("")
		bu.selectedTex:SetAlpha(.2)
		bu.selectedTex:SetPoint("TOPLEFT", 1, -1)
		bu.selectedTex:SetPoint("BOTTOMRIGHT", -1, 1)
	end

	for i = 1, 3 do
		local rewardsRow = ChallengesFrame["RewardRow"..i]
		for j = 1, 2 do
			local bu = rewardsRow["Reward"..j]
			bu:CreateBackdrop()
			bu.Icon:SetTexCoord(.08, .92, .08, .92)	
		end
	end
	
	LFRBrowseFrameListScrollFrameScrollBar:SkinScrollBar()
end

T.SkinFuncs["Blizzard_ChallengesUI"] = LoadSecondarySkin