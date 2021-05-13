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
	local arg1, arg2, arg3, arg4 = Split(cmd)

	if (arg1 == "" or arg1 == "help") then
		T.Help:Show()
	else
		T.Help:Hide()
	end
	
	if (arg1 == "t") or (arg1 == "tracking") then
		if (C.UnitFrames.Enable) and (C.Raid.Enable) then
			T.UnitFrames.Tracking:Toggle()
		else
			T.Print("Sorry, our raid module is currently disabled")
		end
	elseif (arg1 == "p") or (arg1 == "profile") then
		local Profiles = T.Profiles
		
		Profiles:Toggle()
	elseif (arg1 == "mm") or (arg1 == "micromenu") then
		local MicroMenu = T.Miscellaneous.MicroMenu

		if MicroMenu:IsShown() then
			MicroMenu:Hide()

			UpdateMicroButtonsParent(T.Hider)

			for i = 1, #MICRO_BUTTONS do
				local Button = _G[MICRO_BUTTONS[i]]

				if Button.Backdrop then
					Button.Backdrop:Hide()
				end
			end
		else
			MicroMenu:Show()

			for i = 1, #MICRO_BUTTONS do
				local Button = _G[MICRO_BUTTONS[i]]

				if Button.Backdrop then
					Button.Backdrop:Show()
				end
			end

			UpdateMicroButtonsParent(T.PetHider)
		end
	elseif (arg1 == "ot") or (arg1 == "quests") then
		if T.Retail then
			if (ObjectiveTrackerFrame:IsVisible()) then
				ObjectiveTrackerFrame:Hide()
			else
				ObjectiveTrackerFrame:Show()
			end
		else
			if (QuestWatchFrame:IsVisible()) then
				QuestWatchFrame:Hide()
			else
				QuestWatchFrame:Show()
			end
		end
	elseif (arg1 == "ru") or (arg1 == "markers") then
		local Utilities = T.Miscellaneous.RaidUtilities
		
		Utilities:Toggle()
	elseif (arg1 == "fn") then
		local Name = GetMouseFocus():GetName()
		
		if Name then
			T.Print("Global name for this frame is: |CFF00FF00"..GetMouseFocus():GetName().."|r")
		else
			T.Print("Global name not found for this frame")
		end
	elseif (arg1 == "kb" or arg1 == "keybinds") then
		if InCombatLockdown() then
			return
		end
		
		if T.Retail then
			if QuickKeybindFrame and QuickKeybindFrame:IsShown() then
				return
			end

			GameMenuButtonKeybindings:Click()

			KeyBindingFrame.quickKeybindButton:Click()
		else
			T.Miscellaneous.Keybinds:Toggle()
		end
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
				TukuiDatabase.Variables[T.MyRealm][T.MyName].Move.TukuiLeftDataTextBox = nil
				TukuiDatabase.Variables[T.MyRealm][T.MyName].Move.TukuiRightDataTextBox = nil
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
	elseif (arg1 == "c" or arg1 == "config" or arg1 == "gui") then
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
	elseif AddOnCommands[arg1] then
		AddOnCommands[arg1](arg2)
	end
end

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
