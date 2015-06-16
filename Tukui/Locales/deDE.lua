local T, C, L = select(2, ...):unpack()

if (GetLocale() ~= "deDE") then
	return
end

------------------------------------------------
L.ChatFrames = {} -- Data Text Locales
------------------------------------------------

L.ChatFrames.LocalDefense = "LokaleVerteidigung"
L.ChatFrames.GuildRecruitment = "Gildenrekrutierung"
L.ChatFrames.LookingForGroup = "SucheNachGruppe"

------------------------------------------------
L.DataText = {} -- Data Text Locales
------------------------------------------------

L.DataText.AvoidanceBreakdown = "Vermeidung Aufgliederung"
L.DataText.Level = "Stufe"
L.DataText.Boss = "Boss"
L.DataText.Miss = "Verfehlen"
L.DataText.Dodge = "Ausweichen"
L.DataText.Block = "Blocken"
L.DataText.Parry = "Parieren"
L.DataText.Avoidance = "Vermeidung"
L.DataText.AvoidanceShort = "AVD: "
L.DataText.Memory = "Speicher"
L.DataText.Power = "Angriffskraft"
L.DataText.Mastery = "Meisterschaft"
L.DataText.Crit = "Krit"
L.DataText.Regen = "Regeneration"
L.DataText.Versatility = "Vielseitigkeit"
L.DataText.Leech = "Lebensdiebstahl"
L.DataText.Multistrike = "Mehrfachschlag"
L.DataText.Session = "Sitzung: "
L.DataText.Earned = "Bekommen:"
L.DataText.Spent = "Ausgegeben:"
L.DataText.Deficit = "Defizit:"
L.DataText.Profit = "Profit:"
L.DataText.Character = "Character: "
L.DataText.Server = "Server: "
L.DataText.Gold = "Gold"
L.DataText.TotalGold = "Gesamt: "
L.DataText.GoldShort = "|cffffd700g|r"
L.DataText.SilverShort = "|cffc7c7cfs|r"
L.DataText.CopperShort = "|cffeda55fc|r"
L.DataText.Talents = "Talente"
L.DataText.NoTalent = "Keine Talente"
L.DataText.Download = "Download: "
L.DataText.Bandwidth = "Bandbreite: "
L.DataText.Guild = "Gilde"
L.DataText.NoGuild = "Keine Gilde"
L.DataText.Bags = "Taschen"
L.DataText.BagSlots = "Taschenplätze"
L.DataText.Friends = "Freunde"
L.DataText.Online = "Online: "
L.DataText.Armor = "Rüstung"
L.DataText.Durability = "Haltbarkeit"
L.DataText.TimeTo = "Zeit bis"
L.DataText.FriendsList = "Freundesliste:"
L.DataText.Spell = "SP"
L.DataText.AttackPower = "AP"
L.DataText.Haste = "Tempo"
L.DataText.DPS = "DPS"
L.DataText.HPS = "HPS"
L.DataText.Session = "Sitzung: "
L.DataText.Character = "Character: "
L.DataText.Server = "Server: "
L.DataText.Total = "Gesammt: "
L.DataText.SavedRaid = "Gespeicherte Schlachtzüge"
L.DataText.Currency = "Währung"
L.DataText.FPS = " FPS & "
L.DataText.MS = " MS"
L.DataText.FPSAndMS = "FPS & MS"
L.DataText.Critical = " Kritisch"
L.DataText.Heal = " Heilung"
L.DataText.Time = "Zeit"
L.DataText.ServerTime = "Server Zeit: "
L.DataText.LocalTime = "Lokal Zeit: "
L.DataText.Mitigation = "Milderung durch Stufe: "
L.DataText.Healing = "Heilung: "
L.DataText.Damage = "Schaden: "
L.DataText.Honor = "Ehre: "
L.DataText.KillingBlow = "Todesstöße: "
L.DataText.StatsFor = "Werte für "
L.DataText.HonorableKill = "Ehrenhafte Siege:"
L.DataText.Death = "Tode:"
L.DataText.HonorGained = "Ehre Bekommen:"
L.DataText.DamageDone = "Schaden verursacht:"
L.DataText.HealingDone = "Heilung gewirkt:"
L.DataText.BaseAssault = "Stützpunkte eingenommen:"
L.DataText.BaseDefend = "Stützpunkte verteidigt:"
L.DataText.TowerAssault = "Türme angegriffen:"
L.DataText.TowerDefend = "Türme verteidigt:"
L.DataText.FlagCapture = "Flaggen eingenommen:"
L.DataText.FlagReturn = "Flaggen zurückgeholt:"
L.DataText.GraveyardAssault = "Friedhöfe angegriffen:"
L.DataText.GraveyardDefend = "Friedhöfe verteidigt:"
L.DataText.DemolisherDestroy = "Demolishers Destroyed:"
L.DataText.GateDestroy = "Tore zerstört:"
L.DataText.TotalMemory = "Gesamte Speicherauslastung:"
L.DataText.ControlBy = "Kontrolliert von:"
L.DataText.CallToArms = "Ruf zu den Waffen" 
L.DataText.ArmError = "Es konnten keine Informationen für Ruf zu den Waffen abgerufen werden."
L.DataText.NoDungeonArm = "Derzeit bietet keine der Instanzen Ruf zu den Waffen an."
L.DataText.CartControl = "Loren kontrolliert:"
L.DataText.VictoryPts = "Siegpunkte:"
L.DataText.OrbPossession = "Erhaltene Kugeln:"
L.DataText.Slots = {
	[1] = {1, "Kopf", 1000},
	[2] = {3, "Schulter", 1000},
	[3] = {5, "Brust", 1000},
	[4] = {6, "Taille", 1000},
	[5] = {9, "Handgelenke", 1000},
	[6] = {10, "Hände", 1000},
	[7] = {7, "Beine", 1000},
	[8] = {8, "Schuhe", 1000},
	[9] = {16, "Waffenhand", 1000},
	[10] = {17, "Schildhand", 1000},
	[11] = {18, "Distanzwaffe", 1000}
}

------------------------------------------------
L.Tooltips = {} -- Tooltips Locales
------------------------------------------------

L.Tooltips.MoveAnchor = "Bewege Spiel Tooltip"

------------------------------------------------
L.UnitFrames = {} -- Unit Frames Locales
------------------------------------------------

L.UnitFrames.Ghost = "Geist"
L.UnitFrames.Wrath = "Zorn"
L.UnitFrames.Starfire = "Sternenfeuer"

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
L.ActionBars.MoveStanceBar = "Bewege Haltungsleiste"

------------------------------------------------
L.Minimap = {} -- Minimap Locales
------------------------------------------------

L.Minimap.MoveMinimap = "Bewege Minimap"

------------------------------------------------
L.Miscellaneous = {} -- Miscellaneous
------------------------------------------------

L.Miscellaneous.Repair = "Warnung! Du solltest so schnell wie möglich deine Austüstung reparieren!"

------------------------------------------------
L.Auras = {} -- Aura Locales
------------------------------------------------

L.Auras.MoveBuffs = "Bewege Stärkungszauber"
L.Auras.MoveDebuffs = "Bewege Schwächungszauber"

------------------------------------------------
L.Install = {} -- Installation of Tukui
------------------------------------------------

L.Install.Tutorial = "Tutorial"
L.Install.Install = "Installation"
L.Install.InstallStep0 = "Danke das du dich für Tukui entschieden hast!|n|nDu wirst nun in ein paar Schritten durch den Installationsprozess durchgeführt. Du kannst bei jedem Schritt entscheiden, was du haben möchtest oder nicht oder aber auch überspringen."
L.Install.InstallStep1 = "Der erste Schritt betrifft die wesentlichen Einstellungen. Dies wird für jeden Benutzer | cffff0000empfohlen | r , es sei denn, Du möchtest nur einen bestimmten Teil der Einstellungen anwenden.|n|nKlick 'Anwenden' um die Einstellungen zu übernehmen und 'Weiter' um den Installationsprozess fortzufahren. Wenn du den Schritt übersprigen möchtest, dann drücke 'Weiter'."
L.Install.InstallStep2 = "Der zweite Schritt übernimmt die Chateinstellungen. Wenn Du ein neuer Benutzer dieses UI bist, wird dieser Schritt empfohlen.  Wenn Du mit diesem UI vertraut bist, könntest du diesen Schritt überspringen.|n|nKlicke auf 'Anwenden', um die Einstellungen zu übernehmen und auf 'Weiter', um den Installationsprozess fortsetzen. Wenn Du diesen Schritt überspringen möchten, klicke einfach auf 'Weiter'."
L.Install.InstallStep3 = "Installation fertig. Bitte klicke auf 'Fertig' Um dein UI neu zu laden. Viel spaß mit Tukui! Besuche uns unter www.tukui.org!"

------------------------------------------------
L.Help = {} -- /tukui help
------------------------------------------------

L.Help.Title = "Tukui Kommandos:"
L.Help.Datatexts = "'|cff00ff00dt|r' oder '|cff00ff00datatext|r' : Aktiviere oder Deaktiviere die Datatext Konfiguration."
L.Help.Install = "'|cff00ff00install|r' oder '|cff00ff00reset|r' : Installiere oder Setze Tukui auf Standardeinstellungen zurück."
L.Help.Config = "'|cff00ff00c|r' oder '|cff00ff00config|r' : Zeige das In-Game-Konfigurations Fenster."
L.Help.Move = "'|cff00ff00move|r' oder '|cff00ff00moveui|r' : Bewege Fenster."
L.Help.Test = "'|cff00ff00test|r' oder '|cff00ff00testui|r' : Teste Einheiten Fenster."
L.Help.Profile = "'|cff00ff00profile|r' or '|cff00ff00p|r' : Use Tukui settings (existing profile) from another character."

------------------------------------------------
L.Merchant = {} -- Merchant
------------------------------------------------

L.Merchant.NotEnoughMoney = "Du hast nicht genug Gold, um deine Ausrüstung zu reparieren"
L.Merchant.RepairCost = "Deine Ausrüstung wurde repariert für"
L.Merchant.SoldTrash = "Dein Schrott wurde verkauft für"

------------------------------------------------
L.Version = {} -- Version Check
------------------------------------------------

L.Version.Outdated = "Deine Version von Tukui ist veraltet. Du kannst dir die aktuelle Version unter www.tukui.org herunterladen."

------------------------------------------------
L.Others = {} -- Miscellaneous
------------------------------------------------

L.Others.GlobalSettings = "Benutze die globalen Einstellungen"
L.Others.CharSettings = "Benutze die Charakter Einstellungen"
L.Others.ProfileNotFound = "Profile not found"
L.Others.ProfileSelection = "Please type a profile to use (example: /tukui profile Illidan-Tukz)"
L.Others.ConfigNotFound = "Config not loaded."