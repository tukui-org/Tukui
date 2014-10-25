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
			["Name"] = "UI比例",
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
			["Name"] = "启用快捷列",
			["Desc"] = "Derp",
		},
		
		["HotKey"] = {
			["Name"] = "快捷键",
			["Desc"] = "在快捷键上显示名字",
		},
		
		["Macro"] = {
			["Name"] = "宏键",
			["Desc"] = "在快捷键显示宏的名字",
		},
		
		["ShapeShift"] = {
			["Name"] = "姿态列",
			["Desc"] = "使用tukui姿态列",
		},
		
		["Pet"] = {
			["Name"] = "宠物",
			["Desc"] = "使用tukui风格宠物控制列",
		},
		
		["NormalButtonSize"] = {
			["Name"] = "按钮大小",
			["Desc"] = "设置一个快捷键的大小",
		},
		
		["PetButtonSize"] = {
			["Name"] = "宠物按钮的大小",
			["Desc"] = "设置一个宠物的动作栏按钮的大小",
		},
		
		["ButtonSpacing"] = {
			["Name"] = "按键间隔",
			["Desc"] = "设置每个之间快捷键的间距",
		},
		
		["OwnShadowDanceBar"] = {
			["Name"] = "暗影之舞",
			["Desc"] = "使用独立的暗影之舞快捷列代替主快捷列",
		},
		
		["OwnMetamorphosisBar"] = {
			["Name"] = "恶魔变形",
			["Desc"] = "使用独立的恶魔变形快捷列代替主快捷列",
		},
		
		["OwnWarriorStanceBar"] = {
			["Name"] = "战士姿态",
			["Desc"] = "每一种姿态都使用一个独立的快捷列",
		},
		
		["HideBackdrop"] = {
			["Name"] = "隐藏背景",
			["Desc"] = "不显示快捷列的背景",
		},
		
		["Font"] = {
			["Name"] = "快捷列字体",
			["Desc"] = "设置快捷列字体",
		},
	},
	
	["Auras"] = {
		["Enable"] = {
			["Name"] = "启用光环",
			["Desc"] = "Derp",
		},
		
		["Consolidate"] = {
			["Name"] = "光环合并 ",
			["Desc"] = "合并团队buff",
		},
		
		["Flash"] = {
			["Name"] = "光环闪烁",
			["Desc"] = "光环即将消失时闪烁"..PerformanceSlight,
		},
		
		["ClassicTimer"] = {
			["Name"] = "经典的计时器",
			["Desc"] = "在光环下方显示倒数文字",
		},
		
	    ["HideBuffs"] = {
			["Name"] = "隐藏增益",
			["Desc"] = "不显示角色增益效果",
		},
		
		["HideDebuffs"] = {
			["Name"] = "隐藏减益",
			["Desc"] = "隐藏角色减益效果",
		},
		
		["Animation"] = {
			["Name"] = "动画",
			["Desc"] = "显示光环动画"..PerformanceSlight,
		},
		
		["BuffsPerRow"] = {
			["Name"] = "每行增益效果",
			["Desc"] = "设置每一行显示的数量",
		},
		
		["Font"] = {
			["Name"] = "光环字体",
			["Desc"] = "设置光环字体",
		},
	},
	
	["Bags"] = {
		["Enable"] = {
			["Name"] = "启用背包",
			["Desc"] = "Derp",
		},
		
		["ButtonSize"] = {
			["Name"] = "格子尺寸",
			["Desc"] = "设置背包格子大小",
		},
		
		["Spacing"] = {
			["Name"] = "间距",
			["Desc"] = "设置背包之间的间距",
		},
		
		["ItemsPerRow"] = {
			["Name"] = "每行物品",
			["Desc"] = "设置背包每一行格子的数量",
		},
		
		["PulseNewItem"] = {
			["Name"] = "高亮提示",
			["Desc"] = "高亮动画提示背包新获的物品",
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
			["Name"] = "战利品框架",
			["Desc"] = "建立一个独立掉落记录框",
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
			["Name"] = "鼠标拖动",
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
			["Name"] = "项目颜色",
			["Desc"] = "设置信息项目名的颜色"..RestoreDefault,
		},
		
		["ValueColor"] = {
			["Name"] = "数值颜色",
			["Desc"] = "设置信息数值颜色"..RestoreDefault,
		},
		
		["Font"] = {
			["Name"] = "信息字体",
			["Desc"] = "设置信息条的字体",
		},
	},
	
	["Merchant"] = {
		["AutoSellGrays"] = {
			["Name"] = "自动出售灰色的",
			["Desc"] = "自动出售灰色物品",
		},
		
		["SellMisc"] = {
			["Name"] = "自动卖杂物",
			["Desc"] = "自动售不是灰色物品但没用杂物",
		},
		
		["AutoRepair"] = {
			["Name"] = "自动修理",
			["Desc"] = "自动修理装备",
		},
		
		["UseGuildRepair"] = {
			["Name"] = "使用工会修理",
			["Desc"] = "启用自动修复时，使用公会银行资金",
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
			["Name"] = "使用经验条",
			["Desc"] = "使用经验条",
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
			["Name"] = "启动姓名条",
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
			["Name"] = "施放条高度",
			["Desc"] = "设置姓名板施放条高度",
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
			["Name"] = "显示血条文字",
			["Desc"] = "添加在姓名板显示血条文字",
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
			["Name"] = "治疗提示",
			["Desc"] = "显示即将到来的治疗与吸收",
		},
		
		["ShowPlayer"] = {
			["Name"] = "显示玩家",
			["Desc"] = "在小队框架上显示自己",
		},
		
		["ShowHealthText"] = {
			["Name"] = "血量文字",
			["Desc"] = "显示血量具体数值",
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
			["Name"] = "血量材质条",
			["Desc"] = "设置血量材质条",
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
		
		["MaxUnitPerColumn"] = {
			["Name"] = "每列团队成员",
			["Desc"] = "修改每列团队成员的最大数",
		},
		
		["HealBar"] = {
			["Name"] = "治疗提示",
			["Desc"] = "显示即将到来的治疗与吸收",
		},
		
		["AuraWatch"] = {
			["Name"] = "光环监视",
			["Desc"] = "在团队框架的角落显示光环",
		},
		
		["AuraWatchTimers"] = {
			["Name"] = "光环计时器",
			["Desc"] = "显示debuff的秒数",
		},
		
		["DebuffWatch"] = {
			["Name"] = "减益效果",
			["Desc"] = "以大图标在团队框架上显示重要的debuff",
		},
		
		["RangeAlpha"] = {
			["Name"] = "超出范围ALPH",
			["Desc"] = "设定超出范围的透明度",
		},
		
		["ShowRessurection"] = {
			["Name"] = "显示复活的图标",
			["Desc"] = "显示玩家复活的图标",
		},
		
		["ShowHealthText"] = {
			["Name"] = "血量文字",
			["Desc"] = "显示血量的具体数值",
		},
		
		["VerticalHealth"] = {
			["Name"] = "纵向血量",
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
			["Desc"] = "启用鼠标指向tooltip",
		},
		
		["HideOnUnitFrames"] = {
			["Name"] = "隐藏头像提示",
			["Desc"] = "指向头像框架不显示Tooltips",
		},
		
		["UnitHealthText"] = {
			["Name"] = "显示血量数值",
			["Desc"] = "在Tooltips上显示血量数值",
		},
		
		["ShowSpec"] = {
			["Name"] = "专精",
			["Desc"] = "显示玩家的专精",
		},
		
		["HealthFont"] = {
			["Name"] = "血量条字体",
			["Desc"] = "设置Tooltips血量数值的字体",
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
			["Name"] = "Enemy Target Hostile Color",
			["Desc"] = "Enemy target health bar will be colored by hostility instead of by class color",
		},
		
		["Portrait"] = {
			["Name"] = "人物头像",
			["Desc"] = "显示玩家与目标人物头像",
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
			["Desc"] = "建立施法图标",
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
			["Name"] = "治疗提示",
			["Desc"] = "显示即将到来的治疗与吸收",
		},
		
		["TotemBar"] = {
			["Name"] = "图腾条",
			["Desc"] = "启用tukui风格图腾",
		},
		
		["ComboBar"] = {
			["Name"] = "连击点",
			["Desc"] = "使用连击条",
		},
		
		["AnticipationBar"] = {
			["Name"] = "盗贼的连击点",
			["Desc"] = "显示盗贼的连击点",
		},
		
		["SerendipityBar"] = {
			["Name"] = "妙手回春",
			["Desc"] = "显示牧师的妙手回春的层数",
		},
		
		["OnlySelfDebuffs"] = {
			["Name"] = "只显示我造成的减益",
			["Desc"] = "在目标框架上只显示我造成的减益效果",
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
			["Name"] = "Boss Frames",
			["Desc"] = "Display boss frames while doing pve",
		},
		
		["TargetAuras"] = {
			["Name"] = "目标光环",
			["Desc"] = "显示目标减益与玩家增益。",
		},
		
		["FocusAuras"] = {
			["Name"] = "焦点",
			["Desc"] = "显示焦点的deff和debuff",
		},
		
		["FocusTargetAuras"] = {
			["Name"] = "焦点目标",
			["Desc"] = "显示焦点目标的deff和debuff",
		},
		
		["ArenaAuras"] = {
			["Name"] = "竞技场框架光环",
			["Desc"] = "在竞技场框架显示debuff",
		},
		
		["BossAuras"] = {
			["Name"] = "boss框架光环",
			["Desc"] = "在BOSS框架上显示buff",
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