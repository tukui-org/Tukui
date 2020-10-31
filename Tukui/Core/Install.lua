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
	TukuiSettingsPerCharacter[T.MyRealm][T.MyName] = {}

	T:VerifyDataTable()
end

-- Reset datatext & chats
function Install:ResetData()
	if (T.DataTexts) then
		T.DataTexts:Reset()
	end

	TukuiData[T.MyRealm][T.MyName] = {}
	
	T.VerifyDataTable()

	FCF_ResetChatWindows()

	if ChatConfigFrame:IsShown() then
		ChatConfig_UpdateChatSettings()
	end

	ReloadUI()
end

function Install:DeprecatedCheck()
	local OldConfig = "Tukui_Config"
	
	if IsAddOnLoaded(OldConfig) then
		T.Print("|CFFFF0000WARNING! |r")
		print("    -> |CFFFF0000"..OldConfig.."|r is not needed anymore, please remove it from your WoW AddOns directory")
		print("    -> |CFF00FF00..\\World of Warcraft\\_retail_\\Interface\\AddOns|r")
	end
end

function Install:SetDefaultsCVars()
	-- CVars
	SetCVar("countdownForCooldowns", 1)
	SetCVar("buffDurations", 1)
	SetCVar("scriptErrors", 1)
	SetCVar("ShowClassColorInNameplate", 1)
	SetCVar("screenshotQuality", 8)
	SetCVar("chatMouseScroll", 1)
	SetCVar("chatStyle", "im")
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
	SetCVar("nameplateMaxDistance", 60)
	SetCVar("showLootSpam", 1)
	SetCVar("lossOfControl", 1)
	SetCVar("showArenaEnemyFrames", 0)
	SetCVar("nameplateShowSelf", 0)
	SetCVar("nameplateResourceOnTarget", 0)
end

Install:RegisterEvent("PLAYER_ENTERING_WORLD")
Install:SetScript("OnEvent", function(self, event)
	local Name = UnitName("Player")
	local Realm = GetRealmName()

	if (event == "PLAYER_ENTERING_WORLD") then
		local IsInstall = TukuiData[Realm][Name].Installation.Done
			
		if (not IsInstall) then
			local Chat = T["Chat"]
			
			self:SetDefaultsCVars()
				
			Chat:Reset()

			TukuiData[T.MyRealm][T.MyName].Installation.Done = true
		end
			
		self:DeprecatedCheck()
	end
end)

T["Install"] = Install
