local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local GameMenu = CreateFrame("Frame")
local Menu = GameMenuFrame
local Header = GameMenuFrameHeader
local Logout = GameMenuButtonLogout
local Addons = GameMenuButtonAddons

function GameMenu:AddHooks()
	Menu:SetHeight(Menu:GetHeight() + Logout:GetHeight() - 4)
	local _, relTo, _, _, offY = Logout:GetPoint()
	if relTo ~= GameMenu.Tukui then
		GameMenu.Tukui:ClearAllPoints()
		GameMenu.Tukui:Point("TOPLEFT", relTo, "BOTTOMLEFT", 0, -1)
		Logout:ClearAllPoints()
		Logout:Point("TOPLEFT", GameMenu.Tukui, "BOTTOMLEFT", 0, offY)
	end
end

function GameMenu:EnableTukuiConfig()
	local Tukui = CreateFrame("Button", nil, Menu, "GameMenuButtonTemplate")
	Tukui:Size(Logout:GetWidth(), Logout:GetHeight())
	Tukui:Point("TOPLEFT", Addons, "BOTTOMLEFT", 0, -1)
	Tukui:SetText("Tukui")
	Tukui:SetScript("OnClick", function(self)
		if (not TukuiConfigFrame) then
			TukuiConfig:CreateConfigWindow()
		end

		if TukuiConfigFrame:IsVisible() then
			TukuiConfigFrame:Hide()
		else
			TukuiConfigFrame:Show()
		end

		HideUIPanel(Menu)
	end)

	hooksecurefunc('GameMenuFrame_UpdateVisibleButtons', self.AddHooks)
	self.Tukui = Tukui
end

function GameMenu:Enable()
	if TukuiConfig then
		self:EnableTukuiConfig()
	end

	if not AddOnSkins then
		Header:SetTexture("")
		Header:ClearAllPoints()
		Header:SetPoint("TOP", Menu, 0, 7)

		Menu:SetTemplate("Transparent")
		Menu:CreateShadow()
		
		if T.TocVersion >= 80200 then
			Menu.Border:StripTextures()
		end

		for _, Button in pairs({Menu:GetChildren()}) do
			if Button.IsObjectType and Button:IsObjectType("Button") then
				Button:SkinButton()
			end
		end
	end
end

Miscellaneous.GameMenu = GameMenu
