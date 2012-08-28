local T, C, L, G = unpack(select(2, ...)) 
--------------------------------------------------------------------
 -- BAGS
--------------------------------------------------------------------

if C["datatext"].bags and C["datatext"].bags > 0 then
	local Stat = CreateFrame("Frame", "TukuiStatBags")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat.Option = C.datatext.bags
	Stat.Color1 = T.RGBToHex(unpack(C.media.datatextcolor1))
	Stat.Color2 = T.RGBToHex(unpack(C.media.datatextcolor2))
	G.DataText.Bags = Stat

	local Text  = Stat:CreateFontString("TukuiStatBagsText", "OVERLAY")
	Text:SetFont(C.media.font, C["datatext"].fontsize)
	T.DataTextPosition(C["datatext"].bags, Text)
	G.DataText.Bags.Text = Text

	local function OnEvent(self, event, ...)
		local free, total,used = 0, 0, 0
		for i = 0, NUM_BAG_SLOTS do
			free, total = free + GetContainerNumFreeSlots(i), total + GetContainerNumSlots(i)
		end
		used = total - free
		Text:SetText(Stat.Color1..L.datatext_bags.."|r"..Stat.Color2..used.."/"..total.."|r")
		self:SetAllPoints(Text)
	end
          
	Stat:RegisterEvent("PLAYER_LOGIN")
	Stat:RegisterEvent("BAG_UPDATE")
	Stat:SetScript("OnEvent", OnEvent)
	Stat:SetScript("OnMouseDown", function() OpenAllBags() end)
end