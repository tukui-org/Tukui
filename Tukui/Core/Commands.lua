local T, C, L = select(2, ...):unpack()

local AddOnCommands = {} -- Let people use /tukui for their mods
local SelectedProfile = 0

local Split = function(cmd)
	if cmd:find("%s") then
		return strsplit(" ", cmd)
	else
		return cmd
	end
end

local SplitServerCharacter = function(profile)
	return strsplit("-", profile)
end

local EventTraceEnabled = false
local EventTrace = CreateFrame("Frame")
EventTrace:SetScript("OnEvent", function(self, event)
	if (event ~= "GET_ITEM_INFO_RECEIVED" and event ~= "COMBAT_LOG_EVENT_UNFILTERED") then
		T.Print(event)
	end
end)

T.SlashHandler = function(cmd)
	local arg1, arg2, arg3 = Split(cmd)

	if (arg1 == "" or arg1 == "help") then
		print("|cffff8000".. L.Help.Title .."|r")
		print(L.Help.Chat)
		print(L.Help.Config)
		print(L.Help.Datatexts)
		print(L.Help.Events)
		print(L.Help.Gold)
		print(L.Help.Grid)
		print(L.Help.Install)
		print(L.Help.Keybinds)
		print(L.Help.Load)
		print(L.Help.Move)
		print(L.Help.Profile)
		print(L.Help.Status)
		print(L.Help.Test)
	elseif (arg1 == "fn") then
		local Name = GetMouseFocus():GetName()
		
		if Name then
			T.Print("Global name for this frame is: |CFF00FF00"..GetMouseFocus():GetName().."|r")
		else
			T.Print("Global name not found for this frame")
		end
	elseif (arg1 == "feedback" or arg1 == "fb") then
		-- TEMP FOR BETA
		if arg2 == "disable" then
			DisableAddOn("Blizzard_PTRFeedback")
			
			ReloadUI()
		elseif arg2== "enable" then
			EnableAddOn("Blizzard_PTRFeedback")
			
			ReloadUI()
		end
	elseif (arg1 == "kb" or arg1 == "keybinds") then
		if QuickKeybindFrame and QuickKeybindFrame:IsShown() then
			return
		end
		
		GameMenuButtonKeybindings:Click()
		
		KeyBindingFrame.quickKeybindButton:Click()
	elseif (arg1 == "mh") then
		local SlashCommand = _G.SlashCmdList["LIBCLASSICMOBHEALTHONE"]
		local Command = (arg3 and arg2.." "..arg3) or (arg2) or ""

		SlashCommand(Command)
	elseif (arg1 == "chat") then
		if (arg2 == "reset") then
			local Chat = T.Chat
			local Panels = T.DataTexts.Panels
			local DataLeft = Panels.Left
			local DataRight = Panels.Right

			if Chat then
				-- Reset chat windows
				Chat:Reset()
				
				-- Move back to default position
				DataLeft:ClearAllPoints()
				DataLeft:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 34, 20)
				
				DataRight:ClearAllPoints()
				DataRight:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -34, 20)
				
				if DataLeft.DragInfo then
					DataLeft.DragInfo:ClearAllPoints()
					DataLeft.DragInfo:SetAllPoints(DataLeft)
				end
				
				if DataRight.DragInfo then
					DataRight.DragInfo:ClearAllPoints()
					DataRight.DragInfo:SetAllPoints(DataRight)
				end
				
				-- Remove saved position settings
				TukuiData[T.MyRealm][T.MyName].Move.TukuiLeftDataTextBox = nil
				TukuiData[T.MyRealm][T.MyName].Move.TukuiRightDataTextBox = nil
			end
		end
	elseif (arg1 == "dt" or arg1 == "datatext") then
		local DataText = T["DataTexts"]

		if arg2 then
			if (arg2 == "reset") then
				DataText:Reset()
			elseif (arg2 == "resetgold") then
				DataText:ResetGold()
			end
		else
			DataText:ToggleDataPositions()
		end
	elseif (arg1 == "install" or arg1 == "reset") then
		T.Popups.ShowPopup("RESETUI")
	elseif (arg1 == "load" or arg1 == "unload") then
		local Loaded, Reason = LoadAddOn(arg2)

		if (Reason == "MISSING") then
			T.Print("["..arg2.."] is not installed")

			return
		end

		if arg1 == "load" then
			if (IsAddOnLoaded(arg2)) then
				T.Print("["..arg2.."] is already loaded")

				return
			end

			EnableAddOn(arg2)
		else
			DisableAddOn(arg2)
		end

		ReloadUI()
	elseif (arg1 == "br" or arg1 == "report") then
		if arg2 == "enable" then
			EnableAddOn("Blizzard_PTRFeedback")
		else
			DisableAddOn("Blizzard_PTRFeedback")
		end

		ReloadUI()
	elseif (arg1 == "status" or arg1 == "debug") then
		local Status = TukuiStatus

		Status:ShowWindow()
	elseif (arg1 == "events" or arg1 == "trace") then
		if EventTraceEnabled then
			EventTrace:UnregisterAllEvents()

			EventTraceEnabled = false
		else
			EventTrace:RegisterAllEvents()

			EventTraceEnabled = true
		end
	elseif (arg1 == "move" or arg1 == "moveui") then
		local Movers = T["Movers"]

		Movers:StartOrStopMoving()
	elseif (arg1 == "c" or arg1 == "config") then
		T.GUI:Toggle()
	elseif (arg1 == "gold") and (arg2 == "reset") then
		local DataText = T["DataTexts"]
		local MyRealm = GetRealmName()
		local MyName = UnitName("player")

		DataText:ResetGold()
	elseif (arg1 == "test" or arg1 == "testui") then
		local Test = T["TestUI"]

		Test:EnableOrDisable()
	elseif (arg1 == "grid") then
		local Grid = T.Miscellaneous.Grid

		if Grid.Enable then
			Grid:Hide()
			Grid.Enable = false
		else
			if arg2 then
				local Number = tonumber(arg2)

				if Number then
					Grid.BoxSize = Number
				end
			end
			if Grid.BoxSize > 256 then
				Grid.BoxSize = 256
			end

			Grid:Show()
			Grid.Enable = true
			Grid.BoxSize = (math.ceil((tonumber(arg) or Grid.BoxSize) / 32) * 32)
		end
	elseif (arg1 == "profile" or arg1 == "p") then
		if not arg2 then
			print(" ")
			T.Print("/tukui profile list")
			print("     List current profiles available")
			T.Print("/tukui profile #")
			print("     Apply a profile, replace '#' with a profile number")
			print(" ")
		else
			if arg2 == "list" or arg2 == "l" then
				Tukui.Profiles = {}
				Tukui.Profiles.Data = {}
				Tukui.Profiles.Options = {}

				local EmptyTable = {}

				for Server, Table in pairs(TukuiData) do
					if not Server then return end

					for Character, Table in pairs(TukuiData[Server]) do
						-- Data
						tinsert(Tukui.Profiles.Data, TukuiData[Server][Character])

						-- GUI options, it can be not found if you didn't log at least once since version 1.10 on that toon.
						if TukuiSettingsPerCharacter and TukuiSettingsPerCharacter[Server] and TukuiSettingsPerCharacter[Server][Character] then
							tinsert(Tukui.Profiles.Options, TukuiSettingsPerCharacter[Server][Character])
						else
							tinsert(Tukui.Profiles.Options, EmptyTable)
						end

						print("Profile "..#Tukui.Profiles.Data..": ["..Server.."]-["..Character.."]")
					end
				end
			else
				SelectedProfile = tonumber(arg2)

				if not Tukui.Profiles or not Tukui.Profiles.Data[SelectedProfile] then
					T.Print(L.Others.ProfileNotFound)

					return
				end

				T.Popups.ShowPopup("TUKUI_IMPORT_PROFILE")
			end
		end
	elseif AddOnCommands[arg1] then
		AddOnCommands[arg1](arg2)
	end
end

-- Create a Tukui popup for profiles
T.Popups.Popup["TUKUI_IMPORT_PROFILE"] = {
	Question = "Are you sure you want to import this profile? Continue?",
	Answer1 = ACCEPT,
	Answer2 = CANCEL,
	Function1 = function(self)
		TukuiData[T.MyRealm][T.MyName] = Tukui.Profiles.Data[SelectedProfile]

		if TukuiSettingsPerCharacter[T.MyRealm][T.MyName].General and TukuiSettingsPerCharacter[T.MyRealm][T.MyName].General.UseGlobal then
			-- Look like we use globals for gui, don't import gui settings, keep globals
		else
			TukuiSettingsPerCharacter[T.MyRealm][T.MyName] = Tukui.Profiles.Options[SelectedProfile]
		end

		ReloadUI()
	end,
}

T.Popups.Popup["RESETUI"] = {
	Question = "Are you sure you want to reset Tukui to default?",
	Answer1 = ACCEPT,
	Answer2 = CANCEL,
	Function1 = function(self)
		local Install = T["Install"]

		Install:ResetSettings()
		Install:ResetData()
	end,
}

SLASH_TUKUISLASHHANDLER1 = "/tukui"
SlashCmdList["TUKUISLASHHANDLER"] = T.SlashHandler

T.AddOnCommands = AddOnCommands
