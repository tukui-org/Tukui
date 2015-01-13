local T, C, L = select(2, ...):unpack()

if (GetLocale() ~= "esES") then
	return
end

------------------------------------------------
L.ChatFrames = {} -- Data Text Locales
------------------------------------------------

L.ChatFrames.LocalDefense = "DefensaLocal"
L.ChatFrames.GuildRecruitment = "ReclutamientoHermandad"
L.ChatFrames.LookingForGroup = "BuscandoGrupo"

------------------------------------------------
L.DataText = {} -- Data Text Locales
------------------------------------------------

L.DataText.AvoidanceBreakdown = "Avoidance Breakdown"
L.DataText.Level = "Lvl"
L.DataText.Boss = "Boss"
L.DataText.Miss = "Miss"
L.DataText.Dodge = "Dodge"
L.DataText.Block = "Block"
L.DataText.Parry = "Parry"
L.DataText.Avoidance = "Avoidance"
L.DataText.AvoidanceShort = "Avd: "
L.DataText.Memory = "Memory"
L.DataText.Hit = "Hit"
L.DataText.Power = "Power"
L.DataText.Mastery = "Mastery"
L.DataText.Crit = "Crit"
L.DataText.Regen = "Regen"
L.DataText.Versatility = "Versatility"
L.DataText.Leech = "Leech"
L.DataText.Multistrike = "Multistrike"
L.DataText.Session = "Session: "
L.DataText.Earned = "Earned:"
L.DataText.Spent = "Spent:"
L.DataText.Deficit = "Deficit:"
L.DataText.Profit = "Profit:"
L.DataText.Character = "Character: "
L.DataText.Server = "Server: "
L.DataText.Gold = "Gold"
L.DataText.TotalGold = "Total: "
L.DataText.GoldShort = "|cffffd700g|r"
L.DataText.SilverShort = "|cffc7c7cfs|r"
L.DataText.CopperShort = "|cffeda55fc|r"
L.DataText.Talents = "Talents"
L.DataText.NoTalent = "No Talents"
L.DataText.Download = "Download: "
L.DataText.Bandwidth = "Bandwidth: "
L.DataText.Guild = "Guild"
L.DataText.NoGuild = "No Guild"
L.DataText.Bags = "Bags"
L.DataText.BagSlots = "Bags Slots"
L.DataText.Friends = "Friends"
L.DataText.Online = "Online: "
L.DataText.Armor = "Armor"
L.DataText.Durability = "Durability"
L.DataText.TimeTo = "Time to"
L.DataText.FriendsList = "Friends list:"
L.DataText.Spell = "SP"
L.DataText.AttackPower = "AP"
L.DataText.Haste = "Haste"
L.DataText.DPS = "DPS"
L.DataText.HPS = "HPS"
L.DataText.Session = "Session: "
L.DataText.Character = "Character: "
L.DataText.Server = "Server: "
L.DataText.Total = "Total: "
L.DataText.SavedRaid = "Saved Raid(s)"
L.DataText.Currency = "Currency"
L.DataText.FPS = " FPS & "
L.DataText.MS = " MS"
L.DataText.FPSAndMS = "FPS & MS"
L.DataText.Critical = " Crit"
L.DataText.Heal = " Heal"
L.DataText.Time = "Time"
L.DataText.ServerTime = "Server Time: "
L.DataText.LocalTime = "Local Time: "
L.DataText.Mitigation = "Mitigation By Level: "
L.DataText.Healing = "Healing: "
L.DataText.Damage = "Damage: "
L.DataText.Honor = "Honor: "
L.DataText.KillingBlow = "Killing Blows: "
L.DataText.StatsFor = "Stats for "
L.DataText.HonorableKill = "Honorable Kills:"
L.DataText.Death = "Deaths:"
L.DataText.HonorGained = "Honor Gained:"
L.DataText.DamageDone = "Damage Done:"
L.DataText.HealingDone = "Healing Done:"
L.DataText.BaseAssault = "Bases Assaulted:"
L.DataText.BaseDefend = "Bases Defended:"
L.DataText.TowerAssault = "Towers Assaulted:"
L.DataText.TowerDefend = "Towers Defended:"
L.DataText.FlagCapture = "Flags Captured:"
L.DataText.FlagReturn = "Flags Returned:"
L.DataText.GraveyardAssault = "Graveyards Assaulted:"
L.DataText.GraveyardDefend = "Graveyards Defended:"
L.DataText.DemolisherDestroy = "Demolishers Destroyed:"
L.DataText.GateDestroy = "Gates Destroyed:"
L.DataText.TotalMemory = "Total Memory Usage:"
L.DataText.ControlBy = "Controlled by:"
L.DataText.CallToArms = "Call to Arms" 
L.DataText.ArmError = "Could not get Call To Arms information."
L.DataText.NoDungeonArm = "No dungeons are currently offering a Call To Arms."
L.DataText.CartControl = "Carts Controlled:"
L.DataText.VictoryPts = "Victory Points:"
L.DataText.OrbPossession = "Orb Possessions:"
L.DataText.Slots = {
	[1] = {1, "Head", 1000},
	[2] = {3, "Shoulder", 1000},
	[3] = {5, "Chest", 1000},
	[4] = {6, "Waist", 1000},
	[5] = {9, "Wrist", 1000},
	[6] = {10, "Hands", 1000},
	[7] = {7, "Legs", 1000},
	[8] = {8, "Feet", 1000},
	[9] = {16, "Main Hand", 1000},
	[10] = {17, "Off Hand", 1000},
	[11] = {18, "Ranged", 1000}
}

------------------------------------------------
L.Tooltips = {} -- Tooltips Locales
------------------------------------------------

L.Tooltips.MoveAnchor = "Move Game Tooltip"

------------------------------------------------
L.UnitFrames = {} -- Unit Frames Locales
------------------------------------------------

L.UnitFrames.Ghost = "Ghost"
L.UnitFrames.Wrath = "Wrath"
L.UnitFrames.Starfire = "Starfire"

------------------------------------------------
L.ActionBars = {} -- Action Bars Locales
------------------------------------------------

L.ActionBars.ArrowLeft = "◄"
L.ActionBars.ArrowRight = "►"
L.ActionBars.ArrowUp = "▲ ▲ ▲ ▲ ▲"
L.ActionBars.ArrowDown = "▼ ▼ ▼ ▼ ▼"
L.ActionBars.ExtraButton = "Extra Button"
L.ActionBars.CenterBar = "Bottom Center Bar"
L.ActionBars.ActionButton1 = "Main Bar: Bottom Center BottomRow Action Button 1"
L.ActionBars.ActionButton2 = "Main Bar: Bottom Center BottomRow Action Button 2"
L.ActionBars.ActionButton3 = "Main Bar: Bottom Center BottomRow Action Button 3"
L.ActionBars.ActionButton4 = "Main Bar: Bottom Center BottomRow Action Button 4"
L.ActionBars.ActionButton5 = "Main Bar: Bottom Center BottomRow Action Button 5"
L.ActionBars.ActionButton6 = "Main Bar: Bottom Center BottomRow Action Button 6"
L.ActionBars.ActionButton7 = "Main Bar: Bottom Center BottomRow Action Button 7"
L.ActionBars.ActionButton8 = "Main Bar: Bottom Center BottomRow Action Button 8"
L.ActionBars.ActionButton9 = "Main Bar: Bottom Center BottomRow Action Button 9"
L.ActionBars.ActionButton10 = "Main Bar: Bottom Center BottomRow Action Button 10"
L.ActionBars.ActionButton11 = "Main Bar: Bottom Center BottomRow Action Button 11"
L.ActionBars.ActionButton12 = "Main Bar: Bottom Center BottomRow Action Button 12"
L.ActionBars.MultiActionBar1Button1 = "BottomLeft BottomRow Button 6"
L.ActionBars.MultiActionBar1Button2 = "BottomLeft BottomRow Button 5"
L.ActionBars.MultiActionBar1Button3 = "BottomLeft BottomRow Button 4"
L.ActionBars.MultiActionBar1Button4 = "BottomLeft BottomRow Button 3"
L.ActionBars.MultiActionBar1Button5 = "BottomLeft BottomRow Button 2"
L.ActionBars.MultiActionBar1Button6 = "BottomLeft BottomRow Button 1"
L.ActionBars.MultiActionBar1Button7 = "BottomLeft TopRow Button 6"
L.ActionBars.MultiActionBar1Button8 = "BottomLeft TopRow Button 5"
L.ActionBars.MultiActionBar1Button9 = "BottomLeft TopRow Button 4"
L.ActionBars.MultiActionBar1Button10 = "BottomLeft TopRow Button 3"
L.ActionBars.MultiActionBar1Button11 = "BottomLeft TopRow Button 2"
L.ActionBars.MultiActionBar1Button12 = "BottomLeft TopRow Button 1"
L.ActionBars.MultiActionBar2Button1 = "BottomRight BottomRow Button 1"
L.ActionBars.MultiActionBar2Button2 = "BottomRight BottomRow Button 2"
L.ActionBars.MultiActionBar2Button3 = "BottomRight BottomRow Button 3"
L.ActionBars.MultiActionBar2Button4 = "BottomRight BottomRow Button 4"
L.ActionBars.MultiActionBar2Button5 = "BottomRight BottomRow Button 5"
L.ActionBars.MultiActionBar2Button6 = "BottomRight BottomRow Button 6"
L.ActionBars.MultiActionBar2Button7 = "BottomRight TopRow Button 1"
L.ActionBars.MultiActionBar2Button8 = "BottomRight TopRow Button 2"
L.ActionBars.MultiActionBar2Button9 = "BottomRight TopRow Button 3"
L.ActionBars.MultiActionBar2Button10 = "BottomRight TopRow Button 4"
L.ActionBars.MultiActionBar2Button11 = "BottomRight TopRow Button 5"
L.ActionBars.MultiActionBar2Button12 = "BottomRight TopRow Button 6"
L.ActionBars.MultiActionBar4Button1 = "Bottom Center TopRow Button 1"
L.ActionBars.MultiActionBar4Button2 = "Bottom Center TopRow Button 2"
L.ActionBars.MultiActionBar4Button3 = "Bottom Center TopRow Button 3"
L.ActionBars.MultiActionBar4Button4 = "Bottom Center TopRow Button 4"
L.ActionBars.MultiActionBar4Button5 = "Bottom Center TopRow Button 5"
L.ActionBars.MultiActionBar4Button6 = "Bottom Center TopRow Button 6"
L.ActionBars.MultiActionBar4Button7 = "Bottom Center TopRow Button 7"
L.ActionBars.MultiActionBar4Button8 = "Bottom Center TopRow Button 8"
L.ActionBars.MultiActionBar4Button9 = "Bottom Center TopRow Button 9"
L.ActionBars.MultiActionBar4Button10 = "Bottom Center TopRow Button 10"
L.ActionBars.MultiActionBar4Button11 = "Bottom Center TopRow Button 11"
L.ActionBars.MultiActionBar4Button12 = "Bottom Center TopRow Button 12"
L.ActionBars.MoveStanceBar = "Move Stance Bar"

------------------------------------------------
L.Minimap = {} -- Minimap Locales
------------------------------------------------

L.Minimap.MoveMinimap = "Move Minimap"

------------------------------------------------
L.Miscellaneous = {} -- Miscellaneous
------------------------------------------------

L.Miscellaneous.Repair = "Warning! You need to do a repair of your equipment as soon as possible!"

------------------------------------------------
L.Auras = {} -- Aura Locales
------------------------------------------------

L.Auras.MoveBuffs = "Move Buffs"
L.Auras.MoveDebuffs = "Move Debuffs"

------------------------------------------------
L.Install = {} -- Installation of Tukui
------------------------------------------------

L.Install.Tutorial = "Tutorial"
L.Install.Install = "Install"
L.Install.InstallStep0 = "Thank you for choosing Tukui!|n|nYou will be guided through the installation process in a few simple steps.  At each step, you can decide whether or not you want to apply or skip the presented settings."
L.Install.InstallStep1 = "The first step applies the essential settings. This is |cffff0000recommended|r for any user, unless you want to apply only a specific part of the settings.|n|nClick 'Apply' to apply the settings and 'Next' to continue the install process. If you wish to skip this step, just press 'Next'."
L.Install.InstallStep2 = "The second step applies the correct chat setup. If you are a new user, this step is recommended.  If you are an existing user, you may want to skip this step.|n|nClick 'Apply' to apply the settings and 'Next' to continue the install process. If you wish to skip this step, just press 'Next'."
L.Install.InstallStep3 = "Installation is complete. Please click the 'Complete' button to reload the UI. Enjoy Tukui! Visit us at www.tukui.org!"

------------------------------------------------
L.Help = {} -- /tukui help
------------------------------------------------

L.Help.Title = "Tukui Commands:"
L.Help.Datatexts = "'|cff00ff00dt|r' or '|cff00ff00datatext|r' : Enable or disable datatext configuration."
L.Help.Install = "'|cff00ff00install|r' or '|cff00ff00reset|r' : Install or reset Tukui to default settings."
L.Help.Config = "'|cff00ff00c|r' or '|cff00ff00config|r' : Display in-game configuration window."
L.Help.Move = "'|cff00ff00move|r' or '|cff00ff00moveui|r' : Move Frames."
L.Help.Test = "'|cff00ff00test|r' or '|cff00ff00testui|r' : Test Unit Frames."
L.Help.Profile = "'|cff00ff00profile|r' or '|cff00ff00p|r' : Use Tukui settings (existing profile) from another character."

------------------------------------------------
L.Merchant = {} -- Merchant
------------------------------------------------

L.Merchant.NotEnoughMoney = "You don't have enough money to repair!"
L.Merchant.RepairCost = "Your items have been repaired for"
L.Merchant.SoldTrash = "Your vendor trash has been sold and you earned"

------------------------------------------------
L.Version = {} -- Version Check
------------------------------------------------

L.Version.Outdated = "Your version of Tukui is out of date. You can download the latest version from www.tukui.org"

------------------------------------------------
L.Others = {} -- Miscellaneous
------------------------------------------------

L.Others.GlobalSettings = "Use Global Settings"
L.Others.CharSettings = "Use Character Settings"
L.Others.ProfileNotFound = "Profile not found"
L.Others.ProfileSelection = "Please type a profile to use (example: /tukui profile Illidan-Tukz)"
L.Others.ConfigNotFound = "Config not loaded."