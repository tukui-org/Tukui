local T, C, L = unpack((select(2, ...)))

local Miscellaneous = T["Miscellaneous"]
local MirrorTimers = CreateFrame("Frame")

if (T.Retail) then
	local MirrorTimerContainer = _G.MirrorTimerContainer
	local MirrorTimerAtlas = _G.MirrorTimerAtlas

	function MirrorTimers:SetupTimer(timer, value, maxvalue, paused, label)
		local Bar = self:GetAvailableTimer(timer);
		if (not Bar) then return end

		-- local originaTexture = MirrorTimerAtlas[timer]

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

	function MirrorTimers:Enable()
		hooksecurefunc(MirrorTimerContainer, "SetupTimer", self.SetupTimer)
	end
else
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
		hooksecurefunc("MirrorTimer_Show", self.Update)
	end
end

Miscellaneous.MirrorTimers = MirrorTimers
