if GetLocale() == "frFR" then
	-- update needed msg
	TukuiL.option_update = "Vous devez mettre à jour votre interface Tukui pour bénéficier des derniers changements, visitez le site www.tukui.org"

	-- general
	TukuiL.option_general = "Général"
	TukuiL.option_general_uiscale = "Echelle auto de l'interface"
	TukuiL.option_general_override = "Utiliser l'interface Haute Résolution sur une Basse Résolution"
	TukuiL.option_general_multisample = "Protection Multisample (bordure de 1px clean)"
	TukuiL.option_general_customuiscale = "Echelle de l'interface (si échelle auto désactivée)"
	TukuiL.option_general_backdropcolor = "Définis la couleur de fond par défaut des panneaux"
	TukuiL.option_general_bordercolor = "Définis la couleur des Bordures par défaut des panneaux"

	-- nameplate
	TukuiL.option_nameplates = "Barres d'info"
	TukuiL.option_nameplates_enable = "Activer les barres d'info"
	TukuiL.option_nameplates_enhancethreat = "Activer la gestion d'aggro, change automatiquement selon votre rôle:"
	TukuiL.option_nameplates_showhealth = "Montrer la vie sur les barres d'info des ennemis"
 	TukuiL.option_nameplates_combat = "Afficher les barres d'infos des ennemis seulement en combat"
 	TukuiL.option_nameplates_goodcolor = "Bonne couleur de menace, dépend de votre rôle (tank ou dps / heal)"
	TukuiL.option_nameplates_badcolor = "Mauvaise couleur de menace, dépend de votre rôle (tank ou dps / heal)"
	TukuiL.option_nameplates_transitioncolor = "Perte / Gain de couleur de menace"
 
	-- merchant
	TukuiL.option_merchant = "Commerce"
	TukuiL.option_merchant_autosell = "Vente auto des objets gris"
	TukuiL.option_merchant_autorepair = "Réparation auto de l'équipement"
	TukuiL.option_merchant_sellmisc = "Vente de certains objets définis (non-gris, inutile) automatiquement."
 
	-- bags
	TukuiL.option_bags = "Sacs"
	TukuiL.option_bags_enable = "Activer les sacs Tukui"
 
	-- datatext
	TukuiL.option_datatext = "Infos"
	TukuiL.option_datatext_24h = "Activer mode 24h"
	TukuiL.option_datatext_localtime = "Utiliser l'heure locale au lieu de l'heure serveur"
	TukuiL.option_datatext_bg = "Activer les stats en Champ de Bataille"
	TukuiL.option_datatext_hps = "Position Soin par seconde (0 pour désactiver)"
	TukuiL.option_datatext_guild = "Position Guild (0 pour désactiver)e"
	TukuiL.option_datatext_arp = "Position Pénétration d'Armure (0 pour désactiver)"
	TukuiL.option_datatext_mem = "Position Mémoire (0 pour désactiver)"
	TukuiL.option_datatext_bags = "Position Sacs (0 pour désactiver)"
	TukuiL.option_datatext_fontsize = "Taille du texte (0 pour désactiver)"
	TukuiL.option_datatext_fps_ms = "Position Latence et FPS (0 pour désactiver)"
	TukuiL.option_datatext_armor = "Position Armure (0 pour désactiver)"
	TukuiL.option_datatext_avd = "Position Esquive (0 pour désactiver)"
	TukuiL.option_datatext_power = "Position Puissance Attaque / Sorts (0 pour désactiver)"
	TukuiL.option_datatext_haste = "Position Hâte (0 pour désactiver)"
	TukuiL.option_datatext_friend = "Position Amis (0 pour désactiver)"
	TukuiL.option_datatext_time = "Position Heure (0 pour désactiver)"
	TukuiL.option_datatext_gold = "Position Pièces d'Or (0 pour désactiver)"
	TukuiL.option_datatext_dps = "Position Dégâts par seconde (0 pour désactiver)"
	TukuiL.option_datatext_crit = "Position Critique (0 pour désactiver)"
	TukuiL.option_datatext_dur = "Position Durabilité (0 pour désactiver)"
	TukuiL.option_datatext_currency = "Position Monnaie (0 pour désactiver)"
	TukuiL.option_datatext_micromenu = "Position Micro Menu (0 pour désactiver)"
	TukuiL.option_datatext_hit = "Position Toucher (0 pour désactiver)"
	TukuiL.option_datatext_mastery = "Position Maîtrise (0 pour désactiver)"
 
	-- unit frames
	TukuiL.option_unitframes_unitframes = "Unit Frames"
	TukuiL.option_unitframes_combatfeedback = "Feedback des dégâts/soins sur joueur et cible"
	TukuiL.option_unitframes_runebar = "Afficher la barre de rune pour DK"
	TukuiL.option_unitframes_auratimer = "Afficher le timer sur les buffs"
	TukuiL.option_unitframes_totembar = "Afficher la barre de totem pour Chaman"
	TukuiL.option_unitframes_totalhpmp = "Afficher le total vie/pouvoir (mana/énergie/rage)"
	TukuiL.option_unitframes_playerparty = "Se voir dans le groupe"
	TukuiL.option_unitframes_aurawatch = "Afficher les buffs PVE en raid (Grid seulement)"
	TukuiL.option_unitframes_castbar = "Afficher la barre de cast"
	TukuiL.option_unitframes_targetaura = "Afficher les buffs des cibles"
	TukuiL.option_unitframes_saveperchar = "Sauvegarder la position des cadres par personnage"
	TukuiL.option_unitframes_playeraggro = "Afficher l'aggro sur soi"
	TukuiL.option_unitframes_smooth = "Activer les animations sur les barres de vie/mana/etc"
	TukuiL.option_unitframes_portrait = "Activer les portraits sur joueur et cible"
	TukuiL.option_unitframes_enable = "Activer Tukui Unit Frames"
	TukuiL.option_unitframes_enemypower = "Afficher le pouvoir (mana/énergie/rage) seulement sur l'ennemi"
	TukuiL.option_unitframes_gridonly = "Afficher que le mode Grid sur l'interface Healer"
	TukuiL.option_unitframes_healcomm = "Activer healcomm"
	TukuiL.option_unitframes_focusdebuff = "Afficher les debuffs du Focus"
	TukuiL.option_unitframes_raidaggro = "Afficher l'aggro dans le groupe/raid"
	TukuiL.option_unitframes_boss = "Activer les Boss Unit Frames"
	TukuiL.option_unitframes_enemyhostilitycolor = "Colorer la barre de vie des ennemis en fonction de l'hostilité"
	TukuiL.option_unitframes_hpvertical = "Voir la barre de vie verticalement dans l'interface Grid"
	TukuiL.option_unitframes_symbol = "Voir les symboles dans le groupe/raid"
	TukuiL.option_unitframes_threatbar = "Afficher la barre de menace"
	TukuiL.option_unitframes_enablerange = "Afficher la transparence pour la portée des membres du groupe/raid"
	TukuiL.option_unitframes_focus = "Afficher la cible du Focus"
	TukuiL.option_unitframes_latency = "Voir la latence sur la barre de cast"
	TukuiL.option_unitframes_icon = "Voir l'icone de sort sur la barre de cast"
	TukuiL.option_unitframes_playeraura = "Activer un mode de buff alternatif pour le joueur"
	TukuiL.option_unitframes_aurascale = "Taille du texte des buffs"
	TukuiL.option_unitframes_gridscale = "Taille de Grid"
	TukuiL.option_unitframes_manahigh = "Seuil Haut de la mana (Chasseurs)"
	TukuiL.option_unitframes_manalow = "Seuil Bas de la mana (Toutes classes à mana)"
	TukuiL.option_unitframes_range = "Transparence sur unité de Groupe/Raid hors de portée"
	TukuiL.option_unitframes_maintank = "Afficher Main Tank"
	TukuiL.option_unitframes_mainassist = "Afficher Main Heal"
	TukuiL.option_unitframes_unicolor = "Afficher le thème avec une seule couleur (barre de vie grise)"
	TukuiL.option_unitframes_totdebuffs = "Afficher les debuffs de la cible de la cible (interface Haute Resolution)"
	TukuiL.option_unitframes_classbar = "Afficher la barre de classe"
	TukuiL.option_unitframes_weakenedsoulbar = "Afficher la barre de debuff âme affaiblie (pour prêtres)"
	TukuiL.option_unitframes_onlyselfdebuffs = "Afficher seulement vos débuffs sur la cible"
	TukuiL.option_unitframes_focus = "Afficher la cible du Focus"
	TukuiL.option_unitframes_bordercolor = "Définis la couleur des Bordures par défaut des Images d'Unités"
 
	-- loot
	TukuiL.option_loot = "Butin"
	TukuiL.option_loot_enableloot = "Activer fenêtre de butin"
	TukuiL.option_loot_autogreed = "Auto-cupidité pour les objets verts au level max"
	TukuiL.option_loot_enableroll = "Activer la fenêtre de choix du butin (cupitidé/besoin/passer)"
 
	-- map
	TukuiL.option_map = "Carte"
	TukuiL.option_map_enable = "Activer la carte Tukui"
 
	-- invite
	TukuiL.option_invite = "Invite"
	TukuiL.option_invite_autoinvite = "Activer l'Auto-Invite (Amis et Guilde)"
 
	-- tooltip
	TukuiL.option_tooltip = "Tooltip"
	TukuiL.option_tooltip_enable = "Activer les Tooltip"
	TukuiL.option_tooltip_hidecombat = "Cacher les tooltip en combat"
	TukuiL.option_tooltip_hidebutton = "Cacher les tooltip sur les barres d'actions"
	TukuiL.option_tooltip_hideuf = "Cacher les tooltip sur les Unit Frames"
	TukuiL.option_tooltip_cursor = "Afficher les tooltip sous le curseur"
 
	-- others
	TukuiL.option_others = "Autres"
	TukuiL.option_others_bg = "Auto-Libération en Champ de Bataille"
 
	-- reminder
	TukuiL.option_reminder = "Alerte d'Aura"
	TukuiL.option_reminder_enable = "Activer l'alerte d'aura du joueur"
	TukuiL.option_reminder_sound = "Activer une alerte sonore pour l'alerte d'aura"
 
	-- error
	TukuiL.option_error = "Message d'Erreur"
	TukuiL.option_error_hide = "Cacher le spam d'erreur au milieu de l'écran"
 
	-- action bar
	TukuiL.option_actionbar = "Barres d'Actions"
	TukuiL.option_actionbar_hidess = "Cacher barre de Changeforme/Totem"
	TukuiL.option_actionbar_showgrid = "Toujours montrer les grilles sur les barres d'actions"
	TukuiL.option_actionbar_enable = "Activer les barres d'actions Tukui"
	TukuiL.option_actionbar_rb = "Barres d'actions de droite au passage de la souris"
	TukuiL.option_actionbar_hk = "Voir les raccourcis sur les boutons"
	TukuiL.option_actionbar_ssmo = "Barre de Changeforme/Totem au passage de la souris"
	TukuiL.option_actionbar_rbn = "Nombre de barres d'actions en bas (1 ou 2)"
	TukuiL.option_actionbar_rn = "Nombre de barres d'actions à droite (1, 2 ou 3)"
	TukuiL.option_actionbar_buttonsize = "Taille des boutons de la barre d'action"
	TukuiL.option_actionbar_buttonspacing = "Espace entre les boutons de la barre d'action"
	TukuiL.option_actionbar_petbuttonsize = "Taille des boutons du familier/ChangeForme"
	
	-- quest watch frame
	TukuiL.option_quest = "Quêtes"
	TukuiL.option_quest_movable = "Bouger la fenêtre d'Objectifs"
 
	-- arena
	TukuiL.option_arena = "Arène"
	TukuiL.option_arena_st = "Activer le traqueur de sorts ennemi"
	TukuiL.option_arena_uf = "Activer l'Unit Frame d'arène"
	
	-- pvp
	TukuiL.option_pvp = "Pvp"
	TukuiL.option_pvp_ii = "Activer les Icones d'Interruption"
 
	-- cooldowns
	TukuiL.option_cooldown = "Cooldowns"
	TukuiL.option_cooldown_enable = "Activer le cooldown numérique sur les boutons"
	TukuiL.option_cooldown_th = "Colorer en rouge le cooldown à X seconde(s)"
 
	-- chat
	TukuiL.option_chat = "Social"
	TukuiL.option_chat_enable = "Activer le Chat Tukui"
	TukuiL.option_chat_whispersound = "Jouer un son lors de la réception d'un message"
	TukuiL.option_chat_background = "Activer l'arrière plan du Chat"
	
	-- buff
	TukuiL.option_auras = "Auras"
	TukuiL.option_auras_player = "Activer les frames buff/debuff de Tukui"
 
	TukuiL.option_button_reset = "Défaut"
	TukuiL.option_button_load = "Appliquer"
	TukuiL.option_button_close = "Fermer"
	TukuiL.option_setsavedsetttings = "Activer les paramètres par personnage"
	TukuiL.option_resetchar = "Êtes-vous sûr de vouloir réinitialiser les paramètres de votre personnage ?"
	TukuiL.option_resetall = "Êtes vous sûr de vouloir tout réinitialiser ?"
	TukuiL.option_perchar = "Êtes vous sûr de vouloir annuler/passer à des paramètres par personnage ?"
	TukuiL.option_makeselection = "Vous devez faire un choix pour continuer."
end