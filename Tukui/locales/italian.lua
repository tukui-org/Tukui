-- localization for italian made by Iceky (http://www.tukui.org/forums/profile.php?id=42201)
local T, C, L, G = unpack(select(2, ...))

if T.client == "itIT" then
	L.UI_Outdated = "La tua versione di Tukui non è aggiornata. Puoi scaricare l'ultima versione da www.tukui.org"
	L.UI_Talent_Change_Bug = "Un bug della Blizzard sta impedendo il cambio dei talenti, questo succede quando si ispeziona qualcuno. Sfortunatamente non si può fare nulla per sistemare il problema, ricaricate la propria ui e riprovate."

	L.chat_BATTLEGROUND_GET = "BG"
	L.chat_BATTLEGROUND_LEADER_GET = "BG"
	L.chat_BN_WHISPER_GET = "Da"
	L.chat_GUILD_GET = "G"
	L.chat_OFFICER_GET = "O"
	L.chat_PARTY_GET = "P"
	L.chat_PARTY_GUIDE_GET = "P"
	L.chat_PARTY_LEADER_GET = "P"
	L.chat_RAID_GET = "R"
	L.chat_RAID_LEADER_GET = "R"
	L.chat_RAID_WARNING_GET = "W"
	L.chat_WHISPER_GET = "Da"
	L.chat_FLAG_AFK = "[AFK]"
	L.chat_FLAG_DND = "[DND]"
	L.chat_FLAG_GM = "[GM]"
	L.chat_ERR_FRIEND_ONLINE_SS = "è |cff298F00online|r"
	L.chat_ERR_FRIEND_OFFLINE_S = "è |cffff0000offline|r"

	L.chat_general = "Generale"
	L.chat_trade = "Commercio"
	L.chat_defense = "DifesaLocale"
	L.chat_recrutment = "CercaGilda"
	L.chat_lfg = "CercaGruppo"

	L.disband = "Rimuovere il gruppo ?"

	L.datatext_notalents ="Nessun talento"
	L.datatext_download = "Download: "
	L.datatext_bandwidth = "Bandwidth: "
	L.datatext_guild = "Gilda"
	L.datatext_noguild = "Nessuna Gilda"
	L.datatext_bags = "Zaino: "
	L.datatext_friends = "Amici"
	L.datatext_online = "Online: "
	L.datatext_armor = "Armatura"
	L.datatext_earned = "Guadagnato:"
	L.datatext_spent = "Speso:"
	L.datatext_deficit = "Deficit:"
	L.datatext_profit = "Profitto:"
	L.datatext_timeto = "Time to"
	L.datatext_friendlist = "Lista amici:"
	L.datatext_playersp = "SP"
	L.datatext_playerap = "AP"
	L.datatext_playerhaste = "Celerità"
	L.datatext_dps = "DPS"
	L.datatext_hps = "HPS"
	L.datatext_playerarp = "ARP"
	L.datatext_session = "Sessione: "
	L.datatext_character = "Personaggio: "
	L.datatext_server = "Server: "
	L.datatext_totalgold = "Totale: "
	L.datatext_savedraid = "Incursioni Salvate"
	L.datatext_currency = "Valuta:"
	L.datatext_fps = " FPS & "
	L.datatext_ms = " MS"
	L.datatext_playercrit = " Crit"
	L.datatext_playerheal = " Cure"
	L.datatext_avoidancebreakdown = "Prevenzione Ripartizione"
	L.datatext_lvl = "lvl"
	L.datatext_boss = "Boss"
	L.datatext_miss = "Mancato"
	L.datatext_dodge = "Schivato"
	L.datatext_block = "Bloccato"
	L.datatext_parry = "Parato"
	L.datatext_playeravd = "AVD: "
	L.datatext_servertime = "Ora Server: "
	L.datatext_localtime = "Ora Locale: "
	L.datatext_mitigation = "Mitigazione livello: "
	L.datatext_healing = "Cure: "
	L.datatext_damage = "Danno: "
	L.datatext_honor = "Onore: "
	L.datatext_killingblows = "Uccisioni: "
	L.datatext_ttstatsfor = "Statistiche Per "
	L.datatext_ttkillingblows = "Uccisioni:"
	L.datatext_tthonorkills = "Uccisioni Onorevoli:"
	L.datatext_ttdeaths = "Morti:"
	L.datatext_tthonorgain = "Onore Guadagnato:"
	L.datatext_ttdmgdone = "Danno:"
	L.datatext_tthealdone = "Cure:"
	L.datatext_basesassaulted = "Basi Assaltate:"
	L.datatext_basesdefended = "Basi Difese:"
	L.datatext_towersassaulted = "Torri Assaltate:"
	L.datatext_towersdefended = "Torri Difese:"
	L.datatext_flagscaptured = "Bandiere Catturate:"
	L.datatext_flagsreturned = "Bandiere Riportate:"
	L.datatext_graveyardsassaulted = "Cimiteri Assaltati:"
	L.datatext_graveyardsdefended = "Cimireti Difesi:"
	L.datatext_demolishersdestroyed = "Catapulte Distrutte:"
	L.datatext_gatesdestroyed = "Gates Distrutti:"
	L.datatext_totalmemusage = "Utilizzo Memoria Totale:"
	L.datatext_control = "Controllato a:"
	L.datatext_cta_allunavailable = "Impossibile avere informazione sul Call To Arms."
	L.datatext_cta_nodungeons = "Nessun dungeon sta offrendo il Call To Arms."
	L.datatext_carts_controlled = "Carrelli Controllati:"
	L.datatext_victory_points = "Punti Vittoria:"
	L.datatext_orb_possessions = "Orb Posseduti:"

	L.Slots = {
		[1] = {1, "Testa", 1000},
		[2] = {3, "Spalle", 1000},
		[3] = {5, "Torso", 1000},
		[4] = {6, "Fianchi", 1000},
		[5] = {9, "Polsi", 1000},
		[6] = {10, "Mani", 1000},
		[7] = {7, "Gambe", 1000},
		[8] = {8, "Piedi", 1000},
		[9] = {16, "Mano Primaria", 1000},
		[10] = {17, "Mano Secondaria", 1000},
		[11] = {18, "Ranged", 1000}
	}

	L.popup_disableui = "Tukui non funziona con questa risoluzione, vuoi disabilitare Tukui? (Cancella se vuoi provare un altra risoluzione)"
	L.popup_install = "La prima volta che esegui Tukui v15 con questo personaggio. Devi ricaricare la tua UI per settare le barre di azione, le variabili e la chat."
	L.popup_reset = "Attenzione! Questo resetterà Tukui alle impostazioni di default. Vuoi procedere?"
	L.popup_2raidactive = "Sono attivi 2 raid layouts, sceglierne uno."
	L.popup_install_yes = "Yeah! (Raccomandato!)"
	L.popup_install_no = "No"
	L.popup_reset_yes = "Yeah baby!"
	L.popup_reset_no = "No"
	L.popup_fix_ab = "C'è qualcosa di sbagliato nelle tue barre di azione. Vuoi ricaricare la UI per sistemare il problema?"

	L.merchant_repairnomoney = "Non hai abbastanza soldi per riparare!"
	L.merchant_repaircost = "I tuoi item sono stati riparati per"
	L.merchant_trashsell = "La tua spazzatura è stata venduta e hai guadagnato"

	L.goldabbrev = "|cffffd700g|r"
	L.silverabbrev = "|cffc7c7cfs|r"
	L.copperabbrev = "|cffeda55fc|r"

	L.error_noerror = "Nessun errore."

	L.unitframes_ouf_offline = "Offline"
	L.unitframes_ouf_dead = "Morto"
	L.unitframes_ouf_ghost = "Fantasma"
	L.unitframes_ouf_lowmana = "MANA BASSO"
	L.unitframes_ouf_threattext = "Minaccia sul target corrente:"
	L.unitframes_ouf_offlinedps = "Offline"
	L.unitframes_ouf_deaddps = "|cffff0000[DEAD]|r"
	L.unitframes_ouf_ghostheal = "FANTASMA"
	L.unitframes_ouf_deadheal = "MORTO"
	L.unitframes_ouf_gohawk = "GO HAWK"
	L.unitframes_ouf_goviper = "GO VIPER"
	L.unitframes_disconnected = "D/C"
	L.unitframes_ouf_wrathspell = "Wrath"
	L.unitframes_ouf_starfirespell = "Starfire"

	L.tooltip_count = "Count"

	L.bags_noslots = "Impossibile comprare altri slot!"
	L.bags_costs = "Prezzo: %.2f gold"
	L.bags_buyslots = "Compra nuovi slot con /bags purchase yes"
	L.bags_openbank = "Devi aprire la tua banca prima."
	L.bags_sort = "Ordina i tuoi zaini o la tua banca, se aperta."
	L.bags_stack = "Riempie gli slot nei tuoi zaini o nella tua banca, se aperta."
	L.bags_buybankslot = "Compra slot di banca. (Devi avere la banca aperta)"
	L.bags_search = "Cerca"
	L.bags_sortmenu = "Ordina"
	L.bags_sortspecial = "Ordina Speciale"
	L.bags_stackmenu = "Stack"
	L.bags_stackspecial = "Stack Speciale"
	L.bags_showbags = "Visualizza Zaini"
	L.bags_sortingbags = "Ordinamento finito."
	L.bags_nothingsort= "Nulla da ordinare."
	L.bags_bids = "Zaini utilizzati: "
	L.bags_stackend = "Restacking finito."
	L.bags_rightclick_search = "Right-click per cercare."

	L.loot_fish = "Fishy loot"
	L.loot_empty = "slot vuoto"

	L.chat_invalidtarget = "Target non valido"

	L.mount_wintergrasp = "Wintergrasp"

	L.core_autoinv_enable = "Autoinvite ON: invite"
	L.core_autoinv_enable_c = "Autoinvite ON: "
	L.core_autoinv_disable = "Autoinvite OFF"
	L.core_wf_unlock = "WatchFrame unlock"
	L.core_wf_lock = "WatchFrame lock"
	L.core_welcome1 = "Benvenuto in |cffC495DDTukui|r, versione "
	L.core_welcome2 = "Digita |cff00FFFF/uihelp|r per maggiori informazione o visita www.tukui.org"

	L.core_uihelp1 = "|cff00ff00Comandi Generali|r"
	L.core_uihelp2 = "|cffFF0000/moveui|r - Sblocca e muove gli elementi attorno allo schermo."
	L.core_uihelp3 = "|cffFF0000/rl|r - Ricaricare la UI."
	L.core_uihelp4 = "|cffFF0000/gm|r - Iniva un ticket al GM o visualizza l'help in game."
	L.core_uihelp5 = "|cffFF0000/frame|r - Rileva il nome del frame sul quale il tuo mouse si trova. (Utile per chi edita il lua)"
	L.core_uihelp6 = "|cffFF0000/heal|r - Abilita l'healing raid layout."
	L.core_uihelp7 = "|cffFF0000/dps|r - Abilita il DPS/Tank raid layout."
	L.core_uihelp8 = "|cffFF0000/bags|r - Per ordinare, comprare slot di banca o completare gli stack degli item nei tuoi zaini."
	L.core_uihelp9 = "|cffFF0000/resetui|r - Reset Tukui alle impostazioni di default."
	L.core_uihelp10 = "|cffFF0000/rd|r - Rimuovere il raid."
	L.core_uihelp11 = "|cffFF0000/ainv|r - Abilita autoinvito via parola su sussurro. Puoi settare la tua propia parola con `/ainv myword`"
	L.core_uihelp100 = "(Scrolla su per maggiori comandi ...)"

	L.symbol_CLEAR = "Pulisci"
	L.symbol_SKULL = "Teschio"
	L.symbol_CROSS = "Croce"
	L.symbol_SQUARE = "Quadrato"
	L.symbol_MOON = "Luna"
	L.symbol_TRIANGLE = "Triangolo"
	L.symbol_DIAMOND = "Diamante"
	L.symbol_CIRCLE = "Cerchio"
	L.symbol_STAR = "Stella"

	L.bind_combat = "Non puoi associare tasti mentre sei in combattimento."
	L.bind_saved = "Tutte le tue associazioni sono state salvate."
	L.bind_discard = "Tutte le nuove associazioni sono state scartate."
	L.bind_instruct = "Posiziona il puntatore del mouse su qualsiasi actionbutton per legarlo. Premere il tasto Esc o fare clic destro per cancellare le attuali associazioni."
	L.bind_save = "Salva associazioni"
	L.bind_discardbind = "Scarta associazioni"

	L.move_tooltip = "Muovi Tooltip"
	L.move_minimap = "Muovi Minimappa"
	L.move_watchframe = "Muovi Quests"
	L.move_gmframe = "Muovi Ticket"
	L.move_buffs = "Muovi Player Buffs"
	L.move_debuffs = "Muovi Player Debuffs"
	L.move_shapeshift = "Muovi Shapeshift/Totem"
	L.move_achievements = "Muovi Achievements"
	L.move_roll = "Muovi Loot Roll Frame"
	L.move_vehicle = "Muovi Vehicle Seat"
	L.move_extrabutton = "Extra Button"

	-------------------------------------------------
	-- INSTALLATION
	-------------------------------------------------

	-- headers
	L.install_header_1 = "Benveuto"
	L.install_header_2 = "1. Essenziali"
	L.install_header_3 = "2. Unitframes"
	L.install_header_4 = "3. Caratteristiche"
	L.install_header_5 = "4. Cose che devi sapere!"
	L.install_header_6 = "5. Comandi"
	L.install_header_7 = "6. Finito"
	L.install_header_8 = "1. Impostazioni essenziali"
	L.install_header_9 = "2. Sociale"
	L.install_header_10= "3. Frames"
	L.install_header_11= "4. Successo!"

	-- install
	L.install_init_line_1 = "Grazie per aver scelto Tukui!"
	L.install_init_line_2 = "Sarai guidato attraverso l'installazione in pochi semplici passi. Ad ogni passo, puoi decidere cosa applicare e cosa no oppure saltare il passo."
	L.install_init_line_3 = "Si è data la possibilità di vedere un breve tutorial su alcune delle caratteristiche di Tukui."
	L.install_init_line_4 = "Premi 'Tutorial' per essere guidato attraverso questa piccola introduzione, oppure premi 'Installa' per saltare questo passo."

	-- tutorial 1
	L.tutorial_step_1_line_1 = "Questo breve tutorial ti mostrerà alcune delle caratteristiche di Tukui."
	L.tutorial_step_1_line_2 = "Primo, le cose essenziali che devi sapere prima che tu possa giocare con questa UI."
	L.tutorial_step_1_line_3 = "Questa installazione è parzialmente specifica per il singolo personaggio. Mentre alcune impostazioni che verranno applicate in seguito saranno account-wide, devi avviare lo script di installazione per ogni nuovi personaggio che esegue Tukui. Lo script si esegue in automatico su ogni nuovo personaggio per la priam volta. Inoltre le opzioni si possono trovare in /Tukui/config/config.lua per gli utenti `Power` users oppure digitando /tukui in gioco per `Friendly` users"
	L.tutorial_step_1_line_4 = "Un power user è un utente che ha le abilità per utilizzare caratteristiche avanzate (ex: Lua editing) che non sono alla portata dei normali utenti. Un friendly user è un normale utente che necessariamente non è capace di programmare. E' consigliato per questi utilizzare lo strumento di configurazione in gioco (/tukui) per le impostazioni che vogliono cambiare in Tukui."

	-- tutorial 2
	L.tutorial_step_2_line_1 = "Tukui include una versione di oUF (oUFTukui) creata da Haste. Questa controlla tutte le unitframe dello schermo, buffs and debuffs, e gli elementi specifici della classe."
	L.tutorial_step_2_line_2 = "Puoi visitare wowinterface.com e cercare oUF per maggiori informazioni."
	L.tutorial_step_2_line_3 = "Per cambiare facilmente la posizione delle unitframe digitate /moveui."
	L.tutorial_step_2_line_4 = ""

	-- tutorial 3
	L.tutorial_step_3_line_1 = "Tukui ridisegna l'UI della Blizzard. Nulla di meno, nulla di più. Approssimatamente tutte le caratteristiche che vedete nella Default UI sono disponibili in Tukui. Le uniche caratteristiche non disponibili tramite la default UI sono quelle caratteristiche automatiche che non sono visibili a schermo, per esempio la vendita autmatica degli item grigi o l'auto ordinamento degli zaini."
	L.tutorial_step_3_line_2 = "Non a tutti piaciono cose come DPS, Boss mods, Threat meters, etc, abbiamo deciso che era la cosa migliore. Tukui è creato attorno ad una idea che vada bene per tutte le classi, ruoli e spec. Per questo Tukui è uno dei più popolari UI in questo momento. Si adatta a tutti gli stili di gioco ed è estremamente editabile. E' disegnato anche per esssere un buon inizio per tutti quelli che vogliono iniziare a costruire una propia UI senza dipendere dagli addon. Dal 2009 multi utenti hanno iniziato ad usare Tukui come base per la loro UI. Date Un'occhiata alla sezione Edited Packages sul nostro sito!"
	L.tutorial_step_3_line_3 = "Gli utenti potranno visitare la nostra sezione per le mod sul nostro sito o visitando www.wowinterface.com per installare caratteristiche aggiuntive."
	L.tutorial_step_3_line_4 = ""

	-- tutorial 4
	L.tutorial_step_4_line_1 = "Per impostare quante barre vuoi, posizionati sopra con il mouse a sinistra o destra della action bar. Fate lo stasso sulla destra. Per copiare il testo dalla chat, premete il bottone nella parte destra della chat."
	L.tutorial_step_4_line_2 = "Puoi fare left-click sull'80% dei datatext per visualizzare i pannelli BLizzard. Amici e Gilda datatext hanno la caratteristica right-click."
	L.tutorial_step_4_line_3 = "Ci sono alcuni menu a tendina disponibili. Right-Click su [X] (Chiudi) per gli zaini visualizzerà gli zaini, ordinamento item, visualizzerà il keyring, etc. Middle-Clicking sulla minimappa visualizzerà un micro menu."
	L.tutorial_step_4_line_4 = ""

	-- tutorial 5
	L.tutorial_step_5_line_1 = "Ultimo, Tukui include una lista di comandi utili. "
	L.tutorial_step_5_line_2 = "/moveui permette di muovere i Frame per lo schermo.  /enable e /disable abilita/disabilita addons.  /rl ricarica UI."
	L.tutorial_step_5_line_3 = "/tt sussurra al target.  /rc inizia il ready check.  /rd rimuove il  party o il raid.  /bags visualizza alcune caratteristiche attraverso la command line  /ainv abilita auto invito attraverso sussurro.  (/ainv off) lo rende disabilitato"
	L.tutorial_step_5_line_4 = "/gm visualizza l'help.  /install o /tutorial carica questo installer. "

	-- tutorial 6
	L.tutorial_step_6_line_1 = "Il tutorial è completo. Lo puoi riconsultare in ogni momento digitando /tutorial"
	L.tutorial_step_6_line_2 = "Ti suggerisco di dare un'occhiata a config/config.lua o digitare /Tukui per personalizzare la UI come vuoi."
	L.tutorial_step_6_line_3 = "Puoi continuare con l'installazione della UI se non è stata ancora fatta oppure puoi reimpostarla!"
	L.tutorial_step_6_line_4 = ""

	-- install step 1
	L.install_step_1_line_1 = "Questi passaggi applicheranno le corrette impostazioni CVar per Tukui."
	L.install_step_1_line_2 = "Il primo passaggio applica le impostazioni  essenziali."
	L.install_step_1_line_3 = "Questo è |cffff0000reccomandato|r per qualsiasi utente, a meno che tu voglia applicare solo parti specifiche delle impostazioni."
	L.install_step_1_line_4 = "Premete 'Continua' per applicare le impostazioni, oppure premete 'Salta' se volete saltare il passaggio."

	-- install step 2
	L.install_step_2_line_0 = "Un'altro addon per chat è stato trovato. Ignoreremo questo passaggio. Premete 'Salta' per continuare l'installazione."
	L.install_step_2_line_1 = "Il secondo passaggio applica le impostazioni per la chat."
	L.install_step_2_line_2 = "Se sei un nuovo utente queste impostazioni sono raccomandate. Se invece se un utente già esistente puoi saltare questo passaggio."
	L.install_step_2_line_3 = "E' normale che il carattere della chat sembri più grande dopo aver applicato queste impostazioni. Tornerà normale dopo aver completato l'installazione."
	L.install_step_2_line_4 = "Premete 'Continua' per applicare le impostazioni, oppure premete 'Salta' se volete saltare il passaggio."

	-- install step 3
	L.install_step_3_line_1 = "Il terzo e ultimo passaggio applica la posizione di default dei frame."
	L.install_step_3_line_2 = "Questo passaggio è |cffff0000raccomandato|r per i nuovi utenti."
	L.install_step_3_line_3 = ""
	L.install_step_3_line_4 = "Premete 'Continua' per applicare le impostazioni, oppure premete 'Salta' se volete saltare il passaggio."

	-- install step 4
	L.install_step_4_line_1 = "L'installazione è completata."
	L.install_step_4_line_2 = "Premete su 'Finito' per ricaricare la UI."
	L.install_step_4_line_3 = ""
	L.install_step_4_line_4 = "Goditi Tukui! Visita www.tukui.org!"

	-- buttons
	L.install_button_tutorial = "Tutorial"
	L.install_button_install = "Installa"
	L.install_button_next = "Successivo"
	L.install_button_skip = "Salta"
	L.install_button_continue = "Continua"
	L.install_button_finish = "Finito"
	L.install_button_close = "Chiudi"
end