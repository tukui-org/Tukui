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
			["Desc"] = "设置自定义UI比例",
		},
		
		["BackdropColor"] = {
			["Name"] = "背景颜色",
			["Desc"] = "决定框架的背景颜色”"..RestoreDefault,
		},
		
		["BorderColor"] = {
			["Name"] = "边框颜色",
			["Desc"] = "决定框架的边框颜色"..RestoreDefault,
		},
		
		["HideShadows"] = {
			["Name"] = "显示或隐藏",
			["Desc"] = "显示或者隐藏tukui框架",
		},
	},
	
	["ActionBars"] = {
		["Enable"] = {
			["Name"] = "启用动作条",
			["Desc"] = "Derp",
		},
		
		["HotKey"] = {
			["Name"] = "快捷键",
			["Desc"] = "在按钮上显示快捷键文字",
		},
		
		["Macro"] = {
			["Name"] = "宏键",
			["Desc"] = "在按钮显示宏",
		},
		
		["ShapeShift"] = {
			["Name"] = "转变",
			["Desc"] = "使用tukui风格皮肤",
		},
		
		["Pet"] = {
			["Name"] = "宠物",
			["Desc"] = "使用tukui风格宠物皮肤",
		},
		
		["NormalButtonSize"] = {
			["Name"] = "按钮大小",
			["Desc"] = "设置一个动作栏按钮的大小",
		},
		
		["PetButtonSize"] = {
			["Name"] = "宠物按钮的大小",
			["Desc"] = "设置一个宠物的动作栏按钮的大小",
		},
		
		["ButtonSpacing"] = {
			["Name"] = "按钮的间隔",
			["Desc"] = "设置操作栏按钮之间的间距",
		},
		
		["OwnShadowDanceBar"] = {
			["Name"] = "暗影之舞条",
			["Desc"] = "使用自己的暗影之舞动作条",
		},
		
		["OwnMetamorphosisBar"] = {
			["Name"] = "幻化条",
			["Desc"] = "使用幻化条",
		},
		
		["OwnWarriorStanceBar"] = {
			["Name"] = "战士姿态",
			["Desc"] = "启用战士姿态动作条",
		},
		
		["HideBackdrop"] = {
			["Name"] = "隐藏背景",
			["Desc"] = "禁止在动作条的背景下",
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
			["Name"] = "光环增强 ",
			["Desc"] = "启用统一光环",
		},
		
		["Flash"] = {
			["Name"] = "闪光光环",
			["Desc"] = "闪光的光环时，持续时间较低"..PerformanceSlight,
		},
		
		["ClassicTimer"] = {
			["Name"] = "经典的计时器",
			["Desc"] = "使用下面的光环文本定时器",
		},
		
		["HideBuffs"] = {
			["Name"] = "隐藏增益效果",
			["Desc"] = "隐藏角色增益效果",
		},
		
		["HideDebuffs"] = {
			["Name"] = "隐藏负面效果",
			["Desc"] = "隐藏角色负面效果",
		},
		
		["Animation"] = {
			["Name"] = "动画",
			["Desc"] = "显示光环动画"..PerformanceSlight,
		},
		
		["BuffsPerRow"] = {
			["Name"] = "每行增益效果",
			["Desc"] = "创建一个新行数的设置显示每行增益效果",
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
			["Name"] = "插槽尺寸",
			["Desc"] = "设置背包插槽大小",
		},
		
		["Spacing"] = {
			["Name"] = "间距",
			["Desc"] = "设置背包的间距",
		},
		
		["ItemsPerRow"] = {
			["Name"] = "每行物品",
			["Desc"] = "设置多少插槽的每一行上的背包",
		},
		
		["PulseNewItem"] = {
			["Name"] = "闪光的新物品(s)",
			["Desc"] = "在你的包新物品将有一个动画",
		},
		
		["Font"] = {
			["Name"] = "背包字体",
			["Desc"] = "设置背包字体大小",
		},
		
		["BagFilter"] = {
			["Name"] = "使用背包过滤",
			["Desc"] = "清理的时候自动删除您的包没用物品",
			["Default"] = "清理的时候自动删除您的包没用物品",
		},
	},
	
	["Chat"] = {
		["Enable"] = {
			["Name"] = "启用聊天",
			["Desc"] = "Derp",
		},
		
		["WhisperSound"] = {
			["Name"] = "私语声音",
			["Desc"] = "收到私语的时候播放声音",
		},
		
		["LinkColor"] = {
			["Name"] = "URL链接颜色",
			["Desc"] = "设置URL链接显示颜色"..RestoreDefault,
		},
		
		["LinkBrackets"] = {
			["Name"] = "URL链接括号",
			["Desc"] = "包在括号中显示的URL链接",
		},
		
		["LootFrame"] = {
			["Name"] = "战利品框架",
			["Desc"] = "建立一个独立的'掉落'聊天框",
		},
		
		["Background"] = {
			["Name"] = "聊天背景",
			["Desc"] = "创建一个背景聊天框架",
		},
		
		["ChatFont"] = {
			["Name"] = "聊天字体",
			["Desc"] = "设置聊天字体",
		},
		
		["TabFont"] = {
			["Name"] = "聊天标签字体",
			["Desc"] = "设置字体被聊天标签使用",
		},
		
		["ScrollByX"] = {
			["Name"] = "鼠标拖动",
			["Desc"] = "设置行滚动时聊天会跳的数量",
		},
	},
	
	["Cooldowns"] = {
		["Font"] = {
			["Name"] = "冷却时间字体",
			["Desc"] = "设置冷却时间字体",
		},
	},
	
	["DataTexts"] = {
		["Battleground"] = {
			["Name"] = "开启战场",
			["Desc"] = "启动显示战场信息",
		},
		
		["LocalTime"] = {
			["Name"] = "本地时间",
			["Desc"] = "启用本地时间，而不是服务器时间",
		},
		
		["Time24HrFormat"] = {
			["Name"] = "24小时时间格式",
			["Desc"] = "允许设置的时间数据文字24小时格式.",
		},
		
		["NameColor"] = {
			["Name"] = "标签颜色",
			["Desc"] = "设置的数据文本标签的颜色"..RestoreDefault,
		},
		
		["ValueColor"] = {
			["Name"] = "彩色值",
			["Desc"] = "设置颜色为文字数据值"..RestoreDefault,
		},
		
		["Font"] = {
			["Name"] = "数据文本字体",
			["Desc"] = "设置字体要使用的数据文本",
		},
	},
	
	["Merchant"] = {
		["AutoSellGrays"] = {
			["Name"] = "自动出售灰色的",
			["Desc"] = "当访问商人，自动出售灰色物品",
		},
		
		["SellMisc"] = {
			["Name"] = "卖杂项 物品",
			["Desc"] = "自动售没用的东西不属于品质灰色",
		},
		
		["AutoRepair"] = {
			["Name"] = "自动修理",
			["Desc"] = "访问商人的时候自动修理装备",
		},
		
		["UseGuildRepair"] = {
			["Name"] = "使用工会修理",
			["Desc"] = "使用“自动修复”时，使用从公会银行资金",
		},
	},
	
	["Misc"] = {
		["ThreatBarEnable"] = {
			["Name"] = "启动仇恨条",
			["Desc"] = "Derp",
		},
		
		["AltPowerBarEnable"] = {
			["Name"] = "启用按住Alt能量条",
			["Desc"] = "Derp",
		},
		
		["ExperienceEnable"] = {
			["Name"] = "使用经验条",
			["Desc"] = "使在屏幕的左边和右边的两个经验条.",
		},
		
		["ReputationEnable"] = {
			["Name"] = "启用声望条",
			["Desc"] = "使在屏幕的左边和右边的两个名声条.",
		},
		
		["ErrorFilterEnable"] = {
			["Name"] = "启用过滤错误",
			["Desc"] = "过滤掉从UI错误框架消息.",
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
			["Name"] = "非目标测试",
			["Desc"] = "姓名板非目标测试",
		},
		
		["Texture"] = {
			["Name"] = "姓名板材质",
			["Desc"] = "设置姓名板材质",
		},
		
		["Font"] = {
			["Name"] = "姓名板字体",
			["Desc"] = "设置姓名板字体",
		},
	},
	
	["Party"] = {
		["Enable"] = {
			["Name"] = "队友框架",
			["Desc"] = "Derp",
		},
		
		["Portrait"] = {
			["Name"] = "模型",
			["Desc"] = "队友框架显示的模型",
		},
		
		["HealBar"] = {
			["Name"] = "治疗提示",
			["Desc"] = "Display a bar showing incoming heals & absorbs",
		},
		
		["ShowPlayer"] = {
			["Name"] = "显示玩家",
			["Desc"] = "显示自己在框架",
		},
		
		["ShowHealthText"] = {
			["Name"] = "治疗数字",
			["Desc"] = "显示治疗的损失量.",
		},
		
		["Font"] = {
			["Name"] = "团队框名字字体",
			["Desc"] = "设置团队名字的字体",
		},
		
		["HealthFont"] = {
			["Name"] = "治疗团队框体",
			["Desc"] = "设置治疗字体",
		},
		
		["PowerTexture"] = {
			["Name"] = "能量纹理",
			["Desc"] = "设置能量纹理",
		},
		
		["HealthTexture"] = {
			["Name"] = "治疗纹理",
			["Desc"] = "设置治疗纹理",
		},
	},
	
	["Raid"] = {
		["Enable"] = {
			["Name"] = "启用RAID框架",
			["Desc"] = "Derp",
		},
		
		["ShowPets"] = {
			["Name"] = "Show Pets",
			["Desc"] = "Derp",
		},
		
		["MaxUnitPerColumn"] = {
			["Name"] = "Raid members per column",
			["Desc"] = "Change the max number of raid members per column",
		},
		
		["HealBar"] = {
			["Name"] = "治疗",
			["Desc"] = "显示治疗的损失量",
		},
		
		["AuraWatch"] = {
			["Name"] = "光环时间",
			["Desc"] = "计时器显示在RAID框架的的角落",
		},
		
		["AuraWatchTimers"] = {
			["Name"] = "光环计时器",
			["Desc"] = "显示于用户的Debuff关注建立的DEBUFF图标的计时器",
		},
		
		["DebuffWatch"] = {
			["Name"] = "减益效果",
			["Desc"] = "显示在RAID框架的大图标当玩家有重要的debuff",
		},
		
		["RangeAlpha"] = {
			["Name"] = "超出范围ALPH",
			["Desc"] = "设置的单位，超出范围的透明度",
		},
		
		["ShowRessurection"] = {
			["Name"] = "显示复活的图标",
			["Desc"] = "显示玩家复活的图标",
		},
		
		["ShowHealthText"] = {
			["Name"] = "治疗数据",
			["Desc"] = "显示治疗单位的损失量.",
		},
		
		["Font"] = {
			["Name"] = "Raid框架名字字体",
			["Desc"] = "设置RAID框架名字字体",
		},
		
		["HealthFont"] = {
			["Name"] = "Raid框架治疗字体",
			["Desc"] = "设置RAID框架治疗字体",
		},
		
		["PowerTexture"] = {
			["Name"] = "能量纹理",
			["Desc"] = "设置能量条纹理",
		},
		
		["HealthTexture"] = {
			["Name"] = "治疗条纹理",
			["Desc"] = "设置治疗条纹理",
		},
		
		["GroupBy"] = {
			["Name"] = "分组",
			["Desc"] = "自定义raids组进行排序",
		},
	},
	
	["Tooltips"] = {
		["Enable"] = {
			["Name"] = "启用工具提示",
			["Desc"] = "Derp",
		},
		
		["HideOnUnitFrames"] = {
			["Name"] = "隐藏在单元框架",
			["Desc"] = "不要在单位框显示工具提示",
		},
		
		["UnitHealthText"] = {
			["Name"] = "显示治疗文本",
			["Desc"] = "工具提示血条上显示的治疗条",
		},
		
		["ShowSpec"] = {
			["Name"] = "专业等级",
			["Desc"] = "显示玩家专业在提示栏",
		},
		
		["HealthFont"] = {
			["Name"] = "治疗条字体",
			["Desc"] = "设置字体要使用下面的单元工具提示的血条",
		},
		
		["HealthTexture"] = {
			["Name"] = "治疗条纹理",
			["Desc"] = "设置纹理要使用下面的单元工具提示的血条",
		},
	},
	
	["UnitFrames"] = {
		["Enable"] = {
			["Name"] = "启用组框架",
			["Desc"] = "Derp",
		},
		
		["Portrait"] = {
			["Name"] = "启用玩家与目标模型",
			["Desc"] = "启用玩家与目标模型",
		},
		
		["CastBar"] = {
			["Name"] = "施法条",
			["Desc"] = "启用施法条的单位框架",
		},
		
		["UnlinkCastBar"] = {
			["Name"] = "取消施法条",
			["Desc"] = "移动玩家和目标单元框外栏，并允许施法条在屏幕上移动",
		},
		
		["CastBarIcon"] = {
			["Name"] = "施法条图标",
			["Desc"] = "建立施法栏旁边的图标",
		},
		
		["CastBarLatency"] = {
			["Name"] = "施法条延迟",
			["Desc"] = "显示施法条的延迟",
		},
		
		["Smooth"] = {
			["Name"] = "流畅的条",
			["Desc"] = "平滑治疗条的更新"..PerformanceSlight,
		},
		
		["CombatLog"] = {
			["Name"] = "战斗信息反馈",
			["Desc"] = "显示输入的治疗和损坏播放器单元框架",
		},
		
		["WeakBar"] = {
			["Name"] = "虚弱灵魂条",
			["Desc"] = "显示一栏显示的虚弱灵魂的debuff",
		},
		
		["HealBar"] = {
			["Name"] = "正被治疗",
			["Desc"] = "显示栏显示输入的治疗及伤害减伤",
		},
		
		["TotemBar"] = {
			["Name"] = "图腾条",
			["Desc"] = "启用tukui风格图腾",
		},
		
		["AnticipationBar"] = {
			["Name"] = "盗贼隐藏栏",
			["Desc"] = "显示一栏显示盗贼预期点",
		},
		
		["SerendipityBar"] = {
			["Name"] = "牧师机缘栏",
			["Desc"] = "显示一栏显示的牧师机缘巧合叠层",
		},
		
		["OnlySelfDebuffs"] = {
			["Name"] = "显示我只有减益",
			["Desc"] = "只显示我们的减益效果的目标框架",
		},
		
		["DarkTheme"] = {
			["Name"] = "黑暗的主题",
			["Desc"] = "如果启用，单元框架将是一个暗色使用类彩色动力条",
		},
		
		["Arena"] = {
			["Name"] = "Arena Frames",
			["Desc"] = "Display arena opponents when inside a battleground or arena",
		},
		
		["Font"] = {
			["Name"] = "单元框架字体",
			["Desc"] = "设置字体的单元框架",
		},
		
		["PowerTexture"] = {
			["Name"] = "能力栏纹理",
			["Desc"] = "设置能量条纹理",
		},
		
		["HealthTexture"] = {
			["Name"] = "治疗条纹理",
			["Desc"] = "设置治疗条纹理",
		},
	},
}