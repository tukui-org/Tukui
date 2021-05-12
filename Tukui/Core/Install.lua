local T, C, L = select(2, ...):unpack()

local Install = CreateFrame("Frame", nil, UIParent)

-- Create a Tukui popup for resets
T.Popups.Popup["TUKUI_RESET_SETTINGS"] = {
	Question = "This will clear all of your saved settings. Continue?",
	Answer1 = ACCEPT,
	Answer2 = CANCEL,
	Function1 = function(self)
		Install.ResetSettings()

		ReloadUI()
	end,
}

-- Reset GUI settings
function Install:ResetSettings()
	TukuiDatabase.Settings[T.MyRealm][T.MyName] = {}
end

-- Reset datatext & chats
function Install:ResetData()
	if (T.DataTexts) then
		T.DataTexts:Reset()
	end

	TukuiDatabase.Variables[T.MyRealm][T.MyName] = {}

	FCF_ResetChatWindows()

	if ChatConfigFrame:IsShown() then
		ChatConfig_UpdateChatSettings()
	end

	ReloadUI()
end

function Install:SetDefaultsCVars()
	-- CVars
	SetCVar("countdownForCooldowns", 1)
	SetCVar("buffDurations", 1)
	SetCVar("scriptErrors", 1)
	SetCVar("ShowClassColorInNameplate", 1)
	SetCVar("screenshotQuality", 8)
	SetCVar("chatMouseScroll", 1)
	SetCVar("chatStyle", "classic")
	SetCVar("whisperMode", "inline")
	SetCVar("showTutorials", 0)
	SetCVar("autoQuestWatch", 1)
	SetCVar("autoQuestProgress", 1)
	SetCVar("UberTooltips", 1)
	SetCVar("removeChatDelay", 1)
	SetCVar("showVKeyCastbar", 1)
	SetCVar("alwaysShowActionBars", 1)
	SetCVar("autoOpenLootHistory", 0)
	SetCVar("spamFilter", 0)
	SetCVar("violenceLevel", 5)
	SetCVar("ShowClassColorInNameplate", 1)
	SetCVar("nameplateMotion", 0)
	SetCVar("lootUnderMouse", 1)
	SetCVar("instantQuestText", 1)
	SetCVar("nameplateShowAll", 1)
	SetCVar("nameplateShowEnemies", 1)
	SetCVar("nameplateShowEnemyMinions", 1)
	SetCVar("nameplateShowEnemyMinus", 1)
	SetCVar("nameplateShowFriends", 0)
	SetCVar("nameplateShowFriendlyMinions", 0)
	SetCVar("cameraSmoothStyle", 0)
	SetCVar("profanityFilter", 0)
	SetCVar("showLootSpam", 1)
	SetCVar("showArenaEnemyFrames", 0)
	
	if T.Retail then
		SetCVar("lossOfControl", 1)
		SetCVar("nameplateShowSelf", 0)
		SetCVar("nameplateResourceOnTarget", 0)
	end
end

Install:RegisterEvent("PLAYER_ENTERING_WORLD")
Install:SetScript("OnEvent", function(self, event)
	local Name = UnitName("Player")
	local Realm = GetRealmName()

	if (event == "PLAYER_ENTERING_WORLD") then
		local IsInstall = TukuiDatabase.Variables[Realm][Name].Installation.Done
			
		if (not IsInstall) then
			local Chat = T["Chat"]
			
			self:SetDefaultsCVars()
				
			Chat:Reset()

			TukuiDatabase.Variables[T.MyRealm][T.MyName].Installation.Done = true
		end
	end
end)

T["Install"] = Install
