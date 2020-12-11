local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]

UnitFrames.DebuffsTracking = {}

------------------------------------------------------------------------------------
-- Locales functions and tables
------------------------------------------------------------------------------------

local function Priority(priorityOverride)
	return {["enable"] = true, ["priority"] = priorityOverride or 0, ["stackThreshold"] = 0}
end

------------------------------------------------------------------------------------
-- RAID DEBUFFS (TRACKING LIST)
------------------------------------------------------------------------------------

UnitFrames.DebuffsTracking["PvE"] = {
	["type"] = "Whitelist",
	["spells"] = {
	-- Mythic+ Dungeons
		-- General Affix
		[209858] = Priority(), -- Necrotic
		[226512] = Priority(), -- Sanguine
		[240559] = Priority(), -- Grievous
		[240443] = Priority(), -- Bursting
		-- Shadowlands Affix
		[342494] = Priority(), -- Belligerent Boast (Prideful)

	-- Shadowlands Dungeons
		-- Halls of Atonement
		[335338] = Priority(), -- Ritual of Woe
		[326891] = Priority(), -- Anguish
		[329321] = Priority(), -- Jagged Swipe 1
		[344993] = Priority(), -- Jagged Swipe 2
		[319603] = Priority(), -- Curse of Stone
		[319611] = Priority(), -- Turned to Stone
		[325876] = Priority(), -- Curse of Obliteration
		[326632] = Priority(), -- Stony Veins
		[323650] = Priority(), -- Haunting Fixation
		[326874] = Priority(), -- Ankle Bites
		[340446] = Priority(), -- Mark of Envy
		-- Mists of Tirna Scithe
		[325027] = Priority(), -- Bramble Burst
		[323043] = Priority(), -- Bloodletting
		[322557] = Priority(), -- Soul Split
		[331172] = Priority(), -- Mind Link
		[322563] = Priority(), -- Marked Prey
		[322487] = Priority(), -- Overgrowth 1
		[322486] = Priority(), -- Overgrowth 2
		[328756] = Priority(), -- Repulsive Visage
		[325021] = Priority(), -- Mistveil Tear
		[321891] = Priority(), -- Freeze Tag Fixation
		[325224] = Priority(), -- Anima Injection
		[326092] = Priority(), -- Debilitating Poison
		[325418] = Priority(), -- Volatile Acid
		-- Plaguefall
		[336258] = Priority(), -- Solitary Prey
		[331818] = Priority(), -- Shadow Ambush
		[329110] = Priority(), -- Slime Injection
		[325552] = Priority(), -- Cytotoxic Slash
		[336301] = Priority(), -- Web Wrap
		[322358] = Priority(), -- Burning Strain
		[322410] = Priority(), -- Withering Filth
		[328180] = Priority(), -- Gripping Infection
		[320542] = Priority(), -- Wasting Blight
		[340355] = Priority(), -- Rapid Infection
		[328395] = Priority(), -- Venompiercer
		[320512] = Priority(), -- Corroded Claws
		[333406] = Priority(), -- Assassinate
		[332397] = Priority(), -- Shroudweb
		[330069] = Priority(), -- Concentrated Plague
		-- The Necrotic Wake
		[321821] = Priority(), -- Disgusting Guts
		[323365] = Priority(), -- Clinging Darkness
		[338353] = Priority(), -- Goresplatter
		[333485] = Priority(), -- Disease Cloud
		[338357] = Priority(), -- Tenderize
		[328181] = Priority(), -- Frigid Cold
		[320170] = Priority(), -- Necrotic Bolt
		[323464] = Priority(), -- Dark Ichor
		[323198] = Priority(), -- Dark Exile
		[343504] = Priority(), -- Dark Grasp
		[343556] = Priority(), -- Morbid Fixation 1
		[338606] = Priority(), -- Morbid Fixation 2
		[324381] = Priority(), -- Chill Scythe
		[320573] = Priority(), -- Shadow Well
		[333492] = Priority(), -- Necrotic Ichor
		[334748] = Priority(), -- Drain FLuids
		[333489] = Priority(), -- Necrotic Breath
		[320717] = Priority(), -- Blood Hunger
		-- Theater of Pain
		[333299] = Priority(), -- Curse of Desolation 1
		[333301] = Priority(), -- Curse of Desolation 2
		[319539] = Priority(), -- Soulless
		[326892] = Priority(), -- Fixate
		[321768] = Priority(), -- On the Hook
		[323825] = Priority(), -- Grasping Rift
		[342675] = Priority(), -- Bone Spear
		[323831] = Priority(), -- Death Grasp
		[330608] = Priority(), -- Vile Eruption
		[330868] = Priority(), -- Necrotic Bolt Volley
		[323750] = Priority(), -- Vile Gas
		[323406] = Priority(), -- Jagged Gash
		[330700] = Priority(), -- Decaying Blight
		[319626] = Priority(), -- Phantasmal Parasite
		[324449] = Priority(), -- Manifest Death
		[341949] = Priority(), -- Withering Blight
		-- Sanguine Depths
		[326827] = Priority(), -- Dread Bindings
		[326836] = Priority(), -- Curse of Suppression
		[322554] = Priority(), -- Castigate
		[321038] = Priority(), -- Burden Soul
		[328593] = Priority(), -- Agonize
		[325254] = Priority(), -- Iron Spikes
		[335306] = Priority(), -- Barbed Shackles
		[322429] = Priority(), -- Severing Slice
		[334653] = Priority(), -- Engorge
		-- Spires of Ascension
		[338729] = Priority(), -- Charged Stomp
		[338747] = Priority(), -- Purifying Blast
		[327481] = Priority(), -- Dark Lance
		[322818] = Priority(), -- Lost Confidence
		[322817] = Priority(), -- Lingering Doubt
		[324205] = Priority(), -- Blinding Flash
		[331251] = Priority(), -- Deep Connection
		[328331] = Priority(), -- Forced Confession
		[341215] = Priority(), -- Volatile Anima
		[323792] = Priority(), -- Anima Field
		[317661] = Priority(), -- Insidious Venom
		[330683] = Priority(), -- Raw Anima
		[328434] = Priority(), -- Intimidated
		-- De Other Side
		[320786] = Priority(), -- Power Overwhelming
		[334913] = Priority(), -- Master of Death
		[325725] = Priority(), -- Cosmic Artifice
		[328987] = Priority(), -- Zealous
		[334496] = Priority(), -- Soporific Shimmerdust
		[339978] = Priority(), -- Pacifying Mists
		[323692] = Priority(), -- Arcane Vulnerability
		[333250] = Priority(), -- Reaver
		[330434] = Priority(), -- Buzz-Saw 1
		[320144] = Priority(), -- Buzz-Saw 2
		[331847] = Priority(), -- W-00F
		[327649] = Priority(), -- Crushed Soul
		[331379] = Priority(), -- Lubricate
		[332678] = Priority(), -- Gushing Wound
		[322746] = Priority(), -- Corrupted Blood
		[323687] = Priority(), -- Arcane Lightning
		[323877] = Priority(), -- Echo Finger Laser X-treme
		[334535] = Priority(), -- Beak Slice

	-- Castle Nathria
		-- Shriekwing
		[328897] = Priority(), -- Exsanguinated
		[330713] = Priority(), -- Reverberating Pain
		[329370] = Priority(), -- Deadly Descent
		[336494] = Priority(), -- Echo Screech
		-- Huntsman Altimor
		[335304] = Priority(), -- Sinseeker
		[334971] = Priority(), -- Jagged Claws
		[335111] = Priority(), -- Huntsman's Mark 1
		[335112] = Priority(), -- Huntsman's Mark 2
		[335113] = Priority(), -- Huntsman's Mark 3
		[334945] = Priority(), -- Bloody Thrash
		-- Hungering Destroyer
		[334228] = Priority(), -- Volatile Ejection
		[329298] = Priority(), -- Gluttonous Miasma
		-- Lady Inerva Darkvein
		[325936] = Priority(), -- Shared Cognition
		[335396] = Priority(), -- Hidden Desire
		[324983] = Priority(), -- Shared Suffering
		[324982] = Priority(), -- Shared Suffering (Partner)
		[332664] = Priority(), -- Concentrate Anima
		[325382] = Priority(), -- Warped Desires
		-- Sun King's Salvation
		[333002] = Priority(), -- Vulgar Brand
		[326078] = Priority(), -- Infuser's Boon
		[325251] = Priority(), -- Sin of Pride
		-- Artificer Xy'mox
		[327902] = Priority(), -- Fixate
		[326302] = Priority(), -- Stasis Trap
		[325236] = Priority(), -- Glyph of Destruction
		[327414] = Priority(), -- Possession
		-- The Council of Blood
		[327052] = Priority(), -- Drain Essence 1
		[327773] = Priority(), -- Drain Essence 2
		[346651] = Priority(), -- Drain Essence Mythic
		[328334] = Priority(), -- Tactical Advance
		[330848] = Priority(), -- Wrong Moves
		[331706] = Priority(), -- Scarlet Letter
		[331636] = Priority(), -- Dark Recital 1
		[331637] = Priority(), -- Dark Recital 2
		-- Sludgefist
		[335470] = Priority(), -- Chain Slam
		[339181] = Priority(), -- Chain Slam (Root)
		[331209] = Priority(), -- Hateful Gaze
		[335293] = Priority(), -- Chain Link
		[335270] = Priority(), -- Chain This One!
		[335295] = Priority(), -- Shattering Chain
		-- Stone Legion Generals
		[334498] = Priority(), -- Seismic Upheaval
		[337643] = Priority(), -- Unstable Footing
		[334765] = Priority(), -- Heart Rend
		[333377] = Priority(), -- Wicked Mark
		[334616] = Priority(), -- Petrified
		[334541] = Priority(), -- Curse of Petrification
		[339690] = Priority(), -- Crystalize
		[342655] = Priority(), -- Volatile Anima Infusion
		[342698] = Priority(), -- Volatile Anima Infection
		-- Sire Denathrius
		[326851] = Priority(), -- Blood Price
		[327796] = Priority(), -- Night Hunter
		[327992] = Priority(), -- Desolation
		[328276] = Priority(), -- March of the Penitent
		[326699] = Priority(), -- Burden of Sin
		[329181] = Priority(), -- Wracking Pain
		[335873] = Priority(), -- Rancor
		[329951] = Priority(), -- Impale
	},
}

------------------------------------------------------------------------------------
-- IMPORTANT PVP SPELL TO DISPELL
------------------------------------------------------------------------------------

UnitFrames.DebuffsTracking["PvP"] = {
	["type"] = "Whitelist",
	["spells"] = {
	-- Death Knight
		[204085] = Priority(5), -- Deathchill
		[233395] = Priority(5), -- Frozen Center
	-- Demon Hunter
		[217832] = Priority(5), -- Imprison
		[179057] = Priority(5), -- Chaos Nova
		[205630] = Priority(5), -- Illidan's Grasp
		[208618] = Priority(5), -- Illidan's Grasp (Afterward)
	-- Druid
		[102359] = Priority(5), -- Mass Entanglement
		[339]    = Priority(5), -- Entangling Roots
		[2637]   = Priority(5), -- Hibernate
	-- Hunter
		[3355]   = Priority(5), -- Freezing Trap
		[203337] = Priority(5), -- Freezing Trap (Survival PvP)
		[209790] = Priority(5), -- Freezing Arrow
		[117526] = Priority(5), -- Binding Shot
	-- Mage
		[61721]  = Priority(5), -- Rabbit (Poly)
		[61305]  = Priority(5), -- Black Cat (Poly)
		[28272]  = Priority(5), -- Pig (Poly)
		[28271]  = Priority(5), -- Turtle (Poly)
		[126819] = Priority(5), -- Porcupine (Poly)
		[161354] = Priority(5), -- Monkey (Poly)
		[161353] = Priority(5), -- Polar bear (Poly)
		[61780]  = Priority(5),  -- Turkey (Poly)
		[161355] = Priority(5), -- Penguin (Poly)
		[161372] = Priority(5), -- Peacock (Poly)
		[277787] = Priority(5), -- Direhorn (Poly)
		[277792] = Priority(5), -- Bumblebee (Poly)
		[118]    = Priority(5), -- Polymorph
		[82691]  = Priority(5), -- Ring of Frost
		[31661]  = Priority(5), -- Dragon's Breath
		[122]    = Priority(5), -- Frost Nova
		[33395]  = Priority(5), -- Freeze
		[157997] = Priority(5), -- Ice Nova
		[198121] = Priority(5), -- Forstbite
	-- Monk
		[198909] = Priority(5), -- Song of Chi-Ji
		[202274] = Priority(5), -- Incendiary Brew
		--[123407] = Priority(5), -- Spinning Fire Blossom
	-- Paladin
		[853]    = Priority(5), -- Hammer of Justice
		[20066]  = Priority(5), -- Repentance
		[105421] = Priority(5), -- Blinding Light
		[31935]  = Priority(5), -- Avenger's Shield
		[217824] = Priority(5), -- Shield of Virtue
		[205290] = Priority(5), -- Wake of Ashes
	-- Priest
		[9484]   = Priority(5), -- Shackle Undead
		[226943] = Priority(5), -- Mind Bomb
		[605]    = Priority(5), -- Mind Control
		[8122]   = Priority(5), -- Psychic Scream
		[15487]  = Priority(5), -- Silence
		[64044]  = Priority(5), -- Psychic Horror
	-- Rogue
		-- Nothing to track
	-- Shaman
		[51514]  = Priority(5), -- Hex
		[211015] = Priority(5), -- Hex (Cockroach)
		[211010] = Priority(5), -- Hex (Snake)
		[211004] = Priority(5), -- Hex (Spider)
		[210873] = Priority(5), -- Hex (Compy)
		[196942] = Priority(5), -- Hex (Voodoo Totem)
		[269352] = Priority(5), -- Hex (Skeletal Hatchling)
		[277778] = Priority(5), -- Hex (Zandalari Tendonripper)
		[277784] = Priority(5), -- Hex (Wicker Mongrel)
		[118905] = Priority(5), -- Static Charge
		[204399] = Priority(5), -- Earthfury
		[64695]  = Priority(5), -- Earthgrab
	-- Warlock
		[710]    = Priority(5), -- Banish
		[6789]   = Priority(5), -- Mortal Coil
		[118699] = Priority(5), -- Fear
		[6358]   = Priority(5), -- Seduction (Succub)
		[30283]  = Priority(5), -- Shadowfury
		[233582] = Priority(5), -- Entrenched in Flame
	-- Warrior
		-- Nothing to track
	},
}

------------------------------------------------------------------------------------
-- ALL PVP CROWD CONTROL
------------------------------------------------------------------------------------

UnitFrames.DebuffsTracking["CrowdControl"] = {
	["type"] = "Whitelist",
	["spells"] = {
	-- Death Knight
		[47476]  = Priority(2), -- Strangulate
		[108194] = Priority(4), -- Asphyxiate UH
		[221562] = Priority(4), -- Asphyxiate Blood
		[207171] = Priority(4), -- Winter is Coming
		[206961] = Priority(3), -- Tremble Before Me
		[207167] = Priority(4), -- Blinding Sleet
		[212540] = Priority(1), -- Flesh Hook (Pet)
		[91807]  = Priority(1), -- Shambling Rush (Pet)
		[204085] = Priority(1), -- Deathchill
		[233395] = Priority(1), -- Frozen Center
		[212332] = Priority(4), -- Smash (Pet)
		[212337] = Priority(4), -- Powerful Smash (Pet)
		[91800]  = Priority(4), -- Gnaw (Pet)
		[91797]  = Priority(4), -- Monstrous Blow (Pet)
		[210141] = Priority(3), -- Zombie Explosion
	-- Demon Hunter
		[207685] = Priority(4), -- Sigil of Misery
		[217832] = Priority(3), -- Imprison
		[221527] = Priority(5), -- Imprison (Banished version)
		[204490] = Priority(2), -- Sigil of Silence
		[179057] = Priority(3), -- Chaos Nova
		[211881] = Priority(4), -- Fel Eruption
		[205630] = Priority(3), -- Illidan's Grasp
		[208618] = Priority(3), -- Illidan's Grasp (Afterward)
		[213491] = Priority(4), -- Demonic Trample (it's this one or the other)
		[208645] = Priority(4), -- Demonic Trample
	-- Druid
		[81261]  = Priority(2), -- Solar Beam
		[5211]   = Priority(4), -- Mighty Bash
		[163505] = Priority(4), -- Rake
		[203123] = Priority(4), -- Maim
		[202244] = Priority(4), -- Overrun
		[99]     = Priority(4), -- Incapacitating Roar
		[33786]  = Priority(5), -- Cyclone
		[209753] = Priority(5), -- Cyclone Balance
		[45334]  = Priority(1), -- Immobilized
		[102359] = Priority(1), -- Mass Entanglement
		[339]    = Priority(1), -- Entangling Roots
		[2637]   = Priority(1), -- Hibernate
		[102793] = Priority(1), -- Ursol's Vortex
	-- Hunter
		[202933] = Priority(2), -- Spider Sting (it's this one or the other)
		[233022] = Priority(2), -- Spider Sting
		[213691] = Priority(4), -- Scatter Shot
		[19386]  = Priority(3), -- Wyvern Sting
		[3355]   = Priority(3), -- Freezing Trap
		[203337] = Priority(5), -- Freezing Trap (Survival PvPT)
		[209790] = Priority(3), -- Freezing Arrow
		[24394]  = Priority(4), -- Intimidation
		[117526] = Priority(4), -- Binding Shot
		[190927] = Priority(1), -- Harpoon
		[201158] = Priority(1), -- Super Sticky Tar
		[162480] = Priority(1), -- Steel Trap
		[212638] = Priority(1), -- Tracker's Net
		[200108] = Priority(1), -- Ranger's Net
	-- Mage
		[61721]  = Priority(3), -- Rabbit (Poly)
		[61305]  = Priority(3), -- Black Cat (Poly)
		[28272]  = Priority(3), -- Pig (Poly)
		[28271]  = Priority(3), -- Turtle (Poly)
		[126819] = Priority(3), -- Porcupine (Poly)
		[161354] = Priority(3), -- Monkey (Poly)
		[161353] = Priority(3), -- Polar bear (Poly)
		[61780] = Priority(3),  -- Turkey (Poly)
		[161355] = Priority(3), -- Penguin (Poly)
		[161372] = Priority(3), -- Peacock (Poly)
		[277787] = Priority(3), -- Direhorn (Poly)
		[277792] = Priority(3), -- Bumblebee (Poly)
		[118]    = Priority(3), -- Polymorph
		[82691]  = Priority(3), -- Ring of Frost
		[31661]  = Priority(3), -- Dragon's Breath
		[122]    = Priority(1), -- Frost Nova
		[33395]  = Priority(1), -- Freeze
		[157997] = Priority(1), -- Ice Nova
		[228600] = Priority(1), -- Glacial Spike
		[198121] = Priority(1), -- Forstbite
	-- Monk
		[119381] = Priority(4), -- Leg Sweep
		[202346] = Priority(4), -- Double Barrel
		[115078] = Priority(4), -- Paralysis
		[198909] = Priority(3), -- Song of Chi-Ji
		[202274] = Priority(3), -- Incendiary Brew
		[233759] = Priority(2), -- Grapple Weapon
		[123407] = Priority(1), -- Spinning Fire Blossom
		[116706] = Priority(1), -- Disable
		[232055] = Priority(4), -- Fists of Fury (it's this one or the other)
	-- Paladin
		[853]    = Priority(3), -- Hammer of Justice
		[20066]  = Priority(3), -- Repentance
		[105421] = Priority(3), -- Blinding Light
		[31935]  = Priority(2), -- Avenger's Shield
		[217824] = Priority(2), -- Shield of Virtue
		[205290] = Priority(3), -- Wake of Ashes
	-- Priest
		[9484]   = Priority(3), -- Shackle Undead
		[200196] = Priority(4), -- Holy Word: Chastise
		[200200] = Priority(4), -- Holy Word: Chastise
		[226943] = Priority(3), -- Mind Bomb
		[605]    = Priority(5), -- Mind Control
		[8122]   = Priority(3), -- Psychic Scream
		[15487]  = Priority(2), -- Silence
		[64044]  = Priority(1), -- Psychic Horror
	-- Rogue
		[2094]   = Priority(4), -- Blind
		[6770]   = Priority(4), -- Sap
		[1776]   = Priority(4), -- Gouge
		[1330]   = Priority(2), -- Garrote - Silence
		[207777] = Priority(2), -- Dismantle
		[199804] = Priority(4), -- Between the Eyes
		[408]    = Priority(4), -- Kidney Shot
		[1833]   = Priority(4), -- Cheap Shot
		[207736] = Priority(5), -- Shadowy Duel (Smoke effect)
		[212182] = Priority(5), -- Smoke Bomb
	-- Shaman
		[51514]  = Priority(3), -- Hex
		[211015] = Priority(3), -- Hex (Cockroach)
		[211010] = Priority(3), -- Hex (Snake)
		[211004] = Priority(3), -- Hex (Spider)
		[210873] = Priority(3), -- Hex (Compy)
		[196942] = Priority(3), -- Hex (Voodoo Totem)
		[269352] = Priority(3), -- Hex (Skeletal Hatchling)
		[277778] = Priority(3), -- Hex (Zandalari Tendonripper)
		[277784] = Priority(3), -- Hex (Wicker Mongrel)
		[118905] = Priority(3), -- Static Charge
		[77505]  = Priority(4), -- Earthquake (Knocking down)
		[118345] = Priority(4), -- Pulverize (Pet)
		[204399] = Priority(3), -- Earthfury
		[204437] = Priority(3), -- Lightning Lasso
		[157375] = Priority(4), -- Gale Force
		[64695]  = Priority(1), -- Earthgrab
	-- Warlock
		[710]    = Priority(5), -- Banish
		[6789]   = Priority(3), -- Mortal Coil
		[118699] = Priority(3), -- Fear
		[6358]   = Priority(3), -- Seduction (Succub)
		[171017] = Priority(4), -- Meteor Strike (Infernal)
		[22703]  = Priority(4), -- Infernal Awakening (Infernal CD)
		[30283]  = Priority(3), -- Shadowfury
		[89766]  = Priority(4), -- Axe Toss
		[233582] = Priority(1), -- Entrenched in Flame
	-- Warrior
		[5246]   = Priority(4), -- Intimidating Shout
		[132169] = Priority(4), -- Storm Bolt
		[132168] = Priority(4), -- Shockwave
		[199085] = Priority(4), -- Warpath
		[105771] = Priority(1), -- Charge
		[199042] = Priority(1), -- Thunderstruck
		[236077] = Priority(2), -- Disarm
	-- Racial
		[20549]  = Priority(4), -- War Stomp
		[107079] = Priority(4), -- Quaking Palm
	},
}

