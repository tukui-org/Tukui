-- Old keybind script that was made for Tukui 8, for WotLK xpac.
-- Restored and edited for Tukui classic.

local T, C, L = select(2, ...):unpack()
local Bind = CreateFrame("Frame")
local Miscellaneous = T["Miscellaneous"]

function Bind:OnEvent(event, addon)
	if addon ~= "Blizzard_BindingUI" then
		return
	end
	
	local Frame = QuickKeybindFrame
	local Header = Frame.Header
	local Title = Frame.Header.Text
	local Background = Frame.BG
	local Tooltip = QuickKeybindTooltip
	local Buttons = {"okayButton", "defaultsButton", "cancelButton"}
	local CheckBox = Frame.characterSpecificButton
	local Extra = Frame.phantomExtraActionButton
	
	Frame:StripTextures()
	Frame:CreateBackdrop("Transparent")
	Frame:CreateShadow()
	
	Background:StripTextures()
	
	Header:StripTextures()
	
	Title:Hide()
	
	Tooltip:ClearBackdrop()
	Tooltip:CreateBackdrop()
	
	Tooltip.Backdrop:CreateShadow()
	Tooltip.Backdrop:SetBorderColor(unpack(T.Colors.class[T.MyClass]))
	
	CheckBox:SkinCheckBox()
	
	for _, Button in pairs(Buttons) do
		Frame[Button]:SkinButton()
	end
	
	Extra:SetParent(T.Hider)
end

function Bind:Enable()
	self:RegisterEvent("ADDON_LOADED")
	self:SetScript("OnEvent", self.OnEvent)
end

Miscellaneous.Keybinds = Bind
