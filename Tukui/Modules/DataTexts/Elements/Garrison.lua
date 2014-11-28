local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]

local Update = function(self, event)
	GarrisonMissionList_UpdateMissions()
	
	local Missions = GarrisonMissionFrame.MissionTab.MissionList.inProgressMissions
	local Count = 0
	
	C_Garrison.GetInProgressMissions(Missions)
	
	for i = 1, #Missions do
		if Missions[i].inProgress then
			local TimeLeft = Missions[i].timeLeft:match("%d")
			
			if (TimeLeft ~= "0") then
				Count = Count + 1
			end
		end
	end
	
	if (Count > 0) then
		self.Text:SetText(DataText.ValueColor .. format(GARRISON_LANDING_IN_PROGRESS, Count))
	else
		self.Text:SetText(DataText.NameColor .. GARRISON_LOCATION_TOOLTIP)
	end
end

local OnEnter = function(self)
	if (not GarrisonMissionFrame) then
		return
	end
	
	GarrisonMissionList_UpdateMissions()
	
	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()
	
	local Missions = GarrisonMissionFrame.MissionTab.MissionList.inProgressMissions
	local NumMissions = #Missions
	
	C_Garrison.GetInProgressMissions(Missions)
	
	if (NumMissions == 0) then
		return
	end
	
	GameTooltip:AddLine(GARRISON_MISSIONS)
	
	for i = 1, NumMissions do
		local Mission = Missions[i]
		local TimeLeft = Mission.timeLeft:match("%d")
		
		if (Mission.inProgress and (TimeLeft ~= "0")) then
			GameTooltip:AddDoubleLine(Mission.name, Mission.timeLeft, 1, 1, 1, 1, 1, 1)
		end
	end
	
	local Available = GarrisonMissionFrame.MissionTab.MissionList.availableMissions
	local NumAvailable = #Available
	
	if (NumAvailable > 0) then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(format(GARRISON_LANDING_AVAILABLE, NumAvailable))
	end
	
	GameTooltip:Show()
end

local OnLeave = function(self)
	GameTooltip:Hide()
end

local Enable = function(self)
	if (not GarrisonMissionFrame) then
		LoadAddOn("Blizzard_GarrisonUI")
	end
	
    self:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
    self:RegisterEvent("GET_ITEM_INFO_RECEIVED")
    self:RegisterEvent("GARRISON_MISSION_LIST_UPDATE")
    self:RegisterEvent("GARRISON_MISSION_STARTED")
    self:RegisterEvent("GARRISON_MISSION_FINISHED")
	self:RegisterEvent("GARRISON_MISSION_COMPLETE_RESPONSE")
	self:SetScript("OnEvent", Update)
	self:SetScript("OnMouseDown", GarrisonLandingPage_Toggle)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", OnLeave)
	self:Update()
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
	self:SetScript("OnMouseDown", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
end

DataText:Register(GARRISON_LOCATION_TOOLTIP, Enable, Disable, Update)