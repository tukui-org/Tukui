local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
--------------------------------------------------------------------
-- Tukui Minimap Script
--------------------------------------------------------------------

local TukuiMinimap = CreateFrame("Frame", "TukuiMinimap", UIParent)
TukuiMinimap:CreatePanel("Default", 1, 1, "CENTER", UIParent, "CENTER", 0, 0)
TukuiMinimap:RegisterEvent("ADDON_LOADED")
TukuiMinimap:RegisterEvent("CALENDAR_UPDATE_PENDING_INVITES")
TukuiMinimap:RegisterEvent("UPDATE_PENDING_MAIL")
TukuiMinimap:RegisterEvent("PLAYER_ENTERING_WORLD")
TukuiMinimap:Point("TOPRIGHT", UIParent, "TOPRIGHT", -24, -22)
TukuiMinimap:Size(144)
TukuiMinimap:SetClampedToScreen(true)
TukuiMinimap:SetMovable(true)
TukuiMinimap.text = T.SetFontString(TukuiMinimap, C.media.uffont, 12)
TukuiMinimap.text:SetPoint("CENTER")
TukuiMinimap.text:SetText(L.move_minimap)

-- kill the minimap cluster
MinimapCluster:Kill()

-- Parent Minimap into our Map frame.
Minimap:SetParent(TukuiMinimap)
Minimap:ClearAllPoints()
Minimap:Point("TOPLEFT", 2, -2)
Minimap:Point("BOTTOMRIGHT", -2, 2)

-- Hide Border
MinimapBorder:Hide()
MinimapBorderTop:Hide()

-- Hide Zoom Buttons
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()

-- Hide Voice Chat Frame
MiniMapVoiceChatFrame:Hide()

-- Hide North texture at top
MinimapNorthTag:SetTexture(nil)

-- Hide Zone Frame
MinimapZoneTextButton:Hide()

-- Hide Tracking Button
MiniMapTracking:Hide()

-- Hide Calendar Button
GameTimeFrame:Hide()

-- Hide Mail Button
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:Point("TOPRIGHT", Minimap, 3, 3)
MiniMapMailBorder:Hide()
MiniMapMailIcon:SetTexture("Interface\\AddOns\\Tukui\\medias\\textures\\mail")

-- Move battleground icon
MiniMapBattlefieldFrame:ClearAllPoints()
MiniMapBattlefieldFrame:Point("BOTTOMRIGHT", Minimap, 3, 0)
MiniMapBattlefieldBorder:Hide()

-- Hide world map button
MiniMapWorldMapButton:Hide()

-- shitty 3.3 flag to move
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetParent(Minimap)
MiniMapInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)

-- 4.0.6 Guild instance difficulty
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetParent(Minimap)
GuildInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)

-- Reposition lfg icon at bottom-left
local function UpdateLFG()
	MiniMapLFGFrame:ClearAllPoints()
	MiniMapLFGFrame:Point("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 2, 1)
	MiniMapLFGFrameBorder:Hide()
end
hooksecurefunc("MiniMapLFG_UpdateIsShown", UpdateLFG)

-- reskin LFG dropdown
LFDSearchStatus:SetTemplate("Default")

-- for t13+, if we move map we need to point LFDSearchStatus according to our Minimap position.
local function UpdateLFGTooltip()
	local position = TukuiMinimap:GetPoint()
	LFDSearchStatus:ClearAllPoints()
	if position:match("BOTTOMRIGHT") then
		LFDSearchStatus:SetPoint("BOTTOMRIGHT", MiniMapLFGFrame, "BOTTOMLEFT", 0, 0)
	elseif position:match("BOTTOM") then
		LFDSearchStatus:SetPoint("BOTTOMLEFT", MiniMapLFGFrame, "BOTTOMRIGHT", 4, 0)
	elseif position:match("LEFT") then		
		LFDSearchStatus:SetPoint("TOPLEFT", MiniMapLFGFrame, "TOPRIGHT", 4, 0)
	else
		LFDSearchStatus:SetPoint("TOPRIGHT", MiniMapLFGFrame, "TOPLEFT", 0, 0)	
	end
end

-- Enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)

-- Set Square Map Mask
Minimap:SetMaskTexture(C.media.blank)

-- For others mods with a minimap button, set minimap buttons position in square mode.
function GetMinimapShape() return "SQUARE" end

-- do some stuff on addon loaded or player login event
TukuiMinimap:SetScript("OnEvent", function(self, event, addon)
	if event == "PLAYER_LOGIN" then
		UpdateLFGTooltip()
	elseif addon == "Blizzard_TimeManager" then
		-- Hide Game Time
		TimeManagerClockButton:Kill()
	else
		local inv = CalendarGetNumPendingInvites()
		local mail = HasNewMail()
		if inv > 0 and mail then -- New invites and mail
			TukuiMinimap:SetBackdropBorderColor(1, .5, 0)
			if TukuiMinimapStatsLeft then
				TukuiMinimapStatsLeft:SetBackdropBorderColor(1, .5, 0)
			end
			if TukuiMinimapStatsRight then
				TukuiMinimapStatsRight:SetBackdropBorderColor(1, .5, 0)
			end
		elseif inv > 0 and not mail then -- New invites and no mail
			TukuiMinimap:SetBackdropBorderColor(1, 30/255, 60/255)
			if TukuiMinimapStatsLeft then
				TukuiMinimapStatsLeft:SetBackdropBorderColor(1, 30/255, 60/255)
			end
			if TukuiMinimapStatsRight then
				TukuiMinimapStatsRight:SetBackdropBorderColor(1, 30/255, 60/255)
			end
		elseif inv==0 and mail then -- No invites and new mail
			TukuiMinimap:SetBackdropBorderColor(0, 1, 0)
			if TukuiMinimapStatsLeft then
				TukuiMinimapStatsLeft:SetBackdropBorderColor(0, 1, 0)
			end
			if TukuiMinimapStatsRight then
				TukuiMinimapStatsRight:SetBackdropBorderColor(0, 1, 0)
			end
		else -- None of the above
			TukuiMinimap:SetBackdropBorderColor(unpack(C.media.bordercolor))
			if TukuiMinimapStatsLeft then
				TukuiMinimapStatsLeft:SetBackdropBorderColor(unpack(C.media.bordercolor))
			end
			if TukuiMinimapStatsRight then
				TukuiMinimapStatsRight:SetBackdropBorderColor(unpack(C.media.bordercolor))
			end
		end
	end
end)

----------------------------------------------------------------------------------------
-- Right click menu, used to show micro menu
----------------------------------------------------------------------------------------

local menuFrame = CreateFrame("Frame", "TukuiMinimapMiddleClickMenu", TukuiMinimap, "UIDropDownMenuTemplate")
local menuList = {
	{text = CHARACTER_BUTTON,
	func = function() ToggleCharacter("PaperDollFrame") end},
	{text = SPELLBOOK_ABILITIES_BUTTON,
	func = function() ToggleFrame(SpellBookFrame) end},
	{text = TALENTS_BUTTON,
	func = function() 
		if not PlayerTalentFrame then 
			LoadAddOn("Blizzard_TalentUI") 
		end 

		if not GlyphFrame then 
			LoadAddOn("Blizzard_GlyphUI") 
		end 
		PlayerTalentFrame_Toggle() 
	end},
	{text = ACHIEVEMENT_BUTTON,
	func = function() ToggleAchievementFrame() end},
	{text = QUESTLOG_BUTTON,
	func = function() ToggleFrame(QuestLogFrame) end},
	{text = SOCIAL_BUTTON,
	func = function() ToggleFriendsFrame(1) end},
	{text = PLAYER_V_PLAYER,
	func = function() ToggleFrame(PVPFrame) end},
	{text = ACHIEVEMENTS_GUILD_TAB,
	func = function() 
		if IsInGuild() then 
			if not GuildFrame then LoadAddOn("Blizzard_GuildUI") end 
			GuildFrame_Toggle() 
		else 
			if not LookingForGuildFrame then LoadAddOn("Blizzard_LookingForGuildUI") end 
			LookingForGuildFrame_Toggle() 
		end
	end},
	{text = LFG_TITLE,
	func = function() ToggleFrame(LFDParentFrame) end},
	{text = LOOKING_FOR_RAID,
	func = function() ToggleFrame(LFRParentFrame) end},
	{text = HELP_BUTTON,
	func = function() ToggleHelpFrame() end},
	{text = CALENDAR_VIEW_EVENT,
	func = function()
	if(not CalendarFrame) then LoadAddOn("Blizzard_Calendar") end
		Calendar_Toggle()
	end},
}

Minimap:SetScript("OnMouseUp", function(self, btn)
	local position = TukuiMinimap:GetPoint()
	if btn == "RightButton" then
		local xoff = 0
		
		if position:match("RIGHT") then xoff = T.Scale(-16) end
		ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, TukuiMinimap, xoff, T.Scale(-2))
	elseif btn == "MiddleButton" then
		if position:match("LEFT") then
			EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
		else
			EasyMenu(menuList, menuFrame, "cursor", -160, 0, "MENU", 2)
		end
	else
		Minimap_OnClick(self)
	end
end)

----------------------------------------------------------------------------------------
-- Mouseover map, displaying zone and coords
----------------------------------------------------------------------------------------

local m_zone = CreateFrame("Frame",nil,UIParent)
m_zone:CreatePanel("Default", 0, 20, "TOPLEFT", Minimap, "TOPLEFT", 2,-2)
m_zone:SetFrameLevel(5)
m_zone:SetFrameStrata("LOW")
m_zone:Point("TOPRIGHT",Minimap,-2,-2)
m_zone:SetAlpha(0)

local m_zone_text = m_zone:CreateFontString(nil,"Overlay")
m_zone_text:SetFont(C["media"].font,12)
m_zone_text:Point("TOP", 0, -1)
m_zone_text:SetPoint("BOTTOM")
m_zone_text:Height(12)
m_zone_text:Width(m_zone:GetWidth()-6)
m_zone_text:SetAlpha(0)

local m_coord = CreateFrame("Frame",nil,UIParent)
m_coord:CreatePanel("Default", 40, 20, "BOTTOMLEFT", Minimap, "BOTTOMLEFT", 2,2)
m_coord:SetFrameStrata("LOW")
m_coord:SetAlpha(0)

local m_coord_text = m_coord:CreateFontString(nil,"Overlay")
m_coord_text:SetFont(C["media"].font,12)
m_coord_text:Point("Center",-1,0)
m_coord_text:SetAlpha(0)
m_coord_text:SetText("00,00")

Minimap:SetScript("OnEnter",function()
	m_zone:SetAlpha(1)
	m_zone_text:SetAlpha(1)
	m_coord:SetAlpha(1)
	m_coord_text:SetAlpha(1)
end)

Minimap:SetScript("OnLeave",function()
	m_zone:SetAlpha(0)
	m_zone_text:SetAlpha(0)
	m_coord:SetAlpha(0)
	m_coord_text:SetAlpha(0)
end)
 
local ela = 0
local coord_Update = function(self,t)
	ela = ela - t
	if ela > 0 then return end
	local x,y = GetPlayerMapPosition("player")
	local xt,yt
	x = math.floor(100 * x)
	y = math.floor(100 * y)
	if x == 0 and y == 0 then
		m_coord_text:SetText("X _ X")
	else
		if x < 10 then
			xt = "0"..x
		else
			xt = x
		end
		if y < 10 then
			yt = "0"..y
		else
			yt = y
		end
		m_coord_text:SetText(xt..","..yt)
	end
	ela = .2
end
m_coord:SetScript("OnUpdate",coord_Update)
 
local zone_Update = function()
	local pvp = GetZonePVPInfo()
	m_zone_text:SetText(GetMinimapZoneText())
	if pvp == "friendly" then
		m_zone_text:SetTextColor(0.1, 1.0, 0.1)
	elseif pvp == "sanctuary" then
		m_zone_text:SetTextColor(0.41, 0.8, 0.94)
	elseif pvp == "arena" or pvp == "hostile" then
		m_zone_text:SetTextColor(1.0, 0.1, 0.1)
	elseif pvp == "contested" then
		m_zone_text:SetTextColor(1.0, 0.7, 0.0)
	else
		m_zone_text:SetTextColor(1.0, 1.0, 1.0)
	end
end
 
m_zone:RegisterEvent("PLAYER_ENTERING_WORLD")
m_zone:RegisterEvent("ZONE_CHANGED_NEW_AREA")
m_zone:RegisterEvent("ZONE_CHANGED")
m_zone:RegisterEvent("ZONE_CHANGED_INDOORS")
m_zone:SetScript("OnEvent",zone_Update) 
