local T, C, L = select(2, ...):unpack()

local Fonts = T["Fonts"]
local Locale = GetLocale()

function Fonts:SetFont(self, font, size, style, r, g, b, sr, sg, sb, sox, soy)
	self:SetFont(font, size, style)

	if sr and sg and sb then
		self:SetShadowColor(sr, sg, sb)
	end

	if sox and soy then
		self:SetShadowOffset(sox, soy)
	end

	if r and g and b then
		self:SetTextColor(r, g, b)
	elseif r then
		self:SetAlpha(r)
	end
end

function Fonts:Enable()
	-- Base fonts
	Fonts:SetFont(GameTooltipHeader, C.Medias.Font, 12)
	Fonts:SetFont(QuestFont, C.Medias.Font, 14)
	Fonts:SetFont(QuestFont_Large, C.Medias.Font, 14)
	Fonts:SetFont(SystemFont_Large, C.Medias.Font, 15)
	Fonts:SetFont(SystemFont_Med1, C.Medias.Font, 12)
	Fonts:SetFont(SystemFont_Med3, C.Medias.Font, 13)
	Fonts:SetFont(SystemFont_OutlineThick_Huge2, C.Medias.Font, 20, "THICKOUTLINE")
	Fonts:SetFont(SystemFont_Outline_Small, C.Medias.Font, 12, "OUTLINE")
	Fonts:SetFont(SystemFont_Shadow_Large, C.Medias.Font, 15)
	Fonts:SetFont(SystemFont_Shadow_Med1, C.Medias.Font, 12)
	Fonts:SetFont(SystemFont_Shadow_Med3, C.Medias.Font, 13)
	Fonts:SetFont(SystemFont_Shadow_Small, C.Medias.Font, 11)
	Fonts:SetFont(SystemFont_Small, C.Medias.Font, 12)
	Fonts:SetFont(SystemFont_Tiny, C.Medias.Font, 12)
	Fonts:SetFont(Tooltip_Med, C.Medias.Font, 12)
	Fonts:SetFont(Tooltip_Small, C.Medias.Font, 12)
	Fonts:SetFont(SystemFont_Shadow_Huge1, C.Medias.Font, 20, "THINOUTLINE")
	Fonts:SetFont(ZoneTextString, C.Medias.Font, 32, "OUTLINE")
	Fonts:SetFont(SubZoneTextString, C.Medias.Font, 25, "OUTLINE")
	Fonts:SetFont(PVPInfoTextString, C.Medias.Font, 22, "THINOUTLINE")
	Fonts:SetFont(PVPArenaTextString, C.Medias.Font, 22, "THINOUTLINE")
	Fonts:SetFont(FriendsFont_Normal, C.Medias.Font, 12)
	Fonts:SetFont(FriendsFont_Small, C.Medias.Font, 11)
	Fonts:SetFont(FriendsFont_Large, C.Medias.Font, 14)
	Fonts:SetFont(FriendsFont_UserText, C.Medias.Font, 11)
	Fonts:SetFont(NumberFont_OutlineThick_Mono_Small, C.Medias.Font, 12, "OUTLINE")
	Fonts:SetFont(NumberFont_Outline_Huge, C.Medias.Font, 28, "THICKOUTLINE", 28)
	Fonts:SetFont(NumberFont_Outline_Large, C.Medias.Font, 15, "OUTLINE")
	Fonts:SetFont(NumberFont_Outline_Med, C.Medias.Font, 13, "OUTLINE")
	Fonts:SetFont(NumberFont_Shadow_Med, C.Medias.Font, 12)
	Fonts:SetFont(NumberFont_Shadow_Small, C.Medias.Font, 12)
	
	-- Combat Text
	Fonts:SetFont(CombatTextFont, C.Medias.Font, 25, "OUTLINE")
end

-- This need to be set asap
UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 12
CHAT_FONT_HEIGHTS = {12, 13, 14, 15, 16, 17, 18, 19, 20}
UNIT_NAME_FONT = C.Medias.Font
STANDARD_TEXT_FONT = C.Medias.Font
DAMAGE_TEXT_FONT = C.Medias.Font

if (Locale == "koKR" or Locale == "zhTW" or Locale == "zhCN") then
	C["Medias"].Font = STANDARD_TEXT_FONT
	C["Medias"].UnitFrameFont = UNIT_NAME_FONT
	C["Medias"].DamageFont = DAMAGE_TEXT_FONT
end

