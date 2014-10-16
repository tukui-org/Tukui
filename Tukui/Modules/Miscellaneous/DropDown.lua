local T, C, L = select(2, ...):unpack()
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
	for i = 1, Levels do
		local Backdrop 
		
		Backdrop = _G["DropDownList"..i.."MenuBackdrop"]
		if Backdrop and not Backdrop.IsSkinned then
			Backdrop:SetTemplate("Default")
			Backdrop:CreateShadow()
			Backdrop.IsSkinned = true
		end
		
		Backdrop = _G["DropDownList"..i.."Backdrop"]
		if Backdrop and not Backdrop.IsSkinned then
			Backdrop:SetTemplate("Default")
			Backdrop:CreateShadow()
			Backdrop.IsSkinned = true
		end
	end
end

function DropDown:Enable()
	local Menu
	
	for i = 1, getn(self.ChatMenus) do
		Menu = _G[self.ChatMenus[i]]
		Menu:SetTemplate()
		Menu:CreateShadow()
		Menu.SetBackdropColor = Noop
	end
	
	hooksecurefunc("UIDropDownMenu_CreateFrames", self.Skin)
end

Miscellaneous.DropDown = DropDown