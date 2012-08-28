local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	local frames = {
		"CalendarFrame",
	}
	
	for _, frame in pairs(frames) do
		_G[frame]:StripTextures()
	end
	
	CalendarFrame:SetTemplate("Default")
	CalendarCloseButton:SkinCloseButton()
	CalendarCloseButton:Point("TOPRIGHT", CalendarFrame, "TOPRIGHT", -4, -4)
	
	CalendarPrevMonthButton:SkinNextPrevButton()
	CalendarNextMonthButton:SkinNextPrevButton()
	
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
		
		button:SkinNextPrevButton(true)
		
		frame:CreateBackdrop("Default")
		frame.backdrop:Point("TOPLEFT", 20, 2)
		frame.backdrop:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
	end

	CalendarContextMenu:SetTemplate("Default")
	CalendarContextMenu.SetBackdropColor = T.dummy
	CalendarContextMenu.SetBackdropBorderColor = T.dummy
	
	CalendarInviteStatusContextMenu:SetTemplate("Default")
	CalendarInviteStatusContextMenu.SetBackdropColor = T.dummy
	CalendarInviteStatusContextMenu.SetBackdropBorderColor = T.dummy
	
	--Boost frame levels
	for i=1, 42 do
		_G["CalendarDayButton"..i]:SetFrameLevel(_G["CalendarDayButton"..i]:GetFrameLevel() + 1)
		_G["CalendarDayButton"..i]:StripTextures()
		_G["CalendarDayButton"..i]:SetTemplate("Default")
		_G["CalendarDayButton"..i.."OverlayFrame"]:SetAlpha(0)
		_G["CalendarDayButton"..i.."DarkFrame"]:StripTextures()
		_G["CalendarDayButton"..i.."EventTexture"]:SetAlpha(0)
		for j=1, 4 do
			local b = _G["CalendarDayButton"..i.."EventButton"..j]
			b:StripTextures()
			b:StyleButton()
		end
	end
	
	CalendarTodayFrame:StripTextures()
	CalendarTodayFrame:Size(CalendarDayButton1:GetWidth(), CalendarDayButton1:GetHeight())
	CalendarTodayFrame:SetTemplate("Default")
	CalendarTodayFrame:HideInsets()
	CalendarTodayFrame:SetBackdropBorderColor(0, 1, 0, 1)
	CalendarTodayFrame:SetBackdropColor(0, 1, 0, 0.2)
	
	
	--CreateEventFrame
	CalendarCreateEventFrame:StripTextures()
	CalendarCreateEventFrame:SetTemplate("Default")
	CalendarCreateEventFrame:Point("TOPLEFT", CalendarFrame, "TOPRIGHT", 3, -24)
	CalendarCreateEventTitleFrame:StripTextures()
	
	CalendarCreateEventCreateButton:SkinButton(true)
	CalendarCreateEventMassInviteButton:SkinButton(true)
	CalendarCreateEventInviteButton:SkinButton(true)
	CalendarCreateEventInviteButton:Point("TOPLEFT", CalendarCreateEventInviteEdit, "TOPRIGHT", 4, 1)
	CalendarCreateEventInviteEdit:Width(CalendarCreateEventInviteEdit:GetWidth() - 2)
	
	CalendarCreateEventInviteList:StripTextures()
	CalendarCreateEventInviteList:SetTemplate("Default")
	
	CalendarCreateEventInviteEdit:SkinEditBox()
	CalendarCreateEventTitleEdit:SkinEditBox()
	CalendarCreateEventTypeDropDown:SkinDropDownBox(120)
	
	CalendarCreateEventDescriptionContainer:StripTextures()
	CalendarCreateEventDescriptionContainer:SetTemplate("Default")
	
	CalendarCreateEventCloseButton:SkinCloseButton()
	CalendarCreateEventCloseButton:StripTextures()
	
	CalendarCreateEventLockEventCheck:SkinCheckBox()
	
	CalendarCreateEventHourDropDown:SkinDropDownBox(68)
	CalendarCreateEventMinuteDropDown:SkinDropDownBox(68)
	CalendarCreateEventAMPMDropDown:SkinDropDownBox(68)
	CalendarCreateEventRepeatOptionDropDown:SkinDropDownBox(120)
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
	
	CalendarTexturePickerScrollBar:SkinScrollBar()
	CalendarTexturePickerAcceptButton:SkinButton(true)
	CalendarTexturePickerCancelButton:SkinButton(true)
	CalendarCreateEventInviteButton:SkinButton(true)
	CalendarCreateEventRaidInviteButton:SkinButton(true)
	
	--Mass Invite Frame
	CalendarMassInviteFrame:StripTextures()
	CalendarMassInviteFrame:SetTemplate("Default")
	CalendarMassInviteTitleFrame:StripTextures()
	
	CalendarMassInviteCloseButton:SkinCloseButton()
	CalendarMassInviteGuildAcceptButton:SkinButton()
	CalendarMassInviteArenaButton2:SkinButton()
	CalendarMassInviteArenaButton3:SkinButton()
	CalendarMassInviteArenaButton5:SkinButton()
	CalendarMassInviteGuildRankMenu:SkinDropDownBox(130)
	
	CalendarMassInviteGuildMinLevelEdit:SkinEditBox()
	CalendarMassInviteGuildMaxLevelEdit:SkinEditBox()
	
	--Raid View
	CalendarViewRaidFrame:StripTextures()
	CalendarViewRaidFrame:SetTemplate("Default")
	CalendarViewRaidFrame:Point("TOPLEFT", CalendarFrame, "TOPRIGHT", 3, -24)
	CalendarViewRaidTitleFrame:StripTextures()
	CalendarViewRaidCloseButton:SkinCloseButton()
	CalendarViewRaidCloseButton:StripTextures()
	
	--Holiday View
	CalendarViewHolidayFrame:StripTextures(true)
	CalendarViewHolidayFrame:SetTemplate("Default")
	CalendarViewHolidayFrame:Point("TOPLEFT", CalendarFrame, "TOPRIGHT", 3, -24)
	CalendarViewHolidayTitleFrame:StripTextures()
	CalendarViewHolidayCloseButton:SkinCloseButton()
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
	CalendarViewEventCloseButton:SkinCloseButton()
	CalendarViewEventCloseButton:StripTextures()
	
	CalendarViewEventInviteListScrollFrameScrollBar:SkinScrollBar()

	local buttons = {
		"CalendarViewEventAcceptButton",
		"CalendarViewEventTentativeButton",
		"CalendarViewEventRemoveButton",
		"CalendarViewEventDeclineButton",
	}

	for _, button in pairs(buttons) do
		_G[button]:SkinButton()
	end		
	
	-- too many event same day box
    CalendarEventPickerFrame:StripTextures()
	CalendarEventPickerFrame:SetTemplate("Default")
	CalendarEventPickerTitleFrame:StripTextures()

	CalendarEventPickerScrollBar:SkinScrollBar()

	CalendarEventPickerCloseButton:StripTextures()
	CalendarEventPickerCloseButton:SkinButton(true)
	CalendarCreateEventDescriptionScrollFrameScrollBar:SkinScrollBar()
end

T.SkinFuncs["Blizzard_Calendar"] = LoadSkin