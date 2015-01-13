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
	elseif (arg1 == "" or arg1 == "help") then
		print(" ")
		print("|cffff8000".. L.Help.Title .."|r")
		print(L.Help.Install)
		print(L.Help.Datatexts)
		print(L.Help.Config)
		print(L.Help.Move)
		print(L.Help.Test)
		print(L.Help.Profile)
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
	elseif (arg1 == "move" or arg1 == "moveui") then
		local Movers = T["Movers"]
		
		Movers:StartOrStopMoving()
	elseif (arg1 == "test" or arg1 == "testui") then
		local Test = T["TestUI"]
		
		Test:EnableOrDisable()
	elseif (arg1 == "profile" or arg1 == "p") then
		if arg2 then
			local Server, Character = SplitServerCharacter(arg2)

			if Server and Character then
				if TukuiData and TukuiData[Server] and TukuiData[Server][Character] then
					local CurrentServer = GetRealmName()
					local CurrentCharacter = UnitName("player")
					
					TukuiData[CurrentServer][CurrentCharacter] = TukuiData[Server][Character]
					
					if TukuiConfigShared and TukuiConfigShared[Server] and TukuiConfigShared[Server][Character] then
						if not TukuiConfigPerAccount then
							TukuiConfigShared[CurrentServer][CurrentCharacter] = TukuiConfigShared[Server][Character]
						end
					end
					
					ReloadUI()
				else
					T.Print(L.Others.ProfileNotFound)
				end
			end
		else
			T.Print(L.Others.ProfileSelection)
		end
	elseif AddOnCommands[arg1] then
		AddOnCommands[arg1](arg2)
	end
end

SLASH_TUKUISLASHHANDLER1 = "/tukui"
SlashCmdList["TUKUISLASHHANDLER"] = T.SlashHandler

T.AddOnCommands = AddOnCommands