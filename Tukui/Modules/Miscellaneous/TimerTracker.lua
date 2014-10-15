local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local Timer = CreateFrame("Frame", nil, UIParent)
local TimerTracker = TimerTracker

-- [[ Dummy Bar Commands ]] --
-- /run TimerTracker_OnLoad(TimerTracker)
-- /run TimerTracker_OnEvent(TimerTracker, "START_TIMER", 1, 20, 20)
-- /run Tukui[1].Miscellaneous.TimerTracker:Update()

function Timer:UpdateBar()
	local Backdrop = {
		bgFile = C.Medias.Blank,
		insets = {top = -T.Mult, left = -T.Mult, bottom = -T.Mult, right = -T.Mult},
	}
	
	for i = 1, self:GetNumRegions() do
		local Region = select(i, self:GetRegions())
		
		if Region:GetObjectType() == "Texture" then
			Region:SetTexture(nil)
		elseif Region:GetObjectType() == "FontString" then
			Region:SetFont(C.Medias.Font, 10, "THINOUTLINE")
			Region:SetShadowColor(0,0,0,0)
		end
	end
	
	self:Height(26)
	self:StripTextures()
	self:SetBackdrop(Backdrop)
	self:SetBackdropColor(unpack(C.Medias.BackdropColor))
	self:SetStatusBarTexture(C.Medias.Normal)
	self:SetStatusBarColor(170/255, 10/255, 10/255)
	self:CreateShadow()
end

function Timer:Update()
	for _, Bars in pairs(TimerTracker.timerList) do
		if not Bars["bar"].IsSkinned then
			self.UpdateBar(Bars["bar"])

			Bars["bar"].IsSkinned = true
		end
	end
end

function Timer:Enable()
	self:RegisterEvent("START_TIMER")
	self:SetScript("OnEvent", self.Update)
end

Miscellaneous.TimerTracker = Timer
