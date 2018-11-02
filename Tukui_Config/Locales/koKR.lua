-- Some postfix's for certain controls.
local Performance = "\n|cffFF0000비활성화하면 성능이 향상될 수 있습니다|r" -- For high CPU options
local PerformanceSlight = "\n|cffFF0000비활성화하면 성능이 약간 향상될 수 있습니다|r" -- For semi-high CPU options
local RestoreDefault = "\n|cffFFFF00초기화하려면 마우스 오른쪽 버튼 클릭|r" -- For color pickers

TukuiConfig["koKR"] = {
	["General"] = {
		["BackdropColor"] = {
			["Name"] = "배경화면 색",
			["Desc"] = "Tukui 배경화면색 일괄 설정"..RestoreDefault,
		},

		["BorderColor"] = {
			["Name"] = "테두리 색",
			["Desc"] = "Tukui 테두리 색 일괄 설정"..RestoreDefault,
		},

		["HideShadows"] = {
			["Name"] = "그림자 감추기",
			["Desc"] = "특정 프레임의 그림자를 감추거나 표시",
		},

		["Scaling"] = {
			["Name"] = "UI 스케일",
			["Desc"] = "유저 인터페이스 크기 비율을 설정하세요",
		},

		["Themes"] = {
			["Name"] = "테마",
			["Desc"] = "테마를 적용하세요",
		},

		["AFKSaver"] = {
			["Name"] = "자리비움 화면보호기",
			["Desc"] = "자리비움 화면보호기 사용",
		},
	},

	["ActionBars"] = {
		["Enable"] = {
			["Name"] = "행동 바 사용",
			["Desc"] = "ㅇㅇ",
		},

		["AddNewSpells"] = {
			["Name"] = "Automatically Add New Spells",
			["Desc"] = "Derp",
		},

		["EquipBorder"] = {
			["Name"] = "착용한 아이템 테두리",
			["Desc"] = "착용한 아이템은 녹색 테두리로 보임",
		},

		["HotKey"] = {
			["Name"] = "단축키",
			["Desc"] = "단축키 표시",
		},

		["Macro"] = {
			["Name"] = "매크로 이름",
			["Desc"] = "매크로 이름 표시",
		},

		["ShapeShift"] = {
			["Name"] = "태세 바",
			["Desc"] = "Tukui 스타일 태세 바 사용",
		},

		["Pet"] = {
			["Name"] = "소환수 바",
			["Desc"] = "Tukui 스타일 소환수 바 사용",
		},

		["SwitchBarOnStance"] = {
			["Name"] = "태세에 따라 주 행동 바 전환",
			["Desc"] = "태세에 맞춰 주 행동 바가 바뀝니다",
		},

		["NormalButtonSize"] = {
			["Name"] = "버튼 크기",
			["Desc"] = "행동 바 버튼의 크기 설정",
		},

		["PetButtonSize"] = {
			["Name"] = "소환수 버튼 크기",
			["Desc"] = "소환수 바 버튼 크기 설정",
		},

		["ButtonSpacing"] = {
			["Name"] = "버튼 간격",
			["Desc"] = "버튼 간격 설정",
		},

		["HideBackdrop"] = {
			["Name"] = "배경 숨기기",
			["Desc"] = "행동 바 배경을 숨김",
		},

		["Font"] = {
			["Name"] = "행동 바 폰트",
			["Desc"] = "행동 바의 폰트를 설정",
		},
	},

	["Auras"] = {
		["Enable"] = {
			["Name"] = "버프/디버프 사용",
			["Desc"] = "ㅇㅇ",
		},

		["Flash"] = {
			["Name"] = "버프/디버프 깜빡임",
			["Desc"] = "시간이 얼마 남지 않은 버프/디버프는 깜빡입니다"..PerformanceSlight,
		},

		["ClassicTimer"] = {
			["Name"] = "옛 스타일 타이머",
			["Desc"] = "버프/디버프 밑에 남은 시간으로 표시",
		},

		["HideBuffs"] = {
			["Name"] = "버프 숨김",
			["Desc"] = "버프를 표시하지 않음",
		},

		["HideDebuffs"] = {
			["Name"] = "디버프 숨김",
			["Desc"] = "디버프를 표시하지 않음",
		},

		["Animation"] = {
			["Name"] = "애니메이션",
			["Desc"] = "버프/디버프가 추가될 때 애니메이션 적용"..PerformanceSlight,
		},

		["BuffsPerRow"] = {
			["Name"] = "줄 당 버프 수",
			["Desc"] = "한 줄에 표시할 버프 갯수 설정",
		},

		["Font"] = {
			["Name"] = "버프/디버프 폰트",
			["Desc"] = "버프/디버프에 적용할 폰트 설정",
		},
	},

	["Bags"] = {
		["Enable"] = {
			["Name"] = "가방 사용",
			["Desc"] = "ㅇㅇ",
		},

		["ButtonSize"] = {
			["Name"] = "슬롯 크기",
			["Desc"] = "가방 슬롯의 크기 설정",
		},

		["Spacing"] = {
			["Name"] = "간격",
			["Desc"] = "가방 슬롯 간의 간격 설정",
		},

		["ItemsPerRow"] = {
			["Name"] = "줄 당 아이템 수",
			["Desc"] = "가방 한 줄에 표시할 아이템 수 설정",
		},

		["PulseNewItem"] = {
			["Name"] = "새 아이템 깜빡임",
			["Desc"] = "가방의 새 아이템은 깜빡이는 효과로 표시",
		},

		["Font"] = {
			["Name"] = "가방 폰트",
			["Desc"] = "가방에 적용할 폰트 설정",
		},
	},

	["Chat"] = {
		["Enable"] = {
			["Name"] = "채팅창 사용",
			["Desc"] = "ㅇㅇ",
		},

		["WhisperSound"] = {
			["Name"] = "귓말 알림",
			["Desc"] = "귓말이 오면 소리로 알림",
		},

		["LinkColor"] = {
			["Name"] = "URL 링크 색상",
			["Desc"] = "URL 링크의 색상을 설정"..RestoreDefault,
		},

		["LinkBrackets"] = {
			["Name"] = "URL 링크 괄호",
			["Desc"] = "URL 링크를 괄호 안에 표시",
		},

		["Background"] = {
			["Name"] = "채팅창 배경",
			["Desc"] = "좌/우측 채팅창 배경 설정",
		},

		["ChatFont"] = {
			["Name"] = "채팅 폰트",
			["Desc"] = "채팅에 적용할 폰트 설정",
		},

		["TabFont"] = {
			["Name"] = "채팅 탭 폰트",
			["Desc"] = "채팅 탭에 적용할 폰트 설정",
		},

		["ScrollByX"] = {
			["Name"] = "마우스 스크롤",
			["Desc"] = "한 번의 스크롤로 넘길 채팅줄 갯수 설정",
		},

		["ShortChannelName"] = {
			["Name"] = "채널 이름 줄이기",
			["Desc"] = "채팅 채널의 이름을 간략히 표시",
		},
	},

	["Cooldowns"] = {
		["Font"] = {
			["Name"] = "쿨타운 폰트",
			["Desc"] = "쿨타운에 적용할 폰트 설정",
		},
	},

	["DataTexts"] = {
		["Battleground"] = {
			["Name"] = "전장 사용",
			["Desc"] = "전장 정보를 나타내는 데이터 텍스트 사용",
		},

		["LocalTime"] = {
			["Name"] = "현지 시간",
			["Desc"] = "서버 시간 대신 현지 시간 사용",
		},

		["Time24HrFormat"] = {
			["Name"] = "24시 형식",
			["Desc"] = "시간을 24시 형식으로 표시",
		},

		["NameColor"] = {
			["Name"] = "라벨 컬러",
			["Desc"] = "데이터 텍스트의 라벨 색상 설정. 주로 항목 이름임"..RestoreDefault,
		},

		["ValueColor"] = {
			["Name"] = "값 컬러",
			["Desc"] = "데이터 텍스트의 값 색상 설정. 주로 항목 숫자임"..RestoreDefault,
		},

		["Font"] = {
			["Name"] = "데이터 텍스트 폰트",
			["Desc"] = "데이터 텍스트에 적용할 폰트 설정",
		},
	},

	["Loot"] = {
		["Enable"] = {
			["Name"] = "루팅창 사용",
			["Desc"] = "Tukui 전용 루팅창 사용",
		},

		["StandardLoot"] = {
			["Name"] = "블리자르 루팅 윈도우",
			["Desc"] = "Tukui 전용 루팅창 대신 블리자드 기본 윈도우 사용",
		},
	},

	["Merchant"] = {
		["AutoSellGrays"] = {
			["Name"] = "회색템 자동 판매",
			["Desc"] = "상인을 만나면 자동으로 회색템 판매",
		},

		["AutoRepair"] = {
			["Name"] = "자동수리",
			["Desc"] = "수리 상인을 만나면, 자동으로 아이템 수리",
		},

		["UseGuildRepair"] = {
			["Name"] = "길드 수리 사용",
			["Desc"] = "자동수리 활성화 시, 길드 지원금으로 수리",
		},
	},

	["Misc"] = {
		["ThreatBarEnable"] = {
			["Name"] = "위협바 사용",
			["Desc"] = "ㅇㅇ",
		},

		["AltPowerBarEnable"] = {
			["Name"] = "대체 파워바 사용",
			["Desc"] = "ㅇㅇ",
		},

		["ExperienceEnable"] = {
			["Name"] = "경험치 바 사용",
			["Desc"] = "화면 좌/우측에 경험치 바 표시",
		},

		["ReputationEnable"] = {
			["Name"] = "평판 바 사용",
			["Desc"] = "화면 좌/우측에 평판 바 표시",
		},

		["ErrorFilterEnable"] = {
			["Name"] = "오류 필터링 사용",
			["Desc"] = "몇 가지 오류 메시지를 표시하지 않음",
		},

		["AutoInviteEnable"] = {
			["Name"] = "초대 자동수락",
			["Desc"] = "친구나 길드원으로부터 초대를 자동으로 수락함",
		},

		["TalkingHeadEnable"] = {
			["Name"] = "말풍선 표시",
			["Desc"] = "블리자드 기본 말풍선 표시",
		},
	},

	["NamePlates"] = {
		["Enable"] = {
			["Name"] = "네임바 표시",
			["Desc"] = "ㅇㅇ"..PerformanceSlight,
		},

		["Width"] = {
			["Name"] = "너비 설정",
			["Desc"] = "네임바 너비 설정",
		},

		["Height"] = {
			["Name"] = "높이 설정",
			["Desc"] = "네임바 높이 설정",
		},

		["CastHeight"] = {
			["Name"] = "시전바 높이 설정",
			["Desc"] = "네임바에 표시할 시전바의 높이 설정",
		},

		["Font"] = {
			["Name"] = "네임바 폰트",
			["Desc"] = "네임바에 적용할 폰트 설정",
		},

		["OnlySelfDebuffs"] = {
			["Name"] = "내 디버프만 표시",
			["Desc"] = "네임바에 내 디버프만 표시함",
		},
	},

	["Party"] = {
		["Enable"] = {
			["Name"] = "파티 프레임 사용",
			["Desc"] = "ㅇㅇ",
		},

		["HealBar"] = {
			["Name"] = "예측 힐",
			["Desc"] = "들어오는 힐이나 흡수를 표시",
		},

		["ShowPlayer"] = {
			["Name"] = "본인 표시",
			["Desc"] = "파티에 본인을 표시함",
		},

		["ShowHealthText"] = {
			["Name"] = "생명력 수치",
			["Desc"] = "부족한 생명력 수치를 표시함",
		},

		["Font"] = {
			["Name"] = "파티 프레임 폰트",
			["Desc"] = "파티 프레임에서 이름에 적용할 폰트 설정",
		},

		["HealthFont"] = {
			["Name"] = "파티 프레임 생명력 폰트",
			["Desc"] = "파티 프레임에서 생명력에 적용할 폰트 설정",
		},

		["RangeAlpha"] = {
			["Name"] = "범위 밖 투명도",
			["Desc"] = "범위를 벗어났을 때 투명도 설정",
		},
	},

	["Raid"] = {
		["Enable"] = {
			["Name"] = "레이드 프레임 사용",
			["Desc"] = "ㅇㅇ",
		},

		["ShowPets"] = {
			["Name"] = "소환수 보이기",
			["Desc"] = "ㅇㅇ",
		},

		["MaxUnitPerColumn"] = {
			["Name"] = "한 열 당 멤버수",
			["Desc"] = "한 열에 보일 멤버수 설정",
		},

		["HealBar"] = {
			["Name"] = "예측 힐",
			["Desc"] = "들어오는 힐이나 흡수를 표시",
		},

		["AuraWatch"] = {
			["Name"] = "오라워치 사용",
			["Desc"] = "레이드 프레임 네 귀퉁이에 직업별 버프 타이머 표시",
		},

		["AuraWatchTimers"] = {
			["Name"] = "오라워치 타이머",
			["Desc"] = "레이드 프레임 네 귀퉁이에 직업별 디버프 타이머 표시",
		},

		["DebuffWatch"] = {
			["Name"] = "디버프 워치",
			["Desc"] = "중요 디버프를 가운데 큰 아이콘으로 표시",
		},

		["RangeAlpha"] = {
			["Name"] = "범위 밖 투명도",
			["Desc"] = "범위를 벗어났을 때 투명도 설정",
		},

		["ShowRessurection"] = {
			["Name"] = "부활 아이콘 보이기",
			["Desc"] = "부활을 시전받는 플레이어의 아이콘 표시",
		},

		["ShowHealthText"] = {
			["Name"] = "생명력 수치",
			["Desc"] = "부족한 생명력 수치로 표시",
		},

		["VerticalHealth"] = {
			["Name"] = "세로 생명력 바",
			["Desc"] = "생명력이 세로로 변함",
		},

		["Font"] = {
			["Name"] = "레이드 프레임 이름 폰트",
			["Desc"] = "레이드 프레임에서 이름에 적용할 폰트 설정",
		},

		["HealthFont"] = {
			["Name"] = "레이드 프레임 생명력 폰트",
			["Desc"] = "레이드 프레임에서 생명력 수치에 적용할 폰트 설정",
		},

		["GroupBy"] = {
			["Name"] = "그룹",
			["Desc"] = "레이드 그룹을 어떻게 정렬할지 선택",
		},
	},

	["Tooltips"] = {
		["Enable"] = {
			["Name"] = "툴팁 사용",
			["Desc"] = "ㅇㅇ",
		},

		["MouseOver"] = {
			["Name"] = "마우스오버",
			["Desc"] = "마우스오버 툴팁 사용",
		},

		["HideOnUnitFrames"] = {
			["Name"] = "유닛프레임에는 숨김",
			["Desc"] = "유닛프레임에는 툴팁을 표시하지 않음",
		},

		["UnitHealthText"] = {
			["Name"] = "생명력 수치 표시",
			["Desc"] = "툴팁 생명력 바에 생명력 수치 표시",
		},

		["ShowSpec"] = {
			["Name"] = "전문화와 아이템 레벨",
			["Desc"] = "ALT키를 누르고 있으면, 전문화와 아이템 레벨이 툴팁에 표시됨",
		},

		["HealthFont"] = {
			["Name"] = "생명력 바 폰트",
			["Desc"] = "툴팁 하단에 나타날 생명력 바에 적용할 폰트 설정",
		},
	},

	["Textures"] = {
		["QuestProgressTexture"] = {
			["Name"] = "퀘스트 [진행]",
		},

		["TTHealthTexture"] = {
			["Name"] = "툴팁 [생명력]",
		},

		["UFPowerTexture"] = {
			["Name"] = "유닛프레임 [파워]",
		},

		["UFHealthTexture"] = {
			["Name"] = "유닛프레임 [생명력]",
		},

		["UFCastTexture"] = {
			["Name"] = "유닛프레임 [시전]",
		},

		["UFPartyPowerTexture"] = {
			["Name"] = "유닛프레임 [파티원 파워]",
		},

		["UFPartyHealthTexture"] = {
			["Name"] = "유닛프레임 [파티원 생명력]",
		},

		["UFRaidPowerTexture"] = {
			["Name"] = "유닛프레임 [레이드 파워]",
		},

		["UFRaidHealthTexture"] = {
			["Name"] = "유닛프레임 [레이드 생명력]",
		},

		["NPHealthTexture"] = {
			["Name"] = "네임바 [생명력]",
		},

		["NPPowerTexture"] = {
			["Name"] = "네임바 [파워]",
		},

		["NPCastTexture"] = {
			["Name"] = "네임바 [시전]",
		},
	},

	["UnitFrames"] = {
		["Enable"] = {
			["Name"] = "유닛프레임 사용",
			["Desc"] = "ㅇㅇ",
		},

		["TargetEnemyHostileColor"] = {
			["Name"] = "적 대상의 적대적 색상",
			["Desc"] = "대상이 적일 경우, 직업 색상 대신 적대적 정도에 따라 생명력 색상을 표시",
		},

		["Portrait"] = {
			["Name"] = "플레이어와 대상의 초상화 사용",
			["Desc"] = "플레이어와 대상의 초상화 사용",
		},

		["CastBar"] = {
			["Name"] = "시전 바",
			["Desc"] = "유닛프레임에서 시전 바 사용",
		},

		["UnlinkCastBar"] = {
			["Name"] = "시전 바 분리",
			["Desc"] = "플레이어와 대상의 시전 바를 분리하여 아무 곳에나 배치할 수 있음",
		},

		["CastBarIcon"] = {
			["Name"] = "시전 바 아이콘",
			["Desc"] = "시전 바 옆에 아이콘으로 표시",
		},

		["CastBarLatency"] = {
			["Name"] = "시전 바 지연",
			["Desc"] = "시전 바에 지연시간을 표시",
		},

		["Smooth"] = {
			["Name"] = "부드러운 바",
			["Desc"] = "생명력 바의 업데이트를 부드럽게 함"..PerformanceSlight,
		},

		["CombatLog"] = {
			["Name"] = "전투 피드백",
			["Desc"] = "받는 힐과 데미지를 따로 표시함",
		},

		["WeakBar"] = {
			["Name"] = "약화된 영혼 바",
			["Desc"] = "약화된 영혼(사제 보호막)의 디버프를 표시함",
		},

		["HealBar"] = {
			["Name"] = "들어오는 힐",
			["Desc"] = "들어오는 힐과 흡수되는 양을 표시",
		},

		["TotemBar"] = {
			["Name"] = "토템 바",
			["Desc"] = "Tukui 스타일의 토템 바 사용",
		},

		["ComboBar"] = {
			["Name"] = "콤보 포인트",
			["Desc"] = "콤보 포인트 바 사용",
		},

		["OnlySelfDebuffs"] = {
			["Name"] = "내 디버프만 표시",
			["Desc"] = "네임바에 내 디버프만 표시",
		},

		["OnlySelfBuffs"] = {
			["Name"] = "내 버프만 표시",
			["Desc"] = "네임바에 내 버프만 표시",
		},

		["Threat"] = {
			["Name"] = "위협 수준 표시",
			["Desc"] = "파티창이나 레이드창에서 어그로를 먹으면, 생명력 바가 빨간색으로 변함",
		},

		["Arena"] = {
			["Name"] = "투기장 프레임",
			["Desc"] = "전장이나 투기장 안에서 상대편을 표시",
		},

		["Boss"] = {
			["Name"] = "보스 프레임",
			["Desc"] = "레이드나 야외 우두머리의 프레임을 표시",
		},

		["TargetAuras"] = {
			["Name"] = "대상 버프/디버프",
			["Desc"] = "대상의 버프와 디버프를 표시",
		},

		["FocusAuras"] = {
			["Name"] = "주시대상 버프/디버프",
			["Desc"] = "주시대상의 버프와 디버프를 표시함",
		},

		["FocusTargetAuras"] = {
			["Name"] = "주시대상의 대상 버프/디버프",
			["Desc"] = "주시대상의 대상의 버프와 디버프를 표시함",
		},

		["ArenaAuras"] = {
			["Name"] = "투기장 프레임 디버프",
			["Desc"] = "투기장 프레임에서 상대방의 디버프를 표시",
		},

		["BossAuras"] = {
			["Name"] = "보스 프레임 디버프",
			["Desc"] = "보스 프레임에서 보스에 걸린 디버프를 표시",
		},

		["AltPowerText"] = {
			["Name"] = "대체파워 수치",
			["Desc"] = "대체파워바에서 파워 수치를 표시",
		},

		["Font"] = {
			["Name"] = "유닛프레임 폰트",
			["Desc"] = "유닛프레임에 적용할 폰트 설정",
		},
	},
}
