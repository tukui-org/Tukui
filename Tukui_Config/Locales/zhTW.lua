local Locale = GetLocale()

-- Chinese Locale
if (Locale ~= "zhTW") then
	return
end

-- Some postfix's for certain controls.
local Performance = "\n|cffFF0000Disabling this may increase performance|r" -- For high CPU options
local PerformanceSlight = "\n|cffFF0000Disabling this may slightly increase performance|r" -- For semi-high CPU options
local RestoreDefault = "\n|cffFFFF00Right-click to restore to default|r" -- For color pickers

TukuiConfig["zhTW"] = {
	["General"] = {
		["AutoScale"] = {
			["Name"] = "自動縮放",
			["Desc"] = "自動檢測最佳解析度",
		},
		
		["UIScale"] = {
			["Name"] = "UI縮放",
			["Desc"] = "自定義UI縮放比例",
		},
		
		["BackdropColor"] = {
			["Name"] = "背景顏色",
			["Desc"] = "設定TUKUI整體框架的背景顏色”"..RestoreDefault,
		},
		
		["BorderColor"] = {
			["Name"] = "邊框顏色",
			["Desc"] = "設定TUKUI整體框架的邊框顏色"..RestoreDefault,
		},
		
		["HideShadows"] = {
			["Name"] = "隱藏陰影",
			["Desc"] = "在某些TUKUI框架開啟或關閉陰影效果",
		},
	},
	
	["ActionBars"] = {
		["Enable"] = {
			["Name"] = "啟用快捷列",
			["Desc"] = "Derp",
		},
		
		["EquipBorder"] = {
			["Name"] = "Equipped Item Border",
			["Desc"] = "Display Green Border on Equipped Items",
		},

		["HotKey"] = {
			["Name"] = "快捷鍵",
			["Desc"] = "在快捷鍵上顯示熱鍵名稱",
		},
		
		["Macro"] = {
			["Name"] = "巨集",
			["Desc"] = "在快捷鍵上顯示巨集名稱",
		},
		
		["ShapeShift"] = {
			["Name"] = "姿態列",
			["Desc"] = "使用tukui的姿態列",
		},
		
		["Pet"] = {
			["Name"] = "寵物",
			["Desc"] = "使用tukui風格的寵物控制列",
		},
		["SwitchBarOnStance"] = {
			["Name"] = "姿態關聯快捷列",
			["Desc"] = "使主快捷列隨姿態切換",

		},
		["NormalButtonSize"] = {
			["Name"] = "按鍵大小",
			["Desc"] = "設置一個快捷鍵的大小",
		},
		
		["PetButtonSize"] = {
			["Name"] = "寵物列按鍵的大小",
			["Desc"] = "設置一個寵物控制列按鈕的大小",
		},
		
		["ButtonSpacing"] = {
			["Name"] = "按鍵間距",
			["Desc"] = "設置每個快捷鍵之間的間距",
		},
		
		["OwnShadowDanceBar"] = {
			["Name"] = "暗影之舞",
			["Desc"] = "使用獨立的暗影之舞快捷列代替主快捷列",
		},
		
		["OwnMetamorphosisBar"] = {
			["Name"] = "惡魔化身",
			["Desc"] = "使用獨立的惡魔化身快捷列代替主快捷列",
		},
		
		["OwnWarriorStanceBar"] = {
			["Name"] = "戰士姿態",
			["Desc"] = "每一種姿態都使用一個獨立的快捷列",
		},
		
		["HideBackdrop"] = {
			["Name"] = "隱藏背景",
			["Desc"] = "不顯示快捷列的背景",
		},
		
		["Font"] = {
			["Name"] = "快捷列字體",
			["Desc"] = "設定快捷列的字體",
		},
	},
	
	["Auras"] = {
		["Enable"] = {
			["Name"] = "啟用光環",
			["Desc"] = "Derp",
		},
		
		["Consolidate"] = {
			["Name"] = "光環整合",
			["Desc"] = "合併團隊BUFF",
		},
		
		["Flash"] = {
			["Name"] = "光環閃爍",
			["Desc"] = "光環即將消失時閃爍"..PerformanceSlight,
		},
		
		["ClassicTimer"] = {
			["Name"] = "傳統計時器",
			["Desc"] = "在光環下方顯示倒數文字",
		},
		
		["HideBuffs"] = {
			["Name"] = "隱藏增益",
			["Desc"] = "不顯示角色增益效果",
		},
		
		["HideDebuffs"] = {
			["Name"] = "隱藏減益",
			["Desc"] = "不顯示角色減益效果",
		},
		
		["Animation"] = {
			["Name"] = "動畫",
			["Desc"] = "顯示POP IN動畫"..PerformanceSlight,
		},
		
		["BuffsPerRow"] = {
			["Name"] = "每行數量",
			["Desc"] = "設置每一行顯示的buff數量",
		},
		
		["Font"] = {
			["Name"] = "光環字體",
			["Desc"] = "設置光環字體",
		},
	},
	
	["Bags"] = {
		["Enable"] = {
			["Name"] = "啟用背包",
			["Desc"] = "Derp",
		},
		
		["ButtonSize"] = {
			["Name"] = "格子大小",
			["Desc"] = "設置每個背包格子的大小",
		},
		
		["Spacing"] = {
			["Name"] = "間距",
			["Desc"] = "設置每個背包格子之間的間距",
		},
		
		["ItemsPerRow"] = {
			["Name"] = "每行物品",
			["Desc"] = "設置整合背包每一行的格子數量",
		},
		
		["PulseNewItem"] = {
			["Name"] = "高亮提示",
			["Desc"] = "高亮動畫提示背包裡新獲得的物品",
		},
		
		["Font"] = {
			["Name"] = "背包字體",
			["Desc"] = "設定背包字體的大小",
		},
		
		["BagFilter"] = {
			["Name"] = "拾取過濾",
			["Desc"] = "拾取物品時自動刪除灰色物品",
			["Default"] = "拾取物品時自動刪除灰色物品",
		},
	},
	
	["Chat"] = {
		["Enable"] = {
			["Name"] = "啟用聊天",
			["Desc"] = "Derp",
		},
		
		["WhisperSound"] = {
			["Name"] = "密語提示",
			["Desc"] = "收到密語時播放提示音",
		},
		
		["LinkColor"] = {
			["Name"] = "URL超連結染色",
			["Desc"] = "設置URL超連結顯示顏色"..RestoreDefault,
		},
		
		["LinkBrackets"] = {
			["Name"] = "URL超連結括號",
			["Desc"] = "將URL網址以括號括起",
		},
		
		["LootFrame"] = {
			["Name"] = "戰利品框架",
			["Desc"] = "建立一個獨立的掉落紀錄框",
		},
		
		["Background"] = {
			["Name"] = "聊天框背景",
			["Desc"] = "創建一個聊天框背景",
		},
		
		["ChatFont"] = {
			["Name"] = "聊天字體",
			["Desc"] = "設置聊天字體",
		},
		
		["TabFont"] = {
			["Name"] = "聊天標籤字體",
			["Desc"] = "設置聊天標籤的字體",
		},
		
		["ScrollByX"] = {
			["Name"] = "滾輪捲動",
			["Desc"] = "設置滑鼠滾輪滾動時的捲動行數",
		},
	},
	
	["Cooldowns"] = {
		["Font"] = {
			["Name"] = "冷卻計時字體",
			["Desc"] = "設置冷卻計時字體",
		},
	},
	
	["DataTexts"] = {
		["Battleground"] = {
			["Name"] = "戰場訊息",
			["Desc"] = "顯示戰場訊息",
		},
		
		["LocalTime"] = {
			["Name"] = "當地時間",
			["Desc"] = "顯示當地時間，而不是伺服器時間",
		},
		
		["Time24HrFormat"] = {
			["Name"] = "24小時制",
			["Desc"] = "以24小時制顯示時間",
		},
		
		["NameColor"] = {
			["Name"] = "項目顏色",
			["Desc"] = "設置訊息項目名的顏色"..RestoreDefault,
		},
		
		["ValueColor"] = {
			["Name"] = "數值顏色",
			["Desc"] = "設置訊息數值的顏色"..RestoreDefault,
		},
		
		["Font"] = {
			["Name"] = "訊息條字體",
			["Desc"] = "設置訊息條的字體",
		},
	},
	
	["Merchant"] = {
		["AutoSellGrays"] = {
			["Name"] = "自動賣垃圾",
			["Desc"] = "自動販賣灰色物品",
		},
		
		["SellMisc"] = {
			["Name"] = "自動賣雜物",
			["Desc"] = "自動販賣不是灰色品質但沒用的雜物",
		},
		
		["AutoRepair"] = {
			["Name"] = "自動修裝",
			["Desc"] = "自動修理裝備",
		},
		
		["UseGuildRepair"] = {
			["Name"] = "使用公會修裝",
			["Desc"] = "啟用自動修裝時，使用公會銀行資金修理",
		},
	},
	
	["Misc"] = {
		["ThreatBarEnable"] = {
			["Name"] = "啟用仇恨條",
			["Desc"] = "Derp",
		},
		
		["AltPowerBarEnable"] = {
			["Name"] = "啟用特殊能量條",
			["Desc"] = "Derp",
		},
		
		["ExperienceEnable"] = {
			["Name"] = "啟用經驗條",
			["Desc"] = "啟用經驗條.",
		},
		
		["ReputationEnable"] = {
			["Name"] = "啟用聲望條",
			["Desc"] = "啟用聲望條.",
		},
		
		["ErrorFilterEnable"] = {
			["Name"] = "啟用錯誤過濾",
			["Desc"] = "過濾UI的LUA錯誤訊息",
		},
	},
	
	["NamePlates"] = {
		["Enable"] = {
			["Name"] = "啟用姓名板",
			["Desc"] = "Derp"..PerformanceSlight,
		},
		
		["Width"] = {
			["Name"] = "設置寬度",
			["Desc"] = "設置姓名板寬度",
		},
		
		["Height"] = {
			["Name"] = "設置高度",
			["Desc"] = "設置姓名板高度",
		},
		
		["CastHeight"] = {
			["Name"] = "施法條高度",
			["Desc"] = "設置姓名板施法條高度",
		},
		
		["Spacing"] = {
			["Name"] = "間距",
			["Desc"] = "設置姓名板間距",
		},
		
		["NonTargetAlpha"] = {
			["Name"] = "非目標淡出",
			["Desc"] = "非當前目標的姓名板透明度",
		},
		
		["Texture"] = {
			["Name"] = "姓名板材質",
			["Desc"] = "設置姓名板材質",
		},
		
		["Font"] = {
			["Name"] = "姓名板字體",
			["Desc"] = "設置姓名板字體",
		},
		 ["HealthText"] = {
			["Name"] = "血量文字",
			["Desc"] = "在姓名板上顯示血量的具體數值.",
		},
	},		
	["Party"] = {
		["Enable"] = {
			["Name"] = "小隊框架",
			["Desc"] = "Derp",
		},
		
		["Portrait"] = {
			["Name"] = "人物頭像",
			["Desc"] = "在小隊框架顯示人物頭像",
		},
		
		["HealBar"] = {
			["Name"] = "治療提示",
			["Desc"] = "顯示即將到來的治療與吸收",
		},
		
		["ShowPlayer"] = {
			["Name"] = "顯示玩家",
			["Desc"] = "在小隊框架上顯示自己",
		},
		
		["ShowHealthText"] = {
			["Name"] = "血量顯示",
			["Desc"] = "顯示血量具體數值.",
		},
		
		["Font"] = {
			["Name"] = "框架字體",
			["Desc"] = "設置小隊框架的字體",
		},
		
		["HealthFont"] = {
			["Name"] = "血量字體",
			["Desc"] = "小隊框架的血量數值字體",
		},
		
		["PowerTexture"] = {
			["Name"] = "能量條材質",
			["Desc"] = "設置能量條材質",
		},
		
		["HealthTexture"] = {
			["Name"] = "血量條材質",
			["Desc"] = "設置血量條材質",
		},
		["RangeAlpha"] = {
			["Name"] = "距離淡出",
			["Desc"] = "設定超出距離的框架透明度",
		},
	},
	
	["Raid"] = {
		["Enable"] = {
			["Name"] = "啟用團隊框架",
			["Desc"] = "Derp",
		},
		
		["ShowPets"] = {
			["Name"] = "顯示寵物",
			["Desc"] = "Derp",
		},
		
		["Highlight"] = {
			["Name"] = "Highlight",
			["Desc"] = "Highlight your current focus/target",
		},
		
		["HealBar"] = {
			["Name"] = "治療提示",
			["Desc"] = "顯示即將到來的治療與吸收",
		},
		
		["AuraWatch"] = {
			["Name"] = "光環監視",
			["Desc"] = "在團隊框架的的角落顯示光環",
		},
		
		["AuraWatchTimers"] = {
			["Name"] = "光環計時器",
			["Desc"] = "顯示DEBUFF的秒數",
		},
		
		["DebuffWatch"] = {
			["Name"] = "減益效果",
			["Desc"] = "以大圖示在團隊框架上顯示重要的DEBUFF",
		},
		
		["RangeAlpha"] = {
			["Name"] = "距離淡出",
			["Desc"] = "設定超出距離的框架透明度",
		},
		
		["ShowRessurection"] = {
			["Name"] = "顯示復活圖示",
			["Desc"] = "顯示玩家正被復活的圖示",
		},
		
		["ShowHealthText"] = {
			["Name"] = "血量文字",
			["Desc"] = "顯示血量的具體損失數值",
		},
		
		["VerticalHealth"] = {
			["Name"] = "垂直顯示",
			["Desc"] = "直向顯示血量損失",
		},
		
		["Font"] = {
			["Name"] = "框架字體",
			["Desc"] = "設置團隊框架的字體",
		},
		
		["HealthFont"] = {
			["Name"] = "血量字體",
			["Desc"] = "設置團隊框架上血量數值的字體",
		},
		
		["PowerTexture"] = {
			["Name"] = "能量條材質",
			["Desc"] = "設置能量條材質",
		},
		
		["HealthTexture"] = {
			["Name"] = "血量條材質",
			["Desc"] = "設置血量條材質",
		},
		
		["GroupBy"] = {
			["Name"] = "分組",
			["Desc"] = "定義團隊框架的排序方式",
		},
	},
	
	["Tooltips"] = {
		["Enable"] = {
			["Name"] = "啟用滑鼠提示",
			["Desc"] = "Derp",
		},
		
		["HideOnUnitFrames"] = {
			["Name"] = "隱藏頭像提示",
			["Desc"] = "使游標指向頭像框架時不顯示Tooltips",
		},
		
		["UnitHealthText"] = {
			["Name"] = "顯示血量數值",
			["Desc"] = "在Tooltips上顯示血量數值",
		},
		
		["ShowSpec"] = {
			["Name"] = "專精",
			["Desc"] = "顯示玩家的專精",
		},
		
		["HealthFont"] = {
			["Name"] = "血量條字體",
			["Desc"] = "設置Tooltips血量數值的字體",
		},
		
		["HealthTexture"] = {
			["Name"] = "血量條材質",
			["Desc"] = "設置血量條材質",
		},
	},
	
	["UnitFrames"] = {
		["Enable"] = {
			["Name"] = "啟用頭像框架",
			["Desc"] = "Derp",
		},
		
		["TargetEnemyHostileColor"] = {
			["Name"] = "敵對目標顏色",
			["Desc"] = "敵對目標血條將會變色，而不是通用的顏色着色",
		},
		
		["Portrait"] = {
			["Name"] = "人物頭像",
			["Desc"] = "顯示玩家與目標的人物頭像",
		},
		
		["CastBar"] = {
			["Name"] = "施法條",
			["Desc"] = "啟用施法條",
		},
		
		["UnlinkCastBar"] = {
			["Name"] = "解鎖施法條",
			["Desc"] = "使施法條獨立，不依附玩家與目標框架，並允許施法條在螢幕上移動",
		},
		
		["CastBarIcon"] = {
			["Name"] = "施法條圖示",
			["Desc"] = "建立法術圖示",
		},
		
		["CastBarLatency"] = {
			["Name"] = "施法條延遲",
			["Desc"] = "顯示施法條的延遲",
		},
		
		["Smooth"] = {
			["Name"] = "平滑特效",
			["Desc"] = "使施法條看起來更流暢"..PerformanceSlight,
		},
		
		["CombatLog"] = {
			["Name"] = "戰鬥訊息反饋",
			["Desc"] = "在框架上顯示受到的治療和傷害",
		},
		
		["WeakBar"] = {
			["Name"] = "虛弱靈魂條",
			["Desc"] = "顯示虛弱靈魂的debuff",
		},
		
		["HealBar"] = {
			["Name"] = "治療提示",
			["Desc"] = "顯示即將到來的治療與吸收",
		},
		
		["TotemBar"] = {
			["Name"] = "圖騰條",
			["Desc"] = "啟用tukui風格圖騰條",
		},
		
		["AnticipationBar"] = {
			["Name"] = "盜賊連擊點",
			["Desc"] = "顯示盜賊連擊點",
		},
		
		["SerendipityBar"] = {
			["Name"] = "機緣回復",
			["Desc"] = "顯示牧師機緣回復的層數",
		},
		
		["OnlySelfDebuffs"] = {
			["Name"] = "只顯示我造成的減益",
			["Desc"] = "在目標框架上只顯示我造成的減益效果",
		},

		["OnlySelfBuffs"] = {
			["Name"] = "Display My Buffs Only",
			["Desc"] = "Only display our buffs on the target frame",
		},
		
		["DarkTheme"] = {
			["Name"] = "黑暗主題",
			["Desc"] = "如果啟用，血量條會變成暗色而能量條變成職業顏色",
		},
		
		["Threat"] = {
			["Name"] = "仇恨顯示",
			["Desc"] = "當小隊或團隊成員獲得仇恨，血條會變色",
		},
		
		["Arena"] = {
			["Name"] = "競技場頭像框架",
			["Desc"] = "在戰場或競技場顯示對手的頭像框架",
		},

	    ["Boss"] = {
			["Name"] = "首領框架",
			["Desc"] = "在PVE環境顯示首領框架",
		},
		["TargetAuras"] = {
			["Name"] = "目標光環",
			["Desc"] = "在目標頭像顯示增益和減益效果",
		},
		
		
		["FocusAuras"] = {
			["Name"] = "焦點光環",
			["Desc"] = "在焦點頭像顯示增益和減益效果",
		},
		
		["FocusTargetAuras"] = {
			["Name"] = "焦點目標光環",
			["Desc"] = "在焦點目標頭像顯示增益和減益效果",
		},
		
		["ArenaAuras"] = {
			["Name"] = "競技場光環",
			["Desc"] = "在競技場頭像顯示增益和減益效果",
		},
		
		["BossAuras"] = {
			["Name"] = "首領光環",
			["Desc"] = "在首領頭像顯示增益和減益效果",
		},
		
		["AltPowerText"] = {
			["Name"] = "AltPower Text",
			["Desc"] = "Display altpower text values on altpower bar",
		},
		
		["Font"] = {
			["Name"] = "框架字體",
			["Desc"] = "設置框架文字的字體",
		},
		
		["PowerTexture"] = {
			["Name"] = "能量條材質",
			["Desc"] = "設置能量條的材質",
		},
		
		["HealthTexture"] = {
			["Name"] = "血量條材質",
			["Desc"] = "設置血量條的材質",
		},
		
		["CastTexture"] = {
			["Name"] = "施法條材質",
			["Desc"] = "設置施法條的材質",
		},
	},
}