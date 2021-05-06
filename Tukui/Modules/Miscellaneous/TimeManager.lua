local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local Movers = T["Movers"]
local TimeManager = CreateFrame("Frame")

function TimeManager:OnEvent(event, addon)
	if addon ~= "Blizzard_TimeManager" then
		return
	end
	
	if T.Retail then
		TimeManagerFrame.NineSlice:SetAlpha(0)
	end
	
	TimeManagerFrame:ClearAllPoints()
	TimeManagerFrame:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", -8, -40)
	
	TimeManagerFrame.TitleBg:SetAlpha(0)
	
	TimeManagerFrame:StripTextures()
	TimeManagerFrame:StripTexts()
	TimeManagerFrame:CreateBackdrop()
	
	TimeManagerFrameTicker:ClearAllPoints()
	TimeManagerFrameTicker:SetPoint("TOPLEFT", 0, -6)
	
	TimeManagerFrame.Backdrop:SetOutside(TimeManagerFrame, 10, 10)
	TimeManagerFrame.Backdrop:CreateShadow()
	
	TimeManagerFrameBg:SetAlpha(0)
	TimeManagerFrameInset:SetAlpha(0)
	
	TimeManagerFrameCloseButton:SkinCloseButton()
	
	StopwatchFrame:StripTextures()
	StopwatchFrame:CreateBackdrop()
	StopwatchFrame.Backdrop:ClearAllPoints()
	StopwatchFrame.Backdrop:SetPoint("LEFT", 0, 0)
	StopwatchFrame.Backdrop:SetPoint("TOP", 0, -14)
	StopwatchFrame.Backdrop:SetPoint("RIGHT", 0, 0)
	StopwatchFrame.Backdrop:SetPoint("BOTTOM", 0, 0)
	StopwatchFrame.Backdrop:CreateShadow()
	
	StopwatchTabFrame:StripTextures()
	
	StopwatchCloseButton:SkinCloseButton()
	
	StopwatchPlayPauseButton:StripTextures()
	StopwatchPlayPauseButton.Text = StopwatchPlayPauseButton:CreateFontString(nil, "OVERLAY")
	StopwatchPlayPauseButton.Text:SetAllPoints()
	StopwatchPlayPauseButton.Text:SetPoint("CENTER")
	StopwatchPlayPauseButton.Text:SetFont(C.Medias.Font, 32, "OUTLINE")
	StopwatchPlayPauseButton.Text:SetText("+")
	StopwatchPlayPauseButton.SetNormalTexture = function() return end
	
	StopwatchResetButton:StripTextures()
	StopwatchResetButton.Text = StopwatchResetButton:CreateFontString(nil, "OVERLAY")
	StopwatchResetButton.Text:SetAllPoints()
	StopwatchResetButton.Text:SetPoint("CENTER")
	StopwatchResetButton.Text:SetFont(C.Medias.Font, 32, "OUTLINE")
	StopwatchResetButton.Text:SetText("-")
	StopwatchResetButton.SetNormalTexture = function() return end
	
	TimeManagerAlarmHourDropDown:SkinDropDown()
	TimeManagerAlarmHourDropDown:SetWidth(80)
	TimeManagerAlarmMinuteDropDown:SkinDropDown()
	TimeManagerAlarmMinuteDropDown:SetWidth(80)
	TimeManagerAlarmAMPMDropDown:SkinDropDown()
	TimeManagerAlarmAMPMDropDown:SetWidth(80)
	
	TimeManagerAlarmMessageEditBox:SkinEditBox()
	
	TimeManagerStopwatchFrame:StripTextures()
	TimeManagerStopwatchCheck:CreateBackdrop()
	TimeManagerStopwatchCheck:GetNormalTexture():SetTexCoord(unpack(T.IconCoord))
	TimeManagerStopwatchCheck:GetNormalTexture():SetInside()
	
	TimeManagerAlarmEnabledButton:SkinCheckBox()
	TimeManagerMilitaryTimeCheck:SkinCheckBox()
	TimeManagerLocalTimeCheck:SkinCheckBox()
	
	TimeManagerAlarmMessageEditBox.Left:SetAlpha(0)
	TimeManagerAlarmMessageEditBox.Middle:SetAlpha(0)
	TimeManagerAlarmMessageEditBox.Right:SetAlpha(0)
	TimeManagerAlarmMessageEditBox:SkinEditBox()
	
	self:UnregisterAllEvents()
end

function TimeManager:Enable()
	if TimeManagerFrame then
		self:OnEvent("ADDON_LOADED", "Blizzard_TimeManager")
	else
		self:RegisterEvent("ADDON_LOADED")
		self:SetScript("OnEvent", self.OnEvent)
	end
end

Miscellaneous.TimeManager = TimeManager