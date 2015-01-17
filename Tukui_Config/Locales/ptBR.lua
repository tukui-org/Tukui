local Locale = GetLocale()

-- Brazilian Locale
if (Locale ~= "ptBR") then
	return
end

-- Some postfix's for certain controls.
local Performance = "\n|cffFF0000Disabling this may increase performance|r" -- For high CPU options
local PerformanceSlight = "\n|cffFF0000Disabling this may slightly increase performance|r" -- For semi-high CPU options
local RestoreDefault = "\n|cffFFFF00Right-click to restore to default|r" -- For color pickers

TukuiConfig["ptBR"] = {
	["General"] = {
		["AutoScale"] = {
			["Name"] = "Auto Scale",
			["Desc"] = "Automatically detect the best scale for your resolution",
		},
		
		["UIScale"] = {
			["Name"] = "UI Scale",
			["Desc"] = "Set a custom UI scale",
		},
		
		["BackdropColor"] = {
			["Name"] = "Backdrop Color",
			["Desc"] = "Set the backdrop color for all Tukui frames"..RestoreDefault,
		},
		
		["BorderColor"] = {
			["Name"] = "Border Color",
			["Desc"] = "Set the border color for all Tukui frames"..RestoreDefault,
		},
		
		["HideShadows"] = {
			["Name"] = "Hide Shadows",
			["Desc"] = "Display or hide shadows on certain Tukui frames",
		},
	},
	
	["ActionBars"] = {
		["Enable"] = {
			["Name"] = "Enable action bars",
			["Desc"] = "Derp",
		},
		
		["EquipBorder"] = {
			["Name"] = "Equipped Item Border",
			["Desc"] = "Display Green Border on Equipped Items",
		},

		["HotKey"] = {
			["Name"] = "Hotkeys",
			["Desc"] = "Display Hotkey text on buttons",
		},
		
		["Macro"] = {
			["Name"] = "Macro keys",
			["Desc"] = "DIsplay macro text on buttons",
		},
		
		["ShapeShift"] = {
			["Name"] = "Stance Bar",
			["Desc"] = "Enable Tukui style stance bar",
		},
		
		["SwitchBarOnStance"] = {
			["Name"] = "Swap main bar on new stance",
			["Desc"] = "Enable main action bar swap when you change stance.",
		},
		
		["Pet"] = {
			["Name"] = "Pet Bar",
			["Desc"] = "Enable Tukui style Pet bar",
		},
		
		["NormalButtonSize"] = {
			["Name"] = "Button Size",
			["Desc"] = "Set a size for action bar buttons",
		},
		
		["PetButtonSize"] = {
			["Name"] = "Pet Button Size",
			["Desc"] = "Set a size for pet action bar buttons",
		},
		
		["ButtonSpacing"] = {
			["Name"] = "Button Spacing",
			["Desc"] = "Set the spacing between action bar buttons",
		},
		
		["OwnShadowDanceBar"] = {
			["Name"] = "Shadow Dance bar",
			["Desc"] = "Use a special bar while in Shadow Dance",
		},
		
		["OwnMetamorphosisBar"] = {
			["Name"] = "Metamorphosis Bar",
			["Desc"] = "Use a special bar while in Metamorphosis",
		},
		
		["OwnWarriorStanceBar"] = {
			["Name"] = "Warrior Stance Bar",
			["Desc"] = "Use a special bar while in Warrior stances",
		},
		
		["HideBackdrop"] = {
			["Name"] = "Hide Backdrop",
			["Desc"] = "Disable the backdrop on action bars",
		},
		
		["Font"] = {
			["Name"] = "Action bar font",
			["Desc"] = "Set a font for the action bars",
		},
	},
	
	["Auras"] = {
		["Enable"] = {
			["Name"] = "Enable Auras",
			["Desc"] = "Derp",
		},
		
		["Consolidate"] = {
			["Name"] = "Consolidate Auras",
			["Desc"] = "Enable consolidated auras",
		},
		
		["Flash"] = {
			["Name"] = "Flash Auras",
			["Desc"] = "Flash auras when their duration is low"..PerformanceSlight,
		},
		
		["ClassicTimer"] = {
			["Name"] = "Classic Timer",
			["Desc"] = "Use the text timer beneath auras",
		},
		
		["HideBuffs"] = {
			["Name"] = "Hide Buffs",
			["Desc"] = "Disable buff display",
		},
		
		["HideDebuffs"] = {
			["Name"] = "Hide Debuffs",
			["Desc"] = "Disable debuff display",
		},
		
		["Animation"] = {
			["Name"] = "Animation",
			["Desc"] = "Show a 'pop in' animation on auras"..PerformanceSlight,
		},
		
		["BuffsPerRow"] = {
			["Name"] = "Buffs Per Row",
			["Desc"] = "Set the number of buffs to show before creating a new row",
		},
		
		["Font"] = {
			["Name"] = "Aura font",
			["Desc"] = "Set a font for auras",
		},
	},
	
	["Bags"] = {
		["Enable"] = {
			["Name"] = "Enable Bags",
			["Desc"] = "Derp",
		},
		
		["ButtonSize"] = {
			["Name"] = "Slot Size",
			["Desc"] = "Set a size for bag slots",
		},
		
		["Spacing"] = {
			["Name"] = "Spacing",
			["Desc"] = "Set the spacing between bag slots",
		},
		
		["ItemsPerRow"] = {
			["Name"] = "Items Per Row",
			["Desc"] = "Set how many slots are on each row of the bags",
		},
		
		["PulseNewItem"] = {
			["Name"] = "Flash New Item(s)",
			["Desc"] = "New items in your bags will have a flash animation",
		},
		
		["Font"] = {
			["Name"] = "Bag font",
			["Desc"] = "Set a font for bags",
		},
		
		["BagFilter"] = {
			["Name"] = "Enable Bag filter",
			["Desc"] = "Automatically deletes useless items from your bags when looted",
			["Default"] = "Automatically deletes useless items from your bags when looted",
		},
	},
	
	["Chat"] = {
		["Enable"] = {
			["Name"] = "Enable Chat",
			["Desc"] = "Derp",
		},
		
		["WhisperSound"] = {
			["Name"] = "Whisper Sound",
			["Desc"] = "Play a sound when receiving a whisper",
		},
		
		["LinkColor"] = {
			["Name"] = "URL Link Color",
			["Desc"] = "Set a color to display URL links in"..RestoreDefault,
		},
		
		["LinkBrackets"] = {
			["Name"] = "URL Link Brackets",
			["Desc"] = "Display URL links wrapped in brackets",
		},
		
		["LootFrame"] = {
			["Name"] = "Loot Frame",
			["Desc"] = "Create a seperate 'Loot' chat frame to the right",
		},
		
		["Background"] = {
			["Name"] = "Chat Background",
			["Desc"] = "Create a background for the left and right chat frames",
		},
		
		["ChatFont"] = {
			["Name"] = "Chat Font",
			["Desc"] = "Set a font to be used by chat",
		},
		
		["TabFont"] = {
			["Name"] = "Chat Tab Font",
			["Desc"] = "Set a font to be used by chat tabs",
		},
		
		["ScrollByX"] = {
			["Name"] = "Mouse Scrolling",
			["Desc"] = "Set the number of lines that the chat will jump when scrolling",
		},
	},
	
	["Cooldowns"] = {
		["Font"] = {
			["Name"] = "Cooldown Font",
			["Desc"] = "Set a font to be used by cooldown timers",
		},
	},
	
	["DataTexts"] = {
		["Battleground"] = {
			["Name"] = "Enable Battleground",
			["Desc"] = "Enable data texts displaying battleground information",
		},
		
		["LocalTime"] = {
			["Name"] = "Local Time",
			["Desc"] = "Use local time in the Time data text, rather than realm time",
		},
		
		["Time24HrFormat"] = {
			["Name"] = "24-Hour Time Format",
			["Desc"] = "Enable to set the Time data text to 24 hour format.",
		},
		
		["NameColor"] = {
			["Name"] = "Label Color",
			["Desc"] = "Set a color for the label of a data text, usually the name"..RestoreDefault,
		},
		
		["ValueColor"] = {
			["Name"] = "Value Color",
			["Desc"] = "Set a color for the value of a data text, usually a number"..RestoreDefault,
		},
		
		["Font"] = {
			["Name"] = "Data Text Font",
			["Desc"] = "Set a font to be used by the data texts",
		},
	},
	
	["Merchant"] = {
		["AutoSellGrays"] = {
			["Name"] = "Auto Sell Grays",
			["Desc"] = "When visiting a vendor, automatically sell gray quality items",
		},
		
		["SellMisc"] = {
			["Name"] = "Sell Misc. Items",
			["Desc"] = "Automatically sells useless items that are not gray quality",
		},
		
		["AutoRepair"] = {
			["Name"] = "Auto Repair",
			["Desc"] = "When visiting a repair merchant, automatically repair our gear",
		},
		
		["UseGuildRepair"] = {
			["Name"] = "Use Guild Repair",
			["Desc"] = "When using 'Auto Repair', use funds from the Guild bank",
		},
	},
	
	["Misc"] = {
		["ThreatBarEnable"] = {
			["Name"] = "Enable Threat Bar",
			["Desc"] = "Derp",
		},
		
		["AltPowerBarEnable"] = {
			["Name"] = "Enable Alt-Power Bar",
			["Desc"] = "Derp",
		},
		
		["ExperienceEnable"] = {
			["Name"] = "Enable Experience Bars",
			["Desc"] = "Enable two experience bars on the left and right of the screen.",
		},
		
		["ReputationEnable"] = {
			["Name"] = "Enable Reputation Bars",
			["Desc"] = "Enable two reputation bars on the left and right of the screen.",
		},
		
		["ErrorFilterEnable"] = {
			["Name"] = "Enable Error Filtering",
			["Desc"] = "Filters out messages from the UIErrorsFrame.",
		},
	},
	
	["NamePlates"] = {
		["Enable"] = {
			["Name"] = "Enable NamePlates",
			["Desc"] = "Derp"..PerformanceSlight,
		},
		
		["Width"] = {
			["Name"] = "Set Width",
			["Desc"] = "Set the width of NamePlates",
		},
		
		["Height"] = {
			["Name"] = "Set Height",
			["Desc"] = "Set the height of NamePlates",
		},
		
		["CastHeight"] = {
			["Name"] = "Cast Bar Height",
			["Desc"] = "Set the height of the cast bar on NamePlates",
		},
		
		["Spacing"] = {
			["Name"] = "Spacing",
			["Desc"] = "Set the spacing between NamePlates and cast bar",
		},
		
		["NonTargetAlpha"] = {
			["Name"] = "Non-Target Alpha",
			["Desc"] = "The alpha of NamePlates that we're not targetting",
		},
		
		["Texture"] = {
			["Name"] = "NamePlates Texture",
			["Desc"] = "Set a texture for nameplates",
		},
		
		["Font"] = {
			["Name"] = "NamePlates Font",
			["Desc"] = "Set a font for nameplates",
		},
		
		["HealthText"] = {
			["Name"] = "Show Health Text",
			["Desc"] = "Add a text in the nameplate which show current health",
		},
	},
	
	["Party"] = {
		["Enable"] = {
			["Name"] = "Enable Party Frames",
			["Desc"] = "Derp",
		},
		
		["Portrait"] = {
			["Name"] = "Portrait",
			["Desc"] = "Display portrait on party frames",
		},
		
		["HealBar"] = {
			["Name"] = "HealComm",
			["Desc"] = "Display a bar showing incoming heals & absorbs",
		},
		
		["ShowPlayer"] = {
			["Name"] = "Show Player",
			["Desc"] = "Show yourself in the party",
		},
		
		["ShowHealthText"] = {
			["Name"] = "Health Text",
			["Desc"] = "Show the amount of health the unit lost.",
		},
		
		["Font"] = {
			["Name"] = "Party Frame Name Font",
			["Desc"] = "Set a font for name text on party frames",
		},
		
		["HealthFont"] = {
			["Name"] = "Party Frame Health Font",
			["Desc"] = "Set a font for health text on party frames",
		},
		
		["PowerTexture"] = {
			["Name"] = "Power Bar Texture",
			["Desc"] = "Set a texture for power bars",
		},
		
		["HealthTexture"] = {
			["Name"] = "Health Bar Texture",
			["Desc"] = "Set a texture for health bars",
		},
		
		["RangeAlpha"] = {
			["Name"] = "Out Of Range Alpha",
			["Desc"] = "Set the transparency of units that are out of range",
		},
	},
	
	["Raid"] = {
		["Enable"] = {
			["Name"] = "Enable Raid Frames",
			["Desc"] = "Derp",
		},
		
		["ShowPets"] = {
			["Name"] = "Show Pets",
			["Desc"] = "Derp",
		},
		
		["Highlight"] = {
			["Name"] = "Highlight",
			["Desc"] = "Highlight your current focus/target",
		},
		
		["MaxUnitPerColumn"] = {
			["Name"] = "Raid members per column",
			["Desc"] = "Change the max number of raid members per column",
		},
		
		["HealBar"] = {
			["Name"] = "HealComm",
			["Desc"] = "Display a bar showing incoming heals & absorbs",
		},
		
		["AuraWatch"] = {
			["Name"] = "Aura Watch",
			["Desc"] = "Display timers for class specific buffs in the corners of the raid frames",
		},
		
		["AuraWatchTimers"] = {
			["Name"] = "Aura Watch Timers",
			["Desc"] = "Display a timer on debuff icons created by Debuff Watch",
		},
		
		["DebuffWatch"] = {
			["Name"] = "Debuff Watch",
			["Desc"] = "Display a big icon on the raid frames when a player has an important debuff",
		},
		
		["RangeAlpha"] = {
			["Name"] = "Out Of Range Alpha",
			["Desc"] = "Set the transparency of units that are out of range",
		},
		
		["ShowRessurection"] = {
			["Name"] = "Show Ressurection Icon",
			["Desc"] = "Display incoming ressurections on players",
		},
		
		["ShowHealthText"] = {
			["Name"] = "Health Text",
			["Desc"] = "Show the amount of health the unit lost.",
		},
		
		["VerticalHealth"] = {
			["Name"] = "Vertical Health",
			["Desc"] = "Display health lost vertically",
		},
		
		["Font"] = {
			["Name"] = "Raid Frame Name Font",
			["Desc"] = "Set a font for name text on raid frames",
		},
		
		["HealthFont"] = {
			["Name"] = "Raid Frame Health Font",
			["Desc"] = "Set a font for health text on raid frames",
		},
		
		["PowerTexture"] = {
			["Name"] = "Power Bar Texture",
			["Desc"] = "Set a texture for power bars",
		},
		
		["HealthTexture"] = {
			["Name"] = "Health Bar Texture",
			["Desc"] = "Set a texture for health bars",
		},
		
		["GroupBy"] = {
			["Name"] = "Group By",
			["Desc"] = "Define how raids groups are sorted",
		},
	},
	
	["Tooltips"] = {
		["Enable"] = {
			["Name"] = "Enable Tooltips",
			["Desc"] = "Derp",
		},
		
		["MouseOver"] = {
			["Name"] = "Mouseover",
			["Desc"] = "Enable mouseover tooltip",
		},
		
		["HideOnUnitFrames"] = {
			["Name"] = "Hide on Unit Frames",
			["Desc"] = "Don't display Tooltips on unit frames",
		},
		
		["UnitHealthText"] = {
			["Name"] = "Display Health Text",
			["Desc"] = "Display health text on the tooltip health bar",
		},
		
		["ShowSpec"] = {
			["Name"] = "Specialization and iLevel",
			["Desc"] = "Display player specialization and ilevel in tooltip",
		},
		
		["HealthFont"] = {
			["Name"] = "Health Bar Font",
			["Desc"] = "Set a font to be used by the health bar below unit tooltips",
		},
		
		["HealthTexture"] = {
			["Name"] = "Health Bar Texture",
			["Desc"] = "Set a texture to be used by the health bar below unit tooltips",
		},
	},
	
	["UnitFrames"] = {
		["Enable"] = {
			["Name"] = "Enable Unit Frames",
			["Desc"] = "Derp",
		},
		
		["TargetEnemyHostileColor"] = {
			["Name"] = "Enemy Target Hostile Color",
			["Desc"] = "Enemy target health bar will be colored by hostility instead of by class color",
		},
		
		["Portrait"] = {
			["Name"] = "Enable Player & Target Portrait",
			["Desc"] = "Enable Player & Target Portrait",
		},
		
		["CastBar"] = {
			["Name"] = "Cast Bar",
			["Desc"] = "Enable cast bar for unit frames",
		},
		
		["UnlinkCastBar"] = {
			["Name"] = "Unlink Cast Bar",
			["Desc"] = "Move player and target cast bar outside unit frame and allow moving of cast bar around the screen",
		},
		
		["CastBarIcon"] = {
			["Name"] = "Cast Bar Icon",
			["Desc"] = "Create an icon beside the cast bar",
		},
		
		["CastBarLatency"] = {
			["Name"] = "Cast Bar Latency",
			["Desc"] = "Display your latency on the cast bar",
		},
		
		["Smooth"] = {
			["Name"] = "Smooth Bars",
			["Desc"] = "Smooth out the updating of the health bars"..PerformanceSlight,
		},
		
		["CombatLog"] = {
			["Name"] = "Combat Feedback",
			["Desc"] = "Display incoming heals and damage on the player unit frame",
		},
		
		["WeakBar"] = {
			["Name"] = "Weakened Soul Bar",
			["Desc"] = "Display a bar to show the Weakened Soul debuff",
		},
		
		["HealBar"] = {
			["Name"] = "HealComm",
			["Desc"] = "Display a bar showing incoming heals & absorbs",
		},
		
		["TotemBar"] = {
			["Name"] = "Totem Bar",
			["Desc"] = "Create a tukui style totem bar",
		},
		
		["ComboBar"] = {
			["Name"] = "Combo Points",
			["Desc"] = "Enable the combo points bar",
		},
		
		["AnticipationBar"] = {
			["Name"] = "Rogue Anticipation Bar",
			["Desc"] = "Display a bar showing rogue anticipation points",
		},
		
		["SerendipityBar"] = {
			["Name"] = "Priest Serendipity Bar",
			["Desc"] = "Display a bar showing priest serendipity stacks",
		},
		
		["OnlySelfDebuffs"] = {
			["Name"] = "Display My Debuffs Only",
			["Desc"] = "Only display our debuffs on the target frame",
		},
		
		["OnlySelfBuffs"] = {
			["Name"] = "Display My Buffs Only",
			["Desc"] = "Only display our buffs on the target frame",
		},
		
		["DarkTheme"] = {
			["Name"] = "Dark Theme",
			["Desc"] = "If enabled, unit frames will be a dark color with class colored power bars",
		},
		
		["Threat"] = {
			["Name"] = "Enable threat display",
			["Desc"] = "Health Bar on party and raid members will turn if they have aggro",
		},
		
		["Arena"] = {
			["Name"] = "Arena Frames",
			["Desc"] = "Display arena opponents when inside a battleground or arena",
		},
		
		["Boss"] = {
			["Name"] = "Boss Frames",
			["Desc"] = "Display boss frames while doing pve",
		},
		
		["TargetAuras"] = {
			["Name"] = "Target Auras",
			["Desc"] = "Display buffs and debuffs on target",
		},
		
		["FocusAuras"] = {
			["Name"] = "Focus Auras",
			["Desc"] = "Display buffs and debuffs on focus",
		},
		
		["FocusTargetAuras"] = {
			["Name"] = "Focus Target Auras",
			["Desc"] = "Display buffs and debuffs on focus target",
		},
		
		["ArenaAuras"] = {
			["Name"] = "Arena Frames Auras",
			["Desc"] = "Display debuffs on arena frames",
		},
		
		["BossAuras"] = {
			["Name"] = "Boss Frames Auras",
			["Desc"] = "Display debuffs on boss frames",
		},
		
		["AltPowerText"] = {
			["Name"] = "AltPower Text",
			["Desc"] = "Display altpower text values on altpower bar",
		},
		
		["Font"] = {
			["Name"] = "Unit Frame Font",
			["Desc"] = "Set a font for unit frames",
		},
		
		["PowerTexture"] = {
			["Name"] = "Power Bar Texture",
			["Desc"] = "Set a texture for power bars",
		},
		
		["HealthTexture"] = {
			["Name"] = "Health Bar Texture",
			["Desc"] = "Set a texture for health bars",
		},
		
		["CastTexture"] = {
			["Name"] = "Cast Bar Texture",
			["Desc"] = "Set a texture for cast bars",
		},
	},
}