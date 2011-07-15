--by 风吹那啥凉 
if GetLocale() == "zhCN" then

	-- update needed msg
	TukuiL.option_update = "由于Tukui的上一次更新，你必须升级你的Tukui ConfigUI， 请访问 www.tukui.org"

	-- general
	TukuiL.option_general = "综合"
	TukuiL.option_general_uiscale = "自动UI缩放"
	TukuiL.option_general_override = "在低分辨率条件下使用高分辨率样式"
	TukuiL.option_general_multisample = "多重采样保护"
	TukuiL.option_general_customuiscale = "UI缩放 (自动缩放必须被禁用)"
	TukuiL.option_general_backdropcolor = "设置为默认面板背景颜色"
	TukuiL.option_general_bordercolor = "设置为默认边框颜色"
	TukuiL.option_general_blizzardreskin = "改变暴雪样式的框体为Tukui风格"
	 
	-- nameplate
	TukuiL.option_nameplates = "姓名板"
	TukuiL.option_nameplates_enable = "开启姓名版"
	TukuiL.option_nameplates_enhancethreat = "启用仇恨着色模式，将会根据你的角色自动改变颜色"
	TukuiL.option_nameplates_showhealth = "在姓名板上显示生命值"
	TukuiL.option_nameplates_combat = "仅在战斗中显示姓名板"
	TukuiL.option_nameplates_goodcolor = "安全仇恨值颜色，取决于你是坦克还是治疗者"
	TukuiL.option_nameplates_badcolor = "危险仇恨值颜色，取决于你是治疗还是输出"
	TukuiL.option_nameplates_transitioncolor = "失去/获得仇恨值颜色"
	 
	-- merchant
	TukuiL.option_merchant = "商人"
	TukuiL.option_merchant_autosell = "自动售卖灰色物品"
	TukuiL.option_merchant_autorepair = "自动修理物品"
	TukuiL.option_merchant_sellmisc = "自动售卖灰色物品（当然不是灰色的咯）"
	 
	-- bags
	TukuiL.option_bags = "背包"
	TukuiL.option_bags_enable = "开启背包整合"
	 
	-- datatext
	TukuiL.option_datatext = "信息文本"
	TukuiL.option_datatext_24h = "使用24小时制"
	TukuiL.option_datatext_localtime = "使用本地时间取代服务器时间"
	TukuiL.option_datatext_bg = "启用战场状态"
	TukuiL.option_datatext_hps = "每秒治疗(输入0关闭)"
	TukuiL.option_datatext_guild = "公会信息 (输入0关闭)"
	TukuiL.option_datatext_arp = "护甲穿透 (输入0关闭)"
	TukuiL.option_datatext_mem = "内存占用信息 (输入0关闭)"
	TukuiL.option_datatext_bags = "背包 (输入0关闭)"
	TukuiL.option_datatext_fontsize = "文本字体大小"
	TukuiL.option_datatext_fps_ms = "延时和帧数(输入0关闭)"
	TukuiL.option_datatext_armor = "护甲值 (输入0关闭)"
	TukuiL.option_datatext_avd = "躲闪 (输入0关闭)"
	TukuiL.option_datatext_power = "攻强/法伤(输入0关闭)"
	TukuiL.option_datatext_haste = "急速(输入0关闭)"
	TukuiL.option_datatext_friend = "好友(输入0关闭)"
	TukuiL.option_datatext_time = "时间(输入0关闭)"
	TukuiL.option_datatext_gold = "金币(输入0关闭)"
	TukuiL.option_datatext_dps = "DPS (输入0关闭)"
	TukuiL.option_datatext_crit = "爆击 % (输入0关闭)"
	TukuiL.option_datatext_dur = "耐久度(输入0关闭)"
	TukuiL.option_datatext_currency = "货币(输入0关闭)"
	TukuiL.option_datatext_micromenu = "微型菜单(输入0关闭)"
	TukuiL.option_datatext_hit = "命中(输入0关闭)"
	TukuiL.option_datatext_mastery = "精通 (输入0关闭)"

	 
	-- unit frames
	TukuiL.option_unitframes_unitframes = "单位框体"
	TukuiL.option_unitframes_combatfeedback = "在玩家和目标框体上显示战斗信息"
	TukuiL.option_unitframes_runebar = "为死亡骑士启用符文条"
	TukuiL.option_unitframes_auratimer = "在光环上显示时间"
	TukuiL.option_unitframes_totembar = "为萨满启用图腾条"
	TukuiL.option_unitframes_totalhpmp = "显示总的生命/能量值"
	TukuiL.option_unitframes_playerparty = "在团队中显示你自己"
	TukuiL.option_unitframes_aurawatch = "启用PVE光环检测 (只能在GRIG模式下)"
	TukuiL.option_unitframes_castbar = "启用施法条"
	TukuiL.option_unitframes_targetaura = "启用目标光环"
	TukuiL.option_unitframes_saveperchar = "为每个角色单独存储框架位置"
	TukuiL.option_unitframes_playeraggro = "在自身头像上启用仇恨显示"
	TukuiL.option_unitframes_smooth = "启用平滑状态条"
	TukuiL.option_unitframes_portrait = "为自身和目标启用头像显示"
	TukuiL.option_unitframes_enable = "启用Tukui头像框架"
	TukuiL.option_unitframes_enemypower = "只显示敌对目标的能量值"
	TukuiL.option_unitframes_gridonly = "治疗模式下仅使用GRID样式"
	TukuiL.option_unitframes_healcomm = "启用预估治疗"
	TukuiL.option_unitframes_focusdebuff = "启用焦点DEBUFF"
	TukuiL.option_unitframes_raidaggro = "在小队/团队中启用仇恨显示"
	TukuiL.option_unitframes_boss = "启用BOSS框体"
	TukuiL.option_unitframes_enemyhostilitycolor = "用敌对颜色为敌人框体着色 (for PVP)"
	TukuiL.option_unitframes_hpvertical = "在Grid模式中垂直显示生命条"
	TukuiL.option_unitframes_symbol = "显示小队/团队标记"
	TukuiL.option_unitframes_threatbar = "启用仇恨条"
	TukuiL.option_unitframes_enablerange = "启用小队/团队距离检测"
	TukuiL.option_unitframes_focus = "启用焦点目标"
	TukuiL.option_unitframes_latency = "显示施法延时"
	TukuiL.option_unitframes_icon = "显示施法条图标"
	TukuiL.option_unitframes_playeraura = "为玩家启用额外的光环模式"
	TukuiL.option_unitframes_aurascale = "光环文字大小设置"
	TukuiL.option_unitframes_gridscale = "Grid框体大小"
	TukuiL.option_unitframes_manahigh = "法力值过高警报 (LR专用)"
	TukuiL.option_unitframes_manalow = "低法力值警报 (所有的法系职业)"
	TukuiL.option_unitframes_range = "小队/团队超出距离透明值"
	TukuiL.option_unitframes_maintank = "启用主坦克框架"
	TukuiL.option_unitframes_mainassist = "启用主助理框架"
	TukuiL.option_unitframes_unicolor = "启用单一的颜色主题(灰色的生命条)"
	TukuiL.option_unitframes_totdebuffs = "启用目标的目标的DEBUFF显示 (仅限高分辨率)"
	TukuiL.option_unitframes_classbar = "启用职业条（enable class bar)"
	TukuiL.option_unitframes_weakenedsoulbar = "启用灵魂虚弱指示 (MS)"
	TukuiL.option_unitframes_onlyselfdebuffs = "只在目标框体上显示你释放的DEBUFF"
	TukuiL.option_unitframes_focus = "启用焦点目标"
	TukuiL.option_unitframes_bordercolor = "设置为默认的边框颜色"
	 
	-- loot
	TukuiL.option_loot = "拾取"
	TukuiL.option_loot_enableloot = "启用拾取框"
	TukuiL.option_loot_autogreed = "满级时启用自动贪婪绿色物品"
	TukuiL.option_loot_enableroll = "启用R点框体"
	 
	-- map
	TukuiL.option_map = "地图"
	TukuiL.option_map_enable = "启用Tukui风格的地图"
	 
	-- invite
	TukuiL.option_invite = "邀请"
	TukuiL.option_invite_autoinvite = "开启自动邀请 (好友和公会成员)"
	 
	-- tooltip
	TukuiL.option_tooltip = "鼠标提示"
	TukuiL.option_tooltip_enable = "开启鼠标提示"
	TukuiL.option_tooltip_hidecombat = "战斗中关闭鼠标提示"
	TukuiL.option_tooltip_hidebutton = "关闭动作条按钮提示"
	TukuiL.option_tooltip_hideuf = "关闭单位框体的鼠标提示"
	TukuiL.option_tooltip_cursor = "启用提示跟随鼠标模式"
	 
	-- others
	TukuiL.option_others = "其他"
	TukuiL.option_others_bg = "启用在战场中自动释放灵魂"
	 
	-- reminder
	TukuiL.option_reminder = "光环报警"
	TukuiL.option_reminder_enable = "启用玩家光环报警"
	TukuiL.option_reminder_sound = "为光环报警开启声音提示"
	 
	-- error
	TukuiL.option_error = "错误信息"
	TukuiL.option_error_hide = "隐藏屏幕中恼人的错误提示信息"
	 
	-- action bar
	TukuiL.option_actionbar = "动作条"
	TukuiL.option_actionbar_hidess = "隐藏姿态或者图腾栏"
	TukuiL.option_actionbar_showgrid = "始终在动作条上显示方格"
	TukuiL.option_actionbar_enable = "启用Tukui动作条"
	TukuiL.option_actionbar_rb = "启用右侧动作条鼠标划过显示"
	TukuiL.option_actionbar_hk = "显示热键名称"
	TukuiL.option_actionbar_ssmo = "鼠标划过显示姿态栏和图腾栏"
	TukuiL.option_actionbar_rbn = "底部动作条数目 (1 or 2)"
	TukuiL.option_actionbar_rn = "右侧动作条数目 (0, 1, 2 or 3)"
	TukuiL.option_actionbar_buttonsize = "主动作条大小"
	TukuiL.option_actionbar_buttonspacing = "动作条按钮大小"
	TukuiL.option_actionbar_petbuttonsize = "宠物或姿态栏按钮大小"

	-- quest watch frame
	TukuiL.option_quest = "任务追踪"
	TukuiL.option_quest_movable = "可移动任务追踪"
	 
	-- arena
	TukuiL.option_arena = "竞技场"
	TukuiL.option_arena_st = "启用竞技场敌方施法监测"
	TukuiL.option_arena_uf = "启用竞技场单位框架"

	-- pvp
	TukuiL.option_pvp = "Pvp"
	TukuiL.option_pvp_ii = "启用打断图标"
	 
	-- cooldowns
	TukuiL.option_cooldown = "冷却"
	TukuiL.option_cooldown_enable = "在按钮上显示冷却时间"
	TukuiL.option_cooldown_th = "在X秒以后以红色显示冷却时间"
	 
	-- chat
	TukuiL.option_chat = "对话框"
	TukuiL.option_chat_enable = "启用Tukui的聊天框架"
	TukuiL.option_chat_whispersound = "在收到M语时播放提示音"
	TukuiL.option_chat_background = "启用聊天面板背景"

	-- buff
	TukuiL.option_auras = "光环"
	TukuiL.option_auras_player = "启用Tukui Buff/Debuff 框架"

	-- buttons
	TukuiL.option_button_reset = "重置"
	TukuiL.option_button_load = "应用设定"
	TukuiL.option_button_close = "关闭"
	TukuiL.option_setsavedsetttings = "为单一角色设定"
	TukuiL.option_resetchar = "你确定要重置角色的设置为默认值么?"
	TukuiL.option_resetall = "你确定重置所有的设定至默认值么?"
	TukuiL.option_perchar = "你确定要启用或者关闭“为单一角色设定”么?"
	TukuiL.option_makeselection = "在你继续设置之前你必须要做出一个选择"

end