local Locale = GetLocale()

-- German Locale
if (Locale ~= "deDE") then
	return
end

-- Some postfix's for certain controls.
local Performance = "\n|cffFF0000Deaktivieren kann die Leistung erhöhen|r" -- For high CPU options
local PerformanceSlight = "\n|cffFF0000Deaktivieren kann die Leistung leicht erhöhen|r" -- For semi-high CPU options
local RestoreDefault = "\n|cffFFFF00Rechtsklick um den Standartwert Wiederherzustellen|r" -- For color pickers

TukuiConfig["deDE"] = {
	["General"] = {
		["AutoScale"] = {
			["Name"] = "Auto Skalierung",
			["Desc"] = "Automatisch beste Auflösung erkennen",
		},
		
		["UIScale"] = {
			["Name"] = "UI Skalierung",
			["Desc"] = "Lege eigene UI skalierung fest",
		},
		
		["BackdropColor"] = {
			["Name"] = "Hintergrund Farbe",
			["Desc"] = "Lege die Hintergrundfarbe für alle Tukui Fenster fest"..RestoreDefault,
		},
		
		["BorderColor"] = {
			["Name"] = "Rahmenfarbe",
			["Desc"] = "Lege die Rahmenfarbe für alle Tukui Fenster fest"..RestoreDefault,
		},
		
		["HideShadows"] = {
			["Name"] = "Verstecke Schatten",
			["Desc"] = "Zeige oder verstecke die schatten bestimmten Tukui Fenstern",
		},
	},
	
	["ActionBars"] = {
		["Enable"] = {
			["Name"] = "Schalte Aktionsleisten ein",
			["Desc"] = "Derp",
		},
		
		["EquipBorder"] = {
			["Name"] = "Equipped Item Border",
			["Desc"] = "Display Green Border on Equipped Items",
		},

		["HotKey"] = {
			["Name"] = "Hotkeys",
			["Desc"] = "Zeige Hotkey Text an den Tasten",
		},
		
		["Macro"] = {
			["Name"] = "Macro Tasten",
			["Desc"] = "Zeige den Makro Text in den Tasten",
		},
		
		["ShapeShift"] = {
			["Name"] = "Gestaltenwechsel",
			["Desc"] = "Schalte Tukui Style Gestaltenwechselleiste ein",
		},
		
		["Pet"] = {
			["Name"] = "Begleiter",
			["Desc"] = "Schalte Tukui Style Begleiterleiste ein",
		},
		
		["SwitchBarOnStance"] = {
			["Name"] = "Swap main bar on new stance",
			["Desc"] = "Enable main action bar swap when you change stance.",
		},
		
		["NormalButtonSize"] = {
			["Name"] = "Tastengröße",
			["Desc"] = "Lege die Größe für die Aktionsleistentasten fest",
		},
		
		["PetButtonSize"] = {
			["Name"] = "Begleiter-Tastengröße",
			["Desc"] = "Legt die größe für die Begleitertasten fest",
		},
		
		["ButtonSpacing"] = {
			["Name"] = "Tastenabstand",
			["Desc"] = "Legt den Abstand zwischen den Tasten fest",
		},
		
		["OwnShadowDanceBar"] = {
			["Name"] = "Schattentanz Leiste",
			["Desc"] = "Benutze eine Spezialleiste für Schattentanz",
		},
		
		["OwnMetamorphosisBar"] = {
			["Name"] = "Metamorphose Leiste",
			["Desc"] = "Benutze eine Spezialleiste für Metamorphose",
		},
		
		["OwnWarriorStanceBar"] = {
			["Name"] = "Krieger Haltungsleiste",
			["Desc"] = "Benutze eine Spezialleiste für Krieger Haltungen",
		},
		
		["HideBackdrop"] = {
			["Name"] = "Verstecke Hintergrund",
			["Desc"] = "Schalte den Leistenhintergrund aus",
		},
		
		["Font"] = {
			["Name"] = "Aktionsleisten Schrifart",
			["Desc"] = "Lege die Schriftart der Aktionsleisten fest",
		},
	},
	
	["Auras"] = {
		["Enable"] = {
			["Name"] = "Schalte Auren ein",
			["Desc"] = "Derp",
		},
		
		["Consolidate"] = {
			["Name"] = "Consolidate Auras",
			["Desc"] = "Enable consolidated auras",
		},
		
		["Flash"] = {
			["Name"] = "Aufblitzende Auren",
			["Desc"] = "Lässt die Auren aufblitzen wenn sie auslaufen"..PerformanceSlight,
		},
		
		["ClassicTimer"] = {
			["Name"] = "Klassischer Timer",
			["Desc"] = "Benutze den Text Timer anstatt Auren",
		},
		
		["HideBuffs"] = {
			["Name"] = "Verstecke Buffs",
			["Desc"] = "Schalte Buffs aus",
		},
		
		["HideDebuffs"] = {
			["Name"] = "Verstecke Debuffs",
			["Desc"] = "Schalte Debuff aus",
		},
		
		["Animation"] = {
			["Name"] = "Animation",
			["Desc"] = "Zeige eine 'pop in' Animation in Auren"..PerformanceSlight,
		},
		
		["BuffsPerRow"] = {
			["Name"] = "Buffs per Reihe",
			["Desc"] = "Die Anzahl der Buffs, bevor eine neue Zeile beginnt,",
		},
		
		["Font"] = {
			["Name"] = "Aura Schriftart",
			["Desc"] = "Lege die Schriftart für die Auren",
		},
	},
	
	["Bags"] = {
		["Enable"] = {
			["Name"] = "Schalte Taschen ein",
			["Desc"] = "Derp",
		},
		
		["ButtonSize"] = {
			["Name"] = "Taschenplatz Größe",
			["Desc"] = "Legt die Größe der Taschenplätze fest",
		},
		
		["Spacing"] = {
			["Name"] = "Abstände",
			["Desc"] = "Legt die Abstände der Taschenplätzen fest",
		},
		
		["ItemsPerRow"] = {
			["Name"] = "Items pro Reihe",
			["Desc"] = "Legt fest wie viele Plätze in einer Reihe angezeigt werden",
		},
		
		["PulseNewItem"] = {
			["Name"] = "Neue Gegenstände aufblitzen",
			["Desc"] = "Neue Gegenstände in deinen Taschen werden eine Aufblitzanimation haben",
		},
		
		["Font"] = {
			["Name"] = "Taschenschriftart",
			["Desc"] = "Legt die Schriftart für die Tasche fest",
		},
		
		["BagFilter"] = {
			["Name"] = "Schalte Taschen Filter ein",
			["Desc"] = "Löscht automatisch unbrauchebare Items aus den Taschen wenn gelootet wird",
			["Default"] = "Löscht automatisch unbrauchebare Items aus den Taschen wenn gelootet wird",
		},
	},
	
	["Chat"] = {
		["Enable"] = {
			["Name"] = "Schalte Chat ein",
			["Desc"] = "Derp",
		},
		
		["WhisperSound"] = {
			["Name"] = "Flüster Sound",
			["Desc"] = "Spielt einen Sound ab wenn eine Flüstermitteilung erhalten wird",
		},
		
		["LinkColor"] = {
			["Name"] = "URL Link Farbe",
			["Desc"] = "Legt die Farbe für URL Links fest"..RestoreDefault,
		},
		
		["LinkBrackets"] = {
			["Name"] = "URL Link Klammern",
			["Desc"] = "Zeige URL Links in Klammern",
		},
		
		["LootFrame"] = {
			["Name"] = "Loot Fenster",
			["Desc"] = "Erstellt rechts ein separates 'Loot' Chatfenster",
		},
		
		["Background"] = {
			["Name"] = "Chat Hintergrund",
			["Desc"] = "Erstellt einen Hintergrund für das linke und rechte Chatfenster",
		},
		
		["ChatFont"] = {
			["Name"] = "Chat Schriftart",
			["Desc"] = "Legt die Schriftart für den Chat fest",
		},
		
		["TabFont"] = {
			["Name"] = "Chat Tab Schriftart",
			["Desc"] = "Legt die Schriftart für den Chat Tabs fest",
		},
		
		["ScrollByX"] = {
			["Name"] = "Maus scrollen",
			["Desc"] = "Legt die anzahl der Zeilen fest die der Chat beim scrollen weiter springt",
		},
	},
	
	["Cooldowns"] = {
		["Font"] = {
			["Name"] = "Abklingzeit Schriftart",
			["Desc"] = "Legt die Schriftart für die Abklingzeiten fest",
		},
	},
	
	["DataTexts"] = {
		["Battleground"] = {
			["Name"] = "Schalte Schlachtfeld ein Battleground",
			["Desc"] = "Schalte data texts Anzeige für Schlachtfeltinformationen ein",
		},
		
		["LocalTime"] = {
			["Name"] = "Lokale Zeit",
			["Desc"] = "Benutze die lokale Zeit für data text anstatt die Serverzeit",
		},
		
		["Time24HrFormat"] = {
			["Name"] = "24-Stunden Zeit Format",
			["Desc"] = "Schalte das 24-Stunden Format ein.",
		},
		
		["NameColor"] = {
			["Name"] = "Beschriftungsfarbe",
			["Desc"] = "Legt die Farbe für die Beschriftung fest, in der Regel der Name"..RestoreDefault,
		},
		
		["ValueColor"] = {
			["Name"] = "Werte Farbe",
			["Desc"] = "Legt die Farbe der Werte fest, in der Regel eine Zahl"..RestoreDefault,
		},
		
		["Font"] = {
			["Name"] = "Data Text Schriftart",
			["Desc"] = "Legt die Data Text Schriftart fest",
		},
	},
	
	["Merchant"] = {
		["AutoSellGrays"] = {
			["Name"] = "Automatisch Grau verkaufen",
			["Desc"] = "Wenn ein Händler besucht wird, werden automatisch alle Gegenstände grauer Qualität verkauft",
		},
		
		["SellMisc"] = {
			["Name"] = "Verkaufe Sonstige Gegenstände",
			["Desc"] = "Verkauft automatisch unnütze Gegenstände nitcht grauer Qualität",
		},
		
		["AutoRepair"] = {
			["Name"] = "Automatisch reparieren",
			["Desc"] = "Wenn ein Schmied besucht wird, wird automatisch deine Ausrüstung repariert",
		},
		
		["UseGuildRepair"] = {
			["Name"] = "Benutze Gildenreparatur",
			["Desc"] = "Wenn Automatisch reparieren eingeschalten ist benutze stattdessen von der Gildenbank repariert",
		},
	},
	
	["Misc"] = {
		["ThreatBarEnable"] = {
			["Name"] = "Schalte Aggroleiste ein",
			["Desc"] = "Derp",
		},
		
		["AltPowerBarEnable"] = {
			["Name"] = "Schalte Alternativ-Kraft ein",
			["Desc"] = "Derp",
		},
		
		["ExperienceEnable"] = {
			["Name"] = "Schalte Erfahrungsleiste ein",
			["Desc"] = "Schalte zwei Erfahrungsleisten links und rechts ab Bildschirm ein.",
		},
		
		["ReputationEnable"] = {
			["Name"] = "Schalte Rufleiste ein",
			["Desc"] = "Schalte zwei Rufleisten links und rechts ab Bildschirm ein.",
		},
		
		["ErrorFilterEnable"] = {
			["Name"] = "Schalte Fehlerfilter ein",
			["Desc"] = "Filtert die Fehlermeldungen von UI-Fenstern.",
		},
	},
	
	["NamePlates"] = {
		["Enable"] = {
			["Name"] = "Schalte Namensplaketten ein",
			["Desc"] = "Derp"..PerformanceSlight,
		},
		
		["Width"] = {
			["Name"] = "Breite festlegen",
			["Desc"] = "Legt die Breite der Namensplaketten fest",
		},
		
		["Height"] = {
			["Name"] = "Höhe festlegen",
			["Desc"] = "Legt die Höher der Namensplaketten fest",
		},
		
		["CastHeight"] = {
			["Name"] = "Zauberleisten Höhe",
			["Desc"] = "Legt die Höhe der Zauberleisten an den Namensplaketten fest",
		},
		
		["Spacing"] = {
			["Name"] = "Abstände",
			["Desc"] = "Legt die Abstände zwischen den Namensplaketten und der Zauberleiste fest",
		},
		
		["NonTargetAlpha"] = {
			["Name"] = "Kein Ziel Alpha",
			["Desc"] = "Der Alphawert von den Namensplaketten die nicht als Ziel sind",
		},
		
		["Texture"] = {
			["Name"] = "Namensplaketten Texture",
			["Desc"] = "Legt die Texture für die Namensplaketten fest",
		},
		
		["Font"] = {
			["Name"] = "Namensplaketten Schriftart",
			["Desc"] = "Legt die Schriftart der Namensplaketten fest",
		},
		
		["HealthText"] = {
			["Name"] = "Show Health Text",
			["Desc"] = "Add a text in the nameplate which show current health",
		},
	},
	
	["Party"] = {
		["Enable"] = {
			["Name"] = "Schalte Gruppenfenster ein",
			["Desc"] = "Derp",
		},
		
		["Portrait"] = {
			["Name"] = "Porträt",
			["Desc"] = "Zeige Porträts im Gruppenfenster",
		},
		
		["HealBar"] = {
			["Name"] = "Ankommende Heilung",
			["Desc"] = "Zeig eine Leiste mit ankommeneden Heilungen und Absorbationen",
		},
		
		["ShowPlayer"] = {
			["Name"] = "Zeige Spieler",
			["Desc"] = "Zeige dich selbst in der Gruppe",
		},
		
		["ShowHealthText"] = {
			["Name"] = "Gesundheits-Text",
			["Desc"] = "Zeige die menge der gesundheit die die Einheit verloren hat.",
		},
		
		["Font"] = {
			["Name"] = "Gruppenfenster Namensschriftart",
			["Desc"] = "Lege die Schriftart für den Namenstext im Gruppenfenster fest",
		},
		
		["HealthFont"] = {
			["Name"] = "Gruppenfenster Gesundheitsschriftart",
			["Desc"] = "Lege die Schriftart für Gesundheitstext im Gruppenfenster fest",
		},
		
		["PowerTexture"] = {
			["Name"] = "Power Leiste Texture",
			["Desc"] = "Lege die Power Leisten Texture fest",
		},
		
		["HealthTexture"] = {
			["Name"] = "Gesundheitsleisten Texture",
			["Desc"] = "Lege die Texture für die Gesundheitsleisten fest",
		},
		
		["RangeAlpha"] = {
			["Name"] = "Außer Reichweite Alpha",
			["Desc"] = "Legt die Tranzparenz für Einheiten fest die außer Reichweite sind",
		},
	},
	
	["Raid"] = {
		["Enable"] = {
			["Name"] = "Schalte Schlachtzugsfenster ein",
			["Desc"] = "Derp",
		},
		
		["ShowPets"] = {
			["Name"] = "Show Pets",
			["Desc"] = "Derp",
		},
		
		["Highlight"] = {
			["Name"] = "Highlight",
			["Desc"] = "Highlight your current focus/target",
		},
		
		["MaxUnitPerColumn"] = {
			["Name"] = "Raid members per column",
			["Desc"] = "Change the max number of raid members per column",
		},
		
		["HealBar"] = {
			["Name"] = "HealComm",
			["Desc"] = "Zeige eine Leiste für ankommende Heilungen und Absorbationen an",
		},
		
		["AuraWatch"] = {
			["Name"] = "Aura beobachten",
			["Desc"] = "Zeige die Timer für Klassenspezifische Buffs in den Ecken des Schlachtzugsfenster an",
		},
		
		["AuraWatchTimers"] = {
			["Name"] = "Aura beobachten Timer",
			["Desc"] = "Zeige die Timer an den Debuff Icons die erstellt werden mit Debuff beobachten",
		},
		
		["DebuffWatch"] = {
			["Name"] = "Debuff beobachten",
			["Desc"] = "Zeige ein großes Icon im Schlachtzugsfenster wenn eine Spieler einen wichtigen Debuff hat",
		},
		
		["RangeAlpha"] = {
			["Name"] = "Außer Reichweite Alpha",
			["Desc"] = "Legt die Tranzparenz für Einheiten fest die außer Reichweite sind",
		},
		
		["ShowRessurection"] = {
			["Name"] = "Zeige Wiederbelebungs Icon",
			["Desc"] = "Zeige ankommende Wiederbelebungen an Spielern",
		},
		
		["ShowHealthText"] = {
			["Name"] = "Gesundheitstext",
			["Desc"] = "Zeige die menge an Gesundheit die die einheit verloren hat.",
		},
		
		["VerticalHealth"] = {
			["Name"] = "Vertical Health",
			["Desc"] = "Display health lost vertically",
		},
		
		["Font"] = {
			["Name"] = "Schlachtzugsfenster Namensschriftart",
			["Desc"] = "Legt die Schriftart für die Namen im Schlachtzugsfenster an",
		},
		
		["HealthFont"] = {
			["Name"] = "Schalchtzugsfenster Gesundheutsschrifart",
			["Desc"] = "Legt die Schriftart für die Gesundheitstexte im Schlachtzugsfenster fest",
		},
		
		["PowerTexture"] = {
			["Name"] = "Power Leiste Texture",
			["Desc"] = "Legt die Texture von den Power Leisten fest",
		},
		
		["HealthTexture"] = {
			["Name"] = "Gesundheitsleiste Texture",
			["Desc"] = "Legt die Texture für die Gesundheitsleiten fest",
		},
		
		["GroupBy"] = {
			["Name"] = "Gruppieren nach",
			["Desc"] = "Definiere wie die Raidgruppen sortiert werden",
		},
	},
	
	["Tooltips"] = {
		["Enable"] = {
			["Name"] = "Schalte Tooltips ein",
			["Desc"] = "Derp",
		},
		
		["MouseOver"] = {
			["Name"] = "Mouseover",
			["Desc"] = "Enable mouseover tooltip",
		},
		
		["HideOnUnitFrames"] = {
			["Name"] = "Verstecke bei Einheitenfenster",
			["Desc"] = "Zeige keinen Tooltip an Einheitenfenstern an",
		},
		
		["UnitHealthText"] = {
			["Name"] = "Zeige Gesundheits Text",
			["Desc"] = "Zeige Gesundheits Text im Tooltipgesundheitsleiste an",
		},
		
		["ShowSpec"] = {
			["Name"] = "Spezialisierung und Gegenstandsstufe",
			["Desc"] = "Zeigt die Spieler Spezialisierung und die Gegenstandstufe im Tooltip an",
		},
		
		["HealthFont"] = {
			["Name"] = "Gesundheitsanzeige Schriftart",
			["Desc"] = "Legt die Schriftart für die Gesundheitsanzeige fest die unterhalb des Tooltips liegt",
		},
		
		["HealthTexture"] = {
			["Name"] = "Gesundheitstextur Leiste",
			["Desc"] = "Legt die Texture für die Gesundheitsanzeige fest die unterhalb des Tooltips liegt",
		},
	},
	
	["UnitFrames"] = {
		["Enable"] = {
			["Name"] = "Schhalte Einheitenfenster ein",
			["Desc"] = "Derp",
		},
		
		["TargetEnemyHostileColor"] = {
			["Name"] = "Enemy Target Hostile Color",
			["Desc"] = "Enemy target health bar will be colored by hostility instead of by class color",
		},
		
		["CastBar"] = {
			["Name"] = "Schalte Zauberleiste ein",
			["Desc"] = "Schalte die Zauberleiste für die Einhatienfenster ein",
		},
		
		["UnlinkCastBar"] = {
			["Name"] = "Zauberleiste abkoppeln",
			["Desc"] = "Verschiebt die Spieler und Ziel Zauberleiste außerhalb der Einheitenfenster und erlaubt das Bewegen von den Zauberleisten am Bildschirm",
		},
		
		["CastBarIcon"] = {
			["Name"] = "Zauberleisten Icon",
			["Desc"] = "Erstellt ein Icon an der seite der Zauberleiste",
		},
		
		["CastBarLatency"] = {
			["Name"] = "Zauberleisten Latenz",
			["Desc"] = "Zeigt deine Latenz an den Zauberleisten",
		},
		
		["Smooth"] = {
			["Name"] = "Geschmeidige Leisten",
			["Desc"] = "Aktuallisiert die Gesundheitsleiste geschmeidig"..PerformanceSlight,
		},
		
		["CombatLog"] = {
			["Name"] = "Kampf Feedback",
			["Desc"] = "Zeige einkommende Heilungen und Schaden am Spielerfenster an",
		},
		
		["WeakBar"] = {
			["Name"] = "Geschwächte Seele Leiste",
			["Desc"] = "Zeige eine Leiste für den Geschwächte Seele Debuff an",
		},
		
		["HealBar"] = {
			["Name"] = "Ankommende Heilung",
			["Desc"] = "Zeige eine Leiste mit ankommenden Heilungen und Absorbationen",
		},
		
		["TotemBar"] = {
			["Name"] = "Totem Leiste",
			["Desc"] = "Erstellt eine tukui style Totem Leiste",
		},
		
		["ComboBar"] = {
			["Name"] = "Combo Points",
			["Desc"] = "Enable the combo points bar",
		},
		
		["AnticipationBar"] = {
			["Name"] = "Schurke Erwartung Leite Anticipation Bar",
			["Desc"] = "Zeige eine Leister für die Schurken Erwartungspunkte an",
		},
		
		["SerendipityBar"] = {
			["Name"] = "Priester Glücksfall Leiste",
			["Desc"] = "Zeige eine Leister für die Priester Glücksfall Stapel an",
		},
		
		["OnlySelfDebuffs"] = {
			["Name"] = "Zeige nur meine Debuffs",
			["Desc"] = "Zeige nur meine eigenen Debuffs am Ziel an",
		},

		["OnlySelfBuffs"] = {
			["Name"] = "Zeige nur meine Buffs",
			["Desc"] = "Zeige nur meine eigenen Buffs am Ziel an",
		},
		
		["DarkTheme"] = {
			["Name"] = "Dark Theme",
			["Desc"] = "Wenn eingeschalten, Werden die Einheitenfenster mit dunkel und die Powerbar in Klassen Farbe angezeit",
		},
		
		["Threat"] = {
			["Name"] = "Enable threat display",
			["Desc"] = "Health Bar on party and raid members will turn if they have aggro",
		},
		
		["Arena"] = {
			["Name"] = "Arena Frames",
			["Desc"] = "Display arena opponents when inside a battleground or arena",
		},
		
		["Boss"] = {
			["Name"] = "Boss Frames",
			["Desc"] = "Display boss frames while doing pve",
		},
		
		["TargetAuras"] = {
			["Name"] = "Target Auras",
			["Desc"] = "Display buffs and debuffs on target",
		},
		
		["FocusAuras"] = {
			["Name"] = "Focus Auras",
			["Desc"] = "Display buffs and debuffs on focus",
		},
		
		["FocusTargetAuras"] = {
			["Name"] = "Focus Target Auras",
			["Desc"] = "Display buffs and debuffs on focus target",
		},
		
		["ArenaAuras"] = {
			["Name"] = "Arena Frames Auras",
			["Desc"] = "Display debuffs on arena frames",
		},
		
		["BossAuras"] = {
			["Name"] = "Boss Frames Auras",
			["Desc"] = "Display debuffs on boss frames",
		},
		
		["AltPowerText"] = {
			["Name"] = "AltPower Text",
			["Desc"] = "Display altpower text values on altpower bar",
		},
		
		["Font"] = {
			["Name"] = "Einheitenfenster Schriftart",
			["Desc"] = "Legt die Schriftart für Einheitenfenster fest",
		},
		
		["PowerTexture"] = {
			["Name"] = "Power Leiste Texture",
			["Desc"] = "Legt die Textur für die Power Leisten fest",
		},
		
		["HealthTexture"] = {
			["Name"] = "Gesundheitsleiste Texture",
			["Desc"] = "Legit die Texture für die Gesundheitsleiste fest",
		},
		
		["CastTexture"] = {
			["Name"] = "Cast Bar Texture",
			["Desc"] = "Set a texture for cast bars",
		},
	},
}