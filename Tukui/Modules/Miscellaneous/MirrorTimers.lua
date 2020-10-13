local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local MirrorTimers = CreateFrame("Frame")

function MirrorTimers:Update()
	for i = 1, MIRRORTIMER_NUMTIMERS, 1 do
		local Bar = _G["MirrorTimer"..i]
		if not Bar.isSkinned then
			local Status = _G[Bar:GetName().."StatusBar"]
			local Border = _G[Bar:GetName().."Border"]
			local Text = _G[Bar:GetName().."Text"]

			Bar:StripTextures()
			Bar:CreateBackdrop()
			Bar.Backdrop:SetBackdropColor(unpack(C.General.BackdropColor))
			Bar.Backdrop:CreateShadow()

			Status:ClearAllPoints()
			Status:SetInside(Bar, 1, 1)
			Status:SetStatusBarTexture(C.Medias.Normal)

			Text:ClearAllPoints()
			Text:SetPoint("CENTER", Bar)

			Border:SetTexture(nil)

			Bar.isSkinned = true
		end
	end
end

function MirrorTimers:Enable()
	hooksecurefunc("MirrorTimer_Show", MirrorTimers.Update)
end

Miscellaneous.MirrorTimers = MirrorTimers
