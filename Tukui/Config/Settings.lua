local T, C, L = select(2, ...):unpack()

----------------------------------------------------------------
-- Default settings of Tukui
----------------------------------------------------------------

C["General"] = {
	["BackdropColor"] = {0.11, 0.11, 0.11},
	["BorderColor"] = {0, 0, 0},
	["UseGlobal"] = false,
	["HideShadows"] = false,
	["UIScale"] = T.PerfectScale,
	["MinimapScale"] = 100,
	["WorldMapScale"] = 50,

	["Themes"] = {
		["Options"] = {
			["Tukui"] = "Tukui",
			["Tukz"] = "Tukz",
		},

		["Value"] = "Tukui",
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
	["LeftHeight"] = 200,
	["RightWidth"] = 450,
	["RightHeight"] = 200,
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
	["Hour24"] = false,
	["Font"] = "Tukui",
}

C["Loot"] = {
	["Enable"] = true,
	["Font"] = "Tukui",
}

C["Misc"] = {
	["ThreatBar"] = true,
	["WorldMapEnable"] = true,
	["ExperienceEnable"] = true,
	["AutoSellJunk"] = true,
	["AutoRepair"] = true,
	["AFKSaver"] = false,
	["TalkingHeadEnable"] = true,
	["UIErrorSize"] = 16,
	["UIErrorFont"] = "Tukui Outline",
	["ObjectiveTrackerFont"] = "Tukui Outline",
}

C["NamePlates"] = {
	["Enable"] = true,
	["Width"] = 129,
	["Height"] = 14,
	["NameplateCastBar"] = true,
	["Font"] = "Tukui Outline",
	["OnlySelfDebuffs"] = true,
	["QuestIcon"] = true,
	["HighlightColor"] = {1, 1, 0},
	["HighlightSize"] = 10,
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
}

C["Raid"] = {
	["Enable"] = true,
	["DebuffWatch"] = true,
	["ShowPets"] = true,
	["RangeAlpha"] = 0.3,
	["VerticalHealth"] = false,
	["MaxUnitPerColumn"] = 10,
	["Font"] = "Tukui",
	["HealthFont"] = "Tukui Outline",
	["DesaturateNonPlayerBuffs"] = false,
	["RaidBuffs"] = {
		["Options"] = {
			["Hide"] = "Hide",
			["Only my buffs"] = "Self",
			["Only castable buffs"] = "Castable",
			["All buffs"] = "All",
		},
		["Value"] = "Self",
	},
	["ClassRaidBuffs"] = true,
	["WidthSize"] = 79,
	["HeightSize"] = 55,
	["HighlightColor"] = {0, 1, 0},
	["HighlightSize"] = 10,
	["StatusTrack"] = false,
	["GroupBy"] = {
		["Options"] = {
			["Group"] = "GROUP",
			["Class"] = "CLASS",
			["Role"] = "ROLE",
		},

		["Value"] = "GROUP",
	},
}

C["Tooltips"] = {
	["Enable"] = true,
	["HideInCombat"] = false,
	["AlwaysCompareItems"] = false,
	["UnitHealthText"] = true,
	["MouseOver"] = false,
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
	["HealComm"] = true,
	["PlayerAuraBars"] = false,
	["ScrollingCombatText"] = false,
	["ScrollingCombatTextFontSize"] = 32,
	["ScrollingCombatTextFont"] = "Tukui Damage",
	["StatusBarBackgroundMultiplier"] = 25,
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
	["PlayerAuras"] = true,
	["TargetAuras"] = true,
	["FocusAuras"] = true,
	["BossAuras"] = true,
	["ArenaAuras"] = true,
	["TOTAuras"] = true,
	["PetAuras"] = true,
	["AurasBelow"] = false,
	["OnlySelfDebuffs"] = false,
	["OnlySelfBuffs"] = false,
	["Font"] = "Tukui Outline",
	["HealCommSelfColor"] = {0.29, 1, 0.30},
	["HealCommOtherColor"] = {1, .72, 0.30},
	["HealCommAbsorbColor"] = {1, 1, 0.36},
	["RaidIconSize"] = 24,
	["Boss"] = true,
	["Arena"] = true,
	["HighlightSize"] = 10,
	["HighlightColor"] = {0, 1, 0},
	["RangeAlpha"] = 0.3,
	["PlayerHealthTag"] = {
		["Options"] = {
			["Current HP"] = "|cff549654[Tukui:CurrentHP]|r",
			["Percent"] = "|cff549654[perhp]%|r",
			["HP and Percent"] = "|cff549654[Tukui:CurrentHP] - [perhp]%|r",
		},

		["Value"] = "|cff549654[Tukui:CurrentHP]|r",
	},
	["TargetHealthTag"] = {
		["Options"] = {
			["Current HP"] = "|cff549654[Tukui:CurrentHP]|r",
			["Percent"] = "|cff549654[perhp]%|r",
			["HP and Percent"] = "|cff549654[Tukui:CurrentHP] - [perhp]%|r",
		},

		["Value"] = "|cff549654[Tukui:CurrentHP]|r",
	},
	["FocusHealthTag"] = {
		["Options"] = {
			["None"] = "",
			["Current HP"] = "|cff549654[Tukui:CurrentHP]|r",
			["Percent"] = "|cff549654[perhp]%|r",
			["HP and Percent"] = "|cff549654[Tukui:CurrentHP] - [perhp]%|r",
			["Missing HP"] = "|cff549654-[missinghp]|r",
		},

		["Value"] = "|cff549654[perhp]%|r",
	},
	["FocusTargetHealthTag"] = {
		["Options"] = {
			["None"] = "",
			["Current HP"] = "|cff549654[Tukui:CurrentHP]|r",
			["Percent"] = "|cff549654[perhp]%|r",
			["HP and Percent"] = "|cff549654[Tukui:CurrentHP] - [perhp]%|r",
			["Missing HP"] = "|cff549654-[missinghp]|r",
		},

		["Value"] = "|cff549654[perhp]%|r",
	},
	["BossHealthTag"] = {
		["Options"] = {
			["None"] = "",
			["Current HP"] = "|cff549654[Tukui:CurrentHP]|r",
			["Percent"] = "|cff549654[perhp]%|r",
			["HP and Percent"] = "|cff549654[Tukui:CurrentHP] - [perhp]%|r",
			["Missing HP"] = "|cff549654-[missinghp]|r",
		},

		["Value"] = "|cff549654[perhp]%|r",
	},
}
