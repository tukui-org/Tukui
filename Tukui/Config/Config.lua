local T, C, L = select(2, ...):unpack()

----------------------------------------------------------------
-- Default settings of Tukui
----------------------------------------------------------------

C["General"] = {
	["AutoScale"] = true,
	["UIScale"] = 0.71,
	["BackdropColor"] = {0.1, 0.1, 0.1},
	["BorderColor"] = {0.6, 0.6, 0.6},
	["HideShadows"] = false,
}

C["ActionBars"] = {
	["Enable"] = true,
	["EquipBorder"] = true,
	["HotKey"] = false,
	["Macro"] = false,
	["ShapeShift"] = true,
	["Pet"] = true,
	["SwitchBarOnStance"] = true,
	["NormalButtonSize"] = 27,
	["PetButtonSize"] = 25,
	["ButtonSpacing"] = 4,
	["HideBackdrop"] = false,
	["Font"] = "Tukui Outline",
}

C["Auras"] = {
	["Enable"] = true,
	["Consolidate"] = false,
	["Flash"] = false,
	["ClassicTimer"] = false,
	["HideBuffs"] = false,
	["HideDebuffs"] = false,
	["Animation"] = false,
	["BuffsPerRow"] = 12,
	["Font"] = "Tukui Outline",
}

C["Bags"] = {
	["Enable"] = true,
	["ButtonSize"] = 28,
	["Spacing"] = 4,
	["ItemsPerRow"] = 11,
	["PulseNewItem"] = true,
	["Font"] = "Tukui Outline",
	["BagFilter"] = false,
}

C["Chat"] = {
	["Enable"] = true,
	["WhisperSound"] = true,
	["LinkColor"] = {0.08, 1, 0.36},
	["LinkBrackets"] = true,
	["LootFrame"] = true,
	["Background"] = false,
	["ScrollByX"] = 3,
	["TabFont"] = "Tukui",
	["ChatFont"] = "Tukui",
}

C["Cooldowns"] = {
	["Font"] = "Tukui Outline",
}

C["DataTexts"] = {
	["Battleground"] = true,
	["LocalTime"] = true,
	["Time24HrFormat"] = false,
	["NameColor"] = {1, 1, 1},
	["ValueColor"] = {1, 1, 1},
	["Font"] = "Tukui",
}

C["Merchant"] = {
	["AutoSellGrays"] = true,
	["SellMisc"] = true,
	["AutoRepair"] = true,
	["UseGuildRepair"] = false,
}

C["Misc"] = {
	["ThreatBarEnable"] = true,
	["AltPowerBarEnable"] = true,
	["ExperienceEnable"] = true,
	["ReputationEnable"] = true,
	["ErrorFilterEnable"] = true,
	["AutoInviteEnable"] = false,
	["TalkingHeadEnable"] = true,
}

C["NamePlates"] = {
	["Enable"] = true,
	["Width"] = 110,
	["Height"] = 6,
	["CastHeight"] = 4,
	["Texture"] = "Tukui",
	["Font"] = "Tukui Outline",
}

C["Party"] = {
	["Enable"] = true,
	["Portrait"] = true,
	["HealBar"] = true,
	["ShowPlayer"] = true,
	["ShowHealthText"] = true,
	["RangeAlpha"] = 0.3,
	["Font"] = "Tukui UF",
	["HealthFont"] = "Tukui UF Outline",
	["PowerTexture"] = "Tukui",
	["HealthTexture"] = "Tukui",
}

C["Raid"] = {
	["Enable"] = true,
	["HealBar"] = true,
	["AuraWatch"] = true,
	["AuraWatchTimers"] = true,
	["DebuffWatch"] = true,
	["RangeAlpha"] = 0.3,
	["ShowRessurection"] = true,
	["ShowHealthText"] = true,
	["ShowPets"] = true,
	["VerticalHealth"] = false,
	["Highlight"] = true,
	["MaxUnitPerColumn"] = 10,
	["Font"] = "Tukui UF",
	["HealthFont"] = "Tukui UF Outline",
	["PowerTexture"] = "Tukui",
	["HealthTexture"] = "Tukui",
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
	["HideOnUnitFrames"] = false,
	["UnitHealthText"] = true,
	["ShowSpec"] = true,
	["MouseOver"] = false,
	["HealthFont"] = "Tukui Outline",
	["HealthTexture"] = "Tukui",
}

C["UnitFrames"] = {
	["Enable"] = true,
	["Portrait"] = false,
	["CastBar"] = true,
	["ComboBar"] = true,
	["UnlinkCastBar"] = false,
	["CastBarIcon"] = true,
	["CastBarLatency"] = true,
	["Smooth"] = true,
	["TargetEnemyHostileColor"] = true,
	["CombatLog"] = false,
	["HealBar"] = true,
	["TotemBar"] = true,
	["AnticipationBar"] = true,
	["TargetAuras"] = true,
	["FocusAuras"] = true,
	["FocusTargetAuras"] = true,
	["ArenaAuras"] = true,
	["BossAuras"] = true,
	["OnlySelfDebuffs"] = false,
	["OnlySelfBuffs"] = false,
	["Threat"] = false,
	["AltPowerText"] = false,
	["DarkTheme"] = false,
	["Arena"] = true,
	["Boss"] = true,
	["Font"] = "Tukui UF Outline",
	["PowerTexture"] = "Tukui",
	["HealthTexture"] = "Tukui",
	["CastTexture"] = "Tukui",
}
