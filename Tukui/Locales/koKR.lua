local T, C, L = Tukui:unpack()

if (GetLocale() ~= "koKR") then
	return
end

------------------------------------------------
L.ChatFrames = {} -- Data Text Locales
------------------------------------------------

L.ChatFrames.LocalDefense = "수비"
L.ChatFrames.GuildRecruitment = "길드찾기"
L.ChatFrames.LookingForGroup = "파티찾기"

------------------------------------------------
L.DataText = {} -- Data Text Locales
------------------------------------------------

L.DataText.Voice = "음성채팅"
L.DataText.LootSpec = "전리품 전문화"
L.DataText.Garrison = "주둔지"
L.DataText.Zone = "지역"
L.DataText.AvoidanceBreakdown = "회피무시"
L.DataText.Level = "Lvl"
L.DataText.Boss = "우두머리"
L.DataText.Miss = "빗맞음"
L.DataText.Dodge = "피하기"
L.DataText.Block = "막기"
L.DataText.Parry = "비켜기"
L.DataText.Avoidance = "회피"
L.DataText.AvoidanceShort = "회피: "
L.DataText.Memory = "메모리"
L.DataText.Hit = "적중"
L.DataText.Power = "파워"
L.DataText.Mastery = "특화"
L.DataText.Crit = "치타"
L.DataText.Regen = "재생"
L.DataText.Versatility = "유연"
L.DataText.Leech = "생흡"
L.DataText.Multistrike = "다중타격"
L.DataText.Session = "세션: "
L.DataText.Earned = "획득:"
L.DataText.Spent = "소비:"
L.DataText.Deficit = "손해:"
L.DataText.Profit = "이익:"
L.DataText.Character = "캐릭터: "
L.DataText.Server = "서버: "
L.DataText.Gold = "소지금"
L.DataText.TotalGold = "합계: "
L.DataText.GoldShort = "|cffffd700g|r"
L.DataText.SilverShort = "|cffc7c7cfs|r"
L.DataText.CopperShort = "|cffeda55fc|r"
L.DataText.Talents = "특성"
L.DataText.NoTalent = "특성 없음"
L.DataText.Download = "다운로드: "
L.DataText.Bandwidth = "대역폭: "
L.DataText.Guild = "길드"
L.DataText.NoGuild = "길드 없음"
L.DataText.Bags = "가방"
L.DataText.BagSlots = "가방칸"
L.DataText.Friends = "친구"
L.DataText.Online = "접속 중: "
L.DataText.Armor = "방어구"
L.DataText.Durability = "내구도"
L.DataText.TimeTo = "시간"
L.DataText.FriendsList = "친구목록:"
L.DataText.Spell = "주문력"
L.DataText.AttackPower = "공격력"
L.DataText.Haste = "가속"
L.DataText.DPS = "DPS"
L.DataText.HPS = "HPS"
L.DataText.SavedRaid = "귀속 던전"
L.DataText.Currency = "화폐"
L.DataText.FPS = "FPS &"
L.DataText.MS = "MS"
L.DataText.FPSAndMS = "FPS & MS"
L.DataText.Critical = " 치명타"
L.DataText.Heal = " 치유"
L.DataText.Time = "시간"
L.DataText.ServerTime = "서버 시간: "
L.DataText.LocalTime = "지역 시간: "
L.DataText.Mitigation = "레벨 보정: "
L.DataText.Healing = "힐: "
L.DataText.Damage = "딜: "
L.DataText.Honor = "명예: "
L.DataText.KillingBlow = "학살: "
L.DataText.StatsFor = "능력치 "
L.DataText.HonorableKill = "명예승수:"
L.DataText.Death = "죽음:"
L.DataText.HonorGained = "명예 획득:"
L.DataText.DamageDone = "딜량:"
L.DataText.HealingDone = "힐량:"
L.DataText.BaseAssault = "기지 점령:"
L.DataText.BaseDefend = "기지 방어:"
L.DataText.TowerAssault = "탑 점령:"
L.DataText.TowerDefend = "탑 방어:"
L.DataText.FlagCapture = "뺏은 깃발:"
L.DataText.FlagReturn = "반환한 깃발:"
L.DataText.GraveyardAssault = "무덤 점령:"
L.DataText.GraveyardDefend = "무덤 방어:"
L.DataText.DemolisherDestroy = "분쇄자 파괴:"
L.DataText.GateDestroy = "성문 파괴:"
L.DataText.TotalMemory = "총 메모리 사용량:"
L.DataText.ControlBy = "지배당함:"
L.DataText.CallToArms = "전장의 부름"
L.DataText.ArmError = "전장의 부름 정보를 확인할 수 없습니다"
L.DataText.NoDungeonArm = "전장의 부름에 해당하는 던전이 없습니다"
L.DataText.CartControl = "조종한 카트:"
L.DataText.VictoryPts = "승점:"
L.DataText.OrbPossession = "소유한 구슬:"
L.DataText.Slots = {
	[1] = {1, "머리", 1000},
	[2] = {3, "어께", 1000},
	[3] = {5, "가슴", 1000},
	[4] = {6, "허리", 1000},
	[5] = {9, "손목", 1000},
	[6] = {10, "장갑", 1000},
	[7] = {7, "바지", 1000},
	[8] = {8, "발", 1000},
	[9] = {16, "주무기", 1000},
	[10] = {17, "보조무기", 1000},
	[11] = {18, "원거리 무기", 1000}
}

------------------------------------------------
L.Tooltips = {} -- Tooltips Locales
------------------------------------------------

L.Tooltips.MoveAnchor = "툴팁 이동"

------------------------------------------------
L.UnitFrames = {} -- Unit Frames Locales
------------------------------------------------

L.UnitFrames.Ghost = "유령"
L.UnitFrames.Wrath = "천벌"
L.UnitFrames.Starfire = "별빛"

------------------------------------------------
L.ActionBars = {} -- Action Bars Locales
------------------------------------------------

L.ActionBars.ArrowLeft = "◄"
L.ActionBars.ArrowRight = "►"
L.ActionBars.ArrowUp = "▲ ▲ ▲ ▲ ▲"
L.ActionBars.ArrowDown = "▼ ▼ ▼ ▼ ▼"
L.ActionBars.ExtraButton = "추가버튼"
L.ActionBars.CenterBar = "하단 중앙 바"
L.ActionBars.ActionButton1 = "메인바: 하단 중앙 아랫열 버튼 1"
L.ActionBars.ActionButton2 = "메인바: 하단 중앙 아랫열 버튼 2"
L.ActionBars.ActionButton3 = "메인바: 하단 중앙 아랫열 버튼 3"
L.ActionBars.ActionButton4 = "메인바: 하단 중앙 아랫열 버튼 4"
L.ActionBars.ActionButton5 = "메인바: 하단 중앙 아랫열 버튼 5"
L.ActionBars.ActionButton6 = "메인바: 하단 중앙 아랫열 버튼 6"
L.ActionBars.ActionButton7 = "메인바: 하단 중앙 아랫열 버튼 7"
L.ActionBars.ActionButton8 = "메인바: 하단 중앙 아랫열 버튼 8"
L.ActionBars.ActionButton9 = "메인바: 하단 중앙 아랫열 버튼 9"
L.ActionBars.ActionButton10 = "메인바: 하단 중앙 아랫열 버튼 10"
L.ActionBars.ActionButton11 = "메인바: 하단 중앙 아랫열 버튼 11"
L.ActionBars.ActionButton12 = "메인바: 하단 중앙 아랫열 버튼 12"
L.ActionBars.MultiActionBar1Button1 = "하단 좌측 아랫열 버튼 6"
L.ActionBars.MultiActionBar1Button2 = "하단 좌측 아랫열 버튼 5"
L.ActionBars.MultiActionBar1Button3 = "하단 좌측 아랫열 버튼 4"
L.ActionBars.MultiActionBar1Button4 = "하단 좌측 아랫열 버튼 3"
L.ActionBars.MultiActionBar1Button5 = "하단 좌측 아랫열 버튼 2"
L.ActionBars.MultiActionBar1Button6 = "하단 좌측 아랫열 버튼 1"
L.ActionBars.MultiActionBar1Button7 = "하단 좌측 윗열 버튼 6"
L.ActionBars.MultiActionBar1Button8 = "하단 좌측 윗열 버튼 5"
L.ActionBars.MultiActionBar1Button9 = "하단 좌측 윗열 버튼 4"
L.ActionBars.MultiActionBar1Button10 = "하단 좌측 윗열 버튼 3"
L.ActionBars.MultiActionBar1Button11 = "하단 좌측 윗열 버튼 2"
L.ActionBars.MultiActionBar1Button12 = "하단 좌측 윗열 버튼 1"
L.ActionBars.MultiActionBar2Button1 = "하단 우측 아랫열 버튼 1"
L.ActionBars.MultiActionBar2Button2 = "하단 우측 아랫열 버튼 2"
L.ActionBars.MultiActionBar2Button3 = "하단 우측 아랫열 버튼 3"
L.ActionBars.MultiActionBar2Button4 = "하단 우측 아랫열 버튼 4"
L.ActionBars.MultiActionBar2Button5 = "하단 우측 아랫열 버튼 5"
L.ActionBars.MultiActionBar2Button6 = "하단 우측 아랫열 버튼 6"
L.ActionBars.MultiActionBar2Button7 = "하단 우측 윗열 버튼 1"
L.ActionBars.MultiActionBar2Button8 = "하단 우측 윗열 버튼 2"
L.ActionBars.MultiActionBar2Button9 = "하단 우측 윗열 버튼 3"
L.ActionBars.MultiActionBar2Button10 = "하단 우측 윗열 버튼 4"
L.ActionBars.MultiActionBar2Button11 = "하단 우측 윗열 버튼 5"
L.ActionBars.MultiActionBar2Button12 = "하단 우측 윗열 버튼 6"
L.ActionBars.MultiActionBar4Button1 = "하단 중앙 윗열 버튼 1"
L.ActionBars.MultiActionBar4Button2 = "하단 중앙 윗열 버튼 2"
L.ActionBars.MultiActionBar4Button3 = "하단 중앙 윗열 버튼 3"
L.ActionBars.MultiActionBar4Button4 = "하단 중앙 윗열 버튼 4"
L.ActionBars.MultiActionBar4Button5 = "하단 중앙 윗열 버튼 5"
L.ActionBars.MultiActionBar4Button6 = "하단 중앙 윗열 버튼 6"
L.ActionBars.MultiActionBar4Button7 = "하단 중앙 윗열 버튼 7"
L.ActionBars.MultiActionBar4Button8 = "하단 중앙 윗열 버튼 8"
L.ActionBars.MultiActionBar4Button9 = "하단 중앙 윗열 버튼 9"
L.ActionBars.MultiActionBar4Button10 = "하단 중앙 윗열 버튼 10"
L.ActionBars.MultiActionBar4Button11 = "하단 중앙 윗열 버튼 11"
L.ActionBars.MultiActionBar4Button12 = "하단 중앙 윗열 버튼 12"
L.ActionBars.MoveStanceBar = "태세바 이동"

------------------------------------------------
L.Minimap = {} -- Minimap Locales
------------------------------------------------

L.Minimap.MoveMinimap = "미니맵 이동"

------------------------------------------------
L.Miscellaneous = {} -- Miscellaneous
------------------------------------------------

L.Miscellaneous.Repair = "경고! 빨리 수리하십시오!"
L.Miscellaneous.InQueue = "현재 던전 대기 중입니다"

------------------------------------------------
L.Auras = {} -- Aura Locales
------------------------------------------------

L.Auras.MoveBuffs = "버프 이동"
L.Auras.MoveDebuffs = "디버프 이동"

------------------------------------------------
L.Install = {} -- Installation of Tukui
------------------------------------------------

L.Install.Tutorial = "튜토리얼"
L.Install.Install = "설치"
L.Install.InstallStep0 = "Tukui를 선택해주셔서 감사합니다!|n|n간단히 몇 단계만 거치면 설치가 됩니다. 각 단계별로, 제시된 설정을 적용하거나 무시할 수 있습니다."
L.Install.InstallStep1 = [["첫 단계는 기본 설정입니다. 부분적인 설정만 적용하고 싶은 게 아니라면, 모두에게 |cffff0000권장|r됩니다.|n|n
'적용'을 눌러 설정을 적용하고, '다음'을 눌러 설치를 계속하세요.
이 단계를 건너뛰려면 '다음'을 누르세요."]]
L.Install.InstallStep2 = [["두번째 단계는 채팅 설정입니다. 새로운 사용자라면 이번 단계가 권장됩니다. 기존 사용자라면 이 단계를 건너뛸 수도 있습니다.|n|n
'적용'을 눌러 설정을 적용하고, '다음'을 눌러 설치를 계속하세요.
이 단계를 건너뛰려면 '다음'을 누르세요."]]
L.Install.InstallStep3 = "설치가 끝났습니다. '완료'를 누르면 UI를 다시 불러옵니다. Tukui와 함께 즐와하시고! www.tukui.org도 방문해보세요!"

------------------------------------------------
L.Help = {} -- /tukui help
------------------------------------------------

L.Help.Title = "Tukui 명령어:"
L.Help.Datatexts = "'|cff00ff00dt|r' or '|cff00ff00datatext|r' : 정보문자 설정"
L.Help.Install = "'|cff00ff00install|r' or '|cff00ff00reset|r' : Tukui를 설치하거나 초기화"
L.Help.Config = "'|cff00ff00c|r' or '|cff00ff00config|r' : 게임 내 설정창 불러오기"
L.Help.Move = "'|cff00ff00move|r' or '|cff00ff00moveui|r' : 프레임 이동"
L.Help.Test = "'|cff00ff00test|r' or '|cff00ff00testui|r' : 유닛프레임 데모 보기"
L.Help.Profile = "'|cff00ff00profile|r' or '|cff00ff00p|r' : 다른 캐릭터의 Tukui 설정(프로필) 사용"
L.Help.Grid = "'|cff00ff00grid|r' or '|cff00ff00grid 128|r' : 쉬운 배치를 위해 화면에 격자 표시 (128을 다른 값으로 바꿀 수 있음)"
L.Help.Status = "'|cff00ff00status|r' or '|cff00ff00debug|r' : UI 버그를 살펴보기 위해 디버그 창을 띄움"

------------------------------------------------
L.Merchant = {} -- Merchant
------------------------------------------------

L.Merchant.NotEnoughMoney = "수리비가 모자랍니다!"
L.Merchant.RepairCost = "사용된 수리비: "
L.Merchant.SoldTrash = "잡템을 팔아서 번 돈:"

------------------------------------------------
L.Version = {} -- Version Check
------------------------------------------------

L.Version.Outdated = "Tukui의 새 버전이 나왔습니다. www.tukui.org에서 최신 버전을 다운로드 하세요."

------------------------------------------------
L.Others = {} -- Miscellaneous
------------------------------------------------

L.Others.GlobalSettings = "전역 설정 사용"
L.Others.CharSettings = "캐릭터별 설정 사용"
L.Others.ProfileNotFound = "프로필을 찾을 수 없음"
L.Others.ProfileSelection = "사용할 프로필을 적어주세요 (예: /tukui profile Illidan-Tukz)"
L.Others.ConfigNotFound = "설정을 불러오지 않았습니다"
L.Others.ResolutionChanged = "와우의 해상도 변경이 감지되었습니다. UI를 다시 불러오는 것을 강력 추천합니다. 그렇게 하시겠습니까?"
