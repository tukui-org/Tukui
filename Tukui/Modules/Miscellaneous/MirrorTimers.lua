local T, C, L = unpack((select(2, ...)))

local Miscellaneous = T["Miscellaneous"]
local MirrorTimers = CreateFrame("Frame")

-- Retail only function here, dont see a need to put this behind T.Retail now until Tukz can come in and fix this properly without the bandaids being applied for 10.1.5
function MirrorTimers:SetupTimer(timer)
	local Bar = self:GetAvailableTimer(timer);
	if not Bar then return end

	Bar:StripTextures()
	Bar:CreateBackdrop()
	Bar.Backdrop:SetBackdropColor(unpack(C.General.BackdropColor))
	Bar.Backdrop:CreateShadow()

	if (Bar.StatusBar) then
		Bar.StatusBar:ClearAllPoints()
		Bar.StatusBar:SetInside(Bar, 2, 2)
		Bar.StatusBar:SetStatusBarTexture(C.Medias.Normal)
		Bar.StatusBar.SetStatusBarTexture = function() return end
	end

	if (Bar.Text) then
		Bar.Text:ClearAllPoints()
		Bar.Text:SetPoint("CENTER", Bar, "CENTER", 0, 0)
	end

	if (Bar.Border) then
		Bar.Border:SetTexture(nil)
	end

	Bar.isSkinned = true
end

function MirrorTimers:Update()
	for i = 1, MIRRORTIMER_NUMTIMERS, 1 do
		local Bar = _G["MirrorTimer"..i]

		if Bar and not Bar.isSkinned then
			local Status = Bar.StatusBar or _G[Bar:GetName().."StatusBar"]
			local Border = Bar.Border or _G[Bar:GetName().."Border"]
			local Text = Bar.Text or _G[Bar:GetName().."Text"]

			Bar:StripTextures()
			Bar:CreateBackdrop()
			Bar.Backdrop:SetBackdropColor(unpack(C.General.BackdropColor))
			Bar.Backdrop:CreateShadow()

			Status:ClearAllPoints()
			Status:SetInside(Bar, 2, 2)
			Status:SetStatusBarTexture(C.Medias.Normal)
			Status.SetStatusBarTexture = function() return end

			Text:ClearAllPoints()
			Text:SetPoint("CENTER", Bar)

			Border:SetTexture(nil)

			Bar.isSkinned = true
		end
	end
end

function MirrorTimers:Enable()
	if T.Retail then
		hooksecurefunc(_G.MirrorTimerContainer, "SetupTimer", self.SetupTimer)
	else
		hooksecurefunc("MirrorTimer_Show", self.Update)
	end
end
Miscellaneous.MirrorTimers = MirrorTimers
