local T, C, L = select(2, ...):unpack()

local AddOnCommands = {} -- Let people use /tukui for their mods

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
	local arg1, arg2 = Split(cmd)

	if (arg1 == "dt" or arg1 == "datatext") then
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
		local Install = T["Install"]

		Install:Launch()
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
	elseif (arg1 == "" or arg1 == "help") then
		print(" ")
		print("|cffff8000".. L.Help.Title .."|r")
		print(L.Help.Install)
		print(L.Help.Datatexts)
		print(L.Help.Config)
		print(L.Help.Move)
		print(L.Help.Test)
		print(L.Help.Profile)
		print(L.Help.Grid)
		print(L.Help.Status)
		print(" ")
	elseif (arg1 == "c" or arg1 == "config") then
		local Config = TukuiConfig

		if (not TukuiConfig) then
			T.Print(L.Others.ConfigNotFound)

			return
		end

		if (not TukuiConfigFrame) then
			Config:CreateConfigWindow()
		end

		if TukuiConfigFrame:IsVisible() then
			TukuiConfigFrame:Hide()
		else
			TukuiConfigFrame:Show()
		end
	elseif (arg1 == "gold") and (arg2 == "reset") then
		local MyRealm = GetRealmName()
		local MyName = UnitName("player")

		TukuiData["Gold"] = {}
		TukuiData["Gold"][GetRealmName()] = {}
		TukuiData["Gold"][GetRealmName()][UnitName("player")] = GetMoney()
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
		if not TukuiData then return end

		if TukuiConfigPerAccount then
			T.Print("Your settings are currently set accross toons so you can't use this command!")

			return
		end

		if not arg2 then
			T.Print("/tukui profile list")
			T.Print("/tukui profile #")
			print(" ")
		else
			local IsConfigLoaded = IsAddOnLoaded("Tukui_Config")

			if arg2 == "list" or arg2 == "l" then
				Tukui.Profiles = {}
				Tukui.Profiles.Data = {}
				Tukui.Profiles.Options = {}

				for Server, Table in pairs(TukuiData) do
					if not Server then return end

					if Server ~= "Gold" then
						for Character, Table in pairs(TukuiData[Server]) do
							tinsert(Tukui.Profiles.Data, TukuiData[Server][Character])

							if IsConfigLoaded then
								if TukuiConfigShared and TukuiConfigShared[Server] and TukuiConfigShared[Server][Character] then
									tinsert(Tukui.Profiles.Options, TukuiConfigShared[Server][Character])
								else
									if not TukuiConfigShared then
										TukuiConfigShared = {}
									end

									if not TukuiConfigShared[Server] then
										TukuiConfigShared[Server] = {}
									end

									if not TukuiConfigShared[Server][Character] then
										TukuiConfigShared[Server][Character] = {}
									end

									tinsert(Tukui.Profiles.Options, TukuiConfigShared[Server][Character])
								end
							end

							print("Profile "..#Tukui.Profiles.Data..": ["..Server.."]-["..Character.."]")
						end
					end
				end
			else
				local CurrentServer = GetRealmName()
				local CurrentCharacter = UnitName("player")
				local Profile = tonumber(arg2)

				if not Tukui.Profiles or not Tukui.Profiles.Data[Profile] then
					T.Print(L.Others.ProfileNotFound)

					return
				end

				TukuiData[CurrentServer][CurrentCharacter] = Tukui.Profiles.Data[Profile]

				if IsConfigLoaded then
					TukuiConfigShared[CurrentServer][CurrentCharacter] = Tukui.Profiles.Options[Profile]
				end

				ReloadUI()
			end
		end
	elseif AddOnCommands[arg1] then
		AddOnCommands[arg1](arg2)
	end
end

SLASH_TUKUISLASHHANDLER1 = "/tukui"
SlashCmdList["TUKUISLASHHANDLER"] = T.SlashHandler

T.AddOnCommands = AddOnCommands
