local T, C, L = unpack((select(2, ...)))

local Miscellaneous = T["Miscellaneous"]
local MirrorTimers = CreateFrame("Frame")

local MirrorTimerContainer = _G.MirrorTimerContainer
local MirrorTimerAtlas = _G.MirrorTimerAtlas

function MirrorTimers:SetupTimer(timer, value, maxvalue, paused, label)
	local Bar = MirrorTimerContainer:GetAvailableTimer(timer);
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
	hooksecurefunc(MirrorTimerContainer, "SetupTimer", MirrorTimers.SetupTimer)
end

Miscellaneous.MirrorTimers = MirrorTimers
