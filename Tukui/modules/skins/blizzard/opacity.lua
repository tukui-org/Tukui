local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	OpacityFrame:StripTextures()
	OpacityFrame:SetTemplate("Default")
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)