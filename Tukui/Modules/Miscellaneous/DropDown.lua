local T, C, L = unpack((select(2, ...)))
local Levels = UIDROPDOWNMENU_MAXLEVELS
local Miscellaneous = T["Miscellaneous"]
local Noop = function() end
local UIDropDownMenu_CreateFrames = UIDropDownMenu_CreateFrames
local DropDown = CreateFrame("Frame")

DropDown.ChatMenus = {
	"ChatMenu",
	"EmoteMenu",
	"LanguageMenu",
	"VoiceMacroMenu",
}

function DropDown:Skin()
	local Dropdown = Menu.GetManager():GetOpenMenu()

	if Dropdown then
		Dropdown:StripTextures()
		Dropdown:SetTemplate()
	end
end

function DropDown:Enable()
	local Manager = Menu.GetManager()

	hooksecurefunc(Manager, "OpenMenu", self.Skin)
	hooksecurefunc(Manager, "OpenContextMenu", self.Skin)

	-- TWW need rework
	self.Open = function() T.Print("Not available for Retail yet, work in progress") return end
end

Miscellaneous.DropDown = DropDown
