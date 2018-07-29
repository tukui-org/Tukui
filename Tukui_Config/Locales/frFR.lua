local Locale = GetLocale()

-- French Locale
if (Locale ~= "frFR") then
	return
end

-- Some postfix's for certain controls.
local Performance = "\n|cffFF0000La désactivation peut augmenter les performances|r" -- For high CPU options
local PerformanceSlight = "\n|cffFF0000La désactivation peut augmenter légèrement les performances|r" -- For semi-high CPU options
local RestoreDefault = "\n|cffFFFF00Clic droit pour restaurer par défaut|r" -- For color pickers

TukuiConfig["frFR"] = {
	["General"] = {
		["BackdropColor"] = {
			["Name"] = "Couleur de fond",
			["Desc"] = "Réglez la couleur de fond pour tous les cadres Tukui"..RestoreDefault,
		},

		["BorderColor"] = {
			["Name"] = "Couleur de la bordure",
			["Desc"] = "Réglez la couleur de la bordure pour tous les cadres Tukui"..RestoreDefault,
		},

		["HideShadows"] = {
			["Name"] = "Masquer les Ombres",
			["Desc"] = "Afficher ou masquer les ombres sur certains cadres de Tukui",
		},
		
		["Scaling"] = {
			["Name"] = "Échelle de l'UI",
			["Desc"] = "Définir la taille de l'interface utilisateur",
		},
		
		["Themes"] = {
			["Name"] = "Thème",
			["Desc"] = "L'application d'un thème modifie l'interface",
		},
		
		["AFKSaver"] = {
			["Name"] = "Écran de veille AFK",
			["Desc"] = "Active ou désactive l'écran de veille AFK",
		},
	},

	["ActionBars"] = {
		["Enable"] = {
			["Name"] = "Activer les barres d'action",
			["Desc"] = "Ehm...",
		},

		["EquipBorder"] = {
			["Name"] = "Identification équipement",
			["Desc"] = "Les bordures d'équipements dans la barre d'action sera coloré vert.",
		},

		["HotKey"] = {
			["Name"] = "Raccourcis clavier",
			["Desc"] = "Afficher le texte de raccourcis sur les boutons",
		},

		["Macro"] = {
			["Name"] = "Touches de macro",
			["Desc"] = "Afficher le texte de macro sur les boutons",
		},

		["ShapeShift"] = {
			["Name"] = "Barre de Postures",
			["Desc"] = "Activer les barre des postures",
		},

		["Pet"] = {
			["Name"] = "Barre du Familier",
			["Desc"] = "Activer la barre de Familier",
		},

		["SwitchBarOnStance"] = {
			["Name"] = "Changement de barre sur posture",
			["Desc"] = "Change la barre d'action principale lorsque l'on change de posture",
		},

		["NormalButtonSize"] = {
			["Name"] = "Taille des boutons",
			["Desc"] = "Définition de la taille des boutons de la barre d'action",
		},

		["PetButtonSize"] = {
			["Name"] = "Taille des boutons familiers",
			["Desc"] = "Définition de la taille des boutons de la barre des familiers",
		},

		["ButtonSpacing"] = {
			["Name"] = "Espacement des boutons",
			["Desc"] = "Réglez l'espacement entre les boutons de la barre d'action",
		},

		["HideBackdrop"] = {
			["Name"] = "Masquer le Fond",
			["Desc"] = "Désactiver le fond sur les barres d'action",
		},

		["Font"] = {
			["Name"] = "Police de caractères",
			["Desc"] = "Définir une police pour les barres d'action",
		},
	},

	["Auras"] = {
		["Enable"] = {
			["Name"] = "Activer auras",
			["Desc"] = "Ehm...",
		},

		["Flash"] = {
			["Name"] = "Surbrillance des Auras",
			["Desc"] = "Surbrillance des auras lorsque leur durée est faible"..PerformanceSlight,
		},

		["ClassicTimer"] = {
			["Name"] = "Decompte classique",
			["Desc"] = "Utiliser le texte de decompte sous auras",
		},

		["HideBuffs"] = {
			["Name"] = "Cacher les Améliorations",
			["Desc"] = "Affichage des Améliorations Désactiver",
		},

		["HideDebuffs"] = {
			["Name"] = "Cacher les Affaiblissements",
			["Desc"] = "Affichage des Affaiblissements Désactiver",
		},

		["Animation"] = {
			["Name"] = "Animation",
			["Desc"] = "Activer les animations des auras"..PerformanceSlight,
		},

		["BuffsPerRow"] = {
			["Name"] = "Améliorations par rangée",
			["Desc"] = "Définissez le nombre d'améliorations a afficher avant de créer une nouvelle ligne",
		},

		["Font"] = {
			["Name"] = "Police de caractère des auras",
			["Desc"] = "Définir une police pour les auras",
		},
	},

	["Bags"] = {
		["Enable"] = {
			["Name"] = "Activer les Sacs",
			["Desc"] = "Ehm...",
		},

		["ButtonSize"] = {
			["Name"] = "Taille des emplacements",
			["Desc"] = "Taille des emplacements dans le sac",
		},

		["Spacing"] = {
			["Name"] = "Espacement",
			["Desc"] = "Réglez l'espacement entre les emplacements de sacs",
		},

		["ItemsPerRow"] = {
			["Name"] = "Objets par ligne",
			["Desc"] = "Définir le nombre d'emplacements sur chaque ligne de sacs",
		},

		["PulseNewItem"] = {
			["Name"] = "Surbrillance des nouveaux objets",
			["Desc"] = "Les nouveaux objets dans vos sacs auront une animation avec surbrillance",
		},

		["Font"] = {
			["Name"] = "Police de caractère des sacs",
			["Desc"] = "Définir une police pour les sacs",
		},
	},

	["Chat"] = {
		["Enable"] = {
			["Name"] = "Activer la fenêtre de discussion",
			["Desc"] = "Ehm...",
		},

		["WhisperSound"] = {
			["Name"] = "Chuchotement sonore",
			["Desc"] = "Jouer un son lors de la réception d'un chuchotement",
		},

		["LinkColor"] = {
			["Name"] = "Couleur lien URL",
			["Desc"] = "Définir une couleur pour afficher les liens URL dans"..RestoreDefault,
		},

		["LinkBrackets"] = {
			["Name"] = "Lien URL entre crochets",
			["Desc"] = "Affichage des liens URL entre crochets",
		},

		["Background"] = {
			["Name"] = "Fond de fenêtre de discussion",
			["Desc"] = "Créer un fond pour les cadres de discussion gauche et droit",
		},

		["ChatFont"] = {
			["Name"] = "Police",
			["Desc"] = "Définir une police pour la fenêtre de discussion",
		},

		["TabFont"] = {
			["Name"] = "Police de l'onglet",
			["Desc"] = "Définir une police pour l'onglet de la fenêtre de discussion",
		},

		["ScrollByX"] = {
			["Name"] = "Défilement de la souris",
			["Desc"] = "Définissez le nombre de lignes que la fenêtre de discussion va sauter lors du défilement",
		},
		
		["ShortChannelName"] = {
			["Name"] = "Nom des canaux réduit",
			["Desc"] = "Réduit les noms des canaux du chat en abbreviation",
		},
	},

	["Cooldowns"] = {
		["Font"] = {
			["Name"] = "Police de caractère",
			["Desc"] = "Définir une police pour les temps de recharge",
		},
	},

	["DataTexts"] = {
		["Battleground"] = {
			["Name"] = "Activer champ de bataille",
			["Desc"] = "Activer textes de données affichant des informations de champ de bataille",
		},

		["LocalTime"] = {
			["Name"] = "Heure locale",
			["Desc"] = "Utilisez heure locale dans le texte de données de temps , plutot que le temps du serveur",
		},

		["Time24HrFormat"] = {
			["Name"] = "Format de l'heure sur 24 heures",
			["Desc"] = "Permettre de définir le texte de données de temps au format 24 heures.",
		},

		["NameColor"] = {
			["Name"] = "Libellé de couleur",
			["Desc"] = "Définir une couleur de l'étiquette d'un texte de données, généralement le nom"..RestoreDefault,
		},

		["ValueColor"] = {
			["Name"] = "Valeur de la couleur",
			["Desc"] = "Définir une couleur pour la valeur d'un texte de données, généralement un nombre"..RestoreDefault,
		},

		["Font"] = {
			["Name"] = "Police de caractère	",
			["Desc"] = "Définir une police pour les données texte",
		},
	},
	
	["Loot"] = {
		["Enable"] = {
			["Name"] = "Active loot",
			["Desc"] = "Active notre fenêtre de loot",
		},
		
		["StandardLoot"] = {
			["Name"] = "Fenêtre de loot Blizzard",
			["Desc"] = "Remplacez notre fenêtre de butin par celle que Blizzard propose.",
		},
	},

	["Merchant"] = {
		["AutoSellGrays"] = {
			["Name"] = "Vendre automatiquement les objets gris",
			["Desc"] = "Lors de la visite d'un vendeur , vendre automatiquement les objets de qualitée grise",
		},

		["AutoRepair"] = {
			["Name"] = "Réparation Automatique",
			["Desc"] = "Lors de la visite d'un marchand, réparer automatiquement votre équipement",
		},

		["UseGuildRepair"] = {
			["Name"] = "Utilisation des réparations de guilde",
			["Desc"] = "En utilisant 'Réparation Automatique', utiliser les fonds de la banque de guilde",
		},
	},

	["Misc"] = {
		["ThreatBarEnable"] = {
			["Name"] = "Activer la barre de menace",
			["Desc"] = "Ehm...",
		},

		["AltPowerBarEnable"] = {
			["Name"] = "Activer la barre Alt-Power",
			["Desc"] = "Ehm...",
		},

		["ExperienceEnable"] = {
			["Name"] = "Activer la barre d'experience",
			["Desc"] = "Activez deux barres d'expérience sur la gauche et la droite de l'écran.",
		},

		["ReputationEnable"] = {
			["Name"] = "Activer la barre de réputation",
			["Desc"] = "Activez deux barres de réputation sur la gauche et la droite de l'écran.",
		},

		["ErrorFilterEnable"] = {
			["Name"] = "Activer le filtrage des erreurs",
			["Desc"] = "Filtres des messages UIErrorsFrame.",
		},

		["AutoInviteEnable"] = {
			["Name"] = "Activer les invitations automatiques",
			["Desc"] = "Acceptez automatiquement les invitations de groupe d'amis et de membres de guilde.",
		},
		
		["TalkingHeadEnable"] = {
			["Name"] = "Activer le cadre des discussions PNJ",
			["Desc"] = "Ehm...",
		},
	},

	["NamePlates"] = {
		["Enable"] = {
			["Name"] = "Activer les barres d'unités",
			["Desc"] = "Ehm.."..PerformanceSlight,
		},

		["Width"] = {
			["Name"] = "Définir la largeur",
			["Desc"] = "Définir la largeur des barres d'unités",
		},

		["Height"] = {
			["Name"] = "Définir la hauteur",
			["Desc"] = "Définir la hauteur des barres d'unités",
		},

		["CastHeight"] = {
			["Name"] = "Hauteur de la barre de incantation",
			["Desc"] = "Définir la hauteur de la barre de incantation des barres d'unités",
		},

		["Font"] = {
			["Name"] = "Police de caractère",
			["Desc"] = "Définir la police de caractère des barres d'unités",
		},

		["OnlySelfDebuffs"] = {
			["Name"] = "Afficher seulement mes affaiblissements",
			["Desc"] = "Afficher seulement mes affaiblissements sur le cadre cible",
		},
	},

	["Party"] = {
		["Enable"] = {
			["Name"] = "Activer les cadres de groupe",
			["Desc"] = "Ehm...",
		},

		["HealBar"] = {
			["Name"] = "HealComm",
			["Desc"] = "Afficher une barre indiquant les soins et absorbe entrants",
		},

		["ShowPlayer"] = {
			["Name"] = "Afficher jouer",
			["Desc"] = "Afficher soi-meme en groupe",
		},

		["ShowHealthText"] = {
			["Name"] = "Texte de santé",
			["Desc"] = "Indiquez le montant de la santé perdue de l'unité.",
		},

		["Font"] = {
			["Name"] = "Police",
			["Desc"] = "Définir la police de caractère des noms des cadres de groupe",
		},

		["HealthFont"] = {
			["Name"] = "Police du texte santé",
			["Desc"] = "Définir la police de caractère de la santé des cadres de groupe",
		},

		["RangeAlpha"] = {
			["Name"] = "Opacité hors-d'atteinte",
			["Desc"] = "Défini l'opacité des unitées qui sont hors d'atteinte",
		},
	},

	["Raid"] = {
		["Enable"] = {
			["Name"] = "Activer les cadres de raid",
			["Desc"] = "Ehm...",
		},

		["ShowPets"] = {
			["Name"] = "Affichage des familiers",
			["Desc"] = "Ehm...",
		},

		["MaxUnitPerColumn"] = {
			["Name"] = "Nombre de joueurs par colonne",
			["Desc"] = "Changer le nombre maximum de membres du raid par colonne",
		},

		["HealBar"] = {
			["Name"] = "HealComm",
			["Desc"] = "Afficher une barre indiquant les soins et absorbe entrants",
		},

		["AuraWatch"] = {
			["Name"] = "Affichage des auras",
			["Desc"] = "Affiche un decompte pour les améliorations spécifiques aux classes dans les coins des cadres de raid",
		},

		["AuraWatchTimers"] = {
			["Name"] = "Affichage de decompte pour les auras",
			["Desc"] = "Affiche un decompte (spiral) pour les auras",
		},

		["DebuffWatch"] = {
			["Name"] = "Affichage des affaiblissement",
			["Desc"] = "Afficher une grosse icone sur les cadres de raid quand un joueur a un affaiblissement important",
		},

		["RangeAlpha"] = {
			["Name"] = "Opacité hors-d'atteinte",
			["Desc"] = "Défini l'opacité des unitées qui sont hors d'atteinte",
		},

		["ShowRessurection"] = {
			["Name"] = "Afficher l'icone de ressurection",
			["Desc"] = "Afficher les ressurections entrantes sur les joueurs",
		},

		["ShowHealthText"] = {
			["Name"] = "Texte de santé",
			["Desc"] = "Indiquez le montant de la santé perdue de l'unité.",
		},

		["VerticalHealth"] = {
			["Name"] = "Santé verticale",
			["Desc"] = "Afficher la santé perdue verticalement",
		},

		["Font"] = {
			["Name"] = "Police de caractère des noms",
			["Desc"] = "Définir la police de caractère des noms des cadre de raid",
		},

		["HealthFont"] = {
			["Name"] = "Police de caractère du texte santé",
			["Desc"] = "Définir la police de caractère de la santé des cadres de raid",
		},

		["GroupBy"] = {
			["Name"] = "Groupé par",
			["Desc"] = "Définir le mode de tri des groupes de raid",
		},
	},

	["Tooltips"] = {
		["Enable"] = {
			["Name"] = "Activer infobulles",
			["Desc"] = "Ehm...",
		},

		["MouseOver"] = {
			["Name"] = "Infobulle sur curseur",
			["Desc"] = "Activer l'infobulle sur le curseur de la souris",
		},

		["HideOnUnitFrames"] = {
			["Name"] = "cacher sur cadre d'unités",
			["Desc"] = "Ne pas afficher les info-bulles sur les cadres unités",
		},

		["UnitHealthText"] = {
			["Name"] = "Affichage texte santé",
			["Desc"] = "Afficher le texte de la santé sur la barre de santé de l'info-bulle",
		},

		["ShowSpec"] = {
			["Name"] = "Spécialisation et iLevel",
			["Desc"] = "Affichage de la spécialisation et du iLevel dans l'info-bulle lorsque vous appuyez sur ALT",
		},

		["HealthFont"] = {
			["Name"] = "Police de la barre de santé",
			["Desc"] = "Définir une police pour etre utilisé sur la barre de santé des unités en-dessous des infobulles",
		},
	},
	
	["Textures"] = {
		["QuestProgressTexture"] = {
			["Name"] = "Quête [Progression]",
		},

		["TTHealthTexture"] = {
			["Name"] = "Tooltip [Vie]",
		},

		["UFPowerTexture"] = {
			["Name"] = "Barre d'unité [Puissance]",
		},

		["UFHealthTexture"] = {
			["Name"] = "Barre d'unité [Vie]",
		},

		["UFCastTexture"] = {
			["Name"] = "Barre d'unité [Incantation]",
		},

		["UFPartyPowerTexture"] = {
			["Name"] = "Barre d'unité [Party Puissance]",
		},

		["UFPartyHealthTexture"] = {
			["Name"] = "Barre d'unité [Party Vie]",
		},

		["UFRaidPowerTexture"] = {
			["Name"] = "Barre d'unité [Raid Puissance]",
		},

		["UFRaidHealthTexture"] = {
			["Name"] = "Barre d'unité [Raid Vie]",
		},

		["NPHealthTexture"] = {
			["Name"] = "Nameplates [Vie]",
		},

		["NPPowerTexture"] = {
			["Name"] = "Nameplates [Puissance]",
		},

		["NPCastTexture"] = {
			["Name"] = "Nameplates [Incantation]",
		},
	},

	["UnitFrames"] = {
		["Enable"] = {
			["Name"] = "Activé cadre des unités",
			["Desc"] = "Ehm...",
		},

		["TargetEnemyHostileColor"] = {
			["Name"] = "Couleur hostile de la cible ennemie",
			["Desc"] = "La barre de santé de la cible ennemie sera colorée par l'hostilité plutôt que par la couleur de la classe",
		},

		["Portrait"] = {
			["Name"] = "Activer Joueur et portrait de la cible",
			["Desc"] = "Activer Joueur et portrait de la cible",
		},

		["CastBar"] = {
			["Name"] = "Barre d'incantation",
			["Desc"] = "Activer les barres d'incantation pour les unitées",
		},

		["UnlinkCastBar"] = {
			["Name"] = "Délier Barre d'incantation",
			["Desc"] = "Deplacer librement les barres d'incantation joueur et cible en dehors du cadre unité",
		},

		["CastBarIcon"] = {
			["Name"] = "Icone de barre d'incantation",
			["Desc"] = "Affiche une icone barre d'incantation",
		},

		["CastBarLatency"] = {
			["Name"] = "Latence de la barre d'incantation",
			["Desc"] = "Affichez votre temps de latence sur la barre",
		},

		["Smooth"] = {
			["Name"] = "Barres lisses",
			["Desc"] = "Lisser la mise a jour des barres de santé"..PerformanceSlight,
		},

		["CombatLog"] = {
			["Name"] = "Commentaires de combat",
			["Desc"] = "Afficher les soins entrants et les dommages sur le cadre de l'unité du joueur",
		},

		["WeakBar"] = {
			["Name"] = "Barre d'ame affaiblie Pretre",
			["Desc"] = "Afficher une barre pour montrer l'affaiblisement ame affaiblie",
		},

		["HealBar"] = {
			["Name"] = "HealComm",
			["Desc"] = "Afficher une barre indiquant les soins et absorbe entrants",
		},

		["TotemBar"] = {
			["Name"] = "Berre de Totem",
			["Desc"] = "Créer une barre de totem de style Tukui",
		},

		["ComboBar"] = {
			["Name"] = "Combo Points",
			["Desc"] = "Enable the combo points bar",
		},

		["SerendipityBar"] = {
			["Name"] = "Barre 'heureux hasard' de Pretre",
			["Desc"] = "Afficher une barre indiquant le nombre de cumul 'heureux hasard' pour les Pretres",
		},

		["OnlySelfDebuffs"] = {
			["Name"] = "Afficher seulement mes affaiblissements",
			["Desc"] = "Afficher seulement mes affaiblissements sur le cadre cible",
		},

		["OnlySelfBuffs"] = {
			["Name"] = "Afficher mes buffs uniquement",
			["Desc"] = "Afficher uniquement nos buffs sur le cadre cible",
		},

		["Threat"] = {
			["Name"] = "Activer l'affichage de la menace",
			["Desc"] = "La barre de vie va devenir rouge si le joueur a l'aggro",
		},

		["Arena"] = {
			["Name"] = "Cadres d'arène",
			["Desc"] = "Afficher les adversaires de l'arène à l'intérieur d'un champ de bataille ou d'une arène",
		},

		["Boss"] = {
			["Name"] = "Cadres de monstre",
			["Desc"] = "Afficher les cadres de monstre en faisant pve",
		},

		["TargetAuras"] = {
			["Name"] = "Auras de la cible",
			["Desc"] = "Afficher les buffs et les debuffs sur la cible",
		},

		["FocusAuras"] = {
			["Name"] = "Auras du focus",
			["Desc"] = "Afficher les buffs et les debuffs du focus",
		},

		["FocusTargetAuras"] = {
			["Name"] = "Auras de la cible du focus",
			["Desc"] = "Afficher les buffs et les debuffs sur la cible du focus",
		},

		["ArenaAuras"] = {
			["Name"] = "Auras sur les cadres d'arène",
			["Desc"] = "Afficher les débuffs sur les cadres d'arène",
		},

		["BossAuras"] = {
			["Name"] = "Auras sur les cadres de monstre",
			["Desc"] = "Afficher les débuffs sur les cadres de boss",
		},

		["AltPowerText"] = {
			["Name"] = "Affichage du texte sur la barre de puissance alternative",
			["Desc"] = "Ehm...",
		},

		["Font"] = {
			["Name"] = "Police de caractère",
			["Desc"] = "Défini une police de caractère pour les cadres unités",
		},
	},
}
