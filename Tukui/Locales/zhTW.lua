local T, C, L = select(2, ...):unpack()

if (GetLocale() ~= "zhTW") then
	return
end

------------------------------------------------
L.ChatFrames = {} -- Data Text Locales
------------------------------------------------

L.ChatFrames.LocalDefense = "本地防務"
L.ChatFrames.GuildRecruitment = "公會招募"
L.ChatFrames.LookingForGroup = "尋求組隊"

------------------------------------------------
L.DataText = {} -- Data Text Locales
------------------------------------------------

L.DataText.AvoidanceBreakdown = "Avoidance Breakdown"
L.DataText.Level = "Lvl"
L.DataText.Boss = "首領"
L.DataText.Miss = "未命中"
L.DataText.Dodge = "閃躲"
L.DataText.Block = "格檔"
L.DataText.Parry = "招架"
L.DataText.Avoidance = "迴避"
L.DataText.AvoidanceShort = "Avd: "
L.DataText.Memory = "記憶體"
L.DataText.Hit = "命中"
L.DataText.Power = "Power"
L.DataText.Mastery = "精通"
L.DataText.Crit = "致命一擊"
L.DataText.Regen = "法力恢復"
L.DataText.Versatility = "臨機應變"
L.DataText.Leech = "汲取"
L.DataText.Multistrike = "雙擊"
L.DataText.Session = "Session: "
L.DataText.Earned = "收入:"
L.DataText.Spent = "支出:"
L.DataText.Deficit = "赤字:"
L.DataText.Profit = "盈餘:"
L.DataText.Character = "角色: "
L.DataText.Server = "伺服器: "
L.DataText.Gold = "金幣"
L.DataText.TotalGold = "總共: "
L.DataText.GoldShort = "|cffffd700g|r"
L.DataText.SilverShort = "|cffc7c7cfs|r"
L.DataText.CopperShort = "|cffeda55fc|r"
L.DataText.Talents = "天賦"
L.DataText.NoTalent = "無天賦"
L.DataText.Download = "下載: "
L.DataText.Bandwidth = "頻寬: "
L.DataText.Guild = "公會"
L.DataText.NoGuild = "無公會"
L.DataText.Bags = "背包"
L.DataText.BagSlots = "背包剩餘"
L.DataText.Friends = "好友"
L.DataText.Online = "線上: "
L.DataText.Armor = "護甲"
L.DataText.Durability = "耐久度"
L.DataText.TimeTo = "Time to"
L.DataText.FriendsList = "好友列表:"
L.DataText.Spell = "SP"
L.DataText.AttackPower = "AP"
L.DataText.Haste = "加速"
L.DataText.DPS = "DPS"
L.DataText.HPS = "HPS"
L.DataText.Session = "Session: "
L.DataText.Character = "角色: "
L.DataText.Server = "伺服器: "
L.DataText.Total = "總共: "
L.DataText.SavedRaid = "Saved Raid(s)"
L.DataText.Currency = "貨幣"
L.DataText.FPS = " FPS & "
L.DataText.MS = " MS"
L.DataText.FPSAndMS = "FPS & MS"
L.DataText.Critical = " 致命一擊"
L.DataText.Heal = " Heal"
L.DataText.Time = "Time"
L.DataText.ServerTime = "伺服器時間: "
L.DataText.LocalTime = "本地時間: "
L.DataText.Mitigation = "Mitigation By Level: "
L.DataText.Healing = "Healing: "
L.DataText.Damage = "Damage: "
L.DataText.Honor = "榮譽: "
L.DataText.KillingBlow = "擊殺: "
L.DataText.StatsFor = "Stats for "
L.DataText.HonorableKill = "榮譽擊殺:"
L.DataText.Death = "死亡:"
L.DataText.HonorGained = "獲得榮譽:"
L.DataText.DamageDone = "Damage Done:"
L.DataText.HealingDone = "Healing Done:"
L.DataText.BaseAssault = "基地突襲:"
L.DataText.BaseDefend = "基地防禦:"
L.DataText.TowerAssault = "哨塔突襲:"
L.DataText.TowerDefend = "哨塔防禦:"
L.DataText.FlagCapture = "占領旗幟:"
L.DataText.FlagReturn = "交還旗幟:"
L.DataText.GraveyardAssault = "墓地突襲:"
L.DataText.GraveyardDefend = "墓地防禦:"
L.DataText.DemolisherDestroy = "石毀車摧毀:"
L.DataText.GateDestroy = "大門摧毀:"
L.DataText.TotalMemory = "總共使用記憶體:"
L.DataText.ControlBy = "控制方:"
L.DataText.CallToArms = "戰鬥的號角" 
L.DataText.ArmError = "無法獲取戰鬥的號角"
L.DataText.NoDungeonArm = "目前沒有地城獎勵"
L.DataText.CartControl = "推車:"
L.DataText.VictoryPts = "勝利點數:"
L.DataText.OrbPossession = "異能球:"
L.DataText.Slots = {
	[1] = {1, "頭部", 1000},
	[2] = {3, "肩部", 1000},
	[3] = {5, "胸部", 1000},
	[4] = {6, "腰部", 1000},
	[5] = {9, "手腕", 1000},
	[6] = {10, "手", 1000},
	[7] = {7, "腿步", 1000},
	[8] = {8, "腳", 1000},
	[9] = {16, "主手", 1000},
	[10] = {17, "副手", 1000},
	[11] = {18, "遠程", 1000}
}

------------------------------------------------
L.Tooltips = {} -- Tooltips Locales
------------------------------------------------

L.Tooltips.MoveAnchor = "移動滑鼠提示"

------------------------------------------------
L.UnitFrames = {} -- Unit Frames Locales
------------------------------------------------

L.UnitFrames.Ghost = "Ghost"
L.UnitFrames.Wrath = "Wrath"
L.UnitFrames.Starfire = "Starfire"

------------------------------------------------
L.ActionBars = {} -- Action Bars Locales
------------------------------------------------

L.ActionBars.ArrowLeft = "◄"
L.ActionBars.ArrowRight = "►"
L.ActionBars.ArrowUp = "▲ ▲ ▲ ▲ ▲"
L.ActionBars.ArrowDown = "▼ ▼ ▼ ▼ ▼"
L.ActionBars.ExtraButton = "額外按鈕"
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
L.ActionBars.MoveStanceBar = "移動姿態列"

------------------------------------------------
L.Minimap = {} -- Minimap Locales
------------------------------------------------

L.Minimap.MoveMinimap = "移動小地圖"

------------------------------------------------
L.Miscellaneous = {} -- Miscellaneous
------------------------------------------------

L.Miscellaneous.Repair = "警告！你需要修裝！"

------------------------------------------------
L.Auras = {} -- Aura Locales
------------------------------------------------

L.Auras.MoveBuffs = "移動增益效果"
L.Auras.MoveDebuffs = "移動減益效果"

------------------------------------------------
L.Install = {} -- Installation of Tukui
------------------------------------------------

L.Install.Tutorial = "教學"
L.Install.Install = "安裝"
L.Install.InstallStep0 = "感謝您Tukui!|n|n我們將透過幾個簡單的步驟引導您完成安裝。每個步驟都可以自行選擇是否套用設定或跳過設定。"
L.Install.InstallStep1 = "第一步：套用基礎必要設定。 |cffff0000我們建議所有的使用者套用本設定|r, 除非你想單獨設定特定部份選項。|n|n點擊「套用」來套用設定，再點擊「下一步」繼續安裝。如果要跳過這個步驟，直接按「下一步」。"
L.Install.InstallStep2 = "第二步：套用正確的聊天設定，我們建議新使用者套用此設定。如果是現有使用者，可以略過這一步。|n|n點擊「套用」來套用設定，再點擊「下一步」繼續安裝。如果要跳過這個步驟，直接按「下一步」。"
L.Install.InstallStep3 = "安裝完成。請點擊「完成」按鈕來重載介面。 享受Tukui吧！拜訪我們：www.tukui.org！"

------------------------------------------------
L.Help = {} -- /tukui help
------------------------------------------------

L.Help.Title = "Tukui命令:"
L.Help.Datatexts = "'|cff00ff00dt|r' or '|cff00ff00datatext|r' : Enable or disable datatext configuration."
L.Help.Install = "'|cff00ff00install|r' or '|cff00ff00reset|r' : 安裝或重置tukui使設定值恢復預設"
L.Help.Config = "'|cff00ff00c|r' or '|cff00ff00config|r' : 顯示設定介面"
L.Help.Move = "'|cff00ff00move|r' or '|cff00ff00moveui|r' : 移動框架"
L.Help.Test = "'|cff00ff00test|r' or '|cff00ff00testui|r' : 測試頭像"

------------------------------------------------
L.Merchant = {} -- Merchant
------------------------------------------------

L.Merchant.NotEnoughMoney = "你沒有足夠的錢修理裝備！"
L.Merchant.RepairCost = "修理裝備花費"
L.Merchant.SoldTrash = "出售垃圾獲得"

------------------------------------------------
L.Version = {} -- Version Check
------------------------------------------------

L.Version.Outdated = "你的tukui版本需要更新。請造訪www.tukui.org取得最新版本。"

------------------------------------------------
L.Others = {} -- Miscellaneous
------------------------------------------------

L.Others.GlobalSettings = "使用全局通用設定"
L.Others.CharSettings = "使用角色專用設定"