local T, C, L = select(2, ...):unpack()

----------------------------------------------------------------
-- Default settings of Tukui
----------------------------------------------------------------

C["General"] = {
	["BackdropColor"] = {0.11, 0.11, 0.11},
	["BorderColor"] = {0, 0, 0},
	["ClassColorBorder"] = false,
	["UseGlobal"] = false,
	["HideShadows"] = false,
	["UIScale"] = T.PerfectScale,
	["MinimapScale"] = 100,
	["WorldMapScale"] = 60,
	["Profiles"] = {
		["Options"] = {},
	},

	["Themes"] = {
		["Options"] = {
			["Tukui"] = "Tukui",
			["Tukz"] = "Tukz",
		},

		["Value"] = "Tukui",
	},

	["GlobalFont"] = {
		["Options"] = {
			["Express Way"] = "Interface\\AddOns\\Tukui\\Medias\\Fonts\\Expressway.ttf",
			["PT Sans Narrow"] = "Interface\\AddOns\\Tukui\\Medias\\Fonts\\PtSansNarrow.ttf",
		},

		["Value"] = "Interface\\AddOns\\Tukui\\Medias\\Fonts\\Expressway.ttf",
	},
}

C["ActionBars"] = {
	["Enable"] = true,
	["BottomLeftBar"] = true,
	["BottomRightBar"] = true,
	["RightBar"] = false,
	["LeftBar"] = false,
	["HotKey"] = false,
	["EquipBorder"] = true,
	["Macro"] = false,
	["ShapeShift"] = true,
	["Pet"] = true,
	["SwitchBarOnStance"] = true,
	["Bar1ButtonsPerRow"] = 6,
	["Bar2ButtonsPerRow"] = 6,
	["Bar3ButtonsPerRow"] = 6,
	["Bar4ButtonsPerRow"] = 1,
	["Bar5ButtonsPerRow"] = 1,
	["Bar1NumButtons"] = 12,
	["Bar2NumButtons"] = 12,
	["Bar3NumButtons"] = 12,
	["Bar4NumButtons"] = 12,
	["Bar5NumButtons"] = 12,
	["BarPetButtonsPerRow"] = 10,
	["NormalButtonSize"] = 32,
	["PetButtonSize"] = 32,
	["ButtonSpacing"] = 4,
	["ShowBackdrop"] = true,
	["AutoAddNewSpell"] = false,
	["ProcAnim"] = true,
	["Font"] = "Tukui Outline",
	["MultiCastBar"] = true,
}

C["Auras"] = {
	["Enable"] = true,
	["Flash"] = true,
	["ClassicTimer"] = false,
	["HideBuffs"] = false,
	["HideDebuffs"] = false,
	["Animation"] = false,
	["BuffsPerRow"] = 12,
	["Font"] = "Tukui Outline",
}

C["Bags"] = {
	["Enable"] = true,
	["IdentifyQuestItems"] = true,
	["FlashNewItems"] = true,
	["ItemLevel"] = true,
	["SortToBottom"] = false,
	["ButtonSize"] = 32,
	["Spacing"] = 4,
	["ItemsPerRow"] = 12,
}

C["Chat"] = {
	["Enable"] = true,
	["Bubbles"] = {
		["Options"] = {
			["All"] = "All",
			["Exclude Party"] = "Exclude Party",
			["None"] = "None",
		},

		["Value"] = "All",
	},
	["BubblesTextSize"] = 9,
	["SkinBubbles"] = true,
	["LeftWidth"] = 450,
	["LeftHeight"] = 204,
	["RightWidth"] = 450,
	["RightHeight"] = 204,
	["RightChatAlignRight"] = true,
	["BackgroundAlpha"] = 70,
	["WhisperSound"] = true,
	["ShortChannelName"] = true,
	["LinkColor"] = {0.08, 1, 0.36},
	["LinkBrackets"] = true,
	["ScrollByX"] = 3,
	["TextFading"] = false,
	["TextFadingTimer"] = 60,
	["TabFont"] = "Tukui",
	["ChatFont"] = "Tukui",
	["BubblesNames"] = true,
	["LogMax"] = 250,
}

C["Cooldowns"] = {
	["Font"] = "Tukui Outline",
}

C["DataTexts"] = {
	["Battleground"] = true,
	["HideFriendsNotPlaying"] = true,
	["NameColor"] = {1, 1, 1},
	["ValueColor"] = {1, 1, 1},
	["ClassColor"] = false,
	["HighlightColor"] = {1, 1, 0},
	["Font"] = "Tukui",
}

C["Loot"] = {
	["Enable"] = true,
	["Font"] = "Tukui",
}

C["Misc"] = {
	["BlizzardMicroMenu"] = false,
	["ItemLevel"] = true,
	["ThreatBar"] = true,
	["WorldMapEnable"] = true,
	["FadeWorldMapAlpha"] = 100,
	["ExperienceEnable"] = true,
	["AutoSellJunk"] = true,
	["AutoRepair"] = true,
	["AFKSaver"] = false,
	["TalkingHeadEnable"] = true,
	["UIErrorSize"] = 16,
	["UIErrorFont"] = "Tukui Outline",
	["MicroToggle"] = {
		["Options"] = {
			["None"] = "",
			["M"] = "M",
			["SHIFT-M"] = "SHIFT-M",
			["CTRL-M"] = "CTRL-M",
			["ALT-M"] = "ALT-M",
		},

		["Value"] = "ALT-M",
	},
	["MicroStyle"] = {
		["Options"] = {
			["Minimalist"] = "Minimalist",
			["Game Menu"] = "Game Menu",
			["Blizzard"] = "Blizzard",
			["None"] = "None",
		},

		["Value"] = "Game Menu",
	},
}

C["Maps"] = {
	["MinimapTracking"] = false,
	["MinimapCoords"] = false,
}

C["NamePlates"] = {
	["Enable"] = true,
	["Width"] = 128,
	["Height"] = 14,
	["NotSelectedAlpha"] = 100,
	["SelectedScale"] = 100,
	["NameplateCastBar"] = true,
	["Font"] = "Tukui Outline",
	["OnlySelfDebuffs"] = true,
	["QuestIcon"] = true,
	["ClassIcon"] = true,
	["HighlightColor"] = {1, 1, 0},
	["AggroColor1"] = {0.50, 0.50, 0.50},
	["AggroColor2"] = {1, 1, 0.5},
	["AggroColor3"] = {1.00, 0.50, 0.00},
	["AggroColor4"] = {1, 0.2, 0.2},
	["HighlightSize"] = 10,
	["ColorThreat"] = false,
	["HealthTag"] = {
		["Options"] = {
			["None"] = "",
			["Current HP"] = "|cff549654[Tukui:CurrentHP]|r",
			["Percent"] = "|cff549654[perhp]%|r",
			["HP and Percent"] = "|cff549654[Tukui:CurrentHP] - [perhp]%|r",
		},

		["Value"] = "",
	},
}

C["Party"] = {
	["Enable"] = false,
	["ShowPets"] = false,
	["ShowPlayer"] = true,
	["ShowHealthText"] = true,
	["ShowManaText"] = false,
	["RangeAlpha"] = 0.3,
	["Font"] = "Tukui Outline",
	["HealthFont"] = "Tukui Outline",
	["HighlightColor"] = {0, 1, 0},
	["HighlightSize"] = 10,
	["HealthTag"] = {
		["Options"] = {
			["None"] = "",
			["Current HP"] = "|cff549654[Tukui:CurrentHP]|r",
			["Percent"] = "|cff549654[perhp]%|r",
			["HP and Percent"] = "|cff549654[Tukui:CurrentHP] - [perhp]%|r",
			["Missing HP"] = "|cffFF0000[missinghp]|r",
		},

		["Value"] = "|cff549654[perhp]%|r",
	},
}

C["Raid"] = {
	["Enable"] = true,
	["DebuffWatch"] = true,
	["DebuffWatchDefault"] = true,
	["ShowPets"] = true,
	["RangeAlpha"] = 0.3,
	["VerticalHealth"] = false,
	["MaxUnitPerColumn"] = 5,
	["Raid40MaxUnitPerColumn"] = 10,
	["Font"] = "Tukui",
	["HealthFont"] = "Tukui Outline",
	["DesaturateBuffs"] = false,
	["RaidBuffsStyle"] = {
		["Options"] = {
			["Aura Track"] = "Aura Track",
			["Standard"] = "Standard",
			["None"] = "None",
		},
		["Value"] = "Aura Track",
	},
	["RaidBuffs"] = {
		["Options"] = {
			["Only my buffs"] = "Self",
			["Only castable buffs"] = "Castable",
			["All buffs"] = "All",
		},
		["Value"] = "Self",
	},
	["WidthSize"] = 99,
	["HeightSize"] = 69,
	["Raid40WidthSize"] = 79,
	["Raid40HeightSize"] = 55,
	["Padding"] = 10,
	["Padding40"] = 10,
	["HighlightColor"] = {0, 1, 0},
	["HighlightSize"] = 10,
	["AuraTrackIcons"] = true,
	["AuraTrackSpellTextures"] = true,
	["AuraTrackThickness"] = 5,
	["GroupBy"] = {
		["Options"] = {
			["Group"] = "GROUP",
			["Class"] = "CLASS",
			["Role"] = "ROLE",
		},

		["Value"] = "GROUP",
	},
	["HealthTag"] = {
		["Options"] = {
			["None"] = "",
			["Current HP"] = "|cff549654[Tukui:CurrentHP]|r",
			["Percent"] = "|cff549654[perhp]%|r",
			["HP and Percent"] = "|cff549654[Tukui:CurrentHP] - [perhp]%|r",
			["Missing HP"] = "|cffFF0000[missinghp]|r",
		},

		["Value"] = "",
	},
}

C["Tooltips"] = {
	["Enable"] = true,
	["DisplayTitle"] = false,
	["HideInCombat"] = false,
	["AlwaysCompareItems"] = false,
	["UnitHealthText"] = true,
	["MouseOver"] = false,
	["ItemBorderColor"] = true,
	["UnitBorderColor"] = true,
	["HealthFont"] = "Tukui Outline",
}

C["Textures"] = {
	["QuestProgressTexture"] = "Tukui",
	["TTHealthTexture"] = "Tukui",
	["UFPowerTexture"] = "Tukui",
	["UFHealthTexture"] = "Tukui",
	["UFCastTexture"] = "Tukui",
	["UFPartyPowerTexture"] = "Tukui",
	["UFPartyHealthTexture"] = "Tukui",
	["UFRaidPowerTexture"] = "Tukui",
	["UFRaidHealthTexture"] = "Tukui",
	["NPHealthTexture"] = "Tukui",
	["NPPowerTexture"] = "Tukui",
	["NPCastTexture"] = "Tukui",
}

C["UnitFrames"] = {
	["Enable"] = true,
	["TotemBar"] = T.MyClass == "SHAMAN" and true or false,
	["TotemBarStyle"] = {
		["Options"] = {
			["On Screen"] = "On Screen",
			["On Player"] = "On Player",
		},

		["Value"] = "On Screen",
	},
	["ClassBar"] = true,
	["PlayerAuraBars"] = false,
	["ScrollingCombatText"] = false,
	["ScrollingCombatTextIcon"] = true,
	["ScrollingCombatTextFontSize"] = 22,
	["ScrollingCombatTextRadius"] = 120,
	["ScrollingCombatTextDisplayTime"] = 1.5,
	["ScrollingCombatTextFont"] = "Tukui Outline",
	["ScrollingCombatTextAnim"] = {
		["Options"] = {
			["diagonal"] = "diagonal",
			["fountain"] = "fountain",
			["horizontal"] = "horizontal",
			["random"] = "random",
			["static"] = "static",
			["vertical"] = "vertical",
		},

		["Value"] = "fountain",
	},
	["StatusBarBackgroundMultiplier"] = 25,
	["PowerTick"] = true,
	["Portrait2D"] = true,
	["OOCNameLevel"] = true,
	["OOCPetNameLevel"] = false,
	["Portrait"] = false,
	["CastBar"] = true,
	["ComboBar"] = true,
	["UnlinkCastBar"] = false,
	["CastBarIcon"] = true,
	["CastBarLatency"] = true,
	["Smooth"] = true,
	["TargetEnemyHostileColor"] = true,
	["CombatLog"] = true,
	["PlayerBuffs"] = true,
	["PlayerDebuffs"] = true,
	["TargetBuffs"] = true,
	["TargetDebuffs"] = true,
	["DesaturateDebuffs"] = true,
	["FlashRemovableBuffs"] = true,
	["FocusAuras"] = true,
	["BossAuras"] = true,
	["ArenaAuras"] = true,
	["TOTAuras"] = true,
	["PetAuras"] = true,
	["AurasBelow"] = false,
	["OnlySelfDebuffs"] = false,
	["OnlySelfBuffs"] = false,
	["Font"] = "Tukui Outline",
	["CastingColor"] = {0.29, 0.77, 0.30},
	["ChannelingColor"] = {0.29, 0.77, 0.30},
	["NotInterruptibleColor"] = {0.85, 0.09, 0.09},
	["HealComm"] = true,
	["HealCommSelfColor"] = {0.29, 1, 0.30},
	["HealCommOtherColor"] = {1, .72, 0.30},
	["HealCommAbsorbColor"] = {207/255, 181/255, 59/255},
	["RaidIconSize"] = 24,
	["Boss"] = true,
	["Arena"] = true,
	["HighlightSize"] = 10,
	["HighlightColor"] = {0, 1, 0},
	["RangeAlpha"] = 0.3,
	["Smoothing"] = true,
	["PlayerHealthTag"] = {
		["Options"] = {
			["Current HP"] = "|cff549654[Tukui:CurrentHP]|r",
			["Percent"] = "|cff549654[perhp]%|r",
			["HP and Percent"] = "|cff549654[Tukui:CurrentHP] - [perhp]%|r",
			["HP / Max HP and Percent"] = "|cff549654[Tukui:CurrentHP] / [Tukui:MaxHP] - [perhp]%|r",
		},

		["Value"] = "|cff549654[Tukui:CurrentHP]|r",
	},
	["TargetHealthTag"] = {
		["Options"] = {
			["Current HP"] = "|cff549654[Tukui:CurrentHP]|r",
			["Percent"] = "|cff549654[perhp]%|r",
			["HP and Percent"] = "|cff549654[Tukui:CurrentHP] - [perhp]%|r",
			["HP / Max HP and Percent"] = "|cff549654[Tukui:CurrentHP] / [Tukui:MaxHP] - [perhp]%|r",
		},

		["Value"] = "|cff549654[Tukui:CurrentHP]|r",
	},
	["FocusHealthTag"] = {
		["Options"] = {
			["None"] = "",
			["Current HP"] = "|cff549654[Tukui:CurrentHP]|r",
			["Percent"] = "|cff549654[perhp]%|r",
			["HP and Percent"] = "|cff549654[Tukui:CurrentHP] - [perhp]%|r",
			["HP / Max HP and Percent"] = "|cff549654[Tukui:CurrentHP] / [Tukui:MaxHP] - [perhp]%|r",
			["Missing HP"] = "|cffFF0000[missinghp]|r",
		},

		["Value"] = "|cff549654[perhp]%|r",
	},
	["FocusTargetHealthTag"] = {
		["Options"] = {
			["None"] = "",
			["Current HP"] = "|cff549654[Tukui:CurrentHP]|r",
			["Percent"] = "|cff549654[perhp]%|r",
			["HP and Percent"] = "|cff549654[Tukui:CurrentHP] - [perhp]%|r",
			["HP / Max HP and Percent"] = "|cff549654[Tukui:CurrentHP] / [Tukui:MaxHP] - [perhp]%|r",
			["Missing HP"] = "|cffFF0000[missinghp]|r",
		},

		["Value"] = "|cff549654[perhp]%|r",
	},
	["BossHealthTag"] = {
		["Options"] = {
			["None"] = "",
			["Current HP"] = "|cff549654[Tukui:CurrentHP]|r",
			["Percent"] = "|cff549654[perhp]%|r",
			["HP and Percent"] = "|cff549654[Tukui:CurrentHP] - [perhp]%|r",
			["HP / Max HP and Percent"] = "|cff549654[Tukui:CurrentHP] / [Tukui:MaxHP] - [perhp]%|r",
			["Missing HP"] = "|cffFF0000[missinghp]|r",
		},

		["Value"] = "|cff549654[perhp]%|r",
	},
}
