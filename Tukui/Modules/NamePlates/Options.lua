local T, C, L = select(2, ...):unpack()

local Plates = T["NamePlates"]

function Plates:RegisterOptions()
	Plates.Options = {}

	Plates.Options.Friendly = {
		displaySelectionHighlight = true,
		displayAggroHighlight = false,
		displayName = true,
		fadeOutOfRange = false,
		--displayStatusText = true,
		displayHealPrediction = false,
		--displayDispelDebuffs = true,
		colorNameBySelection = true,
		colorNameWithExtendedColors = true,
		colorHealthWithExtendedColors = true,
		colorHealthBySelection = true,
		considerSelectionInCombatAsHostile = true,
		smoothHealthUpdates = false,
		displayNameWhenSelected = false,
		displayNameByPlayerNameRules = false,

		selectedBorderColor = CreateColor(1, 1, 1, .35),
		tankBorderColor = CreateColor(1, 1, 0, .6),
		defaultBorderColor = CreateColor(0, 0, 0, 1),
	}

	Plates.Options.Enemy = {
		displaySelectionHighlight = true,
		displayAggroHighlight = false,
		playLoseAggroHighlight = true,
		displayName = true,
		fadeOutOfRange = false,
		displayHealPrediction = false,
		colorNameBySelection = true,
		colorHealthBySelection = true,
		considerSelectionInCombatAsHostile = true,
		smoothHealthUpdates = false,
		displayNameWhenSelected = false,
		displayNameByPlayerNameRules = false,
		greyOutWhenTapDenied = true,

		selectedBorderColor = CreateColor(1, 1, 1, .55),
		tankBorderColor = CreateColor(1, 1, 0, .6),
		defaultBorderColor = CreateColor(0, 0, 0, 1),
	}

	Plates.Options.Player = {
		displaySelectionHighlight = false,
		displayAggroHighlight = false,
		displayName = false,
		fadeOutOfRange = false,
		displayHealPrediction = false,
		colorNameBySelection = true,
		smoothHealthUpdates = false,
		displayNameWhenSelected = false,
		hideCastbar = true,
		healthBarColorOverride = CreateColor(0, 1, 0),

		defaultBorderColor = CreateColor(0, 0, 0, 1),
	}

	Plates.Options.Size = {
		healthBarHeight = C.NamePlates.Height,
		healthBarAlpha = 1,
		castBarHeight = C.NamePlates.CastHeight,
		castBarFontHeight = 9,
		useLargeNameFont = false,

		castBarShieldWidth = 10,
		castBarShieldHeight = 12,

		castIconWidth = C.NamePlates.Height + C.NamePlates.CastHeight + 2,
		castIconHeight = C.NamePlates.Height + C.NamePlates.CastHeight + 2,
	}

	Plates.Options.PlayerSize = {
		healthBarHeight = C.NamePlates.Height,
		healthBarAlpha = 1,
		castBarHeight = C.NamePlates.CastHeight,
		castBarFontHeight = 10,
		useLargeNameFont = false,

		castBarShieldWidth = 10,
		castBarShieldHeight = 12,

		castIconWidth = 10,
		castIconHeight = 10,
	}

	Plates.Options.CastBarColors = {
		StartNormal =  T.Colors.power["ENERGY"],
		StartChannel = T.Colors.power["MANA"],
		Success = {0.0, 1.0, 0.0},
		NonInterrupt = {0.7, 0.7, 0.7},
		Failed = {1.0, 0.0, 0.0},
	}
end