local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]

------------------------------------------------------------------------------------
-- RAID DEBUFFS (TRACKING LIST)
------------------------------------------------------------------------------------

TukuiUnitFrames.RaidDebuffsTracking = { 
	[GetSpellInfo(159001)] = 6, -- Berserker Rush, Kargath Bladefist
	[GetSpellInfo(156152)] = 6, -- Gushing Wounds, The Butcher
	[GetSpellInfo(159220)] = 6, -- Necrotic Breath, Brackenspore
	[GetSpellInfo(162346)] = 6, -- Crystalline Barrage, Tectus
	[GetSpellInfo(155569)] = 6, -- Injured, Twin Ogrons
	[GetSpellInfo(158241)] = 6, -- Blaze, Twin Ogrons
	[GetSpellInfo(163472)] = 6, -- Dominating Power, Ko'ragh
	[GetSpellInfo(172895)] = 6, -- Expel Magic: Fel, Ko'ragh
	[GetSpellInfo(162185)] = 6, -- Expel Magic: Fire, Ko'ragh
	[GetSpellInfo(162184)] = 6, -- Expel Magic: Shadow, Ko'ragh
	[GetSpellInfo(164004)] = 6, -- Branded: Displacement, Imperator Mar'gok
	[GetSpellInfo(164005)] = 6, -- Branded: Fortification, Imperator Mar'gok
	[GetSpellInfo(164006)] = 6, -- Branded: Replication, Imperator Mar'gok
	[GetSpellInfo(158619)] = 6, -- Fetter, Imperator Mar'gok
	[GetSpellInfo(164176)] = 6, -- Mark of Chaos: Displacement, Imperator Mar'gok
	[GetSpellInfo(164178)] = 6, -- Mark of Chaos: Fortification, Imperator Mar'gok
	[GetSpellInfo(164191)] = 6, -- Mark of Chaos: Replication, Imperator Mar'gok
	[GetSpellInfo(164191)] = 6, -- Mark of Chaos: Replication, Imperator Mar'gok
}

------------------------------------------------------------------------------------
-- RAID BUFFS (SQUARED AURA TRACKING LIST)
------------------------------------------------------------------------------------

TukuiUnitFrames.RaidBuffsTracking = {
	PRIEST = {
		{6788, "TOPRIGHT", {1, 0, 0}, true},	             -- Weakened Soul
		{33076, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},             -- Prayer of Mending
		{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}},                -- Renew
		{17, "TOPLEFT", {0.81, 0.85, 0.1}, true},            -- Power Word: Shield
	},
	
	DRUID = {
		{774, "TOPLEFT", {0.8, 0.4, 0.8}},                   -- Rejuvenation
		{155777, "LEFT", {0.8, 0.4, 0.8}},                   -- Germination
		{8936, "TOPRIGHT", {0.2, 0.8, 0.2}},                 -- Regrowth
		{33763, "BOTTOMLEFT", {0.4, 0.8, 0.2}},              -- Lifebloom
		{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}},               -- Wild Growth
	},
	
	PALADIN = {
		{53563, "TOPLEFT", {0.7, 0.3, 0.7}},	             -- Beacon of Light
		{156910, "TOPRIGHT", {0.7, 0.3, 0.7}},	             -- Beacon of Faith
		{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true}, 	     -- Hand of Protection
		{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},	     -- Hand of Freedom
		{1038, "BOTTOMRIGHT", {0.93, 0.75, 0}, true},  	     -- Hand of Salvation
		{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},	     -- Hand of Sacrifice
		{114163, "BOTTOMLEFT", {0.81, 0.85, 0.1}, true},	 -- Eternal Flame
		{20925, "BOTTOMLEFT", {0.81, 0.85, 0.1}, true},	     -- Sacred Shield
	},
	
	SHAMAN = {
		{61295, "TOPLEFT", {0.7, 0.3, 0.7}},                 -- Riptide
		{974, "TOPRIGHT", {0.2, 0.7, 0.2}},                  -- Earth Shield
	},
	
	MONK = {
		{119611, "TOPLEFT", {0.8, 0.4, 0.8}},	             -- Renewing Mist
		{116849, "TOPRIGHT", {0.2, 0.8, 0.2}},	             -- Life Cocoon
		{124682, "BOTTOMLEFT", {0.4, 0.8, 0.2}},             -- Enveloping Mist
		{124081, "BOTTOMRIGHT", {0.7, 0.4, 0}},              -- Zen Sphere
	},
	
	ALL = {
		{14253, "RIGHT", {0, 1, 0}},                         -- Abolish Poison
	},
}