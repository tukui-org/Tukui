--[[
	Author: Affli@RU-Howling Fjord, 
	All rights reserved.
--]]

local T, C, L = unpack(select(2, ...))

if not C.general.bigwigsreskin then return end
if not IsAddOnLoaded("BigWigs") then return end

local buttonsize = 19

-- init some tables to store backgrounds
local freebg = {}

-- styling functions
local createbg = function()
	local bg = CreateFrame("Frame")
	bg:SetTemplate("Transparent")
	return bg
end

local function freestyle(bar)
	-- reparent and hide bar background
	local bg = bar:Get("bigwigs:Tukui:bg")
	if bg then
		bg:ClearAllPoints()
		bg:SetParent(UIParent)
		bg:Hide()
		freebg[#freebg + 1] = bg
	end

	-- reparent and hide icon background
	local ibg = bar:Get("bigwigs:Tukui:ibg")
	if ibg then
		ibg:ClearAllPoints()
		ibg:SetParent(UIParent)
		ibg:Hide()
		freebg[#freebg + 1] = ibg
	end

	-- replace dummies with original method functions
	bar.candyBarBar.SetPoint=bar.candyBarBar.OldSetPoint
	bar.candyBarIconFrame.SetWidth=bar.candyBarIconFrame.OldSetWidth
	bar.SetScale=bar.OldSetScale
	
	--Reset Positions
	--Icon
	bar.candyBarIconFrame:ClearAllPoints()
	bar.candyBarIconFrame:SetPoint("TOPLEFT")
	bar.candyBarIconFrame:SetPoint("BOTTOMLEFT")
	bar.candyBarIconFrame:SetTexCoord(0.07, 0.93, 0.07, 0.93)

	--Status Bar
	bar.candyBarBar:ClearAllPoints()
	bar.candyBarBar:SetPoint("TOPRIGHT")
	bar.candyBarBar:SetPoint("BOTTOMRIGHT")

	--BG
	bar.candyBarBackground:SetAllPoints()

	--Duration
	bar.candyBarDuration:ClearAllPoints()
	bar.candyBarDuration:SetPoint("RIGHT", bar.candyBarBar, "RIGHT", -2, 0)

	--Name
	bar.candyBarLabel:ClearAllPoints()
	bar.candyBarLabel:SetPoint("LEFT", bar.candyBarBar, "LEFT", 2, 0)
	bar.candyBarLabel:SetPoint("RIGHT", bar.candyBarBar, "RIGHT", -2, 0)
end

local applystyle = function(bar)
	-- general bar settings
	bar:SetHeight(buttonsize)
	bar:SetScale(1)
	bar.OldSetScale=bar.SetScale
	bar.SetScale=T.dummy

	-- create or reparent and use bar background
	local bg = nil
	if #freebg > 0 then
		bg = table.remove(freebg)
	else
		bg = createbg()
	end
	
	bg:SetParent(bar)
	bg:ClearAllPoints()
	bg:Point("TOPLEFT", bar, "TOPLEFT", -2, 2)
	bg:Point("BOTTOMRIGHT", bar, "BOTTOMRIGHT", 2, -2)
	bg:SetFrameStrata("BACKGROUND")
	bg:Show()
	bar:Set("bigwigs:Tukui:bg", bg)

	-- create or reparent and use icon background
	local ibg = nil
	if bar.candyBarIconFrame:GetTexture() then
		if #freebg > 0 then
			ibg = table.remove(freebg)
		else
			ibg = createbg()
		end
		ibg:SetParent(bar)
		ibg:ClearAllPoints()
		ibg:Point("TOPLEFT", bar.candyBarIconFrame, "TOPLEFT", -2, 2)
		ibg:Point("BOTTOMRIGHT", bar.candyBarIconFrame, "BOTTOMRIGHT", 2, -2)
		ibg:SetFrameStrata("BACKGROUND")
		ibg:Show()
		bar:Set("bigwigs:Tukui:ibg", ibg)
	end

	-- setup timer and bar name fonts and positions
	bar.candyBarLabel:SetFont(C.media.font, C["datatext"].fontsize, "OUTLINE")
	bar.candyBarLabel:SetShadowColor(0, 0, 0, 0)
	bar.candyBarLabel:SetJustifyH("LEFT")
	bar.candyBarLabel:ClearAllPoints()
	bar.candyBarLabel:Point("LEFT", bar, "LEFT", 4, 0)
	
	bar.candyBarDuration:SetFont(C.media.font, C["datatext"].fontsize, "OUTLINE")
	bar.candyBarDuration:SetShadowColor(0, 0, 0, 0)
	bar.candyBarDuration:SetJustifyH("RIGHT")
	bar.candyBarDuration:ClearAllPoints()
	bar.candyBarDuration:Point("RIGHT", bar, "RIGHT", -4, 0)

	-- setup bar positions and look
	bar.candyBarBar:ClearAllPoints()
	bar.candyBarBar:SetAllPoints(bar)
	bar.candyBarBar.OldSetPoint = bar.candyBarBar.SetPoint
	bar.candyBarBar.SetPoint=T.dummy
	bar.candyBarBar:SetStatusBarTexture(C["media"].normTex)
	bar.candyBarBackground:SetTexture(unpack(C.media.backdropcolor))
	
	-- setup icon positions and other things
	bar.candyBarIconFrame:ClearAllPoints()
	bar.candyBarIconFrame:Point("BOTTOMRIGHT", bar, "BOTTOMLEFT", -7, 0)
	bar.candyBarIconFrame:SetSize(buttonsize, buttonsize)
	bar.candyBarIconFrame.OldSetWidth = bar.candyBarIconFrame.SetWidth
	bar.candyBarIconFrame.SetWidth=T.dummy
	bar.candyBarIconFrame:SetTexCoord(0.08, 0.92, 0.08, 0.92)
end
	

local f = CreateFrame("Frame")

local function RegisterStyle()
	if not BigWigs then return end
	local bars = BigWigs:GetPlugin("Bars", true)
	local prox = BigWigs:GetPlugin("Proximity", true)
	if bars then
		bars:RegisterBarStyle("Tukui", {
			apiVersion = 1,
			version = 1,
			GetSpacing = function(bar) return 7 end,
			ApplyStyle = applystyle,
			BarStopped = freestyle,
			GetStyleName = function() return "Tukui" end,
		})
	end
	if prox and BigWigs.pluginCore.modules.Bars.db.profile.barStyle == "Tukui" then
		hooksecurefunc(BigWigs.pluginCore.modules.Proximity, "RestyleWindow", function()
			BigWigsProximityAnchor:SetTemplate("Transparent")
		end)
	end
end

f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("Tukui_BigWigs") then return end
	if addon == "BigWigs_Plugins" then
		RegisterStyle()
		local profile = BigWigs3DB["profileKeys"][T.myname.." - "..T.myrealm]
		local path = BigWigs3DB["namespaces"]["BigWigs_Plugins_Bars"]["profiles"][profile]
		path.texture = C.media.normTex
		path.barStyle = "Tukui"
		path.font = C.media.font
		
		path = BigWigs3DB["namespaces"]["BigWigs_Plugins_Proximity"]["profiles"][profile]
		path.font = C.media.font
		
		self:UnregisterEvent("ADDON_LOADED")
	end
end)