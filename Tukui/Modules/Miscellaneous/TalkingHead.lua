local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local Movers = T["Movers"]
local TalkingHead = CreateFrame("Frame")

function TalkingHead:OnEvent(event, addon)
	if addon ~= "Blizzard_TalkingHeadUI" then
		return
	end
	
	local Frame = TalkingHeadFrame
	local CustomPosition = TukuiData[GetRealmName()][UnitName("Player")].Move["TalkingHeadFrame"]
	local A1, Parent, A2, X, Y = "TOP", UIParent, "TOP", 0, -10
	
	if CustomPosition then
		A1, Parent, A2, X, Y = unpack(CustomPosition)
		print(A1, Parent, A2, X, Y)
	end
	
	Frame:ClearAllPoints()
	Frame:Point(A1, Parent, A2, X, Y)

	Frame.ignoreFramePositionManager = true
	
	Movers:RegisterFrame(Frame)
end

function TalkingHead:Enable()
	if not C.Misc.TalkingHeadEnable then
		UIParent:UnregisterEvent("TALKINGHEAD_REQUESTED")
		
		return
	end
	
	self:RegisterEvent("ADDON_LOADED")
	self:SetScript("OnEvent", self.OnEvent)
end

Miscellaneous.TalkingHead = TalkingHead
