local T, C, L = select(2, ...):unpack()

if T.Retail then
	local ObjectiveTracker = CreateFrame("Frame", nil, UIParent)
	local Misc = T["Miscellaneous"]
	local Movers = T["Movers"]
	local Noop = function() return end

	-- Lib Globals
	local _G = _G
	local unpack = unpack
	local select = select

	-- WoW Globals
	local ObjectiveTrackerFrame = ObjectiveTrackerFrame
	local ObjectiveTrackerFrameHeaderMenuMinimizeButton = ObjectiveTrackerFrame.HeaderMenu.MinimizeButton
	local SCENARIO_CONTENT_TRACKER_MODULE = SCENARIO_CONTENT_TRACKER_MODULE
	local QUEST_TRACKER_MODULE = QUEST_TRACKER_MODULE
	local WORLD_QUEST_TRACKER_MODULE = WORLD_QUEST_TRACKER_MODULE
	local DEFAULT_OBJECTIVE_TRACKER_MODULE = DEFAULT_OBJECTIVE_TRACKER_MODULE
	local BONUS_OBJECTIVE_TRACKER_MODULE = BONUS_OBJECTIVE_TRACKER_MODULE
	local SCENARIO_TRACKER_MODULE = SCENARIO_TRACKER_MODULE

	-- Locals
	local Class = select(2, UnitClass("player"))
	local ClassColor = T.Colors.class[Class]

	function ObjectiveTracker:OnEnter()
		self:SetFadeInTemplate(1, 1)
	end

	function ObjectiveTracker:OnLeave()
		self:SetFadeOutTemplate(1, 0)
	end

	function ObjectiveTracker:OnClick()
		if (ObjectiveTrackerFrame:IsVisible()) then
			ObjectiveTrackerFrame:Hide()
		else
			ObjectiveTrackerFrame:Show()
		end
	end

	function ObjectiveTracker:SetDefaultPosition()
		local Anchor1, Parent, Anchor2, X, Y = "TOPRIGHT", UIParent, "TOPRIGHT", -68, -240
		local Data = TukuiDatabase.Variables[T.MyRealm][T.MyName]

		local ObjectiveFrameHolder = CreateFrame("Frame", "TukuiObjectiveTracker", UIParent)
		ObjectiveFrameHolder:SetSize(130, 22)
		ObjectiveFrameHolder:SetPoint(Anchor1, Parent, Anchor2, X, Y)

		ObjectiveTrackerFrame:ClearAllPoints()
		ObjectiveTrackerFrame:SetPoint("TOP", ObjectiveFrameHolder)
		ObjectiveTrackerFrame:SetHeight(T.ScreenHeight - 520)
		ObjectiveTrackerFrame.IsUserPlaced = function() return true end

		Movers:RegisterFrame(ObjectiveFrameHolder, "Objectives Tracker")

		if Data and Data.Move and Data.Move.TukuiObjectiveTracker then
			ObjectiveFrameHolder:ClearAllPoints()
			ObjectiveFrameHolder:SetPoint(unpack(Data.Move.TukuiObjectiveTracker))
		end
	end

	function ObjectiveTracker:Skin()
		local Frame = ObjectiveTrackerFrame.MODULES

		if (Frame) then
			for i = 1, #Frame do

				local Modules = Frame[i]
				if (Modules) then
					local Header = Modules.Header

					local Background = Modules.Header.Background
					Background:SetAtlas(nil)

					local Text = Modules.Header.Text
					Text:SetFont(C.Medias.Font, 16)
					Text:SetDrawLayer("OVERLAY", 7)
					Text:SetParent(Header)

					if not (Modules.IsSkinned) then
						local HeaderPanel = CreateFrame("Frame", nil, Header)
						HeaderPanel:SetFrameLevel(Header:GetFrameLevel() - 1)
						HeaderPanel:SetFrameStrata("BACKGROUND")
						HeaderPanel:SetOutside(Header, 1, 1)

						local HeaderBar = CreateFrame("StatusBar", nil, HeaderPanel)
						HeaderBar:SetSize(214, 4)
						HeaderBar:SetPoint("BOTTOMLEFT", HeaderPanel, -13, 0)
						HeaderBar:SetStatusBarTexture(C.Medias.Blank)
						HeaderBar:SetStatusBarColor(unpack(ClassColor))
						HeaderBar:CreateBackdrop()

						HeaderBar:CreateShadow()

						local Minimize = Header.MinimizeButton
						Minimize.SetCollapsed = function() return end
						Minimize:StripTextures()
						Minimize:ClearAllPoints()
						Minimize:SetAllPoints(HeaderBar)

						Modules.IsSkinned = true
					end
				end
			end
		end
	end

	function ObjectiveTracker:UpdateQuestItem(block)
		local QuestItemButton = block.itemButton

		if (QuestItemButton) then
			local Icon = QuestItemButton.icon
			local Count = QuestItemButton.Count
			local HotKey = QuestItemButton.HotKey

			if not (QuestItemButton.IsSkinned) then
				QuestItemButton:SetSize(26, 26)
				QuestItemButton:CreateBackdrop()
				QuestItemButton:CreateShadow()
				QuestItemButton:StyleButton()
				QuestItemButton:SetNormalTexture(nil)

				if (Icon) then
					Icon:SetInside()
					Icon:SetTexCoord(.08, .92, .08, .92)
				end

				if (Count) then
					Count:ClearAllPoints()
					Count:SetPoint("BOTTOMRIGHT", QuestItemButton, 0, 3)
					Count:SetFont(C.Medias.Font, 12)
				end

				if HotKey then
					HotKey:SetText("")
					HotKey:SetAlpha(0)
				end

				QuestItemButton.IsSkinned = true
			end
		end
	end

	function ObjectiveTracker:UpdateProgressBar(_, line)
		local Progress = line.ProgressBar
		local Bar = Progress.Bar

		if (Bar) then
			local Label = Bar.Label
			local Icon = Bar.Icon
			local IconBG = Bar.IconBG
			local Backdrop = Bar.BarBG
			local Glow = Bar.BarGlow
			local Sheen = Bar.Sheen
			local Frame = Bar.BarFrame
			local Frame2 = Bar.BarFrame2
			local Frame3 = Bar.BarFrame3
			local BorderLeft = Bar.BorderLeft
			local BorderRight = Bar.BorderRight
			local BorderMid = Bar.BorderMid
			local Texture = T.GetTexture(C["Textures"].QuestProgressTexture)
			local R, G, B = unpack(T.Colors.class[T.MyClass])

			if not (Bar.IsSkinned) then
				if (Backdrop) then Backdrop:Hide() Backdrop:SetAlpha(0) end
				if (IconBG) then IconBG:Hide() IconBG:SetAlpha(0) end
				if (Glow) then Glow:Hide() end
				if (Sheen) then Sheen:Hide() end
				if (Frame) then Frame:Hide() end
				if (Frame2) then Frame2:Hide() end
				if (Frame3) then Frame3:Hide() end
				if (BorderLeft) then BorderLeft:SetAlpha(0) end
				if (BorderRight) then BorderRight:SetAlpha(0) end
				if (BorderMid) then BorderMid:SetAlpha(0) end

				Bar:StripTextures()
				Bar:SetHeight(20)
				Bar:SetStatusBarTexture(Texture)
				Bar:SetStatusBarColor(R, G, B)
				Bar:CreateBackdrop()

				Bar.Backdrop:SetBackdropColor(R * .15, G * .15, B * .15)
				Bar.Backdrop:CreateShadow()
				Bar.Backdrop:SetFrameLevel(Bar:GetFrameLevel() - 1)
				Bar.Backdrop:SetOutside(Bar)

				if (Label) then
					Label:ClearAllPoints()
					Label:SetPoint("CENTER", Bar, 0, 0)
					Label:SetFont(C.Medias.Font, 12)
				end

				if (Icon) then
					Icon:SetSize(20, 20)
					Icon:SetMask("")
					Icon:SetTexCoord(.08, .92, .08, .92)
					Icon:ClearAllPoints()
					Icon:SetPoint("RIGHT", Bar, 26, 0)

					if not (Bar.NewBorder) then
						Bar.NewBorder = CreateFrame("Frame", nil, Bar)
						Bar.NewBorder:CreateBackdrop()
						Bar.NewBorder:SetFrameLevel(Bar:GetFrameLevel() - 1)
						Bar.NewBorder:CreateShadow()
						Bar.NewBorder:SetOutside(Icon)
						Bar.NewBorder:SetShown(Icon:IsShown())
					end
				end

				Bar.IsSkinned = true
			elseif (Icon and Bar.NewBorder) then
				Bar.NewBorder:SetShown(Icon:IsShown())
			end
		end
	end

	function ObjectiveTracker:UpdateProgressBarColors(Min)
		if (self.Bar and Min) then
			local R, G, B = T.ColorGradient(Min, 100, .8, 0, 0, .8, .8, 0, 0, .8, 0)

			self.Bar:SetStatusBarColor(R, G, B)

			if self.Bar.Backdrop then
				self.Bar.Backdrop:SetBackdropColor(R * .2, G * .2, B * .2)
			end
		end
	end

	function ObjectiveTracker:UpdatePopup()
		for i = 1, GetNumAutoQuestPopUps() do
			local ID, type = GetAutoQuestPopUp(i)
			local Title = C_QuestLog.GetTitleForQuestID(ID)

			if Title and Title ~= "" then
				local Block = self:GetBlock(ID, "ScrollFrame", "AutoQuestPopUpBlockTemplate")

				if Block then
					local Frame = Block.ScrollChild

					if not Frame.Backdrop then
						Frame:CreateBackdrop("Transparent")

						Frame.Backdrop:ClearAllPoints()
						Frame.Backdrop:SetPoint("TOPLEFT", Frame, 15, -4)
						Frame.Backdrop:SetSize(214, 60)
						Frame.Backdrop:SetFrameLevel(0)
						Frame.Backdrop:CreateShadow()

						Frame.FlashFrame.IconFlash:Hide()

						Frame.Shine:ClearAllPoints()
						Frame.Shine:SetParent(T.Hider)

						Frame.IconShine:ClearAllPoints()
						Frame.IconShine:SetParent(T.Hider)
					end

					if  type == "COMPLETE" then
						Frame.QuestIconBg:SetAlpha(0)
						Frame.QuestIconBadgeBorder:SetAlpha(0)
						Frame.QuestionMark:ClearAllPoints()
						Frame.QuestionMark:SetPoint("CENTER", Frame.Backdrop, "LEFT", 10, 0)
						Frame.QuestionMark:SetParent(Frame.Backdrop)
						Frame.QuestionMark:SetDrawLayer("OVERLAY", 7)
						Frame.IconShine:Hide()
					elseif type == "OFFER" then
						Frame.QuestIconBg:SetAlpha(0)
						Frame.QuestIconBadgeBorder:SetAlpha(0)
						test = Frame
						Frame.Exclamation:ClearAllPoints()
						Frame.Exclamation:SetPoint("CENTER", Frame.Backdrop, "LEFT", 20, 0)
						Frame.Exclamation:SetParent(Frame.Backdrop)
						Frame.Exclamation:SetDrawLayer("OVERLAY", 7)
					end

					Frame.FlashFrame:Hide()
					Frame.Bg:Hide()

					for _, v in pairs({Frame.BorderTopLeft, Frame.BorderTopRight, Frame.BorderBotLeft, Frame.BorderBotRight, Frame.BorderLeft, Frame.BorderRight, Frame.BorderTop, Frame.BorderBottom}) do
						v:Hide()
					end
				end
			end
		end
	end

	local function SkinGroupFindButton(block)
		local HasGroupFinderButton = block.hasGroupFinderButton
		local GroupFinderButton = block.groupFinderButton

		if (HasGroupFinderButton and GroupFinderButton) then
			if not (GroupFinderButton.IsSkinned) then
				GroupFinderButton:SkinButton()
				GroupFinderButton:SetSize(18, 18)
				GroupFinderButton:CreateShadow()

				GroupFinderButton.IsSkinned = true
			end
		end
	end

	local function UpdatePositions(block)
		local GroupFinderButton = block.groupFinderButton
		local ItemButton = block.itemButton

		if (ItemButton) then
			local PointA, PointB, PointC, PointD, PointE = ItemButton:GetPoint()
			ItemButton:SetPoint(PointA, PointB, PointC, -6, -1)
		end

		if (GroupFinderButton) then
			local GPointA, GPointB, GPointC, GPointD, GPointE = GroupFinderButton:GetPoint()
			GroupFinderButton:SetPoint(GPointA, GPointB, GPointC, -262, -4)
		end
	end

	function ObjectiveTracker:SkinRewards()
		local rewardsFrame = self.module.rewardsFrame

		rewardsFrame:StripTextures()

		if rewardsFrame.id then
			for i = 1, 6 do
				local rewardItem = rewardsFrame.Rewards[i]

				if rewardItem then
					local Icon = rewardItem.ItemIcon
					local Border = rewardItem.ItemBorder
					local Label = rewardItem.Label
					local ItemOverlay = rewardItem.ItemOverlay

					if Icon then
						--Icon:SetSize(18)
						Icon:SetTexCoord(.08, .92, .08, .92)
					end

					if Border then
						Border:SetTexture("")
					end
				end
			end
		end
	end

	function ObjectiveTracker:SkinAnimaButtons()
		if not self.buffPool then
			return
		end

		for mawBuff in self.buffPool:EnumerateActive() do
			if mawBuff:IsShown() and not mawBuff.IsSkinned then
				mawBuff.Border:SetAlpha(0)
				mawBuff.CircleMask:Hide()
				mawBuff.CountRing:SetAlpha(0)
				mawBuff.HighlightBorder:SetColorTexture(1, 1, 1, .25)
				mawBuff.Icon:SetTexCoord(.1, .9, .1, .9)
				mawBuff:CreateBackdrop()
				mawBuff.Backdrop:CreateShadow()
				mawBuff.Backdrop:SetOutside(mawBuff.Icon)

				mawBuff.IsSkinned = true
			end
		end
	end

	function ObjectiveTracker:SkinScenario()
		local StageBlock = _G["ScenarioStageBlock"]
		local Widgets = ScenarioStageBlock.WidgetContainer
		local WidgetFrames = Widgets and Widgets.widgetFrames

		StageBlock.NormalBG:SetTexture("")
		StageBlock.NormalBG:SetAlpha(0)
		StageBlock.FinalBG:SetTexture("")
		StageBlock.FinalBG:SetAlpha(0)
		StageBlock.Stage:SetFont(C.Medias.Font, 17)
		StageBlock.GlowTexture:SetTexture("")

		if WidgetFrames then
			for _, Frame in pairs(WidgetFrames) do
				if not Frame.IsSkinned then
					for i = 1, Frame:GetNumRegions() do
						local Region = select(i, Frame:GetRegions())

						if (Region and Region:GetObjectType() == "Texture") then
							if Region:GetAtlas() then
								local Atlas = Region:GetAtlas()

								if Atlas and string.find(Atlas, "frame") then
									Region:SetParent(T.Hider)

									Frame:CreateBackdrop("Transparent")

									Frame.Backdrop:ClearAllPoints()
									Frame.Backdrop:SetPoint("TOP", 0, -10)
									Frame.Backdrop:SetPoint("LEFT", 4, 0)
									Frame.Backdrop:SetPoint("RIGHT", -33, 0)
									Frame.Backdrop:SetPoint("BOTTOM", 0, 4)
									Frame.Backdrop:SetSize(214, 60)
									Frame.Backdrop:SetFrameLevel(1)
									Frame.Backdrop:CreateShadow()
								end
							end
						end
					end

					Frame.IsSkinned = true
				end
			end
		end

		if IsInJailersTower() then
			local Container = _G.ScenarioBlocksFrame.MawBuffsBlock.Container

			Container:StripTextures()

			Container:CreateBackdrop("Transparent")
			Container.Backdrop:ClearAllPoints()
			Container.Backdrop:SetPoint("TOPLEFT", 15, -10)
			Container.Backdrop:SetPoint("BOTTOMRIGHT", -33, 10)
			Container.Backdrop:CreateShadow()
			Container.SetAtlas = Noop
			Container.SetPushedAtlas = Noop
			Container.SetHighlightAtlas = Noop

			Container.List:StripTextures()
			Container.List:CreateBackdrop("Transparent")
			Container.List.Backdrop:CreateShadow()
			Container.List:HookScript("OnShow", ObjectiveTracker.SkinAnimaButtons)
		end
	end

	function ObjectiveTracker:AddHooks()
		hooksecurefunc("ObjectiveTracker_Update", self.Skin)
		hooksecurefunc("ScenarioStage_CustomizeBlock", self.SkinScenario)
		hooksecurefunc(QUEST_TRACKER_MODULE, "SetBlockHeader", self.UpdateQuestItem)
		hooksecurefunc(WORLD_QUEST_TRACKER_MODULE, "AddObjective", self.UpdateQuestItem)
		hooksecurefunc(CAMPAIGN_QUEST_TRACKER_MODULE, "AddObjective", self.UpdateQuestItem)
		hooksecurefunc(QUEST_TRACKER_MODULE, "AddProgressBar", self.UpdateProgressBar)
		hooksecurefunc(CAMPAIGN_QUEST_TRACKER_MODULE, "AddProgressBar", self.UpdateProgressBar)
		hooksecurefunc(ACHIEVEMENT_TRACKER_MODULE, "AddProgressBar", self.UpdateProgressBar)
		hooksecurefunc(BONUS_OBJECTIVE_TRACKER_MODULE, "AddProgressBar", self.UpdateProgressBar)
		hooksecurefunc(WORLD_QUEST_TRACKER_MODULE, "AddProgressBar", self.UpdateProgressBar)
		hooksecurefunc(SCENARIO_CONTENT_TRACKER_MODULE, "AddProgressBar", self.UpdateProgressBar)
		hooksecurefunc(SCENARIO_TRACKER_MODULE, "AddProgressBar", self.UpdateProgressBar)
		hooksecurefunc(UI_WIDGET_TRACKER_MODULE, "AddProgressBar", self.UpdateProgressBar)
		hooksecurefunc("BonusObjectiveTrackerProgressBar_SetValue", self.UpdateProgressBarColors)
		hooksecurefunc("ObjectiveTrackerProgressBar_SetValue", self.UpdateProgressBarColors)
		hooksecurefunc("ScenarioTrackerProgressBar_SetValue", self.UpdateProgressBarColors)
		hooksecurefunc("QuestObjectiveSetupBlockButton_FindGroup", SkinGroupFindButton)
		hooksecurefunc("QuestObjectiveSetupBlockButton_AddRightButton", UpdatePositions)
		hooksecurefunc("AutoQuestPopupTracker_Update", self.UpdatePopup)
		hooksecurefunc("BonusObjectiveTracker_AnimateReward", self.SkinRewards)
	end

	function ObjectiveTracker:Toggle()
		if (ObjectiveTrackerFrame:IsVisible()) then
			ObjectiveTrackerFrame:Hide()
		else
			ObjectiveTrackerFrame:Show()
		end
	end

	function ObjectiveTracker:Enable()
		self:AddHooks()
		self:SetDefaultPosition()
		self:SkinScenario()

		-- Skin Minimize Button
		ObjectiveTrackerFrameHeaderMenuMinimizeButton:CreateBackdrop()
		ObjectiveTrackerFrameHeaderMenuMinimizeButton.Backdrop:CreateShadow()
		ObjectiveTrackerFrameHeaderMenuMinimizeButton.Backdrop:SetFrameLevel(ObjectiveTrackerFrameHeaderMenuMinimizeButton:GetFrameLevel() + 1)
		ObjectiveTrackerFrameHeaderMenuMinimizeButton.Backdrop.Texture = ObjectiveTrackerFrameHeaderMenuMinimizeButton.Backdrop:CreateTexture(nil, "OVERLAY")
		ObjectiveTrackerFrameHeaderMenuMinimizeButton.Backdrop.Texture:SetSize(10, 10)
		ObjectiveTrackerFrameHeaderMenuMinimizeButton.Backdrop.Texture:SetPoint("CENTER")
		ObjectiveTrackerFrameHeaderMenuMinimizeButton.Backdrop.Texture:SetTexture(C.Medias.ArrowUp)

		-- Add a keybind for toggling (SHIFT-O)
		self.ToggleButton = CreateFrame("Button", "TukuiObjectiveTrackerToggleButton", UIParent, "SecureActionButtonTemplate")
		self.ToggleButton:SetScript("OnClick", self.Toggle)

		SetOverrideBindingClick(self.ToggleButton, true, "SHIFT-O", "TukuiObjectiveTrackerToggleButton")
	end

	Misc.ObjectiveTracker = ObjectiveTracker
else
	local ObjectiveTracker = CreateFrame("Frame", nil, UIParent)
	local Misc = T["Miscellaneous"]
	local Movers = T["Movers"]
	local Class = select(2, UnitClass("player"))
	local CustomClassColor = T.Colors.class[Class]
	local QuestWatchFrame = QuestWatchFrame
	local Anchor1, Parent, Anchor2, X, Y = "TOPRIGHT", UIParent, "TOPRIGHT", -280, -400
	local ClickFrames = {}

	function ObjectiveTracker:CreateHolder()
		local ObjectiveFrameHolder = CreateFrame("Frame", "TukuiObjectiveTracker", UIParent)
		ObjectiveFrameHolder:SetSize(130, 22)
		ObjectiveFrameHolder:SetPoint(Anchor1, Parent, Anchor2, X, Y)

		self.Holder = ObjectiveFrameHolder
	end

	function ObjectiveTracker:SetDefaultPosition()
		local Data = TukuiDatabase.Variables[GetRealmName()][UnitName("Player")]
		local ObjectiveFrameHolder = self.Holder

		QuestWatchFrame:SetParent(ObjectiveFrameHolder)
		QuestWatchFrame:ClearAllPoints()
		QuestWatchFrame:SetPoint("TOPLEFT")

		if Data and Data.Move and Data.Move.TukuiObjectiveTracker then
			ObjectiveFrameHolder:ClearAllPoints()
			ObjectiveFrameHolder:SetPoint(unpack(Data.Move.TukuiObjectiveTracker))
		end

		Movers:RegisterFrame(ObjectiveFrameHolder)
	end

	function ObjectiveTracker:Skin()
		local HeaderBar = CreateFrame("StatusBar", nil, QuestWatchFrame)
		local HeaderText = HeaderBar:CreateFontString(nil, "OVERLAY")
		local Font = T.GetFont(C.Misc.ObjectiveTrackerFont)

		HeaderBar:SetSize(160, 2)
		HeaderBar:SetPoint("TOPLEFT", QuestWatchFrame, 0, -4)
		HeaderBar:SetStatusBarTexture(C.Medias.Blank)
		HeaderBar:SetStatusBarColor(unpack(CustomClassColor))
		HeaderBar:CreateBackdrop()
		HeaderBar:CreateShadow()

		HeaderText:SetFontObject(Font)
		HeaderText:SetPoint("LEFT", HeaderBar, "LEFT", -2, 14)
		HeaderText:SetText(CURRENT_QUESTS)

		-- Change font of watched quests
		for i = 1, 30 do
			local Line = _G["QuestWatchLine"..i]

			Line:SetFontObject(Font)
		end

		self.HeaderBar = HeaderBar
		self.HeaderText = HeaderText
	end

	function ObjectiveTracker:SkinQuestTimer()
		local Timer = QuestTimerFrame
		local HeaderBar = self.HeaderBar
		local HeaderTimerBar = CreateFrame("StatusBar", nil, QuestTimerFrame)

		HeaderTimerBar:SetSize(QuestWatchFrame:GetWidth(), 2)
		HeaderTimerBar:SetPoint("TOPLEFT", QuestWatchFrame, 0, 56)
		HeaderTimerBar:SetStatusBarTexture(C.Medias.Blank)
		HeaderTimerBar:SetStatusBarColor(unpack(CustomClassColor))
		HeaderTimerBar:CreateBackdrop()
		HeaderTimerBar:CreateShadow()

		Timer:StripTextures()
		Timer:SetParent(UIParent)
		Timer:ClearAllPoints()
		Timer:SetPoint("TOPLEFT", HeaderBar, "TOPLEFT", -205, 80)
	end

	function ObjectiveTracker:OnQuestClick()
		ShowUIPanel(QuestLogFrame)

		QuestLog_SetSelection(self.Quest)

		QuestLog_Update()
	end

	function ObjectiveTracker:SetClickFrame(index, quest, text)
		if not ClickFrames[index] then
			ClickFrames[index] = CreateFrame("Frame")
		end

		local Frame = ClickFrames[index]
		Frame:SetScript("OnMouseUp", self.OnQuestClick)

		Frame:SetAllPoints(text)
		Frame.Quest = quest
	end

	function ObjectiveTracker:AddQuestClick()
		local Index = 0
		local Toggle = ObjectiveTracker.Toggle

		-- Reset clicks
		for i = 1, 5 do
			local Frame = ClickFrames[i]

			if Frame then
				Frame:SetScript("OnMouseUp", nil)
			end
		end

		-- Set new clicks
		for i = 1, GetNumQuestWatches() do
			local Quest = GetQuestIndexForWatch(i)

			if Quest then
				local NumQuest = GetNumQuestLeaderBoards(Quest)

				if NumQuest > 0 then
					Index = Index + 1

					local Text = _G["QuestWatchLine"..Index]

					for j = 1, NumQuest do
						Index = Index + 1
					end

					ObjectiveTracker:SetClickFrame(i, Quest, Text)
				end
			end
		end

		-- Toggle display
		if Toggle then
			if GetNumQuestWatches() == 0 then
				Toggle:Hide()
			else
				Toggle:Show()
			end
		end
	end

	function ObjectiveTracker:AddToggle()
		local Button = CreateFrame("Button", nil, UIParent)
		local HeaderBar = self.HeaderBar
		local Holder = self.Holder

		Button:SetSize(20, 20)
		Button:SetPoint("BOTTOMRIGHT", HeaderBar, "TOPRIGHT", 5, 3)
		Button:SetScript("OnClick", function(self)
			if QuestWatchFrame:GetParent() == Holder then
				self.Texture:SetTexture(C.Medias.ArrowDown)

				QuestWatchFrame:SetParent(T.Hider)
			else
				self.Texture:SetTexture(C.Medias.ArrowUp)

				QuestWatchFrame:SetParent(Holder)
			end
		end)

		Button.Texture = Button:CreateTexture(nil, "OVERLAY")
		Button.Texture:SetSize(12, 12)
		Button.Texture:SetPoint("CENTER")
		Button.Texture:SetTexture(C.Medias.ArrowUp)

		self.Toggle = Button
	end

	function ObjectiveTracker:AddHooks()
		hooksecurefunc("QuestWatch_Update", self.AddQuestClick)
	end

	function ObjectiveTracker:Enable()
		if self.IsEnabled then
			return
		end

		self:CreateHolder()
		self:SetDefaultPosition()
		self:Skin()
		self:SkinQuestTimer()
		self:AddToggle()
		self:AddHooks()

		self.IsEnabled = true
	end

	Misc.ObjectiveTracker = ObjectiveTracker
end