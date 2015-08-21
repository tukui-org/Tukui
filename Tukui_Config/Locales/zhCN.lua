local Locale = GetLocale()

-- Chinese Locale
if (Locale ~= "zhCN") then
	return
end

-- Some postfix's for certain controls.
local Performance = "\n|cffFF0000Disabling this may increase performance|r" -- For high CPU options
local PerformanceSlight = "\n|cffFF0000Disabling this may slightly increase performance|r" -- For semi-high CPU options
local RestoreDefault = "\n|cffFFFF00Right-click to restore to default|r" -- For color pickers

TukuiConfig["zhCN"] = {
	["General"] = {
		["AutoScale"] = {
			["Name"] = "自动缩放",
			["Desc"] = "自动检测最佳分辨率",
		},
		
		["UIScale"] = {
			["Name"] = "UI缩放",
			["Desc"] = "自定义UI缩放比例",
		},
		
		["BackdropColor"] = {
			["Name"] = "背景颜色",
			["Desc"] = "设定tukui整体框架的背景颜色”"..RestoreDefault,
		},
		
		["BorderColor"] = {
			["Name"] = "边框颜色",
			["Desc"] = "设定tuikui整体框架的边框颜色"..RestoreDefault,
		},
		
		["HideShadows"] = {
			["Name"] = "隐藏阴影",
			["Desc"] = "在某些tukui框架开启或关闭阴影效果",
		},
	},
	
	["ActionBars"] = {
		["Enable"] = {
			["Name"] = "启用动作条",
			["Desc"] = "Derp",
		},
		
		["HotKey"] = {
			["Name"] = "动作条快捷键",
			["Desc"] = "在动作条上显示快捷键",
		},
		
		["Macro"] = {
			["Name"] = "宏键",
			["Desc"] = "在快捷键显示宏名称",
		},
		
		["ShapeShift"] = {
			["Name"] = "姿态列",
			["Desc"] = "启用tukui姿态列",
		},
		
		["Pet"] = {
			["Name"] = "宠物",
			["Desc"] = "启用tukui风格宠物动作条",
		},
		
		["NormalButtonSize"] = {
			["Name"] = "按钮大小",
			["Desc"] = "设置动作条按钮大小",
		},
		
		["PetButtonSize"] = {
			["Name"] = "宠物按钮的大小",
			["Desc"] = "设置宠物动作条按钮大小",
		},
		
		["ButtonSpacing"] = {
			["Name"] = "按键间距",
			["Desc"] = "设置动作条上按钮的间距",
		},
		
		["OwnShadowDanceBar"] = {
			["Name"] = "暗影之舞",
			["Desc"] = "启用tukui风格暗影之舞动作条",
		},
		
		["OwnMetamorphosisBar"] = {
			["Name"] = "恶魔变形",
			["Desc"] = "启用tukui风格恶魔变形动作条",
		},
		
		["OwnWarriorStanceBar"] = {
			["Name"] = "战士姿态栏",
			["Desc"] = "启用tukui风格姿态栏",
		},
		
		["HideBackdrop"] = {
			["Name"] = "隐藏背景",
			["Desc"] = "隐藏动作条背景",
		},
		
		["Font"] = {
			["Name"] = "动作条字体",
			["Desc"] = "设置动作条字体",
		},
	},
	
	["Auras"] = {
		["Enable"] = {
			["Name"] = "启用光环",
			["Desc"] = "Derp",
		},
		
		["Consolidate"] = {
			["Name"] = "Buff合并 ",
			["Desc"] = "合并右上角团队buff",
		},
		
		["Flash"] = {
			["Name"] = "Buff闪烁",
			["Desc"] = "Buff即将消失时闪烁"..PerformanceSlight,
		},
		
		["ClassicTimer"] = {
			["Name"] = "Buff计时",
			["Desc"] = "在Buff下方显示计时",
		},
		
	    ["HideBuffs"] = {
			["Name"] = "隐藏Buff",
			["Desc"] = "隐藏角色Buff",
		},
		
		["HideDebuffs"] = {
			["Name"] = "隐藏Debuff",
			["Desc"] = "隐藏角色的Debuff",
		},
		
		["Animation"] = {
			["Name"] = "动画",
			["Desc"] = "显示光环动画"..PerformanceSlight,
		},
		
		["BuffsPerRow"] = {
			["Name"] = "Buff显示数量",
			["Desc"] = "设置每一行显示的Buff数量",
		},
		
		["Font"] = {
			["Name"] = "Buff字体",
			["Desc"] = "设置Buff字体",
		},
	},
	
	["Bags"] = {
		["Enable"] = {
			["Name"] = "启用背包",
			["Desc"] = "Derp",
		},
		
		["ButtonSize"] = {
			["Name"] = "背包尺寸",
			["Desc"] = "设置背包格子尺寸",
		},
		
		["Spacing"] = {
			["Name"] = "间距",
			["Desc"] = "设置背包格子之间的间距",
		},
		
		["ItemsPerRow"] = {
			["Name"] = "每行物品",
			["Desc"] = "设置背包每一行格子的数量",
		},
		
		["PulseNewItem"] = {
			["Name"] = "高亮提示",
			["Desc"] = "高亮显示背包新获得物品",
		},
		
		["Font"] = {
			["Name"] = "背包字体",
			["Desc"] = "设置背包字体大小",
		},
		
		["BagFilter"] = {
			["Name"] = "拾取过滤",
			["Desc"] = "拾取物品时自动删除灰色物品",
			["Default"] = "拾取物品时自动删除灰色物品",
		},
	},
	
	["Chat"] = {
		["Enable"] = {
			["Name"] = "启用聊天",
			["Desc"] = "Derp",
		},
		
		["WhisperSound"] = {
			["Name"] = "密语提示",
			["Desc"] = "收到密语的时候播放声音",
		},
		
		["LinkColor"] = {
			["Name"] = "URL链接颜色",
			["Desc"] = "设置URL链接颜色"..RestoreDefault,
		},
		
		["LinkBrackets"] = {
			["Name"] = "URL链接括号",
			["Desc"] = "将URL网址以括号括起",
		},
		
		["LootFrame"] = {
			["Name"] = "拾取框体",
			["Desc"] = "Tukui风格拾取框体",
		},
		
		["Background"] = {
			["Name"] = "聊天背景",
			["Desc"] = "创建一个聊天框背景",
		},
		
		["ChatFont"] = {
			["Name"] = "聊天字体",
			["Desc"] = "设置聊天字体",
		},
		
		["TabFont"] = {
			["Name"] = "聊天标签字体",
			["Desc"] = "设置聊天标签字体",
		},
		
		["ScrollByX"] = {
			["Name"] = "鼠标滚轮",
			["Desc"] = "设置鼠标滚轮滚动时拖动行数",
		},
	},
	
	["Cooldowns"] = {
		["Font"] = {
			["Name"] = "冷却时间字体",
			["Desc"] = "设置冷却计时字体",
		},
	},
	
	["DataTexts"] = {
		["Battleground"] = {
			["Name"] = "开启战场",
			["Desc"] = "显示战场信息",
		},
		
		["LocalTime"] = {
			["Name"] = "本地时间",
			["Desc"] = "启用本地时间，而不是服务器时间",
		},
		
		["Time24HrFormat"] = {
			["Name"] = "24小时制",
			["Desc"] = "以24小时制显示时间.",
		},
		
		["NameColor"] = {
			["Name"] = "字体颜色",
			["Desc"] = "设置信息条上字体颜色"..RestoreDefault,
		},
		
		["ValueColor"] = {
			["Name"] = "数字颜色",
			["Desc"] = "设置条上数字颜色"..RestoreDefault,
		},
		
		["Font"] = {
			["Name"] = "信息条字体",
			["Desc"] = "设置信息条上的字体",
		},
	},
	
	["Merchant"] = {
		["AutoSellGrays"] = {
			["Name"] = "自动出售",
			["Desc"] = "自动出售灰色物品",
		},
		
		["SellMisc"] = {
			["Name"] = "自动售卖",
			["Desc"] = "自动售垃圾",
		},
		
		["AutoRepair"] = {
			["Name"] = "自动修理",
			["Desc"] = "自动修理装备",
		},
		
		["UseGuildRepair"] = {
			["Name"] = "使用工会修理",
			["Desc"] = "启用自动修复时，优先使用公会修理",
		},
	},
	
	["Misc"] = {
		["ThreatBarEnable"] = {
			["Name"] = "启动仇恨条",
			["Desc"] = "Derp",
		},
		
		["AltPowerBarEnable"] = {
			["Name"] = "启用能量条",
			["Desc"] = "Derp",
		},
		
		["ExperienceEnable"] = {
			["Name"] = "启用经验条",
			["Desc"] = "启用经验条",
		},
		
		["ReputationEnable"] = {
			["Name"] = "启用声望条",
			["Desc"] = "启用声望条",
		},
		
		["ErrorFilterEnable"] = {
			["Name"] = "启用过滤错误",
			["Desc"] = "过滤UI错误LUA消息.",
		},
	},
	
	["NamePlates"] = {
		["Enable"] = {
			["Name"] = "启动姓名板",
			["Desc"] = "Derp"..PerformanceSlight,
		},
		
		["Width"] = {
			["Name"] = "设置宽度",
			["Desc"] = "设置姓名板宽度",
		},
		
		["Height"] = {
			["Name"] = "设置高度",
			["Desc"] = "设置姓名板高度",
		},
		
		["CastHeight"] = {
			["Name"] = "施法条高度",
			["Desc"] = "设置姓名板施法条高度",
		},
		
		["Spacing"] = {
			["Name"] = "间距",
			["Desc"] = "设置姓名板间距",
		},
		
		["NonTargetAlpha"] = {
			["Name"] = "非目标淡出",
			["Desc"] = "非当前目标的姓名板透明度",
		},
		
		["Texture"] = {
			["Name"] = "姓名板材质",
			["Desc"] = "设置姓名板材质",
		},
		
		["Font"] = {
			["Name"] = "姓名板字体",
			["Desc"] = "设置姓名板字体",
		},
		
		["HealthText"] = {
			["Name"] = "显示血量数值",
			["Desc"] = "在姓名板上显示血量数值",
		},
		
		["NameTextColor"] = {
			["Name"] = "Color Name Text",
			["Desc"] = "Colors Name Text instead of Statusbars for Party/Raid Members.",
		},
	},
	
	["Party"] = {
		["Enable"] = {
			["Name"] = "小队框架",
			["Desc"] = "Derp",
		},
		
		["Portrait"] = {
			["Name"] = "人物头像",
			["Desc"] = "在小队框架显示人物头像",
		},
		
		["HealBar"] = {
			["Name"] = "治疗预估",
			["Desc"] = "显示治疗预估",
		},
		
		["ShowPlayer"] = {
			["Name"] = "显示玩家",
			["Desc"] = "在小队框架上显示自己",
		},
		
		["ShowHealthText"] = {
			["Name"] = "血量数值",
			["Desc"] = "在小队框架上显示血量数值",
		},
		
		["Font"] = {
			["Name"] = "框架字体",
			["Desc"] = "设置小队框架字体",
		},
		
		["HealthFont"] = {
			["Name"] = "血量字体",
			["Desc"] = "小队框架的血量数值字体",
		},
		
		["PowerTexture"] = {
			["Name"] = "能量条材质",
			["Desc"] = "设置能量条材质",
		},
		
		["HealthTexture"] = {
			["Name"] = "血量条材质",
			["Desc"] = "设置血量条材质",
		},
		
	    ["RangeAlpha"] = {
			["Name"] = "超出范围ALPH",
			["Desc"] = "设定超出范围的透明度",
		},
	},
	
	["Raid"] = {
		["Enable"] = {
			["Name"] = "启用团队框架",
			["Desc"] = "Derp",
		},
		
	    ["ShowPets"] = {
			["Name"] = "显示宠物",
			["Desc"] = "Derp",
		},
		
		["Highlight"] = {
			["Name"] = "边框高亮显示",
			["Desc"] = "边框高亮显示你的目标/焦点目标",
		},
		
		["MaxUnitPerColumn"] = {
			["Name"] = "每列团队成员",
			["Desc"] = "修改每列团队成员的最大数",
		},
		
		["HealBar"] = {
			["Name"] = "治疗预估",
			["Desc"] = "显示治疗预估",
		},
		
		["AuraWatch"] = {
			["Name"] = "buff监视",
			["Desc"] = "在团队框架的角落显示buff",
		},
		
		["AuraWatchTimers"] = {
			["Name"] = "Debuff计时器",
			["Desc"] = "显示debuff剩余时间",
		},
		
		["DebuffWatch"] = {
			["Name"] = "Debuff",
			["Desc"] = "以大图标在团队框架上显示重要的Debuff",
		},
		
		["RangeAlpha"] = {
			["Name"] = "超出范围ALPH",
			["Desc"] = "设定超出范围的透明度",
		},
		
		["ShowRessurection"] = {
			["Name"] = "显示复活图标",
			["Desc"] = "显示正在复活图标",
		},
		
		["ShowHealthText"] = {
			["Name"] = "血量数值",
			["Desc"] = "显示血量的具体数值",
		},
		
		["VerticalHealth"] = {
			["Name"] = "纵向生命条",
			["Desc"] = "纵向显示损失的血量",
		},
		
		["Font"] = {
			["Name"] = "框架字体",
			["Desc"] = "设置团队框架的字体",
		},
		
		["HealthFont"] = {
			["Name"] = "血量字体",
			["Desc"] = "设置团队框架上血量数值的字体",
		},
		
		["PowerTexture"] = {
			["Name"] = "能量条材质",
			["Desc"] = "设置能量条材质",
		},
		
		["HealthTexture"] = {
			["Name"] = "血量材质条",
			["Desc"] = "设置血量条材质",
		},
		
		["GroupBy"] = {
			["Name"] = "分组",
			["Desc"] = "定义团队框架的排序方式",
		},
	},
	
	["Tooltips"] = {
		["Enable"] = {
			["Name"] = "启用鼠标提示",
			["Desc"] = "Derp",
		},
		
			["MouseOver"] = {
			["Name"] = "鼠标指向",
			["Desc"] = "启用鼠标指向",
		},
		
		["HideOnUnitFrames"] = {
			["Name"] = "隐藏头像提示",
			["Desc"] = "指向头像框架不显示鼠标提示框体",
		},
		
		["UnitHealthText"] = {
			["Name"] = "显示血量数值",
			["Desc"] = "在鼠标提示框内显示血量数值",
		},
		
		["ShowSpec"] = {
			["Name"] = "专精",
			["Desc"] = "显示玩家的专精",
		},
		
		["HealthFont"] = {
			["Name"] = "血量条字体",
			["Desc"] = "设置鼠标提示框内血量数值的字体",
		},
		
		["HealthTexture"] = {
			["Name"] = "血量材质条",
			["Desc"] = "设置血量材质条",
		},
	},
	
	["UnitFrames"] = {
		["Enable"] = {
			["Name"] = "启用头像框架",
			["Desc"] = "Derp",
		},
		
		["TargetEnemyHostileColor"] = {
			["Name"] = "敌对目标颜色",
			["Desc"] = "敌对目标头像框体着色",
		},
		
		["Portrait"] = {
			["Name"] = "头像框体",
			["Desc"] = "显示玩家与目标头像框体",
		},
		
		["CastBar"] = {
			["Name"] = "施法条",
			["Desc"] = "启用施法条",
		},
		
		["UnlinkCastBar"] = {
			["Name"] = "解锁施法条",
			["Desc"] = "使施法条独立，不依附玩家与目标框架，并允许施法条在屏幕上移动",
		},
		
		["CastBarIcon"] = {
			["Name"] = "施法条图标",
			["Desc"] = "启用施法图标",
		},
		
		["CastBarLatency"] = {
			["Name"] = "施法条延迟",
			["Desc"] = "显示施法条的延迟",
		},
		
		["Smooth"] = {
			["Name"] = "平滑特效",
			["Desc"] = "使施法条看来更流畅"..PerformanceSlight,
		},
		
		["CombatLog"] = {
			["Name"] = "战斗信息反馈",
			["Desc"] = "在框架上显示受到的治疗和伤害",
		},
		
		["WeakBar"] = {
			["Name"] = "虚弱灵魂条",
			["Desc"] = "显示的虚弱灵魂的debuff",
		},
		
		["HealBar"] = {
			["Name"] = "治疗预估",
			["Desc"] = "显示治疗预估",
		},
		
		["TotemBar"] = {
			["Name"] = "图腾条",
			["Desc"] = "启用tukui风格图腾",
		},
		
		["ComboBar"] = {
			["Name"] = "连击点",
			["Desc"] = "启用连击条",
		},
		
		["AnticipationBar"] = {
			["Name"] = "盗贼的连击点",
			["Desc"] = "显示盗贼的连击点",
		},
		
		["SerendipityBar"] = {
			["Name"] = "妙手回春",
			["Desc"] = "显示妙手回春的层数",
		},
		
		["OnlySelfDebuffs"] = {
			["Name"] = "只显示我释放的Debuff",
			["Desc"] = "在目标框架上只显示我释放的Debuff效果",
		},

		["OnlySelfBuffs"] = {
			["Name"] = "只显示我释放的Buff",
			["Desc"] = "在目标框架上只显示我释放的Buff效果",
		},
		["DarkTheme"] = {
			["Name"] = "黑暗主题",
			["Desc"] = "如果启用,血量条变成暗色而能量条变成职业颜色",
		},
		
			["Threat"] = {
			["Name"] = "仇恨显示",
			["Desc"] = "小队和团队成员的生命条将在获得仇恨时变化",
		},
		
		["Arena"] = {
			["Name"] = "竞技场框架",
			["Desc"] = "在进入战场或竞技场时显示敌对玩家",
		},
		
		["Boss"] = {
			["Name"] = "首领框架",
			["Desc"] = "在PVE环境显示首领框架",
		},
		
		["TargetAuras"] = {
			["Name"] = "目标Buff",
			["Desc"] = "目标头像框架上显示Buff与Debuff",
		},
		
		["FocusAuras"] = {
			["Name"] = "焦点Buff",
			["Desc"] = "显示焦点的Buff和Debuff",
		},
		
		["FocusTargetAuras"] = {
			["Name"] = "焦点目标",
			["Desc"] = "显示焦点目标的Buff和Debuff",
		},
		
		["ArenaAuras"] = {
			["Name"] = "竞技场框架Buff",
			["Desc"] = "在竞技场框架显示Buff和Debuff",
		},
		
		["BossAuras"] = {
			["Name"] = "首领框架光环",
			["Desc"] = "在首领框架上显示buff和debuff",
		},
		
		["AltPowerText"] = {
			["Name"] = "能量条文本",
			["Desc"] = "显示能量条文本数值",
		},
		
		["Font"] = {
			["Name"] = "框架字体",
			["Desc"] = "设置框架文字的字体",
		},
		
		["PowerTexture"] = {
			["Name"] = "能量条材质",
			["Desc"] = "设置能量条的材质",
		},
		
		["HealthTexture"] = {
			["Name"] = "血量条材质",
			["Desc"] = "设置血量条的材质",
		},
			
		["CastTexture"] = {
			["Name"] = "施法条材质",
			["Desc"] = "设置施法条的材质",
		},
	},
}