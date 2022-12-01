local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local Movers = T["Movers"]
local TalkingHead = CreateFrame("Frame")

function TalkingHead:OnEvent(event, addon)
	if addon ~= "Blizzard_TalkingHeadUI" then
		return
	end

	local Holder = CreateFrame("Frame", "TukuiTalkingHead", UIParent)
	local Frame = TalkingHeadFrame
	local CustomPosition = TukuiDatabase.Variables[T.MyRealm][T.MyName].Move["TukuiTalkingHead"]
	local A1, Parent, A2, X, Y = "TOP", UIParent, "TOP", 0, -10

	if CustomPosition then
		A1, Parent, A2, X, Y = unpack(CustomPosition)
	end

	Holder:SetWidth(Frame:GetWidth())
	Holder:SetHeight(Frame:GetHeight())
	Holder:ClearAllPoints()
	Holder:SetPoint(A1, Parent, A2, X, Y)
	
	Frame:SetParent(Holder)
	Frame:ClearAllPoints()
	Frame:SetPoint("CENTER", Holder)
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

	Movers:RegisterFrame(Holder, "Talking Head")
end

function TalkingHead:Enable()
	if not C.Misc.TalkingHeadEnable then
		UIParent:UnregisterEvent("TALKINGHEAD_REQUESTED")
		
		TalkingHeadFrame:UnregisterAllEvents()

		return
	end
	
	if TalkingHeadFrame then
		self:OnEvent("ADDON_LOADED", "Blizzard_TalkingHeadUI")
	else
		self:RegisterEvent("ADDON_LOADED")
		self:SetScript("OnEvent", self.OnEvent)
	end
end

Miscellaneous.TalkingHead = TalkingHead
