local T, C = select(2, ...):unpack()

local TukuiMedia = CreateFrame("Frame")
local Locale = GetLocale()

-- Create our own fonts
local TukuiFont = CreateFont("TukuiFont")
TukuiFont:SetFont(C["Medias"].Font, 12)
TukuiFont:SetShadowColor(0, 0, 0)
TukuiFont:SetShadowOffset(1, -1)

local TukuiFontOutline = CreateFont("TukuiFontOutline")
TukuiFontOutline:SetFont(C["Medias"].Font, 12, "THINOUTLINE")

local TukuiUFFont = CreateFont("TukuiUFFont")
TukuiUFFont:SetShadowColor(0, 0, 0)
TukuiUFFont:SetShadowOffset(1, -1)
TukuiUFFont:SetFont(C["Medias"].UnitFrameFont, 12)

local TukuiUFFontOutline = CreateFont("TukuiUFFontOutline")
TukuiUFFontOutline:SetFont(C["Medias"].UnitFrameFont, 12, "THINOUTLINE")

local PixelFont = CreateFont("TukuiPixelFont")
PixelFont:SetFont(C["Medias"].PixelFont, 12, "MONOCHROMEOUTLINE")

local TukuiDamageFont = CreateFont("TukuiDamageFont")
TukuiDamageFont:SetFont(C["Medias"].DamageFont, 12, "OUTLINE")

local TextureTable = {
	["Blank"] = [[Interface\BUTTONS\WHITE8X8]],
	["Tukui"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Tukui]],
	["ElvUI1"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\ElvUI1]],
	["ElvUI2"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\ElvUI2]],
	["sRainbow1"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Rainbow1]],
	["sRainbow2"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Rainbow2]],
	["sGloss1"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy1]],
	["sSword"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy2]],
	["sBeam"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy3]],
	["sStorm"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy4]],
	["sCrater"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy5]],
	["sStrokes"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy6]],
	["sSponge"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy7]],
	["sSimple1"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy8]],
	["sGrudge"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy9]],
	["sGrass"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy10]],
	["sExplosion"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy11]],
	["sWaterPaper"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy12]],
	["sDarkStrokes"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy13]],
	["sDrySwirl"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy14]],
	["sCrosshatch"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy15]],
	["sDoubleDragon"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy16]],
	["sSingleDragon"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy17]],
	["sSplitIce"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy18]],
	["sWaterDroplets"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy19]],
	["sPawPrints"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Simpy20]],
}

local FontTable = {
	["Tukui"] = "TukuiFont",
	["Tukui Outline"] = "TukuiFontOutline",
	["Tukui UF"] = "TukuiUFFont",
	["Tukui UF Outline"] = "TukuiUFFontOutline",
	["Pixel"] = "TukuiPixelFont",
	["Game Font"] = "GameFontWhite",
	["Tukui Damage"] = "TukuiDamageFont",
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
