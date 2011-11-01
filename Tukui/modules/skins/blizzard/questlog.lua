local T, C, L = unpack(select(2, ...))
local function LoadSkin()
	T.SkinCloseButton(QuestLogFrameCloseButton)
	QuestLogFrame:StripTextures()
	QuestLogFrame:SetTemplate("Default")
	QuestLogFrame:CreateShadow("Default")
	QuestLogCount:StripTextures()

	EmptyQuestLogFrame:StripTextures()

	QuestLogFrameShowMapButton:StripTextures()
	T.SkinButton(QuestLogFrameShowMapButton)
	QuestLogFrameShowMapButton.text:ClearAllPoints()
	QuestLogFrameShowMapButton.text:SetPoint("CENTER")
	QuestLogFrameShowMapButton:Size(QuestLogFrameShowMapButton:GetWidth() - 30, QuestLogFrameShowMapButton:GetHeight(), - 40)
	
	QuestLogFrameCompleteButton:StripTextures()
	T.SkinButton(QuestLogFrameCompleteButton)
	T.SkinScrollBar(QuestLogDetailScrollFrameScrollBar)

	local buttons = {
		"QuestLogFrameAbandonButton",
		"QuestLogFramePushQuestButton",
		"QuestLogFrameTrackButton",
		"QuestLogFrameCancelButton",
	}

	for _, button in pairs(buttons) do
		T.SkinButton(_G[button])
	end
	QuestLogFramePushQuestButton:Point("LEFT", QuestLogFrameAbandonButton, "RIGHT", 2, 0)
	QuestLogFramePushQuestButton:Point("RIGHT", QuestLogFrameTrackButton, "LEFT", -2, 0)

	for i=1, MAX_NUM_ITEMS do
		_G["QuestInfoItem"..i]:StripTextures()
		_G["QuestInfoItem"..i]:StyleButton()
		_G["QuestInfoItem"..i]:Width(_G["QuestInfoItem"..i]:GetWidth() - 4)
		_G["QuestInfoItem"..i]:SetFrameLevel(_G["QuestInfoItem"..i]:GetFrameLevel() + 2)
		_G["QuestInfoItem"..i.."IconTexture"]:SetTexCoord(.08, .92, .08, .92)
		_G["QuestInfoItem"..i.."IconTexture"]:SetDrawLayer("OVERLAY")
		_G["QuestInfoItem"..i.."IconTexture"]:Point("TOPLEFT", 2, -2)
		_G["QuestInfoItem"..i.."IconTexture"]:Size(_G["QuestInfoItem"..i.."IconTexture"]:GetWidth() - 2, _G["QuestInfoItem"..i.."IconTexture"]:GetHeight() - 2)
		_G["QuestInfoItem"..i]:SetTemplate("Default")
		_G["QuestInfoItem"..i.."Count"]:SetDrawLayer("OVERLAY")
	end

	QuestInfoSkillPointFrame:StripTextures()
	QuestInfoSkillPointFrame:StyleButton()
	QuestInfoSkillPointFrame:Width(QuestInfoSkillPointFrame:GetWidth() - 4)
	QuestInfoSkillPointFrame:SetFrameLevel(QuestInfoSkillPointFrame:GetFrameLevel() + 2)
	QuestInfoSkillPointFrameIconTexture:SetTexCoord(.08, .92, .08, .92)
	QuestInfoSkillPointFrameIconTexture:SetDrawLayer("OVERLAY")
	QuestInfoSkillPointFrameIconTexture:Point("TOPLEFT", 2, -2)
	QuestInfoSkillPointFrameIconTexture:Size(QuestInfoSkillPointFrameIconTexture:GetWidth() - 2, QuestInfoSkillPointFrameIconTexture:GetHeight() - 2)
	QuestInfoSkillPointFrame:SetTemplate("Default")
	QuestInfoSkillPointFrameCount:SetDrawLayer("OVERLAY")
	QuestInfoSkillPointFramePoints:ClearAllPoints()
	QuestInfoSkillPointFramePoints:Point("BOTTOMRIGHT", QuestInfoSkillPointFrameIconTexture, "BOTTOMRIGHT")

	QuestInfoItemHighlight:StripTextures()
	QuestInfoItemHighlight:SetTemplate("Default")
	QuestInfoItemHighlight:SetBackdropBorderColor(1, 1, 0)
	QuestInfoItemHighlight:SetBackdropColor(0, 0, 0, 0)
	QuestInfoItemHighlight:Size(142, 40)

	hooksecurefunc("QuestInfoItem_OnClick", function(self)
		QuestInfoItemHighlight:ClearAllPoints()
		QuestInfoItemHighlight:SetAllPoints(self)
	end)

	--Everything here to make the text a readable color
	local function QuestObjectiveText()
		local numObjectives = GetNumQuestLeaderBoards()
		local objective
		local type, finished
		local numVisibleObjectives = 0
		for i = 1, numObjectives do
			_, type, finished = GetQuestLogLeaderBoard(i)
			if (type ~= "spell") then
				numVisibleObjectives = numVisibleObjectives+1
				objective = _G["QuestInfoObjective"..numVisibleObjectives]
				if ( finished ) then
					objective:SetTextColor(1, 1, 0)
				else
					objective:SetTextColor(0.6, 0.6, 0.6)
				end
			end
		end			
	end

	hooksecurefunc("QuestInfo_Display", function(template, parentFrame, acceptButton, material)								
		local textColor = {1, 1, 1}
		local titleTextColor = {1, 1, 0}
		
		-- headers
		QuestInfoTitleHeader:SetTextColor(unpack(titleTextColor))
		QuestInfoDescriptionHeader:SetTextColor(unpack(titleTextColor))
		QuestInfoObjectivesHeader:SetTextColor(unpack(titleTextColor))
		QuestInfoRewardsHeader:SetTextColor(unpack(titleTextColor))
		-- other text
		QuestInfoDescriptionText:SetTextColor(unpack(textColor))
		QuestInfoObjectivesText:SetTextColor(unpack(textColor))
		QuestInfoGroupSize:SetTextColor(unpack(textColor))
		QuestInfoRewardText:SetTextColor(unpack(textColor))
		-- reward frame text
		QuestInfoItemChooseText:SetTextColor(unpack(textColor))
		QuestInfoItemReceiveText:SetTextColor(unpack(textColor))
		QuestInfoSpellLearnText:SetTextColor(unpack(textColor))
		QuestInfoXPFrameReceiveText:SetTextColor(unpack(textColor))	
		
		QuestObjectiveText()
	end)

	hooksecurefunc("QuestInfo_ShowRequiredMoney", function()
		local requiredMoney = GetQuestLogRequiredMoney()
		if ( requiredMoney > 0 ) then
			if ( requiredMoney > GetMoney() ) then
				-- Not enough money
				QuestInfoRequiredMoneyText:SetTextColor(0.6, 0.6, 0.6)
			else
				QuestInfoRequiredMoneyText:SetTextColor(1, 1, 0)
			end
		end			
	end)

	QuestLogFrame:HookScript("OnShow", function()
		QuestLogDetailScrollFrame:Height(QuestLogScrollFrame:GetHeight()-4)
		QuestLogScrollFrame:SetTemplate("Default")
		QuestLogDetailScrollFrame:SetTemplate("Default")
	end)
end	

tinsert(T.SkinFuncs["Tukui"], LoadSkin)