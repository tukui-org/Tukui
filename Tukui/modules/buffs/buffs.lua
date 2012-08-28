local T, C, L, G = unpack(select(2, ...))

--[[ This is a forked file by Haste, rewrite by Tukz for Tukui. ]]--

local frame = CreateFrame("Frame", "TukuiAuras")
frame.content = {}

local icon
local faction = T.myfaction
local flash = C.auras.flash
local filter = C.auras.consolidate
local sexID = UnitSex("player")
local sex = "male"
local race = T.myrace

if sexID == 3 or race == "Pandaren" then sex = "female" end -- look like they forgot to include male icon in MoP for pandaren
if race == "Scourge" then race = "Undead" end

local proxyicon = "Interface\\Icons\\Achievement_character_"..string.lower(race).."_"..sex

-- no racial icons exist for goblins in the game, wtf?
if race == "Goblin" then
	if sex == "male" then
		proxyicon = "Interface\\Icons\\Achievement_goblinhead"
	else
		proxyicon = "Interface\\Icons\\Achievement_femalegoblinhead"
	end
end

if race == "Worgen" then
	-- couln't find any female icon in icon list
	proxyicon = "Interface\\Icons\\Achievement_worganhead"
end

local StartStopFlash = function(self, timeLeft)
	if(timeLeft < 31) then
		if(not self:IsPlaying()) then
			self:Play()
		end
	elseif(self:IsPlaying()) then
		self:Stop()
	end
end

local OnUpdate = function(self, elapsed)
	local timeLeft
	
	-- Handle refreshing of temporary enchants.
	if(self.isWeapon) then
		local expiration = select(2, GetWeaponEnchantInfo())
		if(expiration) then
			timeLeft = expiration / 1e3
		else
			timeLeft = 0
		end
	else
		timeLeft = self.timeLeft - elapsed		
	end
	
	self.timeLeft = timeLeft

	if(timeLeft <= 0) then
		-- Kill the tracker so we don't end up with stuck timers.
		self.timeLeft = nil

		self.Duration:SetText("")
		return self:SetScript("OnUpdate", nil)
	else
		local text = T.FormatTime(timeLeft)
		local r, g, b = oUFTukui.ColorGradient(self.timeLeft, self.Dur, 0.8,0,0,0.8,0.8,0,0,0.8,0)

		self.Bar:SetValue(self.timeLeft)
		self.Bar:SetStatusBarColor(r, g, b)
		
		if(timeLeft < 60.5) then
			if flash then
				StartStopFlash(self.Animation, timeLeft)
			end
			
			if(timeLeft < 5) then
				self.Duration:SetTextColor(255/255, 20/255, 20/255)	
			else
				self.Duration:SetTextColor(255/255, 165/255, 0/255)
			end
		else
			self.Duration:SetTextColor(.9, .9, .9)
		end
		
		self.Duration:SetText(text)
	end
end

local UpdateAura = function(self, index)
	local name, rank, texture, count, dtype, duration, expirationTime, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff = UnitAura(self:GetParent():GetAttribute"unit", index, self.filter)
	local consolidate = self.consolidate
	if(name) then
		if(duration > 0 and expirationTime and not consolidate) then
			local timeLeft = expirationTime - GetTime()
			if(not self.timeLeft) then
				self.timeLeft = timeLeft
				self:SetScript("OnUpdate", OnUpdate)
			else
				self.timeLeft = timeLeft
			end
			
			self.Dur = duration

			-- We do the check here as well, that way we don't have to check on
			-- every single OnUpdate call.
			if flash then
				StartStopFlash(self.Animation, timeLeft)
			end
			
			self.Bar:SetMinMaxValues(0, duration)
			if not C.auras.classictimer then self.Holder:Show() end
		else
			if flash then
				self.Animation:Stop()
			end
			self.timeLeft = nil
			self.Duration:SetText("")
			self:SetScript("OnUpdate", nil)
			
			local min, max  = self.Bar:GetMinMaxValues()
			self.Bar:SetValue(max)
			self.Bar:SetStatusBarColor(0, 0.8, 0)
			if not C.auras.classictimer then self.Holder:Hide() end
		end

		if(count > 1) then
			self.Count:SetText(count)
		else
			self.Count:SetText("")
		end

		if(self.filter == "HARMFUL") then
			local color = DebuffTypeColor[dtype or "none"]
			self:SetBackdropBorderColor(color.r * 3/5, color.g * 3/5, color.b * 3/5)
			self.Holder:SetBackdropBorderColor(color.r * 3/5, color.g * 3/5, color.b * 3/5)
		end

		self.Icon:SetTexture(texture)
	end
end

local UpdateTempEnchant = function(self, slot)
	-- set the icon
	self.Icon:SetTexture(GetInventoryItemTexture("player", slot))
	
	-- time left
	local expiration = select(2, GetWeaponEnchantInfo())
	
	if(expiration) then
		self.Dur = 3600
		self.isWeapon = true
		self:SetScript("OnUpdate", OnUpdate)
	else
		self.isWeapon = nil
		self.timeLeft = nil
		self:SetScript("OnUpdate", nil)
	end
end

local OnAttributeChanged = function(self, attribute, value)
	local consolidate = self:GetName():match("Consolidate")
	
	if consolidate or C.auras.classictimer then
		self.Holder:Hide()
	else
		self.Duration:Hide()
	end
	
	if(attribute == "index") then
		-- look if the current buff is consolidated
		if filter then
			if consolidate then
				self.consolidate = true
			end
		end
		
		return UpdateAura(self, value)
	elseif(attribute == "target-slot") then
		self.Bar:SetMinMaxValues(0, 3600)
		return UpdateTempEnchant(self, value)
	end
end

local Skin = function(self)
	local proxy = self:GetName():sub(-11) == "ProxyButton"
	local Icon = self:CreateTexture(nil, "BORDER")
	Icon:SetTexCoord(.07, .93, .07, .93)
	Icon:Point("TOPLEFT", 2, -2)
	Icon:Point("BOTTOMRIGHT", -2, 2)
	self.Icon = Icon

	local Count = self:CreateFontString(nil, "OVERLAY")
	Count:SetFontObject(NumberFontNormal)
	Count:SetPoint("TOP", self, 1, -4)
	self.Count = Count

	if(not proxy) then
		local Holder = CreateFrame("Frame", nil, self)
		Holder:Size(self:GetWidth(), 7)
		Holder:SetPoint("TOP", self, "BOTTOM", 0, -1)
		Holder:SetTemplate("Transparent")
		self.Holder = Holder
		
		local Bar = CreateFrame("StatusBar", nil, Holder)
		Bar:SetInside()
		Bar:SetStatusBarTexture(C.media.blank)
		Bar:SetStatusBarColor(0, 0.8, 0)
		self.Bar = Bar
		
		local Duration = self:CreateFontString(nil, "OVERLAY")
		local font, size, flags = C.media.font, 12, "OUTLINE"
		Duration:SetFont(font, size, flags)
		Duration:SetPoint("BOTTOM", 0, -17)
		self.Duration = Duration
		
		if flash then
			local Animation = self:CreateAnimationGroup()
			Animation:SetLooping"BOUNCE"

			local FadeOut = Animation:CreateAnimation"Alpha"
			FadeOut:SetChange(-.5)
			FadeOut:SetDuration(.4)
			FadeOut:SetSmoothing("IN_OUT")

			self.Animation = Animation
		end

		-- Kinda meh way to piggyback on the secure aura headers update loop.
		self:SetScript("OnAttributeChanged", OnAttributeChanged)

		self.filter = self:GetParent():GetAttribute"filter"
	else
		local Overlay = self:CreateTexture(nil, "OVERLAY")
		local x = self:GetWidth()
		local y = self:GetHeight()
		Overlay:SetTexture(proxyicon)
		Overlay:SetPoint("CENTER")
		Overlay:Size(x - 2, y - 2)
		Overlay:SetTexCoord(.07, .93, .07, .93)
		self.Overlay = Overlay
	end
	
	-- Set a template
	self:SetTemplate("Default")
end

frame:SetScript("OnEvent", function(self, event, ...)
	self[event](self, event, ...)
end)

function frame:PLAYER_ENTERING_WORLD()
	for _, header in next, frame.content do
		local child = header:GetAttribute"child1"
		local i = 1
		while(child) do
			UpdateAura(child, child:GetID())

			i = i + 1
			child = header:GetAttribute("child" .. i)
		end
	end
end
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

function frame:VARIABLES_LOADED()
	for _, header in next, frame.content do
		if header == TukuiAurasPlayerBuffs then
			local buffs = TukuiAurasPlayerBuffs
			local debuffs = TukuiAurasPlayerDebuffs
			local position = buffs:GetPoint()
			if position:match("LEFT") then
				buffs:SetAttribute("xOffset", 35)
				buffs:SetAttribute("point", position)
				debuffs:SetAttribute("xOffset", 35)
				debuffs:SetAttribute("point", position)
			end
		end
	end
end
frame:RegisterEvent("VARIABLES_LOADED")

-- Expose ourselves:
for frame, func in next, {
	Skin = Skin,
	Update = Update,
} do
	TukuiAuras[frame] = func
end