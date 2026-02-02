local T, C, L = unpack((select(2, ...)))

local Miscellaneous = T["Miscellaneous"]
local GUI = T["GUI"]
local GameMenu = CreateFrame("Frame")

function GameMenu:CreateTukuiMenuButton()
	local Menu = GameMenuFrame
	local Addons = GameMenuButtonAddons
	local Tukui = CreateFrame("Button", nil, Menu, "GameMenuButtonTemplate")
	Tukui:SetSize(144, 21)
	Tukui:SetPoint("TOPLEFT", Addons, "BOTTOMLEFT", 0, -1)
	Tukui:SetText("Tukui")

	Tukui:SetScript("OnClick", function(self)
		if InCombatLockdown() then
			T.Print(ERR_NOT_IN_COMBAT)

			return
		end

		GUI:Toggle()

		HideUIPanel(Menu)
	end)

	self.Tukui = Tukui
end

function GameMenu:Enable()
	if T.BCC then
		return
	end

	local Menu = GameMenuFrame
	local Header = Menu.Header

	self:CreateTukuiMenuButton()

	if not AddOnSkins then
		if T.Retail then
			Header:StripTextures()

			Header:ClearAllPoints()
			Header:SetPoint("TOP", Menu, 0, 7)

			Menu.Border:StripTextures()
		else
			Menu:StripTextures()
		end

		Menu:CreateBackdrop("Transparent")
		Menu:CreateShadow()

		for _, Button in pairs({Menu:GetChildren()}) do
			if Button.IsObjectType and Button:IsObjectType("Button") then
				Button:SkinButton(nil, nil, true)
			end
		end
	end
end

Miscellaneous.GameMenu = GameMenu
