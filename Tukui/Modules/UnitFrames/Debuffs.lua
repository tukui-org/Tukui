local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]
local Debuffs = {}
local Priority = function(priorityOverride) return {["enable"] = true, ["priority"] = priorityOverride or 0, ["stackThreshold"] = 0} end

------------------------------------------------------------------------------------
-- RAID DEBUFFS (DEFAULT LISTING)
------------------------------------------------------------------------------------

if T.Retail then
	Debuffs["PvE"] = {
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

	Debuffs["PvP"] = {
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
else
	Debuffs["PvE"] = {
		["type"] = "Whitelist",
		["spells"] = {

		---------------
		-- Pre-Patch --
		---------------

			-- Onyxia's Lair
				[18431] = Priority(2), --Bellowing Roar
			-- Molten Core
				[19703] = Priority(2), --Lucifron's Curse
				[19408] = Priority(2), --Panic
				[19716] = Priority(2), --Gehennas' Curse
				[20277] = Priority(2), --Fist of Ragnaros
				[20475] = Priority(6), --Living Bomb
				[19695] = Priority(6), --Inferno
				[19659] = Priority(2), --Ignite Mana
				[19714] = Priority(2), --Deaden Magic
				[19713] = Priority(2), --Shazzrah's Curse
			-- Blackwing's Lair
				[23023] = Priority(2), --Conflagration
				[18173] = Priority(2), --Burning Adrenaline
				[24573] = Priority(2), --Mortal Strike
				[23340] = Priority(2), --Shadow of Ebonroc
				[23170] = Priority(2), --Brood Affliction: Bronze
				[22687] = Priority(2), --Veil of Shadow
			-- Zul'Gurub
				[23860] = Priority(2), --Holy Fire
				[22884] = Priority(2), --Psychic Scream
				[23918] = Priority(2), --Sonic Burst
				[24111] = Priority(2), --Corrosive Poison
				[21060] = Priority(2), --Blind
				[24328] = Priority(2), --Corrupted Blood
				[16856] = Priority(2), --Mortal Strike
				[24664] = Priority(2), --Sleep
				[17172] = Priority(2), --Hex
				[24306] = Priority(2), --Delusions of Jin'do
				[24099] = Priority(2), --Poison Bolt Volley
			-- Ahn'Qiraj Ruins
				[25646] = Priority(2), --Mortal Wound
				[25471] = Priority(2), --Attack Order
				[96] = Priority(2), --Dismember
				[25725] = Priority(2), --Paralyze
				[25189] = Priority(2), --Enveloping Winds
			-- Ahn'Qiraj Temple
				[785] = Priority(2), --True Fulfillment
				[26580] = Priority(2), --Fear
				[26050] = Priority(2), --Acid Spit
				[26180] = Priority(2), --Wyvern Sting
				[26053] = Priority(2), --Noxious Poison
				[26613] = Priority(2), --Unbalancing Strike
				[26029] = Priority(2), --Dark Glare
			-- Naxxramas
				[28732] = Priority(2), --Widow's Embrace
				[28622] = Priority(2), --Web Wrap
				[28169] = Priority(2), --Mutating Injection
				[29213] = Priority(2), --Curse of the Plaguebringer
				[28835] = Priority(2), --Mark of Zeliek
				[27808] = Priority(2), --Frost Blast
				[28410] = Priority(2), --Chains of Kel'Thuzad
				[27819] = Priority(2), --Detonate Mana

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
end

T["UnitFrames"]["Debuffs"] = Debuffs
