local T, C, L = select(2, ...):unpack()

local Chat = T["Chat"]
local Copy = CreateFrame("Frame")

function Copy:OnTextCopied()
	local Frame = self
	local LeftChat = T.Chat.Panels.LeftChat
	local RightChat = T.Chat.Panels.RightChat
	
	Frame:SetTextCopyable(false)
	Frame:EnableMouse(true)
	Frame:SetOnTextCopiedCallback(nil)
	Frame.IsCopyEnabled = false
	
	LeftChat.Backdrop:SetBorderColor(unpack(C.General.BackdropColor))
	
	RightChat.Backdrop:SetBorderColor(unpack(C.General.BackdropColor))
end

function Copy:EnterSelectMode(chatframe)
	local Frame = chatframe or SELECTED_CHAT_FRAME

	Frame:SetTextCopyable(true)
	Frame:SetOnTextCopiedCallback(Copy.OnTextCopied)
end

function Copy:OnMouseUp()
	local Frame = self.ChatFrame
	local LeftChat = T.Chat.Panels.LeftChat
	local RightChat = T.Chat.Panels.RightChat
	local R, G, B = unpack(T.Colors.class[T.MyClass])
	
	if Frame.IsCopyEnabled then
		Frame:SetTextCopyable(false)
		Frame:EnableMouse(true)
		Frame:SetOnTextCopiedCallback(nil)
		Frame.IsCopyEnabled = false
		
		LeftChat.Backdrop:SetBorderColor(unpack(C.General.BackdropColor))

		RightChat.Backdrop:SetBorderColor(unpack(C.General.BackdropColor))
		
		return
	else
		Frame.IsCopyEnabled = true
	end
	
	if Frame.isDocked then
		LeftChat.Backdrop:SetBorderColor(R, G, B)
	else
		RightChat.Backdrop:SetBorderColor(R, G, B)
	end
	
	Copy:EnterSelectMode(Frame)
end

function Copy:OnEnter()
	local Button = self.CopyButton or self
	
	Button:SetAlpha(1)
end

function Copy:OnLeave()
	local Button = self.CopyButton or self
	
	Button:SetAlpha(0)
end


function Copy:Enable()
	if (not C.Chat.Enable) then
		return
	end
	
	-- Create Copy Buttons
	for i = 1, NUM_CHAT_WINDOWS do
		local Frame = _G["ChatFrame"..i]

		Frame.CopyButton = CreateFrame("Button", nil, Frame)
		Frame.CopyButton:SetPoint("TOPRIGHT", 0, 0)
		Frame.CopyButton:SetSize(20, 20)
		Frame.CopyButton:SetNormalTexture(C.Medias.Copy)
		Frame.CopyButton:SetAlpha(0)
		Frame.CopyButton:CreateBackdrop()
		Frame.CopyButton.ChatFrame = Frame

		Frame.CopyButton:SetScript("OnMouseUp", self.OnMouseUp)
		Frame.CopyButton:SetScript("OnEnter", self.OnEnter)
		Frame.CopyButton:SetScript("OnLeave", self.OnLeave)

		Frame:HookScript("OnEnter", self.OnEnter)
		Frame:HookScript("OnLeave", self.OnLeave)
	end
end

Chat.Copy = Copy