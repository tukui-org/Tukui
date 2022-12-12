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
			----------------------------------------------------------
			-------------------- Mythic+ Specific --------------------
			----------------------------------------------------------
			-- General Affixes
				[209858] = Priority(), -- Necrotic
				[226512] = Priority(), -- Sanguine
				[240559] = Priority(), -- Grievous
				[240443] = Priority(), -- Bursting
			-- Shadowlands Season 4
				[373364] = Priority(), -- Vampiric Claws
				[373429] = Priority(), -- Carrion Swarm
				[373370] = Priority(), -- Nightmare Cloud
				[373391] = Priority(), -- Nightmare
				[373570] = Priority(), -- Hypnosis
				[373607] = Priority(), -- Shadowy Barrier (Hypnosis)
				[373509] = Priority(), -- Shadow Claws (Stacking)
			-- Dragonflight Season 1
				[396369] = Priority(), -- Mark of Lightning
				[396364] = Priority(), -- Mark of Wind
			----------------------------------------------------------
			---------------- Dragonflight (Season 1) -----------------
			----------------------------------------------------------
			-- Court of Stars
				[207278] = Priority(), -- Arcane Lockdown
				[209516] = Priority(), -- Mana Fang
				[209512] = Priority(), -- Disrupting Energy
				[211473] = Priority(), -- Shadow Slash
				[207979] = Priority(), -- Shockwave
				[207980] = Priority(), -- Disintegration Beam 1
				[207981] = Priority(), -- Disintegration Beam 2
				[211464] = Priority(), -- Fel Detonation
				[208165] = Priority(), -- Withering Soul
				[209413] = Priority(), -- Suppress
				[209027] = Priority(), -- Quelling Strike
			-- Halls of Valor
				[197964] = Priority(), -- Runic Brand Orange
				[197965] = Priority(), -- Runic Brand Yellow
				[197963] = Priority(), -- Runic Brand Purple
				[197967] = Priority(), -- Runic Brand Green
				[197966] = Priority(), -- Runic Brand Blue
				[193783] = Priority(), -- Aegis of Aggramar Up
				[196838] = Priority(), -- Scent of Blood
				[199674] = Priority(), -- Wicked Dagger
				[193260] = Priority(), -- Static Field
				[193743] = Priority(), -- Aegis of Aggramar Wielder
				[199652] = Priority(), -- Sever
				[198944] = Priority(), -- Breach Armor
				[215430] = Priority(), -- Thunderstrike 1
				[215429] = Priority(), -- Thunderstrike 2
				[203963] = Priority(), -- Eye of the Storm
			-- Shadowmoon Burial Grounds
				[156776] = Priority(), -- Rending Voidlash
				[153692] = Priority(), -- Necrotic Pitch
				[153524] = Priority(), -- Plague Spit
				[154469] = Priority(), -- Ritual of Bones
				[162652] = Priority(), -- Lunar Purity
				[164907] = Priority(), -- Void Cleave
				[152979] = Priority(), -- Soul Shred
				[158061] = Priority(), -- Blessed Waters of Purity
				[154442] = Priority(), -- Malevolence
				[153501] = Priority(), -- Void Blast
			-- Temple of the Jade Serpent
				[396150] = Priority(), -- Feeling of Superiority
				[397878] = Priority(), -- Tainted Ripple
				[106113] = Priority(), -- Touch of Nothingness
				[397914] = Priority(), -- Defiling Mist
				[397904] = Priority(), -- Setting Sun Kick
				[397911] = Priority(), -- Touch of Ruin
				[395859] = Priority(), -- Haunting Scream
				[374037] = Priority(), -- Overwhelming Rage
				[396093] = Priority(), -- Savage Leap
				[106823] = Priority(), -- Serpent Strike
				[396152] = Priority(), -- Feeling of Inferiority
				[110125] = Priority(), -- Shattered Resolve
			-- Ruby Life Pools
				[392406] = Priority(), -- Thunderclap
				[372820] = Priority(), -- Scorched Earth
				[384823] = Priority(), -- Inferno 1
				[373692] = Priority(), -- Inferno 2
				[381862] = Priority(), -- Infernocore
				[372860] = Priority(), -- Searing Wounds
				[373869] = Priority(), -- Burning Touch
				[385536] = Priority(), -- Flame Dance
				[381518] = Priority(), -- Winds of Change
				[372858] = Priority(), -- Searing Blows
				[372682] = Priority(), -- Primal Chill 1
				[373589] = Priority(), -- Primal Chill 2
				[373693] = Priority(), -- Living Bomb
				[392924] = Priority(), -- Shock Blast
				[381515] = Priority(), -- Stormslam
				[396411] = Priority(), -- Primal Overload
				[384773] = Priority(), -- Flaming Embers
				[392451] = Priority(), -- Flashfire
				[372697] = Priority(), -- Jagged Earth
				[372047] = Priority(), -- Flurry
				[372963] = Priority(), -- Chillstorm
			-- The Nokhud Offensive
				[382628] = Priority(), -- Surge of Power
				[386025] = Priority(), -- Tempest
				[381692] = Priority(), -- Swift Stab
				[387615] = Priority(), -- Grasp of the Dead
				[387629] = Priority(), -- Rotting Wind
				[386912] = Priority(), -- Stormsurge Cloud
				[395669] = Priority(), -- Aftershock
				[384134] = Priority(), -- Pierce
				[388451] = Priority(), -- Stormcaller's Fury 1
				[388446] = Priority(), -- Stormcaller's Fury 2
				[395035] = Priority(), -- Shatter Soul
				[376899] = Priority(), -- Crackling Cloud
				[384492] = Priority(), -- Hunter's Mark
				[376730] = Priority(), -- Stormwinds
				[376894] = Priority(), -- Crackling Upheaval
				[388801] = Priority(), -- Mortal Strike
				[376827] = Priority(), -- Conductive Strike
				[376864] = Priority(), -- Static Spear
				[375937] = Priority(), -- Rending Strike
				[376634] = Priority(), -- Iron Spear
			-- The Azure Vault
				[388777] = Priority(), -- Oppressive Miasma
				[386881] = Priority(), -- Frost Bomb
				[387150] = Priority(), -- Frozen Ground
				[387564] = Priority(), -- Mystic Vapors
				[385267] = Priority(), -- Crackling Vortex
				[386640] = Priority(), -- Tear Flesh
				[374567] = Priority(), -- Explosive Brand
				[374523] = Priority(), -- Arcane Roots
				[375596] = Priority(), -- Erratic Growth Channel
				[375602] = Priority(), -- Erratic Growth
				[370764] = Priority(), -- Piercing Shards
				[384978] = Priority(), -- Dragon Strike
				[375649] = Priority(), -- Infused Ground
				[387151] = Priority(), -- Icy Devastator
				[377488] = Priority(), -- Icy Bindings
				[374789] = Priority(), -- Infused Strike
				[371007] = Priority(), -- Splintering Shards
				[375591] = Priority(), -- Sappy Burst
				[385409] = Priority(), -- Ouch, ouch, ouch!
			-- Algeth'ar Academy
				[389033] = Priority(), -- Lasher Toxin
				[391977] = Priority(), -- Oversurge
				[386201] = Priority(), -- Corrupted Mana
				[389011] = Priority(), -- Overwhelming Power
				[387932] = Priority(), -- Astral Whirlwind
				[396716] = Priority(), -- Splinterbark
				[388866] = Priority(), -- Mana Void
				[386181] = Priority(), -- Mana Bomb
				[388912] = Priority(), -- Severing Slash
				[377344] = Priority(), -- Peck
				[376997] = Priority(), -- Savage Peck
				[388984] = Priority(), -- Vicious Ambush
				[388544] = Priority(), -- Barkbreaker
				[377008] = Priority(), -- Deafening Screech
			----------------------------------------------------------
			---------------- Dragonflight (Season 2) -----------------
			----------------------------------------------------------
			-- Brackenhide Hollow
			-- Halls of Infusion
			-- Neltharus
			-- Uldaman: Legacy of Tyr
			----------------------------------------------------------
			---------------- Shadowlands (Season 4) ------------------
			----------------------------------------------------------
			-- Grimrail Depot
				[162057] = Priority(), -- Spinning Spear
				[156357] = Priority(), -- Blackrock Shrapnel
				[160702] = Priority(), -- Blackrock Mortar Shells
				[160681] = Priority(), -- Suppressive Fire
				[166570] = Priority(), -- Slag Blast (Stacking)
				[164218] = Priority(), -- Double Slash
				[162491] = Priority(), -- Acquiring Targets 1
				[162507] = Priority(), -- Acquiring Targets 2
				[161588] = Priority(), -- Diffused Energy
				[162065] = Priority(), -- Freezing Snare
			-- Iron Docks
				[163276] = Priority(), -- Shredded Tendons
				[162415] = Priority(), -- Time to Feed
				[168398] = Priority(), -- Rapid Fire Targeting
				[172889] = Priority(), -- Charging Slash
				[164504] = Priority(), -- Intimidated
				[172631] = Priority(), -- Knocked Down
				[172636] = Priority(), -- Slippery Grease
				[158341] = Priority(), -- Gushing Wounds
				[167240] = Priority(), -- Leg Shot
				[173105] = Priority(), -- Whirling Chains
				[173324] = Priority(), -- Jagged Caltrops
				[172771] = Priority(), -- Incendiary Slug
				[173307] = Priority(), -- Serrated Spear
				[169341] = Priority(), -- Demoralizing Roar
			-- Return to Karazhan: Upper
				[229248] = Priority(), -- Fel Beam
				[227592] = Priority(6), -- Frostbite
				[228252] = Priority(), -- Shadow Rend
				[227502] = Priority(), -- Unstable Mana
				[228261] = Priority(6), -- Flame Wreath
				[229241] = Priority(), -- Acquiring Target
				[230083] = Priority(6), -- Nullification
				[230221] = Priority(), -- Absorbed Mana
				[228249] = Priority(5), -- Inferno Bolt 1
				[228958] = Priority(5), -- Inferno Bolt 2
				[229159] = Priority(), -- Chaotic Shadows
				[227465] = Priority(), -- Power Discharge
				[229083] = Priority(), -- Burning Blast (Stacking)
			-- Return to Karazhan: Lower
				[227917] = Priority(), -- Poetry Slam
				[228164] = Priority(), -- Hammer Down
				[228215] = Priority(), -- Severe Dusting 1
				[228221] = Priority(), -- Severe Dusting 2
				[29690]  = Priority(), -- Drunken Skull Crack
				[227493] = Priority(), -- Mortal Strike
				[228280] = Priority(), -- Oath of Fealty
				[29574]  = Priority(), -- Rend
				[230297] = Priority(), -- Brittle Bones
				[228526] = Priority(), -- Flirt
				[227851] = Priority(), -- Coat Check 1
				[227832] = Priority(), -- Coat Check 2
				[32752]  = Priority(), -- Summoning Disorientation
				[228559] = Priority(), -- Charming Perfume
				[227508] = Priority(), -- Mass Repentance
				[241774] = Priority(), -- Shield Smash
				[227742] = Priority(), -- Garrote (Stacking)
				[238606] = Priority(), -- Arcane Eruption
				[227848] = Priority(), -- Sacred Ground (Stacking)
				[227404] = Priority(6), -- Intangible Presence
				[228610] = Priority(), -- Burning Brand
				[228576] = Priority(), -- Allured
			-- Operation Mechagon
				[291928] = Priority(), -- Giga-Zap
				[292267] = Priority(), -- Giga-Zap
				[302274] = Priority(), -- Fulminating Zap
				[298669] = Priority(), -- Taze
				[295445] = Priority(), -- Wreck
				[294929] = Priority(), -- Blazing Chomp
				[297257] = Priority(), -- Electrical Charge
				[294855] = Priority(), -- Blossom Blast
				[291972] = Priority(), -- Explosive Leap
				[285443] = Priority(), -- 'Hidden' Flame Cannon
				[291974] = Priority(), -- Obnoxious Monologue
				[296150] = Priority(), -- Vent Blast
				[298602] = Priority(), -- Smoke Cloud
				[296560] = Priority(), -- Clinging Static
				[297283] = Priority(), -- Cave In
				[291914] = Priority(), -- Cutting Beam
				[302384] = Priority(), -- Static Discharge
				[294195] = Priority(), -- Arcing Zap
				[299572] = Priority(), -- Shrink
				[300659] = Priority(), -- Consuming Slime
				[300650] = Priority(), -- Suffocating Smog
				[301712] = Priority(), -- Pounce
				[299475] = Priority(), -- B.O.R.K
				[293670] = Priority(), -- Chain Blade
			----------------------------------------------------------
			------------------ Shadowlands Dungeons ------------------
			----------------------------------------------------------
			-- Tazavesh, the Veiled Market
				[350804] = Priority(), -- Collapsing Energy
				[350885] = Priority(), -- Hyperlight Jolt
				[351101] = Priority(), -- Energy Fragmentation
				[346828] = Priority(), -- Sanitizing Field
				[355641] = Priority(), -- Scintillate
				[355451] = Priority(), -- Undertow
				[355581] = Priority(), -- Crackle
				[349999] = Priority(), -- Anima Detonation
				[346961] = Priority(), -- Purging Field
				[351956] = Priority(), -- High-Value Target
				[346297] = Priority(), -- Unstable Explosion
				[347728] = Priority(), -- Flock!
				[356408] = Priority(), -- Ground Stomp
				[347744] = Priority(), -- Quickblade
				[347481] = Priority(), -- Shuri
				[355915] = Priority(), -- Glyph of Restraint
				[350134] = Priority(), -- Infinite Breath
				[350013] = Priority(), -- Gluttonous Feast
				[355465] = Priority(), -- Boulder Throw
				[346116] = Priority(), -- Shearing Swings
				[356011] = Priority(), -- Beam Splicer
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
				[334748] = Priority(), -- Drain Fluids
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
				[323195] = Priority(), -- Purifying Blast
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
			--------------------------------------------------------
			-------------------- Castle Nathria --------------------
			--------------------------------------------------------
			-- Shriekwing
				[328897] = Priority(), -- Exsanguinated
				[330713] = Priority(), -- Reverberating Pain
				[329370] = Priority(), -- Deadly Descent
				[336494] = Priority(), -- Echo Screech
				[346301] = Priority(), -- Bloodlight
				[342077] = Priority(), -- Echolocation
			-- Huntsman Altimor
				[335304] = Priority(), -- Sinseeker
				[334971] = Priority(), -- Jagged Claws
				[335111] = Priority(), -- Huntsman's Mark 3
				[335112] = Priority(), -- Huntsman's Mark 2
				[335113] = Priority(), -- Huntsman's Mark 1
				[334945] = Priority(), -- Vicious Lunge
				[334852] = Priority(), -- Petrifying Howl
				[334695] = Priority(), -- Destabilize
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
				[341475] = Priority(), -- Crimson Flurry
				[341473] = Priority(), -- Crimson Flurry Teleport
				[328479] = Priority(), -- Eyes on Target
				[328889] = Priority(), -- Greater Castigation
			-- Artificer Xy'mox
				[327902] = Priority(), -- Fixate
				[326302] = Priority(), -- Stasis Trap
				[325236] = Priority(), -- Glyph of Destruction
				[327414] = Priority(), -- Possession
				[328468] = Priority(), -- Dimensional Tear 1
				[328448] = Priority(), -- Dimensional Tear 2
				[340860] = Priority(), -- Withering Touch
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
				[342419] = Priority(), -- Chain Them! 1
				[342420] = Priority(), -- Chain Them! 2
				[335295] = Priority(), -- Shattering Chain
				[332572] = Priority(), -- Falling Rubble
			-- Stone Legion Generals
				[334498] = Priority(), -- Seismic Upheaval
				[337643] = Priority(), -- Unstable Footing
				[334765] = Priority(), -- Heart Rend
				[334771] = Priority(), -- Heart Hemorrhage
				[333377] = Priority(), -- Wicked Mark
				[334616] = Priority(), -- Petrified
				[334541] = Priority(), -- Curse of Petrification
				[339690] = Priority(), -- Crystalize
				[342655] = Priority(), -- Volatile Anima Infusion
				[342698] = Priority(), -- Volatile Anima Infection
				[343881] = Priority(), -- Serrated Tear
			-- Sire Denathrius
				[326851] = Priority(), -- Blood Price
				[327796] = Priority(), -- Night Hunter
				[327992] = Priority(), -- Desolation
				[328276] = Priority(), -- March of the Penitent
				[326699] = Priority(), -- Burden of Sin
				[329181] = Priority(), -- Wracking Pain
				[335873] = Priority(), -- Rancor
				[329951] = Priority(), -- Impale
				[327039] = Priority(), -- Feeding Time
				[332794] = Priority(), -- Fatal Finesse
				[334016] = Priority(), -- Unworthy
			--------------------------------------------------------
			---------------- Sanctum of Domination -----------------
			--------------------------------------------------------
			-- The Tarragrue
				[347283] = Priority(5), -- Predator's Howl
				[347286] = Priority(5), -- Unshakeable Dread
				[346986] = Priority(3), -- Crushed Armor
				[347269] = Priority(6), -- Chains of Eternity
				[346985] = Priority(3), -- Overpower
			-- Eye of the Jailer
				[350606] = Priority(4), -- Hopeless Lethargy
				[355240] = Priority(5), -- Scorn
				[355245] = Priority(5), -- Ire
				[349979] = Priority(2), -- Dragging Chains
				[348074] = Priority(3), -- Assailing Lance
				[351827] = Priority(6), -- Spreading Misery
				[355143] = Priority(6), -- Deathlink
				[350763] = Priority(6), -- Annihilating Glare
			-- The Nine
				[350287] = Priority(2), -- Song of Dissolution
				[350542] = Priority(6), -- Fragments of Destiny
				[350202] = Priority(3), -- Unending Strike
				[350475] = Priority(5), -- Pierce Soul
				[350555] = Priority(3), -- Shard of Destiny
				[350109] = Priority(5), -- Brynja's Mournful Dirge
				[350483] = Priority(6), -- Link Essence
				[350039] = Priority(5), -- Arthura's Crushing Gaze
				[350184] = Priority(5), -- Daschla's Mighty Impact
				[350374] = Priority(5), -- Wings of Rage
			-- Remnant of Ner'zhul
				[350073] = Priority(2), -- Torment
				[349890] = Priority(5), -- Suffering
				[350469] = Priority(6), -- Malevolence
				[354634] = Priority(6), -- Spite 1
				[354479] = Priority(6), -- Spite 2
				[354534] = Priority(6), -- Spite 3
			-- Soulrender Dormazain
				[353429] = Priority(2), -- Tormented
				[353023] = Priority(3), -- Torment
				[351787] = Priority(5), -- Agonizing Spike
				[350647] = Priority(5), -- Brand of Torment
				[350422] = Priority(6), -- Ruinblade
				[350851] = Priority(6), -- Vessel of Torment
				[354231] = Priority(6), -- Soul Manacles
				[348987] = Priority(6), -- Warmonger Shackle 1
				[350927] = Priority(6), -- Warmonger Shackle 2
			-- Painsmith Raznal
				[356472] = Priority(5), -- Lingering Flames
				[355505] = Priority(6), -- Shadowsteel Chains 1
				[355506] = Priority(6), -- Shadowsteel Chains 2
				[348456] = Priority(6), -- Flameclasp Trap
				[356870] = Priority(2), -- Flameclasp Eruption
				[355568] = Priority(6), -- Cruciform Axe
				[355786] = Priority(5), -- Blackened Armor
				[355526] = Priority(6), -- Spiked
			-- Guardian of the First Ones
				[352394] = Priority(5), -- Radiant Energy
				[350496] = Priority(6), -- Threat Neutralization
				[347359] = Priority(6), -- Suppression Field
				[355357] = Priority(6), -- Obliterate
				[350732] = Priority(5), -- Sunder
				[352833] = Priority(6), -- Disintegration
			-- Fatescribe Roh-Kalo
				[354365] = Priority(5), -- Grim Portent
				[350568] = Priority(5), -- Call of Eternity
				[353435] = Priority(6), -- Overwhelming Burden
				[351680] = Priority(6), -- Invoke Destiny
				[353432] = Priority(6), -- Burden of Destiny
				[353693] = Priority(6), -- Unstable Accretion
				[350355] = Priority(6), -- Fated Conjunction
				[353931] = Priority(2), -- Twist Fate
			-- Kel'Thuzad
				[346530] = Priority(2), -- Frozen Destruction
				[354289] = Priority(2), -- Sinister Miasma
				[347454] = Priority(6), -- Oblivion's Echo 1
				[347518] = Priority(6), -- Oblivion's Echo 2
				[347292] = Priority(6), -- Oblivion's Echo 3
				[348978] = Priority(6), -- Soul Exhaustion
				[355389] = Priority(6), -- Relentless Haunt (Fixate)
				[357298] = Priority(6), -- Frozen Binds
				[355137] = Priority(5), -- Shadow Pool
				[348638] = Priority(4), -- Return of the Damned
				[348760] = Priority(6), -- Frost Blast
			-- Sylvanas Windrunner
				[349458] = Priority(2), -- Domination Chains
				[347704] = Priority(2), -- Veil of Darkness
				[347607] = Priority(5), -- Banshee's Mark
				[347670] = Priority(5), -- Shadow Dagger
				[351117] = Priority(5), -- Crushing Dread
				[351870] = Priority(5), -- Haunting Wave
				[351253] = Priority(5), -- Banshee Wail
				[351451] = Priority(6), -- Curse of Lethargy
				[351092] = Priority(6), -- Destabilize 1
				[351091] = Priority(6), -- Destabilize 2
				[348064] = Priority(6), -- Wailing Arrow
			----------------------------------------------------------
			-------------- Sepulcher of the First Ones ---------------
			----------------------------------------------------------
			-- Vigilant Guardian
				[364447] = Priority(3), -- Dissonance
				[364904] = Priority(6), -- Anti-Matter
				[364881] = Priority(5), -- Matter Disolution
				[360415] = Priority(5), -- Defenseless
				[360412] = Priority(4), -- Exposed Core
				[366393] = Priority(5), -- Searing Ablation
			-- Skolex, the Insatiable Ravener
				[364522] = Priority(2), -- Devouring Blood
				[359976] = Priority(2), -- Riftmaw
				[359981] = Priority(2), -- Rend
				[360098] = Priority(3), -- Warp Sickness
				[366070] = Priority(3), -- Volatile Residue
			-- Artificer Xy'mox
				[364030] = Priority(3), -- Debilitating Ray
				[365681] = Priority(2), -- System Shock
				[363413] = Priority(4), -- Forerunner Rings A
				[364604] = Priority(4), -- Forerunner Rings B
				[362615] = Priority(6), -- Interdimensional Wormhole Player 1
				[362614] = Priority(6), -- Interdimensional Wormhole Player 2
				[362803] = Priority(5), -- Glyph of Relocation
			-- Dausegne, The Fallen Oracle
				[361751] = Priority(2), -- Disintegration Halo
				[364289] = Priority(2), -- Staggering Barrage
				[361018] = Priority(2), -- Staggering Barrage Mythic 1
				[360960] = Priority(2), -- Staggering Barrage Mythic 2
				[361225] = Priority(2), -- Encroaching Dominion
				[361966] = Priority(2), -- Infused Strikes
			-- Prototype Pantheon
				[365306] = Priority(2), -- Invigorating Bloom
				[361689] = Priority(3), -- Wracking Pain
				[366232] = Priority(4), -- Animastorm
				[364839] = Priority(2), -- Sinful Projection
				[360259] = Priority(5), -- Gloom Bolt
				[362383] = Priority(5), -- Anima Bolt
				[362352] = Priority(6), -- Pinned
			-- Lihuvim, Principle Architect
				[360159] = Priority(5), -- Unstable Protoform Energy
				[363681] = Priority(3), -- Deconstructing Blast
				[363676] = Priority(4), -- Deconstructing Energy Player 1
				[363795] = Priority(4), -- Deconstructing Energy Player 2
				[464312] = Priority(5), -- Ephemeral Barrier
			-- Halondrus the Reclaimer
				[361309] = Priority(3), -- Lightshatter Beam
				[361002] = Priority(4), -- Ephemeral Fissure
				[360114] = Priority(4), -- Ephemeral Fissure II
			-- Anduin Wrynn
				[365293] = Priority(2), -- Befouled Barrier
				[363020] = Priority(3), -- Necrotic Claws
				[365021] = Priority(5), -- Wicked Star (marked)
				[365024] = Priority(6), -- Wicked Star (hit)
				[365445] = Priority(3), -- Scarred Soul
				[365008] = Priority(4), -- Psychic Terror
				[366849] = Priority(6), -- Domination Word: Pain
			-- Lords of Dread
				[360148] = Priority(5), -- Bursting Dread
				[360012] = Priority(4), -- Cloud of Carrion
				[360146] = Priority(4), -- Fearful Trepidation
				[360241] = Priority(6), -- Unsettling Dreams
			-- Rygelon
				[362206] = Priority(6), -- Event Horizon
				[362137] = Priority(4), -- Corrupted Wound
				[362172] = Priority(4), -- Corrupted Wound
				[361548] = Priority(5), -- Dark Eclipse
			-- The Jailer
				[362075] = Priority(6), -- Domination
				[365150] = Priority(6), -- Rune of Domination
				[363893] = Priority(5), -- Martyrdom
				[363886] = Priority(5), -- Imprisonment
				[365219] = Priority(5), -- Chains of Anguish
				[366285] = Priority(6), -- Rune of Compulsion
				[363332] = Priority(5), -- Unbreaking Grasp
			---------------------------------------------------------
			---------------- Vault of the Incarnates ----------------
			---------------------------------------------------------
			-- Eranog
				[370648] = Priority(5), -- Primal Flow
				[390715] = Priority(6), -- Primal Rifts
				[370597] = Priority(6), -- Kill Order
			-- Terros
				[382776] = Priority(5), -- Awakened Earth 1
				[381253] = Priority(5), -- Awakened Earth 2
				[386352] = Priority(3), -- Rock Blast
				[382458] = Priority(6), -- Resonant Aftermath
			-- The Primal Council
				[371624] = Priority(5), -- Conductive Mark
				[372027] = Priority(4), -- Slashing Blaze
				[374039] = Priority(4), -- Meteor Axe
			-- Sennarth, the Cold Breath
				[371976] = Priority(4), -- Chilling Blast
				[372082] = Priority(5), -- Enveloping Webs
				[374659] = Priority(4), -- Rush
				[374104] = Priority(5), -- Wrapped in Webs Slow
				[374503] = Priority(6), -- Wrapped in Webs Stun
				[373048] = Priority(3), -- Suffocating Webs
			-- Dathea, Ascended
				[391686] = Priority(5), -- Conductive Mark
				[378277] = Priority(2), -- Elemental Equilbrium
				[388290] = Priority(4), -- Cyclone
			-- Kurog Grimtotem
				[377780] = Priority(5), -- Skeletal Fractures
				[372514] = Priority(5), -- Frost Bite
				[374554] = Priority(4), -- Lava Pool
				[374709] = Priority(4), -- Seismic Rupture
				[374023] = Priority(6), -- Searing Carnage
				[374427] = Priority(6), -- Ground Shatter
				[390920] = Priority(5), -- Shocking Burst
				[372458] = Priority(6), -- Below Zero
			-- Broodkeeper Diurna
				[388920] = Priority(6), -- Frozen Shroud
				[378782] = Priority(5), -- Mortal Wounds
				[378787] = Priority(5), -- Crushing Stoneclaws
				[375620] = Priority(6), -- Ionizing Charge
				[375578] = Priority(4), -- Flame Sentry
			-- Raszageth the Storm-Eater
				-- TODO: DF
		},
	}

	Debuffs["PvP"] = {
		["type"] = "Whitelist",
		["spells"] = {
			-- Evoker
				[355689]	= Priority(2), -- Landslide
				[370898]	= Priority(1), -- Permeating Chill
				[360806]	= Priority(3), -- Sleep Walk
			-- Death Knight
				[47476]		= Priority(2), -- Strangulate
				[108194]	= Priority(4), -- Asphyxiate UH
				[221562]	= Priority(4), -- Asphyxiate Blood
				[207171]	= Priority(4), -- Winter is Coming
				[206961]	= Priority(3), -- Tremble Before Me
				[207167]	= Priority(4), -- Blinding Sleet
				[212540]	= Priority(1), -- Flesh Hook (Pet)
				[91807]		= Priority(1), -- Shambling Rush (Pet)
				[204085]	= Priority(1), -- Deathchill
				[233395]	= Priority(1), -- Frozen Center
				[212332]	= Priority(4), -- Smash (Pet)
				[212337]	= Priority(4), -- Powerful Smash (Pet)
				[91800]		= Priority(4), -- Gnaw (Pet)
				[91797]		= Priority(4), -- Monstrous Blow (Pet)
				[210141]	= Priority(3), -- Zombie Explosion
			-- Demon Hunter
				[207685]	= Priority(4), -- Sigil of Misery
				[217832]	= Priority(3), -- Imprison
				[221527]	= Priority(5), -- Imprison (Banished version)
				[204490]	= Priority(2), -- Sigil of Silence
				[179057]	= Priority(3), -- Chaos Nova
				[211881]	= Priority(4), -- Fel Eruption
				[205630]	= Priority(3), -- Illidan's Grasp
				[208618]	= Priority(3), -- Illidan's Grasp (Afterward)
				[213491]	= Priority(4), -- Demonic Trample 1
				[208645]	= Priority(4), -- Demonic Trample 2
			-- Druid
				[81261]		= Priority(2), -- Solar Beam
				[5211]		= Priority(4), -- Mighty Bash
				[163505]	= Priority(4), -- Rake
				[203123]	= Priority(4), -- Maim
				[202244]	= Priority(4), -- Overrun
				[99]		= Priority(4), -- Incapacitating Roar
				[33786]		= Priority(5), -- Cyclone
				[45334]		= Priority(1), -- Immobilized
				[102359]	= Priority(1), -- Mass Entanglement
				[339]		= Priority(1), -- Entangling Roots
				[2637]		= Priority(1), -- Hibernate
				[102793]	= Priority(1), -- Ursol's Vortex
			-- Hunter
				[202933]	= Priority(2), -- Spider Sting 1
				[233022]	= Priority(2), -- Spider Sting 2
				[213691]	= Priority(4), -- Scatter Shot
				[19386]		= Priority(3), -- Wyvern Sting
				[3355]		= Priority(3), -- Freezing Trap
				[203337]	= Priority(5), -- Freezing Trap (PvP Talent)
				[209790]	= Priority(3), -- Freezing Arrow
				[24394]		= Priority(4), -- Intimidation
				[117526]	= Priority(4), -- Binding Shot
				[190927]	= Priority(1), -- Harpoon
				[201158]	= Priority(1), -- Super Sticky Tar
				[162480]	= Priority(1), -- Steel Trap
				[212638]	= Priority(1), -- Tracker's Net
				[200108]	= Priority(1), -- Ranger's Net
			-- Mage
				[61721]		= Priority(3), -- Rabbit
				[61305]		= Priority(3), -- Black Cat
				[28272]		= Priority(3), -- Pig
				[28271]		= Priority(3), -- Turtle
				[126819]	= Priority(3), -- Porcupine
				[161354]	= Priority(3), -- Monkey
				[161353]	= Priority(3), -- Polar Bear
				[61780]		= Priority(3), -- Turkey
				[161355]	= Priority(3), -- Penguin
				[161372]	= Priority(3), -- Peacock
				[277787]	= Priority(3), -- Direhorn
				[277792]	= Priority(3), -- Bumblebee
				[118]		= Priority(3), -- Polymorph
				[82691]		= Priority(3), -- Ring of Frost
				[31661]		= Priority(3), -- Dragon's Breath
				[122]		= Priority(1), -- Frost Nova
				[33395]		= Priority(1), -- Freeze
				[157997]	= Priority(1), -- Ice Nova
				[228600]	= Priority(1), -- Glacial Spike
				[198121]	= Priority(1), -- Frostbite
			-- Monk
				[119381]	= Priority(4), -- Leg Sweep
				[202346]	= Priority(4), -- Double Barrel
				[115078]	= Priority(4), -- Paralysis
				[198909]	= Priority(3), -- Song of Chi-Ji
				[202274]	= Priority(3), -- Incendiary Brew
				[233759]	= Priority(2), -- Grapple Weapon
				[123407]	= Priority(1), -- Spinning Fire Blossom
				[116706]	= Priority(1), -- Disable
				[232055]	= Priority(4), -- Fists of Fury
			-- Paladin
				[853]		= Priority(3), -- Hammer of Justice
				[20066]		= Priority(3), -- Repentance
				[105421]	= Priority(3), -- Blinding Light
				[31935]		= Priority(2), -- Avenger's Shield
				[217824]	= Priority(2), -- Shield of Virtue
				[205290]	= Priority(3), -- Wake of Ashes
			-- Priest
				[9484]		= Priority(3), -- Shackle Undead
				[200196]	= Priority(4), -- Holy Word: Chastise
				[200200]	= Priority(4), -- Holy Word: Chastise
				[226943]	= Priority(3), -- Mind Bomb
				[605]		= Priority(5), -- Mind Control
				[8122]		= Priority(3), -- Psychic Scream
				[15487]		= Priority(2), -- Silence
				[64044]		= Priority(1), -- Psychic Horror
				[453]		= Priority(5), -- Mind Soothe
			-- Rogue
				[2094]		= Priority(4), -- Blind
				[6770]		= Priority(4), -- Sap
				[1776]		= Priority(4), -- Gouge
				[1330]		= Priority(2), -- Garrote - Silence
				[207777]	= Priority(2), -- Dismantle
				[408]		= Priority(4), -- Kidney Shot
				[1833]		= Priority(4), -- Cheap Shot
				[207736]	= Priority(5), -- Shadowy Duel (Smoke effect)
				[212182]	= Priority(5), -- Smoke Bomb
			-- Shaman
				[51514]		= Priority(3), -- Hex
				[211015]	= Priority(3), -- Hex (Cockroach)
				[211010]	= Priority(3), -- Hex (Snake)
				[211004]	= Priority(3), -- Hex (Spider)
				[210873]	= Priority(3), -- Hex (Compy)
				[196942]	= Priority(3), -- Hex (Voodoo Totem)
				[269352]	= Priority(3), -- Hex (Skeletal Hatchling)
				[277778]	= Priority(3), -- Hex (Zandalari Tendonripper)
				[277784]	= Priority(3), -- Hex (Wicker Mongrel)
				[118905]	= Priority(3), -- Static Charge
				[77505]		= Priority(4), -- Earthquake (Knocking down)
				[118345]	= Priority(4), -- Pulverize (Pet)
				[204399]	= Priority(3), -- Earthfury
				[204437]	= Priority(3), -- Lightning Lasso
				[157375]	= Priority(4), -- Gale Force
				[64695]		= Priority(1), -- Earthgrab
			-- Warlock
				[710]		= Priority(5), -- Banish
				[6789]		= Priority(3), -- Mortal Coil
				[118699]	= Priority(3), -- Fear
				[6358]		= Priority(3), -- Seduction (Succub)
				[171017]	= Priority(4), -- Meteor Strike (Infernal)
				[22703]		= Priority(4), -- Infernal Awakening (Infernal CD)
				[30283]		= Priority(3), -- Shadowfury
				[89766]		= Priority(4), -- Axe Toss
				[233582]	= Priority(1), -- Entrenched in Flame
			-- Warrior
				[5246]		= Priority(4), -- Intimidating Shout
				[132169]	= Priority(4), -- Storm Bolt
				[132168]	= Priority(4), -- Shockwave
				[199085]	= Priority(4), -- Warpath
				[105771]	= Priority(1), -- Charge
				[199042]	= Priority(1), -- Thunderstruck
				[236077]	= Priority(2), -- Disarm
			-- Racial
				[20549]		= Priority(4), -- War Stomp
				[107079]	= Priority(4), -- Quaking Palm
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
