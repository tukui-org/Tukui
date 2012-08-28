local T, C, L, G = unpack(select(2, ...)) 

local AchievementHolder = CreateFrame("Frame", "TukuiAchievementHolder", UIParent)
AchievementHolder:Width(180)
AchievementHolder:Height(20)
AchievementHolder:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 176)
AchievementHolder:SetTemplate("Default")
AchievementHolder:SetBackdropBorderColor(1, 0, 0)
AchievementHolder:SetClampedToScreen(true)
AchievementHolder:SetMovable(true)
AchievementHolder:SetAlpha(0)
AchievementHolder.text = T.SetFontString(AchievementHolder, C.media.uffont, 12)
AchievementHolder.text:SetPoint("CENTER")
AchievementHolder.text:SetText(L.move_achievements)

AlertFrame:SetParent(AchievementHolder)
AlertFrame:SetPoint("TOP", AchievementHolder, 0, -30)

--[[
	SlashCmdList.TEST_ACHIEVEMENT = function()
		PlaySound("LFG_Rewards")
		AchievementFrame_LoadUI()
		AchievementAlertFrame_ShowAlert(5780)
		AchievementAlertFrame_ShowAlert(5000)
		GuildChallengeAlertFrame_ShowAlert(3, 2, 5)
		ChallengeModeAlertFrame_ShowAlert()
		CriteriaAlertFrame_GetAlertFrame()
		AlertFrame_AnimateIn(CriteriaAlertFrame1)
		AlertFrame_AnimateIn(DungeonCompletionAlertFrame1)
		AlertFrame_AnimateIn(ScenarioAlertFrame1)
		MoneyWonAlertFrame_ShowAlert(1)
		
		local _, itemLink = GetItemInfo(6948)
		LootWonAlertFrame_ShowAlert(itemLink, -1, 1, 1)
		AlertFrame_FixAnchors()
	end
	SLASH_TEST_ACHIEVEMENT1 = "/testalerts"
--]]