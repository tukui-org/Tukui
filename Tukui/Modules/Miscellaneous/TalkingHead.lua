local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local Movers = T["Movers"]
local TalkingHead = CreateFrame("Frame")

function TalkingHead:OnEvent(event, addon)
	if addon ~= "Blizzard_TalkingHeadUI" then
		return
	end

	local Frame = TalkingHeadFrame
	local CustomPosition = TukuiDatabase.Variables[T.MyRealm][T.MyName].Move["TalkingHeadFrame"]
	local A1, Parent, A2, X, Y = "TOP", UIParent, "TOP", 0, -10
	
	if CustomPosition then
		A1, Parent, A2, X, Y = unpack(CustomPosition)
	end

	Frame:ClearAllPoints()
	Frame:SetPoint(A1, Parent, A2, X, Y)
	Frame.ignoreFramePositionManager = true
	
	if not Frame.IsSkinned then
		Frame:CreateBackdrop("Transparent")
		
		Frame.Backdrop:ClearAllPoints()
		Frame.Backdrop:SetAllPoints(Frame.BackgroundFrame)
		Frame.Backdrop:CreateShadow()
		
		Frame.BackgroundFrame:SetParent(T.Hider)

		Frame.MainFrame.CloseButton:SkinCloseButton()
		
		Frame.PortraitFrame.Portrait:SetParent(T.Hider)
		
		Frame.MainFrame.Model:CreateBackdrop()
		Frame.MainFrame.Model.Backdrop:ClearAllPoints()
		Frame.MainFrame.Model.Backdrop:SetOutside()
		
		Frame.IsSkinned = true
	end
	
	Movers:RegisterFrame(Frame, "Talking Head")
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