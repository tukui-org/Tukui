local T, C, L = select(2, ...):unpack()

local Tooltips = T["Tooltips"]
local Talent = CreateFrame("Frame")
local format = string.format

Talent.Cache = {}
Talent.LastInspectRequest = 0
Talent.SlotNames = {
	"Head",
	"Neck",
	"Shoulder",
	"Back",
	"Chest",
	"Wrist",
	"Hands",
	"Waist",
	"Legs",
	"Feet",
	"Finger0",
	"Finger1",
	"Trinket0",
	"Trinket1",
	"MainHand",
	"SecondaryHand"
}

function Talent:GetItemLevel(unit)
	local Total, Item = 0, 0
	
	for i = 1, #Talent.SlotNames do
		local Slot = GetInventoryItemLink(unit, GetInventorySlotInfo(("%sSlot"):format(Talent.SlotNames[i])))
		
		if (Slot) then
			local ILVL = select(4, GetItemInfo(Slot))
			
			if (ILVL) then
				Item = Item + 1
				Total = Total + ILVL
			end
		end
	end
	
	if (Total < 1 or Total < 1) then
		return "..."
	end
	
	return floor(Total / Item)
end

function Talent:GetTalentSpec(unit)
	local Spec
	
	if not unit then
		Spec = GetSpecialization()
	else
		Spec = GetInspectSpecialization(unit)
	end
	
	if(Spec and Spec > 0) then
		if (unit) then 
			local Role = GetSpecializationRoleByID(Spec)
			
			if (Role) then
				local Name = select(2, GetSpecializationInfoByID(Spec))
				
				return Name
			end
		else
			local Name = select(2, GetSpecializationInfo(Spec))

			return Name
		end
	end
end

Talent:SetScript("OnUpdate", function(self, elapsed)
	if not (C.Tooltips.ShowSpec) then
		self:Hide()
		self:SetScript("OnUpdate", nil)
	end

	self.NextUpdate = (self.NextUpdate or 0) - elapsed
	
	if (self.NextUpdate) <= 0 then
		self:Hide()
		
		local GUID = UnitGUID("mouseover")
		
		if not GUID then
			return
		end
		
		if (GUID == self.CurrentGUID) and (not (InspectFrame and InspectFrame:IsShown())) then
			self.LastGUID = self.CurrentGUID
			self.LastInspectRequest = GetTime()
			self:RegisterEvent("INSPECT_READY")
			NotifyInspect(self.CurrentUnit)
		end
	end
end)

Talent:SetScript("OnEvent", function(self, event, GUID)
	if GUID ~= self.LastGUID or (InspectFrame and InspectFrame:IsShown()) then
		self:UnregisterEvent("INSPECT_READY")
		
		return
	end
	
	local ILVL = self:GetItemLevel("mouseover")
	local TalentSpec = self:GetTalentSpec("mouseover")
	local CurrentTime = GetTime()
	local MatchFound

	for i, Cache in ipairs(self.Cache) do
		if Cache.GUID == GUID then
			Cache.ItemLevel = ILVL
			Cache.TalentSpec = TalentSpec
			Cache.LastUpdate = floor(CurrentTime)
			
			MatchFound = true

			break
		end
	end

	if (not MatchFound) then
		local GUIDInfo = {
			["GUID"] = GUID,
			["ItemLevel"] = ILVL,
			["TalentSpec"] = TalentSpec,
			["LastUpdate"] = floor(CurrentTime)
		}	
		
		self.Cache[#self.Cache + 1] = GUIDInfo
	end
	
	if (#self.Cache > 50) then
		table.remove(self.Cache, 1)
	end

	GameTooltip:SetUnit("mouseover")

	ClearInspectPlayer()
	
	self:UnregisterEvent("INSPECT_READY")
end)

Tooltips.Talent = Talent
