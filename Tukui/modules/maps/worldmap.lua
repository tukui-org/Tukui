local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
if not C["map"].enable == true then return end

WORLDMAP_WINDOWED_SIZE = 0.65 --Slightly increase the size of blizzard small map
local mapscale = WORLDMAP_WINDOWED_SIZE

local ft = C["media"].font -- Map font
local fontsize = 22 -- Map Font Size

local mapbg = CreateFrame("Frame", nil, WorldMapDetailFrame)
mapbg:SetTemplate("Default")
mapbg:CreateShadow("Default")

--Create move button for map
local movebutton = CreateFrame ("Frame", nil, WorldMapFrameSizeUpButton)
movebutton:Height(32)
movebutton:Width(32)
movebutton:Point("TOP", WorldMapFrameSizeUpButton, "BOTTOM", -1, 4)
movebutton:SetBackdrop({bgFile = "Interface\\AddOns\\Tukui\\medias\\textures\\cross"})
movebutton:EnableMouse(true)

movebutton:SetScript("OnMouseDown", function()
	local maplock = GetCVar("advancedWorldMap")
	if maplock ~= "1" or InCombatLockdown() then return end
	WorldMapScreenAnchor:ClearAllPoints()
	WorldMapFrame:ClearAllPoints()
	WorldMapFrame:StartMoving()
	WorldMapBlobFrame:Hide()
end)

movebutton:SetScript("OnMouseUp", function()
	local maplock = GetCVar("advancedWorldMap")
	if maplock ~= "1" or InCombatLockdown() then return end
	WorldMapFrame:StopMovingOrSizing()
	WorldMapScreenAnchor:StartMoving()
	WorldMapScreenAnchor:SetPoint("TOPLEFT", WorldMapFrame)
	WorldMapScreenAnchor:StopMovingOrSizing()
	WorldMapBlobFrame:Show()
	
	-- update it
	WorldMapFrame:Hide()
	WorldMapFrame:Show()
end)

-- look if map is not locked
local MoveMap = GetCVarBool("advancedWorldMap")
if MoveMap == nil then
	SetCVar("advancedWorldMap", 1)
end

-- new frame to put zone and title text in
local ald = CreateFrame ("Frame", nil, WorldMapButton)
ald:SetFrameStrata("HIGH")
ald:SetFrameLevel(0)

--for the larger map
local alds = CreateFrame ("Frame", nil, WorldMapButton)
alds:SetFrameStrata("HIGH")
alds:SetFrameLevel(0)

local SmallerMapSkin = function()
	-- don't need this
	WorldMapTrackQuest:Kill()
	
	-- map border and bg
	mapbg:SetBackdropColor(unpack(C["media"].backdropcolor))
	mapbg:SetBackdropBorderColor(unpack(C["media"].bordercolor))
	mapbg:SetScale(1 / mapscale)
	mapbg:Point("TOPLEFT", WorldMapDetailFrame, -2, 2)
	mapbg:Point("BOTTOMRIGHT", WorldMapDetailFrame, 2, -2)
	mapbg:SetFrameStrata("MEDIUM")
	mapbg:SetFrameLevel(20)
	
	-- move buttons / texts and hide default border
	WorldMapButton:SetAllPoints(WorldMapDetailFrame)
	WorldMapFrame:SetFrameStrata("MEDIUM")
	WorldMapFrame:SetClampedToScreen(true) 
	WorldMapDetailFrame:SetFrameStrata("MEDIUM")
	WorldMapTitleButton:Show()	
	WorldMapFrameMiniBorderLeft:Hide()
	WorldMapFrameMiniBorderRight:Hide()
	WorldMapFrameSizeUpButton:Show()
	WorldMapFrameSizeUpButton:ClearAllPoints()
	WorldMapFrameSizeUpButton:Point("TOPRIGHT", WorldMapButton, "TOPRIGHT", 3, -18)
	WorldMapFrameSizeUpButton:SetFrameStrata("HIGH")
	WorldMapFrameSizeUpButton:SetFrameLevel(18)
	WorldMapFrameCloseButton:ClearAllPoints()
	WorldMapFrameCloseButton:Point("TOPRIGHT", WorldMapButton, "TOPRIGHT", 3, 3)
	WorldMapFrameCloseButton:SetFrameStrata("HIGH")
	WorldMapFrameCloseButton:SetFrameLevel(18)
	WorldMapFrameSizeDownButton:Point("TOPRIGHT", WorldMapFrameMiniBorderRight, "TOPRIGHT", -66, 7)
	WorldMapFrameTitle:ClearAllPoints()
	WorldMapFrameTitle:Point("BOTTOMLEFT", WorldMapDetailFrame, 9, 10)
	WorldMapFrameTitle:SetFont(ft, fontsize, "OUTLINE")
	WorldMapFrameTitle:SetShadowOffset(T.mult, -T.mult)
	WorldMapFrameTitle:SetParent(ald)		
	WorldMapTitleButton:SetFrameStrata("MEDIUM")
	WorldMapTooltip:SetFrameStrata("TOOLTIP")

	WorldMapQuestShowObjectives:SetParent(ald)
	WorldMapQuestShowObjectives:ClearAllPoints()
	WorldMapQuestShowObjectives:Point("BOTTOMLEFT", WorldMapButton, "BOTTOMLEFT", 7, 36)
	WorldMapQuestShowObjectives:SetFrameStrata("HIGH")
	WorldMapQuestShowObjectivesText:SetFont(ft, fontsize, "THINOUTLINE")
	WorldMapQuestShowObjectivesText:SetShadowOffset(T.mult, -T.mult)
	WorldMapQuestShowObjectivesText:ClearAllPoints()
	WorldMapQuestShowObjectivesText:Point("LEFT", WorldMapQuestShowObjectives, "RIGHT", 0, 1)
	
	WorldMapShowDigSites:SetParent(ald)
	WorldMapShowDigSitesText:ClearAllPoints()
	WorldMapShowDigSitesText:Point("BOTTOMLEFT", WorldMapQuestShowObjectivesText, "TOPLEFT", 0, 2)
	WorldMapShowDigSitesText:SetFont(ft, fontsize, "THINOUTLINE")
	WorldMapShowDigSitesText:SetShadowOffset(T.mult, -T.mult)	
	WorldMapShowDigSites:ClearAllPoints()
	WorldMapShowDigSites:Point("BOTTOM", WorldMapQuestShowObjectives, "TOP", 0, 2)
	WorldMapShowDigSites:SetFrameStrata("HIGH")
	
	WorldMapFrameAreaFrame:SetFrameStrata("DIALOG")
	WorldMapFrameAreaFrame:SetFrameLevel(20)
	WorldMapFrameAreaLabel:SetFont(ft, fontsize*3, "OUTLINE")
	WorldMapFrameAreaLabel:SetShadowOffset(2, -2)
	WorldMapFrameAreaLabel:SetTextColor(0.90, 0.8294, 0.6407)
	
	-- 3.3.3, hide the dropdown added into this patch
	WorldMapLevelDropDown:SetAlpha(0)
	WorldMapLevelDropDown:SetScale(0.00001)

	-- fix tooltip not hidding after leaving quest # tracker icon
	hooksecurefunc("WorldMapQuestPOI_OnLeave", function() WorldMapTooltip:Hide() end)
end
hooksecurefunc("WorldMap_ToggleSizeDown", function() SmallerMapSkin() end)

local BiggerMapSkin = function()
	-- 3.3.3, show the dropdown added into this patch
	WorldMapLevelDropDown:SetAlpha(1)
	WorldMapLevelDropDown:SetScale(1)
	
	local fs = fontsize*0.7
	
	WorldMapQuestShowObjectives:SetParent(alds)
	WorldMapQuestShowObjectives:ClearAllPoints()
	WorldMapQuestShowObjectives:Point("BOTTOMRIGHT", WorldMapButton, "BOTTOMRIGHT", 0, -28)
	WorldMapQuestShowObjectives:SetFrameStrata("HIGH")
	WorldMapQuestShowObjectivesText:SetFont(ft, fs, "THINOUTLINE")
	WorldMapQuestShowObjectivesText:SetShadowOffset(T.mult, -T.mult)
	WorldMapQuestShowObjectivesText:ClearAllPoints()
	WorldMapQuestShowObjectivesText:Point("RIGHT", WorldMapQuestShowObjectives, "LEFT", -4, 1)
	
	WorldMapShowDigSites:SetParent(alds)
	WorldMapShowDigSitesText:ClearAllPoints()
	WorldMapShowDigSitesText:Point("RIGHT", WorldMapQuestShowObjectivesText, "LEFT", -45, 0)
	WorldMapShowDigSitesText:SetFont(ft, fs, "THINOUTLINE")
	WorldMapShowDigSitesText:SetShadowOffset(T.mult, -T.mult)	
	WorldMapShowDigSites:ClearAllPoints()
	WorldMapShowDigSites:Point("LEFT", WorldMapShowDigSitesText, "RIGHT", 2, 0)
	WorldMapShowDigSites:SetFrameStrata("HIGH")
	
	WorldMapFrameAreaFrame:SetFrameStrata("DIALOG")
	WorldMapFrameAreaFrame:SetFrameLevel(20)
	WorldMapFrameAreaLabel:SetFont(ft, fontsize*3, "OUTLINE")
	WorldMapFrameAreaLabel:SetShadowOffset(2, -2)
	WorldMapFrameAreaLabel:SetTextColor(0.90, 0.8294, 0.6407)
	
end
hooksecurefunc("WorldMap_ToggleSizeUp", function() BiggerMapSkin() end)

mapbg:SetScript("OnShow", function(self)
	local SmallerMap = GetCVarBool("miniWorldMap")
	if SmallerMap == nil then
		BiggerMapSkin()
	end
	self:SetScript("OnShow", function() end)
end)

local addon = CreateFrame('Frame')
addon:RegisterEvent('PLAYER_ENTERING_WORLD')
addon:RegisterEvent("PLAYER_REGEN_ENABLED")
addon:RegisterEvent("PLAYER_REGEN_DISABLED")
addon:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		ShowUIPanel(WorldMapFrame)
		HideUIPanel(WorldMapFrame)
	elseif event == "PLAYER_REGEN_DISABLED" then
		local miniWorldMap = GetCVarBool("miniWorldMap")
		if not miniWorldMap and WatchFrame.showObjectives then
			-- prevent a taint on fullscreen map when opening fullscreen map in combat
			WorldMapFrame_SetFullMapView()
		end

		WorldMapFrameSizeDownButton:Disable() 
		WorldMapFrameSizeUpButton:Disable()
		HideUIPanel(WorldMapFrame)
		WatchFrame.showObjectives = nil
		WorldMapQuestShowObjectives:SetChecked(false)
		WorldMapQuestShowObjectives:Hide()
		WorldMapTitleButton:Hide()
		WorldMapBlobFrame:Hide()
		WorldMapPOIFrame:Hide()

		WorldMapQuestShowObjectives.Show = T.dummy
		WorldMapTitleButton.Show = T.dummy
		WorldMapBlobFrame.Show = T.dummy
		WorldMapPOIFrame.Show = T.dummy       

		WatchFrame_Update()
	elseif event == "PLAYER_REGEN_ENABLED" then
		WorldMapFrameSizeDownButton:Enable()
		WorldMapFrameSizeUpButton:Enable()
		WorldMapQuestShowObjectives.Show = WorldMapQuestShowObjectives:Show()
		WorldMapTitleButton.Show = WorldMapTitleButton:Show()
		WorldMapBlobFrame.Show = WorldMapBlobFrame:Show()
		WorldMapPOIFrame.Show = WorldMapPOIFrame:Show()

		WorldMapQuestShowObjectives:Show()
		WorldMapTitleButton:Show()

		WatchFrame.showObjectives = true
		WorldMapQuestShowObjectives:SetChecked(true)

		WorldMapBlobFrame:Show()
		WorldMapPOIFrame:Show()

		WatchFrame_Update()
	end
end)