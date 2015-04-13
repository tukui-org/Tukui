local T, C = unpack(select(2, ...))

local Locale = GetLocale()

C["Medias"] = {
	-- Fonts
	["Font"] = [=[Interface\Addons\Tukui\Medias\Fonts\normal_font.ttf]=],
	["UnitFrameFont"] = [[Interface\AddOns\Tukui\Medias\Fonts\uf_font.ttf]],
	["DamageFont"] = [[Interface\AddOns\Tukui\Medias\Fonts\combat_font.ttf]],
	["PixelFont"] = [=[Interface\Addons\Tukui\Medias\Fonts\pixel_font.ttf]=],
	["ActionBarFont"] = [=[Interface\Addons\Tukui\Medias\Fonts\actionbar_font.ttf]=],

	-- Textures
	["Normal"] = [[Interface\AddOns\Tukui\Medias\Textures\normTex]],
	["Glow"] = [[Interface\AddOns\Tukui\Medias\Textures\glowTex]],
	["Bubble"] = [[Interface\AddOns\Tukui\Medias\Textures\bubbleTex]],
	["Copy"] = [[Interface\AddOns\Tukui\Medias\Textures\copy]],
	["Blank"] = [[Interface\AddOns\Tukui\Medias\Textures\blank]],
	["HoverButton"] = [[Interface\AddOns\Tukui\Medias\Textures\button_hover]],
	["Logo"] = [[Interface\AddOns\Tukui\Medias\Textures\logo]],
	
	-- colors
	["BorderColor"] = C.General.BorderColor or { .5, .5, .5 },
	["BackdropColor"] = C.General.BackdropColor or { .1,.1,.1 },
	
	-- sound
	["Whisper"] = [[Interface\AddOns\Tukui\Medias\Sounds\whisper.mp3]],
	["Warning"] = [[Interface\AddOns\Tukui\Medias\Sounds\warning.mp3]],
}

if (Locale == "esES" or Locale == "esMX" or Locale == "itIT" or Locale == "ptBR" or Locale == "ruRU") then
	C["Medias"].UnitFrameFont = C["Medias"].Font
end

if Locale == "koKR" then
	C["Medias"].Font = [[Fonts\2002.TTF]]
	C["Medias"].UnitFrameFont = [[Fonts\2002.TTF]]
	C["Medias"].DamageFont = [[Fonts\2002.TTF]]
elseif Locale == "zhTW" then
	C["Medias"].Font = [[Fonts\bLEI00D.ttf]]
	C["Medias"].UnitFrameFont = [[Fonts\bLEI00D.ttf]]
	C["Medias"].DamageFont = [[Fonts\bLEI00D.ttf]]
elseif Locale == "zhCN" then
	C["Medias"].Font = [[Fonts\ARKai_T.TTF]]
	C["Medias"].UnitFrameFont = [[Fonts\ARHei.TTF]]
	C["Medias"].DamageFont = [[Fonts\ARKai_C.TTF]]
elseif Locale == "ruRU" then
	C["Medias"].DamageFont = [[Interface\AddOns\Tukui\Medias\Fonts\combat_font_rus.ttf]]
end