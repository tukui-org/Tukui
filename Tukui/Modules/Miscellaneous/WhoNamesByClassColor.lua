local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local WhoNamesByClassColor = CreateFrame("Frame")

function WhoNamesByClassColor:Update()
	local WhoOffset = FauxScrollFrame_GetOffset(WhoListScrollFrame)
	local WhoIndex, Button, Text, Name, Class
	
	for i=1, WHOS_TO_DISPLAY, 1 do
		WhoIndex = WhoOffset + i
		Button = _G["WhoFrameButton"..i]
		Class = _G["WhoFrameButton"..i.."Class"]
		Name = _G["WhoFrameButton"..i.."Name"]

		local Info = C_FriendList.GetWhoInfo(WhoIndex)
		
		if Info and Info.filename then
			if Name then
				Name:SetTextColor(unpack(T.Colors.class[Info.filename]))
			end
			
			if Class then
				Class:SetTextColor(1, 1, 1)
			end
		end
	end
end

function WhoNamesByClassColor:Enable()
	hooksecurefunc("WhoList_Update", self.Update)
end

Miscellaneous.WhoNamesByClassColor = WhoNamesByClassColor