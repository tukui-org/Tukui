local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local ObjectiveTracker = CreateFrame("Frame", "TukuiObjectiveTracker", UIParent)
local Noop = function() end

function ObjectiveTracker:SetQuestItemButton(block)
	local Button = block.itemButton
	
	if (Button and not Button.IsSkinned) then
		local Icon = Button.icon
		
		Button:SkinButton()
		Button:StyleButton()
		
		Icon:SetTexCoord(.1,.9,.1,.9)
		Icon:SetInside()
		
		Button.isSkinned = true
	end
end

function ObjectiveTracker:UpdatePopup()
	for i = 1, GetNumAutoQuestPopUps() do
		local questID, popUpType = GetAutoQuestPopUp(i);
		local questTitle, level, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, _ = GetQuestLogTitle(GetQuestLogIndexByID(questID));
		
		if ( questTitle and questTitle ~= "" ) then
			local Block = AUTO_QUEST_POPUP_TRACKER_MODULE:GetBlock(questID)
			local ScrollChild = Block.ScrollChild
			
			if not ScrollChild.IsSkinned then
				ScrollChild:StripTextures()
				ScrollChild:CreateBackdrop("Transparent")
				ScrollChild.Backdrop:Point("TOPLEFT", ScrollChild, "TOPLEFT", 48, -2)
				ScrollChild.Backdrop:Point("BOTTOMRIGHT", ScrollChild, "BOTTOMRIGHT", -1, 2)
				ScrollChild.FlashFrame.IconFlash:Kill()
				ScrollChild.IsSkinned = true
			end
		end
	end
end

function ObjectiveTracker:SetTrackerPosition()
	ObjectiveTrackerFrame:SetPoint("TOPRIGHT", ObjectiveTracker)
end

function ObjectiveTracker:AddHooks()
	hooksecurefunc(QUEST_TRACKER_MODULE, "SetBlockHeader", self.SetQuestItemButton) -- TAINTING?!?
	hooksecurefunc(AUTO_QUEST_POPUP_TRACKER_MODULE, "Update", self.UpdatePopup)
end

function ObjectiveTracker:Minimize()
	local Button = self
	local Text = self.Text
	local Value = Text:GetText()
	
	if (Value and Value == "X") then
		Text:SetText("V")
	else
		Text:SetText("X")
	end
end

function ObjectiveTracker:Enable()
	local Movers = T["Movers"]
	local Frame = ObjectiveTrackerFrame
	local Minimize = ObjectiveTrackerFrame.HeaderMenu.MinimizeButton
	local ScenarioStageBlock = ScenarioStageBlock
	local Data = TukuiData[GetRealmName()][UnitName("Player")]
	local Anchor1, Parent, Anchor2, X, Y = "TOPRIGHT", UIParent, "TOPRIGHT", -T.ScreenHeight / 5, -T.ScreenHeight / 4
	
	self:Size(235, 23)
	self:SetPoint(Anchor1, Parent, Anchor2, X, Y)
	self:AddHooks()
	self.SetTrackerPosition(Frame)

	Movers:RegisterFrame(self)
	Movers:SaveDefaults(self, Anchor1, Parent, Anchor2, X, Y)

	if Data and Data.Move and Data.Move.TukuiObjectiveTracker then
		self:ClearAllPoints()
		self:SetPoint(unpack(Data.Move.TukuiObjectiveTracker))
	end
	
	for i = 1, 5 do
		local Module = ObjectiveTrackerFrame.MODULES[i]

		if Module then
			local Header = Module.Header

			Header:StripTextures()
			Header:Show()
		end
	end
	
	ScenarioStageBlock:StripTextures()
	ScenarioStageBlock:SetHeight(50)
	
	Minimize:StripTextures()
	Minimize:FontString("Text", C.Medias.Font, 12, "OUTLINE")
	Minimize.Text:Point("CENTER", Minimize)
	Minimize.Text:SetText("X")
	Minimize:HookScript("OnClick", ObjectiveTracker.Minimize)
	
	Frame.ClearAllPoints = function() end
	Frame.SetPoint = function() end
end

Miscellaneous.ObjectiveTracker = ObjectiveTracker