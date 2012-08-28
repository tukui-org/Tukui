local T, C, L, G = unpack(select(2, ...))

T.CreatePopup = {}
local frame = {}
local total = 4

local function Hide(self)
	local popup = self:GetParent()
	popup:Hide()
end

-- Create the popups
for i = 1, total do
	frame[i] = CreateFrame("Frame", "TukuiPopupDialog"..i, UIParent)
	frame[i]:SetSize(400, 60)
	frame[i]:SetFrameLevel(3)
	frame[i]:CreateShadow("Default")
	frame[i]:SetTemplate("Default")
	frame[i]:Hide()

	frame[i].Text = CreateFrame("MessageFrame", nil, frame[i])
	frame[i].Text:SetPoint("CENTER")
	frame[i].Text:SetSize(380, 40)
	frame[i].Text:SetFont(C.media.font, 12)
	frame[i].Text:SetInsertMode("TOP")
	frame[i].Text:SetFading(0)
	frame[i].Text:AddMessage("")

	frame[i].button1 = CreateFrame("Button", "TukuiPopupDialogButtonAccept"..i, frame[i])
	frame[i].button1:SetPoint("TOPLEFT", frame[i], "BOTTOMLEFT", 0, -2)
	frame[i].button1:SetSize(199, 23)
	frame[i].button1:SetTemplate("Default")
	frame[i].button1:CreateShadow("Default")
	frame[i].button1:FontString("Text", C.media.font, 12)
	frame[i].button1.Text:SetPoint("CENTER")
	frame[i].button1.Text:SetText(ACCEPT)
	frame[i].button1:SetScript("OnClick", Hide)
	frame[i].button1:HookScript("OnClick", Hide)
	frame[i].button1:SkinButton()

	frame[i].button2 = CreateFrame("Button", "TukuiPopupDialogButtonCancel"..i, frame[i])
	frame[i].button2:SetPoint("TOPRIGHT", frame[i], "BOTTOMRIGHT", 0, -2)
	frame[i].button2:SetSize(199, 23)
	frame[i].button2:SetTemplate("Default")
	frame[i].button2:CreateShadow("Default")
	frame[i].button2:FontString("Text", C.media.font, 12)
	frame[i].button2.Text:SetPoint("CENTER")
	frame[i].button2.Text:SetText(CANCEL)
	frame[i].button2:SetScript("OnClick", Hide)
	frame[i].button2:HookScript("OnClick", Hide)
	frame[i].button2:SkinButton()
	
	frame[i].EditBox = CreateFrame("EditBox", "TukuiPopupDialogEditBox"..i, frame[i])
	frame[i].EditBox:SetMultiLine(false)
	frame[i].EditBox:EnableMouse(true)
	frame[i].EditBox:SetAutoFocus(true)
	frame[i].EditBox:SetFontObject(ChatFontNormal)
	frame[i].EditBox:Width(380)
	frame[i].EditBox:Height(16)
	frame[i].EditBox:SetPoint("BOTTOM", frame[i], 0, 12)
	frame[i].EditBox:SetScript("OnEscapePressed", function() frame[i]:Hide() end)
	frame[i].EditBox:CreateBackdrop()
	frame[i].EditBox.backdrop:SetPoint("TOPLEFT", -4, 4)
	frame[i].EditBox.backdrop:SetPoint("BOTTOMRIGHT", 4, -4)
	frame[i].EditBox:Hide()
	
	-- default position
	if i == 1 then
		-- create a panel which anchor popup #1 to top screen
		frame[i].Anchor = CreateFrame("Frame", nil, frame[i])
		frame[i].Anchor:SetSize(360, 30)
		frame[i].Anchor:SetPoint("BOTTOM", frame[i], "TOP", 0, -2)
		frame[i].Anchor:SetTemplate("Transparent")
		frame[i].Anchor:SetFrameLevel(frame[i]:GetFrameLevel() - 2)
		
		-- position popup #1
		frame[i]:SetPoint("TOP", UIParent, "TOP", 0, -10)
	else
		local previous = frame[i-1]
		frame[i]:SetPoint("TOP", previous, "BOTTOM", 0, -frame[i].button1:GetHeight() - 4)
	end	
end

T.ShowPopup = function(self)
	local info = T.CreatePopup[self]
	if not info then return end
	
	-- choose popup to show
	local selection = _G["TukuiPopupDialog1"]
	for i = 1, total - 1 do
		if frame[i]:IsShown() then
			selection = _G["TukuiPopupDialog"..i+1]
		end
	end

	local popup = selection
	local question = popup.Text
	local btn1 = popup.button1
	local btn2 = popup.button2
	local eb = popup.EditBox
	
	-- clear the question
	question:Clear()
	
	-- clear the editbox
	eb:SetText("")
	
	-- add the question asked if found
	if info.question then
		question:AddMessage(info.question)
	end
	
	-- insert wanted text into left button
	if info.answer1 then
		btn1.Text:SetText(info.answer1)
	else
		btn1.Text:SetText(ACCEPT)
	end
	
	-- insert wanted text into right button
	if info.answer2 then
		btn2.Text:SetText(info.answer2)
	else
		btn2.Text:SetText(CANCEL)
	end
	
	-- execute a function on button 1 if defined by the coder
	if info.function1 then
		btn1:SetScript("OnClick", info.function1)
	else
		btn1:SetScript("OnClick", Hide)
	end
	
	-- execute a function on button 2 if defined by the coder
	if info.function2 then
		btn2:SetScript("OnClick", info.function2)
	else
		btn2:SetScript("OnClick", Hide)
	end
	
	if info.editbox then
		eb:Show()
	else
		eb:Hide()
	end
	
	-- always hide the popup after a click
	btn1:HookScript("OnClick", Hide)
	btn2:HookScript("OnClick", Hide)
	
	-- show it when we ask for it
	popup:Show()
end