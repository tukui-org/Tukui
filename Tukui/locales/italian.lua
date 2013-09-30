-- localization for Italian made by Oz (http://www.tukui.org/forums/profile.php?id=5749)
local T, C, L, G = unpack(select(2, ...))

if T.client == "itIT" then
	L.UI_Outdated = "La tua versione di Tukui non è aggiornata: puoi scaricare l'ultima versione da www.tukui.org."
	L.UI_Talent_Change_Bug = "Si è verificato un bug della Blizzard che, quando ispezioni un personaggio, impedisce il cambio di talenti. Sfortunatamente, in questa patch di WoW non c'è nulla che possiamo fare per correggerlo: per favore, ricarica la UI e riprova."
	L.chat_INSTANCE_CHAT = "IS"
	L.chat_INSTANCE_CHAT_LEADER = "CIS"
	L.chat_BN_WHISPER_GET = "DA"
	L.chat_GUILD_GET = "G"
	L.chat_OFFICER_GET = "U"
	L.chat_PARTY_GET = "GR"
	L.chat_PARTY_GUIDE_GET = "GGR"
	L.chat_PARTY_LEADER_GET = "CGR"
	L.chat_RAID_GET = "IN"
	L.chat_RAID_LEADER_GET = "CIN"
	L.chat_RAID_WARNING_GET = "AIN"
	L.chat_WHISPER_GET = "Da"
	L.chat_FLAG_AFK = "[Assente]"
	L.chat_FLAG_DND = "[Non disturbare]"
	L.chat_FLAG_GM = "[RG]"
	L.chat_ERR_FRIEND_ONLINE_SS = "è adesso|cff298F00online|r."
	L.chat_ERR_FRIEND_OFFLINE_S = "è adesso |cffff0000offline|r."

	L.chat_general = "Generale"
	L.chat_trade = "Commercio"
	L.chat_defense = "DifesaLocale"
	L.chat_recrutment = "CercaGilda"
	L.chat_lfg = "CercaGruppo"

	L.disband = "Sciogli il gruppo?"

	L.datatext_notalents ="Nessun talento"
	L.datatext_download = "Download: "
	L.datatext_bandwidth = "Larghezza banda: "
	L.datatext_guild = "Gilda"
	L.datatext_noguild = "Nessuna gilda"
	L.datatext_bags = "Sacche: "
	L.datatext_friends = "Amici"
	L.datatext_online = "Online: "
	L.datatext_armor = "Armatura"
	L.datatext_earned = "Entrate:"
	L.datatext_spent = "Uscite:"
	L.datatext_deficit = "Deficit:"
	L.datatext_profit = "Profitto:"
	L.datatext_timeto = "Tempo per"
	L.datatext_friendlist = "Elenco amici:"
	L.datatext_playersp = "pm"
	L.datatext_playerap = "pda"
	L.datatext_playerhaste = "celerità"
	L.datatext_dps = "DPS"
	L.datatext_hps = "CPS"
	L.datatext_playerarp = "par"
	L.datatext_session = "Sessione: "
	L.datatext_character = "Personaggio: "
	L.datatext_server = "Reame: "
	L.datatext_totalgold = "Totale: "
	L.datatext_savedraid = "Incursioni salvate"
	L.datatext_currency = "Valuta:"
	L.datatext_fps = " FPS e "
	L.datatext_ms = " ms"
	L.datatext_playercrit = " critico"
	L.datatext_playerheal = " cure"
	L.datatext_avoidancebreakdown = "Esaurimento elusione"
	L.datatext_lvl = "livello"
	L.datatext_boss = "Boss"
	L.datatext_miss = "Colpo fallito"
	L.datatext_dodge = "Schivata"
	L.datatext_block = "Blocco"
	L.datatext_parry = "Parata"
	L.datatext_playeravd = "Elusione: "
	L.datatext_servertime = "Orario reame: "
	L.datatext_localtime = "Orario locale: "
	L.datatext_mitigation = "Mitigazione per livello: "
	L.datatext_healing = "Cure: "
	L.datatext_damage = "Danni: "
	L.datatext_honor = "Onore: "
	L.datatext_killingblows = "Colpi di grazia: "
	L.datatext_ttstatsfor = "Statistiche per "
	L.datatext_ttkillingblows = "Colpi di grazia:"
	L.datatext_tthonorkills = "Uccisioni onorevoli:"
	L.datatext_ttdeaths = "Morti:"
	L.datatext_tthonorgain = "Onore guadagnato:"
	L.datatext_ttdmgdone = "Danni fatti:"
	L.datatext_tthealdone = "Cure fatte:"
	L.datatext_basesassaulted = "Basi assaltate:"
	L.datatext_basesdefended = "Basi difese:"
	L.datatext_towersassaulted = "Torri assaltate:"
	L.datatext_towersdefended = "Torri difese:"
	L.datatext_flagscaptured = "Bandiere catturate:"
	L.datatext_flagsreturned = "Bandiere recuperate:"
	L.datatext_graveyardsassaulted = "Cimiteri assaltati:"
	L.datatext_graveyardsdefended = "Cimiteri difesi:"
	L.datatext_demolishersdestroyed = "Demolitori distrutti:"
	L.datatext_gatesdestroyed = "Portali distrutti:"
	L.datatext_totalmemusage = "Utilizzo totale della memoria:"
	L.datatext_control = "Controllato da:"
	L.datatext_cta_allunavailable = "Impossibile ricevere informazioni sulla chiamata alle armi."
	L.datatext_cta_nodungeons = "Nessun dungeon offre al momento una chiamata alle armi."
	L.datatext_carts_controlled = "Carrelli controllati:"
	L.datatext_victory_points = "Punti vittoria:"
	L.datatext_orb_possessions = "Possesso globi:"
	L.datatext_galleon = "Galeone"
	L.datatext_sha = "Sha della Rabbia"
	L.datatext_oondasta = "Oondasta"
	L.datatext_nalak = "Nalak"
	L.datatext_celestrials = "Celestrials"
	L.datatext_ordos = "Ordos"
	L.datatext_defeated = "Sconfitto"
	L.datatext_undefeated = "Non sconfitto"

	L.Slots = {
		[1] = {1, "Testa", 1000},
		[2] = {3, "Spalle", 1000},
		[3] = {5, "Torso", 1000},
		[4] = {6, "Fianchi", 1000},
		[5] = {9, "Polsi", 1000},
		[6] = {10, "Mani", 1000},
		[7] = {7, "Gambe", 1000},
		[8] = {8, "Piedi", 1000},
		[9] = {16, "Mano primaria", 1000},
		[10] = {17, "Mano secondaria", 1000},
		[11] = {18, "A distanza", 1000}
	}

	L.popup_disableui = "Tukui non funziona a questa risoluzione, vuoi disattivare l'AddOn? Clicca 'Cancella' per provare con un'altra risoluzione."
	L.popup_install = "È la prima volta che usi Tukui con questo personaggio: devi ricaricare la tua UI per impostare barre delle azioni, variabili e riquadri per la chat."
	L.popup_reset = "Attenzione! Questo riporterà Tukui alle impostazioni di partenza: vuoi procedere?"
	L.popup_2raidactive = "Sono attive contemporaneamente 2 disposizioni da incursione, per favore selezionane una sola."
	L.popup_install_yes = "Sì (raccomandato)!"
	L.popup_install_no = "No, meglio di no!"
	L.popup_reset_yes = "Sì, piccola!"
	L.popup_reset_no = "No, altrimenti mi metto a piangere nel forum!"
	L.popup_fix_ab = "C'è qualcosa che non va con la tua barra delle azioni: vuoi ricaricare l'interfaccia per correggerla?"

	L.merchant_repairnomoney = "Non hai denaro sufficiente per riparare"
	L.merchant_repaircost = "I tuoi oggettii sono stati riparati al costo di"
	L.merchant_trashsell = "Le tue cianfrusaglie sono state vendute e hai guadagnato"

	L.goldabbrev = "|cffffd700o|r"
	L.silverabbrev = "|cffc7c7cfa|r"
	L.copperabbrev = "|cffeda55fr|r"

	L.error_noerror = "Ancora nessun errore."

	L.unitframes_ouf_offline = "Offline"
	L.unitframes_ouf_dead = "Morto"
	L.unitframes_ouf_ghost = "Spirito"
	L.unitframes_ouf_lowmana = "MANA BASSO"
	L.unitframes_ouf_threattext = "Minaccia sul bersaglio corrente:"
	L.unitframes_ouf_offlinedps = "Offline"
	L.unitframes_ouf_deaddps = "|cffff0000[MORTO]|r"
	L.unitframes_ouf_ghostheal = "SPIRITO"
	L.unitframes_ouf_deadheal = "MORTO"
	L.unitframes_ouf_gohawk = "AQUILA ATTIVA"
	L.unitframes_ouf_goviper = "VIPERA ATTIVA"
	L.unitframes_disconnected = "D/C"
	L.unitframes_ouf_wrathspell = "Ira"
	L.unitframes_ouf_starfirespell = "Fuoco stellare"

	L.tooltip_count = "Conteggio"

	L.bags_noslots = "Non puoi comprare altri spazi!"
	L.bags_costs = "Costo: %.2f ori"
	L.bags_buyslots = "Compra un nuovo spazio con /bags purchase yes."
	L.bags_openbank = "Devi prima aprire la tua banca."
	L.bags_sort = "Riordina le tue sacche o la tua banca, se aperta."
	L.bags_stack = "Completa pile parziali nelle tue sacche o in banca, se aperta."
	L.bags_buybankslot = "Compra spazi in banca (devi avere la banca aperta)."
	L.bags_search = "Ricerca"
	L.bags_sortmenu = "Riordino"
	L.bags_sortspecial = "Riordino speciale"
	L.bags_stackmenu = "Impilamento"
	L.bags_stackspecial = "Impilamento speciale"
	L.bags_showbags = "Mostra sacche"
	L.bags_sortingbags = "Riordino terminato."
	L.bags_nothingsort= "Non c'è nulla da riordinare!"
	L.bags_bids = "Sacche in uso: "
	L.bags_stackend = "Rimpilamento terminato."
	L.bags_rightclick_search = "Clicca col destro per cercare."

	L.loot_fish = "Bottino pescato."
	L.loot_empty = "Spazio vuoto."
	L.loot_randomplayer = "Giocatore casuale."
	L.loot_self = "Bottino personale."

	L.chat_invalidtarget = "Bersaglio non valido."

	L.mount_wintergrasp = "Lungoinverno"

	L.core_autoinv_enable = "Invito automatico ON: invite"
	L.core_autoinv_enable_c = "Invito automatico ON: "
	L.core_autoinv_disable = "Invito automatico OFF"
	L.core_wf_unlock = "Riquadro del tracciamento delle missioni sbloccato."
	L.core_wf_lock = "Riquadro del tracciamento del missioni bloccato."
	L.core_welcome1 = "Benvenuto/a in  |cffC495DDTukui|r, versione "
	L.core_welcome2 = "Digita |cff00FFFF/uihelp|r per maggiori informazioni o visita www.tukui.org."

	L.core_uihelp1 = "|cff00ff00Comandi slash generali|r"
	L.core_uihelp2 = "|cffFF0000/moveui|r - Sblocca e muovi gli elementi sullo schermo."
	L.core_uihelp3 = "|cffFF0000/rl|r - Ricarica la tua interfaccia utente."
	L.core_uihelp4 = "|cffFF0000/gm|r - Invia un ticket a un RG o mostra l'Assistenza clienti in gioco."
	L.core_uihelp5 = "|cffFF0000/frame|r - Individua il nome del riquadro su cui hai il cursore (molto utile per l'editing in Lua)."
	L.core_uihelp6 = "|cffFF0000/heal|r - Attiva la disposizione dell'incursione da guaritore."
	L.core_uihelp7 = "|cffFF0000/dps|r - Attiva la disposizione dell'incursione da assaltatore/difensore."
	L.core_uihelp8 = "|cffFF0000/bags|r - Per riordinare, comprare spazi in banca o impilare oggetti nelle tue sacche."
	L.core_uihelp9 = "|cffFF0000/resetui|r - Riporta Tukui alle impostazioni di partenza."
	L.core_uihelp10 = "|cffFF0000/rd|r - Sciogli l'incursione."
	L.core_uihelp11 = "|cffFF0000/ainv|r - Attiva l'invito automatico quando in un sussurro è contenuta una parola chiave: puoi impostare la tua personale parola chiave digitando /ainv seguito dalla parola scelta."
	L.core_uihelp100 = "(Scorri in alto per ulteriori comandi ...)"

	L.symbol_CLEAR = "Pulisci"
	L.symbol_SKULL = "Teschio"
	L.symbol_CROSS = "Croce"
	L.symbol_SQUARE = "Quadrato"
	L.symbol_MOON = "Luna"
	L.symbol_TRIANGLE = "Triangolo"
	L.symbol_DIAMOND = "Diamante"
	L.symbol_CIRCLE = "Cerchio"
	L.symbol_STAR = "Stella"

	L.bind_combat = "Non puoi assegnare tasti di scelta rapida se impegnato in combattimento."
	L.bind_saved = "Tutti i tasti di scelta rapida sono stato salvati."
	L.bind_discard = "Tutti gli ultimi tasti di scelta rapida non sono stati salvati."
	L.bind_instruct = "Passa il cursore del mouse su di un qualsiasi scomparto delle barre delle azioni per assegnargli un tasto di scelta rapida: premi il tasto Esc o clicca il tasto destro del mouse per cancellare il tasto di scelta rapida corrente."
	L.bind_save = "Salva i tasti di scelta rapida."
	L.bind_discardbind = "Non salvare i tasti di scelta rapida."

	L.move_tooltip = "Muovi i suggerimenti"
	L.move_minimap = "Muovi la minimappa"
	L.move_watchframe = "Muovi le missioni"
	L.move_gmframe = "Muovi i tickets"
	L.move_buffs = "Muovi i benefici del giocatore"
	L.move_debuffs = "Muovi le penalità del giocatore"
	L.move_shapeshift = "Muovi la 'barra mutaforma/totem'"
	L.move_achievements = "Muovi le imprese"
	L.move_roll = "Muovi il riquadro dei tiri per il bottino"
	L.move_vehicle = "Muovi il riquadro del veicolo"
	L.move_extrabutton = "Muovi lo scomparto extra"

	-------------------------------------------------
	-- INSTALLATION
	-------------------------------------------------

	-- headers
	L.install_header_1 = "Benvenuto/a"
	L.install_header_2 = "1. Informazioni essenziali"
	L.install_header_3 = "2. Riquadri delle unità"
	L.install_header_4 = "3. Funzionalità"
	L.install_header_5 = "4. Cose che dovresti sapere!"
	L.install_header_6 = "5. Comandi"
	L.install_header_7 = "6. Finita"
	L.install_header_8 = "1. Impostazioni essenziali"
	L.install_header_9 = "2. Sociale"
	L.install_header_10= "3. Riquadri"
	L.install_header_11= "4. Successo!"

	-- install
	L.install_init_line_1 = "Grazie per aver scelto Tukui!"
	L.install_init_line_2 = "Sarai guidato attraverso il processo d'installazione in pochi semplici passaggi. A ciascun passaggio, potrai scegliere se applicare o meno le impostazioni presentate."
	L.install_init_line_3 = "Ti sarà data la possibilità di vedere un breve tutorial esplicativo su alcune alcune funzionalità della Tukui."
	L.install_init_line_4 = "Premi il pulsante 'Tutorial' per essere guidato in questa piccola introduzione oppure 'Installa' per saltare questo passaggio."

	-- tutorial 1
	L.tutorial_step_1_line_1 = "Questo breve tutorial ti mostrerà alcune funzionalità di Tukui."
	L.tutorial_step_1_line_2 = "Prima di tutto, le informazioni essenziali che dovresti conoscere prima che tu possa giocare con questa UI."
	L.tutorial_step_1_line_3 = "Questa installazione è parzialmente per-personaggio. Al contrario, alcune di queste impostazioni saranno applicate dopo per tutto l'account. Dovrai avviare il processo d'installazione per ciascun nuovo personaggioc che utilizzi Tukui. Il processo d'installazione sarà mostrato automaticamente per ogni personaggio che utilizzerà Tukui per la prima volta. Inoltre, le opzioni per i 'Power Users' possono essere trovate in /Tukui/config/config.lua mentre per 'Friendly Users' basterà digitare /tukui in gioco."
	L.tutorial_step_1_line_4 = "Per 'Power User' s'intende l'utilizzatore di computer con competenze necessarie per utilizzare funzionalità avanzate (come le modifiche in Lua) e che di solito in possesso dell'utente medio. Per 'Friendly User' s'intende un normale utente senza capacità di programmazione: per questi ultimi si consiglia di utilizzare lo strumento di configurazione fornito in gioco (digitando /tukui) al fine di modificare le impostazioni di Tukui desiderate."

	-- tutorial 2
	L.tutorial_step_2_line_1 = "Tukui include una versione di oUF (un'AddOn creata da Haste) chiamata oUFTukui: questa s'occupa di tutti i riquadri delle unità sullo schermo, di benefici e penalità e degli elementi specifici di ciascuna classe."
	L.tutorial_step_2_line_2 = "Puoi visitare wowinterface.com e cercare oUF per maggiori informazioni su questo strumento."
	L.tutorial_step_2_line_3 = "Per cambiare facilmente la posizione dei riquadri delle unità è sufficiente digitare /moveui."
	L.tutorial_step_2_line_4 = ""

	-- tutorial 3
	L.tutorial_step_3_line_1 = "Tukui è una rivisitazione della UI Blizzard. Niente di più, niente di meno. Praticamente tutte le funzionalità provviste dalla UI di base saranno utilizzabili in Tukui. Le uniche funzionalità non previste dalla UI di base sono automatizzazioni non immediatamente visibili sullo schermo, come la vendita automatica delle cianfrusaglie quando si visita un mercante o il riordino automatico delle sacche."
	L.tutorial_step_3_line_2 = "A non tutti piacciono strumenti come damage meters, threat meters, boss mods, ecc. ecc. e noi reputiamo che questa sia la scelta migliore da prendere. Tukui è studiato attorno all'idea di funzionare per ogni classe, ruolo, specializzazione, tipologia di gioco, gusti dell'utente e via dicendo. Questo è il motivo per cui Tukui è una delle interfacce utente più popolari del momento. Si adatta a tutti gli stili di gioco ed è estremamente modificabile. Essa è anche un buon punto di partenza per coloro i quali desiderano creare la propria UI senza la dipendenza da altre AddOns. Dal 2009 molti utenti hanno cominciato a utilizzare Tukui come base per le proprie UI: dai uno sguardo alla sezione 'Edited Packages' sul nostro sito!"
	L.tutorial_step_3_line_3 = "Per installare funzionalità aggiuntive o altre mods, puoi andare alla sezione sulle AddOns extra del nostro sito oppure visitare www.wowinterface.com."
	L.tutorial_step_3_line_4 = ""

	-- tutorial 4
	L.tutorial_step_4_line_1 = "Per impostare il numero di barre delle azioni visibili, passa il cursore del mouse accanto alla barra delle azioni in basso, alla sua sinistra o alla sua destra.  Fai lo stesso per la barra delle azioni sulla destra, passandoci accanto il cursore, sopra o sotto di essa. Per copiare il testo dei riquadri di chat, clicca il pulsante in basso che compare passando il cursore del mouse sull'angolo destro dei riquadri di chat."
	L.tutorial_step_4_line_2 = "Puoi cliccare col tasto sinistro del mouse su circa l'80% dei testi informativi (data texts) per visualizzare diverse informazioni. I testi informativi per amici e gilda hanno anche una funzionalità attivabile col tasto destro del mouse."
	L.tutorial_step_4_line_3 = "Sono disponibili anche dei menu a tendina: cliccando col tasto destro del mouse sulla [X] (Chiudi) del riquadro delle sacche comparirà un menu a tendina per visualizzare le singole sacche, riordinare gli oggetti, ecc. ecc., mentre cliccando col tasto centrale del mouse sulla mini mappa comparirà invece il micro menu."
	L.tutorial_step_4_line_4 = ""

	-- tutorial 5
	L.tutorial_step_5_line_1 = "Infine, Tukui include alcuni utili comandi slash: sotto ne troverete un elenco."
	L.tutorial_step_5_line_2 = "/moveui consente di muovere dove si vuole numerosi riquadri sullo schermo. /enable e /disable sono utilizzati per attivare e disattivare le AddOns velocemente. /rl ricarica la UI."
	L.tutorial_step_5_line_3 = "/tt ti consente d'inviare un sussurro al tuo bersaglio.  /rc avvia un appello.  /rd scioglie un gruppo o un'incursione.  /bags visualizza altri comandi slash per utilizzare ulteriori funzionalità disponibili.  /ainv attiva l'invito automatico quando ricevi un sussurro (/ainv off per disattivarlo)."
	L.tutorial_step_5_line_4 = "/gm mostra il riquadro dell'Assistenza clienti.  /install o /tutorial ricarica questo installer. "

	-- tutorial 6
	L.tutorial_step_6_line_1 = "Il tutorial è terminato.  Puoi decidere di riconsultarlo quando vuoi semplicemente digitando /tutorial."
	L.tutorial_step_6_line_2 = "Ti suggerisco di dare un'occhiata a config/config.lua o digitare /tukui per personalizzare la UI secondo le tue necessità."
	L.tutorial_step_6_line_3 = "Adesso puoi continuare con l'installazione della UI qualora non fosse ancora terminata o volessi riportare la UI alle impostazioni di partenza!"
	L.tutorial_step_6_line_4 = ""

	-- install step 1
	L.install_step_1_line_1 = "Questi passaggi applicheranno le corrette impostazioni (CVar) per Tukui."
	L.install_step_1_line_2 = "Il primo passaggio applicherà le impostazioni essenziali."
	L.install_step_1_line_3 = "Questo passaggio è |cffff0000raccomandato|r a tutti gli utenti, a meno che non vogliate applicare solo parti specifiche delle impostazioni."
	L.install_step_1_line_4 = "Clicca 'Continua' per applicare tutte le impostazioni o clicca 'Salta' se desideri saltare questo passaggio."

	-- install step 2
	L.install_step_2_line_0 = "È stata rivelata un'altra AddOn per la chat: ignoreremo questo passaggio. Per favore clicca 'Salta' per continuare con l'installazione."
	L.install_step_2_line_1 = "Il secondo pessaggio applicherà le corrette impostazioni per la chat."
	L.install_step_2_line_2 = "Se sei un nuovo utente, questo passaggio è raccomandato, in caso contrario potresti volerlo saltare."
	L.install_step_2_line_3 = "È normale che il carattere della chat possa apparire troppo grande una volta applicate queste impostazioni: ritornerà alle sue dimensioni normali appena terminata l'installazione."
	L.install_step_2_line_4 = "Clicca 'Continua' per applicare le impostazioni o clicca 'Salta' se desideri saltare questo passaggio."

	-- install step 3
	L.install_step_3_line_1 = "Il terzo e ultimo passaggio imposterà le posizioni di base dei riquadri."
	L.install_step_3_line_2 = "Questo passaggio è |cffff0000raccomandato|r ai nuovi utenti."
	L.install_step_3_line_3 = ""
	L.install_step_3_line_4 = "Clicca 'Continua' per applicare le impostazioni o clicca 'Salta' se desideri saltare questo passaggio."

	-- install step 4
	L.install_step_4_line_1 = "L'installazione è stata completata."
	L.install_step_4_line_2 = "Per favore, clicca il pulsante 'Termina' per ricaricare la UI."
	L.install_step_4_line_3 = ""
	L.install_step_4_line_4 = "Divertiti con Tukui! Vienici a trovare su www.tukui.org!"

	-- buttons
	L.install_button_tutorial = "Tutorial"
	L.install_button_install = "Installa"
	L.install_button_next = "Successivo"
	L.install_button_skip = "Salta"
	L.install_button_continue = "Continua"
	L.install_button_finish = "Termina"
	L.install_button_close = "Chiudi"
end