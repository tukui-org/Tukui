local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local MyName = UnitName("player")
local format = format
local int = 2

--Map IDs
local WSG = 443
local TP = 626
local AV = 401
local SOTA = 512
local IOC = 540
local EOTS = 482
local TBFG = 736
local AB = 461
local TOK = 856
local SSM = 860

local BGFrame = CreateFrame("Frame", nil, UIParent)

function BGFrame:OnEnter()
	local NumScores = GetNumBattlefieldScores()
	
	for i = 1, NumScores do
		local Name, KillingBlows, HonorableKills, Deaths, HonorGained, _, _, _, _, DamageDone, HealingDone = GetBattlefieldScore(i)
		
		if (Name and Name == MyName) then
			local CurMapID = GetCurrentMapAreaID()
			local Color = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
			local ClassColor = format("|cff%.2x%.2x%.2x", Color.r * 255, Color.g * 255, Color.b * 255)
			SetMapToCurrentZone()			
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, T.Scale(4))
			GameTooltip:ClearLines()
			GameTooltip:Point("BOTTOM", self, "TOP", 0, 1)
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(L.DataText.StatsFor, ClassColor..Name.."|r")
			GameTooltip:AddLine(" ")
			GameTooltip:AddDoubleLine(L.DataText.KillingBlow, KillingBlows, 1, 1, 1)
			GameTooltip:AddDoubleLine(L.DataText.HonorableKill, HonorableKills, 1, 1, 1)
			GameTooltip:AddDoubleLine(L.DataText.Death, Deaths, 1, 1, 1)
			GameTooltip:AddDoubleLine(L.DataText.Honor, format("%d", HonorGained), 1, 1, 1)
			GameTooltip:AddDoubleLine(L.DataText.Damage, DamageDone, 1, 1, 1)
			GameTooltip:AddDoubleLine(L.DataText.Healing, HealingDone, 1, 1, 1)
			
			-- Add extra statistics based on what BG you're in.
			if (CurMapID == WSG or CurMapID == TP) then 
				GameTooltip:AddDoubleLine(L.DataText.FlagCapture, GetBattlefieldStatData(i, 1), 1, 1, 1)
				GameTooltip:AddDoubleLine(L.DataText.FlagReturn, GetBattlefieldStatData(i, 2), 1, 1, 1)
			elseif (CurMapID == EOTS) then
				GameTooltip:AddDoubleLine(L.DataText.FlagCapture, GetBattlefieldStatData(i, 1), 1, 1, 1)
			elseif (CurMapID == AV) then
				GameTooltip:AddDoubleLine(L.DataText.GraveyardAssault, GetBattlefieldStatData(i, 1), 1, 1, 1)
				GameTooltip:AddDoubleLine(L.DataText.GraveyardDefend, GetBattlefieldStatData(i, 2), 1, 1, 1)
				GameTooltip:AddDoubleLine(L.DataText.TowerAssault, GetBattlefieldStatData(i, 3), 1, 1, 1)
				GameTooltip:AddDoubleLine(L.DataText.TowerDefend, GetBattlefieldStatData(i, 4), 1, 1, 1)
			elseif (CurMapID == SOTA) then
				GameTooltip:AddDoubleLine(L.DataText.DemolisherDestroy, GetBattlefieldStatData(i, 1), 1, 1, 1)
				GameTooltip:AddDoubleLine(L.DataText.GateDestroy, GetBattlefieldStatData(i, 2), 1, 1, 1)
			elseif (CurMapID == IOC or CurMapID == TBFG or CurMapID == AB) then
				GameTooltip:AddDoubleLine(L.DataText.BaseAssault, GetBattlefieldStatData(i, 1), 1, 1, 1)
				GameTooltip:AddDoubleLine(L.DataText.BaseDefend, GetBattlefieldStatData(i, 2), 1, 1, 1)
			elseif (CurrentMapID == TOK) then
				GameTooltip:AddDoubleLine(L.DataText.OrbPossession, GetBattlefieldStatData(i, 1), 1, 1, 1)
				GameTooltip:AddDoubleLine(L.DataText.VictoryPts, GetBattlefieldStatData(i, 2), 1, 1, 1)
			elseif (CurrentMapID == SSM) then
				GameTooltip:AddDoubleLine(L.DataText.CartControl, GetBattlefieldStatData(i, 1), 1, 1, 1)
			end	
			
			GameTooltip:Show()
		end
	end
end

function BGFrame:OnLeave()
	GameTooltip:Hide()
end

function BGFrame:OnUpdate(t)
	int = int - t
	
	if (int < 0) then
		local Amount
		RequestBattlefieldScoreData()
		local NumScores = GetNumBattlefieldScores()
		
		for i = 1, NumScores do
			local Name, KillingBlows, _, _, HonorGained, _, _, _, _, DamageDone, HealingDone = GetBattlefieldScore(i)
			
			if (HealingDone > DamageDone) then
				Amount = (DataText.NameColor..L.DataText.Healing.."|r"..DataText.ValueColor..HealingDone.."|r")
			else
				Amount = (DataText.NameColor..L.DataText.Damage.."|r"..DataText.ValueColor..DamageDone.."|r")
			end
			
			if (Name and Name == MyName) then
				self.Text1:SetText(Amount)
				self.Text2:SetText(DataText.NameColor..L.DataText.Honor.."|r"..DataText.ValueColor..format("%d", HonorGained).."|r")
				self.Text3:SetText(DataText.NameColor..L.DataText.KillingBlow.."|r"..DataText.ValueColor..KillingBlows.."|r")
			end   
		end
		
		int  = 2
	end
end

function BGFrame:OnEvent()
	local InInstance, InstanceType = IsInInstance()
	
	if (InInstance and (InstanceType == "pvp")) then
		self:Show()
	else
		self:Hide()
		self.Text1:SetText("")
		self.Text2:SetText("")
		self.Text3:SetText("")
	end
end

function BGFrame:Enable()
	if not (C.DataTexts.Battleground) then
		return
	end

	local DataTextLeft = T["Panels"].DataTextLeft
	BGFrame:SetAllPoints(DataTextLeft)
	BGFrame:SetTemplate()
	BGFrame:SetFrameLevel(4)

	local Text1 = BGFrame:CreateFontString(nil, "OVERLAY")
	Text1:SetFontObject(DataText.Font)
	Text1:SetPoint("LEFT", 30, -1)
	Text1:SetHeight(BGFrame:GetHeight())
	BGFrame.Text1 = Text1

	local Text2 = BGFrame:CreateFontString(nil, "OVERLAY")
	Text2:SetFontObject(DataText.Font)
	Text2:SetPoint("CENTER", 0, -1)
	Text2:SetHeight(BGFrame:GetHeight())
	BGFrame.Text2 = Text2

	local Text3 = BGFrame:CreateFontString(nil, "OVERLAY")
	Text3:SetFontObject(DataText.Font)
	Text3:SetPoint("RIGHT", -30, -1)
	Text3:SetHeight(BGFrame:GetHeight())
	BGFrame.Text3 = Text3

	BGFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	BGFrame:SetScript("OnUpdate", BGFrame.OnUpdate)
	BGFrame:SetScript("OnEvent", BGFrame.OnEvent)
	BGFrame:SetScript("OnEnter", BGFrame.OnEnter)
	BGFrame:SetScript("OnLeave", BGFrame.OnLeave)
end

DataText.BGFrame = BGFrame