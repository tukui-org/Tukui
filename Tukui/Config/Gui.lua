local T, C, L = select(2, ...):unpack()

local GUI = T["GUI"]
local Locale = GetLocale()

local General = function(self)
	local Window = self:CreateWindow("General", true)

	Window:CreateSection("All", "Profiles")
	local Profile = Window:CreateDropdown("All", "General", "Profiles", "Import a profile from another character")
	Profile.Menu:HookScript("OnHide", GUI.SetProfile)

	Window:CreateSection("All", "Theme")
	Window:CreateDropdown("All", "General", "Themes", "Set UI theme")

	Window:CreateSection("All", "Scaling")
	Window:CreateSlider("All", "General", "UIScale", "Set UI scale", 0.35, 1, 0.01)

	Window:CreateSection("All", "Border & Backdrop")
	Window:CreateColorSelection("All", "General", "BackdropColor", "Backdrop color")
	Window:CreateColorSelection("All", "General", "BorderColor", "Border color")
	Window:CreateSwitch("All", "General", "ClassColorBorder", "Overwrite border color with class color")
	Window:CreateSwitch("All", "General", "HideShadows", "Hide frame shadows")

	if (Locale ~= "koKR" or Locale ~= "zhTW" or Locale ~= "zhCN") then
		Window:CreateSection("All", "Fonts")
		Window:CreateDropdown("All", "General", "GlobalFont", "Set Tukui global font")
	end
end

local ActionBars = function(self)
	local Window = self:CreateWindow("Actionbars")

	Window:CreateSection("All", "Enable")
	Window:CreateSwitch("All", "ActionBars", "Enable", "Enable actionbar module")
	Window:CreateSwitch("All", "ActionBars", "BottomLeftBar", "Enable bottom left bar")
	Window:CreateSwitch("All", "ActionBars", "BottomRightBar", "Enable bottom right bar")
	Window:CreateSwitch("All", "ActionBars", "RightBar", "Enable right bar #1")
	Window:CreateSwitch("All", "ActionBars", "LeftBar", "Enable right bar #2")
	Window:CreateSwitch("All", "ActionBars", "Pet", "Enable pet bar")
	Window:CreateSwitch("All", "ActionBars", "ShapeShift", "Enable shapeshift")
	Window:CreateSwitch("All", "ActionBars", "HotKey", "Enable hotkeys text")
	Window:CreateSwitch("All", "ActionBars", "Macro", "Enable macro text")
	Window:CreateSwitch("WOTLK", "ActionBars", "MultiCastBar", "Display Blizzard MultiCast Totem Bar")
	Window:CreateSwitch("Retail", "ActionBars", "AutoAddNewSpell", "Auto add new spell to actionbars?")

	Window:CreateSection("All", "Styling")
	Window:CreateSwitch("All", "ActionBars", "ProcAnim", "Our own spell flashing proc animation?")
	Window:CreateSwitch("All", "ActionBars", "EquipBorder", "Highlight equipped item if they are in action bars")
	Window:CreateSwitch("All", "ActionBars", "SwitchBarOnStance", "Switch bar on stance changes")
	Window:CreateSwitch("All", "ActionBars", "ShowBackdrop", "Show the actionbar backdrop")
	Window:CreateSlider("All", "ActionBars", "Bar1ButtonsPerRow", "Bar #1, number of buttons per row", 1, 12, 1)
	Window:CreateSlider("All", "ActionBars", "Bar2ButtonsPerRow", "Bar #2, number of buttons per row", 1, 12, 1)
	Window:CreateSlider("All", "ActionBars", "Bar3ButtonsPerRow", "Bar #3, number of buttons per row", 1, 12, 1)
	Window:CreateSlider("All", "ActionBars", "Bar4ButtonsPerRow", "Bar #4, number of buttons per row", 1, 12, 1)
	Window:CreateSlider("All", "ActionBars", "Bar5ButtonsPerRow", "Bar #5, number of buttons per row", 1, 12, 1)
	Window:CreateSlider("All", "ActionBars", "BarPetButtonsPerRow", "Bar Pet, number of buttons per row", 1, 10, 1)

	Window:CreateSection("All", "Amount of buttons per bars")
	Window:CreateSlider("All", "ActionBars", "Bar1NumButtons", "Bar #1, number of buttons needed?", 1, 12, 1)
	Window:CreateSlider("All", "ActionBars", "Bar2NumButtons", "Bar #2, number of buttons needed?", 1, 12, 1)
	Window:CreateSlider("All", "ActionBars", "Bar3NumButtons", "Bar #3, number of buttons needed?", 1, 12, 1)
	Window:CreateSlider("All", "ActionBars", "Bar4NumButtons", "Bar #4, number of buttons needed?", 1, 12, 1)
	Window:CreateSlider("All", "ActionBars", "Bar5NumButtons", "Bar #5, number of buttons needed?", 1, 12, 1)

	Window:CreateSection("All", "Sizing")
	Window:CreateSlider("All", "ActionBars", "NormalButtonSize", "Set button size", 20, 48, 1)
	Window:CreateSlider("All", "ActionBars", "PetButtonSize", "Set pet button size", 20, 48, 1)
	Window:CreateSlider("All", "ActionBars", "ButtonSpacing", "Set button spacing", 0, 8, 1)

	Window:CreateSection("All", "Font")
	Window:CreateDropdown("All", "ActionBars", "Font", "Set actionbar font", "Font")
	Window:CreateDropdown("All", "Cooldowns", "Font", "Set cooldown font", "Font")
end

local Auras = function(self)
	local Window = self:CreateWindow("Auras")

	Window:CreateSection("All", "Enable")
	Window:CreateSwitch("All", "Auras", "Enable", "Enable auras module")

	Window:CreateSection("All", "Styling")
	Window:CreateSwitch("All", "Auras", "Flash", "Flash auras at low duration")
	Window:CreateSwitch("All", "Auras", "ClassicTimer", "Classic timer countdown")
	Window:CreateSwitch("All", "Auras", "HideBuffs", "Hide buffs")
	Window:CreateSwitch("All", "Auras", "HideDebuffs", "Hide debuffs")
	Window:CreateSwitch("All", "Auras", "Animation", "Animate new auras")
	Window:CreateSlider("All", "Auras", "BuffsPerRow", "Buffs per row", 1, 40, 1)

	Window:CreateSection("All", "Font")
	Window:CreateDropdown("All", "Auras", "Font", "Set aura font", "Font")
end

local Bags = function(self)
	local Window = self:CreateWindow("Bags")

	Window:CreateSection("All", "Enable")
	Window:CreateSwitch("All", "Bags", "Enable", "Enable bag module")
	Window:CreateSwitch("All", "Bags", "ItemLevel", "Display ILevel on bags armors and weapons items")

	Window:CreateSection("All", "Styling")
	Window:CreateSwitch("All", "Bags", "IdentifyQuestItems", "Identify quest items in bags with an exclamation mark?")
	Window:CreateSwitch("All", "Bags", "FlashNewItems", "Flash new items in bags?")

	Window:CreateSection("All", "Sizing")
	Window:CreateSlider("All", "Bags", "ButtonSize", "Set bag slot size", 20, 36, 1)
	Window:CreateSlider("All", "Bags", "Spacing", "Set bag slot spacing", 0, 8, 1)
	Window:CreateSlider("All", "Bags", "ItemsPerRow", "Set items per row", 8, 16, 1)

	Window:CreateSection("All", "Sorting")
	Window:CreateSwitch("All", "Bags", "SortToBottom", "Sort bag to bottom")
end

local Chat = function(self)
	local Window = self:CreateWindow("Chat")

	Window:CreateSection("All", "Enable")
	Window:CreateSwitch("All", "Chat", "Enable", "Enable chat module")
	Window:CreateSwitch("All", "Chat", "WhisperSound", "Enable whisper sound")
	Window:CreateSwitch("All", "Chat", "TextFading", "Fade the chat message after inactivity?")
	Window:CreateDropdown("All", "Chat", "Bubbles", "Chat bubbles")
	Window:CreateSlider("All", "Chat", "BubblesTextSize", "Set bubbles text size", 6, 16, 1)
	Window:CreateSwitch("All", "Chat", "BubblesNames", "Display name in bubbles?")

	Window:CreateSection("All", "Log History")
	Window:CreateSlider("All", "Chat", "LogMax", "Amount of chat line you wish to save into log history", 0, 500, 10)

	Window:CreateSection("All", "Size [Tukui theme only]")
	Window:CreateSlider("All", "Chat", "LeftWidth", "Set left chat width", 300, 600, 1)
	Window:CreateSlider("All", "Chat", "LeftHeight", "Set left chat height", 150, 600, 1)
	Window:CreateSlider("All", "Chat", "RightWidth", "Set right chat width", 300, 600, 1)
	Window:CreateSlider("All", "Chat", "RightHeight", "Set right chat height", 150, 600, 1)

	Window:CreateSection("All", "Styling")
	Window:CreateSwitch("All", "Chat", "SkinBubbles", "Skin bubbles")
	Window:CreateSwitch("All", "Chat", "ShortChannelName", "Shorten channel names")
	Window:CreateSlider("All", "Chat", "ScrollByX", "Set lines to scroll", 1, 6, 1)
	Window:CreateSlider("All", "Chat", "BackgroundAlpha", "Set chat background alpha", 40, 100, 1)
	Window:CreateSlider("All", "Chat", "TextFadingTimer", "Timer that chat text should fade?", 10, 600, 10)
	Window:CreateSwitch("All", "Chat", "LinkBrackets", "Display URL links in brackets")
	Window:CreateSwitch("All", "Chat", "RightChatAlignRight", "Align text to right on right chat frame")
	Window:CreateColorSelection("All", "Chat", "LinkColor", "Link color")

	Window:CreateSection("All", "Font")
	Window:CreateDropdown("All", "Chat", "ChatFont", "Set chat font", "Font")
	Window:CreateDropdown("All", "Chat", "TabFont", "Set chat tab font", "Font")
end

local DataTexts = function(self)
	local Window = self:CreateWindow("DataTexts")

	Window:CreateSection("All", "Enable")
	Window:CreateSwitch("All", "DataTexts", "Battleground", "Enable battleground datatext")
	Window:CreateSwitch("All", "DataTexts", "HideFriendsNotPlaying", "Hide friends currently not playing any games")

	Window:CreateSection("All", "Color")
	Window:CreateColorSelection("All", "DataTexts", "NameColor", "Name color")
	Window:CreateColorSelection("All", "DataTexts", "ValueColor", "Value color")
	Window:CreateColorSelection("All", "DataTexts", "HighlightColor", "Highlight color")
	Window:CreateSwitch("All", "DataTexts", "ClassColor", "Color datatext by class (Overwrite Name/Value)")

	Window:CreateSection("All", "Font")
	Window:CreateDropdown("All", "DataTexts", "Font", "Set datatext font", "Font")
end

local Loot = function(self)
	local Window = self:CreateWindow("Loot")

	Window:CreateSection("All", "Enable")
	Window:CreateSwitch("All", "Loot", "Enable", "Enable loot module")

	Window:CreateSection("All", "Font")
	Window:CreateDropdown("All", "Loot", "Font", "Set loot font", "Font")
end

local Misc = function(self)
	local Window = self:CreateWindow("Misc")

	Window:CreateSection("All", "Micro Menu")
	Window:CreateDropdown("All", "Misc", "MicroStyle", "Select the micromenu style you want to use")
	Window:CreateDropdown("All", "Misc", "MicroToggle", "Select a keybind for toggling micro menu")
	Window:CreateSection("All", "Items Level")
	Window:CreateSwitch("All", "Misc", "ItemLevel", "Display items level on character and inspect frames")
	Window:CreateSection("All", "Threat")
	Window:CreateSwitch("All", "Misc", "ThreatBar", "Enable Threat Bar")
	Window:CreateSection("All", "Experience and reputation")
	Window:CreateSwitch("All", "Misc", "ExperienceEnable", "Enable experience and reputation bars")
	Window:CreateSection("All", "Screensaver")
	Window:CreateSwitch("All", "Misc", "AFKSaver", "Enable AFK screensaver")
	Window:CreateSection("All", "Inventory")
	Window:CreateSwitch("All", "Misc", "AutoSellJunk", "Sell junk automatically when visiting a vendor?")
	Window:CreateSwitch("All", "Misc", "AutoRepair", "Auto repair your equipment when visiting a vendor?")
	Window:CreateSection("All", "UI Error Frame")
	Window:CreateSlider("All", "Misc", "UIErrorSize", "Set ui error text font size", 12, 24, 1)
	Window:CreateDropdown("All", "Misc", "UIErrorFont", "Set ui error font", "Font")
	Window:CreateSection("Retail", "Talking Head")
	Window:CreateSwitch("Retail", "Misc", "TalkingHeadEnable", "Enable Talking Head?")
end

local Maps = function(self)
	local Window = self:CreateWindow("Maps")

	Window:CreateSection("All", "Minimap")
	Window:CreateSwitch("WOTLK", "Maps", "MinimapTracking", "Enable minimap tracking icon")
	Window:CreateSwitch("All", "Maps", "MinimapCoords", "Enable minimap coordinate on mouseover")
	Window:CreateSlider("All", "General", "MinimapScale", "Set minimap scale (%)", 50, 200, 1)

	Window:CreateSection("All", "World Map")
	Window:CreateSwitch("All", "Misc", "WorldMapEnable", "Enable our custom world map")
	Window:CreateSlider("All", "Misc", "FadeWorldMapAlpha", "Worldmap opacity while moving", 0, 100, 1)
	Window:CreateSlider("All", "General", "WorldMapScale", "Set world map scale (%)", 40, 100, 1)
end

local NamePlates = function(self)
	local Window = self:CreateWindow("NamePlates")

	Window:CreateSection("All", "Enable")
	Window:CreateSwitch("All", "NamePlates", "Enable", "Enable nameplate module")
	Window:CreateSwitch("All", "NamePlates", "NameplateCastBar", "Enable nameplate cast")
	Window:CreateSwitch("All", "NamePlates", "QuestIcon", "Enable nameplate quest icon indicator")
	Window:CreateSwitch("Retail", "NamePlates", "ClassIcon", "Enable nameplate class icon indicator (PvP recommended)")

	Window:CreateSection("All", "Styling")
	Window:CreateSlider("All", "NamePlates", "NotSelectedAlpha", "Set not selected nameplate alpha (%)", 0, 100, 1)
	Window:CreateSlider("All", "NamePlates", "SelectedScale", "Set scaling of selected plate (%)", 100, 200, 1)
	Window:CreateSwitch("All", "NamePlates", "OnlySelfDebuffs", "Display only our debuffs")
	Window:CreateColorSelection("All", "NamePlates", "HighlightColor", "Highlight texture color")

	Window:CreateSection("All", "Threat indicator")
	Window:CreateSwitch("All", "NamePlates", "ColorThreat", "Enable nameplate coloring by threat")
	Window:CreateColorSelection("All", "NamePlates", "AggroColor1", "Health Color: low on threat")
	Window:CreateColorSelection("All", "NamePlates", "AggroColor2", "Health Color: overaggroing")
	Window:CreateColorSelection("All", "NamePlates", "AggroColor3", "Health Color: insecurely tanking, tanking but not on top of threat")
	Window:CreateColorSelection("All", "NamePlates", "AggroColor4", "Health Color: securely tanking and highest on threat")

	Window:CreateSection("All", "Sizing")
	Window:CreateSlider("All", "NamePlates", "Width", "Set nameplate width", 60, 200, 10)
	Window:CreateSlider("All", "NamePlates", "Height", "Set nameplate height", 12, 24, 1)
	Window:CreateSlider("All", "NamePlates", "HighlightSize", "Set nameplate highlight size", 5, 15, 1)

	Window:CreateSection("All", "Tags")
	Window:CreateDropdown("All", "NamePlates", "HealthTag", "Health tag on nameplates")

	Window:CreateSection("All", "Font")
	Window:CreateDropdown("All", "NamePlates", "Font", "Set nameplate font", "Font")
end

local Party = function(self)
	local Window = self:CreateWindow("Party")

	Window:CreateSection("All", "Enable")
	Window:CreateSwitch("All", "Party", "Enable", "Enable party module")
	Window:CreateSwitch("All", "Party", "ShowPets", "Display Pets")

	Window:CreateSection("All", "Styling")
	Window:CreateSwitch("All", "Party", "ShowPlayer", "Display self in party")
	Window:CreateSlider("All", "Party", "RangeAlpha", "Set out of range alpha", 0, 1, 0.1)
	Window:CreateSwitch("All", "Party", "ShowHealthText", "Display health text values")
	Window:CreateSwitch("All", "Party", "ShowManaText", "Display mana text values")
	Window:CreateColorSelection("All", "Party", "HighlightColor", "Highlight texture color")
	Window:CreateSlider("All", "Party", "HighlightSize", "Set nameplate highlight size", 5, 15, 1)

	Window:CreateSection("All", "Tags")
	Window:CreateDropdown("All", "Party", "HealthTag", "Health tag party unit")

	Window:CreateSection("All", "Font")
	Window:CreateDropdown("All", "Party", "Font", "Set party font", "Font")
	Window:CreateDropdown("All", "Party", "HealthFont", "Set party health font", "Font")
end

local Raid = function(self)
	local Window = self:CreateWindow("Raid")

	Window:CreateSection("All", "Enable")
	Window:CreateSwitch("All", "Raid", "Enable", "Enable raid module")
	Window:CreateSwitch("All", "Raid", "ShowPets", "Enable raid module for pets")
	Window:CreateSwitch("All", "Raid", "VerticalHealth", "Enable vertical health")

	Window:CreateSection("All", "|cffffff00[RAID 1->20]|r Settings")
	Window:CreateSlider("All", "Raid", "MaxUnitPerColumn", "Set max units per column", 1, 15, 1)
	Window:CreateSlider("All", "Raid", "WidthSize", "Set unit width", 79, 150, 1)
	Window:CreateSlider("All", "Raid", "HeightSize", "Set unit height", 45, 150, 1)
	Window:CreateSlider("All", "Raid", "Padding", "Spacing in pixels between units", 0, 20, 1)

	Window:CreateSection("All", "|cf00fff00[RAID 20->40]|r Settings")
	Window:CreateSlider("All", "Raid", "Raid40MaxUnitPerColumn", "Set max units per column", 1, 15, 1)
	Window:CreateSlider("All", "Raid", "Raid40WidthSize", "Set unit width", 79, 150, 1)
	Window:CreateSlider("All", "Raid", "Raid40HeightSize", "Set unit height", 45, 150, 1)
	Window:CreateSlider("All", "Raid", "Padding40", "Spacing in pixels between units", 0, 20, 1)

	Window:CreateSection("All", "Buffs")
	Window:CreateDropdown("All", "Raid", "RaidBuffsStyle", "Select the buff style you want to use")

	if C.Raid.RaidBuffsStyle.Value == "Standard" then
		Window:CreateDropdown("All", "Raid", "RaidBuffs", "Enable buffs display & filtering")
		Window:CreateSwitch("All", "Raid", "DesaturateBuffs", "Desaturate buffs that are not by me")
	elseif C.Raid.RaidBuffsStyle.Value == "Aura Track" then
		Window:CreateSwitch("All", "Raid", "AuraTrack", "Enable auras tracking module for healer (replace buffs)")
		Window:CreateSwitch("All", "Raid", "AuraTrackIcons", "Use squared icons instead of status bars")
		Window:CreateSwitch("All", "Raid", "AuraTrackSpellTextures", "Display icons texture on aura squares instead of colored squares")
		Window:CreateSlider("All", "Raid", "AuraTrackThickness", "Thickness size of status bars in pixel", 2, 10, 1)
	end

	Window:CreateSection("All", "Debuffs")
	Window:CreateSwitch("All", "Raid", "DebuffWatch", "Enable debuffs tracking (filtered auto by current gameplay (pvp or pve)")
	Window:CreateSwitch("All", "Raid", "DebuffWatchDefault", "We have already a debuff tracking list for pve and pvp, use it?")

	Window:CreateSection("All", "Tags")
	Window:CreateDropdown("All", "Raid", "HealthTag", "Health tag raid unit")

	Window:CreateSection("All", "Others")
	Window:CreateDropdown("All", "Raid", "Font", "Set raid font", "Font")
	Window:CreateDropdown("All", "Raid", "HealthFont", "Set raid health font", "Font")
	Window:CreateSlider("All", "Raid", "RangeAlpha", "Set out of range alpha", 0, 1, 0.1)
	Window:CreateSlider("All", "Raid", "HighlightSize", "Set raid highlight size", 5, 15, 1)
	Window:CreateColorSelection("All", "Raid", "HighlightColor", "Highlight texture color")
	Window:CreateDropdown("All", "Raid", "GroupBy", "Set raid grouping")
end

local Tooltips = function(self)
	local Window = self:CreateWindow("Tooltips")

	Window:CreateSection("All", "Enable")
	Window:CreateSwitch("All", "Tooltips", "Enable", "Enable tooltip module")
	Window:CreateSwitch("All", "Tooltips", "DisplayTitle", "Display player title in their name")
	Window:CreateSwitch("All", "Tooltips", "UnitHealthText", "Enable unit health text")
	Window:CreateSwitch("All", "Tooltips", "AlwaysCompareItems", "Always compare items")

	Window:CreateSection("All", "Styling")
	Window:CreateSwitch("All", "Tooltips", "ItemBorderColor", "Set border color according to item quality?")
	Window:CreateSwitch("All", "Tooltips", "UnitBorderColor", "Set border color according to unit class/reaction?")
	Window:CreateSwitch("All", "Tooltips", "HideInCombat", "Hide tooltip while in combat")
	Window:CreateSwitch("All", "Tooltips", "MouseOver", "Display tooltips on the cursor")

	Window:CreateSection("All", "Font")
	Window:CreateDropdown("All", "Tooltips", "HealthFont", "Set tooltip health font", "Font")
end

local Textures = function(self)
	local Window = self:CreateWindow("Textures")

	Window:CreateSection("All", "Unitframe")
	Window:CreateDropdown("All", "Textures", "UFHealthTexture", "Unitframe health texture", "Texture")
	Window:CreateDropdown("All", "Textures", "UFPowerTexture", "Unitframe power texture", "Texture")
	Window:CreateDropdown("All", "Textures", "UFCastTexture", "Unitframe castbar texture", "Texture")

	Window:CreateSection("All", "Party")
	Window:CreateDropdown("All", "Textures", "UFPartyHealthTexture", "Party health texture", "Texture")
	Window:CreateDropdown("All", "Textures", "UFPartyPowerTexture", "Party party texture", "Texture")

	Window:CreateSection("All", "Raid")
	Window:CreateDropdown("All", "Textures", "UFRaidHealthTexture", "Raid health texture", "Texture")
	Window:CreateDropdown("All", "Textures", "UFRaidPowerTexture", "Raid power texture", "Texture")

	Window:CreateSection("All", "Nameplates")
	Window:CreateDropdown("All", "Textures", "NPHealthTexture", "Nameplate health texture", "Texture")
	Window:CreateDropdown("All", "Textures", "NPPowerTexture", "Nameplate power texture", "Texture")
	Window:CreateDropdown("All", "Textures", "NPCastTexture", "Nameplate castbar texture", "Texture")

	Window:CreateSection("All", "Misc")
	Window:CreateDropdown("All", "Textures", "QuestProgressTexture", "Quest progress texture", "Texture")
	Window:CreateDropdown("All", "Textures", "TTHealthTexture", "Tooltip health texture", "Texture")
end

local UnitFrames = function(self)
	local Window = self:CreateWindow("UnitFrames")

	Window:CreateSection("All", "Enable")
	Window:CreateSwitch("All", "UnitFrames", "Enable", "Enable unitframe module")
	Window:CreateSwitch("Retail", "UnitFrames", "ClassBar", "Enable class bar (example: holy power)")
	Window:CreateSwitch("All", "UnitFrames", "OOCNameLevel", "Display my name/level while out of combat")
	Window:CreateSwitch("All", "UnitFrames", "OOCPetNameLevel", "Display my pet name/level while out of combat")
	Window:CreateSwitch("All", "UnitFrames", "Portrait", "Enable unit portraits")
	Window:CreateSwitch("All", "UnitFrames", "CastBar", "Enable castbar")
	Window:CreateSwitch("All", "UnitFrames", "HealComm", "Enable HealComm")
	Window:CreateSwitch("All", "UnitFrames", "Boss", "Enable boss unit frames")
	Window:CreateSwitch("All", "UnitFrames", "Arena", "Enable arena unit frames")
	Window:CreateSwitch("All", "UnitFrames", "TotemBar", "Enable totem bar")
	Window:CreateSwitch("BCC", "UnitFrames", "PowerTick", "Enable power ticks")
	Window:CreateSwitch("Classic", "UnitFrames", "PowerTick", "Enable power ticks")

	Window:CreateSection("All", "Scrolling combat text for yourself")
	Window:CreateSwitch("All", "UnitFrames", "ScrollingCombatText", "Enable scrolling combat text")
	Window:CreateSwitch("All", "UnitFrames", "ScrollingCombatTextIcon", "Display icon on on scrolling combat text")
	Window:CreateSlider("All", "UnitFrames", "ScrollingCombatTextFontSize", "Text size of scrolling", 10, 80, 1)
	Window:CreateSlider("All", "UnitFrames", "ScrollingCombatTextRadius", "Area size of the scrolling combat text", 50, 500, 10)
	Window:CreateSlider("All", "UnitFrames", "ScrollingCombatTextDisplayTime", "Number of seconds the text remain to be seen", .5, 3, .1)
	Window:CreateDropdown("All", "UnitFrames", "ScrollingCombatTextFont", "Set scrolling combat font", "Font")
	Window:CreateDropdown("All", "UnitFrames", "ScrollingCombatTextAnim", "Which animation you want to use?")

	Window:CreateSection("All", "Auras")
	Window:CreateSwitch("All", "UnitFrames", "PlayerBuffs", "Enable player buffs")
	Window:CreateSwitch("All", "UnitFrames", "PlayerDebuffs", "Enable player debuffs")
	Window:CreateSwitch("All", "UnitFrames", "PlayerAuraBars", "Enable player auras as status bars")
	Window:CreateSwitch("All", "UnitFrames", "OnlySelfBuffs", "Display only our buffs on unitframes")
	Window:CreateSwitch("All", "UnitFrames", "OnlySelfDebuffs", "Display only our debuffs on target")
	Window:CreateSwitch("All", "UnitFrames", "TargetBuffs", "Enable target auras")
	Window:CreateSwitch("All", "UnitFrames", "TargetDebuffs", "Enable target debuffs")
	Window:CreateSwitch("All", "UnitFrames", "TOTAuras", "Enable target of target auras")
	Window:CreateSwitch("All", "UnitFrames", "PetAuras", "Enable pet auras")
	Window:CreateSwitch("All", "UnitFrames", "FocusAuras", "Enable focus and focus target auras")
	Window:CreateSwitch("All", "UnitFrames", "ArenaAuras", "Enable arena auras")
	Window:CreateSwitch("All", "UnitFrames", "BossAuras", "Enable boss auras")
	Window:CreateSwitch("All", "UnitFrames", "AurasBelow", "Move auras below unitframes")
	Window:CreateSwitch("All", "UnitFrames", "DesaturateDebuffs", "Desaturate debuffs that are not by me")
	Window:CreateSwitch("All", "UnitFrames", "FlashRemovableBuffs", "Flash enemy buffs that can be dispelled/purged/stealed")

	Window:CreateSection("All", "Styling")
	Window:CreateSwitch("All", "UnitFrames", "Smoothing", "Animate health and power bars")
	Window:CreateSwitch("All", "UnitFrames", "TargetEnemyHostileColor", "Enemy health bar colored by hostile reaction color")
	Window:CreateSlider("All", "UnitFrames", "StatusBarBackgroundMultiplier", "Health and Power background % opacity", 0, 50, 1)
	Window:CreateSwitch("All", "UnitFrames", "UnlinkCastBar", "Unlink cast bars from unitframes")
	Window:CreateSwitch("All", "UnitFrames", "CastBarIcon", "Display castbar spell icon")
	Window:CreateSwitch("All", "UnitFrames", "CastBarLatency", "Display castbar latency")
	Window:CreateSwitch("All", "UnitFrames", "ComboBar", "Enable combo point bar")
	Window:CreateSwitch("All", "UnitFrames", "Smooth", "Enable smooth health transitions")
	Window:CreateSwitch("All", "UnitFrames", "CombatLog", "Enable combat feedback text")
	Window:CreateSwitch("All", "UnitFrames", "Portrait2D", "Use 2D Portrait")
	Window:CreateDropdown("All", "UnitFrames", "Font", "Set unitframe font", "Font")
	Window:CreateDropdown("All", "UnitFrames", "TotemBarStyle", "Which totem style do you want to use?")
	Window:CreateColorSelection("All", "UnitFrames", "HealCommSelfColor", "HealComm - my heals")
	Window:CreateColorSelection("All", "UnitFrames", "HealCommOtherColor", "HealComm - others heals")
	Window:CreateColorSelection("Retail", "UnitFrames", "HealCommAbsorbColor", "HealComm - absorbs")
	Window:CreateColorSelection("All", "UnitFrames", "CastingColor", "Cast bar casting color")
	Window:CreateColorSelection("All", "UnitFrames", "ChannelingColor", "Cast bar channeling color")
	Window:CreateColorSelection("Retail", "UnitFrames", "NotInterruptibleColor", "Cast bar not interruptible color")
	Window:CreateSlider("All", "UnitFrames", "RaidIconSize", "Size of raid icons", 16, 32, 1)
	Window:CreateSlider("All", "UnitFrames", "HighlightSize", "Set nameplate highlight size", 5, 15, 1)
	Window:CreateSlider("All", "UnitFrames", "RangeAlpha", "Set out of range alpha (focus/arena/boss)", 0, 1, 0.1)

	Window:CreateSection("All", "Tags")
	Window:CreateDropdown("All", "UnitFrames", "PlayerHealthTag", "Health tag on player frame")
	Window:CreateDropdown("All", "UnitFrames", "TargetHealthTag", "Health tag on target frame")
	Window:CreateDropdown("All", "UnitFrames", "FocusHealthTag", "Health tag on focus frame")
	Window:CreateDropdown("All", "UnitFrames", "FocusTargetHealthTag", "Health tag on focus target frame")
	Window:CreateDropdown("All", "UnitFrames", "BossHealthTag", "Health tag on boss frames")
end

GUI:AddWidgets(General)
GUI:AddWidgets(ActionBars)
GUI:AddWidgets(Auras)
GUI:AddWidgets(Bags)
GUI:AddWidgets(Chat)
GUI:AddWidgets(DataTexts)
GUI:AddWidgets(Loot)
GUI:AddWidgets(Maps)
GUI:AddWidgets(Misc)
GUI:AddWidgets(NamePlates)
GUI:AddWidgets(Party)
GUI:AddWidgets(Raid)
GUI:AddWidgets(Tooltips)
GUI:AddWidgets(Textures)
GUI:AddWidgets(UnitFrames)
