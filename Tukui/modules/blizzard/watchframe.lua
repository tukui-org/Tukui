local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

local TukuiWatchFrame = CreateFrame("Frame", "TukuiWatchFrame", UIParent)
TukuiWatchFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

-- to be compatible with blizzard option
local wideFrame = GetCVar("watchFrameWidth")

-- create our moving area
local TukuiWatchFrameAnchor = CreateFrame("Button", "TukuiWatchFrameAnchor", UIParent)
TukuiWatchFrameAnchor:SetFrameStrata("HIGH")
TukuiWatchFrameAnchor:SetFrameLevel(20)
TukuiWatchFrameAnchor:SetHeight(20)
TukuiWatchFrameAnchor:SetClampedToScreen(true)
TukuiWatchFrameAnchor:SetMovable(true)
TukuiWatchFrameAnchor:EnableMouse(false)
TukuiWatchFrameAnchor:SetTemplate("Default")
TukuiWatchFrameAnchor:SetBackdropBorderColor(0,0,0,0)
TukuiWatchFrameAnchor:SetBackdropColor(0,0,0,0)
TukuiWatchFrameAnchor.text = T.SetFontString(TukuiWatchFrameAnchor, C.media.uffont, 12)
TukuiWatchFrameAnchor.text:SetPoint("CENTER")
TukuiWatchFrameAnchor.text:SetText(L.move_watchframe)
TukuiWatchFrameAnchor.text:Hide()

-- set default position according to how many right bars we have
TukuiWatchFrameAnchor:Point("TOPRIGHT", UIParent, -210, -220)

-- width of the watchframe according to our Blizzard cVar.
if wideFrame == "1" then
	TukuiWatchFrame:SetWidth(350)
	TukuiWatchFrameAnchor:SetWidth(350)
else
	TukuiWatchFrame:SetWidth(250)
	TukuiWatchFrameAnchor:SetWidth(250)
end

local screenheight = T.getscreenheight
TukuiWatchFrame:SetParent(TukuiWatchFrameAnchor)
TukuiWatchFrame:SetHeight(screenheight / 1.6)
TukuiWatchFrame:ClearAllPoints()
TukuiWatchFrame:SetPoint("TOP")

local function init()
	TukuiWatchFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
	TukuiWatchFrame:RegisterEvent("CVAR_UPDATE")
	TukuiWatchFrame:SetScript("OnEvent", function(_,_,cvar,value)
		if cvar == "WATCH_FRAME_WIDTH_TEXT" then
			if not WatchFrame.userCollapsed then
				if value == "1" then
					TukuiWatchFrame:SetWidth(350)
					TukuiWatchFrameAnchor:SetWidth(350)
				else
					TukuiWatchFrame:SetWidth(250)
					TukuiWatchFrameAnchor:SetWidth(250)
				end
			end
			wideFrame = value
		end
	end)
end

local function setup()	
	WatchFrame:SetParent(TukuiWatchFrame)
	WatchFrame:SetFrameStrata("MEDIUM")
	WatchFrame:SetFrameLevel(3)
	WatchFrame:SetClampedToScreen(false)
	WatchFrame:ClearAllPoints()
	WatchFrame.ClearAllPoints = function() end
	WatchFrame:SetPoint("TOPLEFT", 32,-2.5)
	WatchFrame:SetPoint("BOTTOMRIGHT", 4,0)
	WatchFrame.SetPoint = T.dummy

	WatchFrameTitle:SetParent(TukuiWatchFrame)
	WatchFrameCollapseExpandButton:SetParent(TukuiWatchFrame)
	WatchFrameCollapseExpandButton:SetFrameStrata(WatchFrameHeader:GetFrameStrata())
	WatchFrameCollapseExpandButton:SetFrameLevel(WatchFrameHeader:GetFrameLevel() + 1)
	WatchFrameCollapseExpandButton:SetNormalTexture("")
	WatchFrameCollapseExpandButton:SetPushedTexture("")
	WatchFrameCollapseExpandButton:SetHighlightTexture("")
	WatchFrameCollapseExpandButton:SetTemplate("Default")
	WatchFrameCollapseExpandButton:FontString("text", C.media.font, 12)
	WatchFrameCollapseExpandButton.text:SetText("X")
	WatchFrameCollapseExpandButton.text:Point("CENTER", 1, 0)
	WatchFrameCollapseExpandButton:HookScript("OnClick", function(self) 
		if WatchFrame.collapsed then 
			self.text:SetText("V") 
		else 
			self.text:SetText("X")
		end 
	end)
	WatchFrameTitle:Kill()
end

------------------------------------------------------------------------
-- Execute setup after we enter world
------------------------------------------------------------------------

local f = CreateFrame("Frame")
f:Hide()
f.elapsed = 0
f:SetScript("OnUpdate", function(self, elapsed)
	f.elapsed = f.elapsed + elapsed
	if f.elapsed > .5 then
		setup()
		f:Hide()
	end
end)
TukuiWatchFrame:SetScript("OnEvent", function() if not IsAddOnLoaded("Who Framed Watcher Wabbit") or not IsAddOnLoaded("Fux") then init() f:Show() end end)