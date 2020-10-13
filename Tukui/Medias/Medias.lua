local T, C = unpack(select(2, ...))

local Locale = GetLocale()

C["Medias"] = {
	-- Fonts
	["Font"] = [[Interface\AddOns\Tukui\Medias\Fonts\Expressway.ttf]],
	["UnitFrameFont"] = [[Interface\AddOns\Tukui\Medias\Fonts\BigNoodleTitling.ttf]],
	["DamageFont"] = [[Interface\AddOns\Tukui\Medias\Fonts\DieDieDie.ttf]],
	["PixelFont"] = [=[Interface\AddOns\Tukui\Medias\Fonts\Visitor.ttf]=],
	["ActionBarFont"] = [[Interface\AddOns\Tukui\Medias\Fonts\Arial.ttf]],

	-- Textures
	["Normal"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Tukui]],
	["Glow"] = [[Interface\AddOns\Tukui\Medias\Textures\Others\Glow]],
	["Bubble"] = [[Interface\AddOns\Tukui\Medias\Textures\Others\Bubble]],
	["Copy"] = [[Interface\AddOns\Tukui\Medias\Textures\Others\Copy]],
	["Blank"] = [[Interface\AddOns\Tukui\Medias\Textures\Others\Blank]],
	["Logo"] = [[Interface\AddOns\Tukui\Medias\Textures\Others\Logo]],
	["Sort"] = [[Interface\AddOns\Tukui\Medias\Textures\Others\Sort]],
	["ArrowUp"] = [[Interface\AddOns\Tukui\Medias\Textures\Others\ArrowUp]],
	["ArrowDown"] = [[Interface\AddOns\Tukui\Medias\Textures\Others\ArrowDown]],

	-- colors
	["BorderColor"] = C.General.BorderColor or { 0, 0, 0 },
	["BackdropColor"] = C.General.BackdropColor or { .1,.1,.1 },

	-- sound
	["Whisper"] = [[Interface\AddOns\Tukui\Medias\Sounds\whisper.mp3]],
	["Warning"] = [[Interface\AddOns\Tukui\Medias\Sounds\warning.mp3]],
}

if (Locale == "koKR" or Locale == "zhTW" or Locale == "zhCN") then
	C["Medias"].Font = STANDARD_TEXT_FONT
	C["Medias"].UnitFrameFont = UNIT_NAME_FONT
	C["Medias"].DamageFont = DAMAGE_TEXT_FONT
elseif (Locale ~= "enUS" and Locale ~= "frFR" and Locale ~= "enGB") then
	C["Medias"].DamageFont = C["Medias"].Font
end
