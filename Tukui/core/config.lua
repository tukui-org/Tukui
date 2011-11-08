----------------------------------------------------------------------------
-- This Module loads new user settings if TukUI_ConfigUI is loaded
----------------------------------------------------------------------------
local T, C, L = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales

local myPlayerRealm = GetCVar("realmName")
local myPlayerName  = UnitName("player")

if not IsAddOnLoaded("Tukui_ConfigUI") then return end

if not TukuiConfigAll then TukuiConfigAll = {} end		
if (TukuiConfigAll[myPlayerRealm] == nil) then TukuiConfigAll[myPlayerRealm] = {} end
if (TukuiConfigAll[myPlayerRealm][myPlayerName] == nil) then TukuiConfigAll[myPlayerRealm][myPlayerName] = false end

if TukuiConfigAll[myPlayerRealm][myPlayerName] == true and not TukuiConfigPrivate then return end
if TukuiConfigAll[myPlayerRealm][myPlayerName] == false and not TukuiConfigPublic then return end

local setting
if TukuiConfigAll[myPlayerRealm][myPlayerName] == true then
	setting = TukuiConfigPrivate
else
	setting = TukuiConfigPublic
end

for group,options in pairs(setting) do
	if C[group] then
		local count = 0
		for option,value in pairs(options) do
			if C[group][option] ~= nil then
				if C[group][option] == value then
					setting[group][option] = nil	
				else
					count = count+1
					C[group][option] = value
				end
			end
		end
		-- keeps TukuiConfig clean and small
		if count == 0 then setting[group] = nil end
	else
		setting[group] = nil
	end
end