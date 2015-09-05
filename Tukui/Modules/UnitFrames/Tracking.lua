local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]

------------------------------------------------------------------------------------
-- RAID DEBUFFS (TRACKING LIST)
------------------------------------------------------------------------------------

TukuiUnitFrames.RaidDebuffsTracking = {
	-- Proving Grounds (Healing)
	[GetSpellInfo(145263)] = 6, -- Chomp, Large Illusionary Tunneler
	
	-- Highmaul
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
	
	-- Blackrock Foundry
	[GetSpellInfo(155365)] = 6, -- Pinned Down, Beastlord Darmac
	[GetSpellInfo(155061)] = 6, -- Rend and Tear, Beastlord Darmac
	[GetSpellInfo(155399)] = 6, -- Conflagration, Beastlord Darmac
	[GetSpellInfo(165195)] = 6, -- Prototype Pulse Grenade, Operator Thogar
	[GetSpellInfo(164271)] = 6, -- Penetrating Shot, Iron Maidens
	[GetSpellInfo(155080)] = 6, -- Inferno Slice, Gruul
	[GetSpellInfo(155326)] = 6, -- Petrifying Slam, Gruul
	[GetSpellInfo(156934)] = 6, -- Rupture, Blast Furnace
	[GetSpellInfo(155225)] = 6, -- Melt, Blast Furnace
	[GetSpellInfo(181488)] = 6, -- Marked for Death, Blackhand
	[GetSpellInfo(156743)] = 6, -- Impaled, Blackhand
	[GetSpellInfo(156047)] = 6, -- Slagged, Blackhand
	[GetSpellInfo(156401)] = 6, -- Molten Slag, Blackhand
	
	-- Hellfire Citadel
	[GetSpellInfo(184369)] = 6, -- Howling Axe, Hellfire Assault
	[GetSpellInfo(180079)] = 6, -- Felfire Munitions, Hellfire Assault
	[GetSpellInfo(182280)] = 6, -- Artillery, Iron Reaver
	[GetSpellInfo(182074)] = 6, -- Immolation, Iron Reaver
	[GetSpellInfo(182001)] = 6, -- Unstable Orb, Iron Reaver
	[GetSpellInfo(187819)] = 6, -- Crush, Kormrok
	[GetSpellInfo(181345)] = 6, -- Foul Crush, Kormrok
	[GetSpellInfo(184652)] = 6, -- Reap, High Council
	[GetSpellInfo(188929)] = 6, -- Heart Seeker, Kilrogg
	[GetSpellInfo(180389)] = 6, -- Heart Seeker DoT, Kilrogg
	[GetSpellInfo(181488)] = 6, -- Vision of Death, Kilrogg
	[GetSpellInfo(179867)] = 6, -- Gorefiend's Corruption, Gorefiend
	[GetSpellInfo(181295)] = 6, -- Digest, Gorefiend
	[GetSpellInfo(179908)] = 6, -- Shared Fate, Gorefiend
	[GetSpellInfo(179909)] = 6, -- Shared Fate, Gorefiend
	[GetSpellInfo(181957)] = 6, -- Phantasmal Winds, Shadow-Lord Iskar
	[GetSpellInfo(182200)] = 6, -- Fel Chakram, Shadow-Lord Iskar
	[GetSpellInfo(182178)] = 6, -- Fel Chakram, Shadow-Lord Iskar
	[GetSpellInfo(182325)] = 6, -- Phantasmal Wounds, Shadow-Lord Iskar
	[GetSpellInfo(185239)] = 6, -- Radiance of Anzu, Shadow-Lord Iskar
	[GetSpellInfo(185510)] = 6, -- Dark Bindings, Shadow-Lord Iskar
	[GetSpellInfo(182600)] = 6, -- Fel Fire, Shadow-Lord Iskar
	[GetSpellInfo(179219)] = 6, -- Phantasmal Fel Bomb, Shadow-Lord Iskar
	[GetSpellInfo(181753)] = 6, -- Fel Bomb, Shadow-Lord Iskar
	[GetSpellInfo(185237)] = 6, -- Touch of Harm, Tyrant Velhari
	[GetSpellInfo(185238)] = 6, -- Touch of Harm, Tyrant Velhari
	[GetSpellInfo(185241)] = 6, -- Edict of Condemnation, Tyrant Velhari
	[GetSpellInfo(180526)] = 6, -- Font of Corruption, Tyrant Velhari
	[GetSpellInfo(181508)] = 6, -- Seed of Destruction, Fel Lord Zakuun
	[GetSpellInfo(181653)] = 6, -- Fel Crystals, Fel Lord Zakuun
	[GetSpellInfo(179428)] = 6, -- Rumbling Fissure, Fel Lord Zakuun
	[GetSpellInfo(182008)] = 6, -- Latent Energy, Fel Lord Zakuun
	[GetSpellInfo(179407)] = 6, -- Disembodied, Fel Lord Zakuun
	[GetSpellInfo(189030)] = 6, -- Befouled (Red), Fel Lord Zakuun
	[GetSpellInfo(189031)] = 6, -- Befouled (Orange), Fel Lord Zakuun
	[GetSpellInfo(189032)] = 6, -- Befouled (Green), Fel Lord Zakuun
	[GetSpellInfo(188208)] = 6, -- Ablaze, Xhul'horac
	[GetSpellInfo(186073)] = 6, -- Felsinged, Xhul'horac
	[GetSpellInfo(186407)] = 6, -- Fel Surge, Xhul'horac
	[GetSpellInfo(186500)] = 6, -- Chains of Fel, Xhul'horac
	[GetSpellInfo(186063)] = 6, -- Wasting Void, Xhul'horac
	[GetSpellInfo(186333)] = 6, -- Void Surge, Xhul'horac
	[GetSpellInfo(181275)] = 6, -- Curse of the Legion, Mannoroth
	[GetSpellInfo(181099)] = 6, -- Mark of Doom, Mannoroth
	[GetSpellInfo(181597)] = 6, -- Mannoroth's Gaze, Mannoroth
	[GetSpellInfo(182006)] = 6, -- Empowered Mannoroth's Gaze, Mannoroth
	[GetSpellInfo(181841)] = 6, -- Shadowforce, Mannoroth
	[GetSpellInfo(182088)] = 6, -- Empowered Shadowforce, Mannoroth
	[GetSpellInfo(184964)] = 6, -- Shackled Torment, Archimonde
	[GetSpellInfo(186123)] = 6, -- Wrought Chaos, Archimonde
	[GetSpellInfo(185014)] = 6, -- Focused Chaos, Archimonde
	[GetSpellInfo(186952)] = 6, -- Nether Banish, Archimonde
	[GetSpellInfo(186961)] = 6, -- Nether Banish, Archimonde
	[GetSpellInfo(189891)] = 6, -- Nether Tear, Archimonde
	[GetSpellInfo(183634)] = 6, -- Shadowfel Burst, Archimonde
	[GetSpellInfo(189895)] = 6, -- Void Star Fixate, Archimonde
	[GetSpellInfo(190049)] = 6, -- Nether Corruption, Archimonde
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