local T, C, L = unpack((select(2, ...)))
local Levels = UIDROPDOWNMENU_MAXLEVELS
local Miscellaneous = T["Miscellaneous"]
local Noop = function() end
local UIDropDownMenu_CreateFrames = UIDropDownMenu_CreateFrames
local DropDown = CreateFrame("Frame")
local DataTexts = T["DataTexts"]

-- WIP
function DropDown:Warning()
	T.Print("Dropdown are currently being rewrote from scratch and will be available soon!")
end

function DropDown:DisplayDataTexts()
	MenuUtil.CreateContextMenu(self, function(Region, Description)
		for Number, DataText in pairs(DataTexts.Menu) do
			Description:CreateButton(DataText.text, DropDown.Warning)
		end
	end)
end
-- WIP

function DropDown:Skin()
	if Menu then
		local Dropdown = Menu.GetManager():GetOpenMenu()
		
		if Dropdown then
			Dropdown:StripTextures()
			Dropdown:SetTemplate()
		end
	else
		for i = 1, Levels do
			local Backdrop

			Backdrop = _G["DropDownList"..i.."MenuBackdrop"]
			if Backdrop and not Backdrop.IsSkinned then
				if Backdrop.NineSlice then
					Backdrop.NineSlice:SetAlpha(0)
				end

				Backdrop:StripTextures()
				Backdrop:CreateBackdrop("Default")
				Backdrop:CreateShadow()
				Backdrop.IsSkinned = true
			end

			Backdrop = _G["DropDownList"..i.."Backdrop"]
			if Backdrop and not Backdrop.IsSkinned then
				if Backdrop.NineSlice then
					Backdrop.NineSlice:SetAlpha(0)
				end

				Backdrop:StripTextures()
				Backdrop:CreateBackdrop("Default")
				Backdrop:CreateShadow()
				Backdrop.IsSkinned = true
			end

			Backdrop = _G["Lib_DropDownList"..i.."MenuBackdrop"]
			if Backdrop and not Backdrop.IsSkinned then
				if Backdrop.NineSlice then
					Backdrop.NineSlice:SetAlpha(0)
				end

				Backdrop:StripTextures()
				Backdrop:CreateBackdrop("Default")
				Backdrop:CreateShadow()
				Backdrop.IsSkinned = true
			end

			Backdrop = _G["Lib_DropDownList"..i.."Backdrop"]
			if Backdrop and not Backdrop.IsSkinned then
				if Backdrop.NineSlice then
					Backdrop.NineSlice:SetAlpha(0)
				end

				Backdrop:StripTextures()
				Backdrop:CreateBackdrop("Default")
				Backdrop:CreateShadow()
				Backdrop.IsSkinned = true
			end
		end
	end
end

function DropDown:Enable()
	if Menu then
		local Manager = Menu.GetManager()

		hooksecurefunc(Manager, "OpenMenu", self.Skin)
		hooksecurefunc(Manager, "OpenContextMenu", self.Skin)
	else
		hooksecurefunc("UIDropDownMenu_CreateFrames", self.Skin)

		-- use dropdown lib
		self.Open = Lib_EasyMenu or EasyMenu
	end
end

Miscellaneous.DropDown = DropDown
