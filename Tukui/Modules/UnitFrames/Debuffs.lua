local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]
local Debuffs = {}
local Priority = function(priorityOverride) return {["enable"] = true, ["priority"] = priorityOverride or 0, ["stackThreshold"] = 0} end

------------------------------------------------------------------------------------
-- RAID DEBUFFS (DEFAULT LISTING)
------------------------------------------------------------------------------------

Debuffs["PvE"] = {
	["type"] = "Whitelist",
	["spells"] = {
		
	-------------
	-- Phase 1 --
	-------------

	-- Karazhan
		-- Trash
			[29679] = Priority(4), -- Bad Poetry
			[29505] = Priority(3), -- Banshee Shriek
			[32441] = Priority(4), -- Brittle Bones
			[29690] = Priority(5), -- Drunken Skull Crack
			[29321] = Priority(4), -- Fear
			[29935] = Priority(4), -- Gaping Maw
			[29670] = Priority(5), -- Ice Tomb
			[29491] = Priority(4), -- Impending Betrayal
			[41580] = Priority(3), -- Net
			[29676] = Priority(5), -- Rolling Pin
			[29490] = Priority(5), -- Seduction
			[29684] = Priority(5), -- Shield Slam
			[29300] = Priority(5), -- Sonic Blast
			[29900] = Priority(5), -- Unstable Magic (Good Debuff)
		-- Attumen the Huntsman
			[29833] = Priority(3), -- Intangible Presence
			[29711] = Priority(4), -- Knockdown
		-- Moroes
			[34694] = Priority(4), -- Blind
			[37066] = Priority(5), -- Garrote
			[29425] = Priority(4), -- Gouge
			[13005] = Priority(3), -- Hammer of Justice (Baron Rafe Dreuger)
			[29572] = Priority(3), -- Mortal Strike (Lord Robin Daris)
		-- Maiden of Virtue
			[29522] = Priority(3), -- Holy Fire
			[29511] = Priority(4), -- Repentance
		-- Animal Bosses
		-- Hyakiss the Lurker
			[29901] = Priority(3), -- Acidic Fang
			[29896] = Priority(4), -- Hyakiss' Web
		-- Rokad the Ravager
			[29906] = Priority(3), -- Ravage
		-- Shadikith the Glider
			[29903] = Priority(4), -- Dive
			[29904] = Priority(3), -- Sonic Burst
		-- Opera Event (Wizard of Oz)
			[31042] = Priority(5), -- Shred Armor
			[31046] = Priority(4), -- Brain Bash
		-- Opera Event (The Big Bad Wolf)
			[30753] = Priority(5), -- Red Riding Hood
			[30752] = Priority(3), -- Terrifying Howl
			[30761] = Priority(4), -- Wide Swipe
		-- Opera Event (Romulo and Julianne)
			[30890] = Priority(3), -- Blinding Passion
			[30822] = Priority(4), -- Poisoned Thrust
			[30889] = Priority(5), -- Powerful Attraction
		-- The Curator
		-- Shade of Aran
			[29991] = Priority(5), -- Chains of Ice
			[29954] = Priority(3), -- Frostbolt
			[30035] = Priority(4), -- Mass Slow
			[29990] = Priority(5), -- Slow
		-- Terestian Illhoof
			[30053] = Priority(3), -- Amplify Flames
			[30115] = Priority(4), -- Sacrifice
		-- Netherspite
			[37063] = Priority(3), -- Void Zone
		-- Chess Event
		-- Prince Malchezaar
			[39095] = Priority(3), -- Amplify Damage
			[30843] = Priority(5), -- Enfeeble
			[30854] = Priority(4), -- Shadow Word: Pain (Tank)
			[30898] = Priority(4), -- Shadow Word: Pain (Raid)
			[30901] = Priority(3), -- Sunder Armor
		-- Nightbane
			[36922] = Priority(5), -- Bellowing Roar
			[30129] = Priority(6), -- Charred Earth
			[30130] = Priority(3), -- Distracting Ash
			[37098] = Priority(5), -- Rain of Bones
			[30127] = Priority(4), -- Searing Cinders
			[30210] = Priority(3), -- Smoldering Breath
			[25653] = Priority(3), -- Tail Sweep
	-- Gruul's Lair
		-- Trash
			[22884] = Priority(4), -- Psychic Scream
		-- High King Maulgar
		-- Blindeye the Seer
		-- Kiggler the Crazed
			[33175] = Priority(3), -- Arcane Shock
			[33173] = Priority(5), -- Greater Polymorph
		-- Krosh Firehand
			[33061] = Priority(3), -- Blast Wave
		-- Olm the Summoner
			[33129] = Priority(4), -- Dark Decay
			[33130] = Priority(5), -- Death Coil
		-- High King Maulgar
			[16508] = Priority(5), -- Intimidating Roar
		-- Gruul the Dragonkiller
			[36240] = Priority(4), -- Cave In
	-- Magtheridon's Lair
		-- Trash
			[34437] = Priority(4), -- Death Coil
			[34435] = Priority(3), -- Rain of Fire
			[34439] = Priority(5), -- Unstable Affliction
		-- Magtheridon
			[30410] = Priority(3), -- Shadow Grasp
		
	-------------
	-- Phase 2 --
	-------------
		
	-- Serpentshrine Cavern
		-- Trash
			[38634] = Priority(3), -- Arcane Lightning
			[39032] = Priority(4), -- Initial Infection
			[38572] = Priority(3), -- Mortal Cleave
			[38635] = Priority(3), -- Rain of Fire
			[39042] = Priority(5), -- Rampent Infection
			[39044] = Priority(4), -- Serpentshrine Parasite
			[38591] = Priority(4), -- Shatter Armor
			[38491] = Priority(3), -- Silence
		-- Hydross the Unstable
			[38246] = Priority(3), -- Vile Sludge
			[38235] = Priority(4), -- Water Tomb
		-- The Lurker Below
		-- Morogrim Tidewalker
			[38049] = Priority(4), -- Watery Grave
			[37850] = Priority(4), -- Watery Grave
		-- Fathom-Lord Karathress
			[39261] = Priority(3), -- Gusting Winds
			[29436] = Priority(4), -- Leeching Throw
		-- Leotheras the Blind
			[37675] = Priority(3), -- Chaos Blast
			[37749] = Priority(5), -- Consuming Madness
			[37676] = Priority(4), -- Insidious Whisper
			[37641] = Priority(3), -- Whirlwind
		-- Lady Vashj
			[38316] = Priority(3), -- Entangle
			[38280] = Priority(5), -- Static Charge
	-- Tempest Keep: The Eye
		-- Trash
			[37133] = Priority(4), -- Arcane Buffet
			[37132] = Priority(3), -- Arcane Shock
			[37122] = Priority(5), -- Domination
			[37135] = Priority(5), -- Domination
			[37120] = Priority(4), -- Fragmentation Bomb
			[13005] = Priority(3), -- Hammer of Justice
			[39077] = Priority(3), -- Hammer of Justice
			[37279] = Priority(3), -- Rain of Fire
			[37123] = Priority(4), -- Saw Blade
			[37118] = Priority(5), -- Shell Shock
			[37160] = Priority(3), -- Silence
		-- Al'ar
			[35410] = Priority(4), -- Melt Armor
		-- Void Reaver
		-- High Astromancer Solarian
			[34322] = Priority(4), -- Psychic Scream
			[42783] = Priority(5), -- Wrath of the Astromancer (Patch 2.2.0)
		-- Kael'thas Sunstrider
			[36965] = Priority(4), -- Rend
			[30225] = Priority(4), -- Silence
			[44863] = Priority(5), -- Bellowing Roar
			[37018] = Priority(4), -- Conflagration
			[37027] = Priority(5), -- Remote Toy
			[36991] = Priority(4), -- Rend
			[36797] = Priority(5), -- Mind Control
		
	-------------
	-- Phase 3 --
	-------------
		
	-- The Battle for Mount Hyjal
		-- Rage Winterchill
		-- Anetheron
		-- Kaz'rogal
		-- Azgalor
		-- Archimonde
	-- Black Temple
		-- High Warlord Naj'entus
		-- Supremus
		-- Shade of Akama
		-- Teron Gorefiend
		-- Gurtogg Bloodboil
		-- Reliquary of Souls
		-- Mother Shahraz
		-- Illidari Council
		-- Illidan Stormrage
		
	-------------
	-- Phase 4 --
	-------------
		
	-- Zul'Aman
		-- Nalorakk
		-- Jan'alai
		-- Akil'zon
		-- Halazzi
		-- Hexxlord Jin'Zakk
		-- Zul'jin
		
	-------------
	-- Phase 5 --
	-------------
		
	-- Sunwell Plateau
		-- Kalecgos
		-- Sathrovarr
		-- Brutallus
		-- Felmyst
		-- Alythess
		-- Sacrolash
		-- M'uru
		-- Kil'Jaeden
	},
}

Debuffs["PvP"] = {
	["type"] = "Whitelist",
	["spells"] = {
	-- Druid
		[5211] = Priority(3), -- Bash
		[16922] = Priority(3), -- Celestial Focus
		[33786] = Priority(3), -- Cyclone
		[339] = Priority(2), -- Entangling Roots
		[19975] = Priority(2), -- Entangling Roots (Nature's Grasp)
		[45334] = Priority(2), -- Feral Charge Effect
		[2637] = Priority(3), -- Hibernate
		[22570] = Priority(3), -- Maim
		[9005] = Priority(3), -- Pounce
	-- Hunter
		[19306] = Priority(2), -- Counterattack
		[19185] = Priority(2), -- Entrapment
		[3355] = Priority(3), -- Freezing Trap
		[2637] = Priority(3), -- Hibernate
		[19410] = Priority(3), -- Improved Concussive Shot
		[19229] = Priority(2), -- Improved Wing Clip
		[24394] = Priority(3), -- Intimidation
		[19503] = Priority(3), -- Scatter Shot
		[34490] = Priority(3), -- Silencing Shot
		[4167] = Priority(2), -- Web (Pet)
		[19386] = Priority(3), -- Wyvern Sting
	-- Mage
		[31661] = Priority(3), -- Dragon's Breath
		[33395] = Priority(2), -- Freeze (Water Elemental)
		[12494] = Priority(2), -- Frostbite
		[122] = Priority(2), -- Frost Nova
		[12355] = Priority(3), -- Impact
		[118] = Priority(3), -- Polymorph
		[28272] = Priority(3), -- Polymorph: Pig
		[28271] = Priority(3), -- Polymorph: Turtle
		[18469] = Priority(3), -- Silenced - Improved Counterspell
	-- Paladin
		[853] = Priority(3), -- Hammer of Justice
		[20066] = Priority(3), -- Repentance
		[20170] = Priority(3), -- Stun (Seal of Justice Proc)
		[10326] = Priority(3), -- Turn Evil
		[2878] = Priority(3), -- Turn Undead
	-- Priest
		[15269] = Priority(3), -- Blackout
		[44041] = Priority(3), -- Chastise
		[605] = Priority(3), -- Mind Control
		[8122] = Priority(3), -- Psychic Scream
		[9484] = Priority(3), -- Shackle Undead
		[15487] = Priority(3), -- Silence
	-- Rogue
		[2094] = Priority(3), -- Blind
		[1833] = Priority(3), -- Cheap Shot
		[32747] = Priority(3), -- Deadly Throw Interrupt
		[1330] = Priority(3), -- Garrote - Silence
		[1776] = Priority(3), -- Gouge
		[408] = Priority(3), -- Kidney Shot
		[14251] = Priority(3), -- Riposte
		[6770] = Priority(3), -- Sap
		[18425] = Priority(3), -- Silenced - Improved Kick
	-- Warlock
		[6789] = Priority(3), -- Death Coil
		[5782] = Priority(3), -- Fear
		[5484] = Priority(3), -- Howl of Terror
		[30153] = Priority(3), -- Intercept Stun (Felguard)
		[18093] = Priority(3), -- Pyroclasm
		[6358] = Priority(3), -- Seduction (Succubus)
		[30283] = Priority(3), -- Shadowfury
		[24259] = Priority(3), -- Spell Lock (Felhunter)
	-- Warrior
		[7922] = Priority(3), -- Charge Stun
		[12809] = Priority(3), -- Concussion Blow
		[676] = Priority(3), -- Disarm
		[23694] = Priority(2), -- Improved Hamstring
		[5246] = Priority(3), -- Intimidating Shout
		[20253] = Priority(3), -- Intercept Stun
		[12798] = Priority(3), -- Revenge Stun
		[18498] = Priority(3), -- Shield Bash - Silenced
	-- Racial
		[28730]  = Priority(3), -- Arcane Torrent
		[20549] = Priority(3), -- War Stomp
	-- Others
		[5530] = Priority(3), -- Mace Specialization
	},
}

T["UnitFrames"]["Debuffs"] = Debuffs