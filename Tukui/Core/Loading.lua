local T, C, L = select(2, ...):unpack()

local Loading = CreateFrame("Frame")
local LibDeflate = LibStub:GetLibrary("LibDeflate")
local LibSerialize = LibStub("LibSerialize")

function Loading:StoreDefaults()
	T.Defaults = {}

	for group, options in pairs(C) do
		if (not T.Defaults[group]) then
			T.Defaults[group] = {}
		end

		for option, value in pairs(options) do
			T.Defaults[group][option] = value

			if (type(C[group][option]) == "table") then
				if C[group][option].Options then
					T.Defaults[group][option] = value.Value
				else
					T.Defaults[group][option] = value
				end
			else
				T.Defaults[group][option] = value
			end
		end
	end
end

function Loading:LoadCustomSettings()
	local Settings = TukuiDatabase.Settings[T.MyRealm][T.MyName]

	for group, options in pairs(Settings) do
		if C[group] then
			local Count = 0

			for option, value in pairs(options) do
				if (C[group][option] ~= nil) then
					if (C[group][option] == value) then
						Settings[group][option] = nil
					else
						Count = Count + 1

						if (type(C[group][option]) == "table") then
							if C[group][option].Options then
								C[group][option].Value = value
							else
								C[group][option] = value
							end
						else
							C[group][option] = value
						end
					end
				end
			end

			-- Keeps settings clean and small
			if (Count == 0) then
				Settings[group] = nil
			end
		else
			Settings[group] = nil
		end
	end
end

function Loading:LoadProfiles()
	local Profiles = C.General.Profiles
	local Menu = Profiles.Options
	local Data = TukuiDatabase.Variables
	local GUISettings = TukuiDatabase.Settings
	local Nickname = T.MyName
	local Server = T.MyRealm

	if not GUISettings then
		return
	end

	for Index, Table in pairs(GUISettings) do
		local Server = Index

		for Nickname, Settings in pairs(Table) do
			local ProfileName = Server.."-"..Nickname
			local MyProfileName = T.MyRealm.."-"..T.MyName

			if MyProfileName ~= ProfileName then
				Menu[ProfileName] = ProfileName
			end
		end
	end
end

function Loading:Enable()
	local Toolkit = T.Toolkit

	self:StoreDefaults()
	self:LoadProfiles()
	self:LoadCustomSettings()

	Toolkit.Settings.BackdropColor = C.General.BackdropColor
	Toolkit.Settings.BorderColor = C.General.ClassColorBorder and T.Colors.class[T.MyClass] or C.General.BorderColor
	Toolkit.Settings.UIScale = C.General.UIScale

	if C.General.HideShadows then
		Toolkit.Settings.ShadowTexture = ""
	end
end

function Loading:MergeDatabase()
	if TukuiData then
		TukuiDatabase["Variables"] = TukuiData

		TukuiData = nil
	end

	if TukuiSettingsPerCharacter then
		TukuiDatabase["Settings"] = TukuiSettingsPerCharacter

		TukuiSettingsPerCharacter = nil
	end

	if TukuiGold then
		TukuiDatabase["Gold"] = TukuiGold

		TukuiGold = nil
	end

	if TukuiChatHistory then
		TukuiDatabase["ChatHistory"] = TukuiChatHistory 

		TukuiChatHistory = nil
	end
end

function Loading:VerifyDatabase()
	if not TukuiDatabase then
		TukuiDatabase = {}
	end

	-- VARIABLES
	if not TukuiDatabase.Variables then
		TukuiDatabase.Variables = {}
	end

	if not TukuiDatabase.Variables[T.MyRealm] then
		TukuiDatabase.Variables[T.MyRealm] = {}
	end

	if not TukuiDatabase.Variables[T.MyRealm][T.MyName] then
		TukuiDatabase.Variables[T.MyRealm][T.MyName] = {}
	end

	if not TukuiDatabase.Variables[T.MyRealm][T.MyName].Move then
		TukuiDatabase.Variables[T.MyRealm][T.MyName].Move = {}
	end

	if not TukuiDatabase.Variables[T.MyRealm][T.MyName].ActionBars then
		TukuiDatabase.Variables[T.MyRealm][T.MyName].ActionBars = {}
	end

	if not TukuiDatabase.Variables[T.MyRealm][T.MyName].Tracking then
		TukuiDatabase.Variables[T.MyRealm][T.MyName].Tracking = {}
		TukuiDatabase.Variables[T.MyRealm][T.MyName].Tracking.PvP = {}
		TukuiDatabase.Variables[T.MyRealm][T.MyName].Tracking.PvE = {}
	end

	if (not TukuiDatabase.Variables[T.MyRealm][T.MyName].DataTexts) then
		local DataTexts = T.DataTexts

		DataTexts:AddDefaults()
	end

	if not TukuiDatabase.Variables[T.MyRealm][T.MyName].Chat then
		TukuiDatabase.Variables[T.MyRealm][T.MyName].Chat = {}

		if not TukuiDatabase.Variables[T.MyRealm][T.MyName].Chat.Positions then
			TukuiDatabase.Variables[T.MyRealm][T.MyName].Chat.Positions = T.Chat.Positions
		end
	else
		-- We recently changed this table, make sure it work with our new layout
		if not TukuiDatabase.Variables[T.MyRealm][T.MyName].Chat.Positions then
			-- Reset Chat Database
			TukuiDatabase.Variables[T.MyRealm][T.MyName].Chat = {}

			-- Set frames position default
			TukuiDatabase.Variables[T.MyRealm][T.MyName].Chat.Positions = T.Chat.Positions

			-- Warn user
			T.Print("|CFFFF0000WARNING:|r Your chat position have been reset to default")
		end
	end

	if (not TukuiDatabase.Variables[T.MyRealm][T.MyName].Misc) then
		TukuiDatabase.Variables[T.MyRealm][T.MyName].Misc = {}
	end

	if (not TukuiDatabase.Variables[T.MyRealm][T.MyName].Installation) then
		TukuiDatabase.Variables[T.MyRealm][T.MyName].Installation = {}
	end

	-- SETTINGS
	if (not TukuiDatabase.Settings) then
		TukuiDatabase.Settings = {}
	end

	if not TukuiDatabase.Settings[T.MyRealm] then
		TukuiDatabase.Settings[T.MyRealm] = {}
	end

	if not TukuiDatabase.Settings[T.MyRealm][T.MyName] then
		TukuiDatabase.Settings[T.MyRealm][T.MyName] = {}
	end

	-- Chat History
	if not TukuiDatabase.ChatHistory then
		TukuiDatabase.ChatHistory = {}
	end

	-- Gold
	if not TukuiDatabase.Gold then
		TukuiDatabase.Gold = {}
	end
end

function Loading:OnEvent(event)
	-- We verify everything is ok with our savedvariables
	self:VerifyDatabase()

	-- Patch 9.0 was using different table to save settings, when players will hit 9.1, we need to move their settings into our new table
	self:MergeDatabase()

	if (event == "PLAYER_LOGIN") then
		T["Inventory"]["Bags"]:Enable()
		T["Inventory"]["Loot"]:Enable()
		T["Inventory"]["GroupLoot"]:Enable()
		T["Inventory"]["Merchant"]:Enable()
		T["Auras"]:Enable()
		T["Maps"]["Minimap"]:Enable()
		T["Maps"]["Zonemap"]:Enable()
		T["Maps"]["Worldmap"]:Enable()
		T["DataTexts"]:Enable()
		T["Chat"]:Enable()
		T["ActionBars"]:Enable()
		T["Cooldowns"]:Enable()
		T["Miscellaneous"]["Experience"]:Enable()
		T["Miscellaneous"]["Errors"]:Enable()
		T["Miscellaneous"]["MirrorTimers"]:Enable()
		T["Miscellaneous"]["DropDown"]:Enable()
		T["Miscellaneous"]["GarbageCollection"]:Enable()
		T["Miscellaneous"]["GameMenu"]:Enable()
		T["Miscellaneous"]["StaticPopups"]:Enable()
		T["Miscellaneous"]["Durability"]:Enable()
		T["Miscellaneous"]["UIWidgets"]:Enable()
		T["Miscellaneous"]["AFK"]:Enable()
		T["Miscellaneous"]["MicroMenu"]:Enable()
		T["Miscellaneous"]["Keybinds"]:Enable()
		T["Miscellaneous"]["TimeManager"]:Enable()
		T["Miscellaneous"]["ThreatBar"]:Enable()
		T["Miscellaneous"]["ItemLevel"]:Enable()
		T["Miscellaneous"]["Alerts"]:Enable()
		T["UnitFrames"]:Enable()
		T["Tooltips"]:Enable()

		if T.Retail then
			T["Miscellaneous"]["TalkingHead"]:Enable()
			T["Miscellaneous"]["LossControl"]:Enable()
			T["Miscellaneous"]["DeathRecap"]:Enable()
			T["Miscellaneous"]["Ghost"]:Enable()
			T["Miscellaneous"]["TimerTracker"]:Enable()
			T["Miscellaneous"]["AltPowerBar"]:Enable()
			T["Miscellaneous"]["OrderHall"]:Enable()
			T["Miscellaneous"]["Tutorials"]:Enable()
			T["Miscellaneous"]["VehicleIndicator"]:Enable()
			T["Miscellaneous"]["RaidUtilities"]:Enable()
			T["PetBattles"]:Enable()
		end

		-- restore original stopwatch commands
		SlashCmdList["STOPWATCH"] = Stopwatch_Toggle
	elseif (event == "PLAYER_ENTERING_WORLD") then
		if not T.WotLK then
			T["Miscellaneous"]["ObjectiveTracker"]:Enable()
		end

		if T.Retail then
			-- Temp Fix for Action MultiBarBottomRight buttons 1 to 6 on low monitor resolution
			for i = 1, 6 do
				local Button = _G["MultiBarBottomRightButton"..i]

				Button:SetAttribute("showgrid", 1)
				Button:Show()
			end
		end
	elseif (event == "VARIABLES_LOADED") then
		local Locale = GetLocale()

		T["Loading"]:Enable()

		if (Locale ~= "koKR" or Locale ~= "zhTW" or Locale ~= "zhCN" or Locale ~= "ruRU") then
			C.Medias.Font = C.General.GlobalFont.Value

			TukuiFont:SetFont(C.Medias.Font, 12)
			TukuiFontOutline:SetFont(C.Medias.Font, 12, "THINOUTLINE")
		end

		T["Fonts"]:Enable()
		T["GUI"]:Enable()
		T["Profiles"]:Enable()
		T["Help"]:Enable()
	end
end

Loading:RegisterEvent("PLAYER_LOGIN")
Loading:RegisterEvent("VARIABLES_LOADED")
Loading:RegisterEvent("PLAYER_ENTERING_WORLD")
Loading:SetScript("OnEvent", Loading.OnEvent)

T["Loading"] = Loading
