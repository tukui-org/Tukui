local T, C, L = unpack((select(2, ...)))

-- [WORKLATER] Note, adjust micromenu file for retail later

local Menu = MicroMenu
local Miscellaneous = T["Miscellaneous"]
local MicroMenu = CreateFrame("Frame", "TukuiMicroMenu", UIParent)
local A1, A2, A3, A4, A5
local Noop = function() return end
local RetailMicroButtons = {
	"CharacterMicroButton",
	"SpellbookMicroButton",
	"TalentMicroButton",
	"AchievementMicroButton",
	"QuestLogMicroButton",
	"GuildMicroButton",
	"LFDMicroButton",
	"EJMicroButton",
	"CollectionsMicroButton",
	"MainMenuMicroButton",
	"HelpMicroButton",
	"StoreMicroButton",
}

function MicroMenu:HideAlerts()
	HelpTip:HideAllSystem("MicroButtons")
end

function MicroMenu:AddHooks()
	hooksecurefunc("MainMenuMicroButton_ShowAlert", MicroMenu.HideAlerts)
end

do
	local buttons = {}
	function MicroMenu:ShownMicroButtons()
		wipe(buttons)

		local Buttons = MICRO_BUTTONS

		for _, name in next, Buttons do
			local button = _G[name]
			if T.Retail then
				if button and button:IsShown() then
					tinsert(buttons, name)
				end
			else
				-- button:IsShown() for the lfg for some reason fails to show true and for some reason worldmapmicrobutton is there but dont see it in game...
				if button and button:GetName() ~= 'WorldMapMicroButton' then
					tinsert(buttons, name)
				end
			end
		end

		return buttons
	end
end

function MicroMenu:Minimalist()
	local Width = C.Chat.Enable and T.Chat.Panels.RightChat:GetWidth() or 462
	local Height = 10
	local Buttons = MicroMenu:ShownMicroButtons()
	local NumButtons = #Buttons
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
		[9] = {250/255, 22/255, 22/255},
		[10] = {171/255, 9/255, 182/255},
		[11] = {203/255, 236/255, 79/255},
		[12] = {214/255, 040/255, 79/255},
		[13] = {214/255, 040/255, 79/255},
		[14] = {214/255, 040/255, 79/255},
	}
	local Texts = {
		[1] = "CI",
		[2] = T.Retail and "P" or "SA",
		[3] = "T&S",
		[4] = T.Retail and "A" or T.MoP and "A" or "Q",
		[5] = T.Retail and "QL" or T.MoP and "QL" or (T.Classic or T.BCC) and "GC" or "S",
		[6] = T.Retail and "T" or T.MoP and "S" or "G",
		[7] = T.Retail and "G&C" or T.MoP and "GC" or "MM",
		[8] = T.Retail and "LFG" or T.MoP and "DJ" or "HR",
		[9] = T.Retail and "AG" or T.MoP and "C" or "C",
		[10] = T.MoP and "PvP" or "C",
		[11] = T.MoP and "GF" or "M",
		[12] = T.MoP and "GM" or "S",
		[13] = T.MoP and "CS" or "",
		[14] = T.MoP and "CS" or "",
	}

	MicroMenu:SetFrameStrata("BACKGROUND")
	MicroMenu:SetFrameLevel(2)
	MicroMenu:SetSize(Width, Height)
	MicroMenu:CreateBackdrop()
	MicroMenu:CreateShadow()
	MicroMenu:ClearAllPoints()
	MicroMenu:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -28, Y)

	-- UpdateMicroButtonsParent is disabled:
	-- - On BCC/Classic: causes taint with GameMenuFrame
	-- - On Retail: breaks EditMode MicroMenuContainer positioning

	for i = 1, NumButtons do
		local Button = _G[Buttons[i]]
		local PreviousButton = _G[Buttons[i - 1]]

		-- Skip MainMenuMicroButton on BCC/Classic to prevent taint to GameMenuFrame
		if (T.BCC or T.Classic) and Buttons[i] == "MainMenuMicroButton" then
			-- Don't modify the main menu button at all, just skip it
		else
			Button:StripTextures()
			Button:SetAlpha(0)
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

			if not T.Retail then
				Button.SetPoint = Noop
			end
		end
	end
end

function MicroMenu:GameMenu()
	local Buttons = MicroMenu:ShownMicroButtons()

	if T.Classic or T.BCC then
		WorldMapMicroButton:SetParent(T.Hider)
		WorldMapMicroButton:ClearAllPoints()
		WorldMapMicroButton:SetPoint("BOTTOM", T.Hider, "BOTTOM, 0, -200")
	end

	MicroMenu:SetFrameStrata("HIGH")
	MicroMenu:SetFrameLevel(600)
	MicroMenu:SetSize(250, (T.Classic or T.BCC) and 298 or T.MoP and 438 or 408)
	MicroMenu:CreateBackdrop("Transparent")
	MicroMenu:CreateShadow()
	MicroMenu:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	MicroMenu:Hide()

	MicroMenu.Backdrop:SetFrameLevel(0)

	MainMenuBarBackpackButton:SetParent(T.Hider)

	if UpdateMicroButtonsParent then
		UpdateMicroButtonsParent(MicroMenu)
	end

	for i = 1, #Buttons do
		local Button = _G[Buttons[i]]
		local PreviousButton = _G[Buttons[i - 1]]

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
	local Buttons = MicroMenu:ShownMicroButtons()

	MicroMenu:SetSize(210, 29)
	MicroMenu:ClearAllPoints()
	MicroMenu:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

	-- UpdateMicroButtonsParent is disabled:
	-- - On BCC/Classic: causes taint with GameMenuFrame
	-- - On Retail: breaks EditMode MicroMenuContainer positioning

	for i = 1, #Buttons do
		local Button = _G[Buttons[i]]
		local PreviousButton = _G[Buttons[i - 1]]

		-- Skip MainMenuMicroButton on BCC/Classic to prevent taint to GameMenuFrame
		if (T.BCC or T.Classic) and Buttons[i] == "MainMenuMicroButton" then
			-- Don't modify the main menu button at all
		else
			Button:ClearAllPoints()

			-- Reposition them
			if i == 1 then
				Button:SetPoint("LEFT", MicroMenu, "LEFT", 0, 10)
			else
				Button:SetPoint("LEFT", PreviousButton, "RIGHT", T.Retail and 0 or -3, 0)
			end

			if not T.Retail then
				Button.SetPoint = Noop
			end
		end
	end
end

function MicroMenu:Toggle()
	if self ~= MicroMenu then
		self = MicroMenu
	end

	if self:GetAlpha() == 1 then
		A1, A2, A3, A4, A5 = self:GetPoint()

		self:SetAlpha(0)
		self:ClearAllPoints()
		self:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, -1000)
	else
		self:SetAlpha(1)
		self:ClearAllPoints()
		self:SetPoint(A1, A2, A3, A4, A5)
	end

end

function MicroMenu:Enable()
	if C.Misc.MicroStyle.Value == "None" then
		return
	end

	-- Disable MicroMenu entirely on BCC/Classic to prevent taint
	-- Any modification to secure micro buttons causes taint with GameMenuFrame
	if T.BCC or T.Classic then
		-- Hide default Blizzard micro menu elements
		local elementsToHide = {
			MainMenuBarBackpackButton,
			KeyRingButton,
			CharacterBag0Slot,
			CharacterBag1Slot,
			CharacterBag2Slot,
			CharacterBag3Slot,
			MicroButtonAndBagsBar,
			MicroButtonAndBagsBarMovable,
		}
		for _, element in pairs(elementsToHide) do
			if element then
				element:SetParent(T.Hider)
			end
		end
		return
	end

	-- Hide WorldMapMicroButton early to avoid Blizzard MicroMenu layout issues
	if (T.Classic or T.BCC) and WorldMapMicroButton then
		pcall(function()
			WorldMapMicroButton:SetParent(T.Hider)
			WorldMapMicroButton:ClearAllPoints()
			WorldMapMicroButton:SetPoint("BOTTOM", T.Hider, "BOTTOM", 0, -200)
		end)
	end

	if C.Misc.MicroStyle.Value == "Blizzard" then
		self:Blizzard()
	else
		self:Minimalist()
	end

	MicroMenu:Toggle()
	MicroMenu:AddHooks()

	T.Movers:RegisterFrame(MicroMenu, "Micro Menu")

	-- Toggle micro menu keybind
	if C.Misc.MicroToggle.Value ~= "" then
		self.Captor = CreateFrame("Button", "TukuiMicroMenuCaptor", UIParent)
		self.Captor:SetScript("OnClick", MicroMenu.Toggle)

		SetOverrideBindingClick(self.Captor, true, C.Misc.MicroToggle.Value, "TukuiMicroMenuCaptor")
	end
end

Miscellaneous.MicroMenu = MicroMenu
