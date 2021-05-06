local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local GUI = T["GUI"]
local GameMenu = CreateFrame("Frame")
local Menu = GameMenuFrame
local Header = Menu.Header
local Logout = GameMenuButtonLogout
local Addons = GameMenuButtonAddons

function GameMenu:AddHooks()
	Menu:SetHeight(Menu:GetHeight() + Logout:GetHeight() - 4)
	
	local _, RelativeTo, _, _, OffY = Logout:GetPoint()
	
	if RelativeTo ~= GameMenu.Tukui then
		GameMenu.Tukui:ClearAllPoints()
		GameMenu.Tukui:SetPoint("TOPLEFT", RelativeTo, "BOTTOMLEFT", 0, -1)
		
		Logout:ClearAllPoints()
		Logout:SetPoint("TOPLEFT", GameMenu.Tukui, "BOTTOMLEFT", 0, OffY)
	end
end

function GameMenu:CreateTukuiMenuButton()
	local Tukui = CreateFrame("Button", nil, Menu, "GameMenuButtonTemplate")
	Tukui:SetSize(Logout:GetWidth(), Logout:GetHeight())
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

	hooksecurefunc("GameMenuFrame_UpdateVisibleButtons", self.AddHooks)
	
	self.Tukui = Tukui
end

function GameMenu:Enable()
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
				Button:SkinButton()
			end
		end
	end
end

Miscellaneous.GameMenu = GameMenu
