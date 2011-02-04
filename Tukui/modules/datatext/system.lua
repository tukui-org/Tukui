--------------------------------------------------------------------
-- System Stats
--------------------------------------------------------------------
local T, C, L = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales

if not C["datatext"].system or C["datatext"].system == 0 then return end

local Stat = CreateFrame("Frame")
Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
Stat:SetFrameStrata("BACKGROUND")
Stat:SetFrameLevel(3)
Stat:EnableMouse(true)
Stat.tooltip = false

local Text  = TukuiInfoLeft:CreateFontString(nil, "OVERLAY")
Text:SetFont(C.media.font, C["datatext"].fontsize)
T.PP(C["datatext"].system, Text)

local bandwidthString = "%.2f Mbps"
local percentageString = "%.2f%%"

local kiloByteString = "%d kb"
local megaByteString = "%.2f mb"

local function formatMem(memory)
	local mult = 10^1
	if memory > 999 then
		local mem = ((memory/1024) * mult) / mult
		return string.format(megaByteString, mem)
	else
		local mem = (memory * mult) / mult
		return string.format(kiloByteString, mem)
	end
end

local memoryTable = {}

local function RebuildAddonList(self)
	local addOnCount = GetNumAddOns()
	if (addOnCount == #memoryTable) or self.tooltip == true then return end

	-- Number of loaded addons changed, create new memoryTable for all addons
	memoryTable = {}
	for i = 1, addOnCount do
		memoryTable[i] = { i, select(2, GetAddOnInfo(i)), 0, IsAddOnLoaded(i) }
	end
	self:SetAllPoints(Text)
end

local function UpdateMemory()
	-- Update the memory usages of the addons
	UpdateAddOnMemoryUsage()
	-- Load memory usage in table
	local addOnMem = 0
	local totalMemory = 0
	for i = 1, #memoryTable do
		addOnMem = GetAddOnMemoryUsage(memoryTable[i][1])
		memoryTable[i][3] = addOnMem
		totalMemory = totalMemory + addOnMem
	end
	-- Sort the table to put the largest addon on top
	table.sort(memoryTable, function(a, b)
		if a and b then
			return a[3] > b[3]
		end
	end)
	
	return totalMemory
end

local int = 10

local function Update(self, t)
	int = int - t
	
	if int < 0 then
		RebuildAddonList(self)
		local total = UpdateMemory()
		Text:SetText(formatMem(total))
		int = 10
	end
end

Stat:SetScript("OnMouseDown", function () collectgarbage("collect") Update(Stat, 10) end)
Stat:SetScript("OnEnter", function(self)
	if not InCombatLockdown() then
		self.tooltip = true
		local bandwidth = GetAvailableBandwidth()
		local anchor, panel, xoff, yoff = T.DataTextTooltipAnchor(Text)
		GameTooltip:SetOwner(panel, anchor, xoff, yoff)
		GameTooltip:ClearLines()
		if bandwidth ~= 0 then
			GameTooltip:AddDoubleLine(L.datatext_bandwidth , string.format(bandwidthString, bandwidth),0.69, 0.31, 0.31,0.84, 0.75, 0.65)
			GameTooltip:AddDoubleLine(L.datatext_download , string.format(percentageString, GetDownloadedPercentage() *100),0.69, 0.31, 0.31, 0.84, 0.75, 0.65)
			GameTooltip:AddLine(" ")
		end
		local totalMemory = UpdateMemory()
		GameTooltip:AddDoubleLine(L.datatext_totalmemusage, formatMem(totalMemory), 0.69, 0.31, 0.31,0.84, 0.75, 0.65)
		GameTooltip:AddLine(" ")
		for i = 1, #memoryTable do
			if (memoryTable[i][4]) then
				local red = memoryTable[i][3] / totalMemory
				local green = 1 - red
				GameTooltip:AddDoubleLine(memoryTable[i][2], formatMem(memoryTable[i][3]), 1, 1, 1, red, green + .5, 0)
			end						
		end
		GameTooltip:Show()
	end
end)
Stat:SetScript("OnLeave", function(self) self.tooltip = false GameTooltip:Hide() end)
Stat:SetScript("OnUpdate", Update)
Stat:SetScript("OnEvent", function(self, event) collectgarbage("collect") end)
Update(Stat, 10)