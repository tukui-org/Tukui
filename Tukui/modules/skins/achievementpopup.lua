local T, C, L, G = unpack(select(2, ...))

--[[
	-- for testing them
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
		AlertFrame_FixAnchors()
	end
	SLASH_TEST_ACHIEVEMENT1 = "/testalerts"
--]]

local function LoadSkin()
	local function SkinAchievePopUp()
		for i = 1, MAX_ACHIEVEMENT_ALERTS do
			local frame = _G["AchievementAlertFrame"..i]

			if frame then
				frame:SetAlpha(1)
				frame.SetAlpha = T.dummy

				if not frame.backdrop then
					frame:CreateBackdrop("Default")
					frame.backdrop:Point("TOPLEFT", frame, "TOPLEFT", -2, -6)
					frame.backdrop:Point("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 6)
				end

				-- Background
				_G["AchievementAlertFrame"..i.."Background"]:SetTexture(nil)
				_G["AchievementAlertFrame"..i..'OldAchievement']:Kill()
				_G["AchievementAlertFrame"..i.."Glow"]:Kill()
				_G["AchievementAlertFrame"..i.."Shine"]:Kill()
				_G["AchievementAlertFrame"..i.."GuildBanner"]:Kill()
				_G["AchievementAlertFrame"..i.."GuildBorder"]:Kill()

				-- Text
				_G["AchievementAlertFrame"..i.."Name"]:SetTextColor(1, 0.8, 0)
				_G["AchievementAlertFrame"..i.."Name"]:SetFont(C.media.font, 11)
				_G["AchievementAlertFrame"..i.."Unlocked"]:SetTextColor(1, 1, 1)
				_G["AchievementAlertFrame"..i.."Unlocked"]:SetFont(C.media.font, 11)

				-- Icon
				_G["AchievementAlertFrame"..i.."IconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				_G["AchievementAlertFrame"..i.."IconOverlay"]:Kill()
				_G["AchievementAlertFrame"..i.."IconTexture"]:ClearAllPoints()
				_G["AchievementAlertFrame"..i.."IconTexture"]:Point("LEFT", frame, 7, 0)

				if not _G["AchievementAlertFrame"..i.."IconTexture"].b then
					_G["AchievementAlertFrame"..i.."IconTexture"].b = CreateFrame("Frame", nil, _G["AchievementAlertFrame"..i])
					_G["AchievementAlertFrame"..i.."IconTexture"].b:SetFrameLevel(0)
					_G["AchievementAlertFrame"..i.."IconTexture"].b:SetTemplate("Default")
					_G["AchievementAlertFrame"..i.."IconTexture"].b:Point("TOPLEFT", _G["AchievementAlertFrame"..i.."IconTexture"], "TOPLEFT", -2, 2)
					_G["AchievementAlertFrame"..i.."IconTexture"].b:Point("BOTTOMRIGHT", _G["AchievementAlertFrame"..i.."IconTexture"], "BOTTOMRIGHT", 2, -2)
				end
			end
		end
	end
	hooksecurefunc("AlertFrame_SetAchievementAnchors", SkinAchievePopUp)

	local function SkinDungeonPopUp()
		for i = 1, DUNGEON_COMPLETION_MAX_REWARDS do
			local frame = _G["DungeonCompletionAlertFrame"..i]
			if frame then
				frame:SetAlpha(1)
				frame.SetAlpha = T.dummy
				frame.heroicIcon:Hide()

				if not frame.backdrop then
					frame:CreateBackdrop("Default")
					frame.backdrop:Point("TOPLEFT", frame, "TOPLEFT", 16, -6)
					frame.backdrop:Point("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -20, 6)
				end

				-- Background
				for i = 1, frame:GetNumRegions() do
					local region = select(i, frame:GetRegions())
					if region:GetObjectType() == "Texture" then
						if region:GetTexture() == "Interface\\LFGFrame\\UI-LFG-DUNGEONTOAST" or region:GetTexture() == "Interface\\LFGFrame\\LFR-Texture" then
							region:Kill()
						end
					end
				end

				_G["DungeonCompletionAlertFrame"..i.."Shine"]:Kill()
				_G["DungeonCompletionAlertFrame"..i.."GlowFrame"]:Kill()
				_G["DungeonCompletionAlertFrame"..i.."GlowFrame"].glow:Kill()
				_G["DungeonCompletionAlertFrame"..i].raidArt:Kill()
				_G["DungeonCompletionAlertFrame"..i.."Reward1"]:Hide()

				-- Icon
				_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"]:SetDrawLayer('OVERLAY')
				_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"]:ClearAllPoints()
				_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"]:Point("LEFT", frame.backdrop, 9, 0)

				if not _G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b then
					_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b = CreateFrame("Frame", nil, _G["DungeonCompletionAlertFrame"..i])
					_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b:SetFrameLevel(0)
					_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b:SetTemplate("Default")
					_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b:Point("TOPLEFT", _G["DungeonCompletionAlertFrame"..i.."DungeonTexture"], "TOPLEFT", -2, 2)
					_G["DungeonCompletionAlertFrame"..i.."DungeonTexture"].b:Point("BOTTOMRIGHT", _G["DungeonCompletionAlertFrame"..i.."DungeonTexture"], "BOTTOMRIGHT", 2, -2)
				end
			end
		end
	end
	hooksecurefunc("AlertFrame_SetDungeonCompletionAnchors", SkinDungeonPopUp)
	
	-- hide some shit icons on dungeons alerts
	local function DungeonCompletionAlertFrameReward_SetReward(self)
		self:Hide()
	end
	hooksecurefunc("DungeonCompletionAlertFrameReward_SetReward", DungeonCompletionAlertFrameReward_SetReward)

	local function SkinGuildChallengePopUp()
		local frame = _G["GuildChallengeAlertFrame"]

		if frame then
			frame:SetAlpha(1)
			frame.SetAlpha = T.dummy

			if not frame.backdrop then
				frame:CreateBackdrop("Default")
				frame.backdrop:Point("TOPLEFT", frame, "TOPLEFT", -2, -6)
				frame.backdrop:Point("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 6)
			end

			-- Background
			local region = select(2, frame:GetRegions())
			if region:GetObjectType() == "Texture" then
				if region:GetTexture() == "Interface\\GuildFrame\\GuildChallenges" then
					region:Kill()
				end
			end

			_G["GuildChallengeAlertFrameGlow"]:Kill()
			_G["GuildChallengeAlertFrameShine"]:Kill()
			_G["GuildChallengeAlertFrameEmblemBorder"]:Kill()

			-- Icon border
			if not _G["GuildChallengeAlertFrameEmblemIcon"].b then
				_G["GuildChallengeAlertFrameEmblemIcon"].b = CreateFrame("Frame", nil, _G["GuildChallengeAlertFrame"])
				_G["GuildChallengeAlertFrameEmblemIcon"].b:SetFrameLevel(0)
				_G["GuildChallengeAlertFrameEmblemIcon"].b:SetTemplate("Default")
				_G["GuildChallengeAlertFrameEmblemIcon"].b:Point("TOPLEFT", _G["GuildChallengeAlertFrameEmblemIcon"], "TOPLEFT", -3, 3)
				_G["GuildChallengeAlertFrameEmblemIcon"].b:Point("BOTTOMRIGHT", _G["GuildChallengeAlertFrameEmblemIcon"], "BOTTOMRIGHT", 3, -2)
			end
		end
	end
	hooksecurefunc("AlertFrame_SetGuildChallengeAnchors", SkinGuildChallengePopUp)

	local function SkinChallengePopUp()
		local frame = _G["ChallengeModeAlertFrame1"]

		if frame then
			frame:SetAlpha(1)
			frame.SetAlpha = T.dummy

			if not frame.backdrop then
				frame:CreateBackdrop("Default")
				frame.backdrop:Point("TOPLEFT", frame, "TOPLEFT", 19, -6)
				frame.backdrop:Point("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -22, 6)
			end

			-- Background
			for i = 1, frame:GetNumRegions() do
				local region = select(i, frame:GetRegions())
				if region:GetObjectType() == "Texture" then
					if region:GetTexture() == "Interface\\Challenges\\challenges-main" then
						region:Kill()
					end
				end
			end

			_G["ChallengeModeAlertFrame1Shine"]:Kill()
			_G["ChallengeModeAlertFrame1GlowFrame"]:Kill()
			_G["ChallengeModeAlertFrame1GlowFrame"].glow:Kill()
			_G["ChallengeModeAlertFrame1Border"]:Kill()

			-- Icon
			_G["ChallengeModeAlertFrame1DungeonTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			_G["ChallengeModeAlertFrame1DungeonTexture"]:ClearAllPoints()
			_G["ChallengeModeAlertFrame1DungeonTexture"]:Point("LEFT", frame.backdrop, 9, 0)

			-- Icon border
			if not _G["ChallengeModeAlertFrame1DungeonTexture"].b then
				_G["ChallengeModeAlertFrame1DungeonTexture"].b = CreateFrame("Frame", nil, _G["ChallengeModeAlertFrame1"])
				_G["ChallengeModeAlertFrame1DungeonTexture"].b:SetFrameLevel(0)
				_G["ChallengeModeAlertFrame1DungeonTexture"].b:SetTemplate("Default")
				_G["ChallengeModeAlertFrame1DungeonTexture"].b:Point("TOPLEFT", _G["ChallengeModeAlertFrame1DungeonTexture"], "TOPLEFT", -2, 2)
				_G["ChallengeModeAlertFrame1DungeonTexture"].b:Point("BOTTOMRIGHT", _G["ChallengeModeAlertFrame1DungeonTexture"], "BOTTOMRIGHT", 2, -2)
			end
		end
	end
	hooksecurefunc("AlertFrame_SetChallengeModeAnchors", SkinChallengePopUp)

	local function SkinScenarioPopUp()
		local frame = _G["ScenarioAlertFrame1"]

		if frame then
			frame:SetAlpha(1)
			frame.SetAlpha = T.dummy

			if not frame.backdrop then
				frame:CreateBackdrop("Default")
				frame.backdrop:Point("TOPLEFT", frame, "TOPLEFT", 4, 4)
				frame.backdrop:Point("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -7, 6)
			end

			-- Background
			for i = 1, frame:GetNumRegions() do
				local region = select(i, frame:GetRegions())
				if region:GetObjectType() == "Texture" then
					if region:GetTexture() == "Interface\\Scenarios\\ScenariosParts" then
						region:Kill()
					end
				end
			end

			_G["ScenarioAlertFrame1Shine"]:Kill()
			_G["ScenarioAlertFrame1GlowFrame"]:Kill()
			_G["ScenarioAlertFrame1GlowFrame"].glow:Kill()

			-- Icon
			_G["ScenarioAlertFrame1DungeonTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			_G["ScenarioAlertFrame1DungeonTexture"]:ClearAllPoints()
			_G["ScenarioAlertFrame1DungeonTexture"]:Point("LEFT", frame.backdrop, 9, 0)
			
			-- Icon border
			if not _G["ScenarioAlertFrame1DungeonTexture"].b then
				_G["ScenarioAlertFrame1DungeonTexture"].b = CreateFrame("Frame", nil, _G["ScenarioAlertFrame1"])
				_G["ScenarioAlertFrame1DungeonTexture"].b:SetFrameLevel(0)
				_G["ScenarioAlertFrame1DungeonTexture"].b:SetTemplate("Default")
				_G["ScenarioAlertFrame1DungeonTexture"].b:Point("TOPLEFT", _G["ScenarioAlertFrame1DungeonTexture"], "TOPLEFT", -2, 2)
				_G["ScenarioAlertFrame1DungeonTexture"].b:Point("BOTTOMRIGHT", _G["ScenarioAlertFrame1DungeonTexture"], "BOTTOMRIGHT", 2, -2)
			end
		end
	end
	hooksecurefunc("AlertFrame_SetScenarioAnchors", SkinScenarioPopUp)
	
	local function SkinCriteriaPopUp()
		for i = 1, MAX_ACHIEVEMENT_ALERTS do
			local frame = _G['CriteriaAlertFrame'..i]
			if frame then
				frame:SetAlpha(1)
				frame.SetAlpha = T.dummy

				if not frame.backdrop then
					frame:CreateBackdrop("Default")
					frame.backdrop:Point("TOPLEFT", frame, "TOPLEFT", -2, -6)
					frame.backdrop:Point("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 6)
				end

				_G['CriteriaAlertFrame'..i..'Unlocked']:SetTextColor(1, 1, 1)
				_G['CriteriaAlertFrame'..i..'Name']:SetTextColor(1, 1, 0)
				_G['CriteriaAlertFrame'..i..'Background']:Kill()
				_G['CriteriaAlertFrame'..i..'Glow']:Kill()
				_G['CriteriaAlertFrame'..i..'Shine']:Kill()
				_G['CriteriaAlertFrame'..i..'IconBling']:Kill()
				_G['CriteriaAlertFrame'..i..'IconOverlay']:Kill()
				
				-- Icon border
				if not _G['CriteriaAlertFrame'..i..'IconTexture'].b then
					_G['CriteriaAlertFrame'..i..'IconTexture'].b = CreateFrame("Frame", nil, frame)
					_G['CriteriaAlertFrame'..i..'IconTexture'].b:SetTemplate("Default")
					_G['CriteriaAlertFrame'..i..'IconTexture'].b:Point("TOPLEFT", _G['CriteriaAlertFrame'..i..'IconTexture'], "TOPLEFT", -2, 2)
					_G['CriteriaAlertFrame'..i..'IconTexture'].b:Point("BOTTOMRIGHT", _G['CriteriaAlertFrame'..i..'IconTexture'], "BOTTOMRIGHT", 2, -2)
					_G['CriteriaAlertFrame'..i..'IconTexture']:SetParent(_G['CriteriaAlertFrame'..i..'IconTexture'].b)
					_G['CriteriaAlertFrame'..i..'IconTexture']:SetTexCoord(0.1, 0.9, 0.1, 0.9)

				end
			end
		end
	end
	hooksecurefunc("AlertFrame_SetCriteriaAnchors", SkinCriteriaPopUp)
	
	local function SetLootWonAnchors()
		for i=1, #LOOT_WON_ALERT_FRAMES do
			local frame = LOOT_WON_ALERT_FRAMES[i];
			if frame then
				frame:SetAlpha(1)
				frame.SetAlpha = T.dummy

				frame.Background:Kill()
				frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				frame.IconBorder:Kill()
				frame.glow:Kill()
				frame.shine:Kill()

				-- Icon border
				if not frame.Icon.b then
					frame.Icon.b = CreateFrame("Frame", nil, frame)
					frame.Icon.b:SetTemplate("Default")
					frame.Icon.b:Point("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
					frame.Icon.b:Point("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
					frame.Icon:SetParent(frame.Icon.b)
				end

				if not frame.backdrop then
					frame:CreateBackdrop("Default")
					frame.backdrop:SetPoint('TOPLEFT', frame.Icon.b, 'TOPLEFT', -4, 4)
					frame.backdrop:SetPoint('BOTTOMRIGHT', frame.Icon.b, 'BOTTOMRIGHT', 180, -4)
				end
			end
		end
	end
	hooksecurefunc("AlertFrame_SetLootWonAnchors", SetLootWonAnchors)

	local function SetMoneyWonAnchors()
		for i=1, #MONEY_WON_ALERT_FRAMES do
			local frame = MONEY_WON_ALERT_FRAMES[i];
			if frame then
				frame:SetAlpha(1)
				frame.SetAlpha = T.dummy

				frame.Background:Kill()
				frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				frame.IconBorder:Kill()

				-- Icon border
				if not frame.Icon.b then
					frame.Icon.b = CreateFrame("Frame", nil, frame)
					frame.Icon.b:SetTemplate("Default")
					frame.Icon.b:Point("TOPLEFT", frame.Icon, "TOPLEFT", -2, 2)
					frame.Icon.b:Point("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, -2)
					frame.Icon:SetParent(frame.Icon.b)
				end

				if not frame.backdrop then
					frame:CreateBackdrop("Default")
					frame.backdrop:SetPoint('TOPLEFT', frame.Icon.b, 'TOPLEFT', -4, 4)
					frame.backdrop:SetPoint('BOTTOMRIGHT', frame.Icon.b, 'BOTTOMRIGHT', 180, -4)
				end
			end
		end
	end
	hooksecurefunc("AlertFrame_SetMoneyWonAnchors", SetMoneyWonAnchors)
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)