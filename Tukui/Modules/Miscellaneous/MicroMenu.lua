local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local MicroMenu = CreateFrame("Frame", "TukuiMicroMenu", UIParent)

MicroMenu.Texts = {
	"CH",
	"SP",
	"TA",
	"AC",
	"QU",
	"GU",
	"GF",
	"AG",
	"CO",
	"ME",
	"SH",
}

function MicroMenu:HideAlerts()
	HelpTip:HideAllSystem("MicroButtons")
end

function MicroMenu:AddHooks()
	hooksecurefunc("MainMenuMicroButton_ShowAlert", MicroMenu.HideAlerts)
end

function MicroMenu:Enable()
	MicroMenu:AddHooks()
	
	MicroMenu:SetSize(284, 34)
	MicroMenu:SetPoint("BOTTOM", 0, 400)
	MicroMenu:Hide()
	
	MicroButtonAndBagsBar:StripTextures()
	MicroButtonAndBagsBar:SetParent(MicroMenu)
	MicroButtonAndBagsBar:ClearAllPoints()
	MicroButtonAndBagsBar:SetPoint("CENTER", -1, 23)
	MainMenuBarBackpackButton:SetParent(T.Hider)
	
	for i = 1, #MICRO_BUTTONS do
		local Button = _G[MICRO_BUTTONS[i]]
		
		Button:StripTextures()
		Button:SetAlpha(0)
		Button:CreateBackdrop()
		Button.Backdrop:SetParent(MicroMenu)
		Button.Backdrop:ClearAllPoints()
		Button.Backdrop:SetInside(Button, 2, 2)
		Button.Backdrop:SetFrameLevel(Button:GetFrameLevel() + 2)
		Button.Backdrop:CreateShadow()
		Button.Backdrop:Hide()
		
		Button.Text = Button.Backdrop:CreateFontString(nil, "OVERLAY")
		Button.Text:SetFontTemplate(C.Medias.Font, 12)
		Button.Text:SetText(MicroMenu.Texts[i])
		Button.Text:SetPoint("CENTER", 2, 1)
		Button.Text:SetTextColor(1, 1, 1)
	end
	
	UpdateMicroButtonsParent(T.Hider)
	
	T.Movers:RegisterFrame(MicroMenu)
end

Miscellaneous.MicroMenu = MicroMenu
