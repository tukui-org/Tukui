local T, C, L = unpack(select(2, ...))

-- Define action bar default buttons size
T.buttonsize = T.Scale(C.actionbar.buttonsize)
T.buttonspacing = T.Scale(C.actionbar.buttonspacing)
T.petbuttonsize = T.Scale(C.actionbar.petbuttonsize)
T.petbuttonspacing = T.Scale(C.actionbar.buttonspacing)

-- return if we are currently playing on PTR.
T.IsPTRVersion = function()
	if T.toc > 40200 then
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
T.PP = function(p, obj)
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
T.TukuiShiftBarUpdate = function()
	local numForms = GetNumShapeshiftForms()
	local texture, name, isActive, isCastable
	local button, icon, cooldown
	local start, duration, enable
	for i = 1, NUM_SHAPESHIFT_SLOTS do
		button = _G["ShapeshiftButton"..i]
		icon = _G["ShapeshiftButton"..i.."Icon"]
		if i <= numForms then
			texture, name, isActive, isCastable = GetShapeshiftFormInfo(i)
			icon:SetTexture(texture)
			
			cooldown = _G["ShapeshiftButton"..i.."Cooldown"]
			if texture then
				cooldown:SetAlpha(1)
			else
				cooldown:SetAlpha(0)
			end
			
			start, duration, enable = GetShapeshiftFormCooldown(i)
			CooldownFrame_SetTimer(cooldown, start, duration, enable)
			
			if isActive then
				ShapeshiftBarFrame.lastSelected = button:GetID()
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
T.TukuiPetBarUpdate = function(self, event)
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
		
		-- grid display
		if name then
			if not C["actionbar"].showgrid then
				petActionButton:SetAlpha(1)
			end			
		else
			if not C["actionbar"].showgrid then
				petActionButton:SetAlpha(0)
			end
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
	local role
	local tree = GetPrimaryTalentTree()
	if ((T.myclass == "PALADIN" and tree == 2) or (T.myclass == "WARRIOR" and tree == 3) or (T.myclass == "DEATHKNIGHT" and tree == 1)) or (T.myclass == "DRUID" and tree == 2 and GetBonusBarOffset() == 3) then
		role = "Tank"
	else
		local playerint = select(2, UnitStat("player", 4))
		local playeragi	= select(2, UnitStat("player", 2))
		local base, posBuff, negBuff = UnitAttackPower("player");
		local playerap = base + posBuff + negBuff;

		if (((playerap > playerint) or (playeragi > playerint)) and not (T.myclass == "SHAMAN" and tree ~= 1 and tree ~= 3) and not (UnitBuff("player", GetSpellInfo(24858)) or UnitBuff("player", GetSpellInfo(65139)))) or T.myclass == "ROGUE" or T.myclass == "HUNTER" or (T.myclass == "SHAMAN" and tree == 2) then
			role = "Melee"
		else
			role = "Caster"
		end
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

function T.SetModifiedBackdrop(self)
	local color = RAID_CLASS_COLORS[T.myclass]
	self:SetBackdropColor(color.r*.15, color.g*.15, color.b*.15)
	self:SetBackdropBorderColor(color.r, color.g, color.b)
end

function T.SetOriginalBackdrop(self)
	local color = RAID_CLASS_COLORS[T.myclass]
	if C["general"].classcolortheme == true then
		self:SetBackdropBorderColor(color.r, color.g, color.b)
	else
		self:SetTemplate("Default")
	end
end

function T.SkinButton(f, strip)
	if f:GetName() then
		local l = _G[f:GetName().."Left"]
		local m = _G[f:GetName().."Middle"]
		local r = _G[f:GetName().."Right"]
		
		
		if l then l:SetAlpha(0) end
		if m then m:SetAlpha(0) end
		if r then r:SetAlpha(0) end
	end

	if f.SetNormalTexture then f:SetNormalTexture("") end
	
	if f.SetHighlightTexture then f:SetHighlightTexture("") end
	
	if f.SetPushedTexture then f:SetPushedTexture("") end
	
	if f.SetDisabledTexture then f:SetDisabledTexture("") end
	
	if strip then f:StripTextures() end
	
	f:SetTemplate("Default")
	f:HookScript("OnEnter", T.SetModifiedBackdrop)
	f:HookScript("OnLeave", T.SetOriginalBackdrop)
end

function T.SkinScrollBar(frame)
	if _G[frame:GetName().."BG"] then _G[frame:GetName().."BG"]:SetTexture(nil) end
	if _G[frame:GetName().."Track"] then _G[frame:GetName().."Track"]:SetTexture(nil) end
	
	if _G[frame:GetName().."Top"] then
		_G[frame:GetName().."Top"]:SetTexture(nil)
	end
	
	if _G[frame:GetName().."Bottom"] then
		_G[frame:GetName().."Bottom"]:SetTexture(nil)
	end
	
	if _G[frame:GetName().."Middle"] then
		_G[frame:GetName().."Middle"]:SetTexture(nil)
	end

	if _G[frame:GetName().."ScrollUpButton"] and _G[frame:GetName().."ScrollDownButton"] then
		_G[frame:GetName().."ScrollUpButton"]:StripTextures()
		_G[frame:GetName().."ScrollUpButton"]:SetTemplate("Default", true)
		if not _G[frame:GetName().."ScrollUpButton"].texture then
			_G[frame:GetName().."ScrollUpButton"].texture = _G[frame:GetName().."ScrollUpButton"]:CreateTexture(nil, 'OVERLAY')
			_G[frame:GetName().."ScrollUpButton"].texture:Point("TOPLEFT", 2, -2)
			_G[frame:GetName().."ScrollUpButton"].texture:Point("BOTTOMRIGHT", -2, 2)
			_G[frame:GetName().."ScrollUpButton"].texture:SetTexture([[Interface\AddOns\Tukui\medias\textures\arrowup.tga]])
			_G[frame:GetName().."ScrollUpButton"].texture:SetVertexColor(unpack(C["media"].bordercolor))
		end	
		
		_G[frame:GetName().."ScrollDownButton"]:StripTextures()
		_G[frame:GetName().."ScrollDownButton"]:SetTemplate("Default", true)
	
		if not _G[frame:GetName().."ScrollDownButton"].texture then
			_G[frame:GetName().."ScrollDownButton"].texture = _G[frame:GetName().."ScrollDownButton"]:CreateTexture(nil, 'OVERLAY')
			_G[frame:GetName().."ScrollDownButton"].texture:Point("TOPLEFT", 2, -2)
			_G[frame:GetName().."ScrollDownButton"].texture:Point("BOTTOMRIGHT", -2, 2)
			_G[frame:GetName().."ScrollDownButton"].texture:SetTexture([[Interface\AddOns\Tukui\medias\textures\arrowdown.tga]])
			_G[frame:GetName().."ScrollDownButton"].texture:SetVertexColor(unpack(C["media"].bordercolor))
		end				
		
		if not frame.trackbg then
			frame.trackbg = CreateFrame("Frame", nil, frame)
			frame.trackbg:Point("TOPLEFT", _G[frame:GetName().."ScrollUpButton"], "BOTTOMLEFT", 0, -1)
			frame.trackbg:Point("BOTTOMRIGHT", _G[frame:GetName().."ScrollDownButton"], "TOPRIGHT", 0, 1)
			frame.trackbg:SetTemplate("Transparent")
		end
		
		if frame:GetThumbTexture() then
			if not thumbTrim then thumbTrim = 3 end
			frame:GetThumbTexture():SetTexture(nil)
			if not frame.thumbbg then
				frame.thumbbg = CreateFrame("Frame", nil, frame)
				frame.thumbbg:Point("TOPLEFT", frame:GetThumbTexture(), "TOPLEFT", 2, -thumbTrim)
				frame.thumbbg:Point("BOTTOMRIGHT", frame:GetThumbTexture(), "BOTTOMRIGHT", -2, thumbTrim)
				frame.thumbbg:SetTemplate("Default", true)
				if frame.trackbg then
					frame.thumbbg:SetFrameLevel(frame.trackbg:GetFrameLevel())
				end
			end
		end	
	end	
end

--Tab Regions
local tabs = {
	"LeftDisabled",
	"MiddleDisabled",
	"RightDisabled",
	"Left",
	"Middle",
	"Right",
}

function T.SkinTab(tab)
	if not tab then return end
	for _, object in pairs(tabs) do
		local tex = _G[tab:GetName()..object]
		if tex then
			tex:SetTexture(nil)
		end
	end
	
	if tab.GetHighlightTexture and tab:GetHighlightTexture() then
		tab:GetHighlightTexture():SetTexture(nil)
	else
		tab:StripTextures()
	end
	
	tab.backdrop = CreateFrame("Frame", nil, tab)
	tab.backdrop:SetTemplate("Default")
	tab.backdrop:SetFrameLevel(tab:GetFrameLevel() - 1)
	tab.backdrop:Point("TOPLEFT", 10, -3)
	tab.backdrop:Point("BOTTOMRIGHT", -10, 3)				
end

function T.SkinNextPrevButton(btn, horizonal)
	btn:SetTemplate("Default")
	btn:Size(btn:GetWidth() - 7, btn:GetHeight() - 7)	
	
	if horizonal then
		btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.72, 0.65, 0.29, 0.65, 0.72)
		btn:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.8, 0.65, 0.35, 0.65, 0.8)
		btn:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)	
	else
		btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.81, 0.65, 0.29, 0.65, 0.81)
		if btn:GetPushedTexture() then
			btn:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.81, 0.65, 0.35, 0.65, 0.81)
		end
		if btn:GetDisabledTexture() then
			btn:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)
		end
	end
	
	btn:GetNormalTexture():ClearAllPoints()
	btn:GetNormalTexture():Point("TOPLEFT", 2, -2)
	btn:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
	if btn:GetDisabledTexture() then
		btn:GetDisabledTexture():SetAllPoints(btn:GetNormalTexture())
	end
	if btn:GetPushedTexture() then
		btn:GetPushedTexture():SetAllPoints(btn:GetNormalTexture())
	end
	btn:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)
	btn:GetHighlightTexture():SetAllPoints(btn:GetNormalTexture())
end

function T.SkinRotateButton(btn)
	btn:SetTemplate("Default")
	btn:Size(btn:GetWidth() - 14, btn:GetHeight() - 14)	
	
	btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.65, 0.69, 0.29, 0.69, 0.65)
	btn:GetPushedTexture():SetTexCoord(0.3, 0.29, 0.3, 0.65, 0.69, 0.29, 0.69, 0.65)	
	
	btn:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)
	
	btn:GetNormalTexture():ClearAllPoints()
	btn:GetNormalTexture():Point("TOPLEFT", 2, -2)
	btn:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
	btn:GetPushedTexture():SetAllPoints(btn:GetNormalTexture())	
	btn:GetHighlightTexture():SetAllPoints(btn:GetNormalTexture())
end

function T.SkinEditBox(frame)
	if _G[frame:GetName().."Left"] then _G[frame:GetName().."Left"]:Kill() end
	if _G[frame:GetName().."Middle"] then _G[frame:GetName().."Middle"]:Kill() end
	if _G[frame:GetName().."Right"] then _G[frame:GetName().."Right"]:Kill() end
	if _G[frame:GetName().."Mid"] then _G[frame:GetName().."Mid"]:Kill() end
	frame:CreateBackdrop("Default")
	
	if frame:GetName() and frame:GetName():find("Silver") or frame:GetName():find("Copper") then
		frame.backdrop:Point("BOTTOMRIGHT", -12, -2)
	end
end

function T.SkinDropDownBox(frame, width)
	local button = _G[frame:GetName().."Button"]
	if not width then width = 155 end
	
	frame:StripTextures()
	frame:Width(width)
	
	_G[frame:GetName().."Text"]:ClearAllPoints()
	_G[frame:GetName().."Text"]:Point("RIGHT", button, "LEFT", -2, 0)

	
	button:ClearAllPoints()
	button:Point("RIGHT", frame, "RIGHT", -10, 3)
	button.SetPoint = T.dummy
	
	T.SkinNextPrevButton(button, true)
	
	frame:CreateBackdrop("Default")
	frame.backdrop:Point("TOPLEFT", 20, -2)
	frame.backdrop:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
end

function T.SkinCheckBox(frame)
	frame:StripTextures()
	frame:CreateBackdrop("Default")
	frame.backdrop:Point("TOPLEFT", 4, -4)
	frame.backdrop:Point("BOTTOMRIGHT", -4, 4)
	
	if frame.SetCheckedTexture then
		frame:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
	end
	
	if frame.SetDisabledCheckedTexture then
		frame:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
	end
	
	frame.SetNormalTexture = T.dummy
	frame.SetPushedTexture = T.dummy
	frame.SetHighlightTexture = T.dummy
end

function T.SkinCloseButton(f, point)	
	if point then
		f:Point("TOPRIGHT", point, "TOPRIGHT", 2, 2)
	end
	
	f:SetNormalTexture("")
	f:SetPushedTexture("")
	f:SetHighlightTexture("")
	f.t = f:CreateFontString(nil, "OVERLAY")
	f.t:SetFont(C.media.pixelfont, 12, "MONOCHROME")
	f.t:SetPoint("CENTER", 0, 1)
	f.t:SetText("X")
end

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

-- Spawn the right-click dropdown on unitframe
T.SpawnMenu = function(self)
	local unit = self.unit:gsub("(.)", string.upper, 1)
	if unit == "Targettarget" or unit == "focustarget" or unit == "pettarget" then return end

	if _G[unit.."FrameDropDown"] then
		ToggleDropDownMenu(1, nil, _G[unit.."FrameDropDown"], "cursor")
	elseif (self.unit:match("party")) then
		ToggleDropDownMenu(1, nil, _G["PartyMemberFrame"..self.id.."DropDown"], "cursor")
	else
		FriendsDropDown.unit = self.unit
		FriendsDropDown.id = self.id
		FriendsDropDown.initialize = RaidFrameDropDown_Initialize
		ToggleDropDownMenu(1, nil, FriendsDropDown, "cursor")
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
			r, g, b = oUF.ColorGradient(min/max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
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
	if(icon.debuff) then
		if(not UnitIsFriend("player", unit) and icon.owner ~= "player" and icon.owner ~= "vehicle") then
			icon:SetBackdropBorderColor(unpack(C["media"].bordercolor))
			icon.icon:SetDesaturated(true)
		else
			local color = DebuffTypeColor[dtype] or DebuffTypeColor.none
			icon:SetBackdropBorderColor(color.r * 0.6, color.g * 0.6, color.b * 0.6)
			icon.icon:SetDesaturated(false)
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

-- hide the portrait if out of range, not connected, etc
T.HidePortrait = function(self, unit)
	if self.unit == "target" then
		if not UnitExists(self.unit) or not UnitIsConnected(self.unit) or not UnitIsVisible(self.unit) then
			self.Portrait:SetAlpha(0)
		else
			self.Portrait:SetAlpha(1)
		end
	end
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

-- update holy charge display on paladin
T.UpdateHoly = function(self, event, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= 'HOLY_POWER')) then return end
	local num = UnitPower(unit, SPELL_POWER_HOLY_POWER)
	for i = 1, MAX_HOLY_POWER do
		if(i <= num) then
			self.HolyPower[i]:SetAlpha(1)
		else
			self.HolyPower[i]:SetAlpha(.2)
		end
	end
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

-- show the druid bar mana or eclipse if form is moonkin/cat/bear.
T.DruidBarDisplay = function(self, login)
	local eb = self.EclipseBar
	local dm = self.DruidMana
	local txt = self.EclipseBar.Text
	local shadow = self.shadow
	local bg = self.DruidManaBackground
	local flash = self.FlashInfo

	if login then
		dm:SetScript("OnUpdate", nil)
	end
	
	if eb:IsShown() or dm:IsShown() then
		if eb:IsShown() then
			txt:Show()
			flash:Hide()
		end
		shadow:Point("TOPLEFT", -4, 12)
		bg:SetAlpha(1)
	else
		txt:Hide()
		flash:Show()
		shadow:Point("TOPLEFT", -4, 4)
		bg:SetAlpha(0)
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

	local percMana = UnitMana("player") / UnitManaMax("player") * 100

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
				{6788, "TOPLEFT", {1, 0, 0}, true}, -- Weakened Soul
				{33076, "TOPRIGHT", {0.2, 0.7, 0.2}}, -- Prayer of Mending
				{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, -- Renew
				{17, "BOTTOMRIGHT", {0.81, 0.85, 0.1}, true}, -- Power Word: Shield
			},
			DRUID = {
				{774, "TOPLEFT", {0.8, 0.4, 0.8}}, -- Rejuvenation
				{8936, "TOPRIGHT", {0.2, 0.8, 0.2}}, -- Regrowth
				{33763, "BOTTOMLEFT", {0.4, 0.8, 0.2}}, -- Lifebloom
				{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}}, -- Wild Growth
			},
			PALADIN = {
				{53563, "TOPLEFT", {0.7, 0.3, 0.7}}, -- Beacon of Light
			},
			SHAMAN = {
				{61295, "TOPLEFT", {0.7, 0.3, 0.7}}, -- Riptide 
				{51945, "TOPRIGHT", {0.2, 0.7, 0.2}}, -- Earthliving
				{16177, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, -- Ancestral Fortitude
				{974, "BOTTOMRIGHT", {0.7, 0.4, 0}, true}, -- Earth Shield
			},
			ALL = {
				{14253, "RIGHT", {0, 1, 0}}, -- Abolish Poison
				{23333, "LEFT", {1, 0, 0}}, -- Warsong flag xD
			},
		}
	end
	
	-- Dispellable & Important Raid Debuffs we want to show on Grid!
	-- It use oUF_RaidDebuffs lib for tracking dispellable / important
	do
		local _, ns = ...
		local ORD = ns.oUF_RaidDebuffs or oUF_RaidDebuffs

		if not ORD then return end
		
		ORD.ShowDispelableDebuff = true
		ORD.FilterDispellableDebuff = true
		ORD.MatchBySpellName = true
		ORD.DeepCorruption = true
		
		local function SpellName(id)
			local name = select(1, GetSpellInfo(id))
			return name	
		end

		T.debuffids = {
		-- Other debuff
			SpellName(67479), -- Impale

		--CATA DEBUFFS
		--Baradin Hold
			SpellName(95173), -- Consuming Darkness

		--Blackwing Descent
			--Magmaw
			SpellName(91911), -- Constricting Chains
			SpellName(94679), -- Parasitic Infection
			SpellName(94617), -- Mangle

			--Omintron Defense System
			SpellName(79835), --Poison Soaked Shell
			SpellName(91433), --Lightning Conductor
			SpellName(91521), --Incineration Security Measure

			--Maloriak
			SpellName(77699), -- Flash Freeze
			SpellName(77760), -- Biting Chill

			--Atramedes
			SpellName(92423), -- Searing Flame
			SpellName(92485), -- Roaring Flame
			SpellName(92407), -- Sonic Breath

			--Chimaeron
			SpellName(82881), -- Break
			SpellName(89084), -- Low Health

			--Nefarian

			--Sinestra
			SpellName(92956), --Wrack

		--The Bastion of Twilight
			--Valiona & Theralion
			SpellName(92878), -- Blackout
			SpellName(86840), -- Devouring Flames
			SpellName(95639), -- Engulfing Magic

			--Halfus Wyrmbreaker
			SpellName(39171), -- Malevolent Strikes

			--Twilight Ascendant Council
			SpellName(92511), -- Hydro Lance
			SpellName(82762), -- Waterlogged
			SpellName(92505), -- Frozen
			SpellName(92518), -- Flame Torrent
			SpellName(83099), -- Lightning Rod
			SpellName(92075), -- Gravity Core
			SpellName(92488), -- Gravity Crush

			--Cho'gall
			SpellName(86028), -- Cho's Blast
			SpellName(86029), -- Gall's Blast

		--Throne of the Four Winds
			--Conclave of Wind
				--Nezir <Lord of the North Wind>
				SpellName(93131), --Ice Patch
				--Anshal <Lord of the West Wind>
				SpellName(86206), --Soothing Breeze
				SpellName(93122), --Toxic Spores
				--Rohash <Lord of the East Wind>
				SpellName(93058), --Slicing Gale
			--Al'Akir
			SpellName(93260), -- Ice Storm
			SpellName(93295), -- Lightning Rod

		-- Firelands, thanks Kaelhan :)
			-- Beth'tilac
				SpellName(99506),	-- Widows Kiss
				SpellName(97202),	-- Fiery Web Spin
				SpellName(49026),	-- Fixate
				SpellName(97079),	-- Seeping Venom
			-- Lord Rhyolith
				-- none, hehe, fake boss
			-- Alysrazor
				SpellName(101296),	-- Fieroblast
				SpellName(100723),	-- Gushing Wound
				SpellName(99389),	-- Imprinted
				SpellName(101729),	-- Blazing Claw
			-- Shannox
				SpellName(99837),	-- Crystal Prison
				SpellName(99937),	-- Jagged Tear
			-- Baleroc
				SpellName(99256),	-- Torment
				SpellName(99252),	-- Blaze of Glory
				SpellName(99516),	-- Countdown
			-- Majordomo Staghelm
				SpellName(98450),	-- Searing Seeds
			-- Ragnaros
				SpellName(99399),	-- Burning Wound
				SpellName(100293),	-- Lava Wave
				SpellName(98313),	-- Magma Blast
				SpellName(100675),	-- Dreadflame
				
		-- Dragon Soul
			-- Morchok
				SpellName(103687),	-- Crush Armor
				SpellName(103536),	-- Warning
				SpellName(103534),	-- Danger
				SpellName(108570),	-- Black Blood of the Earth
			
			-- Warlord Zon'ozz
				SpellName(103434),	-- Disrupting Shadows
			
			-- Yor'sahj the Unsleeping
				SpellName(103628),	-- Deep Corruption
			
			-- Hagara the Stormbinder
				SpellName(104451),	-- Ice Tomb
				SpellName(105259),	-- Watery Entrenchment
				SpellName(109325),	-- Frostflake
				SpellName(105289),	-- Shattered Ice
				SpellName(105285),	-- Target
				SpellName(107061),	-- Ice Lance
			
			-- Ultraxion
				SpellName(105925),	-- Fading Light
			
			-- Warmaster Blackhorn
				SpellName(108043),	-- Devastate
				SpellName(108046),	-- Shockwave
				SpellName(107567),	-- Brutal Strike
				SpellName(107558),	-- Degeneration
			
			-- Spine of Deathwing
				SpellName(105563),	-- Grasping Tendrils
				SpellName(105479),	-- Searing Plasma
				SpellName(105490),	-- Fiery Grip
			
			-- Madness of Deathwing
				SpellName(105841),	-- Degenerative bite
				SpellName(105445),	-- Blistering heat
				SpellName(109603),	-- Tetanus
				SpellName(110141),	-- Shrapnel
		}

		T.ReverseTimer = {
			[92956] = true, -- Sinestra (Wrack)
		},
		
		ORD:RegisterDebuffs(T.debuffids)
	end
end