local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	ItemTextFrame:StripTextures(true)
	ItemTextScrollFrame:StripTextures()
	ItemTextFrame:SetTemplate("Default")
	T.SkinCloseButton(ItemTextCloseButton)
	T.SkinNextPrevButton(ItemTextPrevPageButton)
	T.SkinNextPrevButton(ItemTextNextPageButton)
	ItemTextPageText:SetTextColor(1, 1, 1)
	ItemTextPageText.SetTextColor = T.dummy
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)