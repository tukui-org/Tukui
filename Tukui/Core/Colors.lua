local T, C, L = select(2, ...):unpack()

local Framework = select(2, ...)
local oUF = oUF or Framework.oUF
local Class = select(2, UnitClass("player"))

oUF.colors.disconnected = {
	0.1, 0.1, 0.1
}

oUF.colors.runes = {
	[1] = {0.69, 0.31, 0.31},
	[2] = {0.41, 0.80, 1.00},
	[3] = {0.65, 0.63, 0.35},
	[5] = {0.55, 0.57, 0.61}, -- unspec, new char
}

oUF.colors.reaction = {
	[1] = { 0.78, 0.25, 0.25 }, -- Hated
	[2] = { 0.78, 0.25, 0.25 }, -- Hostile
	[3] = { 0.78, 0.25, 0.25 }, -- Unfriendly
	[4] = { 0.85, 0.77, 0.36 }, -- Neutral
	[5] = { 0.29, 0.68, 0.30 }, -- Friendly
	[6] = { 0.29, 0.68, 0.30 }, -- Honored
	[7] = { 0.29, 0.68, 0.30 }, -- Revered
	[8] = { 0.29, 0.68, 0.30 }, -- Exalted
}

oUF.colors.power = {
	["MANA"]              = {0.31, 0.45, 0.63},
	["INSANITY"]          = {0.40, 0.00, 0.80},
	["MAELSTROM"]         = {0.00, 0.50, 1.00},
	["LUNAR_POWER"]       = {0.93, 0.51, 0.93},
	["HOLY_POWER"]        = {0.95, 0.90, 0.60},
	["RAGE"]              = {0.69, 0.31, 0.31},
	["FOCUS"]             = {0.71, 0.43, 0.27},
	["ENERGY"]            = {0.65, 0.63, 0.35},
	["CHI"]               = {0.71, 1.00, 0.92},
	["RUNES"]             = {0.55, 0.57, 0.61},
	["SOUL_SHARDS"]       = {0.50, 0.32, 0.55},
	["FURY"]              = {0.78, 0.26, 0.99},
	["PAIN"]              = {1.00, 0.61, 0.00},
	["RUNIC_POWER"]       = {0.00, 0.82, 1.00},
	["AMMOSLOT"]          = {0.80, 0.60, 0.00},
	["FUEL"]              = {0.00, 0.55, 0.50},
	["POWER_TYPE_STEAM"]  = {0.55, 0.57, 0.61},
	["POWER_TYPE_PYRITE"] = {0.60, 0.09, 0.17},
	["ALTPOWER"]          = {0.00, 1.00, 1.00},
	["ANIMA"]             = {0.83, 0.83, 0.83},
}

oUF.colors.class = {
	["DRUID"]       = { 1.00, 0.49, 0.04 },
	["HUNTER"]      = { 0.67, 0.83, 0.45 },
	["MAGE"]        = { 0.25, 0.78, 0.92 },
	["PALADIN"]     = { 0.96, 0.55, 0.73 },
	["PRIEST"]      = { 0.99, 0.99, 0.99 },
	["ROGUE"]       = { 1.00, 0.96, 0.41 },
	["SHAMAN"]      = { 0.00, 0.44, 0.87 },
	["WARLOCK"]     = { 0.53, 0.53, 0.93 },
	["WARRIOR"]     = { 0.78, 0.61, 0.43 },
	["DEATHKNIGHT"] = { 0.77, 0.12, 0.24 },
	["MONK"]        = { 0.00, 1.00, 0.59 },
	["DEMONHUNTER"] = { 0.64, 0.19, 0.79 },
}

oUF.colors.totems = {
	[1] = {0.78, 0.25, 0.25},
	[2] = {0.78, 0.61, 0.43},
	[3] = {0.25, 0.78, 0.92},
	[4] = {0.99, 0.99, 0.99},
}

oUF.colors.happiness = {
	[1] = {.69,.31,.31},
	[2] = {.65,.63,.35},
	[3] = {.33,.59,.33},
}

T["Colors"] = oUF.colors