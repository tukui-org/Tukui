local parent, ns = ...
local oUF = ns.oUF
local ScanTooltip = CreateFrame("GameTooltip", "oUF_QuestIconTooltip", UIParent, "GameTooltipTemplate")

local FindPlateWithQuest = function(self, unit)
	local QuestIcon = self.QuestIcon
	
	if QuestIcon then
		ScanTooltip:ClearLines()
		ScanTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
		ScanTooltip:SetUnit(unit)
		ScanTooltip:Show()

		local NumLines = ScanTooltip:NumLines()

		if NumLines >= 3 then
			for i = 3, NumLines do
				local Line = _G[ScanTooltip:GetName().."TextLeft"..i]
				local r, g, b = Line:GetTextColor()

				if (r > 0.99 and r <= 1) and (g > 0.82 and g < 0.83) and (b >= 0 and b < 0.01) then
					QuestIcon:Show()

					break
				else
					QuestIcon:Hide()
				end
			end
		else
			QuestIcon:Hide()
		end

		ScanTooltip:Hide()
	end
end

local Update = function(self, event)
	local QuestIcon = self.QuestIcon
	local Unit = self.unit
	local NumPlates = C_NamePlate.GetNamePlates()
	
	if(QuestIcon.PreUpdate) then 
		QuestIcon:PreUpdate()
	end
	
	for i, Plate in pairs(NumPlates) do
		FindPlateWithQuest(self, Unit)
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
		
		QuestIcon:SetTexture([[Interface\QuestFrame\AutoQuest-Parts]])
		QuestIcon:SetTexCoord(0.13476563, 0.17187500, 0.01562500, 0.53125000)

		self:RegisterEvent("QUEST_LOG_UPDATE", Path, true)
		self:RegisterEvent("NAME_PLATE_UNIT_ADDED", Path, true)

		return true
	end
end

local function Disable(self)
	local QuestIcon = self.QuestIcon
	
	if (QuestIcon) then
		self:UnregisterEvent('QUEST_LOG_UPDATE', Path, true)
		self:UnregisterEvent('NAME_PLATE_UNIT_ADDED', Path, true)
	end
end

oUF:AddElement('QuestIcon', Path, Enable, Disable)