if GetLocale() == "koKR" then

	-- update needed msg
	TukuiL.option_update = "Tukui 최종 변경으로 인하여 당신의 Tukui ConfigUI를 업데이트 해야합니다.(www.tukui.org 방문해주세요.)"
	
	-- general
	TukuiL.option_general = "일반"
	TukuiL.option_general_uiscale = "자동으로 UI크기를 조절"
	TukuiL.option_general_override = "저해상도에서 고해상도 버전의 개체창을 사용"
	TukuiL.option_general_multisample = "멀티샘플링을 항상 1배로 유지 (깨끗한 선)"
	TukuiL.option_general_customuiscale = "UI크기 (autoscale이 꺼져 있을 때)"
	TukuiL.option_general_backdropcolor = "판넬 기본 배경 색상 설정"
	TukuiL.option_general_bordercolor = "판넬 기본 테두리 색상 설정"
 
	-- nameplate
	TukuiL.option_nameplates = "이름표"
	TukuiL.option_nameplates_enable = "이름표를 사용"
	TukuiL.option_nameplates_enhancethreat = "위협수준 기능 사용, 당신의 역할에 따라 자동적으로 변경됨"
	TukuiL.option_nameplates_showhealth = "생명력을 표시"
	TukuiL.option_nameplates_combat = "전투 중에만 표시"
	TukuiL.option_nameplates_goodcolor = "Good threat color, varies depending if your a tank or dps/heal"
	TukuiL.option_nameplates_badcolor = "Bad threat color, varies depending if your a tank or dps/heal"
	TukuiL.option_nameplates_transitioncolor = "Losing/Gaining threat color"
 
	-- merchant
	TukuiL.option_merchant = "상점"
	TukuiL.option_merchant_autosell = "회색 아이템의 자동판매를 사용"
	TukuiL.option_merchant_autorepair = "자동수리를 사용"
	TukuiL.option_merchant_sellmisc = "Sell some defined (craps not gray) items automatically"
 
	-- bags
	TukuiL.option_bags = "가방"
	TukuiL.option_bags_enable = "단일가방을 사용"
 
	-- datatext
	TukuiL.option_datatext = "정보 글자"
	TukuiL.option_datatext_24h = "24시 주기로 시간을 설정"
	TukuiL.option_datatext_localtime = "서버시간이 아닌 지역시간으로 설정"
	TukuiL.option_datatext_bg = "전장정보를 보여줌"
	TukuiL.option_datatext_hps = "초당 치유량"
	TukuiL.option_datatext_guild = "접속 중인 길드 원의 수"
	TukuiL.option_datatext_arp = "방어구 관통력"
	TukuiL.option_datatext_mem = "총 메모리 사용량"
	TukuiL.option_datatext_bags = "소지품 여유 공간"
	TukuiL.option_datatext_fontsize = "정보 글자의 글꼴크기"
	TukuiL.option_datatext_fps_ms = "초당 프레임 수와 지연시간"
	TukuiL.option_datatext_armor = "동일 레벨 대상에 대한 플레이어의 방어도"
	TukuiL.option_datatext_avd = "동일 레벨 대상에 대한 플레이어의 완방 수치"
	TukuiL.option_datatext_power = "전투력, 주문력, 치유력, 원거리전투력 중 높은 것"
	TukuiL.option_datatext_haste = "가속도"
	TukuiL.option_datatext_friend = "접속 중인 친구의 수"
	TukuiL.option_datatext_time = "시간"
	TukuiL.option_datatext_gold = "보유 중인 골드"
	TukuiL.option_datatext_dps = "초당 피해량"
	TukuiL.option_datatext_crit = "치명타 및 주문 극대화 적중도"
	TukuiL.option_datatext_dur = "장비의 내구도"	
	TukuiL.option_datatext_currency = "화폐 위치 (0 이면 미사용)"
	TukuiL.option_datatext_micromenu = "마이크로 메뉴 위치 (0 이면 미사용)"
	TukuiL.option_datatext_hit = "적중도 위치 (0 이면 미사용)"--@@
	TukuiL.option_datatext_mastery = "특화도 위치 (0 이면 미사용)"--@@
 
	-- unit frames
	TukuiL.option_unitframes_unitframes = "개체창"
	TukuiL.option_unitframes_combatfeedback = "플레이어창과 대상창에 받는 피해량 및 치유량을 보여줌"
	TukuiL.option_unitframes_runebar = "죽음의 기사 룬바를 사용"
	TukuiL.option_unitframes_auratimer = "강화 및 약화 효과의 지속시간 타이머를 사용"
	TukuiL.option_unitframes_totembar = "주술사 토템 타이머를 사용"
	TukuiL.option_unitframes_totalhpmp = "체력과 마나를 '현재/전체'로 보여줌"
	TukuiL.option_unitframes_playerparty = "파티창에 자신을 보여줌"
	TukuiL.option_unitframes_aurawatch = "공격대 약화 효과를 보여줌 (힐러용 공격대 인터페이스)"
	TukuiL.option_unitframes_castbar = "시전바를 사용"
	TukuiL.option_unitframes_targetaura = "대상창에 강화 및 약화 효과를 보여줌"
	TukuiL.option_unitframes_saveperchar = "개체창의 위치를 캐릭터별로 저장"
	TukuiL.option_unitframes_playeraggro = "위협수준이 증가하면 강조"
	TukuiL.option_unitframes_smooth = "부드러운 바를 사용"
	TukuiL.option_unitframes_portrait = "플레이어와 대상의 초상화를 보여줌"
	TukuiL.option_unitframes_enable = "Tukui 개체창을 사용"
	TukuiL.option_unitframes_enemypower = "PVP대상만 분노, 기력 등의 글자를 보여줌"
	TukuiL.option_unitframes_gridonly = "힐러용 인터페이스일 때 격자모양으로 설정"
	TukuiL.option_unitframes_healcomm = "Healcomm 기능을 사용"
	TukuiL.option_unitframes_focusdebuff = "주시대상의 약화 효과를 보여줌"
	TukuiL.option_unitframes_raidaggro = "위협수준이 높은 공격대원을 강조"
	TukuiL.option_unitframes_boss = "우두머리 개체창을 사용"
	TukuiL.option_unitframes_enemyhostilitycolor = " 적대감에 의존한 대상창 바의 색을 사용"
	TukuiL.option_unitframes_hpvertical = "힐러용 인터페이스일 때 체력이 세로로 줄어듬"
	TukuiL.option_unitframes_symbol = "공격대 인터페이스에 전술 목표 아이콘을 보여줌"
	TukuiL.option_unitframes_threatbar = "위협수준 바를 사용"
	TukuiL.option_unitframes_enablerange = "공격대 인터페이스에 거리에 따른 투명도를 사용"
	TukuiL.option_unitframes_focus = "주시대상의 대상을 보여줌"
	TukuiL.option_unitframes_latency = "시전바에 지연시간을 보여줌"
	TukuiL.option_unitframes_icon = "시전바에 아이콘을 보여줌"
	TukuiL.option_unitframes_playeraura = "플레이어창 위에 강화 및 약화 효과를 보여줌"
	TukuiL.option_unitframes_aurascale = "강화 및 약화 효과 지속시간의 글꼴크기"
	TukuiL.option_unitframes_gridscale = "공격대 인터페이스의 크기"
	TukuiL.option_unitframes_manahigh = "마나가 높으면 경고를 보여줌 (사냥꾼 전용)"
	TukuiL.option_unitframes_manalow = "마나가 낮으면 경고를 보여줌"
	TukuiL.option_unitframes_range = "거리에 따른 투명도 수치"
	TukuiL.option_unitframes_maintank = "방어 전담창을 사용"
	TukuiL.option_unitframes_mainassist = "지원공격 전담창을 사용"
	TukuiL.option_unitframes_unicolor = "직업색상을 사용"
	TukuiL.option_unitframes_totdebuffs = "대상의 대상의 약화 효과를 보여줌 (고해상도 전용)"
	TukuiL.option_unitframes_classbar = "직업 바 사용"
	TukuiL.option_unitframes_weakenedsoulbar = "약화된 영혼 알림바 사용 (사제)"
	TukuiL.option_unitframes_focus = "주시대상의 대상을 보여줌"
	TukuiL.option_unitframes_bordercolor = "유닛프레임 기본 테두리 색상 설정"

 
	-- loot
	TukuiL.option_loot = "전리품"
	TukuiL.option_loot_enableloot = "전리품 획득창을 사용"
	TukuiL.option_loot_autogreed = "만렙일 때 자동차비 또는 자동마출을 사용"
	TukuiL.option_loot_enableroll = "주사위창을 사용"
 
	-- map
	TukuiL.option_map = "지도"
	TukuiL.option_map_enable = "세계 지도를 사용"
 
	-- invite
	TukuiL.option_invite = "자동수락"
	TukuiL.option_invite_autoinvite = "길드원이나 친구에게서 온 초대에 대한 자동수락을 사용"
 
	-- tooltip
	TukuiL.option_tooltip = "툴팁"
	TukuiL.option_tooltip_enable = "툴팁을 사용"
	TukuiL.option_tooltip_hidecombat = "전투시 툴팁을 숨김"
	TukuiL.option_tooltip_hidebutton = "행동 단축버튼의 툴팁을 숨김"
	TukuiL.option_tooltip_hideuf = "개체창의 툴팁을 숨김"
	TukuiL.option_tooltip_cursor = "커서 툴팁 사용"
 
	-- others
	TukuiL.option_others = "기타"
	TukuiL.option_others_bg = "전장에서 자동부활을 사용"
 
	-- reminder
	TukuiL.option_reminder = "경고"
	TukuiL.option_reminder_enable = "보호막, 상, 외침 등에 대한 경고를 사용"
	TukuiL.option_reminder_sound = "경고 소리를 사용"
 
	-- error
	TukuiL.option_error = "오류메세지"
	TukuiL.option_error_hide = "화면 중앙의 오류메세지를 숨김"
 
	-- action bar
	TukuiL.option_actionbar = "행동 단축바"
	TukuiL.option_actionbar_hidess = "특수 기술 단축바를 숨김"
	TukuiL.option_actionbar_showgrid = "빈 행동 단축버튼을 보여줌"
	TukuiL.option_actionbar_enable = "Tukui 행동 단축바를 사용"
	TukuiL.option_actionbar_rb = "우측측 바를 커서가 위치했을 때 보여줌"
	TukuiL.option_actionbar_hk = "행동 단축바에 단축키를 보여줌"
	TukuiL.option_actionbar_ssmo = "특수 기술 단축바를 커서가 위치했을 때 보여줌"
	TukuiL.option_actionbar_rbn = "하단 단축바의 줄의 수 (1 또는 2)"
	TukuiL.option_actionbar_rn = "우측 단축바의 줄의 수 (0부터 3까지, 하단 단축바의 줄의 수가 2인 경우 0 또는 1)"
	TukuiL.option_actionbar_buttonsize = "행동 단축버튼의 크기"
	TukuiL.option_actionbar_buttonspacing = "행동 단축버튼의 간격"
	TukuiL.option_actionbar_petbuttonsize = "펫/태세 버튼의 크기"
	
	-- quest watch frame
	TukuiL.option_quest = "임무 추적기"
	TukuiL.option_quest_movable = "임무 추적기 이동을 사용"
 
	-- arena
	TukuiL.option_arena = "투기장"
	TukuiL.option_arena_st = "상대 플레이어의 주문 추적을 사용"
	TukuiL.option_arena_uf = "투기장 상대 플레이어창을 사용 (Tukui 개체창을 사용 중이어야 함)"
	
	-- pvp
	TukuiL.option_pvp = "PVP"
	TukuiL.option_pvp_ii = "방해 아이콘을 사용"
 
	-- cooldowns
	TukuiL.option_cooldown = "재사용 대기시간"
	TukuiL.option_cooldown_enable = "재사용 대기시간 문자를 보여줌"
	TukuiL.option_cooldown_th = "몇 초 아래로 내려갔을 때 글자가 빨간색으로 변하고 소수점 이하도 보여줄지 설정"
 
	-- chat
	TukuiL.option_chat = "커뮤니티"
	TukuiL.option_chat_enable = "Tukui 대화창을 사용"
	TukuiL.option_chat_whispersound = "귓속말을 받았을때 소리 출력"
	TukuiL.option_chat_background = "채팅 패널 배경 사용"

	-- buff
	TukuiL.option_auras = "Auras"
	TukuiL.option_auras_player = "Enable Tukui Buff/Debuff Frames"
	
	-- buttons
	TukuiL.option_button_reset = "초기화"
	TukuiL.option_button_load = "불러오기"
	TukuiL.option_button_close = "닫기"
	TukuiL.option_setsavedsetttings = "캐릭터별로 저장"
	TukuiL.option_resetchar = "해당 캐릭터의 설정을 기본 설정으로 초기화하시겠습니까?"
	TukuiL.option_resetall = "모든 캐릭터의 설정을 기본 설정으로 초기화하시겠습니까?"
	TukuiL.option_perchar = "설정을 캐릭터별로 저장하시겠습니까?"
	TukuiL.option_makeselection = "계속하기전에 선택을 해야합니다."	
end