local T, C, L = unpack((select(2, ...)))

local Miscellaneous = T["Miscellaneous"]
local MirrorTimers = CreateFrame("Frame")
local Colors = T.Colors


function MirrorTimers:StyleBar( Bar )
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
	-- The reason for this is because on classic the hooked 'show' function does not appear to be called more than once.
	Status.DefaultSetStatusBarColor = Status.SetStatusBarColor
	Status.SetStatusBarColor = function() return end

	Text:ClearAllPoints()
	Text:SetPoint("CENTER", Bar)

	Border:SetTexture(nil)
end

function MirrorTimers:SetupContainer()
	local Container = _G.MirrorTimerContainer

	Container.expand = false
	Container.topPadding = 0
	Container.bottomPadding = 0
	Container.leftPadding = 0
	Container.rightPadding = 0
	Container.spacing = padding
	Container.respectChildScale = true

	hooksecurefunc(Container, "SetupTimer", self.SetupTimer)
end

function MirrorTimers:SetupTimerBars()
	local Container = _G.MirrorTimerContainer

	for _, Bar in ipairs(Container.mirrorTimers) do
		Bar.expand = true
		Bar.align = "center"
		Bar.topPadding = 0
		Bar.bottomPadding = 0
		Bar.leftPadding = 0
		Bar.rightPadding = 0
		self:StyleBar(Bar)
		Bar.isSkinned = true
	end
end

function MirrorTimers:SetupTimer(timer)
	local Bar = self:GetAvailableTimer(timer);
	if (not Bar) then return end

	local Status = Bar.StatusBar or _G[Bar:GetName().."StatusBar"]

	-- On retail the bars are colored via their textures, so a colour is required.
	Status:DefaultSetStatusBarColor( unpack( Colors.mirror[timer] ) )
end

function MirrorTimers:Update()
	for i = 1, MIRRORTIMER_NUMTIMERS, 1 do
		local Bar = _G["MirrorTimer"..i]

		if Bar and not Bar.isSkinned then
			MirrorTimers:StyleBar(Bar)
			Bar.isSkinned = true
		end

		-- For consistency with retail, set the custom colors we have.
		if ( Bar.timer ) then
			local Status = Bar.StatusBar or _G[Bar:GetName().."StatusBar"]

			Status:DefaultSetStatusBarColor( unpack( Colors.mirror[Bar.timer] ) )
		end
	end
end

function MirrorTimers:Enable()
	if T.Retail then
		self:SetupContainer()
		self:SetupTimerBars()
	else
		hooksecurefunc("MirrorTimer_Show", self.Update)
	end
end
Miscellaneous.MirrorTimers = MirrorTimers
