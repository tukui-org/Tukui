--------------------------------------------------------------------------
-- overwrite font for some language, because default font are incompatible
--------------------------------------------------------------------------
local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

if T.client == "ruRU" then
	C["media"].uffont = C["media"].ru_uffont
	C["media"].font = C["media"].ru_font
	C["media"].dmgfont = C["media"].ru_dmgfont
elseif T.client == "zhTW" then
	C["media"].uffont = C["media"].tw_uffont
	C["media"].font = C["media"].tw_font
	C["media"].dmgfont = C["media"].tw_dmgfont
elseif T.client == "koKR" then
	C["media"].uffont = C["media"].kr_uffont
	C["media"].font = C["media"].kr_font
	C["media"].dmgfont = C["media"].kr_dmgfont
elseif T.client == "frFR" then
	C["media"].uffont = C["media"].fr_uffont
	C["media"].font = C["media"].fr_font
	C["media"].dmgfont = C["media"].fr_dmgfont
elseif T.client == "deDE" then
	C["media"].uffont = C["media"].de_uffont
	C["media"].font = C["media"].de_font
	C["media"].dmgfont = C["media"].de_dmgfont
end