local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	TaxiFrame:StripTextures()
	TaxiFrame:CreateBackdrop("Default")
	TaxiRouteMap:CreateBackdrop("Default")
	TaxiRouteMap.backdrop:SetAllPoints()
	T.SkinCloseButton(TaxiFrameCloseButton)
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)