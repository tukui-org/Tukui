local T, C, L = select(2, ...):unpack()
local DataText = T["DataTexts"]

--Lua functions
local select, collectgarbage = select, collectgarbage
local sort, wipe, floor, format = sort, wipe, floor, format
--WoW API / Variables
local GetAddOnCPUUsage = GetAddOnCPUUsage
local GetAddOnInfo = GetAddOnInfo
local GetAddOnMemoryUsage = GetAddOnMemoryUsage
local GetAvailableBandwidth = GetAvailableBandwidth
local GetCVar = GetCVar
local GetCVarBool = GetCVarBool
local GetDownloadedPercentage = GetDownloadedPercentage
local GetFramerate = GetFramerate
local GetNetIpTypes = GetNetIpTypes
local GetNetStats = GetNetStats
local GetNumAddOns = GetNumAddOns
local IsAddOnLoaded = IsAddOnLoaded
local IsShiftKeyDown = IsShiftKeyDown
local IsModifierKeyDown = IsModifierKeyDown
local ResetCPUUsage = ResetCPUUsage
local UpdateAddOnCPUUsage = UpdateAddOnCPUUsage
local UpdateAddOnMemoryUsage = UpdateAddOnMemoryUsage
local UNKNOWN = UNKNOWN

-- initial delay for update (let the ui load)
local int, int2 = 6, 5
local statusColors = {
	"|cff0CD809",
	"|cffE8DA0F",
	"|cffFF9000",
	"|cffD80909"
}

local enteredFrame = false
local bandwidthString = "%.2f Mbps"
local percentageString = "%.2f%%"
local homeLatencyString = "%d ms"
local kiloByteString = "%d kb"
local megaByteString = "%.2f mb"

local function formatMem(memory)
	local mult = 10^1
	if memory > 999 then
		local mem = ((memory/1024) * mult) / mult
		return format(megaByteString, mem)
	else
		local mem = (memory * mult) / mult
		return format(kiloByteString, mem)
	end
end

local function sortByMemoryOrCPU(a, b)
	if a and b then
		return (a[3] == b[3] and a[2] < b[2]) or a[3] > b[3]
	end
end

local memoryTable = {}
local cpuTable = {}
local function RebuildAddonList()
	local addOnCount = GetNumAddOns()
	if (addOnCount == #memoryTable) then return end

	-- Number of loaded addons changed, create new memoryTable for all addons
	wipe(memoryTable)
	wipe(cpuTable)
	for i = 1, addOnCount do
		memoryTable[i] = {i, select(2, GetAddOnInfo(i)), 0}
		cpuTable[i] = {i, select(2, GetAddOnInfo(i)), 0}
	end
end

local function UpdateMemory()
	-- Update the memory usages of the addons
	UpdateAddOnMemoryUsage()
	-- Load memory usage in table
	local totalMemory = 0
	for i = 1, #memoryTable do
		memoryTable[i][3] = GetAddOnMemoryUsage(memoryTable[i][1])
		totalMemory = totalMemory + memoryTable[i][3]
	end
	-- Sort the table to put the largest addon on top
	sort(memoryTable, sortByMemoryOrCPU)
	return totalMemory
end

local function UpdateCPU()
	--Update the CPU usages of the addons
	UpdateAddOnCPUUsage()
	-- Load cpu usage in table
	local totalCPU = 0
	for i = 1, #cpuTable do
		local addonCPU = GetAddOnCPUUsage(cpuTable[i][1])
		cpuTable[i][3] = addonCPU
		totalCPU = totalCPU + addonCPU
	end

	-- Sort the table to put the largest addon on top
	sort(cpuTable, sortByMemoryOrCPU)

	return totalCPU
end

local function Click()
	if IsModifierKeyDown() then
		collectgarbage("collect")
		ResetCPUUsage()
	end
end

local function OnLeave()
	enteredFrame = false
	GameTooltip_Hide()
end

local ipTypes = {"IPv4", "IPv6"}
local function OnEnter(self)
	enteredFrame = true
	local cpuProfiling = GetCVar("scriptProfile") == "1"
	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()

	local totalMemory = UpdateMemory()
	local bandwidth = GetAvailableBandwidth()
	local _, _, homePing, worldPing = GetNetStats()

	GameTooltip:AddDoubleLine("Home Latency:", format(homeLatencyString, homePing), 0.69, 0.31, 0.31,0.84, 0.75, 0.65)
	GameTooltip:AddDoubleLine("World Latency:", format(homeLatencyString, worldPing), 0.69, 0.31, 0.31,0.84, 0.75, 0.65)

	if GetCVarBool("useIPv6") then
		local ipTypeHome, ipTypeWorld = GetNetIpTypes()
		GameTooltip:AddDoubleLine("Home Protocol:", ipTypes[ipTypeHome or 0] or UNKNOWN, 0.69, 0.31, 0.31,0.84, 0.75, 0.65)
		GameTooltip:AddDoubleLine("World Protocol:", ipTypes[ipTypeWorld or 0] or UNKNOWN, 0.69, 0.31, 0.31,0.84, 0.75, 0.65)
	end

	if bandwidth ~= 0 then
		GameTooltip:AddDoubleLine("Bandwidth", format(bandwidthString, bandwidth),0.69, 0.31, 0.31,0.84, 0.75, 0.65)
		GameTooltip:AddDoubleLine("Download", format(percentageString, GetDownloadedPercentage() *100),0.69, 0.31, 0.31, 0.84, 0.75, 0.65)
		GameTooltip:AddLine(" ")
	end

	local totalCPU
	GameTooltip:AddDoubleLine("Total Memory:", formatMem(totalMemory), 0.69, 0.31, 0.31,0.84, 0.75, 0.65)
	if cpuProfiling then
		totalCPU = UpdateCPU()
		GameTooltip:AddDoubleLine("Total CPU:", format(homeLatencyString, totalCPU), 0.69, 0.31, 0.31,0.84, 0.75, 0.65)
	end

	GameTooltip:AddLine(" ")
	
	if IsShiftKeyDown() or not cpuProfiling then
		for i = 1, #memoryTable do
			local ele = memoryTable[i]
			if ele and IsAddOnLoaded(ele[1]) then
				local red = ele[3] / totalMemory
				local green = 1 - red
				GameTooltip:AddDoubleLine(ele[2], formatMem(ele[3]), 1, 1, 1, red, green + .5, 0)
			end
		end
	else
		for i = 1, #cpuTable do
			local ele = cpuTable[i]
			if ele and IsAddOnLoaded(ele[1]) then
				local red = ele[3] / totalCPU
				local green = 1 - red
				GameTooltip:AddDoubleLine(ele[2], format(homeLatencyString, ele[3]), 1, 1, 1, red, green + .5, 0)
			end
		end
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("(Hold Shift) Memory Usage")
	end
	
	if IsShiftKeyDown() or not cpuProfiling then
		GameTooltip:AddLine(" ")
	end
	
	GameTooltip:AddLine("(Modifer Click) Collect Garbage")
	GameTooltip:Show()
end

local function Update(self, t)
	int = int - t
	int2 = int2 - t

	if int < 0 then
		RebuildAddonList()
		int = 10
	end
	
	if int2 < 0 then
		local framerate = floor(GetFramerate())
		local latency = select(4, GetNetStats())
		local FPS = DataText.NameColor.."FPS|r"
		local MS = DataText.NameColor.."MS|r"

		self.Text:SetFormattedText(
			FPS.." %s%d|r "..MS.." %s%d|r", DataText.StatusColors[framerate >= 30 and 1 or (framerate >= 20 and framerate < 30) and 2 or (framerate >= 10 and framerate < 20) and 3 or 4], 
			framerate, DataText.StatusColors[latency < 150 and 1 or (latency >= 150 and latency < 300) and 2 or (latency >= 300 and latency < 500) and 3 or 4], 
			latency
		)
		
		int2 = 1
		
		if enteredFrame then
			OnEnter(self)
		end
	end
end

local Enable = function(self)
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:SetScript("OnEvent", OnLeave)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnUpdate", Update)
	self:SetScript("OnLeave", OnLeave)
	self:SetScript("OnMouseUp", Click)
	self:Update(int)
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnUpdate", nil)
	self:SetScript("OnLeave", nil)
	self:SetScript("OnMouseUp", nil)
end

DataText:Register("System", Enable, Disable, Update)
