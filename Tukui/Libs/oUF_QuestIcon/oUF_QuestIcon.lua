local parent, ns = ...
local oUF = ns.oUF
local ScanTooltip = CreateFrame("GameTooltip", "oUF_QuestIconTooltip", UIParent, "GameTooltipTemplate")

Cache = {
	-- Cache for NPCs
}

local ClearCache = function(self)
	Cache = {}
end

local DisplayQuestIcon = function(self)
	local QuestIcon = self.QuestIcon
	local Name = UnitName(self.unit)
	
	if Cache[Name] == "QUEST" then
		if not QuestIcon:IsShown() then
			QuestIcon:Show()
		end
	else
		if QuestIcon:IsShown() then
			QuestIcon:Hide()
		end
	end
end

local FindPlateWithQuest = function(self, unit)
	local QuestIcon = self.QuestIcon
	
	if QuestIcon then
		local Name = UnitName(unit)
		
		if not Cache[Name] then
			ScanTooltip:ClearLines()
			ScanTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
			ScanTooltip:SetUnit(unit)
			ScanTooltip:Show()

			local NumLines = ScanTooltip:NumLines()
			local Name = UnitName(unit)
			
			Cache[Name] = "NOQUEST"

			if NumLines >= 3 then
				for i = 3, NumLines do
					local Line = _G[ScanTooltip:GetName().."TextLeft"..i]
					local r, g, b = Line:GetTextColor()

					if (r > 0.99 and r <= 1) and (g > 0.82 and g < 0.83) and (b >= 0 and b < 0.01) then
						Cache[Name] = "QUEST"
						
						break
					end
				end
			end
			
			ScanTooltip:Hide()
		end
	end
end

local Update = function(self, event)
	if IsInInstance() then
		return
	end
	
	if event ~= "NAME_PLATE_UNIT_ADDED" then
		ClearCache()
	end
	
	local QuestIcon = self.QuestIcon
	local Unit = self.unit
	local NumPlates = C_NamePlate.GetNamePlates()
	
	if(QuestIcon.PreUpdate) then 
		QuestIcon:PreUpdate()
	end
	
	for i, Plate in pairs(NumPlates) do
		FindPlateWithQuest(self, Unit)
		
		DisplayQuestIcon(self)
	end

	if(QuestIcon.PostUpdate) then
		return QuestIcon:PostUpdate()
	end
end

local Path = function(self, ...)
	return (self.QuestIcon.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate')
end

local function Enable(self)
	local QuestIcon = self.QuestIcon
	
	if (QuestIcon) then
		QuestIcon.__owner = self
		QuestIcon.ForceUpdate = ForceUpdate

		if not QuestIcon:GetTexture() then
			QuestIcon:SetTexture([[Interface\QuestFrame\AutoQuest-Parts]])
			QuestIcon:SetTexCoord(0.13476563, 0.17187500, 0.01562500, 0.53125000)
		end

		self:RegisterEvent("QUEST_ACCEPTED", Path, true)
		self:RegisterEvent("QUEST_REMOVED", Path, true)
		self:RegisterEvent("NAME_PLATE_UNIT_ADDED", Path, true)

		return true
	end
end

local function Disable(self)
	local QuestIcon = self.QuestIcon
	
	if (QuestIcon) then
		self:UnregisterEvent('QUEST_ACCEPTED', Path, true)
		self:UnregisterEvent('QUEST_REMOVED', Path, true)
		self:UnregisterEvent('NAME_PLATE_UNIT_ADDED', Path, true)
	end
end

oUF:AddElement('QuestIcon', Path, Enable, Disable)