-- localization for enUS and enGB
local T, C, L, G = unpack(select(2, ...))

if T.client == "ptBR" then
	L.UI_Outdated = "A sua versão da Tukui está desactualizada. Pode baixar a versão mais recente no site www.tukui.org"
	L.UI_Talent_Change_Bug = "A blizzard bug has occured which is preventing you from changing your talents, this happen when you've inspected someone. Unfortunatly there is nothing we can do in this WoW Patch to fix it, please reload your ui and try again."
	
	L.chat_INSTANCE_CHAT = "I"
	L.chat_INSTANCE_CHAT_LEADER = "IL"
	L.chat_BN_WHISPER_GET = "De"
	L.chat_GUILD_GET = "G"
	L.chat_OFFICER_GET = "O"
	L.chat_PARTY_GET = "P"
	L.chat_PARTY_GUIDE_GET = "P"
	L.chat_PARTY_LEADER_GET = "P"
	L.chat_RAID_GET = "R"
	L.chat_RAID_LEADER_GET = "R"
	L.chat_RAID_WARNING_GET = "W"
	L.chat_WHISPER_GET = "De"
	L.chat_FLAG_AFK = "[LDT]"
	L.chat_FLAG_DND = "[NP]"
	L.chat_FLAG_GM = "[GM]"
	L.chat_ERR_FRIEND_ONLINE_SS = "Está agora |cff298F00online|r"
	L.chat_ERR_FRIEND_OFFLINE_S = "Está agora |cffff0000offline|r"

	L.chat_general = "Geral"
	L.chat_trade = "Comércio"
	L.chat_defense = "DefesaLocal"
	L.chat_recrutment = "RecrutamentoDeGuilda"
	L.chat_lfg = "ProcurandoGrupo"

	L.disband = "Dissolvendo o grupo ?"

	L.datatext_notalents ="Sem Talentos"
	L.datatext_download = "Download: "
	L.datatext_bandwidth = "Largura de Banda: "
	L.datatext_guild = "Guilda"
	L.datatext_noguild = "Sem Guilda"
	L.datatext_bags = "Sacos: "
	L.datatext_friends = "Amigos"
	L.datatext_online = "Online: "
	L.datatext_armor = "Armadura"
	L.datatext_earned = "Ganho:"
	L.datatext_spent = "Gasto:"
	L.datatext_deficit = "Défice:"
	L.datatext_profit = "Lucro:"
	L.datatext_timeto = "Tempo para"
	L.datatext_friendlist = "Lista de Amigos:"
	L.datatext_playersp = "pm"
	L.datatext_playerap = "pa"
	L.datatext_playerhaste = "Aceleração"
	L.datatext_dps = "dps"
	L.datatext_hps = "cps"
	L.datatext_playerarp = "arp"
	L.datatext_session = "Sessão: "
	L.datatext_character = "Personagem: "
	L.datatext_server = "Servidor: "
	L.datatext_totalgold = "Total: "
	L.datatext_savedraid = "Raide(s) Salva(s)"
	L.datatext_currency = "Moeda de troca:"
	L.datatext_fps = " fps & "
	L.datatext_ms = " ms"
	L.datatext_playercrit = " crítico"
	L.datatext_playerheal = " Cura"
	L.datatext_avoidancebreakdown = "Evasão Total"
	L.datatext_lvl = "lvl"
	L.datatext_boss = "Chefe"
	L.datatext_miss = "Falha"
	L.datatext_dodge = "Esquiva"
	L.datatext_block = "Bloqueio"
	L.datatext_parry = "Aparo"
	L.datatext_playeravd = "avd: "
	L.datatext_servertime = "Hora do Servidor: "
	L.datatext_localtime = "Hora Local: "
	L.datatext_mitigation = "Mitigação por Nível: "
	L.datatext_healing = "Cura: "
	L.datatext_damage = "Dano: "
	L.datatext_honor = "Honra: "
	L.datatext_killingblows = "Golpes Fatais: "
	L.datatext_ttstatsfor = "Status para "
	L.datatext_ttkillingblows = "Golpes Fatais:"
	L.datatext_tthonorkills = "Mortes Honrosas:"
	L.datatext_ttdeaths = "Mortes:"
	L.datatext_tthonorgain = "Honra Ganha:"
	L.datatext_ttdmgdone = "Dano Causado:"
	L.datatext_tthealdone = "Cura Causada:"
	L.datatext_basesassaulted = "Bases Assaltadas:"
	L.datatext_basesdefended = "Bases Defendidas:"
	L.datatext_towersassaulted = "Torres Assaltadas:"
	L.datatext_towersdefended = "Torres Defendidas:"
	L.datatext_flagscaptured = "Bandeiras Capturadas:"
	L.datatext_flagsreturned = "Bandeiras Recuperadas:"
	L.datatext_graveyardsassaulted = "Cemitérios Assaltados:"
	L.datatext_graveyardsdefended = "Cemitérios Defendidos:"
	L.datatext_demolishersdestroyed = "Demolidores Destruídos:"
	L.datatext_gatesdestroyed = "Portões Destruídos:"
	L.datatext_totalmemusage = "Memória Total Usada:"
	L.datatext_control = "Controlado por:"
	L.datatext_cta_allunavailable = "Não foi possivel obter informações acerca do Chamado às armas."
	L.datatext_cta_nodungeons = "Nenhuma masmorra está oferecendo um Chamado às armas."
	L.datatext_carts_controlled = "Carrinhos Controlados:"
	L.datatext_victory_points = "Pontos de Vitória:"
	L.datatext_orb_possessions = "Posse de Orbes:"

	L.Slots = {
		[1] = {1, "Cabeça", 1000},
		[2] = {3, "Ombros", 1000},
		[3] = {5, "Torso", 1000},
		[4] = {6, "Cintura", 1000},
		[5] = {9, "Pulsos", 1000},
		[6] = {10, "Mãos", 1000},
		[7] = {7, "Pernas", 1000},
		[8] = {8, "Pés", 1000},
		[9] = {16, "Mão Principal", 1000},
		[10] = {17, "Mão Secundária", 1000},
		[11] = {18, "Longo Alcance", 1000}
	}

	L.popup_disableui = "A Tukui nao funciona nesta resolução, deseja desactivar a Tukui? (Cancele se quizer tentar outra resolução)."
	L.popup_install = "Primeira vez a correr a tukui V13 neste personagem. Deve recarregar a sua UI para defenir as Barras de Acção, Variáveis e os Quadros de conversação."
	L.popup_reset = "Aviso! Isto vai redefinir tudo para a Tukui padrão. Deseja proceder?" 
	L.popup_2raidactive = "2 layouts de raide estão activos, por favor selecione um."
	L.popup_install_yes = "Yeah! (recomendado!)"
	L.popup_install_no = "Não, não vale nada"
	L.popup_reset_yes = "Yeah bébé!"
	L.popup_reset_no = "Não, senão vou chorar para os forums!"
	L.popup_fix_ab = "Algo está errado com a sua barra de acção. Deseja recarregar a UI para corrigir o problema?"

	L.merchant_repairnomoney = "Não tem dinheiro suficiente para reparar!"
	L.merchant_repaircost = "Os seus itens foram reparados por"
	L.merchant_trashsell = "O seu lixo foi vendido e voce ganhou"

	L.goldabbrev = "|cffffd700g|r"
	L.silverabbrev = "|cffc7c7cfs|r"
	L.copperabbrev = "|cffeda55fc|r"

	L.error_noerror = "Nenhum erro ainda detectado."

	L.unitframes_ouf_offline = "Offline"
	L.unitframes_ouf_dead = "Morto"
	L.unitframes_ouf_ghost = "Fantasma"
	L.unitframes_ouf_lowmana = "Mana baixa"
	L.unitframes_ouf_threattext = "Ameaça no alvo actual:"
	L.unitframes_ouf_offlinedps = "Offline"
	L.unitframes_ouf_deaddps = "|cffff0000[MORTO]|r"
	L.unitframes_ouf_ghostheal = "FANTASMA"
	L.unitframes_ouf_deadheal = "MORTO"
	L.unitframes_ouf_gohawk = "VAI FALCÃO"
	L.unitframes_ouf_goviper = "VAI VÍBORA"
	L.unitframes_disconnected = "D/C"
	L.unitframes_ouf_wrathspell = "Ira"
	L.unitframes_ouf_starfirespell = "Estrela de Fogo"

	L.tooltip_count = "Contar"

	L.bags_noslots = "Impossivel comprar mais espaços!"
	L.bags_costs = "Custa: %.2f gold"
	L.bags_buyslots = "Comprar novo espaço com / compra de Sacos sim"
	L.bags_openbank = "Precisa de abrir o seu banco primeiro."
	L.bags_sort = "Organiza os seus sacos ou o seu banco, se aberto."
	L.bags_stack = "Enche as pilhas incompletas nos seus sacos ou banco, se aberto."
	L.bags_buybankslot = "Comprar espaço no banco. (Precisa ter o banco aberto)"
	L.bags_search = "Procurar"
	L.bags_sortmenu = "Organizar"
	L.bags_sortspecial = "Organizar Especial"
	L.bags_stackmenu = "Empilhar"
	L.bags_stackspecial = "Empilhar Especial"
	L.bags_showbags = "Mostrar Sacos"
	L.bags_sortingbags = "Organização acabada."
	L.bags_nothingsort= "Nada para Organizar."
	L.bags_bids = "Usando os Sacos: "
	L.bags_stackend = "Reempilhamento acabado."
	L.bags_rightclick_search = "Clique direito do rato para procurar."

	L.loot_fish = "Saque de Peixe"
	L.loot_empty = "Espaço vazio"
	L.loot_randomplayer = "Random Player"
	L.loot_self = "Self Loot"

	L.chat_invalidtarget = "Alvo inválido"

	L.mount_wintergrasp = "Wintergrasp"

	L.core_autoinv_enable = "Convite automático Ligado: Convidar"
	L.core_autoinv_enable_c = "Convite automático Ligado: "
	L.core_autoinv_disable = "Convite automático Desligado"
	L.core_wf_unlock = "Desbloquear o Quadro de Objectivos"
	L.core_wf_lock = "Bloquear o Quadro de Objectivos"
	L.core_welcome1 = "Bem vindo à versão |cffC495DDTukui|r,"
	L.core_welcome2 = "Escreva |cff00FFFF/uihelp|r para mais informação ou visite o site www.tukui.org"

	L.core_uihelp1 = "|cff00ff00Comandos Gerais Slash|r"
	L.core_uihelp2 = "|cffFF0000/moveui|r - Desbloqueia e permite mover os elementos pelo ecrã."
	L.core_uihelp3 = "|cffFF0000/rl|r - Recarrega a sua Interface."
	L.core_uihelp4 = "|cffFF0000/gm|r - Manda bilhete ao GM ou mostra a ajuda do WoW em jogo."
	L.core_uihelp5 = "|cffFF0000/frame|r - Detecta o nome do quadro no qual o seu rato se encontra (muito Útil para editores de lua)"
	L.core_uihelp6 = "|cffFF0000/heal|r - Activa o layout de curandeiro na raide."
	L.core_uihelp7 = "|cffFF0000/dps|r - Activa o layout de Dps/Tank na raide."
	L.core_uihelp8 = "|cffFF0000/bags|r - Para organização, compra de espaço no banco ou empilhamento de itens nos seus sacos."
	L.core_uihelp9 = "|cffFF0000/resetui|r - Redefine para a Tukui padrão."
	L.core_uihelp10 = "|cffFF0000/rd|r - Raide Dissolvida."
	L.core_uihelp11 = "|cffFF0000/ainv|r - Activa o convite automático via palavra chave por sussurro. voce pode defenir a sua própria palavra chave escrevendo `/ainv myword`"
	L.core_uihelp100 = "(Scroll para cima para mais comandos ...)"

	L.symbol_CLEAR = "Limpar"
	L.symbol_SKULL = "Caveira"
	L.symbol_CROSS = "Cruz"
	L.symbol_SQUARE = "Quadrado"
	L.symbol_MOON = "Lua"
	L.symbol_TRIANGLE = "Triangulo"
	L.symbol_DIAMOND = "Diamante"
	L.symbol_CIRCLE = "Circulo"
	L.symbol_STAR = "Estrela"

	L.bind_combat = "Você não pode fazer ligações em combate"
	L.bind_saved = "Todas as Ligações foram salvas."
	L.bind_discard = "Todas as novas Ligações foram descartadas."
	L.bind_instruct = "Passe com o rato por qualquer botão de acção para fazer uma Ligação. Pressione escape ou Clique Direito do rato para limpar os botões de acção correntes."
	L.bind_save = "Salvar Ligações"
	L.bind_discardbind = "Descartar Ligações"

	L.hunter_unhappy = "O seu ajudante está triste!"
	L.hunter_content = "O seu ajudante está contente!"
	L.hunter_happy = "O seu ajudante está feliz!"

	L.move_tooltip = "Mover a Tooltip"
	L.move_minimap = "Mover o Minimapa"
	L.move_watchframe = "Mover as Missões"
	L.move_gmframe = "Mover o quadro do bilhete ao GM"
	L.move_buffs = "Mover os buffs do jogador"
	L.move_debuffs = "Mover os debuffs do jogador"
	L.move_shapeshift = "Mover a barra de Mudança de Forma/Totems"
	L.move_achievements = "Mover o quadro das Conquistas"
	L.move_roll = "Mover o quadro de Roll do Saque"
	L.move_vehicle = "Mover o quadro do Veiculo"
	L.move_extrabutton = "Botão Extra"

	-------------------------------------------------
	-- INSTALLATION
	-------------------------------------------------

	-- headers
	L.install_header_1 = "Bem Vindo"
	L.install_header_2 = "1. Essenciais"
	L.install_header_3 = "2. Quadros de Unidades"
	L.install_header_4 = "3. Opções"
	L.install_header_5 = "4. Coisas que devia saber!"
	L.install_header_6 = "5. Comandos"
	L.install_header_7 = "6. Acabado"
	L.install_header_8 = "1. Definições essenciais"
	L.install_header_9 = "2. Social"
	L.install_header_10= "3. Quadros"
	L.install_header_11= "4. Sucesso!"

	-- install
	L.install_init_line_1 = "Obrigado por escolher a Tukui!"
	L.install_init_line_2 = "Você será guiado em passos simples pelo processo de instalação. Em cada passo, você pode decidir se quer ou nao aplicar ou saltar as definições apresentadas."
	L.install_init_line_3 = "Também lhe é dada a possibilidade de ver um curto tutorial sobre algumas das opções da Tukui."
	L.install_init_line_4 = "Pressione o botão 'Tutorial' para ser guiado através desta pequena introdução ou pressione 'Instalar' para saltar este passo."

	-- tutorial 1
	L.tutorial_step_1_line_1 = "Este rápido tutorial mostrará algumas das opções da Tukui."
	L.tutorial_step_1_line_2 = "Primeiro, as coisas essenciais que voce deve saber antes de puder jogar com esta UI."
	L.tutorial_step_1_line_3 = "O instalador é parcialmente especifico para cada personagem. Enquando algumas das definições serão para toda a conta, você precisa correr o instaldor para cada personagem novo que use a Tukui. O instalador aparece automaticamente em todos os personagens que logem pela primeira vez na Tukui. Também, a opção pode ser encontrada em /Tukui/config/config.lua para utilizadores 'Power' ou escrevendo /tukui em jogo para utilizadores 'Friendly'."
	L.tutorial_step_1_line_4 = "Um utilizador 'Power' é um utilizador que tem a capacidade de usar opções avançadas (ex: editar Lua) que estão além das capacidades de um utilizador normal. Um utilizador 'Friendly' é um utilizador normal e não tem necessariamente que ter a capacidade de programar. É então recomendado que usem a nossa ferramenta de configuração em jogo (/tukui) para definições que queiram ver mostradas na Tukui."

	-- tutorial 2
	L.tutorial_step_2_line_1 = "A Tukui inclui uma versão integrada do oUF (oUFTukui) criada pelo Haste. Isto trata de todos os quadros de unidades, buffs e debuffs, e dos elementos específicos de cada class."
	L.tutorial_step_2_line_2 = "Você pode visitar o site wowinterface.com e procurar pelo oUF para obter mais informações acerca desta ferramenta."
	L.tutorial_step_2_line_3 = "Se você joga como curandeiro ou líder de raide, poderá ser útil activar os quadros de unidades de curandeiros. Estes mostram mais informações acerca da sua raide (/heal). Um dps ou um tank deverá usar o nosso simples mostrador de raide (/dps). Se você não quiser usar nenhuma das duas opções ou usar outro mostrador de raide, pode desactivar esta opção no gestor de addons no ecrã da lista de personagens."  
	L.tutorial_step_2_line_4 = "Para mudar a posição do quadro de unidade facilmente, escreva /moveui."

	-- tutorial 3
	L.tutorial_step_3_line_1 = "A Tukui é simplesmente a UI da Blizzard redesenhada. Nada mais, nada menos. Quase todas as opções que você vê na UI padrão estão disponíveis através da Tukui. As únicas opções não disponíveis através da UI padrão são algumas opções não visíveis no ecrã, como por exemplo a venda automática dos itens cinzentos quando visitando um vendedor ou, outro exemplo, a organização automática dos itens nos sacos."
	L.tutorial_step_3_line_2 = "Nem todos os utilizadores gostam de coisas como medidores de DPS, mods de Chefe, medidores de ameaça, etc, nós julgamos que é a melhor coisa a se fazer. A Tukui foi feita para que trabalha-se para todas as classes, papeis, especializações, estilos de jogo, gosto dos utilizadores, etc. É por isso que a Tukui é uma das mais populares UIs do momento. Encaixa em todos os estilos de jogo e é extremamente editável. Também é desenhada para ser um bom começo para todos os que querem fazer a sua própria UI sem depender de Addons. Desde 2009 muitos utilizadores começaram a usar a Tukui como base das suas próprias UIs. Dê uma olhadela aos Pacotes Editados no nosso Site!"
	L.tutorial_step_3_line_3 = "Os utilizadores podem querer visitar a nossa secção de 'mods externos' no nosso site ou visitando o site www.wowinterface.com para instalar opções ou mods adicionais."
	L.tutorial_step_3_line_4 = ""

	-- tutorial 4
	L.tutorial_step_4_line_1 = "Para configurar quantas barras você quer, passe com o rato à esquerda ou à direita no fundo da barra inferior de acção. Faça o mesmo na da direita, de cima para baixo. Para copiar texto do quadro de conversação, clique no botão que aparece no canto direito do quadro de conversação quando passa com o rato por cima."
	L.tutorial_step_4_line_2 = "O rebordo do minimapa muda de cor. Fica verde quando você recebe correio novo, fica vermelho quando tem um novo convite no calendário e fica laranja quando tem os dois."
	L.tutorial_step_4_line_3 = "Você pode usar o Clique esquerdo do rato em 80% dos 'datatext' para mostrar vários painéis da Blizzard. O 'datatext' dos Amigos e da Guilda possuem também opções de Clique direito do rato."  
	L.tutorial_step_4_line_4 = "Existem alguns menus suspensos disponíveis. Clicar no botão direito do rato no botão [X] (Fechar) do Saco abrirá um menu suspenso para mostrar os Sacos, Organizar itens, Organizar o Porta-Chaves, etc. Clicar no botão do centro do rato no minimapa mostrará o micro menu."

	-- tutorial 5
	L.tutorial_step_5_line_1 = " Finalmente, a Tukui inclui comandos slash muito úteis. Em baixo está uma lista." 
	L.tutorial_step_5_line_2 = "/moveui permite mover muitos quadros para qualquer sitio do ecrã. /enable e /disable são usados para rapidamente activar e desactivar addons. /rl recarrega a UI. /heal activa os quadros de raide para o modo curandeiro. /dps activa os quadros de raide para o modo dps/tank."
	L.tutorial_step_5_line_3 = "/tt permite sussurrar ao seu alvo. /rc inicia um 'verificador de prontidão'. /rd dissolve um grupo ou uma raide. /bags mostra algumas opções disponíveis via linha de comandos. /ainv activa o autoinvite a quem o pedir via sussurro. (/ainv off) para desactivar."
	L.tutorial_step_5_line_4 = "/gm mostra/oculta o quadro de ajuda. /install, /resetui or /tutorial carrega este instalador. /frame mostra o nome do quadro por baixo do cursor com informação adicional."

	-- tutorial 6
	L.tutorial_step_6_line_1 = "O tutorial está completo. Você pode escolher revê-lo a qualquer altura escrevendo /tutorial." 
	L.tutorial_step_6_line_2 = "Nós sugerimos que você de uma olhada pelo config/config.lua ou escrevendo /tukui para configurar a UI às suas necessidades."
	L.tutorial_step_6_line_3 = "Você pode agora continuar a instalação da UI caso esta não esteja acabada ou se quiser restabelecer a UI padrão!"
	L.tutorial_step_6_line_4 = ""

	-- install step 1
	L.install_step_1_line_1 = "Estes passos aplicarão as definições corretas para a Tukui."
	L.install_step_1_line_2 = "O primeiro passo aplica as definições essenciais." 
	L.install_step_1_line_3 = "Isto é |cffff0000recomendado|r para qualquer utilizador, a não ser que queira aplicar apenas uma parte especifica das definições."
	L.install_step_1_line_4 = "Clique 'Continuar' para aplicar as definições, ou clique 'Saltar' se desejar saltar este passo."

	-- install step 2
	L.install_step_2_line_0 = "Foi encontrado outro addon de conversação. Vamos ignorar este passo. Por favor pressione Saltar para continuar a instalação." 
	L.install_step_2_line_1 = "O segundo passo aplica as definições corretas de conversação."
	L.install_step_2_line_2 = "Se você é um novo utilizador, este passo é recomendado. Se você é um utilizador antigo, poderá querer saltar este passo."
	L.install_step_2_line_3 = " É normal que a fonte de Conversação apareça muito grande após aplicar estas definições. Voltará ao normal quando acabar a instalação."
	L.install_step_2_line_4 = "Clique 'Continuar' para aplicar as definições, ou clique 'Saltar' se desejar saltar este passo."

	-- install step 3
	L.install_step_3_line_1 = "O terceiro e passo final aplica as posições padrão para os quadros." 
	L.install_step_3_line_2 = "Este passo é |cffff0000recomendado|r para qualquer novo utilizador."
	L.install_step_3_line_3 = ""
	L.install_step_3_line_4 = "Clique 'Continuar' para aplicar as definições, ou clique 'Saltar' se desejar saltar este passo." 

	-- install step 4
	L.install_step_4_line_1 = "Installation is complete. Instalação Completada."
	L.install_step_4_line_2 = "Please click the 'Finish' button to reload the UI. Por favor clique 'Acabar' para recarregar a UI."
	L.install_step_4_line_3 = ""
	L.install_step_4_line_4 = "Desfrute da Tukui! Visite o nosso site www.tukui.org!"

	-- buttons
	L.install_button_tutorial = "Tutorial"
	L.install_button_install = "Instalar"
	L.install_button_next = "Seguinte"
	L.install_button_skip = "Saltar"
	L.install_button_continue = "Continuar"
	L.install_button_finish = "Acabar"
	L.install_button_close = "Fechar"
end