local T, C, L, G = unpack(select(2, ...))

if T.client == "zhCN" then
	L.UI_Outdated = "Tukui 版本已过期，请至 www.tukui.org 下载最新版"
	L.UI_Talent_Change_Bug = "A blizzard bug has occured which is preventing you from changing your talents, this happen when you've inspected someone. Unfortunatly there is nothing we can do in this WoW Patch to fix it, please reload your ui and try again."
	
	-- localization for zhCN  by 风吹那啥凉（Popptise @Tukui forums)	
	L.chat_INSTANCE_CHAT = "I"
	L.chat_INSTANCE_CHAT_LEADER = "IL"
	L.chat_BN_WHISPER_GET = "密语"
	L.chat_GUILD_GET = "公"
	L.chat_OFFICER_GET = "官"
	L.chat_PARTY_GET = "队"
	L.chat_PARTY_GUIDE_GET = "地下城向导"
	L.chat_PARTY_LEADER_GET = "队长"
	L.chat_RAID_GET = "团"
	L.chat_RAID_LEADER_GET = "团长"
	L.chat_RAID_WARNING_GET = "团队警告"
	L.chat_WHISPER_GET = "密语"
	L.chat_FLAG_AFK = "[AFK]"
	L.chat_FLAG_DND = "[DND]"
	L.chat_FLAG_GM = "[GM]"
	L.chat_ERR_FRIEND_ONLINE_SS = "|cff05e9FF上线了|r"  
	L.chat_ERR_FRIEND_OFFLINE_S = "|cffff0000下线了|r"
	
	-- 请不要缩写下列频道名称 这是用来帮助设置归类频道的
	L.chat_general = "综合"
	L.chat_trade = "交易"
	L.chat_defense = "本地防务"
	L.chat_recrutment = "公会招募"
	L.chat_lfg = "寻求组队"

	L.disband = "正在解散团队"

	L.datatext_download = "下载： "
	L.datatext_bandwidth = "带宽："
	L.datatext_guild = "公会"
	L.datatext_noguild = "没有公会"
	L.datatext_bags = "背包 "
	L.datatext_friends = "好友"
	L.datatext_online = "在线："
	L.datatext_armor = "耐久度"
	L.datatext_earned = "赚取："
	L.datatext_spent = "花费："
	L.datatext_deficit = "赤字："
	L.datatext_profit = "利润："
	L.datatext_timeto = "时间至："
	L.datatext_friendlist = "好友列表："
	L.datatext_playersp = "法伤"
	L.datatext_playerap = "攻强"
	L.datatext_playerhaste = "急速"
	L.datatext_dps = "dps"
	L.datatext_hps = "hps"
	L.datatext_playerarp = "护甲穿透"
	L.datatext_session = "本次概况："
	L.datatext_character = "角色："
	L.datatext_server = "服务器："
	L.datatext_totalgold = "总共："
	L.datatext_savedraid = "已保存进度的团队副本"
	L.datatext_currency = "兑换通货："
	L.datatext_fps = " 帧数 & "
	L.datatext_ms = " 延时"
	L.datatext_playercrit = " 爆击"
	L.datatext_playerheal = " 治疗"
	L.datatext_avoidancebreakdown = "伤害减免"
	L.datatext_lvl = "等级"
	L.datatext_boss = "首领"
	L.datatext_miss = "未命中"
	L.datatext_dodge = "躲闪"
	L.datatext_block = "格挡"
	L.datatext_parry = "招架"
	L.datatext_playeravd = "免伤： "
	L.datatext_servertime = "服务器时间： "
	L.datatext_localtime = "本地时间： "
	L.datatext_mitigation = "等级缓和： "
	L.datatext_healing = "治疗： "
	L.datatext_damage = "伤害： "
	L.datatext_honor = "荣誉： "
	L.datatext_killingblows = "击杀： "
	L.datatext_ttstatsfor = "状态 "
	L.datatext_ttkillingblows = "击杀："
	L.datatext_tthonorkills = "荣誉击杀"
	L.datatext_ttdeaths = "死亡："
	L.datatext_tthonorgain = "获得荣誉："
	L.datatext_ttdmgdone = "伤害输出："
	L.datatext_tthealdone = "治疗输出："
	L.datatext_basesassaulted = "突袭基地："
	L.datatext_basesdefended = "防守基地："
	L.datatext_towersassaulted = "突袭哨塔："
	L.datatext_towersdefended = "防守哨塔："
	L.datatext_flagscaptured = "夺取旗帜："
	L.datatext_flagsreturned = "交换旗帜："
	L.datatext_graveyardsassaulted = "突袭墓地："
	L.datatext_graveyardsdefended = "防守墓地："
	L.datatext_demolishersdestroyed = "摧毁投石车："
	L.datatext_gatesdestroyed = "摧毁大门："
	L.datatext_totalmemusage = "总内存占用："
	L.datatext_control = "控制方："
	L.datatext_cta_allunavailable = "无法获取战斗的召唤信息."
	L.datatext_cta_nodungeons = "目前没有可用的战斗的召唤地下城."
	L.datatext_carts_controlled = "Carts Controlled:"
	L.datatext_victory_points = "Victory Points:"
	L.datatext_orb_possessions = "Orb Possessions:"
	L.datatext_galleon = "炮舰"
	L.datatext_sha = "怒之煞"
	L.datatext_oondasta = "Oondasta"
	L.datatext_nalak = "Nalak"
	L.datatext_defeated = "已击杀"
	L.datatext_undefeated = "未击杀"

	L.Slots = {
		[1] = {1, "头部", 1000},
		[2] = {3, "肩部", 1000},
		[3] = {5, "胸部", 1000},
		[4] = {6, "腰部", 1000},
		[5] = {9, "手腕", 1000},
		[6] = {10, "手", 1000},
		[7] = {7, "腿部", 1000},
		[8] = {8, "脚", 1000},
		[9] = {16, "主手", 1000},
		[10] = {17, "副手", 1000},
		[11] = {18, "远程", 1000}
	}

	L.popup_disableui = "Tukui不支持当前分辨率，想要禁用Tukui吗？（如果你想尝试其他分辨率就点击取消）"
	L.popup_install = "当前角色第一次使用Tukui，你必须重载插件以完成配置。"
	L.popup_reset = "注意！当前操作将还原Tukui至默认设置，你是否决定继续？"
	L.popup_2raidactive = "当前两种团队样式被激活，请选择其中之一。"
	L.popup_install_yes = "当然！（建议！）"
	L.popup_install_no = "不，这个UI太难用了！"
	L.popup_reset_yes = "当然勒~还是预设的好~"
	L.popup_reset_no = "不了，否则我会在论坛发帖抱怨的！"
	L.popup_fix_ab = "你的动作条存在一些问题。你想重载插件修复它么?"

	L.merchant_repairnomoney = "您没有足够的金币以完成修理！"
	L.merchant_repaircost = "您修理装备花费了："
	L.merchant_trashsell = "您包里的垃圾被卖出去了，您赚取了："

	L.goldabbrev = "|cffffd700g|r"
	L.silverabbrev = "|cffc7c7cfs|r"
	L.copperabbrev = "|cffeda55fc|r"

	L.error_noerror = "没有错误。"

	L.unitframes_ouf_offline = "离线"
	L.unitframes_ouf_dead = "死亡"
	L.unitframes_ouf_ghost = "灵魂"
	L.unitframes_ouf_lowmana = "低法力值"
	L.unitframes_ouf_threattext = "当前目标仇恨："
	L.unitframes_ouf_offlinedps = "离线"
	L.unitframes_ouf_deaddps = "|cffff0000[死亡]|r"
	L.unitframes_ouf_ghostheal = "灵魂"
	L.unitframes_ouf_deadheal = "死亡"
	L.unitframes_ouf_gohawk = "切换为雄鹰守护"
	L.unitframes_ouf_goviper = "切换为蝰蛇守护"
	L.unitframes_disconnected = "断线"
	L.unitframes_ouf_wrathspell = "愤怒"
	L.unitframes_ouf_starfirespell = "星火术"

	L.tooltip_count = "数量"

	L.bags_noslots = "不能再购买更多的栏位了！"
	L.bags_costs = "花费： %.2f G"
	L.bags_buyslots = "输入 /bags purchase yes 以购买新的栏位！"
	L.bags_openbank = "您必须先打开您的银行！"
	L.bags_sort = "当背包或者银行打开的时候，整理和排序其中的物品！"
	L.bags_stack = "当背包或者银行打开的时候，对其中不完整的物品进行堆叠！"
	L.bags_buybankslot = "购买银行栏位(必须保持银行打开)"
	L.bags_search = "查找"
	L.bags_sortmenu = "整理"
	L.bags_sortspecial = "整理特殊物品"
	L.bags_stackmenu = "堆叠"
	L.bags_stackspecial = "堆叠特殊物品"
	L.bags_showbags = "显示背包"
	L.bags_sortingbags = "整理完成。"
	L.bags_nothingsort= "不需要整理。"
	L.bags_bids = "使用背包： "
	L.bags_stackend = "重新堆叠完成。"
	L.bags_rightclick_search = "右击开始查找。"
	
	L.loot_fish = "Fishy loot" -- not sure for this now
	L.loot_empty = "Empty slot" -- not sure for this now
	L.loot_randomplayer = "Random Player"
	L.loot_self = "Self Loot"

	L.chat_invalidtarget = "无效的目标"

	L.mount_wintergrasp = "冬拥湖"

	L.core_autoinv_enable = "自动邀请开启：invite"
	L.core_autoinv_enable_c = "自动邀请已开启"
	L.core_autoinv_disable = "自动邀请已关闭"
	L.core_wf_unlock = "任务追踪已解锁"
	L.core_wf_lock = "任务追踪已锁定"
	L.core_welcome1 = "欢迎使用 |cffC495DDTukui|r, 版本 "
	L.core_welcome2 = "输入 |cff00FFFF/uihelp|r 以获取更多信息或者访问 www.tukui.org"

	L.core_uihelp1 = "|cff00ff00General 通用指令|r"
	L.core_uihelp2 = "|cffFF0000/moveui|r - 解锁和移动屏幕中的框架。"
	L.core_uihelp3 = "|cffFF0000/rl|r - 重载你的插件。"
	L.core_uihelp4 = "|cffFF0000/gm|r - 向G M发送帮助请求或者打开游戏内帮助。"
	L.core_uihelp5 = "|cffFF0000/frame|r - 侦测当前鼠标所在框体的名称。(对lua编辑者来说非常有用) "
	L.core_uihelp6 = "|cffFF0000/heal|r - 启用团队治疗框体样式。"
	L.core_uihelp7 = "|cffFF0000/dps|r - 启用Dps/Tank 团队样式。"
	L.core_uihelp8 = "|cffFF0000/bags|r - 整理背包，购买银行栏位或者购买物品。"
	L.core_uihelp9 = "|cffFF0000/resetui|r - 重置所有框体配置文件至原始的Tukui。"
	L.core_uihelp10 = "|cffFF0000/rd|r - 解散团队。"
	L.core_uihelp11 = "|cffFF0000/ainv|r - 通过M语关键词启用自动邀请。你可以通过在聊天框输入“/ainv 你的关键词”来设置你自己的关键词。"
	L.core_uihelp100 = "（向下滚动以获取更多的指令。）"

	L.symbol_CLEAR = "取消标记"
	L.symbol_SKULL = "骷髅"
	L.symbol_CROSS = "十字"
	L.symbol_SQUARE = "方形"
	L.symbol_MOON = "月亮"
	L.symbol_TRIANGLE = "三角形"
	L.symbol_DIAMOND = "钻石"
	L.symbol_CIRCLE = "大饼"
	L.symbol_STAR = "星星"

	L.bind_combat = "您不能在战斗中绑定快捷键。"
	L.bind_saved = "所有绑定的快捷键已经被保存。"
	L.bind_discard = "所有新设定的快捷键已经呗取消。"
	L.bind_instruct = "移动鼠标至动作条按钮上来绑定，按ESC键或者右击取消绑定。"
	L.bind_save = "保存绑定"
	L.bind_discardbind = "取消绑定"

	L.hunter_unhappy = "你的宠物感到不高兴了！"
	L.hunter_content = "你的宠物感到很满足！"
	L.hunter_happy = "你的宠物很开心"

	L.move_tooltip = "移动鼠标提示"
	L.move_minimap = "移动小地图"
	L.move_watchframe = "移动任务追踪"
	L.move_gmframe = "移动G M对话框"
	L.move_buffs = "移动玩家增益效果"
	L.move_debuffs = "移动玩家减益效果"
	L.move_shapeshift = "移动姿态或图腾条"
	L.move_achievements = "移动成就框体"
	L.move_roll = "移动拾取R点框体"
	L.move_vehicle = "移动载具界面"

	-------------------------------------------------
	-- INSTALLATION
	-------------------------------------------------

	-- headers
	L.install_header_1 = "欢迎"
	L.install_header_2 = "1. 要点"
	L.install_header_3 = "2. 单位框架"
	L.install_header_4 = "3. 特性"
	L.install_header_5 = "4. 您应该知道的东西"
	L.install_header_6 = "5. 命令"
	L.install_header_7 = "6. 完成"
	L.install_header_8 = "1. 必要的设定"
	L.install_header_9 = "2. 社交"
	L.install_header_10= "3. 框架"
	L.install_header_11= "4. 成功！"

	-- install
	L.install_init_line_1 = "感谢您选择Tukui。"
	L.install_init_line_2 = "几个小步骤将引导你安装Tukui. 在每一步中， 你可以选择应用或者跳过当前的设定。"
	L.install_init_line_3 = "你也可以选择查看我们提供给您的关于Tukui一些特性的小提示。"
	L.install_init_line_4 = "按下教程按键开始查看教程，或者点击安装跳过这一步。"

	-- tutorial 1
	L.tutorial_step_1_line_1 = "这个快速的小教程将给您展示一些Tukui的特性。"
	L.tutorial_step_1_line_2 = "首先，将告知你一些使用Tukui前该知道的要点。"
	L.tutorial_step_1_line_3 = "安装程序是按照每个角色来设定的。当然一些设定将在整个帐号下适用，您必须要为每一个使用Tukui的角色运行一遍安装程序。程序将在您每个角色第一次运行Tukui时自动显示。 当然, 高阶用户可以在 /Tukui/config/config.lua 中发现这些选项， 新手在游戏中输入/tukui 也可以找到。"
	L.tutorial_step_1_line_4 = "高阶用户是指相比于普通的用户他们有能力使用一些新的特新(比如编辑LUA脚本)。新手是指没有编程能力的用户。那么我们建议他们使用游戏内设置面板来设定Tukui至他们想要的样式。"

	-- tutorial 2
	L.tutorial_step_2_line_1 = "Tukui包含了一个由Haste编写的oUF的内建版本. 由它来构建整个屏幕上的各种单位框体，玩家的BUFF/DEBUFF和职业特定的BUFF/DEBUFF."
	L.tutorial_step_2_line_2 = "你可以在Wowinterface上搜索oUF来获取更多关于这个工具的信息。"
	L.tutorial_step_2_line_3 = "如果你是一个治疗者或者团队领袖，那么你可能需要启用治疗框体。 它显示了更多的raid信息(/heal)。DPS和坦克需要一个相对简单的团队框架(/dps)。如果你不想使用它们中的任何一个，你可以在人物选择界面中的插件列表里禁用它们。"
	L.tutorial_step_2_line_4 = "你只需要输入/moveui,，既可以简单的移动单位框架。"

	-- tutorial 3
	L.tutorial_step_3_line_1 = "Tukui是一个重新设计过的暴雪用户界面。不多不少，大概所有的原始特性你都可以在Tukui中体验到。 有些仅有的原始界面不能实现的功能在屏幕中是看不到的， 比如说当你访问商人的时候自动售卖灰色的物品，又或者自动整理背包内的物品。"
	L.tutorial_step_3_line_2 = "因为并不是所有人都喜欢诸如：伤害统计, 首领模块, 仇恨统计, 等等这些模块, 但我们认为这是非常好的事. Tukui是为不同职业，不同口味，不同爱好，不同天赋等等最大化的玩家群体所编写的。 这就是为什么Tukui是当前最火的UI。 它满足了每一个人的游戏体验并且完全可供编辑。 它也被设计于为那些想要打造自己特性的UI的初学者们提供了一个很好的开端而无需专注于插件本身的构造。 从2009年开始，许多用户使用Tukui作为基本架构来制作他们自己的插件。 你可以到我们的网站上看看那些Tukui改版！"
	L.tutorial_step_3_line_3 = "用户们可以到我们官方网站的Tukui配套插件区或者访问 www.wowinterface.com 来获取安装更多有额外特性的插件。"
	L.tutorial_step_3_line_4 = ""

	-- tutorial 4
	L.tutorial_step_4_line_1 = "想要设置动作条的数目, 移动鼠标至左/右动作条的底部背景框架。可以使用相同的方法设定右边的动作条，点击顶部或底部。 想要从聊天框内复制文字， 鼠标点击在聊天框右上角出现的小按钮即可。"
	L.tutorial_step_4_line_2 = "小地图的边框可以改变颜色。绿色的时候说明你有未读邮件，红色表明你有新的行事历邀请 ，橙色表明你两者都有。"
	L.tutorial_step_4_line_3 = "你可以点击80%的信息栏来打开更多的BLZ面板。 好友和公会信息也具有右键特性。"
	L.tutorial_step_4_line_4 = "这里有一些下拉菜单可以使用。 右键[X] (关闭) 背包按钮 将会显示下拉菜单比如：显示背包，整理背包，显示钥匙扣等等。 鼠标中间点击小地图将会显示宏命令按钮。"

	-- tutorial 5
	L.tutorial_step_5_line_1 = "最后，Tukui有一些实用的命令，下面是列表"
	L.tutorial_step_5_line_2 = "/moveui 允许你移动屏幕上的大多数框体至任何地方。 /enable 和 /disable 被用于快速开启或关闭大多数插件。 /rl 重载插件。 /heal 启用治疗团队框架。/dps 启用坦克/输出团队框架。"
	L.tutorial_step_5_line_3 = "/tt 让你M语你的目标 /rc 立即进行团队就绪检查 /rd 解散团队或小队 /bags 通过命令行来显示一些可用信息 /ainv 通过M语你来启用自动邀请 (/ainv off) 关闭自动邀请。"
	L.tutorial_step_5_line_4 = "/gm 打开帮助面板 /install, /resetui or /tutorial 载入安装程序 /frame 在聊天框里输入当前鼠标下框体的一些额外的信息。"

	-- tutorial 6
	L.tutorial_step_6_line_1 = "教程结束了。你可以在任何时候输入/tutorial来重新参看教程。"
	L.tutorial_step_6_line_2 = "我建议你仔细的看一下config/config.lua 或者输入 /Tukui 来设置你所需要的属性。"
	L.tutorial_step_6_line_3 = "你可以继续安装，如果安装已经完成你可以重置插件。"
	L.tutorial_step_6_line_4 = ""

	-- install step 1
	L.install_step_1_line_1 = "这些步骤将会为Tukui设置正确的环境变量。"
	L.install_step_1_line_2 = "第一步将会应用一些比较重要的设置。"
	L.install_step_1_line_3 = "这一步 |cffff0000推荐|r 所有的用户应用, 除非你只想应用一些特殊的设定。"
	L.install_step_1_line_4 = "点击继续来应用这些设定，或者如果你想要跳过这些步骤点击跳过。"

	-- install step 2
	L.install_step_2_line_0 = "发现另外的聊天插件。我们将略过这一步。请按跳过继续安装。"
	L.install_step_2_line_1 = "第二步应用了正确的聊天设定。"
	L.install_step_2_line_2 = "如果你是一个新用户，那么非常建议你应用这一步。 如果您已经在使用，那么可以跳过这一步。"
	L.install_step_2_line_3 = "由于应用这些设定，聊天字体过大是正常的。 当安装完成之后它会恢复正常。"
	L.install_step_2_line_4 = "点击继续来继续安装，或者点击跳过，如果你想跳过这一步骤。"

	-- install step 3
	L.install_step_3_line_1 = "第三步且是最后一步将会设定原始框体的位置。"
	L.install_step_3_line_2 = "非常 |cffff0000推荐|r 新手应用这一步。"
	L.install_step_3_line_3 = ""
	L.install_step_3_line_4 = "点击继续来继续安装，或者点击跳过，如果你想跳过这一步骤。"

	-- install step 4
	L.install_step_4_line_1 = "安装完成~"
	L.install_step_4_line_2 = "请点击”完成“按钮重载插件。"
	L.install_step_4_line_3 = ""
	L.install_step_4_line_4 = "享受Tukui吧! 访问我们： www.tukui.org!"

	-- buttons
	L.install_button_tutorial = "教程"
	L.install_button_install = "安装"
	L.install_button_next = "下一步"
	L.install_button_skip = "跳过"
	L.install_button_continue = "继续"
	L.install_button_finish = "完成"
	L.install_button_close = "关闭"
end