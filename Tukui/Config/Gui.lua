local T, C, L = select(2, ...):unpack()

local GUI = T["GUI"]

local General = function(self)
	local Window = self:CreateWindow("General", true)

	Window:CreateSection("Theme")
	Window:CreateDropdown("General", "Themes", "Set UI theme")

	Window:CreateSection("Scaling")
	Window:CreateSlider("General", "UIScale", "Set UI scale", 0.35, 1, 0.01)
	Window:CreateSlider("General", "MinimapScale", "Set minimap scale (%)", 50, 200, 1)
	Window:CreateSlider("General", "WorldMapScale", "Set world map scale (%)", 40, 100, 1)

	Window:CreateSection("Border & Backdrop")
	Window:CreateColorSelection("General", "BackdropColor", "Backdrop color")
	Window:CreateColorSelection("General", "BorderColor", "Border color")
	Window:CreateSwitch("General", "HideShadows", "Hide frame shadows")
end

local ActionBars = function(self)
	local Window = self:CreateWindow("Actionbars")

	Window:CreateSection("Enable")
	Window:CreateSwitch("ActionBars", "Enable", "Enable actionbar module")
	Window:CreateSwitch("ActionBars", "BottomLeftBar", "Enable bottom left bar")
	Window:CreateSwitch("ActionBars", "BottomRightBar", "Enable bottom right bar")
	Window:CreateSwitch("ActionBars", "RightBar", "Enable right bar #1")
	Window:CreateSwitch("ActionBars", "LeftBar", "Enable right bar #2")
	Window:CreateSwitch("ActionBars", "Pet", "Enable pet bar")
	Window:CreateSwitch("ActionBars", "ShapeShift", "Enable shapeshift")
	Window:CreateSwitch("ActionBars", "HotKey", "Enable hotkeys text")
	Window:CreateSwitch("ActionBars", "Macro", "Enable macro text")

	Window:CreateSection("Styling")
	Window:CreateSwitch("ActionBars", "EquipBorder", "Highlight equipped item if they are in action bars")
	Window:CreateSwitch("ActionBars", "SwitchBarOnStance", "Switch bar on stance changes")
	Window:CreateSwitch("ActionBars", "ShowBackdrop", "Show the actionbar backdrop")
	Window:CreateSwitch("ActionBars", "RightBarsAtBottom", "Move right bars at the bottom and set them horizontal")

	Window:CreateSection("Sizing")
	Window:CreateSlider("ActionBars", "NormalButtonSize", "Set button size", 20, 48, 1)
	Window:CreateSlider("ActionBars", "PetButtonSize", "Set pet button size", 20, 48, 1)
	Window:CreateSlider("ActionBars", "ButtonSpacing", "Set button spacing", 0, 8, 1)

	Window:CreateSection("Font")
	Window:CreateDropdown("ActionBars", "Font", "Set actionbar font", "Font")
	Window:CreateDropdown("Cooldowns", "Font", "Set cooldown font", "Font")
end

local Auras = function(self)
	local Window = self:CreateWindow("Auras")

	Window:CreateSection("Enable")
	Window:CreateSwitch("Auras", "Enable", "Enable auras module")

	Window:CreateSection("Styling")
	Window:CreateSwitch("Auras", "Flash", "Flash auras at low duration")
	Window:CreateSwitch("Auras", "ClassicTimer", "Classic timer countdown")
	Window:CreateSwitch("Auras", "HideBuffs", "Hide buffs")
	Window:CreateSwitch("Auras", "HideDebuffs", "Hide debuffs")
	Window:CreateSwitch("Auras", "Animation", "Animate new auras")
	Window:CreateSlider("Auras", "BuffsPerRow", "Buffs per row", 6, 20, 1)

	Window:CreateSection("Font")
	Window:CreateDropdown("Auras", "Font", "Set aura font", "Font")
end

local Bags = function(self)
	local Window = self:CreateWindow("Bags")

	Window:CreateSection("Enable")
	Window:CreateSwitch("Bags", "Enable", "Enable bag module")

	Window:CreateSection("Sizing")
	Window:CreateSlider("Bags", "ButtonSize", "Set bag slot size", 20, 36, 1)
	Window:CreateSlider("Bags", "Spacing", "Set bag slot spacing", 0, 8, 1)
	Window:CreateSlider("Bags", "ItemsPerRow", "Set items per row", 8, 16, 1)
end

local Chat = function(self)
	local Window = self:CreateWindow("Chat")

	Window:CreateSection("Enable")
	Window:CreateSwitch("Chat", "Enable", "Enable chat module")
	Window:CreateSwitch("Chat", "WhisperSound", "Enable whisper sound")
	Window:CreateSwitch("Chat", "TextFading", "Fade the chat message after inactivity?")
	Window:CreateDropdown("Chat", "Bubbles", "Chat bubbles")
	Window:CreateSlider("Chat", "BubblesTextSize", "Set bubbles text size", 6, 16, 1)

	Window:CreateSection("Size [Tukui theme only]")
	Window:CreateSlider("Chat", "LeftWidth", "Set left chat width", 300, 600, 10)
	Window:CreateSlider("Chat", "LeftHeight", "Set left chat height", 150, 600, 10)
	Window:CreateSlider("Chat", "RightWidth", "Set right chat width", 300, 600, 10)
	Window:CreateSlider("Chat", "RightHeight", "Set right chat height", 150, 600, 10)

	Window:CreateSection("Styling")
	Window:CreateSwitch("Chat", "ShortChannelName", "Shorten channel names")
	Window:CreateSlider("Chat", "ScrollByX", "Set lines to scroll", 1, 6, 1)
	Window:CreateSlider("Chat", "BackgroundAlpha", "Set chat background alpha", 40, 100, 1)
	Window:CreateSlider("Chat", "TextFadingTimer", "Timer that chat text should fade?", 10, 600, 10)
	Window:CreateSwitch("Chat", "LinkBrackets", "Display URL links in brackets")
	Window:CreateSwitch("Chat", "RightChatAlignRight", "Align text to right on second chat frame")
	Window:CreateColorSelection("Chat", "LinkColor", "Link color")

	Window:CreateSection("Font")
	Window:CreateDropdown("Chat", "ChatFont", "Set chat font", "Font")
	Window:CreateDropdown("Chat", "TabFont", "Set chat tab font", "Font")
end

local DataTexts = function(self)
	local Window = self:CreateWindow("DataTexts")

	Window:CreateSection("Enable")
	Window:CreateSwitch("DataTexts", "Battleground", "Enable battleground datatext")
	Window:CreateSwitch("DataTexts", "Hour24", "Switch time datatext to 24h mode")
	Window:CreateSwitch("DataTexts", "HideFriendsNotPlaying", "Hide friends currently not playing any games")

	Window:CreateSection("Color")
	Window:CreateColorSelection("DataTexts", "NameColor", "Name color")
	Window:CreateColorSelection("DataTexts", "ValueColor", "Value color")
	Window:CreateColorSelection("DataTexts", "HighlightColor", "Highlight color")
	Window:CreateSwitch("DataTexts", "ClassColor", "Color datatext by class (Overwrite Name/Value)")

	Window:CreateSection("Font")
	Window:CreateDropdown("DataTexts", "Font", "Set datatext font", "Font")
end

local Loot = function(self)
	local Window = self:CreateWindow("Loot")

	Window:CreateSection("Enable")
	Window:CreateSwitch("Loot", "Enable", "Enable loot module")

	Window:CreateSection("Font")
	Window:CreateDropdown("Loot", "Font", "Set loot font", "Font")
end

local Misc = function(self)
	local Window = self:CreateWindow("Misc")
				
	Window:CreateSection("Threat")
	Window:CreateSwitch("Misc", "ThreatBar", "Enable Threat Bar")
	Window:CreateSection("World Map")
	Window:CreateSwitch("Misc", "WorldMapEnable", "Enable our custom world map")
	Window:CreateSwitch("Misc", "FadeWorldMapWhileMoving", "Fade world map while moving?")
	Window:CreateSection("Experience and reputation")
	Window:CreateSwitch("Misc", "ExperienceEnable", "Enable experience and reputation bars")
	Window:CreateSection("Screensaver")
	Window:CreateSwitch("Misc", "AFKSaver", "Enable AFK screensaver")
	Window:CreateSection("Inventory")
	Window:CreateSwitch("Misc", "AutoSellJunk", "Sell junk automatically when visiting a vendor?")
	Window:CreateSwitch("Misc", "AutoRepair", "Auto repair your equipment when visiting a vendor?")
	Window:CreateSection("Objective Tracker")
	Window:CreateDropdown("Misc", "ObjectiveTrackerFont", "Set objective tracker font", "Font")
	Window:CreateSection("Talking Head")
	Window:CreateSwitch("Misc", "TalkingHeadEnable", "Enable Talking Head?")
	Window:CreateSection("UI Error Frame")
	Window:CreateSlider("Misc", "UIErrorSize", "Set ui error text font size", 12, 24, 1)
	Window:CreateDropdown("Misc", "UIErrorFont", "Set ui error font", "Font")
end

local NamePlates = function(self)
	local Window = self:CreateWindow("NamePlates")

	Window:CreateSection("Enable")
	Window:CreateSwitch("NamePlates", "Enable", "Enable nameplate module")
	Window:CreateSwitch("NamePlates", "NameplateCastBar", "Enable nameplate castbar")

	Window:CreateSection("Styling")
	Window:CreateSwitch("NamePlates", "OnlySelfDebuffs", "Display only our debuffs")
	Window:CreateColorSelection("NamePlates", "HighlightColor", "Highlight texture color")

	Window:CreateSection("Sizing")
	Window:CreateSlider("NamePlates", "Width", "Set nameplate width", 60, 200, 10)
	Window:CreateSlider("NamePlates", "Height", "Set nameplate height", 12, 24, 1)
	Window:CreateSlider("NamePlates", "HighlightSize", "Set nameplate highlight size", 5, 15, 1)

	Window:CreateSection("Font")
	Window:CreateDropdown("NamePlates", "Font", "Set nameplate font", "Font")
end

local Party = function(self)
	local Window = self:CreateWindow("Party")

	Window:CreateSection("Enable")
	Window:CreateSwitch("Party", "Enable", "Enable party module")
	Window:CreateSwitch("Party", "ShowPets", "Display Pets")

	Window:CreateSection("Styling")
	Window:CreateSwitch("Party", "ShowPlayer", "Display self in party")
	Window:CreateSlider("Party", "RangeAlpha", "Set out of range alpha", 0, 1, 0.1)
	Window:CreateSwitch("Party", "ShowHealthText", "Display health text values")
	Window:CreateSwitch("Party", "ShowManaText", "Display mana text values")
	Window:CreateColorSelection("Party", "HighlightColor", "Highlight texture color")
	Window:CreateSlider("Party", "HighlightSize", "Set nameplate highlight size", 5, 15, 1)

	Window:CreateSection("Font")
	Window:CreateDropdown("Party", "Font", "Set party font", "Font")
	Window:CreateDropdown("Party", "HealthFont", "Set party health font", "Font")
end

local Raid = function(self)
	local Window = self:CreateWindow("Raid")

	Window:CreateSection("Enable")
	Window:CreateSwitch("Raid", "Enable", "Enable raid module")
	Window:CreateSwitch("Raid", "ShowPets", "Enable raid module for pets")
	Window:CreateSwitch("Raid", "DebuffWatch", "Display dispellable debuffs")
	Window:CreateSwitch("Raid", "VerticalHealth", "Enable vertical health")
	Window:CreateSwitch("Raid", "DesaturateNonPlayerBuffs", "Displays other players buffs grayscaled")
	Window:CreateDropdown("Raid", "RaidBuffs", "Show buff on raid frames")
	
	Window:CreateSection("Sorting")
	Window:CreateDropdown("Raid", "GroupBy", "Set raid grouping")

	Window:CreateSection("Styling")
	Window:CreateSlider("Raid", "RangeAlpha", "Set out of range alpha", 0, 1, 0.1)
	Window:CreateSlider("Raid", "MaxUnitPerColumn", "Set max units per column", 1, 15, 1)
	Window:CreateSlider("Raid", "WidthSize", "Set raid unit width", 79, 150, 1)
	Window:CreateSlider("Raid", "HeightSize", "Set raid unit height", 45, 150, 1)
	Window:CreateColorSelection("Raid", "HighlightColor", "Highlight texture color")
	Window:CreateSlider("Raid", "HighlightSize", "Set nameplate highlight size", 5, 15, 1)

	Window:CreateSection("Font")
	Window:CreateDropdown("Raid", "Font", "Set raid font", "Font")
	Window:CreateDropdown("Raid", "HealthFont", "Set raid health font", "Font")
end

local Tooltips = function(self)
	local Window = self:CreateWindow("Tooltips")

	Window:CreateSection("Enable")
	Window:CreateSwitch("Tooltips", "Enable", "Enable tooltip module")
	Window:CreateSwitch("Tooltips", "UnitHealthText", "Enable unit health text")
	Window:CreateSwitch("Tooltips", "AlwaysCompareItems", "Always compare items")

	Window:CreateSection("Styling")
	Window:CreateSwitch("Tooltips", "HideInCombat", "Hide tooltip while in combat")
	Window:CreateSwitch("Tooltips", "MouseOver", "Display tooltips on the cursor")

	Window:CreateSection("Font")
	Window:CreateDropdown("Tooltips", "HealthFont", "Set tooltip health font", "Font")
end

local Textures = function(self)
	local Window = self:CreateWindow("Textures")

	Window:CreateSection("Unitframe")
	Window:CreateDropdown("Textures", "UFHealthTexture", "Unitframe health texture", "Texture")
	Window:CreateDropdown("Textures", "UFPowerTexture", "Unitframe power texture", "Texture")
	Window:CreateDropdown("Textures", "UFCastTexture", "Unitframe castbar texture", "Texture")

	Window:CreateSection("Party")
	Window:CreateDropdown("Textures", "UFPartyHealthTexture", "Party health texture", "Texture")
	Window:CreateDropdown("Textures", "UFPartyPowerTexture", "Party party texture", "Texture")

	Window:CreateSection("Raid")
	Window:CreateDropdown("Textures", "UFRaidHealthTexture", "Raid health texture", "Texture")
	Window:CreateDropdown("Textures", "UFRaidPowerTexture", "Raid power texture", "Texture")

	Window:CreateSection("Nameplates")
	Window:CreateDropdown("Textures", "NPHealthTexture", "Nameplate health texture", "Texture")
	Window:CreateDropdown("Textures", "NPPowerTexture", "Nameplate power texture", "Texture")
	Window:CreateDropdown("Textures", "NPCastTexture", "Nameplate castbar texture", "Texture")

	Window:CreateSection("Misc")
	Window:CreateDropdown("Textures", "QuestProgressTexture", "Quest progress texture", "Texture")
	Window:CreateDropdown("Textures", "TTHealthTexture", "Tooltip health texture", "Texture")
end

local UnitFrames = function(self)
	local Window = self:CreateWindow("UnitFrames")

	Window:CreateSection("Enable")
	Window:CreateSwitch("UnitFrames", "Enable", "Enable unitframe module")
	Window:CreateSwitch("UnitFrames", "OOCNameLevel", "Display my name/level while out of combat")
	Window:CreateSwitch("UnitFrames", "OOCPetNameLevel", "Display my pet name/level while out of combat")
	Window:CreateSwitch("UnitFrames", "ShowTargetManaText", "Display power text on target")
	Window:CreateSwitch("UnitFrames", "Portrait", "Enable unit portraits")
	Window:CreateSwitch("UnitFrames", "CastBar", "Enable castbar")
	Window:CreateSwitch("UnitFrames", "HealComm", "Enable HealComm")
	Window:CreateSwitch("UnitFrames", "Boss", "Enable boss unit frames")
	Window:CreateSwitch("UnitFrames", "Arena", "Enable arena unit frames")

	if T.MyClass == "SHAMAN" then
		Window:CreateSwitch("UnitFrames", "TotemBar", "Enable totem bar")
	end

	Window:CreateSection("Scrolling combat text")
	Window:CreateSwitch("UnitFrames", "ScrollingCombatText", "Enable scrolling combat text")
	Window:CreateSlider("UnitFrames", "ScrollingCombatTextFontSize", "Text size of scrolling", 10, 80, 1)
	Window:CreateDropdown("UnitFrames", "ScrollingCombatTextFont", "Set scrolling combat font", "Font")

	Window:CreateSection("Auras")
	Window:CreateSwitch("UnitFrames", "PlayerAuras", "Enable player auras")
	Window:CreateSwitch("UnitFrames", "PlayerAuraBars", "Enable player auras as status bars")
	Window:CreateSwitch("UnitFrames", "OnlySelfBuffs", "Display only our buffs on unitframes")
	Window:CreateSwitch("UnitFrames", "OnlySelfDebuffs", "Display only our debuffs on target")
	Window:CreateSwitch("UnitFrames", "TargetAuras", "Enable target auras")
	Window:CreateSwitch("UnitFrames", "TOTAuras", "Enable target of target auras")
	Window:CreateSwitch("UnitFrames", "PetAuras", "Enable pet auras")
	Window:CreateSwitch("UnitFrames", "FocusAuras", "Enable focus and focus target auras")
	Window:CreateSwitch("UnitFrames", "ArenaAuras", "Enable arena auras")
	Window:CreateSwitch("UnitFrames", "BossAuras", "Enable boss auras")
	Window:CreateSwitch("UnitFrames", "AurasBelow", "Move auras below unitframes")

	Window:CreateSection("Styling")
	Window:CreateSlider("UnitFrames", "StatusBarBackgroundMultiplier", "Health and Power background % opacity", 0, 50, 1)
	Window:CreateSwitch("UnitFrames", "UnlinkCastBar", "Unlink cast bars from unitframes")
	Window:CreateSwitch("UnitFrames", "CastBarIcon", "Display castbar spell icon")
	Window:CreateSwitch("UnitFrames", "CastBarLatency", "Display castbar latency")
	Window:CreateSwitch("UnitFrames", "ComboBar", "Enable combo point bar")
	Window:CreateSwitch("UnitFrames", "Smooth", "Enable smooth health transitions")
	Window:CreateSwitch("UnitFrames", "CombatLog", "Enable combat feedback text")
	Window:CreateSwitch("UnitFrames", "TargetEnemyHostileColor", "Enemy health bar colored by hostile reaction color")
	Window:CreateSwitch("UnitFrames", "Portrait2D", "Use 2D Portrait")
	Window:CreateDropdown("UnitFrames", "Font", "Set unitframe font", "Font")
	Window:CreateColorSelection("UnitFrames", "HealCommSelfColor", "HealComm - my heals")
	Window:CreateColorSelection("UnitFrames", "HealCommOtherColor", "HealComm - others heals")
	Window:CreateSlider("UnitFrames", "RaidIconSize", "Size of raid icons", 16, 32, 1)
	Window:CreateSlider("UnitFrames", "HighlightSize", "Set nameplate highlight size", 5, 15, 1)
	Window:CreateSlider("UnitFrames", "RangeAlpha", "Set out of range alpha (focus/arena/boss)", 0, 1, 0.1)
end

GUI:AddWidgets(General)
GUI:AddWidgets(ActionBars)
GUI:AddWidgets(Auras)
GUI:AddWidgets(Bags)
GUI:AddWidgets(Chat)
GUI:AddWidgets(DataTexts)
GUI:AddWidgets(Loot)
GUI:AddWidgets(Misc)
GUI:AddWidgets(NamePlates)
GUI:AddWidgets(Party)
GUI:AddWidgets(Raid)
GUI:AddWidgets(Tooltips)
GUI:AddWidgets(Textures)
GUI:AddWidgets(UnitFrames)