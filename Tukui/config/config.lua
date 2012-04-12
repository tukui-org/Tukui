local T, C, L = unpack(select(2, ...))

-----------------------------------------
-- This is the default configuration file
-----------------------------------------

C["general"] = {
	["autoscale"] = true,                               -- mainly enabled for users that don't want to mess with the config file
	["uiscale"] = 0.71,                                 -- set your value (between 0.64 and 1) of your uiscale if autoscale is off
	["overridelowtohigh"] = false,                      -- EXPERIMENTAL ONLY! override lower version to higher version on a lower reso.
	["backdropcolor"] = { .1,.1,.1 },                   -- default backdrop color of panels
	["bordercolor"] = { .6,.6,.6 },                     -- default border color of panels
	["blizzardreskin"] = true,                          -- reskin all Blizzard frames
	["bigwigsreskin"] = true,                           -- reskin bigwigs
	["dbmreskin"] = true,                               -- reskin dbm
	["dxereskin"] = true,                               -- reskin dxe
	["omenreskin"] = true,                              -- reskin omen
	["recountreskin"] = true,                           -- reskin recount
	["skadareskin"] = true,                             -- reskin skada
	["tinydpsreskin"] = true,                           -- reskin tinydps
}

C["unitframes"] = {
	-- general options
	["enable"] = true,                                  -- do i really need to explain this?
	["enemyhcolor"] = false,                            -- enemy target (players) color by hostility, very useful for healer.
	["unitcastbar"] = true,                             -- enable tukui castbar
	["cblatency"] = false,                              -- enable castbar latency
	["cbicons"] = true,                                 -- enable icons on castbar
	["classiccombo"] = false,                           -- display classic combo points (from Tukui 13 or less)
	["movecombobar"] = true,                            -- display the new combo bar (t14+) from target to player (ROGUE ONLY)
	["auratimer"] = true,                               -- enable timers on buffs/debuffs
	["auratextscale"] = 11,                             -- the font size of buffs/debuffs timers on unitframes
	["targetauras"] = true,                             -- enable auras on target unit frame
	["lowThreshold"] = 20,                              -- global low threshold, for low mana warning.
	["targetpowerpvponly"] = true,                      -- enable power text on pvp target only
	["totdebuffs"] = false,                             -- enable tot debuffs (high reso only)
	["showtotalhpmp"] = false,                          -- change the display of info text on player and target with XXXX/Total.
	["showsmooth"] = true,                              -- enable smooth bar
	["charportrait"] = false,                           -- do i really need to explain this?
	["maintank"] = false,                               -- enable maintank
	["mainassist"] = false,                             -- enable mainassist
	["unicolor"] = false,                               -- enable unicolor theme
	["combatfeedback"] = true,                          -- enable combattext on player and target.
	["playeraggro"] = true,                             -- color player border to red if you have aggro on current target.
	["healcomm"] = false,                               -- enable healprediction support.
	["onlyselfdebuffs"] = false,                        -- display only our own debuffs applied on target
	["showfocustarget"] = true,                         -- show focus target
	["bordercolor"] = { .4,.4,.4 },                     -- unit frames panel border color

	-- raid layout (if one of them is enabled)
	["showrange"] = true,                               -- show range opacity on raidframes
	["raidalphaoor"] = 0.3,                             -- alpha of unitframes when unit is out of range
	["gridonly"] = false,                               -- enable grid only mode for all healer mode raid layout.
	["showsymbols"] = true,	                            -- show symbol.
	["aggro"] = true,                                   -- show aggro on all raids layouts
	["raidunitdebuffwatch"] = true,                     -- track important spell to watch in pve for grid mode.
	["gridhealthvertical"] = true,                      -- enable vertical grow on health bar for grid mode.
	["showplayerinparty"] = false,                      -- show my player frame in party
	["gridscale"] = 1,                                  -- set the healing grid scaling
	["gridvertical"] = false,                           -- grid group displayed vertically
	
	-- boss frames
	["showboss"] = true,                                -- enable boss unit frames for PVELOL encounters.

	-- priest only plugin
	["weakenedsoulbar"] = true,                         -- show weakened soul bar
	
	-- class bar
	["classbar"] = true,                                -- enable tukui classbar over player unit
}

C["arena"] = {
	["unitframes"] = true,                              -- enable tukz arena unitframes (requirement : tukui unitframes enabled)
}

C["auras"] = {
	["player"] = true,                                  -- enable tukui buffs/debuffs
	["consolidate"] = true,                             -- enable downpdown menu with consolidate buff
	["flash"] = false,                                   -- flash warning for buff with time < 30 sec
}

C["actionbar"] = {
	["enable"] = true,                                  -- enable tukui action bars
	["hotkey"] = true,                                  -- enable hotkey display because it was a lot requested
	["hideshapeshift"] = false,                         -- hide shapeshift or totembar because it was a lot requested.
	["showgrid"] = true,                                -- show grid on empty button
	["buttonsize"] = 27,                                -- normal buttons size
	["petbuttonsize"] = 29,                             -- pet & stance buttons size
	["buttonspacing"] = 4,                              -- buttons spacing
	["ownshdbar"] = false,                              -- use a complete new stance bar for shadow dance (rogue only)
}

C["bags"] = {
	["enable"] = true,                                  -- enable an all in one bag mod that fit tukui perfectly
}

C["loot"] = {
	["lootframe"] = true,                               -- reskin the loot frame to fit tukui
	["rolllootframe"] = true,                           -- reskin the roll frame to fit tukui
	["autogreed"] = true,                               -- auto-dez or auto-greed item at max level, auto-greed Frozen orb
}

C["cooldown"] = {
	["enable"] = true,                                  -- do i really need to explain this?
	["treshold"] = 8,                                   -- show decimal under X seconds and text turn red
}

C["datatext"] = {
	["fps_ms"] = 4,                                     -- show fps and ms on panels
	["system"] = 5,                                     -- show total memory and others systems infos on panels
	["bags"] = 0,                                       -- show space used in bags on panels
	["gold"] = 6,                                       -- show your current gold on panels
	["wowtime"] = 8,                                    -- show time on panels
	["guild"] = 1,                                      -- show number on guildmate connected on panels
	["dur"] = 2,                                        -- show your equipment durability on panels.
	["friends"] = 3,                                    -- show number of friends connected.
	["dps_text"] = 0,                                   -- show a dps meter on panels
	["hps_text"] = 0,                                   -- show a heal meter on panels
	["power"] = 7,                                      -- show your attackpower/spellpower/healpower/rangedattackpower whatever stat is higher gets displayed
	["haste"] = 0,                                      -- show your haste rating on panels.
	["crit"] = 0,                                       -- show your crit rating on panels.
	["avd"] = 0,                                        -- show your current avoidance against the level of the mob your targeting
	["armor"] = 0,                                      -- show your armor value against the level mob you are currently targeting
	["currency"] = 0,                                   -- show your tracked currency on panels
	["hit"] = 0,                                        -- show hit rating
	["mastery"] = 0,                                    -- show mastery rating
	["micromenu"] = 0,                                  -- add a micro menu thought datatext
	["regen"] = 0,                                      -- show mana regeneration
	["talent"] = 0,                                     -- show talent
	["calltoarms"] = 0,                                 -- show dungeon and call to arms

	["battleground"] = true,                            -- enable 3 stats in battleground only that replace stat1,stat2,stat3.
	["time24"] = true,                                  -- set time to 24h format.
	["localtime"] = false,                              -- set time to local time instead of server time.
	["fontsize"] = 12,                                  -- font size for panels.
}

C["chat"] = {
	["enable"] = true,                                  -- blah
	["whispersound"] = true,                            -- play a sound when receiving whisper
	["background"] = false,
}

C["nameplate"] = {
	["enable"] = true,                                  -- enable nice skinned nameplates that fit into tukui
	["showhealth"] = false,				                -- show health text on nameplate
	["enhancethreat"] = false,			                -- threat features based on if your a tank or not
	["combat"] = false,					                -- only show enemy nameplates in-combat.
	["goodcolor"] = {75/255,  175/255, 76/255},	        -- good threat color (tank shows this with threat, everyone else without)
	["badcolor"] = {0.78, 0.25, 0.25},			        -- bad threat color (opposite of above)
	["transitioncolor"] = {218/255, 197/255, 92/255},	-- threat color when gaining threat
}

C["tooltip"] = {
	["enable"] = true,                                  -- true to enable this mod, false to disable
	["hidecombat"] = false,                             -- hide bottom-right tooltip when in combat
	["hidebuttons"] = false,                            -- always hide action bar buttons tooltip.
	["hideuf"] = false,                                 -- hide tooltip on unitframes
	["cursor"] = false,                                 -- tooltip via cursor only
}

C["merchant"] = {
	["sellgrays"] = true,                               -- automaticly sell grays?
	["autorepair"] = true,                              -- automaticly repair?
	["sellmisc"] = true,                                -- sell defined items automatically
}

C["error"] = {
	["enable"] = true,                                  -- true to enable this mod, false to disable
	filter = {                                          -- what messages to not hide
		[INVENTORY_FULL] = true,                        -- inventory is full will not be hidden by default
	},
}

C["invite"] = { 
	["autoaccept"] = true,                              -- auto-accept invite from guildmate and friends.
}
