local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
-- credits : Aezay (TipTac) and Caellian for some parts of code.

if not C["tooltip"].enable then return end

local TukuiTooltip = CreateFrame("Frame", "TukuiTooltip", UIParent)

local _G = getfenv(0)

local GameTooltip, GameTooltipStatusBar = _G["GameTooltip"], _G["GameTooltipStatusBar"]

local gsub, find, format = string.gsub, string.find, string.format

local Tooltips = {GameTooltip,ShoppingTooltip1,ShoppingTooltip2,ShoppingTooltip3,WorldMapTooltip}
local ItemRefTooltip = ItemRefTooltip

local linkTypes = {item = true, enchant = true, spell = true, quest = true, unit = true, talent = true, achievement = true, glyph = true}

local classification = {
	worldboss = "|cffAF5050Boss|r",
	rareelite = "|cffAF5050+ Rare|r",
	elite = "|cffAF5050+|r",
	rare = "|cffAF5050Rare|r",
}

local NeedBackdropBorderRefresh = true

local anchor = CreateFrame("Frame", "TukuiTooltipAnchor", UIParent)
anchor:SetSize(200, TukuiInfoRight:GetHeight())
anchor:SetFrameStrata("TOOLTIP")
anchor:SetFrameLevel(20)
anchor:SetClampedToScreen(true)
anchor:SetAlpha(0)
if C.chat.background and TukuiChatBackgroundRight then
	anchor:SetPoint("BOTTOMRIGHT", TukuiChatBackgroundRight, "TOPRIGHT", 0, -TukuiInfoRight:GetHeight())
else
	anchor:SetPoint("BOTTOMRIGHT", TukuiInfoRight)
end
anchor:SetTemplate("Default")
anchor:SetBackdropBorderColor(1, 0, 0, 1)
anchor:SetMovable(true)
anchor.text = T.SetFontString(anchor, C.media.uffont, 12)
anchor.text:SetPoint("CENTER")
anchor.text:SetText(L.move_tooltip)

-- Update Tukui Tooltip Position on some specifics Tooltip
-- Also used because on Eyefinity, SetClampedToScreen doesn't work on left and right side of screen #1
local function UpdateTooltip(self)
	local owner = self:GetOwner()
	if not owner then return end	
	local name = owner:GetName()
	
	-- fix X-offset or Y-offset
	local x = T.Scale(5)
	
	-- mouseover
	if self:GetAnchorType() == "ANCHOR_CURSOR" then
		-- h4x for world object tooltip border showing last border color 
		-- or showing background sometime ~blue :x		
		if NeedBackdropBorderRefresh then
			NeedBackdropBorderRefresh = false			
			self:SetBackdropColor(unpack(C.media.backdropcolor))
			if not C["tooltip"].cursor then
				self:SetBackdropBorderColor(unpack(C.media.bordercolor))
			end
		end
	elseif self:GetAnchorType() == "ANCHOR_NONE" and InCombatLockdown() and C["tooltip"].hidecombat == true then
		self:Hide()
	end
	
	if name and (TukuiPlayerBuffs or TukuiPlayerDebuffs) then
		if (TukuiPlayerBuffs:GetPoint():match("LEFT") or TukuiPlayerDebuffs:GetPoint():match("LEFT")) and (name:match("TukuiPlayerBuffs") or name:match("TukuiPlayerDebuffs")) then
			self:SetAnchorType("ANCHOR_BOTTOMRIGHT", x, -x)
		end
	end
		
	if (owner == MiniMapBattlefieldFrame or owner == MiniMapMailFrame) and TukuiMinimap then
		if TukuiMinimap:GetPoint():match("LEFT") then 
			self:SetAnchorType("ANCHOR_TOPRIGHT", x, -x)
		end
	end
	
	if self:GetAnchorType() == "ANCHOR_NONE" and TukuiTooltipAnchor then
		local point = TukuiTooltipAnchor:GetPoint()
		if point == "TOPLEFT" then
			self:ClearAllPoints()
			self:SetPoint("TOPLEFT", TukuiTooltipAnchor, "BOTTOMLEFT", 0, -x)			
		elseif point == "TOP" then
			self:ClearAllPoints()
			self:SetPoint("TOP", TukuiTooltipAnchor, "BOTTOM", 0, -x)			
		elseif point == "TOPRIGHT" then
			self:ClearAllPoints()
			self:SetPoint("TOPRIGHT", TukuiTooltipAnchor, "BOTTOMRIGHT", 0, -x)			
		elseif point == "BOTTOMLEFT" or point == "LEFT" then
			self:ClearAllPoints()
			self:SetPoint("BOTTOMLEFT", TukuiTooltipAnchor, "TOPLEFT", 0, x)		
		elseif point == "BOTTOMRIGHT" or point == "RIGHT" then
			if TukuiBags and TukuiBags:IsShown() then
				self:ClearAllPoints()
				self:SetPoint("BOTTOMRIGHT", TukuiBags, "TOPRIGHT", 0, x)			
			else
				self:ClearAllPoints()
				self:SetPoint("BOTTOMRIGHT", TukuiTooltipAnchor, "TOPRIGHT", 0, x)
			end
		else
			self:ClearAllPoints()
			self:SetPoint("BOTTOM", TukuiTooltipAnchor, "TOP", 0, x)		
		end
	end
end

hooksecurefunc("GameTooltip_SetDefaultAnchor", function(self, parent)
	if C["tooltip"].cursor == true then
		if IsAddOnLoaded("Tukui_Raid_Healing") and parent ~= UIParent then
			self:SetOwner(parent, "ANCHOR_NONE")
		else
			self:SetOwner(parent, "ANCHOR_CURSOR")
		end
	else
		self:SetOwner(parent, "ANCHOR_NONE")
	end
end)

GameTooltip:HookScript("OnUpdate", function(self, ...) UpdateTooltip(self) end)

local function Hex(color)
	return string.format('|cff%02x%02x%02x', color.r * 255, color.g * 255, color.b * 255)
end

local function GetColor(unit)
	if(UnitIsPlayer(unit) and not UnitHasVehicleUI(unit)) then
		local _, class = UnitClass(unit)
		local color = RAID_CLASS_COLORS[class]
		if not color then return end -- sometime unit too far away return nil for color :(
		local r,g,b = color.r, color.g, color.b
		return Hex(color), r, g, b	
	else
		local color = FACTION_BAR_COLORS[UnitReaction(unit, "player")]
		if not color then return end -- sometime unit too far away return nil for color :(
		local r,g,b = color.r, color.g, color.b		
		return Hex(color), r, g, b		
	end
end

-- function to short-display HP value on StatusBar
local function ShortValue(value)
	if value >= 1e7 then
		return ('%.1fm'):format(value / 1e6):gsub('%.?0+([km])$', '%1')
	elseif value >= 1e6 then
		return ('%.2fm'):format(value / 1e6):gsub('%.?0+([km])$', '%1')
	elseif value >= 1e5 then
		return ('%.0fk'):format(value / 1e3)
	elseif value >= 1e3 then
		return ('%.1fk'):format(value / 1e3):gsub('%.?0+([km])$', '%1')
	else
		return value
	end
end

-- update HP value on status bar
GameTooltipStatusBar:SetScript("OnValueChanged", function(self, value)
	if not value then
		return
	end
	local min, max = self:GetMinMaxValues()
	
	if (value < min) or (value > max) then
		return
	end
	local _, unit = GameTooltip:GetUnit()
	
	-- fix target of target returning nil
	if (not unit) then
		local GMF = GetMouseFocus()
		unit = GMF and GMF:GetAttribute("unit")
	end

	if not self.text then
		self.text = self:CreateFontString(nil, "OVERLAY")
		local position = TukuiTooltipAnchor:GetPoint()
		if position:match("TOP") then
			self.text:Point("CENTER", GameTooltipStatusBar, 0, -6)
		else
			self.text:Point("CENTER", GameTooltipStatusBar, 0, 6)
		end
		
		self.text:SetFont(C["media"].font, 12, "THINOUTLINE")
		self.text:Show()
		if unit then
			min, max = UnitHealth(unit), UnitHealthMax(unit)
			local hp = ShortValue(min).." / "..ShortValue(max)
			if UnitIsGhost(unit) then
				self.text:SetText(L.unitframes_ouf_ghost)
			elseif min == 0 or UnitIsDead(unit) or UnitIsGhost(unit) then
				self.text:SetText(L.unitframes_ouf_dead)
			else
				self.text:SetText(hp)
			end
		end
	else
		if unit then
			min, max = UnitHealth(unit), UnitHealthMax(unit)
			self.text:Show()
			local hp = ShortValue(min).." / "..ShortValue(max)
			if UnitIsGhost(unit) then
				self.text:SetText(L.unitframes_ouf_ghost)
			elseif min == 0 or UnitIsDead(unit) or UnitIsGhost(unit) then
				self.text:SetText(L.unitframes_ouf_dead)
			else
				self.text:SetText(hp)
			end
		else
			self.text:Hide()
		end
	end
end)

local healthBar = GameTooltipStatusBar
healthBar:ClearAllPoints()
healthBar:Height(6)
healthBar:Point("BOTTOMLEFT", healthBar:GetParent(), "TOPLEFT", 2, 5)
healthBar:Point("BOTTOMRIGHT", healthBar:GetParent(), "TOPRIGHT", -2, 5)
healthBar:SetStatusBarTexture(C.media.normTex)

local healthBarBG = CreateFrame("Frame", "StatusBarBG", healthBar)
healthBarBG:SetFrameLevel(healthBar:GetFrameLevel() - 1)
healthBarBG:Point("TOPLEFT", -2, 2)
healthBarBG:Point("BOTTOMRIGHT", 2, -2)
healthBarBG:SetTemplate("Default")

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
	local lines = self:NumLines()
	local GMF = GetMouseFocus()
	local unit = (select(2, self:GetUnit())) or (GMF and GMF:GetAttribute("unit"))
	
	-- A mage's mirror images sometimes doesn't return a unit, this would fix it
	if (not unit) and (UnitExists("mouseover")) then
		unit = "mouseover"
	end
	
	-- Sometimes when you move your mouse quicky over units in the worldframe, we can get here without a unit
	if not unit then self:Hide() return end
	
	-- for hiding tooltip on unitframes
	if (self:GetOwner() ~= UIParent and C["tooltip"].hideuf) then self:Hide() return end
	
	-- A "mouseover" unit is better to have as we can then safely say the tip should no longer show when it becomes invalid.
	if (UnitIsUnit(unit,"mouseover")) then
		unit = "mouseover"
	end

	local race = UnitRace(unit)
	local class = UnitClass(unit)
	local level = UnitLevel(unit)
	local guild = GetGuildInfo(unit)
	local name, realm = UnitName(unit)
	local crtype = UnitCreatureType(unit)
	local classif = UnitClassification(unit)
	local title = UnitPVPName(unit)
	local r, g, b = GetQuestDifficultyColor(level).r, GetQuestDifficultyColor(level).g, GetQuestDifficultyColor(level).b

	local color = GetColor(unit)	
	if not color then color = "|CFFFFFFFF" end -- just safe mode for when GetColor(unit) return nil for unit too far away

	_G["GameTooltipTextLeft1"]:SetFormattedText("%s%s%s", color, title or name, realm and realm ~= "" and " - "..realm.."|r" or "|r")

	if(UnitIsPlayer(unit)) then
		if UnitIsAFK(unit) then
			self:AppendText((" %s"):format(CHAT_FLAG_AFK))
		elseif UnitIsDND(unit) then 
			self:AppendText((" %s"):format(CHAT_FLAG_DND))
		end

		local offset = 2
		if guild then
			_G["GameTooltipTextLeft2"]:SetFormattedText("%s", IsInGuild() and GetGuildInfo("player") == guild and "|cff0090ff"..guild.."|r" or "|cff00ff10"..guild.."|r")
			offset = offset + 1
		end

		for i= offset, lines do
			if(_G["GameTooltipTextLeft"..i]:GetText():find("^"..LEVEL)) then
				_G["GameTooltipTextLeft"..i]:SetFormattedText("|cff%02x%02x%02x%s|r %s %s%s", r*255, g*255, b*255, level > 0 and level or "??", race, color, class.."|r")
				break
			end
		end
	else
		for i = 2, lines do
			if((_G["GameTooltipTextLeft"..i]:GetText():find("^"..LEVEL)) or (crtype and _G["GameTooltipTextLeft"..i]:GetText():find("^"..crtype))) then
				if level == -1 and classif == "elite" then classif = "worldboss" end
				_G["GameTooltipTextLeft"..i]:SetFormattedText("|cff%02x%02x%02x%s|r%s %s", r*255, g*255, b*255, classif ~= "worldboss" and level ~= 0 and level or "", classification[classif] or "", crtype or "")
				break
			end
		end
	end

	local pvpLine
	for i = 1, lines do
		local text = _G["GameTooltipTextLeft"..i]:GetText()
		if text and text == PVP_ENABLED then
			pvpLine = _G["GameTooltipTextLeft"..i]
			pvpLine:SetText()
			break
		end
	end

	-- ToT line
	if UnitExists(unit.."target") and unit~="player" then
		local hex, r, g, b = GetColor(unit.."target")
		if not r and not g and not b then r, g, b = 1, 1, 1 end
		GameTooltip:AddLine(UnitName(unit.."target"), r, g, b)
	end
	
	-- Sometimes this wasn't getting reset, the fact a cleanup isn't performed at this point, now that it was moved to "OnTooltipCleared" is very bad, so this is a fix
	self.fadeOut = nil
end)

local BorderColor = function(self)
	local GMF = GetMouseFocus()
	local unit = (select(2, self:GetUnit())) or (GMF and GMF:GetAttribute("unit"))
		
	local reaction = unit and UnitReaction(unit, "player")
	local player = unit and UnitIsPlayer(unit)
	local tapped = unit and UnitIsTapped(unit)
	local tappedbyme = unit and UnitIsTappedByPlayer(unit)
	local connected = unit and UnitIsConnected(unit)
	local dead = unit and UnitIsDead(unit)

	if player then
		local class = select(2, UnitClass(unit))
		local c = T.oUF_colors.class[class]
		r, g, b = c[1], c[2], c[3]
		self:SetBackdropBorderColor(r, g, b)
		healthBarBG:SetBackdropBorderColor(r, g, b)
		healthBar:SetStatusBarColor(r, g, b)
	elseif reaction then
		local c = T.oUF_colors.reaction[reaction]
		r, g, b = c[1], c[2], c[3]
		self:SetBackdropBorderColor(r, g, b)
		healthBarBG:SetBackdropBorderColor(r, g, b)
		healthBar:SetStatusBarColor(r, g, b)
	else
		local _, link = self:GetItem()
		local quality = link and select(3, GetItemInfo(link))
		if quality and quality >= 2 then
			local r, g, b = GetItemQualityColor(quality)
			self:SetBackdropBorderColor(r, g, b)
		else
			self:SetBackdropBorderColor(unpack(C["media"].bordercolor))
			healthBarBG:SetBackdropBorderColor(unpack(C["media"].bordercolor))
			healthBar:SetStatusBarColor(unpack(C["media"].bordercolor))
		end
	end
	
	-- need this
	NeedBackdropBorderRefresh = true
end

local SetStyle = function(self)
	self:SetTemplate("Default")
	BorderColor(self)
end

TukuiTooltip:RegisterEvent("PLAYER_ENTERING_WORLD")
TukuiTooltip:RegisterEvent("ADDON_LOADED")
TukuiTooltip:SetScript("OnEvent", function(self, event, addon)
	if event == "PLAYER_ENTERING_WORLD" then
		for _, tt in pairs(Tooltips) do
			tt:HookScript("OnShow", SetStyle)
		end
		
		ItemRefTooltip:HookScript("OnTooltipSetItem", SetStyle)
		ItemRefTooltip:HookScript("OnShow", SetStyle)	
		FriendsTooltip:SetTemplate("Default")
			
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		
		-- move health status bar if anchor is found at top
		local position = TukuiTooltipAnchor:GetPoint()
		if position:match("TOP") then
			healthBar:ClearAllPoints()
			healthBar:Point("TOPLEFT", healthBar:GetParent(), "BOTTOMLEFT", 2, -5)
			healthBar:Point("TOPRIGHT", healthBar:GetParent(), "BOTTOMRIGHT", -2, -5)
		end
		
		-- Hide tooltips in combat for actions, pet actions and shapeshift
		if C["tooltip"].hidebuttons == true then
			local CombatHideActionButtonsTooltip = function(self)
				if not IsShiftKeyDown() then
					self:Hide()
				end
			end
		 
			hooksecurefunc(GameTooltip, "SetAction", CombatHideActionButtonsTooltip)
			hooksecurefunc(GameTooltip, "SetPetAction", CombatHideActionButtonsTooltip)
			hooksecurefunc(GameTooltip, "SetShapeshift", CombatHideActionButtonsTooltip)
		end
	else
		if addon ~= "Blizzard_DebugTools" then return end
		
		if FrameStackTooltip then
			FrameStackTooltip:SetScale(C.general.uiscale)
			
			-- Skin it
			FrameStackTooltip:HookScript("OnShow", function(self) self:SetTemplate("Default") end)
		end
		
		if EventTraceTooltip then
			EventTraceTooltip:HookScript("OnShow", function(self) self:SetTemplate("Default") end)
		end
	end
end)