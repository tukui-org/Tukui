local T, C, L = select(2, ...):unpack()
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

function ObjectiveTracker:Disable()
	ObjectiveTrackerFrameHeaderMenuMinimizeButton:Hide()
end

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

function ObjectiveTracker:CreateToggleButtons()
	local Button = CreateFrame("Button", nil, UIParent)
	
	Button:SetSize(216, 32)
	Button:SetAlpha(0)
	Button:CreateBackdrop()
	Button:SetPoint("TOPLEFT", ObjectiveTrackerFrame, -25, 24)
	Button:RegisterForClicks("AnyUp")
	Button:SetScript("OnClick", self.OnClick)
	Button:SetScript("OnEnter", self.OnEnter)
	Button:SetScript("OnLeave", self.OnLeave)
	
	Button.Backdrop:SetInside(Button, 0, 19)
	Button.Backdrop:SetBackdropColor(unpack(T.Colors.class[T.MyClass]))
	Button.Backdrop:CreateShadow()

	Button.Toggle = Button:CreateFontString(nil, "OVERLAY")
	Button.Toggle:SetFont(C.Medias.Font, 12, "OUTLINE")
	Button.Toggle:SetSize(214, 32)
	Button.Toggle:SetPoint("RIGHT")
	Button.Toggle:SetText(BINDING_NAME_TOGGLEQUESTLOG)
end

function ObjectiveTracker:SetDefaultPosition()
	local Anchor1, Parent, Anchor2, X, Y = "TOPRIGHT", UIParent, "TOPRIGHT", -228, -325
	local Data = TukuiData[T.MyRealm][T.MyName]

	local ObjectiveFrameHolder = CreateFrame("Frame", "TukuiObjectiveTracker", UIParent)
	ObjectiveFrameHolder:SetSize(130, 22)
	ObjectiveFrameHolder:SetPoint(Anchor1, Parent, Anchor2, X, Y)

	ObjectiveTrackerFrame:ClearAllPoints()
	ObjectiveTrackerFrame:SetPoint("TOP", ObjectiveFrameHolder)
	ObjectiveTrackerFrame:SetHeight(396)
	ObjectiveTrackerFrame.IsUserPlaced = function() return true end

	Movers:RegisterFrame(ObjectiveFrameHolder)

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

function ObjectiveTracker:SkinScenario()
	local StageBlock = _G["ScenarioStageBlock"]

	StageBlock.NormalBG:SetTexture("")
	StageBlock.FinalBG:SetTexture("")
	StageBlock.Stage:SetFont(C.Medias.Font, 17)
	StageBlock.GlowTexture:SetTexture("")
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

			Bar:SetHeight(20)
			Bar:SetStatusBarTexture(Texture)
			Bar:CreateBackdrop()
			Bar.Backdrop:CreateShadow()
			Bar.Backdrop:SetFrameStrata("BACKGROUND")
			Bar.Backdrop:SetFrameLevel(1)
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
		local R, G, B = T.ColorGradient(Min, 100, 0.8, 0, 0, 0.8, 0.8, 0, 0, 0.8, 0)
		
		self.Bar:SetStatusBarColor(R, G, B)
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

function ObjectiveTracker:UpdatePOI()
	if self:GetParent() ~= ObjectiveTrackerBlocksFrame then
		return
	end
	
	if not self.IsSkinned then
		self.NormalTexture:SetTexture("")
		self.PushedTexture:SetTexture("")
		self.HighlightTexture:SetTexture("")
		self:CreateBackdrop()
		self.Backdrop:SetFrameLevel(0)
		self.Backdrop:SetOutside()
		self:StyleButton()
		self.Backdrop:CreateShadow()

		self.IsSkinned = true	
	end
	
	if self.Glow then
		self.Glow:SetAlpha(0)
	end
	
	if self.NormalTexture then
		self.NormalTexture:SetAlpha(0)
	end
	
	if self.selected then
		local R, G, B = unpack(T.Colors.class[T.MyClass])
		
		self.Backdrop.Shadow:SetBackdropBorderColor(R, G, B)
		self.Backdrop:SetBackdropColor(0/255, 152/255, 34/255, 1)
	else
		self.Backdrop.Shadow:SetBackdropBorderColor(unpack(C.Medias.BorderColor))
		self.Backdrop:SetBackdropColor(unpack(C.Medias.BackdropColor))
	end
	
	if self.style == "numeric" then
		self.Display:SetNumber(self.index)
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

function ObjectiveTracker:AddHooks()
	hooksecurefunc("ObjectiveTracker_Update", self.Skin)
	hooksecurefunc("ScenarioBlocksFrame_OnLoad", self.SkinScenario)
	hooksecurefunc(SCENARIO_CONTENT_TRACKER_MODULE, "Update", self.SkinScenario)
	hooksecurefunc(QUEST_TRACKER_MODULE, "SetBlockHeader", self.UpdateQuestItem)
	hooksecurefunc(WORLD_QUEST_TRACKER_MODULE, "AddObjective", self.UpdateQuestItem)
	hooksecurefunc(CAMPAIGN_QUEST_TRACKER_MODULE, "AddObjective", self.UpdateQuestItem)
	hooksecurefunc(CAMPAIGN_QUEST_TRACKER_MODULE, "AddProgressBar", self.UpdateProgressBar)
	hooksecurefunc(QUEST_TRACKER_MODULE, "AddProgressBar", self.UpdateProgressBar)
	hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddProgressBar", self.UpdateProgressBar)
	hooksecurefunc(BONUS_OBJECTIVE_TRACKER_MODULE, "AddProgressBar", self.UpdateProgressBar)
	hooksecurefunc(WORLD_QUEST_TRACKER_MODULE, "AddProgressBar", self.UpdateProgressBar)
	hooksecurefunc(SCENARIO_TRACKER_MODULE, "AddProgressBar", self.UpdateProgressBar)
	hooksecurefunc("BonusObjectiveTrackerProgressBar_SetValue", self.UpdateProgressBarColors)
	hooksecurefunc("ObjectiveTrackerProgressBar_SetValue", self.UpdateProgressBarColors)
	hooksecurefunc("ScenarioTrackerProgressBar_SetValue", self.UpdateProgressBarColors)
	hooksecurefunc("QuestObjectiveSetupBlockButton_FindGroup", SkinGroupFindButton)
	hooksecurefunc("QuestObjectiveSetupBlockButton_AddRightButton", UpdatePositions)
	hooksecurefunc("AutoQuestPopupTracker_Update", self.UpdatePopup)
	hooksecurefunc("BonusObjectiveTracker_AnimateReward", self.SkinRewards)
	hooksecurefunc("QuestPOI_UpdateButtonStyle", self.UpdatePOI)
end

function ObjectiveTracker:Enable()
	OBJECTIVE_TRACKER_COLOR["Header"] = {
		r = ClassColor[1], 
		g = ClassColor[2], 
		b = ClassColor[3],
	}
	
	OBJECTIVE_TRACKER_COLOR["HeaderHighlight"] = {
		r = ClassColor[1]*1.2, 
		g = ClassColor[2]*1.2, 
		b = ClassColor[3]*1.2,
	}
	
	OBJECTIVE_TRACKER_COLOR["Complete"] = { 
		r = 0, 
		g = 1, 
		b = 0,
	}
	
	OBJECTIVE_TRACKER_COLOR["Normal"] = { 
		r = 1, 
		g = 1, 
		b = 1,
	}

	self:AddHooks()
	self:Disable()
	self:CreateToggleButtons()
	self:SetDefaultPosition()
	self:SkinScenario()
end

Misc.ObjectiveTracker = ObjectiveTracker