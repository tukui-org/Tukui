local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local MicroMenu = CreateFrame("Frame", "TukuiMicroMenu", UIParent)
local Noop = function() return end

function MicroMenu:HideAlerts()
	HelpTip:HideAllSystem("MicroButtons")
end

function MicroMenu:MoveMicroButtons()
	for i = 1, #MICRO_BUTTONS do
		local Button = _G[MICRO_BUTTONS[i]]
		local PreviousButton = _G[MICRO_BUTTONS[i - 1]]
		
		if C.Misc.BlizzardMicroMenu then
			if i == 1 then
				Button:SetPoint("LEFT", MicroMenu, "LEFT", 0, 10)
			else
				Button:SetPoint("LEFT", PreviousButton, "RIGHT", -3, 0)
			end
		else
			if i == 1 then
				Button:SetPoint("TOP", MicroMenu, "TOP", 0, 6)
			else
				Button:SetPoint("TOP", PreviousButton, "BOTTOM", 0, 14)
			end
		end
	end
end

function MicroMenu:AddHooks()
	hooksecurefunc("MainMenuMicroButton_ShowAlert", MicroMenu.HideAlerts)
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
	if not C.Misc.MicroMenu then
		return
	end
	
	MicroMenu:SetFrameStrata("HIGH")
	MicroMenu:SetFrameLevel(600)
	
	if C.Misc.BlizzardMicroMenu then
		MicroMenu:SetSize(210, 29)
		MicroMenu:ClearAllPoints()
		MicroMenu:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		
		UpdateMicroButtonsParent(MicroMenu)
		
		for i = 1, #MICRO_BUTTONS do
			local Button = _G[MICRO_BUTTONS[i]]
			local PreviousButton = _G[MICRO_BUTTONS[i - 1]]
			
			Button:ClearAllPoints()

			-- Reposition them
			if i == 1 then
				Button:SetPoint("LEFT", MicroMenu, "LEFT", 0, 10)
			else
				Button:SetPoint("LEFT", PreviousButton, "RIGHT", -3, 0)
			end
		end
		
		T.Movers:RegisterFrame(MicroMenu, "Micro Menu")
	else
		local Data = TukuiDatabase.Variables[T.MyRealm][T.MyName]

		MicroMenu:SetSize(250, T.BCC and 298 or 439)
		MicroMenu:Hide()
		MicroMenu:CreateBackdrop("Transparent")
		MicroMenu:CreateShadow()
		MicroMenu:EnableMouse(true)
		MicroMenu:SetMovable(true)
		MicroMenu:SetUserPlaced(true)
		MicroMenu:RegisterForDrag("LeftButton")

		if Data.MicroMenuPosition then
			MicroMenu:SetPoint(unpack(Data.MicroMenuPosition))
		else
			MicroMenu:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		end

		MicroMenu:SetScript("OnDragStart", function(self)
			MicroMenu:StartMoving()
		end)

		MicroMenu:SetScript("OnDragStop", function(self)
			MicroMenu:StopMovingOrSizing()

			local A1, P, A2, X, Y = MicroMenu:GetPoint()

			Data.MicroMenuPosition = {A1, "UIParent", A2, X, Y}
		end)

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
			
			if T.BCC then
				Button.SetPoint = Noop
			end
		end
	end
	
	MicroMenu:AddHooks()
	
	T.Movers:RegisterFrame(MicroMenu, "Micro Menu")
	
	tinsert(UISpecialFrames, "TukuiMicroMenu")
	
	-- Toggle micro menu keybind
	if C.Misc.MicroToggle.Value ~= "" then
		self.Captor = CreateFrame("Button", "TukuiMicroMenuCaptor", UIParent, "SecureActionButtonTemplate")
		self.Captor:SetScript("OnClick", MicroMenu.Toggle)
		
		SetOverrideBindingClick(self.Captor, true, C.Misc.MicroToggle.Value, "TukuiMicroMenuCaptor")
	end
	
	if T.Retail then
		-- 9.1, menu it at top (wtf?!), move it back to original position
		GameMenuFrame:ClearAllPoints()
		GameMenuFrame:SetPoint("CENTER", UIParent)
	end
end

Miscellaneous.MicroMenu = MicroMenu
