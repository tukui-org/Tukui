local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local MicroMenu = CreateFrame("Frame", "TukuiMicroMenu", UIParent)
local Noop = function() return end

function MicroMenu:HideAlerts()
	HelpTip:HideAllSystem("MicroButtons")
end

function MicroMenu:AddHooks()
	hooksecurefunc("MainMenuMicroButton_ShowAlert", MicroMenu.HideAlerts)
end

function MicroMenu:Update()
	if self:IsShown() then
		for i = 1, #MICRO_BUTTONS do
			local Button = _G[MICRO_BUTTONS[i]]
			
			if Button.Backdrop then
				Button.Backdrop:Show()
			end
			
			if Button.Text then
				if (not Button:IsEnabled()) or (not Button:IsShown()) then
					Button.Text:SetAlpha(0.5)
				else
					Button.Text:SetAlpha(1)
				end
			end
		end
		
		UpdateMicroButtonsParent(T.PetHider)
	else
		UpdateMicroButtonsParent(T.Hider)
		
		for i = 1, #MICRO_BUTTONS do
			local Button = _G[MICRO_BUTTONS[i]]
			
			if Button.Backdrop then
				Button.Backdrop:Hide()
			end
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
		
		return
	end
	
	if self:IsShown() then
		self:Hide()
	else
		self:Show()
	end
end

function MicroMenu:Enable()
	MicroMenu:AddHooks()
	
	MicroMenu:SetSize(250, 374)
	MicroMenu:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	MicroMenu:Hide()
	MicroMenu:SetScript("OnHide", self.Update)
	MicroMenu:SetScript("OnShow", self.Update)
	MicroMenu:CreateBackdrop("Transparent")
	MicroMenu:CreateShadow()
	--MicroMenu:SetScript("OnKeyDown", function(self, b) print(b) end)
	
	MicroButtonAndBagsBar:StripTextures()
	MicroButtonAndBagsBar:SetParent(MicroMenu)
	MicroButtonAndBagsBar:ClearAllPoints()
	MicroButtonAndBagsBar:SetPoint("CENTER", -1, 23)
	MainMenuBarBackpackButton:SetParent(T.Hider)
	
	for i = 1, #MICRO_BUTTONS do
		local Button = _G[MICRO_BUTTONS[i]]
		local PreviousButton = _G[MICRO_BUTTONS[i - 1]]
		
		Button:StripTextures()
		Button:SetAlpha(0)
		Button:ClearAllPoints()
		Button:SetSize(230, 29)
		
		-- Reposition them
		if i == 1 then
			Button:SetPoint("TOP", MicroMenu, "TOP", 0, -14)
		else
			Button:SetPoint("TOP", PreviousButton, "BOTTOM", 0, 0)
		end

		if Button.tooltipText ~= MAINMENU_BUTTON then
			Button:SetScript("OnEnter", Noop)
			Button:HookScript("OnClick", MicroMenu.Toggle)
		end
		
		Button:SkinButton()
		Button.Backdrop:SetParent(MicroMenu)
		Button.Backdrop:ClearAllPoints()
		Button.Backdrop:SetInside(Button, 2, 2)
		Button.Backdrop:SetFrameLevel(Button:GetFrameLevel() + 2)
		Button.Backdrop:CreateShadow()
		Button.Backdrop:Hide()
		
		Button.Text = Button.Backdrop:CreateFontString(nil, "OVERLAY")
		Button.Text:SetFontTemplate(C.Medias.Font, 12)
		Button.Text:SetText(Button.tooltipText)
		Button.Text:SetPoint("CENTER", 2, 1)
		Button.Text:SetTextColor(1, 1, 1)
	end
	
	UpdateMicroButtonsParent(T.Hider)
	
	T.Movers:RegisterFrame(MicroMenu)
	
	tinsert(UISpecialFrames, "TukuiMicroMenu")
	
	-- Toggle micro menu keybind
	if C.Misc.MicroToggle.Value ~= "" then
		self.Captor = CreateFrame("Button", "TukuiMicroMenuCaptor", UIParent, "SecureActionButtonTemplate")
		self.Captor:SetScript("OnClick", MicroMenu.Toggle)
		
		SetOverrideBindingClick(self.Captor, true, C.Misc.MicroToggle.Value, "TukuiMicroMenuCaptor")
	end
end

Miscellaneous.MicroMenu = MicroMenu
