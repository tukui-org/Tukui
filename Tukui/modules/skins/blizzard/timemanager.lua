local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	TimeManagerFrame:StripTextures()
	TimeManagerFrame:SetTemplate("Default")

	T.SkinCloseButton(TimeManagerCloseButton)

	T.SkinDropDownBox(TimeManagerAlarmHourDropDown, 80)
	T.SkinDropDownBox(TimeManagerAlarmMinuteDropDown, 80)
	T.SkinDropDownBox(TimeManagerAlarmAMPMDropDown, 80)
	
	T.SkinEditBox(TimeManagerAlarmMessageEditBox)
	
	T.SkinButton(TimeManagerAlarmEnabledButton, true)
	TimeManagerAlarmEnabledButton:HookScript("OnClick", function(self)
		T.SkinButton(self)
	end)

	TimeManagerFrame:HookScript("OnShow", function(self)
		T.SkinButton(TimeManagerAlarmEnabledButton)
	end)		
	
	T.SkinCheckBox(TimeManagerMilitaryTimeCheck)
	T.SkinCheckBox(TimeManagerLocalTimeCheck)
	
	TimeManagerStopwatchFrame:StripTextures()
	TimeManagerStopwatchCheck:SetTemplate("Default")
	TimeManagerStopwatchCheck:GetNormalTexture():SetTexCoord(.08, .92, .08, .92)
	TimeManagerStopwatchCheck:GetNormalTexture():ClearAllPoints()
	TimeManagerStopwatchCheck:GetNormalTexture():Point("TOPLEFT", 2, -2)
	TimeManagerStopwatchCheck:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
	local hover = TimeManagerStopwatchCheck:CreateTexture("frame", nil, TimeManagerStopwatchCheck) -- hover
	hover:SetTexture(1,1,1,0.3)
	hover:Point("TOPLEFT",TimeManagerStopwatchCheck,2,-2)
	hover:Point("BOTTOMRIGHT",TimeManagerStopwatchCheck,-2,2)
	TimeManagerStopwatchCheck:SetHighlightTexture(hover)
	
	StopwatchFrame:StripTextures()
	StopwatchFrame:CreateBackdrop("Default")
	StopwatchFrame.backdrop:Point("TOPLEFT", 0, -17)
	StopwatchFrame.backdrop:Point("BOTTOMRIGHT", 0, 2)
	
	StopwatchTabFrame:StripTextures()
	T.SkinCloseButton(StopwatchCloseButton)
	T.SkinNextPrevButton(StopwatchPlayPauseButton)
	T.SkinNextPrevButton(StopwatchResetButton)
	StopwatchPlayPauseButton:Point("RIGHT", StopwatchResetButton, "LEFT", -4, 0)
	StopwatchResetButton:Point("BOTTOMRIGHT", StopwatchFrame, "BOTTOMRIGHT", -4, 6)
end

T.SkinFuncs["Blizzard_TimeManager"] = LoadSkin