local T, C, L = select(2, ...):unpack()

local Chat = T["Chat"]
local Bubbles = CreateFrame("Frame")
local GetAllChatBubbles = C_ChatBubbles.GetAllChatBubbles

function Bubbles:Skin(bubble)
	local Bubble = bubble
	local Frame = bubble:GetChildren()

	if Frame and not Frame:IsForbidden() then
		local Tail = Frame.Tail
		local Text = Frame.String
		local Gap = (UIParent:GetEffectiveScale() <= 0.60 and 20) or 10

		Text:SetFont(C.Medias.Font, C.Chat.BubblesTextSize)
		
		Frame:ClearBackdrop()
		Frame:CreateBackdrop("Transparent")
		
		Frame.Backdrop:SetScale(UIParent:GetEffectiveScale())
		Frame.Backdrop:SetInside(Frame, Gap, Gap)
		Frame.Backdrop:CreateShadow()
		
		Tail:SetAlpha(0)
	end

	Bubble.IsSkinned = true
end

function Bubbles:Scan()
	for Index, Bubble in pairs(GetAllChatBubbles()) do
		if (not Bubble.IsSkinned) then
			self:Skin(Bubble)
		end
	end
end

function Bubbles:OnUpdate(elapsed)
	self.Elapsed = self.Elapsed + elapsed
	
	if (self.Elapsed > 0.1) then
		self:Scan()
		
		self.Elapsed = 0
	end
end

function Bubbles:Enable()
	local Setting = C.Chat.Bubbles.Value
	local Dropdown = InterfaceOptionsDisplayPanelChatBubblesDropDown
	
	Dropdown:Hide()
	
	if (Setting == "None") then
        SetCVar("chatBubbles", 0)
        SetCVar("chatBubblesParty", 0)
		
		return
    elseif (Setting == "Exclude Party") then
        SetCVar("chatBubbles", 1)
        SetCVar("chatBubblesParty", 0)
    else
        SetCVar("chatBubbles", 1)
        SetCVar("chatBubblesParty", 1)
    end
	
	self.Elapsed = 0
	self:SetScript("OnUpdate", self.OnUpdate)
end

Chat.Bubbles = Bubbles