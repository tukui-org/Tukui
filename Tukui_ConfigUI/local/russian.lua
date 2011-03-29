if GetLocale() == "ruRU" then

	-- update needed msg
	TukuiL.option_update = "Необходимо обновить Tukui_ConfigUI чтобы настройки соответствовали последним изменениям Tukui, пожалуйста посетите www.tukui.org" -- CHANGES

	-- general
	TukuiL.option_general = "Общее"
	TukuiL.option_general_uiscale = "Автоматически масштабировать интерфейс"
	TukuiL.option_general_override = "Использовать раскладку для высокого разрешения при низком разрешении"
	TukuiL.option_general_multisample = "Защищать конфигурацию мультисемплинга (ровные края шириной 1 пиксель)"
	TukuiL.option_general_customuiscale = "Масштаб интерфейса (если автомасштабирование отключено)"
	TukuiL.option_general_backdropcolor = "Установить изначальный цвет фона панелей"
	TukuiL.option_general_bordercolor = "Установить изначальный цвет окантовки панелей"		
 
	-- nameplate
	TukuiL.option_nameplates = "Индикаторы здоровья"
	TukuiL.option_nameplates_enable = "Включить индикаторы здоровья"
	TukuiL.option_nameplates_enhancethreat = "Включить поддержку угрозы, зависит от вашей роли"
	TukuiL.option_nameplates_showhealth = "Показывать здоровье на индикаторе"
	TukuiL.option_nameplates_combat = "Отображать индикаторы противников только в бою"
	TukuiL.option_nameplates_goodcolor = "Хороший цвет, высокий уровень угрозы у танка и низкий у дпс/хила" -- CHANGES
	TukuiL.option_nameplates_badcolor = "Плохой цвет, срыв агро дпс или хилом/низкий уровень угрозы у танка" -- CHANGES
	TukuiL.option_nameplates_transitioncolor = "Изменять цвет при потере/наборе угрозы" -- changes
 
	-- merchant
	TukuiL.option_merchant = "Торговля"
	TukuiL.option_merchant_autosell = "Автоматически продавать серые предметы"
	TukuiL.option_merchant_autorepair = "Автоматический ремонт"
	TukuiL.option_merchant_sellmisc = "Продажа определенных (не серых) вещей автоматически"
 
	-- bags
	TukuiL.option_bags = "Сумки"
	TukuiL.option_bags_enable = "Включить единую сумку"
 
	-- datatext
	TukuiL.option_datatext = "Текст панелей"
	TukuiL.option_datatext_24h = "24-часовой формат времени"
	TukuiL.option_datatext_localtime = "Использовать локальное время вместо серверного"
	TukuiL.option_datatext_bg = "Включить статистику поля боя"
	TukuiL.option_datatext_hps = "ИВС"
	TukuiL.option_datatext_guild = "Гильдия"
	TukuiL.option_datatext_arp = "Рейтинг пробивания брони"
	TukuiL.option_datatext_mem = "Память"
	TukuiL.option_datatext_bags = "Сумки"
	TukuiL.option_datatext_fontsize = "Размер шрифта текста"
	TukuiL.option_datatext_fps_ms = "Задержка и К/С"
	TukuiL.option_datatext_armor = "Броня"
	TukuiL.option_datatext_avd = "Уворот"
	TukuiL.option_datatext_power = "Сила"
	TukuiL.option_datatext_haste = "Скорость"
	TukuiL.option_datatext_friend = "Друзья"
	TukuiL.option_datatext_time = "Время"
	TukuiL.option_datatext_gold = "Золото"
	TukuiL.option_datatext_dps = "УВС"
	TukuiL.option_datatext_crit = "Крит"
	TukuiL.option_datatext_dur = "Прочность"
	TukuiL.option_datatext_currency = "Валюты (0 для отключения)"
	TukuiL.option_datatext_micromenu = "Микроменю (0 для отключения)"
	TukuiL.option_datatext_hit = "Меткость (0 для отключения)"
	TukuiL.option_datatext_mastery = "Mастерство (0 для отключения)"	
 
	-- unit frames
	TukuiL.option_unitframes_unitframes = "Рамки юнитов"
	TukuiL.option_unitframes_combatfeedback = "Текст боя на рамках игрока и цели"
	TukuiL.option_unitframes_runebar = "Включить панель рун для Рыцарей Смерти"
	TukuiL.option_unitframes_auratimer = "Включить таймер аур"
	TukuiL.option_unitframes_totembar = "Включить панель тотемов для Шаманов"
	TukuiL.option_unitframes_totalhpmp = "Отображать общее здоровье/энергию"
	TukuiL.option_unitframes_playerparty = "Показывать себя в группе"
	TukuiL.option_unitframes_aurawatch = "Включить показ рейдовых аур PVE (только Grid)"
	TukuiL.option_unitframes_castbar = "Включить полосу применения"
	TukuiL.option_unitframes_targetaura = "Включить ауры цели"
	TukuiL.option_unitframes_saveperchar = "Сохранять позицию рамок юнитов для персонажа"
	TukuiL.option_unitframes_playeraggro = "Включить отображение собственной угрозы"
	TukuiL.option_unitframes_smooth = "Плавное изменение полос"
	TukuiL.option_unitframes_portrait = "Включить портреты игрока и цели"
	TukuiL.option_unitframes_enable = "Включить рамки юнитов Tukui"
	TukuiL.option_unitframes_enemypower = "Включить отображение энергии только для врагов"
	TukuiL.option_unitframes_gridonly = "Включить режим Grid only для целителей"
	TukuiL.option_unitframes_healcomm = "Включить healcomm"
	TukuiL.option_unitframes_focusdebuff = "Включить дебаффы фокуса"
	TukuiL.option_unitframes_raidaggro = "Включить отображение угрозы на рамках группы/рейда"
	TukuiL.option_unitframes_boss = "Включить рамки боссов"
	TukuiL.option_unitframes_enemyhostilitycolor = "Окрашивать полосу здоровья врага по враждебности"
	TukuiL.option_unitframes_hpvertical = "Отображать полосу здоровья вертикально для Grid"
	TukuiL.option_unitframes_symbol = "Показывать метки на рамках группы/рейда"
	TukuiL.option_unitframes_threatbar = "Включить полосу угрозы"
	TukuiL.option_unitframes_enablerange = "Менять прозрачность группы/рейда в зависимости от расстояния"
	TukuiL.option_unitframes_focus = "Включить цель фокуса"
	TukuiL.option_unitframes_latency = "Показывать задержку на полосе применения"
	TukuiL.option_unitframes_icon = "Показывать иконки на полосе применения"
	TukuiL.option_unitframes_playeraura = "Включить альтернативный режим аур игрока"
	TukuiL.option_unitframes_aurascale = "Масштаб текста аур"
	TukuiL.option_unitframes_gridscale = "Масштаб Grid"
	TukuiL.option_unitframes_manahigh = "Верхний порог маны(для Охотников)"
	TukuiL.option_unitframes_manalow = "Нижний порог маны"
	TukuiL.option_unitframes_range = "Прозрачность рамок группы/рейда вне зоны досягаемости"
	TukuiL.option_unitframes_maintank = "Включить отображение главного танка"
	TukuiL.option_unitframes_mainassist = "Включить отображение наводчика"
	TukuiL.option_unitframes_unicolor = "Включить унифицированную цветовую схему (серая полоса здоровья)"
	TukuiL.option_unitframes_totdebuffs = "Включить дебаффы цели цели (Высокое разрешение)"
	TukuiL.option_unitframes_classbar = "Включить классовую панель"
	TukuiL.option_unitframes_weakenedsoulbar = "Включить уведомление Ослабленной души (для Приста)"
	TukuiL.option_unitframes_onlyselfdebuffs = "Отображать только ваши дебаффы на цели"
	TukuiL.option_unitframes_focus = "Включить цель фокуса"
	TukuiL.option_unitframes_bordercolor = "Установить изначальный цвет окантовки рамок"
 
	-- loot
	TukuiL.option_loot = "Добыча"
	TukuiL.option_loot_enableloot = "Включить окно добычи"
	TukuiL.option_loot_autogreed = "Автоматически нажимать НУЖНО для зеленых предметов на 80 уровне"
	TukuiL.option_loot_enableroll = "Включить окно розыгрыша"
 
	-- map
	TukuiL.option_map = "Карта"
	TukuiL.option_map_enable = "Включить карту"
 
	-- invite
	TukuiL.option_invite = "Приглашения"
	TukuiL.option_invite_autoinvite = "Автопринятие приглашений от друзей и гильдии"
 
	-- tooltip
	TukuiL.option_tooltip = "Подксказка"
	TukuiL.option_tooltip_enable = "Включить подсказку"
	TukuiL.option_tooltip_hidecombat = "Прятать подсказку в бою"
	TukuiL.option_tooltip_hidebutton = "Прятать подсказку для кнопок панели действий"
	TukuiL.option_tooltip_hideuf = "Прятать подсказку для рамок юнитов"
	TukuiL.option_tooltip_cursor = "Подсказка под указателем мыши"
 
	-- others
	TukuiL.option_others = "Прочее"
	TukuiL.option_others_bg = "Автовоскрешение на поле боя"
 
	-- reminder
	TukuiL.option_reminder = "Предупреждения аур"
	TukuiL.option_reminder_enable = "Предупреждать об аурах игрока"
	TukuiL.option_reminder_sound = "Звук предупреждения"
 
	-- error
	TukuiL.option_error = "Сообщения об ошибках"
	TukuiL.option_error_hide = "Прятать сообщения об ошибках посреди экрана"
 
	-- action bar
	TukuiL.option_actionbar = "Панели комманд"
	TukuiL.option_actionbar_hidess = "Прятать панель стоек или тотемов"
	TukuiL.option_actionbar_showgrid = "Всегда показывать сетку на панелях комманд"
	TukuiL.option_actionbar_enable = "Включить панели комманд Tukui"
	TukuiL.option_actionbar_rb = "Показывать правую панель комманд при наведении мыши"
	TukuiL.option_actionbar_hk = "Показывать горячие клавиши на кнопках"
	TukuiL.option_actionbar_ssmo = "Показывать панель стоек или тотемов при наведении мыши"
	TukuiL.option_actionbar_rbn = "Количество панелей комманд снизу (1 или 2)"
	TukuiL.option_actionbar_rn = "Количество панелей комманд справа (1, 2 или 3)"
 	TukuiL.option_actionbar_buttonsize = "Размер кнопок панели действий"
	TukuiL.option_actionbar_buttonspacing = "Промежуток между кнопками панели действий"
	TukuiL.option_actionbar_petbuttonsize = "Размер кнопок панели питомца/облика"
	
	-- quest watch frame
	TukuiL.option_quest = "Задания"
	TukuiL.option_quest_movable = "Включить возможность переноса списока задач"
 
	-- arena
	TukuiL.option_arena = "Арена"
	TukuiL.option_arena_st = "Отслеживание вражеский заклинаний на арене"
	TukuiL.option_arena_uf = "Отображать рамки юнитов на арене"
	
	-- pvp
	TukuiL.option_pvp = "Pvp"
	TukuiL.option_pvp_ii = "Включить иконки прерываний"
 
	-- cooldowns
	TukuiL.option_cooldown = "Перезарядки"
	TukuiL.option_cooldown_enable = "Отображать значения перезарядок на кнопках"
	TukuiL.option_cooldown_th = "Окрашивать значения перезарядок красным на Х сек"
 
	-- chat
	TukuiL.option_chat = "Общение"
	TukuiL.option_chat_enable = "Включить чат Tukui"
	TukuiL.option_chat_whispersound = "Проигрывать звук при получении личного сообщения"
	TukuiL.option_chat_background = "Включить фон окна чата"
	
	-- buff
	TukuiL.option_auras = "Auras"
	TukuiL.option_auras_player = "Enable Tukui Buff/Debuff Frames"
 
	-- buttons
	TukuiL.option_button_reset = "Сброс"
	TukuiL.option_button_load = "Применить"
	TukuiL.option_button_close = "Закрыть"
	TukuiL.option_setsavedsetttings = "Установить настройки для персонажа"
	TukuiL.option_resetchar = "Вы уверены, что хотите сбросить все настройки для персонажа до настроек по умолчанию?"
	TukuiL.option_resetall = "Вы уверены, что хотите сбросить все настройки?"
	TukuiL.option_perchar = "Вы уверены что хотите сменить режим сохранения настроек?"
	TukuiL.option_makeselection = "Вы должны сделать выбор прежде чем продолжите конфигурацию"	
end