local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local format = format
local int = 1
local MemoryTable = {}
local KilobyteString, MegabyteString
local Mult = 10^1
local bandwidthString = "%.2f Mbps"
local percentageString = "%.2f%%"

local FormatMemory = function(memory)
	if (memory > 999) then
		local Memory = ((memory/1024) * Mult) / Mult
		return string.format(MegabyteString, Memory)
	else
		local Memory = (memory * Mult) / Mult
		return string.format(KilobyteString, Memory)
	end
end

local UpdateMemory = function()
	-- Update the memory usages of the addons
	UpdateAddOnMemoryUsage()
	local AddOnMem = 0
	local TotalMem = 0
	
	for i = 1, #MemoryTable do
		AddOnMem = GetAddOnMemoryUsage(MemoryTable[i][1])
		MemoryTable[i][3] = AddOnMem
		TotalMem = TotalMem + AddOnMem
	end
	-- Sort the table to put the largest addon on top
	table.sort(MemoryTable, function(a, b)
		if (a and b) then
			return a[3] > b[3]
		end
	end)
	
	return TotalMem
end

local RebuildAddonList = function(self)
	local AddOnCount = GetNumAddOns()
	if (AddOnCount == #MemoryTable) or self.tooltip then
		return
	end

	wipe(MemoryTable)
	
	for i = 1, AddOnCount do
		MemoryTable[i] = { i, select(2, GetAddOnInfo(i)), 0, IsAddOnLoaded(i) }
	end
end

local Update = function(self, second)
	int = int - second
	
	if (int < 0) then
		RebuildAddonList(self)
		local Total = UpdateMemory()
		
		self.Text:SetText(DataText.ValueColor .. FormatMemory(Total) .. "|r")
		int = 10
	end
end

local OnEnter = function(self)
	if (not InCombatLockdown()) then
		GameTooltip:SetOwner(self:GetTooltipAnchor())
		GameTooltip:ClearLines()

		local Bandwidth = GetAvailableBandwidth()
		
		if (Bandwidth ~= 0) then
			GameTooltip:AddDoubleLine(L.DataText.Bandwidth , string.format(bandwidthString, Bandwidth),0.69, 0.31, 0.31,0.84, 0.75, 0.65)
			GameTooltip:AddDoubleLine(L.DataText.Download , string.format(percentageString, GetDownloadedPercentage() * 100), 0.69, 0.31, 0.31, 0.84, 0.75, 0.65)
			GameTooltip:AddLine(" ")
		end
		
		local TotalMemory = UpdateMemory()
		GameTooltip:AddDoubleLine(L.DataText.TotalMemory, FormatMemory(TotalMemory), 0.69, 0.31, 0.31,0.84, 0.75, 0.65)
		GameTooltip:AddLine(" ")
		
		for i = 1, #MemoryTable do
			if (MemoryTable[i][4]) then
				local Red = MemoryTable[i][3] / TotalMemory
				local Green = 1 - Red
				
				GameTooltip:AddDoubleLine(MemoryTable[i][2], FormatMemory(MemoryTable[i][3]), 1, 1, 1, Red, Green + .5, 0)
			end						
		end
		
		self.Text:SetText(DataText.ValueColor..FormatMemory(TotalMemory).."|r")
		GameTooltip:Show()
	end
end

local OnLeave = function()
	GameTooltip:Hide()
end

local OnMouseUp = function()
	collectgarbage("collect")
end

local ResetData = function(self, event)
	wipe(MemoryTable)
end

local Enable = function(self)
	KilobyteString = "%d ".. DataText.NameColor .."kb".."|r"
	MegabyteString = "%.2f ".. DataText.NameColor .."mb".."|r"
	self:RegisterEvent("ADDON_LOADED")
	self:SetScript("OnEvent", ResetData)
	self:SetScript("OnUpdate", Update)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", OnLeave)
	self:SetScript("OnMouseUp", OnMouseUp)
	self:Update(10)
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
	self:SetScript("OnUpdate", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
	self:SetScript("OnMouseUp", nil)
end

DataText:Register(L.DataText.Memory, Enable, Disable, Update)