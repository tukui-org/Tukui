local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]

------------------------------------------------------------------------------------
-- RAID DEBUFFS (TRACKING LIST)
------------------------------------------------------------------------------------

TukuiUnitFrames.DebuffsTracking = {}

local function Defaults(priorityOverride)
	return {["enable"] = true, ["priority"] = priorityOverride or 0, ["stackThreshold"] = 0}
end

TukuiUnitFrames.DebuffsTracking["RaidDebuffs"] = {
	["type"] = "Whitelist",
	["spells"] = {
		--BFA Dungeons
		--Freehold
		[258323] = Defaults(), -- Infected Wound
		[257775] = Defaults(), -- Plague Step
		[257908] = Defaults(), -- Oiled Blade
		[257436] = Defaults(), -- Poisoning Strike
		[274389] = Defaults(), -- Rat Traps
		[274555] = Defaults(), -- Scabrous Bites
		[258875] = Defaults(), -- Blackout Barrel
		[256363] = Defaults(), -- Ripper Punch
		
		--Shrine of the Storm
		[264560] = Defaults(), -- Choking Brine
		[268233] = Defaults(), -- Electrifying Shock
		[268322] = Defaults(), -- Touch of the Drowned
		[268896] = Defaults(), -- Mind Rend
		[268104] = Defaults(), -- Explosive Void
		[267034] = Defaults(), -- Whispers of Power
		[276268] = Defaults(), -- Heaving Blow
		[264166] = Defaults(), -- Undertow
		[264526] = Defaults(), -- Grasp of the Depths
		[274633] = Defaults(), -- Sundering Blow
		[268214] = Defaults(), -- Carving Flesh
		[267818] = Defaults(), -- Slicing Blast
		[268309] = Defaults(), -- Unending Darkness
		[268317] = Defaults(), -- Rip Mind
		[268391] = Defaults(), -- Mental Assault
		[274720] = Defaults(), -- Abyssal Strike

		--Siege of Boralus
		[257168] = Defaults(), -- Cursed Slash
		[272588] = Defaults(), -- Rotting Wounds
		[272571] = Defaults(), -- Choking Waters
		[274991] = Defaults(), -- Putrid Waters
		[275835] = Defaults(), -- Stinging Venom Coating
		[273930] = Defaults(), -- Hindering Cut
		[257292] = Defaults(), -- Heavy Slash
		[261428] = Defaults(), -- Hangman's Noose
		[256897] = Defaults(), -- Clamping Jaws
		[272874] = Defaults(), -- Trample
		[273470] = Defaults(), -- Gut Shot
		[272834] = Defaults(), -- Viscous Slobber
		[257169] = Defaults(), -- Terrifying Roar
		[272713] = Defaults(), -- Crushing Slam
		
		-- Tol Dagor
		[258128] = Defaults(), -- Debilitating Shout
		[265889] = Defaults(), -- Torch Strike
		[257791] = Defaults(), -- Howling Fear
		[258864] = Defaults(), -- Suppression Fire
		[257028] = Defaults(), -- Fuselighter
		[258917] = Defaults(), -- Righteous Flames
		[257777] = Defaults(), -- Crippling Shiv
		[258079] = Defaults(), -- Massive Chomp
		[258058] = Defaults(), -- Squeeze
		[260016] = Defaults(), -- Itchy Bite
		[257119] = Defaults(), -- Sand Trap
		[260067] = Defaults(), -- Vicious Mauling
		[258313] = Defaults(), -- Handcuff
		[259711] = Defaults(), -- Lockdown
		[256198] = Defaults(), -- Azerite Rounds: Incendiary
		[256101] = Defaults(), -- Explosive Burst
		[256044] = Defaults(), -- Deadeye
		[256474] = Defaults(), -- Heartstopper Venom
		
		--Waycrest Manor
		[260703] = Defaults(), -- Unstable Runic Mark
		[263905] = Defaults(), -- Marking Cleave
		[265880] = Defaults(), -- Dread Mark
		[265882] = Defaults(), -- Lingering Dread
		[264105] = Defaults(), -- Runic Mark
		[264050] = Defaults(), -- Infected Thorn
		[261440] = Defaults(), -- Virulent Pathogen
		[263891] = Defaults(), -- Grasping Thorns
		[264378] = Defaults(), -- Fragment Soul
		[266035] = Defaults(), -- Bone Splinter
		[266036] = Defaults(), -- Drain Essence
		[260907] = Defaults(), -- Soul Manipulation
		[260741] = Defaults(), -- Jagged Nettles
		[264556] = Defaults(), -- Tearing Strike
		[265760] = Defaults(), -- Thorned Barrage
		[260551] = Defaults(), -- Soul Thorns
		[263943] = Defaults(), -- Etch
		[265881] = Defaults(), -- Decaying Touch
		[261438] = Defaults(), -- Wasting Strike
		[268202] = Defaults(), -- Death Lens
		
		-- Atal'Dazar
		[252781] = Defaults(), -- Unstable Hex
		[250096] = Defaults(), -- Wracking Pain
		[250371] = Defaults(), -- Lingering Nausea
		[253562] = Defaults(), -- Wildfire
		[255582] = Defaults(), -- Molten Gold
		[255041] = Defaults(), -- Terrifying Screech
		[255371] = Defaults(), -- Terrifying Visage
		[252687] = Defaults(), -- Venomfang Strike
		[254959] = Defaults(), -- Soulburn
		[255814] = Defaults(), -- Rending Maul
		[255421] = Defaults(), -- Devour
		[255434] = Defaults(), -- Serrated Teeth
		[256577] = Defaults(), -- Soulfeast
		
		--King's Rest
		[270492] = Defaults(), -- Hex
		[267763] = Defaults(), -- Wretched Discharge
		[276031] = Defaults(), -- Pit of Despair
		[265773] = Defaults(), -- Spit Gold
		[270920] = Defaults(), -- Seduction
		[270865] = Defaults(), -- Hidden Blade
		[271564] = Defaults(), -- Embalming Fluid
		[270507] = Defaults(), -- Poison Barrage
		[267273] = Defaults(), -- Poison Nova
		[270003] = Defaults(), -- Suppression Slam
		[270084] = Defaults(), -- Axe Barrage
		[267618] = Defaults(), -- Drain Fluids
		[267626] = Defaults(), -- Dessication
		[270487] = Defaults(), -- Severing Blade
		[266238] = Defaults(), -- Shattered Defenses
		[266231] = Defaults(), -- Severing Axe
		[266191] = Defaults(), -- Whirling Axes
		[272388] = Defaults(), -- Shadow Barrage
		[271640] = Defaults(), -- Dark Revelation
		[268796] = Defaults(), -- Impaling Spear
		
		--Motherlode
		[263074] = Defaults(), -- Festering Bite
		[280605] = Defaults(), -- Brain Freeze
		[257337] = Defaults(), -- Shocking Claw
		[270882] = Defaults(), -- Blazing Azerite
		[268797] = Defaults(), -- Transmute: Enemy to Goo
		[259856] = Defaults(), -- Chemical Burn
		[269302] = Defaults(), -- Toxic Blades
		[280604] = Defaults(), -- Iced Spritzer
		[257371] = Defaults(), -- Tear Gas
		[257544] = Defaults(), -- Jagged Cut
		[268846] = Defaults(), -- Echo Blade
		[262794] = Defaults(), -- Energy Lash
		[262513] = Defaults(), -- Azerite Heartseeker
		[260829] = Defaults(), -- Homing Missle (travelling)
		[260838] = Defaults(), -- Homing Missle (exploded)
		[263637] = Defaults(), -- Clothesline
		
		--Temple of Sethraliss
		[269686] = Defaults(), -- Plague
		[268013] = Defaults(), -- Flame Shock
		[268008] = Defaults(), -- Snake Charm
		[273563] = Defaults(), -- Neurotoxin
		[272657] = Defaults(), -- Noxious Breath
		[267027] = Defaults(), -- Cytotoxin
		[272699] = Defaults(), -- Venomous Spit
		[263371] = Defaults(), -- Conduction
		[272655] = Defaults(), -- Scouring Sand
		[263914] = Defaults(), -- Blinding Sand
		[263958] = Defaults(), -- A Knot of Snakes
		[266923] = Defaults(), -- Galvanize
		[268007] = Defaults(), -- Heart Attack
		
		--Underrot
		[265468] = Defaults(), -- Withering Curse
		[278961] = Defaults(), -- Decaying Mind
		[259714] = Defaults(), -- Decaying Spores
		[272180] = Defaults(), -- Death Bolt
		[272609] = Defaults(), -- Maddening Gaze
		[269301] = Defaults(), -- Putrid Blood
		[265533] = Defaults(), -- Blood Maw
		[265019] = Defaults(), -- Savage Cleave
		[265377] = Defaults(), -- Hooked Snare
		[265625] = Defaults(), -- Dark Omen
		[260685] = Defaults(), -- Taint of G'huun
		[266107] = Defaults(), -- Thirst for Blood
		[260455] = Defaults(), -- Serrated Fangs
		
		------------------------
		-- Dungeons (Mythic+) --
		------------------------
		
		[226303] = Defaults(), -- Piercing Shards (Neltharion's Lair)
		[227742] = Defaults(), -- Garrote (Karazhan)
		[209858] = Defaults(), -- Necrotic
		[226512] = Defaults(), -- Sanguine
		[240559] = Defaults(), -- Grievous
		[240443] = Defaults(), -- Bursting
		[196376] = Defaults(), -- Grievous Tear
		[200227] = Defaults(), -- Tangled Web
		
		----------------------------------
		-- The Emerald Nightmare (RAID) --
		----------------------------------
		
		-- Nythendra
		[204504] = Defaults(), -- Infested
		[205043] = Defaults(), -- Infested mind
		[203096] = Defaults(), -- Rot
		[204463] = Defaults(), -- Volatile Rot
		[203045] = Defaults(), -- Infested Ground
		[203646] = Defaults(), -- Burst of Corruption

		-- Elerethe Renferal
		[210228] = Defaults(), -- Dripping Fangs
		[215307] = Defaults(), -- Web of Pain
		[215300] = Defaults(), -- Web of Pain
		[215460] = Defaults(), -- Necrotic Venom
		[213124] = Defaults(), -- Venomous Pool
		[210850] = Defaults(), -- Twisting Shadows
		[215489] = Defaults(), -- Venomous Pool
		[218519] = Defaults(), -- Wind Burn (Mythic)

		-- Il'gynoth, Heart of the Corruption
		[208929] = Defaults(),  -- Spew Corruption
		[210984] = Defaults(),  -- Eye of Fate
		[209469] = Defaults(5), -- Touch of Corruption
		[208697] = Defaults(),  -- Mind Flay
		[215143] = Defaults(),  -- Cursed Blood

		-- Ursoc
		[198108] = Defaults(), -- Unbalanced
		[197943] = Defaults(), -- Overwhelm
		[204859] = Defaults(), -- Rend Flesh
		[205611] = Defaults(), -- Miasma
		[198006] = Defaults(), -- Focused Gaze
		[197980] = Defaults(), -- Nightmarish Cacophony

		-- Dragons of Nightmare
		[203102] = Defaults(),  -- Mark of Ysondre
		[203121] = Defaults(),  -- Mark of Taerar
		[203125] = Defaults(),  -- Mark of Emeriss
		[203124] = Defaults(),  -- Mark of Lethon
		[204731] = Defaults(5), -- Wasting Dread
		[203110] = Defaults(5), -- Slumbering Nightmare
		[207681] = Defaults(5), -- Nightmare Bloom
		[205341] = Defaults(5), -- Sleeping Fog
		[203770] = Defaults(5), -- Defiled Vines
		[203787] = Defaults(5), -- Volatile Infection

		-- Cenarius
		[210279] = Defaults(), -- Creeping Nightmares
		[213162] = Defaults(), -- Nightmare Blast
		[210315] = Defaults(), -- Nightmare Brambles
		[212681] = Defaults(), -- Cleansed Ground
		[211507] = Defaults(), -- Nightmare Javelin
		[211471] = Defaults(), -- Scorned Touch
		[211612] = Defaults(), -- Replenishing Roots
		[216516] = Defaults(), -- Ancient Dream

		-- Xavius
		[206005] = Defaults(), -- Dream Simulacrum
		[206651] = Defaults(), -- Darkening Soul
		[209158] = Defaults(), -- Blackening Soul
		[211802] = Defaults(), -- Nightmare Blades
		[206109] = Defaults(), -- Awakening to the Nightmare
		[209034] = Defaults(), -- Bonds of Terror
		[210451] = Defaults(), -- Bonds of Terror
		[208431] = Defaults(), -- Corruption: Descent into Madness
		[207409] = Defaults(), -- Madness
		[211634] = Defaults(), -- The Infinite Dark
		[208385] = Defaults(), -- Tainted Discharge

		---------------------------
		-- Trial of Valor (RAID) --
		---------------------------
		
		-- Odyn
		[227959] = Defaults(), -- Storm of Justice
		[227807] = Defaults(), -- Storm of Justice
		[227475] = Defaults(), -- Cleansing Flame
		[192044] = Defaults(), -- Expel Light
		[228030] = Defaults(), -- Expel Light
		[227781] = Defaults(), -- Glowing Fragment
		[228918] = Defaults(), -- Stormforged Spear
		[227490] = Defaults(), -- Branded
		[227491] = Defaults(), -- Branded
		[227498] = Defaults(), -- Branded
		[227499] = Defaults(), -- Branded
		[227500] = Defaults(), -- Branded
		[231297] = Defaults(), -- Runic Brand (Mythic Only)

		-- Guarm
		[228228] = Defaults(), -- Flame Lick
		[228248] = Defaults(), -- Frost Lick
		[228253] = Defaults(), -- Shadow Lick
		[227539] = Defaults(), -- Fiery Phlegm
		[227566] = Defaults(), -- Salty Spittle
		[227570] = Defaults(), -- Dark Discharge

		-- Helya
		[228883] = Defaults(5), -- Unholy Reckoning (Trash)
		[227903] = Defaults(),  -- Orb of Corruption
		[228058] = Defaults(),  -- Orb of Corrosion
		[229119] = Defaults(),  -- Orb of Corrosion
		[228054] = Defaults(),  -- Taint of the Sea
		[193367] = Defaults(),  -- Fetid Rot
		[227982] = Defaults(),  -- Bilewater Redox
		[228519] = Defaults(),  -- Anchor Slam
		[202476] = Defaults(),  -- Rabid
		[232450] = Defaults(),  -- Corrupted Axion
		
		--------------------------
		-- The Nighthold (RAID) --
		--------------------------
	
		-- Skorpyron
		[204766] = Defaults(), -- Energy Surge
		[214718] = Defaults(), -- Acidic Fragments
		[211801] = Defaults(), -- Volatile Fragments
		[204284] = Defaults(), -- Broken Shard (Protection)
		[204275] = Defaults(), -- Arcanoslash (Tank)
		[211659] = Defaults(), -- Arcane Tether (Tank debuff)
		[204483] = Defaults(), -- Focused Blast (Stun)

		-- Chronomatic Anomaly
		[206607] = Defaults(), -- Chronometric Particles (Tank stack debuff)
		[206609] = Defaults(), -- Time Release (Heal buff/debuff)
		[219966] = Defaults(), -- Time Release (Heal Absorb Red)
		[219965] = Defaults(), -- Time Release (Heal Absorb Yellow)
		[219964] = Defaults(), -- Time Release (Heal Absorb Green)
		[205653] = Defaults(), -- Passage of Time
		[207871] = Defaults(), -- Vortex (Mythic)
		[212099] = Defaults(), -- Temporal Charge

		-- Trilliax
		[206488] = Defaults(), -- Arcane Seepage
		[206641] = Defaults(), -- Arcane Spear (Tank)
		[206798] = Defaults(), -- Toxic Slice
		[214672] = Defaults(), -- Annihilation
		[214573] = Defaults(), -- Stuffed
		[214583] = Defaults(), -- Sterilize
		[208910] = Defaults(), -- Arcing Bonds
		[206838] = Defaults(), -- Succulent Feast

		-- Spellblade Aluriel
		[212492] = Defaults(), -- Annihilate (Tank)
		[212494] = Defaults(), -- Annihilated (Main Tank debuff)
		[212587] = Defaults(), -- Mark of Frost
		[212531] = Defaults(), -- Mark of Frost (marked)
		[212530] = Defaults(), -- Replicate: Mark of Frost
		[212647] = Defaults(), -- Frostbitten
		[212736] = Defaults(), -- Pool of Frost
		[213085] = Defaults(), -- Frozen Tempest
		[213621] = Defaults(), -- Entombed in Ice
		[213148] = Defaults(), -- Searing Brand Chosen
		[213181] = Defaults(), -- Searing Brand Stunned
		[213166] = Defaults(), -- Searing Brand
		[213278] = Defaults(), -- Burning Ground
		[213504] = Defaults(), -- Arcane Fog

		-- Tichondrius
		[206480] = Defaults(), -- Carrion Plague
		[215988] = Defaults(), -- Carrion Nightmare
		[208230] = Defaults(), -- Feast of Blood
		[212794] = Defaults(), -- Brand of Argus
		[216685] = Defaults(), -- Flames of Argus
		[206311] = Defaults(), -- Illusionary Night
		[206466] = Defaults(), -- Essence of Night
		[216024] = Defaults(), -- Volatile Wound
		[216027] = Defaults(), -- Nether Zone
		[216039] = Defaults(), -- Fel Storm
		[216726] = Defaults(), -- Ring of Shadows
		[216040] = Defaults(), -- Burning Soul

		-- Krosus
		[206677] = Defaults(), -- Searing Brand
		[205344] = Defaults(), -- Orb of Destruction

		-- High Botanist Tel'arn
		[218503] = Defaults(), -- Recursive Strikes (Tank)
		[219235] = Defaults(), -- Toxic Spores
		[218809] = Defaults(), -- Call of Night
		[218342] = Defaults(), -- Parasitic Fixate
		[218304] = Defaults(), -- Parasitic Fetter
		[218780] = Defaults(), -- Plasma Explosion

		-- Star Augur Etraeus
		[205984] = Defaults(), -- Gravitaional Pull
		[214167] = Defaults(), -- Gravitaional Pull
		[214335] = Defaults(), -- Gravitaional Pull
		[206936] = Defaults(), -- Icy Ejection
		[206388] = Defaults(), -- Felburst
		[206585] = Defaults(), -- Absolute Zero
		[206398] = Defaults(), -- Felflame
		[206589] = Defaults(), -- Chilled
		[205649] = Defaults(), -- Fel Ejection
		[206965] = Defaults(), -- Voidburst
		[206464] = Defaults(), -- Coronal Ejection
		[207143] = Defaults(), -- Void Ejection
		[206603] = Defaults(), -- Frozen Solid
		[207720] = Defaults(), -- Witness the Void
		[216697] = Defaults(), -- Frigid Pulse

		-- Grand Magistrix Elisande
		[209166] = Defaults(), -- Fast Time
		[211887] = Defaults(), -- Ablated
		[209615] = Defaults(), -- Ablation
		[209244] = Defaults(), -- Delphuric Beam
		[209165] = Defaults(), -- Slow Time
		[209598] = Defaults(), -- Conflexive Burst
		[209433] = Defaults(), -- Spanning Singularity
		[209973] = Defaults(), -- Ablating Explosion
		[209549] = Defaults(), -- Lingering Burn
		[211261] = Defaults(), -- Permaliative Torment
		[208659] = Defaults(), -- Arcanetic Ring

		-- Gul'dan
		[210339] = Defaults(), -- Time Dilation
		[180079] = Defaults(), -- Felfire Munitions
		[206875] = Defaults(), -- Fel Obelisk (Tank)
		[206840] = Defaults(), -- Gaze of Vethriz
		[206896] = Defaults(), -- Torn Soul
		[206221] = Defaults(), -- Empowered Bonds of Fel
		[208802] = Defaults(), -- Soul Corrosion
		[212686] = Defaults(), -- Flames of Sargeras
		
		-----------------------------
		-- Tomb of Sargeras (RAID) --
		-----------------------------
		
		-- Goroth
		[233279] = Defaults(), -- Shattering Star
		[230345] = Defaults(), -- Crashing Comet (Dot)
		[232249] = Defaults(), -- Crashing Comet
		[231363] = Defaults(), -- Burning Armor
		[234264] = Defaults(), -- Melted Armor
		[233062] = Defaults(), -- Infernal Burning
		[230348] = Defaults(), -- Fel Pool

		-- Demonic Inquisition
		[233430] = Defaults(), -- Ubearable Torment
		[233983] = Defaults(), -- Echoing Anguish
		[248713] = Defaults(), -- Soul Corruption

		-- Harjatan
		[231770] = Defaults(), -- Drenched
		[231998] = Defaults(), -- Jagged Abrasion
		[231729] = Defaults(), -- Aqueous Burst
		[234128] = Defaults(), -- Driven Assault
		[234016] = Defaults(), -- Driven Assault

		-- Sisters of the Moon
		[236603] = Defaults(), -- Rapid Shot
		[236596] = Defaults(), -- Rapid Shot
		[234995] = Defaults(), -- Lunar Suffusion
		[234996] = Defaults(), -- Umbra Suffusion
		[236519] = Defaults(), -- Moon Burn
		[236697] = Defaults(), -- Deathly Screech
		[239264] = Defaults(), -- Lunar Flare (Tank)
		[236712] = Defaults(), -- Lunar Beacon
		[236304] = Defaults(), -- Incorporeal Shot
		[236305] = Defaults(), -- Incorporeal Shot (Heroic)
		[236306] = Defaults(), -- Incorporeal Shot
		[237570] = Defaults(), -- Incorporeal Shot
		[248911] = Defaults(), -- Incorporeal Shot
		[236550] = Defaults(), -- Discorporate (Tank)
		[236330] = Defaults(), -- Astral Vulnerability
		[236529] = Defaults(), -- Twilight Glaive
		[236541] = Defaults(), -- Twilight Glaive
		[237561] = Defaults(), -- Twilight Glaive (Heroic)
		[237633] = Defaults(), -- Spectral Glaive
		[233263] = Defaults(), -- Embrace of the Eclipse

		-- Mistress Sassz'ine
		[230959] = Defaults(), -- Concealing Murk
		[232732] = Defaults(), -- Slicing Tornado
		[232913] = Defaults(), -- Befouling Ink
		[234621] = Defaults(), -- Devouring Maw
		[230201] = Defaults(), -- Burden of Pain (Tank)
		[230139] = Defaults(), -- Hydra Shot
		[232754] = Defaults(), -- Hydra Acid
		[230920] = Defaults(), -- Consuming Hunger
		[230358] = Defaults(), -- Thundering Shock
		[230362] = Defaults(), -- Thundering Shock

		-- The Desolate Host
		[236072] = Defaults(), -- Wailing Souls
		[236449] = Defaults(), -- Soulbind
		[236459] = Defaults(), -- Soulbind M
		[236515] = Defaults(), -- Shattering Scream
		[235989] = Defaults(), -- Tormented Cries
		[236241] = Defaults(), -- Soul Rot
		[236361] = Defaults(), -- Spirit Chains
		[235968] = Defaults(), -- Grasping Darkness

		-- Maiden of Vigilance
		[235117] = Defaults(), -- Unstable Soul
		[240209] = Defaults(), -- Unstable Soul
		[243276] = Defaults(), -- Unstable Soul
		[249912] = Defaults(), -- Unstable Soul
		[235534] = Defaults(), -- Creator's Grace
		[235538] = Defaults(), -- Demon's Vigor
		[234891] = Defaults(), -- Wrath of the Creators
		[235569] = Defaults(), -- Hammer of Creation
		[235573] = Defaults(), -- Hammer of Obliteration
		[235213] = Defaults(), -- Light Infusion
		[235240] = Defaults(), -- Fel Infusion

		-- Fallen Avatar
		[239058] = Defaults(), -- Touch of Sargeras
		[239739] = Defaults(), -- Dark Mark
		[234059] = Defaults(), -- Unbound Chaos
		[240213] = Defaults(), -- Chaos Flames
		[236604] = Defaults(), -- Shadowy Blades
		[236494] = Defaults(), -- Desolate (Tank)
		[240728] = Defaults(), -- Tainted Essence

		-- Kil'jaeden
		[238999] = Defaults(), -- Darkness of a Thousand Souls
		[239216] = Defaults(), -- Darkness of a Thousand Souls (Dot)
		[239155] = Defaults(), -- Gravity Squeeze
		[234295] = Defaults(), -- Armageddon Rain
		[240908] = Defaults(), -- Armageddon Blast
		[239932] = Defaults(), -- Felclaws (Tank)
		[240911] = Defaults(), -- Armageddon Hail
		[238505] = Defaults(), -- Focused Dreadflame
		[238429] = Defaults(), -- Bursting Dreadflame
		[236710] = Defaults(), -- Shadow Reflection: Erupting
		[241822] = Defaults(), -- Choking Shadow
		[236555] = Defaults(), -- Deceiver's Veil
		[234310] = Defaults(), -- Armageddon Rain
	
		----------------------------------------
		-- Antorus, the Burning Throne (RAID) --
		----------------------------------------
	
		-- Garothi Worldbreaker
		[244590] = Defaults(), -- Molten Hot Fel
		[244761] = Defaults(), -- Annihilation
		[246920] = Defaults(), -- Haywire Decimation
		[246369] = Defaults(), -- Searing Barrage
		[246848] = Defaults(), -- Luring Destruction
		[246220] = Defaults(), -- Fel Bombardment
		[247159] = Defaults(), -- Luring Destruction
		[244122] = Defaults(), -- Carnage
		[244410] = Defaults(), -- Decimation
		[245294] = Defaults(), -- Empowered Decimation
		[246368] = Defaults(), -- Searing Barrage

		-- Felhounds of Sargeras
		[245022] = Defaults(), -- Burning Remnant
		[251445] = Defaults(), -- Smouldering
		[251448] = Defaults(), -- Burning Maw
		[244086] = Defaults(), -- Molten Touch
		[244091] = Defaults(), -- Singed
		[244768] = Defaults(), -- Desolate Gaze
		[244767] = Defaults(), -- Desolate Path
		[244471] = Defaults(), -- Enflame Corruption
		[248815] = Defaults(), -- Enflamed
		[244517] = Defaults(), -- Lingering Flames
		[245098] = Defaults(), -- Decay
		[251447] = Defaults(), -- Corrupting Maw
		[244131] = Defaults(), -- Consuming Sphere
		[245024] = Defaults(), -- Consumed
		[244071] = Defaults(), -- Weight of Darkness
		[244578] = Defaults(), -- Siphon Corruption
		[248819] = Defaults(), -- Siphoned
		[254429] = Defaults(), -- Weight of Darkness
		[244072] = Defaults(), -- Molten Touch

		-- Antoran High Command
		[245121] = Defaults(), -- Entropic Blast
		[244748] = Defaults(), -- Shocked
		[244824] = Defaults(), -- Warp Field
		[244892] = Defaults(), -- Exploit Weakness
		[244172] = Defaults(), -- Psychic Assault
		[244388] = Defaults(), -- Psychic Scarring
		[244420] = Defaults(), -- Chaos Pulse
		[254771] = Defaults(), -- Disruption Field
		[257974] = Defaults(), -- Chaos Pulse
		[244910] = Defaults(), -- Felshield
		[244737] = Defaults(), -- Shock Grenade

		-- Portal Keeper Hasabel
		[244016] = Defaults(), -- Reality Tear
		[245157] = Defaults(), -- Everburning Light
		[245075] = Defaults(), -- Hungering Gloom
		[245240] = Defaults(), -- Oppressive Gloom
		[244709] = Defaults(), -- Fiery Detonation
		[246208] = Defaults(), -- Acidic Web
		[246075] = Defaults(), -- Catastrophic Implosion
		[244826] = Defaults(), -- Fel Miasma
		[246316] = Defaults(), -- Poison Essence
		[244849] = Defaults(), -- Caustic Slime
		[245118] = Defaults(), -- Cloying Shadows
		[245050] = Defaults(), -- Delusions
		[245040] = Defaults(), -- Corrupt
		[244607] = Defaults(), -- Flames of Xoroth
		[244915] = Defaults(), -- Leech Essence
		[244926] = Defaults(), -- Felsilk Wrap
		[244949] = Defaults(), -- Felsilk Wrap
		[244613] = Defaults(), -- Everburning Flames

		-- Eonar the Life-Binder
		[248326] = Defaults(), -- Rain of Fel
		[248861] = Defaults(), -- Spear of Doom
		[249016] = Defaults(), -- Feedback - Targeted
		[249015] = Defaults(), -- Feedback - Burning Embers
		[249014] = Defaults(), -- Feedback - Foul Steps
		[249017] = Defaults(), -- Feedback - Arcane Singularity
		[250693] = Defaults(), -- Arcane Buildup
		[250691] = Defaults(), -- Burning Embers
		[248795] = Defaults(), -- Fel Wake
		[248332] = Defaults(), -- Rain of Fel
		[250140] = Defaults(), -- Foul Steps

		-- Imonar the Soulhunter
		[248424] = Defaults(), -- Gathering Power
		[247552] = Defaults(), -- Sleep Canister
		[247565] = Defaults(), -- Slumber Gas
		[250224] = Defaults(), -- Shocked
		[248252] = Defaults(), -- Infernal Rockets
		[247687] = Defaults(), -- Sever
		[247716] = Defaults(), -- Charged Blasts
		[247367] = Defaults(), -- Shock Lance
		[250255] = Defaults(), -- Empowered Shock Lance
		[247641] = Defaults(), -- Stasis Trap
		[255029] = Defaults(), -- Sleep Canister
		[248321] = Defaults(), -- Conflagration
		[247932] = Defaults(), -- Shrapnel Blast
		[248070] = Defaults(), -- Empowered Shrapnel Blast
		[254183] = Defaults(), -- Seared Skin

		-- Kin'garoth
		[244312] = Defaults(), -- Forging Strike
		[246840] = Defaults(), -- Ruiner
		[248061] = Defaults(), -- Purging Protocol
		[249686] = Defaults(), -- Reverberating Decimation
		[246706] = Defaults(), -- Demolish
		[246698] = Defaults(), -- Demolish
		[245919] = Defaults(), -- Meteor Swarm
		[245770] = Defaults(), -- Decimation

		-- Varimathras
		[244042] = Defaults(), -- Marked Prey
		[243961] = Defaults(), -- Misery
		[248732] = Defaults(), -- Echoes of Doom
		[243973] = Defaults(), -- Torment of Shadows
		[244005] = Defaults(), -- Dark Fissure
		[244093] = Defaults(), -- Necrotic Embrace
		[244094] = Defaults(), -- Necrotic Embrace

		-- The Coven of Shivarra
		[244899] = Defaults(), -- Fiery Strike
		[245518] = Defaults(), -- Flashfreeze
		[245586] = Defaults(), -- Chilled Blood
		[246763] = Defaults(), -- Fury of Golganneth
		[245674] = Defaults(), -- Flames of Khaz'goroth
		[245671] = Defaults(), -- Flames of Khaz'goroth
		[245910] = Defaults(), -- Spectral Army of Norgannon
		[253520] = Defaults(), -- Fulminating Pulse
		[245634] = Defaults(), -- Whirling Saber
		[253020] = Defaults(), -- Storm of Darkness
		[245921] = Defaults(), -- Spectral Army of Norgannon
		[250757] = Defaults(), -- Cosmic Glare

		-- Aggramar
		[244291] = Defaults(), -- Foe Breaker
		[255060] = Defaults(), -- Empowered Foe Breaker
		[245995] = Defaults(), -- Scorching Blaze
		[246014] = Defaults(), -- Searing Tempest
		[244912] = Defaults(), -- Blazing Eruption
		[247135] = Defaults(), -- Scorched Earth
		[247091] = Defaults(), -- Catalyzed
		[245631] = Defaults(), -- Unchecked Flame
		[245916] = Defaults(), -- Molten Remnants
		[245990] = Defaults(), -- Taeshalach's Reach
		[254452] = Defaults(), -- Ravenous Blaze
		[244736] = Defaults(), -- Wake of Flame
		[247079] = Defaults(), -- Empowered Flame Rend

		-- Argus the Unmaker
		[251815] = Defaults(), -- Edge of Obliteration
		[248499] = Defaults(), -- Sweeping Scythe
		[250669] = Defaults(), -- Soulburst
		[251570] = Defaults(), -- Soulbomb
		[248396] = Defaults(), -- Soulblight
		[258039] = Defaults(), -- Deadly Scythe
		[252729] = Defaults(), -- Cosmic Ray
		[256899] = Defaults(), -- Soul Detonation
		[252634] = Defaults(), -- Cosmic Smash
		[252616] = Defaults(), -- Cosmic Beacon
		[255200] = Defaults(), -- Aggramar's Boon
		[255199] = Defaults(), -- Avatar of Aggramar
		[258647] = Defaults(), -- Gift of the Sea
		[253901] = Defaults(), -- Strength of the Sea
		[257299] = Defaults(), -- Ember of Rage
		[248167] = Defaults(), -- Death Fog
		[258646] = Defaults(), -- Gift of the Sky
		[253903] = Defaults(), -- Strength of the Sky
	},
}

--------------------------------
-- CC DEBUFFS (TRACKING LIST) --
--------------------------------

TukuiUnitFrames.DebuffsTracking["CCDebuffs"] = {
	["type"] = "Whitelist",
	["spells"] = {
		-- Death Knight
		[47476]  = Defaults(2), -- Strangulate
		[108194] = Defaults(4), -- Asphyxiate UH
		[221562] = Defaults(4), -- Asphyxiate Blood
		[207171] = Defaults(4), -- Winter is Coming
		[206961] = Defaults(3), -- Tremble Before Me
		[207167] = Defaults(4), -- Blinding Sleet
		[212540] = Defaults(1), -- Flesh Hook (Pet)
		[91807]  = Defaults(1), -- Shambling Rush (Pet)
		[204085] = Defaults(1), -- Deathchill
		[233395] = Defaults(1), -- Frozen Center
		[212332] = Defaults(4), -- Smash (Pet)
		[212337] = Defaults(4), -- Powerful Smash (Pet)
		[91800]  = Defaults(4), -- Gnaw (Pet)
		[91797]  = Defaults(4), -- Monstrous Blow (Pet)
		[210141] = Defaults(3), -- Zombie Explosion
		
		-- Demon Hunter
		[207685] = Defaults(4), -- Sigil of Misery
		[217832] = Defaults(3), -- Imprison
		[221527] = Defaults(5), -- Imprison (Banished version)
		[204490] = Defaults(2), -- Sigil of Silence
		[179057] = Defaults(3), -- Chaos Nova
		[211881] = Defaults(4), -- Fel Eruption
		[205630] = Defaults(3), -- Illidan's Grasp
		[208618] = Defaults(3), -- Illidan's Grasp (Afterward)
		[213491] = Defaults(4), -- Demonic Trample (it's this one or the other)
		[208645] = Defaults(4), -- Demonic Trample
		[200166] = Defaults(4), -- Metamorphosis
		
		-- Druid
		[81261]  = Defaults(2), -- Solar Beam
		[5211]   = Defaults(4), -- Mighty Bash
		[163505] = Defaults(4), -- Rake
		[203123] = Defaults(4), -- Maim
		[202244] = Defaults(4), -- Overrun
		[99]     = Defaults(4), -- Incapacitating Roar
		[33786]  = Defaults(5), -- Cyclone
		[209753] = Defaults(5), -- Cyclone Balance
		[45334]  = Defaults(1), -- Immobilized
		[102359] = Defaults(1), -- Mass Entanglement
		[339]    = Defaults(1), -- Entangling Roots
		
		-- Hunter
		[202933] = Defaults(2), -- Spider Sting (it's this one or the other)
		[233022] = Defaults(2), -- Spider Sting
		[224729] = Defaults(4), -- Bursting Shot
		[213691] = Defaults(4), -- Scatter Shot
		[19386]  = Defaults(3), -- Wyvern Sting
		[3355]   = Defaults(3), -- Freezing Trap
		[203337] = Defaults(5), -- Freezing Trap (Survival PvPT)
		[209790] = Defaults(3), -- Freezing Arrow
		[24394]  = Defaults(4), -- Intimidation
		[117526] = Defaults(4), -- Binding Shot
		[190927] = Defaults(1), -- Harpoon
		[201158] = Defaults(1), -- Super Sticky Tar
		[162480] = Defaults(1), -- Steel Trap
		[212638] = Defaults(1), -- Tracker's Net
		[200108] = Defaults(1), -- Ranger's Net
		
		-- Mage
		[61721]  = Defaults(3), -- Rabbit (Poly)
		[61305]  = Defaults(3), -- Black Cat (Poly)
		[28272]  = Defaults(3), -- Pig (Poly)
		[28271]  = Defaults(3), -- Turtle (Poly)
		[126819] = Defaults(3), -- Porcupine (Poly)
		[161354] = Defaults(3), -- Monkey (Poly)
		[161353] = Defaults(3), -- Polar bear (Poly)
		[118]    = Defaults(3), -- Polymorph
		[82691]  = Defaults(3), -- Ring of Frost
		[31661]  = Defaults(3), -- Dragon's Breath
		[122]    = Defaults(1), -- Frost Nova
		[33395]  = Defaults(1), -- Freeze
		[157997] = Defaults(1), -- Ice Nova
		[228600] = Defaults(1), -- Glacial Spike
		[198121] = Defaults(1), -- Forstbite
		
		-- Monk
		[119381] = Defaults(4), -- Leg Sweep
		[202346] = Defaults(4), -- Double Barrel
		[115078] = Defaults(4), -- Paralysis
		[198909] = Defaults(3), -- Song of Chi-Ji
		[202274] = Defaults(3), -- Incendiary Brew
		[233759] = Defaults(2), -- Grapple Weapon
		[123407] = Defaults(1), -- Spinning Fire Blossom
		[116706] = Defaults(1), -- Disable
		[232055] = Defaults(4), -- Fists of Fury (it's this one or the other)
		
		-- Paladin
		[853]    = Defaults(3), -- Hammer of Justice
		[20066]  = Defaults(3), -- Repentance
		[105421] = Defaults(3), -- Blinding Light
		[31935]  = Defaults(2), -- Avenger's Shield
		[217824] = Defaults(2), -- Shield of Virtue
		[205290] = Defaults(3), -- Wake of Ashes
		
		-- Priest
		[9484]   = Defaults(3), -- Shackle Undead
		[200196] = Defaults(4), -- Holy Word: Chastise
		[200200] = Defaults(4), -- Holy Word: Chastise
		[226943] = Defaults(3), -- Mind Bomb
		[605]    = Defaults(5), -- Mind Control
		[8122]   = Defaults(3), -- Psychic Scream
		[15487]  = Defaults(2), -- Silence
		[199683] = Defaults(2), -- Last Word
		
		-- Rogue
		[2094]   = Defaults(4), -- Blind
		[6770]   = Defaults(4), -- Sap
		[1776]   = Defaults(4), -- Gouge
		[199743] = Defaults(4), -- Parley
		[1330]   = Defaults(2), -- Garrote - Silence
		[207777] = Defaults(2), -- Dismantle
		[199804] = Defaults(4), -- Between the Eyes
		[408]    = Defaults(4), -- Kidney Shot
		[1833]   = Defaults(4), -- Cheap Shot
		[207736] = Defaults(5), -- Shadowy Duel (Smoke effect)
		[212182] = Defaults(5), -- Smoke Bomb
		
		-- Shaman
		[51514]  = Defaults(3), -- Hex
		[211015] = Defaults(3), -- Hex (Cockroach)
		[211010] = Defaults(3), -- Hex (Snake)
		[211004] = Defaults(3), -- Hex (Spider)
		[210873] = Defaults(3), -- Hex (Compy)
		[196942] = Defaults(3), -- Hex (Voodoo Totem)
		[118905] = Defaults(3), -- Static Charge
		[77505]  = Defaults(4), -- Earthquake (Knocking down)
		[118345] = Defaults(4), -- Pulverize (Pet)
		[204399] = Defaults(3), -- Earthfury
		[204437] = Defaults(3), -- Lightning Lasso
		[157375] = Defaults(4), -- Gale Force
		[64695]  = Defaults(1), -- Earthgrab
		
		-- Warlock
		[710]    = Defaults(5), -- Banish
		[6789]   = Defaults(3), -- Mortal Coil
		[118699] = Defaults(3), -- Fear
		[5484]   = Defaults(3), -- Howl of Terror
		[6358]   = Defaults(3), -- Seduction (Succub)
		[171017] = Defaults(4), -- Meteor Strike (Infernal)
		[22703]  = Defaults(4), -- Infernal Awakening (Infernal CD)
		[30283]  = Defaults(3), -- Shadowfury
		[89766]  = Defaults(4), -- Axe Toss
		[233582] = Defaults(1), -- Entrenched in Flame
		
		-- Warrior
		[5246]   = Defaults(4), -- Intimidating Shout
		[7922]   = Defaults(4), -- Warbringer
		[132169] = Defaults(4), -- Storm Bolt
		[132168] = Defaults(4), -- Shockwave
		[199085] = Defaults(4), -- Warpath
		[105771] = Defaults(1), -- Charge
		[199042] = Defaults(1), -- Thunderstruck
		
		-- Racials
		[155145] = Defaults(2), -- Arcane Torrent
		[20549]  = Defaults(4), -- War Stomp
		[107079] = Defaults(4), -- Quaking Palm
	},
}

------------------------------------------------------------------------------------
-- RAID BUFFS (SQUARED AURA TRACKING LIST)
------------------------------------------------------------------------------------

TukuiUnitFrames.RaidBuffsTracking = {
	PRIEST = {
		{41635, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},             -- Prayer of Mending 
		{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}},                -- Renew
		{17, "TOPLEFT", {1, 1, 0}, true},                    -- Power Word: Shield
		{194384, "TOPRIGHT", {0.81, 0.70, 0.23}, true},      -- Atonement
		{214206, "TOPRIGHT", {0.81, 0.70, 0.23}, true},      -- PVP Atonement
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
		{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},	     -- Hand of Sacrifice
	},

	SHAMAN = {
		{61295, "TOPLEFT", {0.7, 0.3, 0.7}},                 -- Riptide
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