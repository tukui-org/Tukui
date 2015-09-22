local T, C, L = select(2, ...):unpack()

if (GetLocale() ~= "frFR") then
	return
end

------------------------------------------------
L.ChatFrames = {} -- Data Text Locales
------------------------------------------------

L.ChatFrames.LocalDefense = "DéfenseLocale"
L.ChatFrames.GuildRecruitment = "RecrutementDeGuilde"
L.ChatFrames.LookingForGroup = "RechercheDeGroupe"

------------------------------------------------
L.DataText = {} -- Data Text Locales
------------------------------------------------

L.DataText.AvoidanceBreakdown = "Evitement détaillé"
L.DataText.Level = "Niveau"
L.DataText.Boss = "Boss"
L.DataText.Miss = "Raté"
L.DataText.Dodge = "Esquive"
L.DataText.Block = "Blocage"
L.DataText.Parry = "Parade"
L.DataText.Avoidance = "Evitement"
L.DataText.AvoidanceShort = "Evi: "
L.DataText.Memory = "Mémoire"
L.DataText.Hit = "Toucher"
L.DataText.Power = "Puissance"
L.DataText.Mastery = "Maîtrise"
L.DataText.Crit = "Critique"
L.DataText.Regen = "Régéneration"
L.DataText.Versatility = "Versatilité"
L.DataText.Leech = "Leech"
L.DataText.Multistrike = "Frappe multiple"
L.DataText.Session = "Session: "
L.DataText.Earned = "Earned:"
L.DataText.Spent = "Spent:"
L.DataText.Deficit = "Déficit:"
L.DataText.Profit = "Profit:"
L.DataText.Character = "Personnage: "
L.DataText.Server = "Serveur: "
L.DataText.Gold = "Or"
L.DataText.TotalGold = "Total: "
L.DataText.GoldShort = "|cffffd700g|r"
L.DataText.SilverShort = "|cffc7c7cfs|r"
L.DataText.CopperShort = "|cffeda55fc|r"
L.DataText.Talents = "Talents"
L.DataText.NoTalent = "Aucun Talents"
L.DataText.Download = "Téléchargement: "
L.DataText.Bandwidth = "Bande Passante: "
L.DataText.Guild = "Guilde"
L.DataText.NoGuild = "Aucune Guilde"
L.DataText.Bags = "Sacs"
L.DataText.BagSlots = "Emplacements de sacs"
L.DataText.Friends = "Amis"
L.DataText.Online = "En Ligne: "
L.DataText.Armor = "Armure"
L.DataText.Durability = "Durabilité"
L.DataText.TimeTo = "Durée de"
L.DataText.FriendsList = "Liste d'Amis:"
L.DataText.Spell = "PS"
L.DataText.AttackPower = "PA"
L.DataText.Haste = "Hâte"
L.DataText.DPS = "DPS"
L.DataText.HPS = "HPS"
L.DataText.Session = "Session: "
L.DataText.Character = "Personnage: "
L.DataText.Server = "Serveur: "
L.DataText.Total = "Total: "
L.DataText.SavedRaid = "Saved Raid(s)"
L.DataText.Currency = "Monnaie"
L.DataText.FPS = " FPS & "
L.DataText.MS = " MS"
L.DataText.FPSAndMS = "FPS & MS"
L.DataText.Critical = " Critique"
L.DataText.Heal = " Soin"
L.DataText.Time = "Temps"
L.DataText.ServerTime = "Heure Serveur: "
L.DataText.LocalTime = "Heure Locale: "
L.DataText.Mitigation = "Mitigation Par Niveau: "
L.DataText.Healing = "Soins: "
L.DataText.Damage = "Dégats: "
L.DataText.Honor = "Honneur: "
L.DataText.KillingBlow = "Coups fatals: "
L.DataText.StatsFor = "Stats pour "
L.DataText.HonorableKill = "Victoires Honorables:"
L.DataText.Death = "Morts:"
L.DataText.HonorGained = "Honneur gagné:"
L.DataText.DamageDone = "Dégats Effectués:"
L.DataText.HealingDone = "Soins Effectués:"
L.DataText.BaseAssault = "Bases Assiégés:"
L.DataText.BaseDefend = "Bases Défendues:"
L.DataText.TowerAssault = "Tours Assiégés:"
L.DataText.TowerDefend = "Tours Défendues:"
L.DataText.FlagCapture = "Drapeaux Capturés:"
L.DataText.FlagReturn = "Drapeaux Retournés:"
L.DataText.GraveyardAssault = "Cimetières Assiégés:"
L.DataText.GraveyardDefend = "Cimetières Défendus:"
L.DataText.DemolisherDestroy = "Démolisseurs Détruits:"
L.DataText.GateDestroy = "Portes Détruites:"
L.DataText.TotalMemory = "Utilisation totale de la mémoire:"
L.DataText.ControlBy = "Contrôlé par:"
L.DataText.CallToArms = "Appel aux Armes" 
L.DataText.ArmError = "Impossible d'obtenir des informations sur l'appel aux armes."
L.DataText.NoDungeonArm = "Aucun donjons n'offre actuellement un appel aux armes."
L.DataText.CartControl = "Chariots contrôlés:"
L.DataText.VictoryPts = "Points de Victoire:"
L.DataText.OrbPossession = "Orbes Possédés:"
L.DataText.Slots = {
	[1] = {1, "Tête", 1000},
	[2] = {3, "Epaules", 1000},
	[3] = {5, "Torse", 1000},
	[4] = {6, "Taille", 1000},
	[5] = {9, "Poignets", 1000},
	[6] = {10, "Mains", 1000},
	[7] = {7, "Jambes", 1000},
	[8] = {8, "Pieds", 1000},
	[9] = {16, "À une main", 1000},
	[10] = {17, "Tenu en main gauche", 1000},
	[11] = {18, "À distance", 1000}
}

------------------------------------------------
L.Tooltips = {} -- Tooltips Locales
------------------------------------------------

L.Tooltips.MoveAnchor = "Déplacer les Infobulles"

------------------------------------------------
L.UnitFrames = {} -- Unit Frames Locales
------------------------------------------------

L.UnitFrames.Ghost = "Fantôme"
L.UnitFrames.Wrath = "Colère"
L.UnitFrames.Starfire = "Feu Stellaire"

------------------------------------------------
L.ActionBars = {} -- Action Bars Locales
------------------------------------------------

L.ActionBars.ArrowLeft = "◄"
L.ActionBars.ArrowRight = "►"
L.ActionBars.ArrowUp = "▲ ▲ ▲ ▲ ▲"
L.ActionBars.ArrowDown = "▼ ▼ ▼ ▼ ▼"
L.ActionBars.ExtraButton = "Bouton supplémentaire"
L.ActionBars.CenterBar = " Barre en bas au centre"
L.ActionBars.ActionButton1 = "Barre d'action principale: Barre du Bas au Centre Bouton d'action 1"
L.ActionBars.ActionButton2 = "Barre d'action principale: Barre du Bas au Centre Bouton d'action 2"
L.ActionBars.ActionButton3 = "Barre d'action principale: Barre du Bas au Centre Bouton d'action 3"
L.ActionBars.ActionButton4 = "Barre d'action principale: Barre du Bas au Centre Bouton d'action 4"
L.ActionBars.ActionButton5 = "Barre d'action principale: Barre du Bas au Centre Bouton d'action 5"
L.ActionBars.ActionButton6 = "Barre d'action principale: Barre du Bas au Centre Bouton d'action 6"
L.ActionBars.ActionButton7 = "Barre d'action principale: Barre du Bas au Centre Bouton d'action 7"
L.ActionBars.ActionButton8 = "Barre d'action principale: Barre du Bas au Centre Bouton d'action 8"
L.ActionBars.ActionButton9 = "Barre d'action principale: Barre du Bas au Centre Bouton d'action 9"
L.ActionBars.ActionButton10 = "Barre d'action principale: Barre du Bas au Centre Bouton d'action 10"
L.ActionBars.ActionButton11 = "Barre d'action principale: Barre du Bas au Centre Bouton d'action 11"
L.ActionBars.ActionButton12 = "Barre d'action principale: Barre du Bas au Centre Bouton d'action 12"
L.ActionBars.MultiActionBar1Button1 = "Bas Gauche: Barre du Bas Bouton d'action 6"
L.ActionBars.MultiActionBar1Button2 = "Bas Gauche: Barre du Bas Bouton d'action 5"
L.ActionBars.MultiActionBar1Button3 = "Bas Gauche: Barre du Bas Bouton d'action 4"
L.ActionBars.MultiActionBar1Button4 = "Bas Gauche: Barre du Bas Bouton d'action 3"
L.ActionBars.MultiActionBar1Button5 = "Bas Gauche: Barre du Bas Bouton d'action 2"
L.ActionBars.MultiActionBar1Button6 = "Bas Gauche: Barre du Bas Bouton d'action 1"
L.ActionBars.MultiActionBar1Button7 = "Bas Gauche: Barre du Haut Bouton d'action 6"
L.ActionBars.MultiActionBar1Button8 = "Bas Gauche: Barre du Haut Bouton d'action 5"
L.ActionBars.MultiActionBar1Button9 = "Bas Gauche: Barre du Haut Bouton d'action 4"
L.ActionBars.MultiActionBar1Button10 = "Bas Gauche: Barre du Haut Bouton d'action 3"
L.ActionBars.MultiActionBar1Button11 = "Bas Gauche: Barre du Haut Bouton d'action 2"
L.ActionBars.MultiActionBar1Button12 = "Bas Gauche: Barre du Haut Bouton d'action 1"
L.ActionBars.MultiActionBar2Button1 = "Bas Droite: Barre du Bas Bouton d'action 1"
L.ActionBars.MultiActionBar2Button2 = "Bas Droite: Barre du Bas Bouton d'action 2"
L.ActionBars.MultiActionBar2Button3 = "Bas Droite: Barre du Bas Bouton d'action 3"
L.ActionBars.MultiActionBar2Button4 = "Bas Droite: Barre du Bas Bouton d'action 4"
L.ActionBars.MultiActionBar2Button5 = "Bas Droite: Barre du Bas Bouton d'action 5"
L.ActionBars.MultiActionBar2Button6 = "Bas Droite: Barre du Bas Bouton d'action 6"
L.ActionBars.MultiActionBar2Button7 = "Bas Droite: Barre du Haut Bouton d'action 1"
L.ActionBars.MultiActionBar2Button8 = "Bas Droite: Barre du Haut Bouton d'action 2"
L.ActionBars.MultiActionBar2Button9 = "Bas Droite: Barre du Haut Bouton d'action 3"
L.ActionBars.MultiActionBar2Button10 = "Bas Droite: Barre du Haut Bouton d'action 4"
L.ActionBars.MultiActionBar2Button11 = "Bas Droite: Barre du Haut Bouton d'action 5"
L.ActionBars.MultiActionBar2Button12 = "Bas Droite: Barre du Haut Bouton d'action 6"
L.ActionBars.MultiActionBar4Button1 = "Bas Centre: Barre du Haut Bouton d'action 1"
L.ActionBars.MultiActionBar4Button2 = "Bas Centre: Barre du Haut Bouton d'action 2"
L.ActionBars.MultiActionBar4Button3 = "Bas Centre: Barre du Haut Bouton d'action 3"
L.ActionBars.MultiActionBar4Button4 = "Bas Centre: Barre du Haut Bouton d'action 4"
L.ActionBars.MultiActionBar4Button5 = "Bas Centre: Barre du Haut Bouton d'action 5"
L.ActionBars.MultiActionBar4Button6 = "Bas Centre: Barre du Haut Bouton d'action 6"
L.ActionBars.MultiActionBar4Button7 = "Bas Centre: Barre du Haut Bouton d'action 7"
L.ActionBars.MultiActionBar4Button8 = "Bas Centre: Barre du Haut Bouton d'action 8"
L.ActionBars.MultiActionBar4Button9 = "Bas Centre: Barre du Haut Bouton d'action 9"
L.ActionBars.MultiActionBar4Button10 = "Bas Centre: Barre du Haut Bouton d'action 10"
L.ActionBars.MultiActionBar4Button11 = "Bas Centre: Barre du Haut Bouton d'action 11"
L.ActionBars.MultiActionBar4Button12 = "Bas Centre: Barre du Haut Bouton d'action 12"
L.ActionBars.MoveStanceBar = "Déplacer la barre de postures"

------------------------------------------------
L.Minimap = {} -- Minimap Locales
------------------------------------------------

L.Minimap.MoveMinimap = "Déplacer la Minicarte"

------------------------------------------------
L.Miscellaneous = {} -- Miscellaneous
------------------------------------------------

L.Miscellaneous.Repair = "Attention ! Vous devez réparer vôtre équipement dès que possible!"
L.Miscellaneous.InQueue = "I'm currently in Queue!"

------------------------------------------------
L.Auras = {} -- Aura Locales
------------------------------------------------

L.Auras.MoveBuffs = "Déplacer les Améliorations"
L.Auras.MoveDebuffs = "Déplacer les Affaiblissements"

------------------------------------------------
L.Install = {} -- Installation of Tukui
------------------------------------------------

L.Install.Tutorial = "Tutoriel"
L.Install.Install = "Installation"
L.Install.InstallStep0 = "Merci d'avoir choisi Tukui !|n|nVous serez guidé à travers le processus d'installation en quelques étapes simples . A chaque étape , vous pouvez décider si vous souhaitez ou non appliquer ou ignorer les paramètres présentés."
L.Install.InstallStep1 = "La première étape applique les paramètres essentiels . Ceci est |cffff0000recommendé|r pour tout utilisateur , à moins que vous souhaitiez appliquer seulement une partie spécifique des paramètres.|n|nCliquer 'Appliquer' pour appliquer les paramètres et 'Suivant' pour continuer le processus d'installation . Si vous souhaitez sauter cette étape , appuyez simplement sur 'Suivant'."
L.Install.InstallStep2 = "La deuxième étape concerne la configuration de la fenêtre de discussion . Si vous êtes un nouvel utilisateur , cette étape est recommandé . Si vous êtes un utilisateur existant , vous pouvez sauter cette étape .|n|nCliquer 'Appliquer' pour appliquer les paramètres et 'Suivant' pour continuer le processus d'installation . Si vous souhaitez sauter cette étape , appuyez simplement sur 'Suivant'."
L.Install.InstallStep3 = "L'installation est terminée . Veuillez cliquer sur le bouton 'Terminer' pour recharger l'interface utilisateur. Profitez de Tukui ! Rendez-nous visite sur www.tukui.org !"

------------------------------------------------
L.Help = {} -- /tukui help
------------------------------------------------

L.Help.Title = "Commandes Tukui:"
L.Help.Datatexts = "'|cff00ff00dt|r' or '|cff00ff00datatext|r' : Activer ou désactiver la configuration DataText."
L.Help.Install = "'|cff00ff00install|r' or '|cff00ff00reset|r' : Installer ou réinitialiser les paramètres par défaut Tukui."
L.Help.Config = "'|cff00ff00c|r' or '|cff00ff00config|r' : Afficher la fenêtre de configuration en jeu."
L.Help.Move = "'|cff00ff00move|r' or '|cff00ff00moveui|r' : Déplacer les cadres."
L.Help.Test = "'|cff00ff00test|r' or '|cff00ff00testui|r' : Tester les cadres d'unitées."
L.Help.Profile = "'|cff00ff00profile|r' or '|cff00ff00p|r' : Use Tukui settings (existing profile) from another character."

------------------------------------------------
L.Merchant = {} -- Merchant
------------------------------------------------

L.Merchant.NotEnoughMoney = "Vous n'avez pas assez d'argent pour réparer!"
L.Merchant.RepairCost = "Votre équipement a été réparé pour"
L.Merchant.SoldTrash = "Vos objets inutiles ont été vendu et vous avez gagné"

------------------------------------------------
L.Version = {} -- Version Check
------------------------------------------------

L.Version.Outdated = "Vôtre version de Tukui n'est pas à jour . Vous pouvez télécharger la dernière version depuis www.tukui.org"

------------------------------------------------
L.Others = {} -- Miscellaneous
------------------------------------------------

L.Others.GlobalSettings = "Use Global Settings"
L.Others.CharSettings = "Use Character Settings"
L.Others.ProfileNotFound = "Profile not found"
L.Others.ProfileSelection = "Please type a profile to use (example: /tukui profile Illidan-Tukz)"
L.Others.ConfigNotFound = "Config not loaded."
