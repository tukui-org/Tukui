local T, C, L = select(2, ...):unpack()

local Chat = T["Chat"]
local Copy = CreateFrame("Frame")

function Copy:OnTextCopied()
	local Frame = self
	local LeftChat = T.Chat.Panels.LeftChat
	local RightChat = T.Chat.Panels.RightChat
	
	Frame:SetTextCopyable(false)
	Frame:EnableMouse(false)
	Frame:SetOnTextCopiedCallback(nil)
	Frame.IsCopyEnabled = false
	
	LeftChat.Backdrop:SetBorderColor(unpack(C.General.BackdropColor))
	
	RightChat.Backdrop:SetBorderColor(unpack(C.General.BackdropColor))
end

function Copy:EnterSelectMode(chatframe)
	local Frame = chatframe or SELECTED_CHAT_FRAME

	Frame:SetTextCopyable(true)
	Frame:EnableMouse(true)
	Frame:SetOnTextCopiedCallback(Copy.OnTextCopied)
end

function Copy:OnMouseUp()
	local Frame = self.ChatFrame
	local LeftChat = T.Chat.Panels.LeftChat
	local RightChat = T.Chat.Panels.RightChat
	local R, G, B = unpack(T.Colors.class[T.MyClass])
	
	if Frame.IsCopyEnabled then
		Frame:SetTextCopyable(false)
		Frame:EnableMouse(false)
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
	self:SetAlpha(1)
end

function Copy:OnLeave()
	self:SetAlpha(0)
end


function Copy:Enable()
	if (not C.Chat.Enable) then
		return
	end
	
	-- Create Copy Buttons
	for i = 1, NUM_CHAT_WINDOWS do
		local Frame = _G["ChatFrame"..i]

		local Button = CreateFrame("Button", nil, Frame)
		Button:SetPoint("TOPRIGHT", 0, 0)
		Button:SetSize(20, 20)
		Button:SetNormalTexture(C.Medias.Copy)
		Button:SetAlpha(0)
		Button:CreateBackdrop()
		Button.ChatFrame = Frame

		Button:SetScript("OnMouseUp", self.OnMouseUp)
		Button:SetScript("OnEnter", self.OnEnter)
		Button:SetScript("OnLeave", self.OnLeave)
	end
end

Chat.Copy = Copy