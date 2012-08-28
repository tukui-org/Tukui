local T, C, L, G = unpack(select(2, ...)) 
if C.tooltip.enable ~= true then return end

local function ClearItemID(self)
	self.TukuiItemTooltip = nil
end
T.ClearTooltipItemID = ClearItemID

local function ShowItemID(self)
	if (IsShiftKeyDown() or IsAltKeyDown()) and (TukuiItemTooltip and not self.TukuiItemTooltip and (TukuiItemTooltip.id or TukuiItemTooltip.count)) then
		local item, link = self:GetItem()
		local num = GetItemCount(link)
		local left = ""
		local right = ""
		
		if TukuiItemTooltip.id and link ~= nil then
			left = "|cFFCA3C3CID|r "..link:match(":(%w+)")
		end
		
		if TukuiItemTooltip.count and num > 1 then
			right = "|cFFCA3C3C"..L.tooltip_count.."|r "..num
		end
				
		self:AddLine(" ")
		self:AddDoubleLine(left, right)
		self.TukuiItemTooltip = 1
	end
end
T.ShowTooltipItemID = ShowItemID

GameTooltip:HookScript("OnTooltipCleared", ClearItemID)
GameTooltip:HookScript("OnTooltipSetItem", ShowItemID)

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(_, _, name)
	if name ~= "Tukui" then return end
	f:UnregisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent", nil)
	TukuiItemTooltip = TukuiItemTooltip or {count=true, id=true}
end)
