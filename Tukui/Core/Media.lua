local T, C = select(2, ...):unpack()

local TukuiMedia = CreateFrame("Frame")
local Locale = GetLocale()

-- Create our own fonts
local TukuiFont = CreateFont("TukuiFont")
TukuiFont:SetFont(C["Medias"].Font, 12)
TukuiFont:SetShadowColor(0, 0, 0)
TukuiFont:SetShadowOffset(1.25, -1.25)

local TukuiFontOutline = CreateFont("TukuiFontOutline")
TukuiFontOutline:SetFont(C["Medias"].Font, 12, "THINOUTLINE")

local TukuiUFFont = CreateFont("TukuiUFFont")
TukuiUFFont:SetShadowColor(0, 0, 0)
TukuiUFFont:SetShadowOffset(1.25, -1.25)
TukuiUFFont:SetFont(C["Medias"].UnitFrameFont, 12)

local TukuiUFFontOutline = CreateFont("TukuiUFFontOutline")
TukuiUFFontOutline:SetFont(C["Medias"].UnitFrameFont, 12, "THINOUTLINE")

local PixelFont = CreateFont("TukuiPixelFont")
PixelFont:SetFont(C["Medias"].PixelFont, 12, "MONOCHROMEOUTLINE")

local TextureTable = {
	["Blank"] = "Interface\\BUTTONS\\WHITE8X8.tga",
	["Tukui"] = C.Medias.Normal,
}

local FontTable = {
	["Tukui"] = "TukuiFont",
	["Tukui Outline"] = "TukuiFontOutline",
	["Tukui UF"] = "TukuiUFFont",
	["Tukui UF Outline"] = "TukuiUFFontOutline",
	["Pixel"] = "TukuiPixelFont",
	["Game Font"] = "GameFontWhite",
}

T.GetFont = function(font)
	if FontTable[font] then
		return FontTable[font]
	else
		return FontTable["Tukui"] -- Return something to prevent errors
	end
end

T.GetTexture = function(texture)
	if TextureTable[texture] then
		return TextureTable[texture]
	else
		return TextureTable["Blank"] -- Return something to prevent errors
	end
end

function TukuiMedia:RegisterTexture(name, path)
	if (not TextureTable[name]) then
		TextureTable[name] = path
	end
end

function TukuiMedia:RegisterFont(name, path)
	if (not FontTable[name]) then
		FontTable[name] = path
	end
end

T["Media"] = TukuiMedia
T.FontTable = FontTable
T.TextureTable = TextureTable