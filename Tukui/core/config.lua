------------------------------------------------------------------
-- This Module loads new user settings if in-game config is loaded
------------------------------------------------------------------

local T, C, L, G = unpack(select(2, ...))

local myPlayerRealm = GetCVar("realmName")
local myPlayerName  = UnitName("player")

if not IsAddOnLoaded("Tukui_ConfigUI") then return end
if not TukuiConfigAll then TukuiConfigAll = {} end

local tca = TukuiConfigAll
local private = TukuiConfigPrivate
local public = TukuiConfigPublic
		
if not tca[myPlayerRealm] then tca[myPlayerRealm] = {} end
if not tca[myPlayerRealm][myPlayerName] then tca[myPlayerRealm][myPlayerName] = false end

if tca[myPlayerRealm][myPlayerName] == true and not private then return end
if tca[myPlayerRealm][myPlayerName] == false and not public then return end

local setting
if tca[myPlayerRealm][myPlayerName] == true then
	setting = private
else
	setting = public
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