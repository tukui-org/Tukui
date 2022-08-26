local T, C, L = select(2, ...):unpack()

local Chat = T["Chat"]
local Bubbles = CreateFrame("Frame")
local GetAllChatBubbles = C_ChatBubbles.GetAllChatBubbles

local Messages = {}

function Bubbles:Update()
	local Message = self.String:GetText()
	
	-- No need to update
	if not Message or Message == "" or Message == self.Message then
		return
	end

	-- Reset name
	self.Name:Hide()

	-- Refresh name if found
	for Nickname, Table in pairs(Messages) do
		if (Message == Table.Message) then
			local Guid = Messages[Nickname].Guid
			local _, Class, Name, GuidName, GuidServer

			if Guid then
				_, Class, _, _, _, GuidName, GuidServer = GetPlayerInfoByGUID(Guid)

				if GuidServer == "" then
					GuidServer = T.MyRealm
				end

				-- Remove spaces
				GuidServer = GuidServer:gsub("%s+", "")

				Name = GuidName.."-"..GuidServer
			else
				Name = Nickname
			end

			if Nickname == Name then
				local Text = GuidName or Name

				self.Name:Show()
				self.Name:SetText(Text..":")
				self.Message = Message

				if Class then
					self.Name:SetTextColor(unpack(T.Colors.class[Class]))
				else
					self.Name:SetTextColor(0, 1, 0)
				end

				break
			end
		end
	end
end

function Bubbles:Skin(bubble)
	local Bubble = bubble
	local Frame = bubble:GetChildren()

	if Frame and not Frame:IsForbidden() and not Frame.IsSkinned then
		if not Bubble.IsSkinned then
			local Tail = Frame.Tail
			local Text = Frame.String
			local Scaling = UIParent:GetEffectiveScale()
			local Gap = (Scaling <= 0.60 and 20) or 10

			Text:SetFont(C.Medias.Font, C.Chat.BubblesTextSize)

			if not Frame.ClearBackdrop then
				Frame:StripTextures()
			else
				Frame:ClearBackdrop()

				Tail:SetAlpha(0)
			end

			Frame:CreateBackdrop("Transparent")

			Frame.Backdrop:SetScale(Scaling)
			Frame.Backdrop:SetInside(Frame, Gap, Gap)
			Frame.Backdrop:CreateShadow()

			Frame.Name = Frame:CreateFontString(nil, "OVERLAY")
			Frame.Name:SetScale(Scaling)
			Frame.Name:SetFont(C.Medias.Font, 14, "OUTLINE")
			Frame.Name:SetPoint("BOTTOMLEFT", Frame.Backdrop, "TOPLEFT", 0, 4)
			
			if C.Chat.BubblesNames then
				Frame:HookScript("OnShow", Bubbles.Update)
				
				Bubbles.Update(Frame)
			end

			Bubble.IsSkinned = true
		end
	end
end

function Bubbles:Scan()
	for Index, Bubble in pairs(GetAllChatBubbles()) do
		self:Skin(Bubble)
	end
end

function Bubbles:OnUpdate(elapsed)
	self.Elapsed = self.Elapsed + elapsed
	
	if (self.Elapsed > 0.1) then
		self:Scan()
		
		self.Elapsed = 0
	end
end

function Bubbles:OnEvent(event, message, nickname, _, _, test, _, _, _, _, _, _, guid)
	if event == "PLAYER_ENTERING_WORLD" then
		Messages = {}
	else
		Messages[nickname] = {}
		Messages[nickname].Guid = guid
		Messages[nickname].Message = message
	end
end

function Bubbles:Enable()
	local Setting = C.Chat.Bubbles.Value
	local Dropdown = InterfaceOptionsDisplayPanelChatBubblesDropDown
	
	if Dropdown then
		Dropdown:Hide()
	end
	
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
	
	if C.Chat.SkinBubbles then
		self.Elapsed = 0
		self:SetScript("OnUpdate", self.OnUpdate)
	end
	
	if C.Chat.BubblesNames then
		Bubbles:RegisterEvent("CHAT_MSG_SAY")
		Bubbles:RegisterEvent("CHAT_MSG_YELL")
		Bubbles:RegisterEvent("CHAT_MSG_MONSTER_SAY")
		Bubbles:RegisterEvent("CHAT_MSG_MONSTER_YELL")
		Bubbles:RegisterEvent("PLAYER_ENTERING_WORLD")

		if Setting == "All" then
			Bubbles:RegisterEvent("CHAT_MSG_PARTY")
			Bubbles:RegisterEvent("CHAT_MSG_PARTY_LEADER")
			Bubbles:RegisterEvent("CHAT_MSG_RAID")
			Bubbles:RegisterEvent("CHAT_MSG_RAID_LEADER")
		end

		Bubbles:SetScript("OnEvent", self.OnEvent)
	end
end

Chat.Bubbles = Bubbles