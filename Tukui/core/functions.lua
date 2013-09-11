local T, C, L, G = unpack(select(2, ...))

-- Define action bar default buttons size
T.buttonsize = T.Scale(C.actionbar.buttonsize)
T.buttonspacing = T.Scale(C.actionbar.buttonspacing)
T.petbuttonsize = T.Scale(C.actionbar.petbuttonsize)
T.petbuttonspacing = T.Scale(C.actionbar.buttonspacing)

-- return if we are currently playing on PTR.
T.IsPTRVersion = function()
	if T.toc > 50000 then
		return true
	else
		return false
	end
end

-- just for creating text
T.SetFontString = function(parent, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH("LEFT")
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(1.25, -1.25)
	return fs
end

-- datatext panel position
T.DataTextPosition = function(p, obj)
	local left = TukuiInfoLeft
	local right = TukuiInfoRight
	local mapleft = TukuiMinimapStatsLeft
	local mapright = TukuiMinimapStatsRight
	
	if p == 1 then
		obj:SetParent(left)
		obj:SetHeight(left:GetHeight())
		obj:SetPoint("LEFT", left, 30, 0)
		obj:SetPoint('TOP', left)
		obj:SetPoint('BOTTOM', left)
	elseif p == 2 then
		obj:SetParent(left)
		obj:SetHeight(left:GetHeight())
		obj:SetPoint('TOP', left)
		obj:SetPoint('BOTTOM', left)
	elseif p == 3 then
		obj:SetParent(left)
		obj:SetHeight(left:GetHeight())
		obj:SetPoint("RIGHT", left, -30, 0)
		obj:SetPoint('TOP', left)
		obj:SetPoint('BOTTOM', left)
	elseif p == 4 then
		obj:SetParent(right)
		obj:SetHeight(right:GetHeight())
		obj:SetPoint("LEFT", right, 30, 0)
		obj:SetPoint('TOP', right)
		obj:SetPoint('BOTTOM', right)
	elseif p == 5 then
		obj:SetParent(right)
		obj:SetHeight(right:GetHeight())
		obj:SetPoint('TOP', right)
		obj:SetPoint('BOTTOM', right)
	elseif p == 6 then
		obj:SetParent(right)
		obj:SetHeight(right:GetHeight())
		obj:SetPoint("RIGHT", right, -30, 0)
		obj:SetPoint('TOP', right)
		obj:SetPoint('BOTTOM', right)
	end
	
	if TukuiMinimap then
		if p == 7 then
			obj:SetParent(mapleft)
			obj:SetHeight(mapleft:GetHeight())
			obj:SetPoint('TOP', mapleft)
			obj:SetPoint('BOTTOM', mapleft)
		elseif p == 8 then
			obj:SetParent(mapright)
			obj:SetHeight(mapright:GetHeight())
			obj:SetPoint('TOP', mapright)
			obj:SetPoint('BOTTOM', mapright)
		end
	end
end

-- set the position of the datatext tooltip
T.DataTextTooltipAnchor = function(self)
	local panel = self:GetParent()
	local anchor = "ANCHOR_TOP"
	local xoff = 0
	local yoff = T.Scale(5)
	
	if panel == TukuiInfoLeft then
		anchor = "ANCHOR_TOPLEFT"
	elseif panel == TukuiInfoRight then
		anchor = "ANCHOR_TOPRIGHT"
	elseif panel == TukuiMinimapStatsLeft or panel == TukuiMinimapStatsRight then
		local position = TukuiMinimap:GetPoint()
		if position:match("LEFT") then
			anchor = "ANCHOR_BOTTOMRIGHT"
			yoff = T.Scale(-6)
			xoff = 0 - TukuiMinimapStatsRight:GetWidth()
		elseif position:match("RIGHT") then
			anchor = "ANCHOR_BOTTOMLEFT"
			yoff = T.Scale(-6)
			xoff = TukuiMinimapStatsRight:GetWidth()
		else
			anchor = "ANCHOR_BOTTOM"
			yoff = T.Scale(-6)
		end
	end
	
	return anchor, panel, xoff, yoff
end

-- used to update shift action bar buttons
T.ShiftBarUpdate = function(self)
	local numForms = GetNumShapeshiftForms()
	local texture, name, isActive, isCastable
	local button, icon, cooldown
	local start, duration, enable
	for i = 1, NUM_STANCE_SLOTS do
		buttonName = "StanceButton"..i
		button = _G[buttonName]
		icon = _G[buttonName.."Icon"]
		if i <= numForms then
			texture, name, isActive, isCastable = GetShapeshiftFormInfo(i)
			
			if not icon then return end
			
			icon:SetTexture(texture)
			
			cooldown = _G[buttonName.."Cooldown"]
			if texture then
				cooldown:SetAlpha(1)
			else
				cooldown:SetAlpha(0)
			end
			
			start, duration, enable = GetShapeshiftFormCooldown(i)
			CooldownFrame_SetTimer(cooldown, start, duration, enable)
			
			if isActive then
				StanceBarFrame.lastSelected = button:GetID()
				button:SetChecked(1)
			else
				button:SetChecked(0)
			end

			if isCastable then
				icon:SetVertexColor(1.0, 1.0, 1.0)
			else
				icon:SetVertexColor(0.4, 0.4, 0.4)
			end
		end
	end
end

-- used to update pet bar buttons
T.PetBarUpdate = function(self, event)
	local petActionButton, petActionIcon, petAutoCastableTexture, petAutoCastShine
	for i=1, NUM_PET_ACTION_SLOTS, 1 do
		local buttonName = "PetActionButton" .. i
		petActionButton = _G[buttonName]
		petActionIcon = _G[buttonName.."Icon"]
		petAutoCastableTexture = _G[buttonName.."AutoCastable"]
		petAutoCastShine = _G[buttonName.."Shine"]
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i)
		
		if not isToken then
			petActionIcon:SetTexture(texture)
			petActionButton.tooltipName = name
		else
			petActionIcon:SetTexture(_G[texture])
			petActionButton.tooltipName = _G[name]
		end
		
		petActionButton.isToken = isToken
		petActionButton.tooltipSubtext = subtext

		if isActive and name ~= "PET_ACTION_FOLLOW" then
			petActionButton:SetChecked(1)
			if IsPetAttackAction(i) then
				PetActionButton_StartFlash(petActionButton)
			end
		else
			petActionButton:SetChecked(0)
			if IsPetAttackAction(i) then
				PetActionButton_StopFlash(petActionButton)
			end			
		end
		
		if autoCastAllowed then
			petAutoCastableTexture:Show()
		else
			petAutoCastableTexture:Hide()
		end
		
		if autoCastEnabled then
			AutoCastShine_AutoCastStart(petAutoCastShine)
		else
			AutoCastShine_AutoCastStop(petAutoCastShine)
		end
		
		if texture then
			if GetPetActionSlotUsable(i) then
				SetDesaturation(petActionIcon, nil)
			else
				SetDesaturation(petActionIcon, 1)
			end
			petActionIcon:Show()
		else
			petActionIcon:Hide()
		end
		
		-- between level 1 and 10 on cata, we don't have any control on Pet. (I lol'ed so hard)
		-- Setting desaturation on button to true until you learn the control on class trainer.
		-- you can at least control "follow" button.
		if not PetHasActionBar() and texture and name ~= "PET_ACTION_FOLLOW" then
			PetActionButton_StopFlash(petActionButton)
			SetDesaturation(petActionIcon, 1)
			petActionButton:SetChecked(0)
		end
	end
end

-- remove decimal from a number
T.Round = function(number, decimals)
	if not decimals then decimals = 0 end
    return (("%%.%df"):format(decimals)):format(number)
end

-- want hex color instead of RGB?
T.RGBToHex = function(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	return string.format("|cff%02x%02x%02x", r*255, g*255, b*255)
end

-- Spawn the right-click dropdown on unitframe
local dropdown = CreateFrame("Frame", "oUF_TukuiDropDown", UIParent, "UIDropDownMenuTemplate")

T.SpawnMenu = function(self)
	dropdown:SetParent(self)
	return ToggleDropDownMenu(nil, nil, dropdown, "cursor", 0, 0)
end

local initdropdown = function(self)
	local unit = self:GetParent().unit
	local menu, name, id

	if(not unit) then
		return
	end

	if(UnitIsPlayer(unit)) then
		id = UnitInRaid(unit)
		if(id) then
			menu = "RAID_PLAYER"
			name = GetRaidRosterInfo(id)
		elseif(UnitInParty(unit)) then
			menu = "PARTY"
		end
	end

	if(menu) then
		UnitPopup_ShowMenu(self, menu, unit, name, id)
	end
end

UIDropDownMenu_Initialize(dropdown, initdropdown, "MENU")

UnitPopupMenus["PARTY"] = { "ADD_FRIEND", "ADD_FRIEND_MENU", "MUTE", "UNMUTE", "PARTY_SILENCE", "PARTY_UNSILENCE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "PROMOTE", "PROMOTE_GUIDE", "LOOT_PROMOTE", "VOTE_TO_KICK", "UNINVITE", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "PET_BATTLE_PVP_DUEL", "RAID_TARGET_ICON", "SELECT_ROLE", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "REPORT_PLAYER", "CANCEL" };
UnitPopupMenus["RAID_PLAYER"] = { "ADD_FRIEND", "ADD_FRIEND_MENU", "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "PET_BATTLE_PVP_DUEL", "RAID_TARGET_ICON", "SELECT_ROLE", "RAID_LEADER", "RAID_PROMOTE", "RAID_DEMOTE", "LOOT_PROMOTE", "VOTE_TO_KICK", "RAID_REMOVE", "RAF_SUMMON", "RAF_GRANT_LEVEL", "REPORT_PLAYER", "CANCEL" };
UnitPopupMenus["RAID"] = { "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "RAID_LEADER", "RAID_PROMOTE", "RAID_MAINTANK", "RAID_MAINASSIST", "LOOT_PROMOTE", "RAID_DEMOTE", "VOTE_TO_KICK", "RAID_REMOVE", "MOVE_PLAYER_FRAME", "MOVE_TARGET_FRAME", "REPORT_PLAYER", "CANCEL" };

--Return short value of a number
T.ShortValue = function(v)
	if v >= 1e6 then
		return ("%.1fm"):format(v / 1e6):gsub("%.?0+([km])$", "%1")
	elseif v >= 1e3 or v <= -1e3 then
		return ("%.1fk"):format(v / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return v
	end
end

-- used to return role
T.CheckRole = function()
	local role = ""
	local tree = GetSpecialization()
	
	if tree then
		role = select(6, GetSpecializationInfo(tree))
	end

	return role
end

--Add time before calling a function
--Usage T.Delay(seconds, functionToCall, ...)
local waitTable = {}
local waitFrame
T.Delay = function(delay, func, ...)
	if(type(delay)~="number" or type(func)~="function") then
		return false
	end
	if(waitFrame == nil) then
		waitFrame = CreateFrame("Frame","WaitFrame", UIParent)
		waitFrame:SetScript("onUpdate",function (self,elapse)
			local count = #waitTable
			local i = 1
			while(i<=count) do
				local waitRecord = tremove(waitTable,i)
				local d = tremove(waitRecord,1)
				local f = tremove(waitRecord,1)
				local p = tremove(waitRecord,1)
				if(d>elapse) then
				  tinsert(waitTable,i,{d-elapse,f,p})
				  i = i + 1
				else
				  count = count - 1
				  f(unpack(p))
				end
			end
		end)
	end
	tinsert(waitTable,{delay,func,{...}})
	return true
end

------------------------------------------------------------------------
-- Skinning
------------------------------------------------------------------------

T.SkinFuncs = {}
T.SkinFuncs["Tukui"] = {}

local LoadBlizzardSkin = CreateFrame("Frame")
LoadBlizzardSkin:RegisterEvent("ADDON_LOADED")
LoadBlizzardSkin:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") or not C.general.blizzardreskin then
		self:UnregisterEvent("ADDON_LOADED")
		return 
	end
	
	for _addon, skinfunc in pairs(T.SkinFuncs) do
		if type(skinfunc) == "function" then
			if _addon == addon then
				if skinfunc then
					skinfunc()
				end
			end
		elseif type(skinfunc) == "table" then
			if _addon == addon then
				for _, skinfunc in pairs(T.SkinFuncs[_addon]) do
					if skinfunc then
						skinfunc()
					end
				end
			end
		end
	end
end)

------------------------------------------------------------------------
--	unitframes Functions
------------------------------------------------------------------------

-- tell oUF Framework that we use our own oUF version (ns.oUF, also know as X-oUF in /Tukui/Tukui.toc)
local ADDON_NAME, ns = ...
local oUF = ns.oUF
oUFTukui = ns.oUF -- MOP BETA
assert(oUF, "Tukui was unable to locate oUF install.")

-- a function to update all unit frames
T.updateAllElements = function(frame)
	for _, v in ipairs(frame.__elements) do
		v(frame, "UpdateElement", frame.unit)
	end
end

-- Create an animation (like seen on text unitframe when low mana)
local SetUpAnimGroup = function(self)
	self.anim = self:CreateAnimationGroup("Flash")
	self.anim.fadein = self.anim:CreateAnimation("ALPHA", "FadeIn")
	self.anim.fadein:SetChange(1)
	self.anim.fadein:SetOrder(2)

	self.anim.fadeout = self.anim:CreateAnimation("ALPHA", "FadeOut")
	self.anim.fadeout:SetChange(-1)
	self.anim.fadeout:SetOrder(1)
end

-- Start the flash anim
local Flash = function(self, duration)
	if not self.anim then
		SetUpAnimGroup(self)
	end

	self.anim.fadein:SetDuration(duration)
	self.anim.fadeout:SetDuration(duration)
	self.anim:Play()
end

-- Stop the flash anim
local StopFlash = function(self)
	if self.anim then
		self.anim:Finish()
	end
end

-- called in some function to return a short value. (example: 120 000 return 120k)
local ShortValue = function(v)
	if v <= 999 then return v end
	if v >= 1000000 then
		local value = string.format("%.1fm", v/1000000)
		return value
	elseif v >= 1000 then
		local value = string.format("%.1fk", v/1000)
		return value
	end
end

-- function to update health text
T.PostUpdateHealth = function(health, unit, min, max)
	if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
		if not UnitIsConnected(unit) then
			health.value:SetText("|cffD7BEA5"..L.unitframes_ouf_offline.."|r")
		elseif UnitIsDead(unit) then
			health.value:SetText("|cffD7BEA5"..L.unitframes_ouf_dead.."|r")
		elseif UnitIsGhost(unit) then
			health.value:SetText("|cffD7BEA5"..L.unitframes_ouf_ghost.."|r")
		end
	else
		local r, g, b
		
		-- overwrite healthbar color for enemy player (a tukui option if enabled), target vehicle/pet too far away returning unitreaction nil and friend unit not a player. (mostly for overwrite tapped for friendly)
		-- I don't know if we really need to call C["unitframes"].unicolor but anyway, it's safe this way.
		if (C["unitframes"].unicolor ~= true and C["unitframes"].enemyhcolor and unit == "target" and UnitIsEnemy(unit, "player") and UnitIsPlayer(unit)) or (C["unitframes"].unicolor ~= true and unit == "target" and not UnitIsPlayer(unit) and UnitIsFriend(unit, "player")) then
			local c = T.UnitColor.reaction[UnitReaction(unit, "player")]
			if c then 
				r, g, b = c[1], c[2], c[3]
				health:SetStatusBarColor(r, g, b)
			else
				-- if "c" return nil it's because it's a vehicle or pet unit too far away, we force friendly color
				-- this should fix color not updating for vehicle/pet too far away from yourself.
				r, g, b = 75/255,  175/255, 76/255
				health:SetStatusBarColor(r, g, b)
			end					
		end

		if min ~= max then
			local r, g, b
			r, g, b = oUF.ColorGradient(min, max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
			if unit == "player" and health:GetAttribute("normalUnit") ~= "pet" then
				if C["unitframes"].showtotalhpmp == true then
					health.value:SetFormattedText("|cff559655%s|r |cffD7BEA5|||r |cff559655%s|r", ShortValue(min), ShortValue(max))
				else
					health.value:SetFormattedText("|cffAF5050%d|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", min, r * 255, g * 255, b * 255, floor(min / max * 100))
				end
			elseif unit == "target" or (unit and unit:find("boss%d")) then
				if C["unitframes"].showtotalhpmp == true then
					health.value:SetFormattedText("|cff559655%s|r |cffD7BEA5|||r |cff559655%s|r", ShortValue(min), ShortValue(max))
				else
					health.value:SetFormattedText("|cffAF5050%s|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", ShortValue(min), r * 255, g * 255, b * 255, floor(min / max * 100))
				end
			elseif (unit and unit:find("arena%d")) or unit == "focus" or unit == "focustarget" then
				health.value:SetText("|cff559655"..ShortValue(min).."|r")
			else
				health.value:SetText("|cff559655-"..ShortValue(max-min).."|r")
			end
		else
			if unit == "player" and health:GetAttribute("normalUnit") ~= "pet" then
				health.value:SetText("|cff559655"..max.."|r")
			elseif unit == "target" or unit == "focus"  or unit == "focustarget" or (unit and unit:find("arena%d")) then
				health.value:SetText("|cff559655"..ShortValue(max).."|r")
			else
				health.value:SetText(" ")
			end
		end
	end
end

-- function to update health text for party/raid
T.PostUpdateHealthRaid = function(health, unit, min, max)
	if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
		if not UnitIsConnected(unit) then
			health.value:SetText("|cffD7BEA5"..L.unitframes_ouf_offline.."|r")
		elseif UnitIsDead(unit) then
			health.value:SetText("|cffD7BEA5"..L.unitframes_ouf_dead.."|r")
		elseif UnitIsGhost(unit) then
			health.value:SetText("|cffD7BEA5"..L.unitframes_ouf_ghost.."|r")
		end
	else
		-- doing this here to force friendly unit (vehicle or pet) very far away from you to update color correcly
		-- because if vehicle or pet is too far away, unitreaction return nil and color of health bar is white.
		if not UnitIsPlayer(unit) and UnitIsFriend(unit, "player") and C["unitframes"].unicolor ~= true then
			local c = T.UnitColor.reaction[5]
			local r, g, b = c[1], c[2], c[3]
			health:SetStatusBarColor(r, g, b)
			health.bg:SetTexture(.1, .1, .1)
		end
		
		if min ~= max then
			health.value:SetText("|cff559655-"..ShortValue(max-min).."|r")
		else
			health.value:SetText(" ")
		end
	end
end

-- function to make sure pet unit health is always colored.
T.PostUpdatePetColor = function(health, unit, min, max)
	-- doing this here to force friendly unit (vehicle or pet) very far away from you to update color correcly
	-- because if vehicle or pet is too far away, unitreaction return nil and color of health bar is white.
	if not UnitIsPlayer(unit) and UnitIsFriend(unit, "player") and C["unitframes"].unicolor ~= true then
		local c = T.UnitColor.reaction[5]
		local r, g, b = c[1], c[2], c[3]

		if health then health:SetStatusBarColor(r, g, b) end
		if health.bg then health.bg:SetTexture(.1, .1, .1) end
	end
end

-- a function to move name of current target unit if enemy or friendly
T.PostNamePosition = function(self)
	self.Name:ClearAllPoints()
	if (self.Power.value:GetText() and UnitIsEnemy("player", "target") and C["unitframes"].targetpowerpvponly == true) or (self.Power.value:GetText() and C["unitframes"].targetpowerpvponly == false) then
		self.Name:SetPoint("CENTER", self.panel, "CENTER", 0, 0)
	else
		self.Power.value:SetAlpha(0)
		self.Name:SetPoint("LEFT", self.panel, "LEFT", 4, 0)
	end
end

-- color the power bar according to class / vehicle / etc.
T.PreUpdatePower = function(power, unit)
	local pType = select(2, UnitPowerType(unit))
	
	local color = T.UnitColor.power[pType]
	if color then
		power:SetStatusBarColor(color[1], color[2], color[3])
	end
end

-- function to update power text on unit frames
T.PostUpdatePower = function(power, unit, min, max)
	local self = power:GetParent()
	local pType, pToken = UnitPowerType(unit)
	local color = T.UnitColor.power[pToken]

	if color then
		power.value:SetTextColor(color[1], color[2], color[3])
	end

	if not UnitIsPlayer(unit) and not UnitPlayerControlled(unit) or not UnitIsConnected(unit) then
		power.value:SetText()
	elseif UnitIsDead(unit) or UnitIsGhost(unit) then
		power.value:SetText()
	else
		if min ~= max then
			if pType == 0 then
				if unit == "target" then
					if C["unitframes"].showtotalhpmp == true then
						power.value:SetFormattedText("%s |cffD7BEA5|||r %s", ShortValue(max - (max - min)), ShortValue(max))
					else
						power.value:SetFormattedText("%d%% |cffD7BEA5-|r %s", floor(min / max * 100), ShortValue(max - (max - min)))
					end
				elseif unit == "player" and self:GetAttribute("normalUnit") == "pet" or unit == "pet" then
					if C["unitframes"].showtotalhpmp == true then
						power.value:SetFormattedText("%s |cffD7BEA5|||r %s", ShortValue(max - (max - min)), ShortValue(max))
					else
						power.value:SetFormattedText("%d%%", floor(min / max * 100))
					end
				elseif (unit and unit:find("arena%d")) or unit == "focus" or unit == "focustarget" then
					power.value:SetText(ShortValue(min))
				else
					if C["unitframes"].showtotalhpmp == true then
						power.value:SetFormattedText("%s |cffD7BEA5|||r %s", ShortValue(max - (max - min)), ShortValue(max))
					else
						power.value:SetFormattedText("%d%% |cffD7BEA5-|r %d", floor(min / max * 100), max - (max - min))
					end
				end
			else
				power.value:SetText(max - (max - min))
			end
		else
			if unit == "pet" or unit == "target" or unit == "focus" or unit == "focustarget" or (unit and unit:find("arena%d")) then
				power.value:SetText(ShortValue(min))
			else
				power.value:SetText(min)
			end
		end
	end
	if self.Name then
		if unit == "target" then T.PostNamePosition(self, power) end
	end
end

-- display casting time
T.CustomCastTimeText = function(self, duration)
	self.Time:SetText(("%.1f / %.1f"):format(self.channeling and duration or self.max - duration, self.max))
end

-- display delay in casting time
T.CustomCastDelayText = function(self, duration)
	self.Time:SetText(("%.1f |cffaf5050%s %.1f|r"):format(self.channeling and duration or self.max - duration, self.channeling and "- " or "+", self.delay))
end

-- display seconds to min/hour/day
T.FormatTime = function(s)
	local day, hour, minute = 86400, 3600, 60
	if s >= day then
		return format("%dd", ceil(s / day))
	elseif s >= hour then
		return format("%dh", ceil(s / hour))
	elseif s >= minute then
		return format("%dm", ceil(s / minute))
	elseif s >= minute / 12 then
		return floor(s)
	end
	return format("%.1f", s)
end

-- create a timer on a buff or debuff
local CreateAuraTimer = function(self, elapsed)
	if self.timeLeft then
		self.elapsed = (self.elapsed or 0) + elapsed
		if self.elapsed >= 0.1 then
			if not self.first then
				self.timeLeft = self.timeLeft - self.elapsed
			else
				self.timeLeft = self.timeLeft - GetTime()
				self.first = false
			end
			if self.timeLeft > 0 then
				local time = T.FormatTime(self.timeLeft)
				self.remaining:SetText(time)
				if self.timeLeft <= 5 then
					self.remaining:SetTextColor(0.99, 0.31, 0.31)
				else
					self.remaining:SetTextColor(1, 1, 1)
				end
			else
				self.remaining:Hide()
				self:SetScript("OnUpdate", nil)
			end
			self.elapsed = 0
		end
	end
end

-- create a skin for all unitframes buffs/debuffs
T.PostCreateAura = function(self, button)
	button:SetTemplate("Default")
	
	button.remaining = T.SetFontString(button, C["media"].font, C["unitframes"].auratextscale, "THINOUTLINE")
	button.remaining:Point("CENTER", 1, 0)
	
	button.cd.noOCC = true -- hide OmniCC CDs, because we  create our own cd with CreateAuraTimer()
	button.cd.noCooldownCount = true -- hide CDC CDs, because we create our own cd with CreateAuraTimer()
	
	button.cd:SetReverse()
	button.icon:Point("TOPLEFT", 2, -2)
	button.icon:Point("BOTTOMRIGHT", -2, 2)
	button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	button.icon:SetDrawLayer('ARTWORK')
	
	button.count:Point("BOTTOMRIGHT", 3, 3)
	button.count:SetJustifyH("RIGHT")
	button.count:SetFont(C["media"].font, 9, "THICKOUTLINE")
	button.count:SetTextColor(0.84, 0.75, 0.65)
	
	button.overlayFrame = CreateFrame("frame", nil, button, nil)
	button.cd:SetFrameLevel(button:GetFrameLevel() + 1)
	button.cd:ClearAllPoints()
	button.cd:Point("TOPLEFT", button, "TOPLEFT", 2, -2)
	button.cd:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
	button.overlayFrame:SetFrameLevel(button.cd:GetFrameLevel() + 1)	   
	button.overlay:SetParent(button.overlayFrame)
	button.count:SetParent(button.overlayFrame)
	button.remaining:SetParent(button.overlayFrame)
			
	button.Glow = CreateFrame("Frame", nil, button)
	button.Glow:Point("TOPLEFT", button, "TOPLEFT", -3, 3)
	button.Glow:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", 3, -3)
	button.Glow:SetFrameStrata("BACKGROUND")	
	button.Glow:SetBackdrop{edgeFile = C["media"].glowTex, edgeSize = 3, insets = {left = 0, right = 0, top = 0, bottom = 0}}
	button.Glow:SetBackdropColor(0, 0, 0, 0)
	button.Glow:SetBackdropBorderColor(0, 0, 0)
	
	local Animation = button:CreateAnimationGroup()
	Animation:SetLooping("BOUNCE")

	local FadeOut = Animation:CreateAnimation("Alpha")
	FadeOut:SetChange(-.9)
	FadeOut:SetDuration(.6)
	FadeOut:SetSmoothing("IN_OUT")

	button.Animation = Animation
end

-- update cd, border color, etc on buffs / debuffs
T.PostUpdateAura = function(self, unit, icon, index, offset, filter, isDebuff, duration, timeLeft)
	local _, _, _, _, dtype, duration, expirationTime, unitCaster, isStealable = UnitAura(unit, index, icon.filter)
	if icon then
		if(icon.filter == "HARMFUL") then
			if(not UnitIsFriend("player", unit) and icon.owner ~= "player" and icon.owner ~= "vehicle") then
				icon.icon:SetDesaturated(true)
				icon:SetBackdropBorderColor(unpack(C.media.bordercolor))
			else
				local color = DebuffTypeColor[dtype] or DebuffTypeColor.none
				icon.icon:SetDesaturated(false)
				icon:SetBackdropBorderColor(color.r * 0.8, color.g * 0.8, color.b * 0.8)
			end
		else
			if (isStealable or ((T.myclass == "MAGE" or T.myclass == "PRIEST" or T.myclass == "SHAMAN") and dtype == "Magic")) and not UnitIsFriend("player", unit) then
				if not icon.Animation:IsPlaying() then
					icon.Animation:Play()
				end
			else
				if icon.Animation:IsPlaying() then
					icon.Animation:Stop()
				end
			end
		end
		
		if duration and duration > 0 then
			if C["unitframes"].auratimer == true then
				icon.remaining:Show()
			else
				icon.remaining:Hide()
			end
		else
			icon.remaining:Hide()
		end
	 
		icon.duration = duration
		icon.timeLeft = expirationTime
		icon.first = true
		icon:SetScript("OnUpdate", CreateAuraTimer)
	end
end

T.UpdateTargetDebuffsHeader = function(self)
	local numBuffs = self.visibleBuffs
	local perRow = self.numRow
	local s = self.size
	local row = math.ceil((numBuffs / perRow))
	local p = self:GetParent()
	local h = p.Debuffs
	local y = s * row
	local addition = s
	
	if numBuffs == 0 then addition = 0 end
	h:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", (T.lowversion and 0) or -2, y + addition)
end

-- hide the portrait if out of range, not connected, etc
T.HidePortrait = function(self, unit)
	if self.unit == "target" then
		if not UnitExists(self.unit) or not UnitIsConnected(self.unit) or not UnitIsVisible(self.unit) then
			self.Portrait:SetAlpha(0)
		else
			self.Portrait:SetAlpha(1)
		end
	end
	-- weird bug, need to set level everytime to fix a portrait issue on dx9. :X
	self.Portrait:SetFrameLevel(4)
end

-- This is mostly just a fix for worgen male portrait because of a bug found in default Blizzard UI.
T.PortraitUpdate = function(self, unit)
	--Fucking Furries
	if self:GetModel() and self:GetModel().find and self:GetModel():find("worgenmale") then
		self:SetCamera(1)
	end
end

-- used to check if a spell is interruptable
local CheckInterrupt = function(self, unit)
	if unit == "vehicle" then unit = "player" end

	if self.interrupt and UnitCanAttack("player", unit) then
		self:SetStatusBarColor(1, 0, 0, 0.5)	
	else
		self:SetStatusBarColor(0.31, 0.45, 0.63, 0.5)		
	end
end

-- check if we can interrupt on cast
T.CheckCast = function(self, unit, name, rank, castid)
	CheckInterrupt(self, unit)
end

-- check if we can interrupt on channel cast
T.CheckChannel = function(self, unit, name, rank)
	CheckInterrupt(self, unit)
end

-- update the warlock shard
T.UpdateShards = function(self, event, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= 'SOUL_SHARDS')) then return end
	local num = UnitPower(unit, SPELL_POWER_SOUL_SHARDS)
	for i = 1, SHARD_BAR_NUM_SHARDS do
		if(i <= num) then
			self.SoulShards[i]:SetAlpha(1)
		else
			self.SoulShards[i]:SetAlpha(.2)
		end
	end
end

-- phasing detection on party/raid
T.Phasing = function(self, event)
	local inPhase = UnitInPhase(self.unit)
	local picon = self.PhaseIcon

	if not UnitIsPlayer(self.unit) then picon:Hide() return end

	-- TO BE COMPLETED
end

-- druid eclipse bar direction :P
T.EclipseDirection = function(self)
	if ( GetEclipseDirection() == "sun" ) then
			self.Text:SetText("|cffE5994C"..L.unitframes_ouf_starfirespell.."|r")
	elseif ( GetEclipseDirection() == "moon" ) then
			self.Text:SetText("|cff4478BC"..L.unitframes_ouf_wrathspell.."|r")
	else
			self.Text:SetText("")
	end
end

-- update some elements
T.ComboPointsBarUpdate = function(self, parent, points)
	local s = parent.shadow
	local b = parent.Buffs
		
	if T.myclass == "ROGUE" and C.unitframes.movecombobar then
		-- always show we this option enabled
		s:Point("TOPLEFT", -4, 12)
		self:Show()
	else
		if points > 0 then
			if s then
				s:Point("TOPLEFT", -4, 12)
			end
			if b then 
				b:ClearAllPoints() 
				b:SetPoint("BOTTOMLEFT", parent, "TOPLEFT", 0, 14)
			end
		else
			if s then
				s:Point("TOPLEFT", -4, 4)
			end
			if b then 
				b:ClearAllPoints() 
				b:SetPoint("BOTTOMLEFT", parent, "TOPLEFT", 0, 4)
			end
		end
	end
end

-- show the druid bar mana or eclipse if form is moonkin/cat/bear.
T.DruidBarDisplay = function(self, login)
	local eb = self.EclipseBar
	local m = self.WildMushroom
	local dm = self.DruidMana
	local shadow = self.shadow
	local bg = self.DruidManaBackground
	local flash = self.FlashInfo

	if login then
		dm:SetScript("OnUpdate", nil)
	end
	
	if dm and dm:IsShown() then
		shadow:Point("TOPLEFT", -4, 12)
		bg:SetAlpha(1)
	else
		flash:Show()
		shadow:Point("TOPLEFT", -4, 4)
		if bg then bg:SetAlpha(0) end
	end
		
	if (eb and eb:IsShown()) or (dm and dm:IsShown()) then
		if eb and eb:IsShown() then
			local txt = self.EclipseBar.Text
			txt:Show()
			flash:Hide()
		end
		shadow:Point("TOPLEFT", -4, 12)
		if bg then bg:SetAlpha(1) end
		
		-- mushroom
		if m and m:IsShown() then
			shadow:Point("TOPLEFT", -4, 21)
			m:ClearAllPoints()
			m:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 10)
		end
	else
		if eb then
			local txt = self.EclipseBar.Text
			txt:Hide()
		end
		flash:Show()
		shadow:Point("TOPLEFT", -4, 4)
		if bg then bg:SetAlpha(0) end
		
		-- mushroom
		if m and m:IsShown() then
			shadow:Point("TOPLEFT", -4, 12)
			m:ClearAllPoints()
			m:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
		end
	end
end

T.UpdateMageClassBarVisibility = function(self)
	local p = self:GetParent()
	local a = p.ArcaneChargeBar
	local r = p.RunePower
	local shadow = p.shadow
	
	if (a and a:IsShown()) and (r and r:IsShown()) then
		shadow:Point("TOPLEFT", -4, 21)
		r:ClearAllPoints()
		r:Point("BOTTOMLEFT", p, "TOPLEFT", 0, 10)		
	elseif (a and a:IsShown()) or (r and r:IsShown()) then
		shadow:Point("TOPLEFT", -4, 12)
		r:ClearAllPoints()
		r:Point("BOTTOMLEFT", p, "TOPLEFT", 0, 1)
	else
		shadow:Point("TOPLEFT", -4, 4)
	end
end

T.UpdateMushroomVisibility = function(self)
	local p = self:GetParent()
	local eb = p.EclipseBar
	local dm = p.DruidMana
	local m = p.WildMushroom
	local shadow = p.shadow
	
	if (eb and eb:IsShown()) or (dm and dm:IsShown()) then
		shadow:Point("TOPLEFT", -4, 21)
		m:ClearAllPoints()
		m:Point("BOTTOMLEFT", p, "TOPLEFT", 0, 10)
	elseif m:IsShown() then
		shadow:Point("TOPLEFT", -4, 12)
		m:ClearAllPoints()
		m:Point("BOTTOMLEFT", p, "TOPLEFT", 0, 1)
	else
		shadow:Point("TOPLEFT", -4, 4)
	end
end

-- master looter icon
T.MLAnchorUpdate = function (self)
	if self.Leader:IsShown() then
		self.MasterLooter:SetPoint("TOPLEFT", 14, 8)
	else
		self.MasterLooter:SetPoint("TOPLEFT", 2, 8)
	end
end

-- update repuration bar color
T.UpdateReputationColor = function(self, event, unit, bar)
	local name, id = GetWatchedFactionInfo()
	bar:SetStatusBarColor(FACTION_BAR_COLORS[id].r, FACTION_BAR_COLORS[id].g, FACTION_BAR_COLORS[id].b)
end

-- when called, it update the name of unit
T.UpdateName = function(self,event)
	if self.Name then self.Name:UpdateTag(self.unit) end
end

-- display warning when low mana
local UpdateManaLevelDelay = 0
T.UpdateManaLevel = function(self, elapsed)
	UpdateManaLevelDelay = UpdateManaLevelDelay + elapsed
	if self.parent.unit ~= "player" or UpdateManaLevelDelay < 0.2 or UnitIsDeadOrGhost("player") or UnitPowerType("player") ~= 0 then return end
	UpdateManaLevelDelay = 0
	local mana = UnitMana("player")
	local maxmana = UnitManaMax("player")
	
	if maxmana == 0 then return end
	
	local percMana = mana / maxmana * 100

	if percMana <= C.unitframes.lowThreshold then
		self.ManaLevel:SetText("|cffaf5050"..L.unitframes_ouf_lowmana.."|r")
		Flash(self, 0.3)
	else
		self.ManaLevel:SetText()
		StopFlash(self)
	end
end

-- show or hide druid mana text if cat/bear form or not.
T.UpdateDruidManaText = function(self)
	if self.unit ~= "player" then return end

	local num, str = UnitPowerType("player")
	if num ~= 0 then
		local min = UnitPower("player", 0)
		local max = UnitPowerMax("player", 0)

		local percMana = min / max * 100
		if percMana <= C["unitframes"].lowThreshold then
			self.FlashInfo.ManaLevel:SetText("|cffaf5050"..L.unitframes_ouf_lowmana.."|r")
			Flash(self.FlashInfo, 0.3)
		else
			self.FlashInfo.ManaLevel:SetText()
			StopFlash(self.FlashInfo)
		end

		if min ~= max then
			if self.Power.value:GetText() then
				self.DruidManaText:SetPoint("LEFT", self.Power.value, "RIGHT", 1, 0)
				self.DruidManaText:SetFormattedText("|cffD7BEA5-|r  |cff4693FF%d%%|r|r", floor(min / max * 100))
			else
				self.DruidManaText:SetPoint("LEFT", self.panel, "LEFT", 4, 1)
				self.DruidManaText:SetFormattedText("%d%%", floor(min / max * 100))
			end
		else
			self.DruidManaText:SetText()
		end

		self.DruidManaText:SetAlpha(1)
	else
		self.DruidManaText:SetAlpha(0)
	end
end

-- red color the border of text panel or name on unitframes if unit have aggro
T.UpdateThreat = function(self, event, unit)
	if (self.unit ~= unit) or (unit == "target" or unit == "pet" or unit == "focus" or unit == "focustarget" or unit == "targettarget") then return end
	local threat = UnitThreatSituation(self.unit)
	if (threat == 3) then
		if self.panel then
			self.panel:SetBackdropBorderColor(.69,.31,.31,1)
		else
			self.Name:SetTextColor(1,0.1,0.1)
		end
	else
		if self.panel then
			local r, g, b = unpack(C["media"].bordercolor)
			self.panel:SetBackdropBorderColor(r * 0.7, g * 0.7, b * 0.7)
		else
			self.Name:SetTextColor(1,1,1)
		end
	end 
end

T.SetGridGroupRole = function(self, role)
	local lfdrole = self.LFDRole
	
	local role = UnitGroupRolesAssigned(self.unit)
	
	if role == "TANK" then
		lfdrole:SetTexture(67/255, 110/255, 238/255,.3)
		lfdrole:Show()
	elseif role == "HEALER" then
		lfdrole:SetTexture(130/255,  255/255, 130/255, .15)
		lfdrole:Show()
	elseif role == "DAMAGER" then
		lfdrole:SetTexture(176/255, 23/255, 31/255, .27)
		lfdrole:Show()
	else
		lfdrole:Hide()
	end
end

T.UpdateBossAltPower = function(self, minimum, current, maximum)
	if (not current) or (not maximum) then return end
	
	local r, g, b = oUFTukui.ColorGradient(current, maximum, 0, .8 ,0 ,.8 ,.8 ,0 ,.8 ,0 ,0)
	self:SetStatusBarColor(r, g, b)
end

--------------------------------------------------------------------------------------------
-- Grid theme indicator section
--------------------------------------------------------------------------------------------

-- position of indicators
T.countOffsets = {
	TOPLEFT = {6*C["unitframes"].gridscale, 1},
	TOPRIGHT = {-6*C["unitframes"].gridscale, 1},
	BOTTOMLEFT = {6*C["unitframes"].gridscale, 1},
	BOTTOMRIGHT = {-6*C["unitframes"].gridscale, 1},
	LEFT = {6*C["unitframes"].gridscale, 1},
	RIGHT = {-6*C["unitframes"].gridscale, 1},
	TOP = {0, 0},
	BOTTOM = {0, 0},
}

-- skin the icon
T.CreateAuraWatchIcon = function(self, icon)
	icon:SetTemplate("Default")
	icon.icon:Point("TOPLEFT", 1, -1)
	icon.icon:Point("BOTTOMRIGHT", -1, 1)
	icon.icon:SetTexCoord(.08, .92, .08, .92)
	icon.icon:SetDrawLayer("ARTWORK")
	if (icon.cd) then
		icon.cd:SetReverse()
	end
	icon.overlay:SetTexture()
end

-- create the icon
T.createAuraWatch = function(self, unit)
	local auras = CreateFrame("Frame", nil, self)
	auras:SetPoint("TOPLEFT", self.Health, 2, -2)
	auras:SetPoint("BOTTOMRIGHT", self.Health, -2, 2)
	auras.presentAlpha = 1
	auras.missingAlpha = 0
	auras.icons = {}
	auras.PostCreateIcon = T.CreateAuraWatchIcon

	if (not C["unitframes"].auratimer) then
		auras.hideCooldown = true
	end

	local buffs = {}

	if (T.buffids["ALL"]) then
		for key, value in pairs(T.buffids["ALL"]) do
			tinsert(buffs, value)
		end
	end

	if (T.buffids[T.myclass]) then
		for key, value in pairs(T.buffids[T.myclass]) do
			tinsert(buffs, value)
		end
	end

	-- "Cornerbuffs"
	if (buffs) then
		for key, spell in pairs(buffs) do
			local icon = CreateFrame("Frame", nil, auras)
			icon.spellID = spell[1]
			icon.anyUnit = spell[4]
			icon:Width(6*C["unitframes"].gridscale)
			icon:Height(6*C["unitframes"].gridscale)
			icon:SetPoint(spell[2], 0, 0)

			local tex = icon:CreateTexture(nil, "OVERLAY")
			tex:SetAllPoints(icon)
			tex:SetTexture(C.media.blank)
			if (spell[3]) then
				tex:SetVertexColor(unpack(spell[3]))
			else
				tex:SetVertexColor(0.8, 0.8, 0.8)
			end

			local count = icon:CreateFontString(nil, "OVERLAY")
			count:SetFont(C["media"].uffont, 8*C["unitframes"].gridscale, "THINOUTLINE")
			count:SetPoint("CENTER", unpack(T.countOffsets[spell[2]]))
			icon.count = count

			auras.icons[spell[1]] = icon
		end
	end
	
	self.AuraWatch = auras
end

--------------------------------------------------------------------------------------------
-- This is the "Grid" theme debuff display section, like what GridStatusDebuffs does
--------------------------------------------------------------------------------------------

if C["unitframes"].raidunitdebuffwatch == true then
	-- Class buffs { spell ID, position [, {r,g,b,a}][, anyUnit] }
	-- It use oUF_AuraWatch lib, for grid indicator
	do
		T.buffids = {
			PRIEST = {
				{6788, "TOPRIGHT", {1, 0, 0}, true},	 -- Weakened Soul
				{33076, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},	 -- Prayer of Mending
				{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, -- Renew
				{17, "TOPLEFT", {0.81, 0.85, 0.1}, true},	 -- Power Word: Shield
			},
			DRUID = {
				{774, "TOPLEFT", {0.8, 0.4, 0.8}}, -- Rejuvenation
				{8936, "TOPRIGHT", {0.2, 0.8, 0.2}}, -- Regrowth
				{33763, "BOTTOMLEFT", {0.4, 0.8, 0.2}}, -- Lifebloom
				{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}}, -- Wild Growth
			},
			PALADIN = {
				{53563, "TOPRIGHT", {0.7, 0.3, 0.7}},	 -- Beacon of Light
				{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true},	-- Hand of Protection
				{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},	-- Hand of Freedom
				{1038, "BOTTOMRIGHT", {0.93, 0.75, 0}, true},	-- Hand of Salvation
				{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},	-- Hand of Sacrifice
			},
			SHAMAN = {
				{61295, "TOPLEFT", {0.7, 0.3, 0.7}}, -- Riptide 
				{51945, "TOPRIGHT", {0.2, 0.7, 0.2}}, -- Earthliving
				{974, "BOTTOMRIGHT", {0.7, 0.4, 0}, true}, -- Earth Shield
			},
			MONK = {
				{119611, "TOPLEFT", {0.8, 0.4, 0.8}},	 --Renewing Mist
				{116849, "TOPRIGHT", {0.2, 0.8, 0.2}},	 -- Life Cocoon
				{124682, "BOTTOMLEFT", {0.4, 0.8, 0.2}}, -- Enveloping Mist
				{124081, "BOTTOMRIGHT", {0.7, 0.4, 0}}, -- Zen Sphere
			},
			ALL = {
				{14253, "RIGHT", {0, 1, 0}}, -- Abolish Poison
			},
		}
	end
	
	-- Dispellable & Important Raid Debuffs we want to show on Grid!
	-- It use oUF_RaidDebuffs lib for tracking dispellable / important
	do
		local ORD = oUF_RaidDebuffs

		if not ORD then return end
		
		ORD.ShowDispelableDebuff = true
		ORD.FilterDispellableDebuff = true
		ORD.MatchBySpellName = true
		ORD.DeepCorruption = true
		
		local function SpellName(id)
			local name = select(1, GetSpellInfo(id))
			return name	
		end
			
		-- Important Raid Debuffs we want to show on Grid!
		-- Mists of Pandaria debuff list created by prophet
		-- http://www.tukui.org/code/view.php?id=PROPHET170812083424
		T.debuffids = {			
			-----------------------------------------------------------------
			-- Mogu'shan Vaults
			-----------------------------------------------------------------
			-- The Stone Guard
			SpellName(116281),	-- Cobalt Mine Blast
			
			-- Feng the Accursed
			SpellName(116784),	-- Wildfire Spark
			SpellName(116417),	-- Arcane Resonance
			SpellName(116942),	-- Flaming Spear
			
			-- Gara'jal the Spiritbinder
			SpellName(116161),	-- Crossed Over
			SpellName(122151),	-- Voodoo Dolls
			
			-- The Spirit Kings
			SpellName(117708),	-- Maddening Shout
			SpellName(118303),	-- Fixate
			SpellName(118048),	-- Pillaged
			SpellName(118135),	-- Pinned Down
			
			-- Elegon
			SpellName(117878),	-- Overcharged
			SpellName(117949),	-- Closed Circuit
			
			-- Will of the Emperor
			SpellName(116835),	-- Devastating Arc
			SpellName(116778),	-- Focused Defense
			SpellName(116525),	-- Focused Assault
			
			-----------------------------------------------------------------
			-- Heart of Fear
			-----------------------------------------------------------------
			-- Imperial Vizier Zor'lok
			SpellName(122761),	-- Exhale
			SpellName(122760), -- Exhale
			SpellName(122740),	-- Convert
			SpellName(123812),	-- Pheromones of Zeal
			
			-- Blade Lord Ta'yak
			SpellName(123180),	-- Wind Step
			SpellName(123474),	-- Overwhelming Assault
			
			-- Garalon
			SpellName(122835),	-- Pheromones
			SpellName(123081),	-- Pungency
			
			-- Wind Lord Mel'jarak
			SpellName(122125),	-- Corrosive Resin Pool
			SpellName(121885), 	-- Amber Prison
			
			-- Amber-Shaper Un'sok
			SpellName(121949),	-- Parasitic Growth
			-- Grand Empress Shek'zeer
			
			-----------------------------------------------------------------
			-- Terrace of Endless Spring
			-----------------------------------------------------------------
			-- Protectors of the Endless
			SpellName(117436),	-- Lightning Prison
			SpellName(118091),	-- Defiled Ground
			SpellName(117519),	-- Touch of Sha

			-- Tsulong
			SpellName(122752),	-- Shadow Breath
			SpellName(123011),	-- Terrorize
			SpellName(116161),	-- Crossed Over
			
			-- Lei Shi
			SpellName(123121),	-- Spray
			
			-- Sha of Fear
			SpellName(119985),	-- Dread Spray
			SpellName(119086),	-- Penetrating Bolt
			SpellName(119775),	-- Reaching Attack
			
			
			-----------------------------------------------------------------
			-- Throne of Thunder
			-----------------------------------------------------------------
			--Trash
			SpellName(138349), -- Static Wound
			SpellName(137371), -- Thundering Throw

			--Horridon
			SpellName(136767), --Triple Puncture

			--Council of Elders
			SpellName(137641), --Soul Fragment
			SpellName(137359), --Shadowed Loa Spirit Fixate
			SpellName(137972), --Twisted Fate

			--Tortos
			SpellName(136753), --Slashing Talons
			SpellName(137633), --Crystal Shell

			--Megaera
			SpellName(137731), --Ignite Flesh

			--Ji-Kun
			SpellName(138309), --Slimed

			--Durumu the Forgotten
			SpellName(133767), --Serious Wound
			SpellName(133768), --Arterial Cut

			--Primordius
			SpellName(136050), --Malformed Blood

			--Dark Animus
			SpellName(138569), --Explosive Slam

			--Iron Qon
			SpellName(134691), --Impale

			--Twin Consorts
			SpellName(137440), --Icy Shadows
			SpellName(137408), --Fan of Flames
			SpellName(137360), --Corrupted Healing

			--Lei Shen
			SpellName(135000), --Decapitate

			--Ra-den

			-----------------------------------------------------------------
			-- Siege of Orgrimmar
			-----------------------------------------------------------------
			-- Immerseus
			SpellName(143436),	-- Corrosive Blast
			SpellName(143459),	-- Sha Residue
			
			-- The Fallen Protectors
			SpellName(143198),	-- Garrote
			SpellName(143434),	-- Shadow Word: Bane
			SpellName(147383),	-- Debilitation
			
			-- Norushen
			SpellName(146124),	-- Self Doubt
			SpellName(144514),	-- Lingering Corruption
			
			-- Sha of Pride
			SpellName(144358),	-- Wounded Pride
			SpellName(144351),	-- Mark of Arrogance
			SpellName(146594),	-- Gift of the Titans
			SpellName(147207),	-- Weakened Resolve
			
			-- Galakras
			SpellName(146765),	-- Flame Arrows
			SpellName(146902),	-- Poison-Tipped Blades
			
			-- Iron Juggernaut
			SpellName(144467),	-- Ignite Armor
			SpellName(144459),	-- Laser Burn
			
			-- Kor'kron Dark Shaman
			SpellName(144215),	-- Froststorm Strike
			SpellName(144089),	-- Toxic Mist
			SpellName(144330),	-- Iron Prison
			
			-- General Nazgrim
			SpellName(143494),	-- Sundering Blow
			SpellName(143638),	-- Bonecracker
			SpellName(143431),	-- Magistrike
			
			-- Malkorok
			SpellName(142990),	-- Fatal Strike
			SpellName(142913),	-- Displaced Energy
			
			-- Spoils of Pandaria
			SpellName(145218),	-- Harden Flesh
			SpellName(146235),	-- Breath of Fire
			
			-- Thok the Bloodthirsty
			SpellName(143766),	-- Panic
			SpellName(143780),	-- Acid Breath
			SpellName(143773),	-- Freezing Breath
			SpellName(143800),	-- Icy Blood
			SpellName(143767),	-- Scorching Breath
			SpellName(143791),	-- Corrosive Blood
			
			-- Siegecrafter Blackfuse
			SpellName(143385),	-- Electrostatic Charge
			SpellName(144236),	-- Pattern Recognition
			
			-- Paragons of the Klaxxi
			SpellName(142929),	-- Tenderizing Strikes
			SpellName(143275),	-- Hewn
			SpellName(143279),	-- Genetic Alteration
			SpellName(143974),	-- Shield Bash
			SpellName(142948),	-- Aim
			
			-- Garrosh Hellscream
			SpellName(145183),	-- Gripping Despair
			SpellName(145195),	-- Empowered Gripping Despair
		}

		T.ReverseTimer = {

		},
		
		ORD:RegisterDebuffs(T.debuffids)
	end
end