local T, C = unpack(select(2, ...))

local Locale = GetLocale()

C["Medias"] = {
	-- Fonts
	["Font"] = [[Interface\AddOns\Tukui\Medias\Fonts\normal_font.ttf]],
	["UnitFrameFont"] = [[Interface\AddOns\Tukui\Medias\Fonts\uf_font.ttf]],
	["DamageFont"] = [[Interface\AddOns\Tukui\Medias\Fonts\normal_font.ttf]],
	["PixelFont"] = [=[Interface\AddOns\Tukui\Medias\Fonts\pixel_font.ttf]=],
	["ActionBarFont"] = [[Interface\AddOns\Tukui\Medias\Fonts\actionbar_font.ttf]],

	-- Textures
	["Normal"] = [[Interface\AddOns\Tukui\Medias\Textures\Status\Tukui1]],
	["Glow"] = [[Interface\AddOns\Tukui\Medias\Textures\Others\Glow]],
	["Bubble"] = [[Interface\AddOns\Tukui\Medias\Textures\Others\Bubble]],
	["Copy"] = [[Interface\AddOns\Tukui\Medias\Textures\Others\Copy]],
	["Blank"] = [[Interface\AddOns\Tukui\Medias\Textures\Others\Blank]],
	["Logo"] = [[Interface\AddOns\Tukui\Medias\Textures\Others\Logo]],

	-- colors
	["BorderColor"] = C.General.BorderColor or { .5, .5, .5 },
	["BackdropColor"] = C.General.BackdropColor or { .1,.1,.1 },

	-- sound
	["Whisper"] = [[Interface\AddOns\Tukui\Medias\Sounds\whisper.mp3]],
	["Warning"] = [[Interface\AddOns\Tukui\Medias\Sounds\warning.mp3]],
}

if (Locale == "koKR" or Locale == "zhTW" or Locale == "zhCN") then
	C["Medias"].Font = STANDARD_TEXT_FONT
	C["Medias"].UnitFrameFont = UNIT_NAME_FONT
	C["Medias"].DamageFont = DAMAGE_TEXT_FONT
end
