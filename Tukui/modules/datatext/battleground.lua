local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

local twinpeaks = select(1, GetBattlegroundInfo(2))
local gilneas = select(1, GetBattlegroundInfo(3))
local warsong = select(1, GetBattlegroundInfo(4))
local arathi = select(1, GetBattlegroundInfo(5))
local eos = select(1, GetBattlegroundInfo(6))
local alterac = select(1, GetBattlegroundInfo(7))
local sota = select(1, GetBattlegroundInfo(8))
local conquest = select(1, GetBattlegroundInfo(9))

if not C["datatext"].battleground then return end

local bgframe = TukuiInfoLeftBattleGround
bgframe:SetScript("OnEnter", function(self)
	local numScores = GetNumBattlefieldScores()
	for i=1, numScores do
		local name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, healingDone, bgRating, ratingChange = GetBattlefieldScore(i)
		if ( name ) then
			if ( name == UnitName("player") ) then
				GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, T.Scale(4))
				GameTooltip:ClearLines()
				GameTooltip:Point("BOTTOM", self, "TOP", 0, 1)
				GameTooltip:ClearLines()
				GameTooltip:AddLine(L.datatext_ttstatsfor.."[|cffCC0033"..name.."|r]")
				GameTooltip:AddLine' '
				GameTooltip:AddDoubleLine(L.datatext_ttkillingblows, killingBlows,1,1,1)
				GameTooltip:AddDoubleLine(L.datatext_tthonorkills, honorableKills,1,1,1)
				GameTooltip:AddDoubleLine(L.datatext_ttdeaths, deaths,1,1,1)
				GameTooltip:AddDoubleLine(L.datatext_tthonorgain, format('%d', honorGained),1,1,1)
				GameTooltip:AddDoubleLine(L.datatext_ttdmgdone, damageDone,1,1,1)
				GameTooltip:AddDoubleLine(L.datatext_tthealdone, healingDone,1,1,1)
				--Add extra statistics to watch based on what BG you are in.
				if GetRealZoneText() == arathi or GetRealZoneText() == gilneas then 
					GameTooltip:AddDoubleLine(L.datatext_basesassaulted,GetBattlefieldStatData(i, 1),1,1,1)
					GameTooltip:AddDoubleLine(L.datatext_basesdefended,GetBattlefieldStatData(i, 2),1,1,1)
				elseif GetRealZoneText() == warsong or GetRealZoneText() == twinpeaks then 
					GameTooltip:AddDoubleLine(L.datatext_flagscaptured,GetBattlefieldStatData(i, 1),1,1,1)
					GameTooltip:AddDoubleLine(L.datatext_flagsreturned,GetBattlefieldStatData(i, 2),1,1,1)
				elseif GetRealZoneText() == eos then 
					GameTooltip:AddDoubleLine(L.datatext_flagscaptured,GetBattlefieldStatData(i, 1),1,1,1)
				elseif GetRealZoneText() == alterac then
					GameTooltip:AddDoubleLine(L.datatext_graveyardsassaulted,GetBattlefieldStatData(i, 1),1,1,1)
					GameTooltip:AddDoubleLine(L.datatext_graveyardsdefended,GetBattlefieldStatData(i, 2),1,1,1)
					GameTooltip:AddDoubleLine(L.datatext_towersassaulted,GetBattlefieldStatData(i, 3),1,1,1)
					GameTooltip:AddDoubleLine(L.datatext_towersdefended,GetBattlefieldStatData(i, 4),1,1,1)
				elseif GetRealZoneText() == sota then
					GameTooltip:AddDoubleLine(L.datatext_demolishersdestroyed,GetBattlefieldStatData(i, 1),1,1,1)
					GameTooltip:AddDoubleLine(L.datatext_gatesdestroyed,GetBattlefieldStatData(i, 2),1,1,1)
				elseif GetRealZoneText() == conquest then
					GameTooltip:AddDoubleLine(L.datatext_basesassaulted,GetBattlefieldStatData(i, 1),1,1,1)
					GameTooltip:AddDoubleLine(L.datatext_basesdefended,GetBattlefieldStatData(i, 2),1,1,1)
				end					
				GameTooltip:Show()
			end
		end
	end
end) 
bgframe:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

local Stat = CreateFrame("Frame")
Stat:EnableMouse(true)

local Text1  = TukuiInfoLeftBattleGround:CreateFontString(nil, "OVERLAY")
Text1:SetFont(C.media.font, C["datatext"].fontsize)
Text1:SetPoint("LEFT", TukuiInfoLeftBattleGround, 30, 0.5)
Text1:SetHeight(TukuiInfoLeft:GetHeight())

local Text2  = TukuiInfoLeftBattleGround:CreateFontString(nil, "OVERLAY")
Text2:SetFont(C.media.font, C["datatext"].fontsize)
Text2:SetPoint("CENTER", TukuiInfoLeftBattleGround, 0, 0.5)
Text2:SetHeight(TukuiInfoLeft:GetHeight())

local Text3  = TukuiInfoLeftBattleGround:CreateFontString(nil, "OVERLAY")
Text3:SetFont(C.media.font, C["datatext"].fontsize)
Text3:SetPoint("RIGHT", TukuiInfoLeftBattleGround, -30, 0.5)
Text3:SetHeight(TukuiInfoLeft:GetHeight())

local int = 2
local function Update(self, t)
	int = int - t
	if int < 0 then
		local dmgtxt
		RequestBattlefieldScoreData()
		local numScores = GetNumBattlefieldScores()
		for i=1, numScores do
			local name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, healingDone, bgRating, ratingChange = GetBattlefieldScore(i)
			if healingDone > damageDone then
				dmgtxt = (L.datatext_healing..healingDone)
			else
				dmgtxt = (L.datatext_damage..damageDone)
			end
			if ( name ) then
				if ( name == T.myname ) then
					Text2:SetText(L.datatext_honor..format('%d', honorGained))
					Text1:SetText(dmgtxt)
					Text3:SetText(L.datatext_killingblows..killingBlows)
				end   
			end
		end 
		int  = 2
	end
end

--hide text when not in an bg
local function OnEvent(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		local inInstance, instanceType = IsInInstance()
		if inInstance and (instanceType == "pvp") then
			bgframe:Show()
		else
			Text1:SetText("")
			Text2:SetText("")
			Text3:SetText("")
			bgframe:Hide()
		end
	end
end

Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
Stat:SetScript("OnEvent", OnEvent)
Stat:SetScript("OnUpdate", Update)
Update(Stat, 2)