local T, C, L = select(2, ...):unpack()

if (not C.Chat.Enable) then
	return
end

local TukuiChat = T["Chat"]
local Lines = {}
local CopyFrame

function TukuiChat:GetLines(...)
	local Count = 1

	for i = select("#", ...), 1, -1 do
		local Region = select(i, ...)

		if (Region:GetObjectType() == "FontString") then
			Lines[Count] = tostring(Region:GetText())
			Count = Count + 1
		end
	end

	return Count - 1
end

function TukuiChat:CopyText(chatframe)
	local _, Size = chatframe:GetFont()
	FCF_SetChatWindowFontSize(chatframe, chatframe, 0.01)
	local LineCount = self:GetLines(chatframe:GetRegions())
	local Text = table.concat(Lines, "\n", 1, LineCount)
	FCF_SetChatWindowFontSize(chatframe, chatframe, Size)

	if CopyFrame:IsVisible() then
		return CopyFrame:Hide()
	end

	CopyFrame.EditBox:SetText(Text)
	CopyFrame:Show()
end

local OnEnter = function(self)
	self:SetAlpha(1)
end

local OnLeave = function(self)
	self:SetAlpha(0)
end

local OnMouseUp = function(self)
	if InCombatLockdown() then
		return
	end

	TukuiChat:CopyText(self.ChatFrame)
end

function TukuiChat:CreateCopyFrame()
	CopyFrame = CreateFrame("Frame", nil, UIParent)
	CopyFrame:SetTemplate()
	CopyFrame:Width(772)
	CopyFrame:Height(250)
	CopyFrame:Point("BOTTOM", UIParent, "BOTTOM", 0, 10)
	CopyFrame:Hide()

	CopyFrame:SetFrameStrata("DIALOG")
	CopyFrame.Minimized = true

	local ScrollArea = CreateFrame("ScrollFrame", "TukuiCopyScrollArea", CopyFrame, "UIPanelScrollFrameTemplate")
	ScrollArea:Point("TOPLEFT", CopyFrame, "TOPLEFT", 8, -30)
	ScrollArea:Point("BOTTOMRIGHT", CopyFrame, "BOTTOMRIGHT", -30, 8)

	local EditBox = CreateFrame("EditBox", nil, CopyFrame)
	EditBox:SetMultiLine(true)
	EditBox:SetMaxLetters(99999)
	EditBox:EnableMouse(true)
	EditBox:SetAutoFocus(false)
	EditBox:SetFont(C.Medias.Font, 12)
	EditBox:Width(772)
	EditBox:Height(250)
	EditBox:SetScript("OnEscapePressed", function()
		CopyFrame:Hide()
	end)

	ScrollArea:SetScrollChild(EditBox)
	
	TukuiCopyScrollAreaScrollBar:SkinScrollBar()

	local Close = CreateFrame("Button", nil, CopyFrame, "UIPanelCloseButton")
	Close:SetPoint("TOPRIGHT", CopyFrame, "TOPRIGHT", 2, 0)
	Close:SkinCloseButton()
	Close:SetScript("OnClick", function()
		CopyFrame:Hide()
	end)

	CopyFrame.EditBox = EditBox
	CopyFrame.Close = Close

	TukuiChat.CopyFrame = CopyFrame
end

function TukuiChat:CreateCopyButtons()
	for i = 1, NUM_CHAT_WINDOWS do
		local Frame = _G["ChatFrame"..i]

		local Button = CreateFrame("Button", nil, Frame)
		Button:Point("TOPRIGHT", 0, 0)
		Button:Size(20, 20)
		Button:SetNormalTexture(C.Medias.Copy)
		Button:SetAlpha(0)
		Button:SetTemplate()
		Button.ChatFrame = Frame

		Button:SetScript("OnMouseUp", OnMouseUp)
		Button:SetScript("OnEnter", OnEnter)
		Button:SetScript("OnLeave", OnLeave)
	end
end