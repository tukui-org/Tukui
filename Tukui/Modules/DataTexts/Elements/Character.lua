local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local format = format
local ClassColor = T.RGBToHex(unpack(T.Colors.class[T.MyClass]))

local Update = function(self)
	local Total = 0
	local Current, Max

	for i = 1, 11 do
		if (GetInventoryItemLink("player", L.DataText.Slots[i][1]) ~= nil) then
			Current, Max = GetInventoryItemDurability(L.DataText.Slots[i][1])

			if Current then
				L.DataText.Slots[i][3] = Current / Max
				
				Total = Total + 1
			end
		end
	end

	table.sort(L.DataText.Slots, function(a, b) return a[3] < b[3] end)
end

local OnEnter = function(self)
	if (not InCombatLockdown()) then
		PaperDollFrame_UpdateStats()
		
		GameTooltip:SetOwner(self:GetTooltipAnchor())
		GameTooltip:ClearLines()
		
		local Objects = CharacterStatsPane.statsFramePool.activeObjects
		
		-- Sort attributes
		GameTooltip:AddDoubleLine(ClassColor..T.MyName.."|r", T.MyRealm)
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("|CFFFFFFFF"..PET_BATTLE_STATS_LABEL.."|r")
		GameTooltip:AddDoubleLine("|CF00FFF00"..LEVEL.."|r", UnitLevel("player"))
		GameTooltip:AddDoubleLine("|CF00FFF00"..ITEM_UPGRADE_STAT_AVERAGE_ITEM_LEVEL.."|r", GetAverageItemLevel())
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("|CFFFFFFFF"..STAT_CATEGORY_ATTRIBUTES.."|r")
		
		for Table in pairs(Objects) do
			local Label = Table.Label:GetText()
			local Value = Table.Value:GetText()
			local Percent = string.find(Value, "%%")
			
			
			if not Percent then
				GameTooltip:AddDoubleLine("|CF00FFF00"..Label.."|r", "|CFFFFFFFF"..Value.."|r")
			end
		end
		
		-- Sort enhancements
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("|CFFFFFFFF"..STAT_CATEGORY_ENHANCEMENTS.."|r")
		
		for Table in pairs(Objects) do
			local Label = Table.Label:GetText()
			local Value = Table.Value:GetText()
			local Percent = string.find(Value, "%%")
			
			if Percent then
				GameTooltip:AddDoubleLine("|CFFFFFF00"..Label.."|r", "|CFFFFFFFF"..Value.."|r")
			end
		end
		
		-- Display durability
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("|CFFFFFFFF"..DURABILITY.."|r")

		for i = 1, 11 do
			if (L.DataText.Slots[i][3] ~= 1000) then
				local Green, Red
				Green = L.DataText.Slots[i][3] * 2
				Red = 1 - Green
				GameTooltip:AddDoubleLine(L.DataText.Slots[i][2]..":", floor(L.DataText.Slots[i][3] * 100).."%", Red + 1, Green, 0, Red + 1, Green, 0)
			end
		end

		GameTooltip:Show()
	end
end

local Enable = function(self)
	self:RegisterEvent("MERCHANT_SHOW")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
	self:SetScript("OnEvent", Update)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", GameTooltip_Hide)
	self:SetScript("OnMouseDown", function() ToggleCharacter("PaperDollFrame") end)
	self:Update()
	self.Text:SetText(ClassColor..T.MyName.."|r")
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
end

DataText:Register("Character", Enable, Disable, Update)
