local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

-- all the frame we want to move
-- all our frames that we want being movable.
T.AllowFrameMoving = {
	TukuiMinimap,
	TukuiTooltipAnchor,
	TukuiAurasPlayerBuffs,
	TukuiShiftBar,
	TukuiRollAnchor,
	TukuiAchievementHolder,
	TukuiWatchFrameAnchor,
	TukuiGMFrameAnchor,
	TukuiVehicleAnchor,
}

-- used to exec various code if we enable or disable moving
local function exec(self, enable)
	if self == TukuiGMFrameAnchor then
		if enable then
			self:Show()
		else
			self:Hide()
		end
	end
	
	if self == TukuiMinimap then
		if enable then 
			Minimap:Hide()
			self:SetBackdropBorderColor(1,0,0,1)
		else 
			Minimap:Show()
			self:SetBackdropBorderColor(unpack(C.media.bordercolor))
		end
	end
	
	if self == TukuiAurasPlayerBuffs then
		if not self:GetBackdrop() then self:SetTemplate("Default") end
		
		local buffs = TukuiAurasPlayerBuffs
		local debuffs = TukuiAurasPlayerDebuffs
		
		if enable then
			buffs:SetBackdropColor(unpack(C.media.backdropcolor))
			buffs:SetBackdropBorderColor(1,0,0,1)	
		else
			local position = self:GetPoint()
			if position:match("TOPLEFT") or position:match("BOTTOMLEFT") or position:match("BOTTOMRIGHT") or position:match("TOPRIGHT") then
				buffs:SetAttribute("point", position)
				debuffs:SetAttribute("point", position)
			end
			if position:match("LEFT") then
				buffs:SetAttribute("xOffset", 35)
				debuffs:SetAttribute("xOffset", 35)
			else
				buffs:SetAttribute("xOffset", -35)
				debuffs:SetAttribute("xOffset", -35)
			end
			if position:match("BOTTOM") then
				buffs:SetAttribute("wrapYOffset", 67.5)
				debuffs:SetAttribute("wrapYOffset", 67.5)
			else
				buffs:SetAttribute("wrapYOffset", -67.5)
				debuffs:SetAttribute("wrapYOffset", -67.5)
			end
			buffs:SetBackdropColor(0,0,0,0)
			buffs:SetBackdropBorderColor(0,0,0,0)
		end
	end
	
	if self == TukuiTooltipAnchor or self == TukuiRollAnchor or self == TukuiAchievementHolder or self == TukuiVehicleAnchor then
		if enable then
			self:SetAlpha(1)
		else
			self:SetAlpha(0)
			if self == TukuiTooltipAnchor then 
				local position = TukuiTooltipAnchor:GetPoint()
				local healthBar = GameTooltipStatusBar
				if position:match("TOP") then
					healthBar:ClearAllPoints()
					healthBar:Point("TOPLEFT", healthBar:GetParent(), "BOTTOMLEFT", 2, -5)
					healthBar:Point("TOPRIGHT", healthBar:GetParent(), "BOTTOMRIGHT", -2, -5)
					if healthBar.text then healthBar.text:Point("CENTER", healthBar, 0, -6) end
				else
					healthBar:ClearAllPoints()
					healthBar:Point("BOTTOMLEFT", healthBar:GetParent(), "TOPLEFT", 2, 5)
					healthBar:Point("BOTTOMRIGHT", healthBar:GetParent(), "TOPRIGHT", -2, 5)
					if healthBar.text then healthBar.text:Point("CENTER", healthBar, 0, 6) end			
				end
			end
		end		
	end
	
	if self == TukuiWatchFrameAnchor then
		if enable then
			TukuiWatchFrameAnchor:SetBackdropBorderColor(1,0,0,1)
			TukuiWatchFrameAnchor:SetBackdropColor(unpack(C.media.backdropcolor))		
		else
			TukuiWatchFrameAnchor:SetBackdropBorderColor(0,0,0,0)
			TukuiWatchFrameAnchor:SetBackdropColor(0,0,0,0)		
		end
	end
	
	if self == TukuiShiftBar then
		if enable then
			TukuiShapeShiftHolder:SetAlpha(1)
		else
			TukuiShapeShiftHolder:SetAlpha(0)
		end
	end
end

local enable = true
local origa1, origf, origa2, origx, origy

local function moving()
	-- don't allow moving while in combat
	if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end
	
	for i = 1, getn(T.AllowFrameMoving) do
		if T.AllowFrameMoving[i] then		
			if enable then			
				T.AllowFrameMoving[i]:EnableMouse(true)
				T.AllowFrameMoving[i]:RegisterForDrag("LeftButton", "RightButton")
				T.AllowFrameMoving[i]:SetScript("OnDragStart", function(self) 
					origa1, origf, origa2, origx, origy = T.AllowFrameMoving[i]:GetPoint() 
					self.moving = true 
					self:SetUserPlaced(true) 
					self:StartMoving() 
				end)			
				T.AllowFrameMoving[i]:SetScript("OnDragStop", function(self) 
					self.moving = false 
					self:StopMovingOrSizing() 
				end)			
				exec(T.AllowFrameMoving[i], enable)			
				if T.AllowFrameMoving[i].text then 
					T.AllowFrameMoving[i].text:Show() 
				end
			else			
				T.AllowFrameMoving[i]:EnableMouse(false)
				if T.AllowFrameMoving[i].moving == true then
					T.AllowFrameMoving[i]:StopMovingOrSizing()
					T.AllowFrameMoving[i]:ClearAllPoints()
					T.AllowFrameMoving[i]:SetPoint(origa1, origf, origa2, origx, origy)
				end
				exec(T.AllowFrameMoving[i], enable)
				if T.AllowFrameMoving[i].text then T.AllowFrameMoving[i].text:Hide() end
				T.AllowFrameMoving[i].moving = false
			end
		end
	end
	
	if T.MoveUnitFrames then T.MoveUnitFrames() end
	
	if enable then enable = false else enable = true end
end
SLASH_MOVING1 = "/mtukui"
SLASH_MOVING2 = "/moveui"
SlashCmdList["MOVING"] = moving

local protection = CreateFrame("Frame")
protection:RegisterEvent("PLAYER_REGEN_DISABLED")
protection:SetScript("OnEvent", function(self, event)
	if enable then return end
	print(ERR_NOT_IN_COMBAT)
	enable = false
	moving()
end)