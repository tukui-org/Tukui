local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	ItemTextFrame:StripTextures(true)
	ItemTextFrameInset:StripTextures()
	ItemTextScrollFrame:StripTextures()
	ItemTextFrame:SetTemplate("Default")
	ItemTextScrollFrameScrollBar:SkinScrollBar()
	ItemTextFrameCloseButton:SkinCloseButton()
	ItemTextPrevPageButton:SkinNextPrevButton()
	ItemTextNextPageButton:SkinNextPrevButton()
	ItemTextPageText:SetTextColor(1, 1, 1)
	ItemTextPageText.SetTextColor = T.dummy
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)