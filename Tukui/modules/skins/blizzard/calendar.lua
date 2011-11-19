local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	local frames = {
		"CalendarFrame",
	}
	
	for _, frame in pairs(frames) do
		_G[frame]:StripTextures()
	end
	
	CalendarFrame:SetTemplate("Default")
	T.SkinCloseButton(CalendarCloseButton)
	CalendarCloseButton:Point("TOPRIGHT", CalendarFrame, "TOPRIGHT", -4, -4)
	
	T.SkinNextPrevButton(CalendarPrevMonthButton)
	T.SkinNextPrevButton(CalendarNextMonthButton)
	
	do --Handle drop down button, this one is differant than the others
		local frame = CalendarFilterFrame
		local button = CalendarFilterButton

		frame:StripTextures()
		frame:Width(155)
		
		_G[frame:GetName().."Text"]:ClearAllPoints()
		_G[frame:GetName().."Text"]:Point("RIGHT", button, "LEFT", -2, 0)

		
		button:ClearAllPoints()
		button:Point("RIGHT", frame, "RIGHT", -10, 3)
		button.SetPoint = T.dummy
		
		T.SkinNextPrevButton(button, true)
		
		frame:CreateBackdrop("Default")
		frame.backdrop:Point("TOPLEFT", 20, 2)
		frame.backdrop:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
	end
	
	
	--backdrop
	local bg = CreateFrame("Frame", "CalendarFrameBackdrop", CalendarFrame)
	bg:SetTemplate("Default")
	bg:Point("TOPLEFT", 10, -72)
	bg:Point("BOTTOMRIGHT", -8, 3)
	
	CalendarContextMenu:SetTemplate("Default")
	CalendarContextMenu.SetBackdropColor = T.dummy
	CalendarContextMenu.SetBackdropBorderColor = T.dummy
	
	CalendarInviteStatusContextMenu:SetTemplate("Default")
	CalendarInviteStatusContextMenu.SetBackdropColor = T.dummy
	CalendarInviteStatusContextMenu.SetBackdropBorderColor = T.dummy
	
	--Boost frame levels
	for i=1, 42 do
		_G["CalendarDayButton"..i]:SetFrameLevel(_G["CalendarDayButton"..i]:GetFrameLevel() + 1)
	end
	
	--CreateEventFrame
	CalendarCreateEventFrame:StripTextures()
	CalendarCreateEventFrame:SetTemplate("Default")
	CalendarCreateEventFrame:Point("TOPLEFT", CalendarFrame, "TOPRIGHT", 3, -24)
	CalendarCreateEventTitleFrame:StripTextures()
	
	T.SkinButton(CalendarCreateEventCreateButton, true)
	T.SkinButton(CalendarCreateEventMassInviteButton, true)
	T.SkinButton(CalendarCreateEventInviteButton, true)
	CalendarCreateEventInviteButton:Point("TOPLEFT", CalendarCreateEventInviteEdit, "TOPRIGHT", 4, 1)
	CalendarCreateEventInviteEdit:Width(CalendarCreateEventInviteEdit:GetWidth() - 2)
	
	CalendarCreateEventInviteList:StripTextures()
	CalendarCreateEventInviteList:SetTemplate("Default")
	
	T.SkinEditBox(CalendarCreateEventInviteEdit)
	T.SkinEditBox(CalendarCreateEventTitleEdit)
	T.SkinDropDownBox(CalendarCreateEventTypeDropDown, 120)
	
	CalendarCreateEventDescriptionContainer:StripTextures()
	CalendarCreateEventDescriptionContainer:SetTemplate("Default")
	
	T.SkinCloseButton(CalendarCreateEventCloseButton)
	CalendarCreateEventCloseButton:StripTextures()
	
	T.SkinCheckBox(CalendarCreateEventLockEventCheck)
	
	T.SkinDropDownBox(CalendarCreateEventHourDropDown, 68)
	T.SkinDropDownBox(CalendarCreateEventMinuteDropDown, 68)
	T.SkinDropDownBox(CalendarCreateEventAMPMDropDown, 68)
	T.SkinDropDownBox(CalendarCreateEventRepeatOptionDropDown, 120)
	CalendarCreateEventIcon:SetTexCoord(.08, .92, .08, .92)
	CalendarCreateEventIcon.SetTexCoord = T.dummy
	
	CalendarCreateEventInviteListSection:StripTextures()
	
	CalendarClassButtonContainer:HookScript("OnShow", function()
		for i, class in ipairs(CLASS_SORT_ORDER) do
			local button = _G["CalendarClassButton"..i]
			button:StripTextures()
			button:CreateBackdrop("Default")
			
			local tcoords = CLASS_ICON_TCOORDS[class]
			local buttonIcon = button:GetNormalTexture()
			buttonIcon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
			buttonIcon:SetTexCoord(tcoords[1] + 0.015, tcoords[2] - 0.02, tcoords[3] + 0.018, tcoords[4] - 0.02) --F U C K I N G H A X
		end
		
		CalendarClassButton1:Point("TOPLEFT", CalendarClassButtonContainer, "TOPLEFT", 5, 0)
		
		CalendarClassTotalsButton:StripTextures()
		CalendarClassTotalsButton:CreateBackdrop("Default")
	end)
	
	--Texture Picker Frame
	CalendarTexturePickerFrame:StripTextures()
	CalendarTexturePickerTitleFrame:StripTextures()
	
	CalendarTexturePickerFrame:SetTemplate("Default")
	
	T.SkinScrollBar(CalendarTexturePickerScrollBar)
	T.SkinButton(CalendarTexturePickerAcceptButton, true)
	T.SkinButton(CalendarTexturePickerCancelButton, true)
	T.SkinButton(CalendarCreateEventInviteButton, true)
	T.SkinButton(CalendarCreateEventRaidInviteButton, true)
	
	--Mass Invite Frame
	CalendarMassInviteFrame:StripTextures()
	CalendarMassInviteFrame:SetTemplate("Default")
	CalendarMassInviteTitleFrame:StripTextures()
	
	T.SkinCloseButton(CalendarMassInviteCloseButton)
	T.SkinButton(CalendarMassInviteGuildAcceptButton)
	T.SkinButton(CalendarMassInviteArenaButton2)
	T.SkinButton(CalendarMassInviteArenaButton3)
	T.SkinButton(CalendarMassInviteArenaButton5)
	T.SkinDropDownBox(CalendarMassInviteGuildRankMenu, 130)
	
	T.SkinEditBox(CalendarMassInviteGuildMinLevelEdit)
	T.SkinEditBox(CalendarMassInviteGuildMaxLevelEdit)
	
	--Raid View
	CalendarViewRaidFrame:StripTextures()
	CalendarViewRaidFrame:SetTemplate("Default")
	CalendarViewRaidFrame:Point("TOPLEFT", CalendarFrame, "TOPRIGHT", 3, -24)
	CalendarViewRaidTitleFrame:StripTextures()
	T.SkinCloseButton(CalendarViewRaidCloseButton)
	CalendarViewRaidCloseButton:StripTextures()
	
	--Holiday View
	CalendarViewHolidayFrame:StripTextures(true)
	CalendarViewHolidayFrame:SetTemplate("Default")
	CalendarViewHolidayFrame:Point("TOPLEFT", CalendarFrame, "TOPRIGHT", 3, -24)
	CalendarViewHolidayTitleFrame:StripTextures()
	T.SkinCloseButton(CalendarViewHolidayCloseButton)
	CalendarViewHolidayCloseButton:StripTextures()
	
	-- Event View
	CalendarViewEventFrame:StripTextures()
	CalendarViewEventFrame:SetTemplate("Default")
	CalendarViewEventFrame:Point("TOPLEFT", CalendarFrame, "TOPRIGHT", 3, -24)
	CalendarViewEventTitleFrame:StripTextures()
	CalendarViewEventDescriptionContainer:StripTextures()
	CalendarViewEventDescriptionContainer:SetTemplate("Default")
	CalendarViewEventInviteList:StripTextures()
	CalendarViewEventInviteList:SetTemplate("Default")
	CalendarViewEventInviteListSection:StripTextures()
	T.SkinCloseButton(CalendarViewEventCloseButton)
	CalendarViewEventCloseButton:StripTextures()
	
	T.SkinScrollBar(CalendarViewEventInviteListScrollFrameScrollBar)

	local buttons = {
		"CalendarViewEventAcceptButton",
		"CalendarViewEventTentativeButton",
		"CalendarViewEventRemoveButton",
		"CalendarViewEventDeclineButton",
	}

	for _, button in pairs(buttons) do
		T.SkinButton(_G[button])
	end		
	
	-- too many event same day box
    CalendarEventPickerFrame:StripTextures()
	CalendarEventPickerFrame:SetTemplate("Default")
	CalendarEventPickerTitleFrame:StripTextures()

	T.SkinScrollBar(CalendarEventPickerScrollBar)

	CalendarEventPickerCloseButton:StripTextures()
	T.SkinButton(CalendarEventPickerCloseButton, true)
	T.SkinScrollBar(CalendarCreateEventDescriptionScrollFrameScrollBar)
end

T.SkinFuncs["Blizzard_Calendar"] = LoadSkin