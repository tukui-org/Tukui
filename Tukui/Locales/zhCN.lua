local T, C, L = select(2, ...):unpack()

if (GetLocale() ~= "zhCN") then
	return
end

------------------------------------------------
L.ChatFrames = {} -- Data Text Locales
------------------------------------------------

L.ChatFrames.LocalDefense = "本地防务"
L.ChatFrames.GuildRecruitment = "公会招募"
L.ChatFrames.LookingForGroup = "寻求组队"

------------------------------------------------
L.DataText = {} -- Data Text Locales
------------------------------------------------

L.DataText.AvoidanceBreakdown = "Avoidance Breakdown"
L.DataText.Level = "等级"
L.DataText.Boss = "Boss"
L.DataText.Miss = "未命中"
L.DataText.Dodge = "躲闪"
L.DataText.Block = "格挡"
L.DataText.Parry = "闪避"
L.DataText.Avoidance = "避免"
L.DataText.AvoidanceShort = "闪避: "
L.DataText.Memory = "内存"
L.DataText.Hit = "命中"
L.DataText.Power = "力量"
L.DataText.Mastery = "精通"
L.DataText.Crit = "暴击"
L.DataText.Regen = "恢复"
L.DataText.Versatility = "全能"
L.DataText.Leech = "吸血"
L.DataText.Multistrike = "溅射"
L.DataText.Session = "会话: "
L.DataText.Earned = "赚得:"
L.DataText.Spent = "花费:"
L.DataText.Deficit = "赤字:"
L.DataText.Profit = "利润:"
L.DataText.Character = "角色: "
L.DataText.Server = "服务器: "
L.DataText.Gold = "金币"
L.DataText.TotalGold = "总计: "
L.DataText.GoldShort = "|cffffd700g|r"
L.DataText.SilverShort = "|cffc7c7cfs|r"
L.DataText.CopperShort = "|cffeda55fc|r"
L.DataText.Talents = "天赋"
L.DataText.NoTalent = "没有天赋"
L.DataText.Download = "下载: "
L.DataText.Bandwidth = "带宽: "
L.DataText.Guild = "工会"
L.DataText.NoGuild = "没有公会"
L.DataText.Bags = "包裹"
L.DataText.BagSlots = "包裹剩余"
L.DataText.Friends = "朋友"
L.DataText.Online = "在线: "
L.DataText.Armor = "护甲"
L.DataText.Durability = "耐久"
L.DataText.TimeTo = "时间"
L.DataText.FriendsList = "好友列表:"
L.DataText.Spell = "SP"
L.DataText.AttackPower = "AP"
L.DataText.Haste = "匆忙"
L.DataText.DPS = "DPS"
L.DataText.HPS = "HPS"
L.DataText.Session = "会话: "
L.DataText.Character = "特征: "
L.DataText.Server = "服务器: "
L.DataText.Total = "总计 "
L.DataText.SavedRaid = "保存进度"
L.DataText.Currency = "货币"
L.DataText.FPS = " FPS & "
L.DataText.MS = " MS"
L.DataText.FPSAndMS = "FPS & MS"
L.DataText.Critical = " 暴击"
L.DataText.Heal = " 治疗"
L.DataText.Time = "时间"
L.DataText.ServerTime = "服务器时间: "
L.DataText.LocalTime = "本地时间: "
L.DataText.Mitigation = "等级免伤: "
L.DataText.Healing = "治疗: "
L.DataText.Damage = "攻击: "
L.DataText.Honor = "荣誉: "
L.DataText.KillingBlow = "击杀: "
L.DataText.StatsFor = "统计数据 "
L.DataText.HonorableKill = "荣誉击杀:"
L.DataText.Death = "死亡:"
L.DataText.HonorGained = "获得的荣誉:"
L.DataText.DamageDone = "伤害的效果"
L.DataText.HealingDone = "治疗效果:"
L.DataText.BaseAssault = "基地袭击:"
L.DataText.BaseDefend = "基地防御:"
L.DataText.TowerAssault = "哨塔的攻击:"
L.DataText.TowerDefend = "哨塔:"
L.DataText.FlagCapture = "旗子捕获:"
L.DataText.FlagReturn = "旗帜返回:"
L.DataText.GraveyardAssault = "墓地被突击:"
L.DataText.GraveyardDefend = "墓地防御:"
L.DataText.DemolisherDestroy = "伐木机破坏:"
L.DataText.GateDestroy = "门的破坏:"
L.DataText.TotalMemory = "总的内存使用情况:"
L.DataText.ControlBy = "控制的:"
L.DataText.CallToArms = "召唤" 
L.DataText.ArmError = "无法召唤信息."
L.DataText.NoDungeonArm = "目前没有地下城召唤信息."
L.DataText.CartControl = "载具:"
L.DataText.VictoryPts = "胜利点:"
L.DataText.OrbPossession = "宝珠财物:"
L.DataText.Slots = {
	[1] = {1, "头", 1000},
	[2] = {3, "肩", 1000},
	[3] = {5, "胸部", 1000},
	[4] = {6, "腰", 1000},
	[5] = {9, "手腕", 1000},
	[6] = {10, "手", 1000},
	[7] = {7, "腿", 1000},
	[8] = {8, "脚", 1000},
	[9] = {16, "主手", 1000},
	[10] = {17, "副手", 1000},
	[11] = {18, "远程", 1000}
}

------------------------------------------------
L.Tooltips = {} -- Tooltips Locales
------------------------------------------------

L.Tooltips.MoveAnchor = "移动鼠标提示"

------------------------------------------------
L.UnitFrames = {} -- Unit Frames Locales
------------------------------------------------

L.UnitFrames.Ghost = "灵魂"
L.UnitFrames.Wrath = "愤怒"
L.UnitFrames.Starfire = "星火"

------------------------------------------------
L.ActionBars = {} -- Action Bars Locales
------------------------------------------------

L.ActionBars.ArrowLeft = "◄"
L.ActionBars.ArrowRight = "►"
L.ActionBars.ArrowUp = "▲ ▲ ▲ ▲ ▲"
L.ActionBars.ArrowDown = "▼ ▼ ▼ ▼ ▼"
L.ActionBars.ExtraButton = "额外的按钮"
L.ActionBars.CenterBar = "底部中心按钮"
L.ActionBars.ActionButton1 = "主菜单: 底部中心的快捷键 1"
L.ActionBars.ActionButton2 = "主菜单: 底部中心的快捷键 2"
L.ActionBars.ActionButton3 = "主菜单: 底部中心的快捷键 3"
L.ActionBars.ActionButton4 = "主菜单: 底部中心的快捷键 4"
L.ActionBars.ActionButton5 = "主菜单: 底部中心的快捷键 5"
L.ActionBars.ActionButton6 = "主菜单: 底部中心的快捷键 6"
L.ActionBars.ActionButton7 = "主菜单: 底部中心的快捷键 7"
L.ActionBars.ActionButton8 = "主菜单: 底部中心的快捷键 8"
L.ActionBars.ActionButton9 = "主菜单: 底部中心的快捷键 9"
L.ActionBars.ActionButton10 = "主菜单: 底部中心的快捷键 10"
L.ActionBars.ActionButton11 = "主菜单: 底部中心的快捷键 11"
L.ActionBars.ActionButton12 = "主菜单: 底部中心的快捷键 12"
L.ActionBars.MultiActionBar1Button1 = "左下角的快捷键 6"
L.ActionBars.MultiActionBar1Button2 = "左下角的快捷键 5"
L.ActionBars.MultiActionBar1Button3 = "左下角的快捷键 4"
L.ActionBars.MultiActionBar1Button4 = "左下角的快捷键 3"
L.ActionBars.MultiActionBar1Button5 = "左下角的快捷键 2"
L.ActionBars.MultiActionBar1Button6 = "左下角的快捷键 1"
L.ActionBars.MultiActionBar1Button7 = "绑定左下角的快捷键 6"
L.ActionBars.MultiActionBar1Button8 = "绑定左下角的快捷键 5"
L.ActionBars.MultiActionBar1Button9 = "绑定左下角的快捷键 4"
L.ActionBars.MultiActionBar1Button10 = "绑定左下角的快捷键 3"
L.ActionBars.MultiActionBar1Button11 = "绑定左下角的快捷键 2"
L.ActionBars.MultiActionBar1Button12 = "绑定左下角的快捷键 1"
L.ActionBars.MultiActionBar2Button1 = "右下角的快捷键 1"
L.ActionBars.MultiActionBar2Button2 = "右下角的快捷键 2"
L.ActionBars.MultiActionBar2Button3 = "右下角的快捷键 3"
L.ActionBars.MultiActionBar2Button4 = "右下角的快捷键 4"
L.ActionBars.MultiActionBar2Button5 = "右下角的快捷键 5"
L.ActionBars.MultiActionBar2Button6 = "右下角的快捷键 6"
L.ActionBars.MultiActionBar2Button7 = "右下角的快捷键1"
L.ActionBars.MultiActionBar2Button8 = "右下角的快捷键2"
L.ActionBars.MultiActionBar2Button9 = "右下角的快捷键3"
L.ActionBars.MultiActionBar2Button10 = "绑定右下角的快捷键4"
L.ActionBars.MultiActionBar2Button11 = "绑定右下角的快捷键5"
L.ActionBars.MultiActionBar2Button12 = "绑定右下角的快捷键6"
L.ActionBars.MultiActionBar4Button1 = "绑定中间的快捷键1"
L.ActionBars.MultiActionBar4Button2 = "绑定中间的快捷键2"
L.ActionBars.MultiActionBar4Button3 = "绑定中间的快捷键3"
L.ActionBars.MultiActionBar4Button4 = "绑定中间的快捷键4"
L.ActionBars.MultiActionBar4Button5 = "绑定中间的快捷键5"
L.ActionBars.MultiActionBar4Button6 = "绑定中间的快捷键6"
L.ActionBars.MultiActionBar4Button7 = "绑定中间的快捷键7"
L.ActionBars.MultiActionBar4Button8 = "绑定中间的快捷键8"
L.ActionBars.MultiActionBar4Button9 = "绑定中间的快捷键9"
L.ActionBars.MultiActionBar4Button10 = "绑定中间的快捷键10"
L.ActionBars.MultiActionBar4Button11 = "绑定中间的快捷键11"
L.ActionBars.MultiActionBar4Button12 = "绑定中间的快捷键12"
L.ActionBars.MoveStanceBar = "移动姿态栏"

------------------------------------------------
L.Minimap = {} -- Minimap Locales
------------------------------------------------

L.Minimap.MoveMinimap = "移动迷你地图"

------------------------------------------------
L.Miscellaneous = {} -- Miscellaneous
------------------------------------------------

L.Miscellaneous.Repair = "警告！你需要修复一下装备！"

------------------------------------------------
L.Auras = {} -- Aura Locales
------------------------------------------------

L.Auras.MoveBuffs = "移动增益效果"
L.Auras.MoveDebuffs = "移动负面效果"

------------------------------------------------
L.Install = {} -- Installation of Tukui
------------------------------------------------

L.Install.Tutorial = "教程"
L.Install.Install = "安装"
L.Install.InstallStep0 = "感谢您选择Tukui!|n|n您将在以下几步的指导中完成安装.  在接下来的每一步中, 您可以决定是否应用这些设置或者您也可以跳过这些设置. 同时您还有机会观看一段简要教程来了解Tukui的特性. 点击 '教程' 按钮观看介绍指引, 或者点击 '安装' 跳过此步.|n|n|cffff0000注意! 点击 '安装 / 重置', 会立即消除您所有的设置!|r"
L.Install.InstallStep1 = "第一步是设定基本设置. 这一步|cffff0000推荐|r 所有用户, 除非您想要设定某些特定部分的应用设置.|n|n点击 '应用' 来应用设置, 然后点击 '下一步' 继续安装. 如果您希望跳过这一步, 请点击 '下一步'."
L.Install.InstallStep2 = "第二步是设定正确的聊天设置. 如果您是新用户, 推荐您完成本步骤.  如果您已是注册用户, 您可以跳过此步.|n|n点击 '应用' 来设定设置 然后点击 '下一步' 来继续安装. 如果您想跳过此步, 请点击 '下一步'."
L.Install.InstallStep3 = "安装已经完成. 请点击 '完成' 按钮以重新装载界面. 欢迎来到Tukui! 点击 www.tukui.org 访问我们!"

------------------------------------------------
L.Help = {} -- /tukui help
------------------------------------------------

L.Help.Title = "tukui 命令"
L.Help.Datatexts = "'|cff00ff00dt|r' or '|cff00ff00datatext|r' : 启用或禁用数据文本配置."
L.Help.Install = "'|cff00ff00install|r' or '|cff00ff00reset|r' : 安装或重置Tukui来恢复默认设置."
L.Help.Config = "'|cff00ff00c|r' or '|cff00ff00config|r' : 显示的游戏配置窗口."
L.Help.Move = "'|cff00ff00move|r' or '|cff00ff00moveui|r' : 移动框架."
L.Help.Test = "'|cff00ff00test|r' or '|cff00ff00testui|r' : 测试单元框架."

------------------------------------------------
L.Merchant = {} -- Merchant
------------------------------------------------

L.Merchant.NotEnoughMoney = "您没有足够的金钱来修理!"
L.Merchant.RepairCost = "您的物品已经修好了"
L.Merchant.SoldTrash = "您的垃圾物品已出售"

------------------------------------------------
L.Version = {} -- Version Check
------------------------------------------------

L.Version.Outdated = "你的版本的需要更新，你可以从www.tukui.org下载最新版本。"

------------------------------------------------
L.Others = {} -- Miscellaneous
------------------------------------------------

L.Others.GlobalSettings = "Use Global Settings"
L.Others.CharSettings = "Use Character Settings"