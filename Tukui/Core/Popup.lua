local T, C, L = select(2, ...):unpack()

local TukuiPopups = CreateFrame("Frame")
local ACCEPT, CANCEL = ACCEPT, CANCEL
local ChatFontNormal = ChatFontNormal

TukuiPopups.Popup = {}
TukuiPopups.Frames = {}
TukuiPopups.Total = 4

function TukuiPopups:HidePopup()
	local Popup = self:GetParent()
	Popup:Hide()
end

function TukuiPopups:CreatePopups()
	for i = 1, TukuiPopups.Total do
		local Frames = TukuiPopups.Frames
		
		Frames[i] = CreateFrame("Frame", nil, UIParent)
		Frames[i]:SetSize(400, 60)
		Frames[i]:SetFrameLevel(3)
		Frames[i]:CreateShadow()
		Frames[i]:SetTemplate()
		Frames[i]:Hide()

		Frames[i].Text = CreateFrame("MessageFrame", nil, Frames[i])
		Frames[i].Text:SetPoint("CENTER")
		Frames[i].Text:SetSize(380, 40)
		Frames[i].Text:SetFont(C.Medias.Font, 12)
		Frames[i].Text:SetInsertMode("TOP")
		Frames[i].Text:SetFading(0)
		Frames[i].Text:AddMessage("")

		Frames[i].Button1 = CreateFrame("Button", nil, Frames[i])
		Frames[i].Button1:SetPoint("TOPLEFT", Frames[i], "BOTTOMLEFT", 0, -2)
		Frames[i].Button1:SetSize(199, 23)
		Frames[i].Button1:SetTemplate()
		Frames[i].Button1:CreateShadow()
		Frames[i].Button1:FontString("Text", C.Medias.Font, 12)
		Frames[i].Button1.Text:SetPoint("CENTER")
		Frames[i].Button1.Text:SetText(ACCEPT)
		Frames[i].Button1:SetScript("OnClick", TukuiPopups.HidePopup)
		Frames[i].Button1:HookScript("OnClick", TukuiPopups.HidePopup)
		Frames[i].Button1:SkinButton()

		Frames[i].Button2 = CreateFrame("Button", nil, Frames[i])
		Frames[i].Button2:SetPoint("TOPRIGHT", Frames[i], "BOTTOMRIGHT", 0, -2)
		Frames[i].Button2:SetSize(199, 23)
		Frames[i].Button2:SetTemplate("Default")
		Frames[i].Button2:CreateShadow("Default")
		Frames[i].Button2:FontString("Text", C.Medias.Font, 12)
		Frames[i].Button2.Text:SetPoint("CENTER")
		Frames[i].Button2.Text:SetText(CANCEL)
		Frames[i].Button2:SetScript("OnClick", TukuiPopups.HidePopup)
		Frames[i].Button2:HookScript("OnClick", TukuiPopups.HidePopup)
		Frames[i].Button2:SkinButton()
		
		Frames[i].EditBox = CreateFrame("EditBox", nil, Frames[i])
		Frames[i].EditBox:SetMultiLine(false)
		Frames[i].EditBox:EnableMouse(true)
		Frames[i].EditBox:SetAutoFocus(true)
		Frames[i].EditBox:SetFontObject(ChatFontNormal)
		Frames[i].EditBox:Width(380)
		Frames[i].EditBox:Height(16)
		Frames[i].EditBox:SetPoint("BOTTOM", Frames[i], 0, 12)
		Frames[i].EditBox:SetScript("OnEscapePressed", function() Frames[i]:Hide() end)
		Frames[i].EditBox:CreateBackdrop()
		Frames[i].EditBox.Backdrop:SetPoint("TOPLEFT", -4, 4)
		Frames[i].EditBox.Backdrop:SetPoint("BOTTOMRIGHT", 4, -4)
		Frames[i].EditBox:Hide()
		
		if (i == 1) then
			Frames[i].Anchor = CreateFrame("Frame", nil, Frames[i])
			Frames[i].Anchor:SetSize(360, 30)
			Frames[i].Anchor:SetPoint("BOTTOM", Frames[i], "TOP", 0, -2)
			Frames[i].Anchor:SetTemplate("Transparent")
			Frames[i].Anchor:SetFrameLevel(Frames[i]:GetFrameLevel() - 2)
			Frames[i]:SetPoint("TOP", UIParent, "TOP", 0, -10)
		else
			local Previous = Frames[i-1]
			Frames[i]:SetPoint("TOP", Previous, "BOTTOM", 0, -Frames[i].Button1:GetHeight() - 4)
		end
	end
end

function TukuiPopups:ShowPopup()
	local Info = TukuiPopups.Popup[self]
	
	if not Info then
		return
	end

	local Popups = TukuiPopups.Frames
	local Selection = Popups[1]
	for i = 1, TukuiPopups.Total - 1 do
		if Popups[i]:IsShown() then
			Selection = Popups[i + 1]
		end
	end

	local Popup = Selection
	local Question = Popup.Text
	local Button1 = Popup.Button1
	local Button2 = Popup.Button2
	local EditBox = Popup.EditBox
	
	Question:Clear()
	EditBox:SetText("")
	
	if Info.Question then
		Question:AddMessage(Info.Question)
	end
	
	if Info.Answer1 then
		Button1.Text:SetText(Info.Answer1)
	else
		Button1.Text:SetText(ACCEPT)
	end
	
	if Info.Answer2 then
		Button2.Text:SetText(Info.Answer2)
	else
		Button2.Text:SetText(CANCEL)
	end
	
	if Info.Function1 then
		Button1:SetScript("OnClick", Info.Function1)
	else
		Button1:SetScript("OnClick", TukuiPopups.HidePopup)
	end
	
	if Info.Function2 then
		Button2:SetScript("OnClick", Info.Function2)
	else
		Button2:SetScript("OnClick", TukuiPopups.HidePopup)
	end
	
	if Info.EditBox then
		EditBox:Show()
	else
		EditBox:Hide()
	end
	
	Button1:HookScript("OnClick", TukuiPopups.HidePopup)
	Button2:HookScript("OnClick", TukuiPopups.HidePopup)
	
	Popup:Show()
end

TukuiPopups:RegisterEvent("PLAYER_LOGIN")
TukuiPopups:SetScript("OnEvent", function(self, event)
	self:CreatePopups()
	self:UnregisterAllEvents()
end)

T["Popups"] = TukuiPopups