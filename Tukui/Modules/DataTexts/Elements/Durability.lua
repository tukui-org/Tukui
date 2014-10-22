local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local format = format

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
	
	if (Total > 0) then
		self.Text:SetFormattedText("%s: %s", DataText.NameColor .. L.DataText.Armor .. "|r", DataText.ValueColor .. floor(L.DataText.Slots[1][3] * 100) .. "%|r")
	else
		self.Text:SetFormattedText("%s: %s", DataText.NameColor .. L.DataText.Armor .. "|r", DataText.ValueColor .. "100" .. "%|r")
	end

	Total = 0
end

local OnEnter = function(self)
	if (not InCombatLockdown()) then
		GameTooltip:SetOwner(self:GetTooltipAnchor())
		GameTooltip:ClearLines()
		
		for i = 1, 11 do
			if (L.DataText.Slots[i][3] ~= 1000) then
				local Green, Red
				Green = L.DataText.Slots[i][3] * 2
				Red = 1 - Green
				GameTooltip:AddDoubleLine(L.DataText.Slots[i][2], floor(L.DataText.Slots[i][3] * 100).."%", 1, 1, 1, Red + 1, Green, 0)
			end
		end
		
		GameTooltip:Show()
	end
end

local OnLeave = function()
	GameTooltip:Hide()
end

local Enable = function(self)
	self:RegisterEvent("MERCHANT_SHOW")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
	self:SetScript("OnEvent", Update)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", OnLeave)
	self:SetScript("OnMouseDown", function() ToggleCharacter("PaperDollFrame") end)
	self:Update()
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
end

DataText:Register(L.DataText.Durability, Enable, Disable, Update)