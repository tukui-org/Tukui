local T, C, L = select(2, ...):unpack()

if (GetLocale() ~= "ruRU") then
	return
end

------------------------------------------------
L.ChatFrames = {} -- Data Text Locales
------------------------------------------------

L.ChatFrames.LocalDefense = "ОборонаЛокальный"
L.ChatFrames.GuildRecruitment = "Гильдии"
L.ChatFrames.LookingForGroup = "ПоискСпутников"

------------------------------------------------
L.DataText = {} -- Data Text Locales
------------------------------------------------

L.DataText.AvoidanceBreakdown = "Распределение"
L.DataText.Level = "ур"
L.DataText.Boss = "Босс"
L.DataText.Miss = "Промах"
L.DataText.Dodge = "Уклонение"
L.DataText.Block = "Блок"
L.DataText.Parry = "Парирование"
L.DataText.Avoidance = "Avoidance"
L.DataText.AvoidanceShort = "Avd: "
L.DataText.Memory = "Память"
L.DataText.Hit = "Точность"
L.DataText.Power = "Мощь"
L.DataText.Mastery = "Искусность"
L.DataText.Crit = "Крит"
L.DataText.Regen = "Восстановление"
L.DataText.Versatility = "Versatility"
L.DataText.Leech = "Вытягивание"
L.DataText.Multistrike = "Мульти-удар"
L.DataText.Session = "Сезон: "
L.DataText.Earned = "Получено:"
L.DataText.Spent = "Потрачено:"
L.DataText.Deficit = "Убыток:"
L.DataText.Profit = "Прибыль:"
L.DataText.Character = "Персонаж: "
L.DataText.Server = "Сервер: "
L.DataText.Gold = "Золото"
L.DataText.TotalGold = "Итог: "
L.DataText.GoldShort = "|cffffd700з|r"
L.DataText.SilverShort = "|cffc7c7cfс|r"
L.DataText.CopperShort = "|cffeda55fм|r"
L.DataText.Talents = "Таланты"
L.DataText.NoTalent = "Нет талантов"
L.DataText.Download = "Загрузка: "
L.DataText.Bandwidth = "Скорость: "
L.DataText.Guild = "Гильдия"
L.DataText.NoGuild = "Не в Гильдии"
L.DataText.Bags = "Сумки"
L.DataText.BagSlots = "Слоты"
L.DataText.Friends = "Друзья"
L.DataText.Online = "В сети: "
L.DataText.Armor = "Броня"
L.DataText.Durability = "Прочность"
L.DataText.TimeTo = "Времени до"
L.DataText.FriendsList = "Список друзей:"
L.DataText.Spell = "МП"
L.DataText.AttackPower = "АП"
L.DataText.Haste = "Скорость"
L.DataText.DPS = "ДПС"
L.DataText.HPS = "ХПС"
L.DataText.Session = "Сеанс: "
L.DataText.Character = "Персонаж: "
L.DataText.Server = "Сервер: "
L.DataText.Total = "Всего: "
L.DataText.SavedRaid = "Сохранено ПОдземелий"
L.DataText.Currency = "Валюта"
L.DataText.FPS = " К/С & "
L.DataText.MS = " МС"
L.DataText.FPSAndMS = "К/С & МС"
L.DataText.Critical = " Критический"
L.DataText.Heal = " Исцелить"
L.DataText.Time = "Время"
L.DataText.ServerTime = "Серверное время: "
L.DataText.LocalTime = "Местное время: "
L.DataText.Mitigation = "Уменьшение по уровню: "
L.DataText.Healing = "Исцеление: "
L.DataText.Damage = "Урон: "
L.DataText.Honor = "Очки чести: "
L.DataText.KillingBlow = "Смерт. удары: "
L.DataText.StatsFor = "Статистика по "
L.DataText.HonorableKill = "Почетные победы:"
L.DataText.Death = "Смерти:"
L.DataText.HonorGained = "Получено чести:"
L.DataText.DamageDone = "Нанесено урона:"
L.DataText.HealingDone = "Исцелено урона:"
L.DataText.BaseAssault = "Штурмы баз:"
L.DataText.BaseDefend = "Оборона баз:"
L.DataText.TowerAssault = "Штурмы башен:"
L.DataText.TowerDefend = "Оборона башен:"
L.DataText.FlagCapture = "Захваты флага:"
L.DataText.FlagReturn = "Возвраты флага:"
L.DataText.GraveyardAssault = "Штурмы кладбищ:"
L.DataText.GraveyardDefend = "Оборона кладбищ:"
L.DataText.DemolisherDestroy = "Разрушителей уничтожено:"
L.DataText.GateDestroy = "Врат разрушено:"
L.DataText.TotalMemory = "Общее использование памяти:"
L.DataText.ControlBy = "Под контролем:"
L.DataText.CallToArms = "Призыв к Оружию" 
L.DataText.ArmError = "Не могу получить информацию Призыва к Оружию."
L.DataText.NoDungeonArm = "Призыва к Оружию на данный момент нет."
L.DataText.CartControl = "Захваты вагонеток:"
L.DataText.VictoryPts = "Очки победы:"
L.DataText.OrbPossession = "Захваты сферы:"
L.DataText.OrbPossession = "Захваты сферы:"
L.DataText.Slots = {
	[1] = {1, "Голова", 1000},
	[2] = {3, "Плечо", 1000},
	[3] = {5, "Грудь", 1000},
	[4] = {6, "Пояс", 1000},
	[5] = {9, "Запястья", 1000},
	[6] = {10, "Кисти рук", 1000},
	[7] = {7, "Ноги", 1000},
	[8] = {8, "Ступни", 1000},
	[9] = {16, "Правая рука", 1000},
	[10] = {17, "Левая рука", 1000},
	[11] = {18, "Оружие дальнего боя", 1000}
}

------------------------------------------------
L.Tooltips = {} -- Tooltips Locales
------------------------------------------------

L.Tooltips.MoveAnchor = "Передвинуть подсказку"

------------------------------------------------
L.UnitFrames = {} -- Unit Frames Locales
------------------------------------------------

L.UnitFrames.Ghost = "Призрак"
L.UnitFrames.Wrath = "Гнев"
L.UnitFrames.Starfire = "Звездный огонь"

------------------------------------------------
L.ActionBars = {} -- Action Bars Locales
------------------------------------------------

L.ActionBars.ArrowLeft = "◄"
L.ActionBars.ArrowRight = "►"
L.ActionBars.ArrowUp = "▲ ▲ ▲ ▲ ▲"
L.ActionBars.ArrowDown = "▼ ▼ ▼ ▼ ▼"
L.ActionBars.ExtraButton = "Доп. кнопки"
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
L.ActionBars.MoveStanceBar = "Передвинуть панель стоек."

------------------------------------------------
L.Minimap = {} -- Minimap Locales
------------------------------------------------

L.Minimap.MoveMinimap = "Передвинуть миникарту"

------------------------------------------------
L.Miscellaneous = {} -- Miscellaneous
------------------------------------------------

L.Miscellaneous.Repair = "Предупреждение! Вам нужно починить свою экипировку как можно скорее!"

------------------------------------------------
L.Auras = {} -- Aura Locales
------------------------------------------------

L.Auras.MoveBuffs = "Передвинуть бафы"
L.Auras.MoveDebuffs = "Передвинуть дебафы"

------------------------------------------------
L.Install = {} -- Installation of Tukui
------------------------------------------------

L.Install.Tutorial = "Введение"
L.Install.Install = "Установка"
L.Install.InstallStep0 = "Спасибо за использование Tukui!|n|nМы поможем Вам с процессом установки с помощью всего нескольких простых шагов.  На каждом шагу Вы можете выбрать, хотите ли Вы применить выбранные настройки или пропустить этот шаг."
L.Install.InstallStep1 = "Первый шаг применяет основные настройки. |cffff0000Рекомендуется|r для любого пользователя, если Вы не собираетесь применить только определенные параметры.|n|nНажмите «Продолжить», чтобы сохранить настройки, или нажмите «Пропустить», если вы хотите пропустить данный шаг."
L.Install.InstallStep2 = "Второй шаг применит настройки для чата. Если вы новый пользователь, этот шаг рекомендуется. Если Вы уже пользовались этим интерфейсом, возможно, Вы захотите пропустить данный шаг.|n|nНажмите «Продолжить» для сохранения настроек или нажмите «Пропустить», чтобы пропустить данный шаг."
L.Install.InstallStep3 = "Установка завершена. Пожалуйста, нажмите «Завершить» для перезагрузки интерфейса. Наслаждайтесь Tukui! Посетите нас на http://www.tukui.org!"

------------------------------------------------
L.Help = {} -- /tukui help
------------------------------------------------

L.Help.Title = "Команды Tukui:"
L.Help.Datatexts = "'|cff00ff00dt|r' или '|cff00ff00datatext|r' : Включить или выключить конфигурацию datatext."
L.Help.Install = "'|cff00ff00install|r' или '|cff00ff00reset|r' : Установить или сбросить Tukui к настройкам по умолчанию."
L.Help.Config = "'|cff00ff00c|r' или '|cff00ff00config|r' : Показать окно настроек."
L.Help.Move = "'|cff00ff00move|r' или '|cff00ff00moveui|r' : Разблокировать и передвинуть элементы интерфейса."
L.Help.Test = "'|cff00ff00test|r' или '|cff00ff00testui|r' : Тест элементов интерфейса."

------------------------------------------------
L.Merchant = {} -- Merchant
------------------------------------------------

L.Merchant.NotEnoughMoney = "Недостаточно денег на починку!"
L.Merchant.RepairCost = "Предметы починены за"
L.Merchant.SoldTrash = "Серые предметы проданы и Вы получили"

------------------------------------------------
L.Version = {} -- Version Check
------------------------------------------------

L.Version.Outdated = "Ваша версия Tukui устарела. Вы можете скачать последнюю версию на www.tukui.org"