local T, C, L = select(2, ...):unpack()

-- [WORKLATER] Note, adjust micromenu file for retail later

local Miscellaneous = T["Miscellaneous"]
local MicroMenu = CreateFrame("Frame", "TukuiMicroMenu", UIParent)
local Noop = function() return end

function MicroMenu:HideAlerts()
	HelpTip:HideAllSystem("MicroButtons")
end

function MicroMenu:AddHooks()
	hooksecurefunc("MainMenuMicroButton_ShowAlert", MicroMenu.HideAlerts)
end

function MicroMenu:Minimalist()
	local Width = C.Chat.Enable and T.Chat.Panels.RightChat:GetWidth() or 462
	local Height = 10
	local NumButtons = #MICRO_BUTTONS
	local Y = C.Chat.Enable and T.Chat.Panels.RightChat:GetHeight() + 28 or 232
	local Colors = {
		[1] = {250/255, 22/255, 22/255},
		[2] = {171/255, 9/255, 182/255},
		[3] = {203/255, 236/255, 79/255},
		[4] = {240/255, 240/255, 21/255},
		[5] = {88/255, 73/255, 197/255},
		[6] = {221/255, 215/255, 173/255},
		[7] = {16/255, 238/255, 213/255},
		[8] = {160/255, 215/255, 241/255},
	}
	local Texts = {
		[1] = "C",
		[2] = "S",
		[3] = "T",
		[4] = "Q",
		[5] = "S",
		[6] = "M",
		[7] = "O",
		[8] = "H",
	}

	MicroMenu:SetFrameStrata("BACKGROUND")
	MicroMenu:SetFrameLevel(2)
	MicroMenu:SetSize(Width, Height)
	MicroMenu:CreateBackdrop()
	MicroMenu:CreateShadow()
	MicroMenu:ClearAllPoints()
	MicroMenu:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -28, Y)

	UpdateMicroButtonsParent(MicroMenu)

	for i = 1, NumButtons do
		local Button = _G[MICRO_BUTTONS[i]]
		local PreviousButton = _G[MICRO_BUTTONS[i - 1]]
		local Pushed = Button:GetPushedTexture()
		local Normal = Button:GetNormalTexture()
		local Disabled = Button:GetDisabledTexture()

		Button:StripTextures()
		Button:SetAlpha(0)
		Button:SetParent(MicroMenu)
		Button:SetWidth(math.floor(Width / NumButtons))
		Button:SetHeight(Height - 2)
		Button:SetHitRectInsets(0, 0, 0, 0)
		Button:CreateBackdrop()
		Button.Backdrop:SetParent(MicroMenu)
		Button.Backdrop:SetFrameLevel(Button:GetFrameLevel() + 2)
		Button:ClearAllPoints()

		Button.Backdrop.Texture = Button.Backdrop:CreateTexture(nil, "ARTWORK")
		Button.Backdrop.Texture:SetInside()
		Button.Backdrop.Texture:SetTexture(C.Medias.Normal)
		Button.Backdrop.Texture:SetVertexColor(unpack(Colors[i]))

		Button.Backdrop.Text = Button.Backdrop:CreateFontString(nil, "OVERLAY")
		Button.Backdrop.Text:SetFontTemplate(C.Medias.Font, 12)
		Button.Backdrop.Text:SetText(Texts[i])
		Button.Backdrop.Text:SetPoint("TOP", 0, 7)
		Button.Backdrop.Text:SetTextColor(1, 1, 1)

		-- Reposition them
		if i == 1 then
			Button:SetPoint("BOTTOMLEFT", MicroMenu, "BOTTOMLEFT", 0, 1)
		else
			Button:SetPoint("LEFT", PreviousButton, "RIGHT", 0, 0)

			if i == NumButtons then
				Button:SetPoint("RIGHT", MicroMenu)
			end
		end
	end
end

function MicroMenu:GameMenu()
	MicroMenu:SetFrameStrata("HIGH")
	MicroMenu:SetFrameLevel(600)
	MicroMenu:SetSize(250, not T.Retail and 298 or 439)
	MicroMenu:CreateBackdrop("Transparent")
	MicroMenu:CreateShadow()
	MicroMenu:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

	MainMenuBarBackpackButton:SetParent(T.Hider)

	UpdateMicroButtonsParent(MicroMenu)

	for i = 1, #MICRO_BUTTONS do
		local Button = _G[MICRO_BUTTONS[i]]
		local PreviousButton = _G[MICRO_BUTTONS[i - 1]]

		Button:StripTextures()
		Button:SetAlpha(0)
		Button:ClearAllPoints()
		Button:SetSize(230, 49)
		Button:CreateBackdrop()

		Button.Backdrop:SetParent(MicroMenu)
		Button.Backdrop:ClearAllPoints()
		Button.Backdrop:SetPoint("LEFT", Button, "LEFT", 0, 0)
		Button.Backdrop:SetPoint("TOP", Button, "TOP", 0, -18)
		Button.Backdrop:SetPoint("RIGHT", Button, "RIGHT", 0, 0)
		Button.Backdrop:SetPoint("BOTTOM", Button, "BOTTOM", 0, 0)
		Button.Backdrop:SetFrameLevel(Button:GetFrameLevel() + 2)
		Button.Backdrop:CreateShadow()

		Button.Text = Button.Backdrop:CreateFontString(nil, "OVERLAY")
		Button.Text:SetFontTemplate(C.Medias.Font, 12)
		Button.Text:SetText(Button.tooltipText)
		Button.Text:SetPoint("BOTTOM", 2, 11)
		Button.Text:SetTextColor(1, 1, 1)

		-- Reposition them
		if i == 1 then
			Button:SetPoint("TOP", MicroMenu, "TOP", 0, 6)
		else
			Button:SetPoint("TOP", PreviousButton, "BOTTOM", 0, 14)
		end

		-- Hide on a click
		if Button.newbieText ~= NEWBIE_TOOLTIP_MAINMENU then
			Button:HookScript("OnClick", MicroMenu.Toggle)
		end

		if not T.Retail then
			Button.SetPoint = Noop
		end

		tinsert(UISpecialFrames, "TukuiMicroMenu")
	end
end

function MicroMenu:Blizzard()
	MicroMenu:SetSize(210, 29)
	MicroMenu:ClearAllPoints()
	MicroMenu:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

	UpdateMicroButtonsParent(MicroMenu)

	for i = 1, #MICRO_BUTTONS do
		local Button = _G[MICRO_BUTTONS[i]]
		local PreviousButton = _G[MICRO_BUTTONS[i - 1]]
		local Pushed = Button:GetPushedTexture()
		local Normal = Button:GetNormalTexture()
		local Disabled = Button:GetDisabledTexture()

		Button:SetParent(MicroMenu)
		Button:ClearAllPoints()

		-- Reposition them
		if i == 1 then
			Button:SetPoint("LEFT", MicroMenu, "LEFT", 0, 10)
		else
			Button:SetPoint("LEFT", PreviousButton, "RIGHT", -3, 0)
		end
	end
end

function MicroMenu:Toggle()
	if self ~= MicroMenu then
		self = MicroMenu
	end

	-- Hide Game Menu if visible
	if GameMenuFrame:IsShown() then
		HideUIPanel(GameMenuFrame)
	end

	if self:IsShown() then
		self:Hide()
	else
		self:Show()
	end
end

function MicroMenu:Enable()
	if not C.Misc.MicroStyle.Value == "None" then
		return
	end

	if C.Misc.MicroStyle.Value == "Minimalist" then
		self:Minimalist()
	elseif C.Misc.MicroStyle.Value == "Blizzard" then
		self:Blizzard()
	elseif C.Misc.MicroStyle.Value == "Game Menu" then
		self:GameMenu()
	end

	MicroMenu:Hide()
	MicroMenu:AddHooks()

	T.Movers:RegisterFrame(MicroMenu, "Micro Menu")

	-- Toggle micro menu keybind
	if C.Misc.MicroToggle.Value ~= "" then
		self.Captor = CreateFrame("Button", "TukuiMicroMenuCaptor", UIParent, "SecureActionButtonTemplate")
		self.Captor:SetScript("OnClick", MicroMenu.Toggle)

		SetOverrideBindingClick(self.Captor, true, C.Misc.MicroToggle.Value, "TukuiMicroMenuCaptor")
	end
end

Miscellaneous.MicroMenu = MicroMenu
