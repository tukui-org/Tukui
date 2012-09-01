local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, "Tukui was unable to locate oUF install.")

ns._Objects = {}
ns._Headers = {}

local T, C, L, G = unpack(select(2, ...)) 

if not C["unitframes"].enable == true then return end

------------------------------------------------------------------------
--	local variables
------------------------------------------------------------------------

local font1 = C["media"].uffont
local font2 = C["media"].font
local normTex = C["media"].normTex
local glowTex = C["media"].glowTex
local bubbleTex = C["media"].bubbleTex
local bdcr, bdcg, bdcb = unpack(C["media"].bordercolor)

local backdrop = {
	bgFile = C["media"].blank,
	insets = {top = -T.mult, left = -T.mult, bottom = -T.mult, right = -T.mult},
}

------------------------------------------------------------------------
--	Layout
------------------------------------------------------------------------

local function Shared(self, unit)
	-- set our own colors
	self.colors = T.UnitColor
	
	-- register click
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	
	-- menu? lol
	self.menu = T.SpawnMenu

	-- backdrop for every units
	self:SetBackdrop(backdrop)
	self:SetBackdropColor(0, 0, 0)

	-- this is the glow border
	self:CreateShadow("Default")
	
	------------------------------------------------------------------------
	--	Features we want for all units at the same time
	------------------------------------------------------------------------
	
	-- here we create an invisible frame for all element we want to show over health/power.
	local InvFrame = CreateFrame("Frame", nil, self)
	InvFrame:SetFrameStrata("HIGH")
	InvFrame:SetFrameLevel(5)
	InvFrame:SetAllPoints()
	
	-- symbols, now put the symbol on the frame we created above.
	local RaidIcon = InvFrame:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetTexture("Interface\\AddOns\\Tukui\\medias\\textures\\raidicons.blp") -- thx hankthetank for texture
	RaidIcon:SetHeight(20)
	RaidIcon:SetWidth(20)
	RaidIcon:SetPoint("TOP", 0, 11)
	self.RaidIcon = RaidIcon
	
	------------------------------------------------------------------------
	--	Player and Target units layout (mostly mirror"d)
	------------------------------------------------------------------------
	
	if (unit == "player" or unit == "target") then
		-- create a panel
		local panel = CreateFrame("Frame", nil, self)
		panel:SetTemplate()
		if T.lowversion then
			panel:Size(186, 21)
			panel:Point("BOTTOM", self, "BOTTOM", 0, 0)
		else
			panel:Size(250, 21)
			panel:Point("BOTTOM", self, "BOTTOM", 0, 0)
		end
		panel:SetFrameLevel(2)
		panel:SetFrameStrata("MEDIUM")
		panel:SetBackdropBorderColor(bdcr * 0.7, bdcg * 0.7, bdcb * 0.7)
		self.panel = panel
	
		-- health bar
		local health = CreateFrame("StatusBar", nil, self)
		if T.lowversion then
			health:Height(20)
		else
			health:Height(26)
		end
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)
				
		-- health bar background
		local healthBG = health:CreateTexture(nil, "BORDER")
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
	
		health.value = T.SetFontString(panel, font1, 12)
		health.value:Point("RIGHT", panel, "RIGHT", -4, 0)
		health.PostUpdate = T.PostUpdateHealth
				
		self.Health = health
		self.Health.bg = healthBG

		health.frequentUpdates = true
		if C["unitframes"].showsmooth == true then
			health.Smooth = true
		end
		
		if C["unitframes"].unicolor == true then
			health.colorTapping = false
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.3, .3, .3, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true
			health.colorTapping = true	
			health.colorClass = true
			health.colorReaction = true			
		end

		-- power
		local power = CreateFrame("StatusBar", nil, self)
		power:Height(8)
		power:Point("TOPLEFT", health, "BOTTOMLEFT", 0, -1)
		power:Point("TOPRIGHT", health, "BOTTOMRIGHT", 0, -1)
		power:SetStatusBarTexture(normTex)
		
		local powerBG = power:CreateTexture(nil, "BORDER")
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(normTex)
		powerBG.multiplier = 0.3
		
		power.value = T.SetFontString(panel, font1, 12)
		power.value:Point("LEFT", panel, "LEFT", 4, 0)
		power.PreUpdate = T.PreUpdatePower
		power.PostUpdate = T.PostUpdatePower
				
		self.Power = power
		self.Power.bg = powerBG
		
		power.frequentUpdates = true
		power.colorDisconnected = true

		if C["unitframes"].showsmooth == true then
			power.Smooth = true
		end
		
		if C["unitframes"].unicolor == true then
			power.colorTapping = true
			power.colorClass = true
			powerBG.multiplier = 0.1				
		else
			power.colorPower = true
		end

		-- portraits
		if (C["unitframes"].charportrait == true) then
			local graphic = GetCVar("gxapi")
			local isMac = IsMacClient()
			if isMac or graphic == "D3D11" then
				local portrait = CreateFrame("PlayerModel", self:GetName().."_Portrait", self)
				portrait:SetFrameLevel(8)
				if T.lowversion then
					portrait:SetHeight(51)
				else
					portrait:SetHeight(57)
				end
				portrait:SetWidth(33)
				portrait:SetAlpha(1)
				if unit == "player" then
					portrait:SetPoint("TOPLEFT", health, "TOPLEFT", -34,0)
					panel:Point("TOPLEFT", power, "BOTTOMLEFT", 0, -1)
					panel:Point("TOPRIGHT", power, "BOTTOMRIGHT", 0, -1)
				elseif unit == "target" then
					portrait:SetPoint("TOPRIGHT", health, "TOPRIGHT", 34,0)
					panel:Point("TOPRIGHT", power, "BOTTOMRIGHT", 0, -1)
					panel:Point("TOPLEFT", power, "BOTTOMLEFT", 0, -1)
				end
				panel:SetWidth(panel:GetWidth() - 34) -- panel need to be resized if charportrait is enabled
				table.insert(self.__elements, T.HidePortrait)
				portrait.PostUpdate = T.PortraitUpdate --Worgen Fix (Hydra)
				self.Portrait = portrait
			else
				portrait = self:CreateTexture(nil, "ARTWORK")
				portrait:SetPoint("CENTER")
				portrait:SetPoint("CENTER")
				portrait:SetHeight(35)
				portrait:SetWidth(33)
				portrait:SetTexCoord(0.1,0.9,0.1,0.9)
				if unit == "player" then
					portrait:SetPoint("TOPLEFT", health, "TOPLEFT", -34,0)
				elseif unit == "target" then
					portrait:SetPoint("TOPRIGHT", health, "TOPRIGHT", 34,0)
				end	

				self.Portrait = portrait
			end
			
			if unit == "player" then
				health:SetPoint("TOPLEFT", 34,0)
				health:SetPoint("TOPRIGHT")
				power:Point("TOPLEFT", health, "BOTTOMLEFT", 0, -1)
				power:Point("TOPRIGHT", health, "BOTTOMRIGHT", 0, -1)
			elseif unit == "target" then
				health:SetPoint("TOPRIGHT", -34,0)
				health:SetPoint("TOPLEFT")
				power:Point("TOPRIGHT", health, "BOTTOMRIGHT", 0, -1)
				power:Point("TOPLEFT", health, "BOTTOMLEFT", 0, -1)
			end
		end
		
		if T.myclass == "PRIEST" and C["unitframes"].weakenedsoulbar then
			local ws = CreateFrame("StatusBar", self:GetName().."_WeakenedSoul", power)
			ws:SetAllPoints(power)
			ws:SetStatusBarTexture(C.media.normTex)
			ws:GetStatusBarTexture():SetHorizTile(false)
			ws:SetBackdrop(backdrop)
			ws:SetBackdropColor(unpack(C.media.backdropcolor))
			ws:SetStatusBarColor(191/255, 10/255, 10/255)
			
			self.WeakenedSoul = ws
		end
			
		if (unit == "player") then
			-- combat icon
			local Combat = health:CreateTexture(nil, "OVERLAY")
			Combat:Height(19)
			Combat:Width(19)
			Combat:SetPoint("LEFT",0,1)
			Combat:SetVertexColor(0.69, 0.31, 0.31)
			self.Combat = Combat

			-- custom info (low mana warning)
			FlashInfo = CreateFrame("Frame", "TukuiFlashInfo", self)
			FlashInfo:SetScript("OnUpdate", T.UpdateManaLevel)
			FlashInfo.parent = self
			FlashInfo:SetAllPoints(panel)
			FlashInfo.ManaLevel = T.SetFontString(FlashInfo, font1, 12)
			FlashInfo.ManaLevel:SetPoint("CENTER", panel, "CENTER", 0, 0)
			self.FlashInfo = FlashInfo
			
			-- pvp status text
			local status = T.SetFontString(panel, font1, 12)
			status:SetPoint("CENTER", panel, "CENTER", 0, 0)
			status:SetTextColor(0.69, 0.31, 0.31)
			status:Hide()
			self.Status = status
			
			-- leader icon
			local Leader = InvFrame:CreateTexture(nil, "OVERLAY")
			Leader:Height(14)
			Leader:Width(14)
			Leader:Point("TOPLEFT", 2, 8)
			self.Leader = Leader
			
			-- master looter
			local MasterLooter = InvFrame:CreateTexture(nil, "OVERLAY")
			MasterLooter:Height(14)
			MasterLooter:Width(14)
			self.MasterLooter = MasterLooter
			self:RegisterEvent("PARTY_LEADER_CHANGED", T.MLAnchorUpdate)
			self:RegisterEvent("GROUP_ROSTER_UPDATE", T.MLAnchorUpdate)

			-- experience bar on player via mouseover for player currently levelling a character
			if T.level ~= MAX_PLAYER_LEVEL then
				local Experience = CreateFrame("StatusBar", self:GetName().."_Experience", self)
				Experience:SetStatusBarTexture(normTex)
				Experience:SetStatusBarColor(0, 0.4, 1, .8)
				Experience:SetBackdrop(backdrop)
				Experience:SetBackdropColor(unpack(C["media"].backdropcolor))
				Experience:Width(panel:GetWidth() - 4)
				Experience:Height(panel:GetHeight() - 4)
				Experience:Point("TOPLEFT", panel, 2, -2)
				Experience:Point("BOTTOMRIGHT", panel, -2, 2)
				Experience:SetFrameLevel(10)
				Experience:SetAlpha(0)				
				Experience:HookScript("OnEnter", function(self) self:SetAlpha(1) end)
				Experience:HookScript("OnLeave", function(self) self:SetAlpha(0) end)
				Experience.Tooltip = true						
				Experience.Rested = CreateFrame("StatusBar", nil, self)
				Experience.Rested:SetParent(Experience)
				Experience.Rested:SetAllPoints(Experience)
				Experience.Rested:SetStatusBarTexture(normTex)
				Experience.Rested:SetStatusBarColor(1, 0, 1, 0.2)
				local Resting = Experience:CreateTexture(nil, "OVERLAY")
				Resting:SetHeight(28)
				Resting:SetWidth(28)
				Resting:SetPoint("LEFT", -18, 76)
				Resting:SetTexture([=[Interface\CharacterFrame\UI-StateIcon]=])
				Resting:SetTexCoord(0, 0.5, 0, 0.421875)
				self.Resting = Resting
				self.Experience = Experience
			end
			
			-- reputation bar for max level character
			if T.level == MAX_PLAYER_LEVEL then
				local Reputation = CreateFrame("StatusBar", self:GetName().."_Reputation", self)
				Reputation:SetStatusBarTexture(normTex)
				Reputation:SetBackdrop(backdrop)
				Reputation:SetBackdropColor(unpack(C["media"].backdropcolor))
				Reputation:Width(panel:GetWidth() - 4)
				Reputation:Height(panel:GetHeight() - 4)
				Reputation:Point("TOPLEFT", panel, 2, -2)
				Reputation:Point("BOTTOMRIGHT", panel, -2, 2)
				Reputation:SetFrameLevel(10)
				Reputation:SetAlpha(0)

				Reputation:HookScript("OnEnter", function(self) self:SetAlpha(1) end)
				Reputation:HookScript("OnLeave", function(self) self:SetAlpha(0) end)

				Reputation.PostUpdate = T.UpdateReputationColor
				Reputation.Tooltip = true
				self.Reputation = Reputation
			end
			
			-- show druid mana when shapeshifted in bear, cat or whatever
			if T.myclass == "DRUID" then
				local DruidManaUpdate = CreateFrame("Frame")
				DruidManaUpdate:SetScript("OnUpdate", function() T.UpdateDruidManaText(self) end)
				local DruidManaText = T.SetFontString(health, font1, 12)
				DruidManaText:SetTextColor(1, 0.49, 0.04)
				self.DruidManaText = DruidManaText
				
				-- DRUID MANA BAR
				if C.unitframes.druidmanabar then
					local DruidManaBackground = CreateFrame("Frame", nil, self)
					DruidManaBackground:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
					if T.lowversion then
						DruidManaBackground:Size(186, 8)
					else
						DruidManaBackground:Size(250, 8)
					end
				
					DruidManaBackground:SetFrameLevel(8)
					DruidManaBackground:SetFrameStrata("MEDIUM")
					DruidManaBackground:SetBackdrop(backdrop)
					DruidManaBackground:SetBackdropColor(0, 0, 0)
					DruidManaBackground:SetBackdropBorderColor(0,0,0,0)
					DruidManaBackground.bg = DruidManaBackground:CreateTexture(nil, 'ARTWORK')
					DruidManaBackground.bg:SetAllPoints()
					DruidManaBackground.bg:SetAlpha(.20)
					DruidManaBackground.bg:SetTexture(.30, .52, .90)
					
					local DruidManaBarStatus = CreateFrame("StatusBar", nil, DruidManaBackground)
					DruidManaBarStatus:SetPoint("LEFT", DruidManaBackground, "LEFT", 0, 0)
					DruidManaBarStatus:SetSize(DruidManaBackground:GetWidth(), DruidManaBackground:GetHeight())
					DruidManaBarStatus:SetStatusBarTexture(normTex)
					DruidManaBarStatus:SetStatusBarColor(.30, .52, .90)
					
					DruidManaBarStatus:SetScript("OnShow", function() T.DruidBarDisplay(self, false) end)
					DruidManaBarStatus:SetScript("OnUpdate", function() T.DruidBarDisplay(self, true) end) -- just forcing 1 update on login for buffs/shadow/etc.
					DruidManaBarStatus:SetScript("OnHide", function() T.DruidBarDisplay(self, false) end)
					
					self.DruidManaBackground = DruidManaBackground
					self.DruidMana = DruidManaBarStatus
				end
				
				if C.unitframes.druidmushroombar then	
					local m = CreateFrame("Frame", "TukuiWildMushroomBar", self)
					m:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
					m:SetWidth((T.lowversion and 186) or 250)
					m:SetHeight(8)
					m:SetBackdrop(backdrop)
					m:SetBackdropColor(0, 0, 0)
					m:SetBackdropBorderColor(0, 0, 0)
					
					for i = 1, 3 do
						m[i] = CreateFrame("StatusBar", "TukuiWildMushroomBar"..i, m)
						m[i]:Height(8)
						m[i]:SetStatusBarTexture(C.media.normTex)
						
						if i == 1 then
							if T.lowversion then
								m[i]:Width((186 / 3))
							else
								m[i]:Width((250 / 3) - 1)
							end
							m[i]:SetPoint("LEFT", m, "LEFT", 0, 0)
						else
							if T.lowversion then
								m[i]:Width((186 / 3) - 1)
							else
								m[i]:Width((250 / 3))
							end
							m[i]:SetPoint("LEFT", m[i-1], "RIGHT", 1, 0)
						end
						m[i].bg = m[i]:CreateTexture(nil, 'ARTWORK')
					end
					
					m:SetScript("OnShow", T.UpdateMushroomVisibility)
					m:SetScript("OnHide", T.UpdateMushroomVisibility)

					self.WildMushroom = m
				end
			end
			
			-- mage
			if C.unitframes.mageclassbar and T.myclass == "MAGE" then
				self.shadow:Point("TOPLEFT", -4, 12)
				
				local mb = CreateFrame("Frame", "TukuiArcaneBar", self)
				mb:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
				mb:SetWidth((T.lowversion and 186) or 250)
				mb:SetHeight(8)
				mb:SetBackdrop(backdrop)
				mb:SetBackdropColor(0, 0, 0)
				mb:SetBackdropBorderColor(0, 0, 0)				
				
				for i = 1, 6 do
					mb[i] = CreateFrame("StatusBar", "TukuiArcaneBar"..i, mb)
					mb[i]:Height(8)
					mb[i]:SetStatusBarTexture(C.media.normTex)
					
					if i == 1 then
						if T.lowversion then
							mb[i]:Width((186 / 6))
						else
							mb[i]:Width((250 / 6) - 2)
						end
						mb[i]:SetPoint("LEFT", mb, "LEFT", 0, 0)
					else
						if T.lowversion then
							mb[i]:Width((186 / 6) - 1)
						else
							mb[i]:Width((250 / 6 - 1))
						end
						mb[i]:SetPoint("LEFT", mb[i-1], "RIGHT", 1, 0)
					end
					
					mb[i].bg = mb[i]:CreateTexture(nil, 'ARTWORK')
				end
				
				mb:SetScript("OnShow", function(self) 
					local f = self:GetParent()
					f.shadow:Point("TOPLEFT", -4, 12)
				end)
				
				mb:SetScript("OnHide", function(self)
					local f = self:GetParent()
					f.shadow:Point("TOPLEFT", -4, 4)
				end)
				
				self.ArcaneChargeBar = mb
			end
			
			if C.unitframes.classbar then
				if T.myclass == "DRUID" then
					-- ECLIPSE BAR
					local eclipseBar = CreateFrame("Frame", nil, self)
					eclipseBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
					if T.lowversion then
						eclipseBar:Size(186, 8)
					else
						eclipseBar:Size(250, 8)
					end
					eclipseBar:SetFrameStrata("MEDIUM")
					eclipseBar:SetFrameLevel(8)
					eclipseBar:SetBackdrop(backdrop)
					eclipseBar:SetBackdropColor(0, 0, 0)
					eclipseBar:SetBackdropBorderColor(0,0,0,0)
					eclipseBar:SetScript("OnShow", function() T.DruidBarDisplay(self, false) end)
					eclipseBar:SetScript("OnHide", function() T.DruidBarDisplay(self, false) end)
					
					local lunarBar = CreateFrame("StatusBar", nil, eclipseBar)
					lunarBar:SetPoint("LEFT", eclipseBar, "LEFT", 0, 0)
					lunarBar:SetSize(eclipseBar:GetWidth(), eclipseBar:GetHeight())
					lunarBar:SetStatusBarTexture(normTex)
					lunarBar:SetStatusBarColor(.50, .52, .70)
					eclipseBar.LunarBar = lunarBar

					local solarBar = CreateFrame("StatusBar", nil, eclipseBar)
					solarBar:SetPoint("LEFT", lunarBar:GetStatusBarTexture(), "RIGHT", 0, 0)
					solarBar:SetSize(eclipseBar:GetWidth(), eclipseBar:GetHeight())
					solarBar:SetStatusBarTexture(normTex)
					solarBar:SetStatusBarColor(.80, .82,  .60)
					eclipseBar.SolarBar = solarBar

					local eclipseBarText = eclipseBar:CreateFontString(nil, "OVERLAY")
					eclipseBarText:SetPoint("TOP", panel)
					eclipseBarText:SetPoint("BOTTOM", panel)
					eclipseBarText:SetFont(font1, 12)
					eclipseBar.PostUpdatePower = T.EclipseDirection
					
					-- hide "low mana" text on load if eclipseBar is show
					if eclipseBar and eclipseBar:IsShown() then FlashInfo.ManaLevel:SetAlpha(0) end

					self.EclipseBar = eclipseBar
					self.EclipseBar.Text = eclipseBarText
				end
				
				if T.myclass == "WARLOCK" then
					self.shadow:Point("TOPLEFT", -4, 12)
					
					local wb = CreateFrame("Frame", "TukuiWarlockSpecBars", self)
					wb:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
					wb:SetWidth((T.lowversion and 186) or 250)
					wb:SetHeight(8)
					wb:SetBackdrop(backdrop)
					wb:SetBackdropColor(0, 0, 0)
					wb:SetBackdropBorderColor(0, 0, 0)	
					
					for i = 1, 4 do
						wb[i] = CreateFrame("StatusBar", "TukuiWarlockSpecBars"..i, wb)
						wb[i]:Height(8)
						wb[i]:SetStatusBarTexture(C.media.normTex)
						
						if i == 1 then
							if T.lowversion then
								wb[i]:Width((186 / 4) - 2)
							else
								wb[i]:Width((250 / 4) - 2)
							end
							wb[i]:SetPoint("LEFT", wb, "LEFT", 0, 0)
						else
							if T.lowversion then
								wb[i]:Width((186 / 4) - 1)
							else
								wb[i]:Width((250 / 4) - 1)
							end
							wb[i]:SetPoint("LEFT", wb[i-1], "RIGHT", 1, 0)
						end
						
						wb[i].bg = wb[i]:CreateTexture(nil, 'ARTWORK')
					end
					
					wb:SetScript("OnShow", function(self) 
						local f = self:GetParent()
						f.shadow:Point("TOPLEFT", -4, 12)
					end)
					
					wb:SetScript("OnHide", function(self)
						local f = self:GetParent()
						f.shadow:Point("TOPLEFT", -4, 4)
					end)
					
					self.WarlockSpecBars = wb				
				end
				
				-- set holy power bar or shard bar
				if (T.myclass == "PALADIN") then
					self.shadow:Point("TOPLEFT", -4, 11)
		
					local bars = CreateFrame("Frame", nil, self)
					bars:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
					if T.lowversion then
						bars:Width(186)
					else
						bars:Width(250)
					end
					bars:Height(8)
					bars:SetBackdrop(backdrop)
					bars:SetBackdropColor(0, 0, 0)
					bars:SetBackdropBorderColor(0,0,0,0)
					
					for i = 1, 5 do					
						bars[i]=CreateFrame("StatusBar", self:GetName().."_Shard"..i, bars)
						bars[i]:Height(8)					
						bars[i]:SetStatusBarTexture(normTex)
						bars[i]:GetStatusBarTexture():SetHorizTile(false)

						bars[i].bg = bars[i]:CreateTexture(nil, "BORDER")

						bars[i]:SetStatusBarColor(228/255,225/255,16/255)
						bars[i].bg:SetTexture(228/255,225/255,16/255)
						
						if i == 1 then
							bars[i]:SetPoint("LEFT", bars)
							if T.lowversion then
								bars[i]:Width(38)
							else
								bars[i]:Width(50)
							end
							bars[i].bg:SetAllPoints(bars[i])
						else
							bars[i]:Point("LEFT", bars[i-1], "RIGHT", 1, 0)
							if T.lowversion then
								bars[i]:Width(36)
							else
								bars[i]:Width(49)
							end
							bars[i].bg:SetAllPoints(bars[i])
						end
						
						bars[i].bg:SetTexture(normTex)					
						bars[i].bg:SetAlpha(.15)
						bars[i].width = bars[i]:GetWidth()
					end
					
					bars.Override = T.UpdateHoly
					self.HolyPower = bars
				end

				-- deathknight runes
				if T.myclass == "DEATHKNIGHT" then
					-- rescale top shadow border
					self.shadow:Point("TOPLEFT", -4, 12)
					
					local Runes = CreateFrame("Frame", nil, self)
					Runes:Point("BOTTOMLEFT", self, "TOPLEFT", 0,1)
					Runes:Height(8)
					if T.lowversion then
						Runes:SetWidth(186)
					else
						Runes:SetWidth(250)
					end
					Runes:SetBackdrop(backdrop)
					Runes:SetBackdropColor(0, 0, 0)

					for i = 1, 6 do
						Runes[i] = CreateFrame("StatusBar", self:GetName().."_Runes"..i, Runes)
						Runes[i]:SetHeight(8)
						if T.lowversion then
							if i == 1 then
								Runes[i]:SetWidth(31)
							else
								Runes[i]:SetWidth(30)
							end
						else
							if i == 1 then
								Runes[i]:SetWidth(40)
							else
								Runes[i]:SetWidth(41)
							end
						end
						if (i == 1) then
							Runes[i]:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
						else
							Runes[i]:Point("TOPLEFT", Runes[i-1], "TOPRIGHT", 1, 0)
						end
						Runes[i]:SetStatusBarTexture(normTex)
						Runes[i]:GetStatusBarTexture():SetHorizTile(false)
					end

					self.Runes = Runes
				end
				
				if T.myclass == "WARRIOR" then
					-- statue bar
					local bar = CreateFrame("StatusBar", "TukuiStatueBar", self)
					bar:SetWidth((T.lowversion and 186) or 250)
					bar:SetHeight(8)
					bar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
					bar:SetStatusBarTexture(C.media.normTex)
					bar.bg = bar:CreateTexture(nil, 'ARTWORK')
					
					bar.background = CreateFrame("Frame", "TukuiStatue", bar)
					bar.background:SetAllPoints()
					bar.background:SetFrameLevel(bar:GetFrameLevel() - 1)
					bar.background:SetBackdrop(backdrop)
					bar.background:SetBackdropColor(0, 0, 0)
					bar.background:SetBackdropBorderColor(0,0,0)
					
					bar:SetScript("OnShow", function(self) 
						local f = self:GetParent()
						f.shadow:Point("TOPLEFT", -4, 12)
					end)
					
					bar:SetScript("OnHide", function(self)
						local f = self:GetParent()
						f.shadow:Point("TOPLEFT", -4, 4)
					end)

					self.Statue = bar				
				end
				
				-- Monk harmony bar
				if T.myclass == "MONK" then
					self.shadow:Point("TOPLEFT", -4, 12)
					
					local hb = CreateFrame("Frame", "TukuiHarmony", health)
					hb:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
					hb:SetWidth((T.lowversion and 186) or 250)
					hb:SetHeight(8)
					hb:SetBackdrop(backdrop)
					hb:SetBackdropColor(0, 0, 0)
					hb:SetBackdropBorderColor(0, 0, 0)	
					
					for i = 1, 5 do
						hb[i] = CreateFrame("StatusBar", "TukuiHarmonyBar"..i, hb)
						hb[i]:Height(8)
						hb[i]:SetStatusBarTexture(C.media.normTex)
						
						if i == 1 then
							if T.lowversion then
								hb[i]:Width(186 / 5 + 1)
							else
								hb[i]:Width(250 / 5)
							end
							hb[i]:SetPoint("LEFT", hb, "LEFT", 0, 0)
						else
							if T.lowversion then
								hb[i]:Width((186 / 5) - 1)
							else
								hb[i]:Width((250 / 5) - 1)
							end
							hb[i]:SetPoint("LEFT", hb[i-1], "RIGHT", 1, 0)
						end
					end
					
					self.HarmonyBar = hb
					
					-- statue bar
					local bar = CreateFrame("StatusBar", "TukuiStatueBar", self)
					bar:SetWidth((T.lowversion and 186) or 250)
					bar:SetHeight(8)
					bar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 10)
					bar:SetStatusBarTexture(C.media.normTex)
					bar.bg = bar:CreateTexture(nil, 'ARTWORK')
					
					bar.background = CreateFrame("Frame", "TukuiStatue", bar)
					bar.background:SetAllPoints()
					bar.background:SetFrameLevel(bar:GetFrameLevel() - 1)
					bar.background:SetBackdrop(backdrop)
					bar.background:SetBackdropColor(0, 0, 0)
					bar.background:SetBackdropBorderColor(0,0,0)
					
					bar:SetScript("OnShow", function(self) 
						local f = self:GetParent()
						f.shadow:Point("TOPLEFT", -4, 22)
					end)
					
					bar:SetScript("OnHide", function(self)
						local f = self:GetParent()
						f.shadow:Point("TOPLEFT", -4, 12)
					end)

					self.Statue = bar
				end
				
				-- priest
				if T.myclass == "PRIEST" then
					self.shadow:Point("TOPLEFT", -4, 12)
					
					local pb = CreateFrame("Frame", "TukuiShadowOrbsBar", self)
					pb:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
					pb:SetWidth((T.lowversion and 186) or 250)
					pb:SetHeight(8)
					pb:SetBackdrop(backdrop)
					pb:SetBackdropColor(0, 0, 0)
					pb:SetBackdropBorderColor(0, 0, 0)	
					
					for i = 1, 3 do
						pb[i] = CreateFrame("StatusBar", "TukuiShadowOrbsBar"..i, pb)
						pb[i]:Height(8)
						pb[i]:SetStatusBarTexture(C.media.normTex)
						
						if i == 1 then
							if T.lowversion then
								pb[i]:Width((186 / 3))
							else
								pb[i]:Width((250 / 3) - 1)
							end
							pb[i]:SetPoint("LEFT", pb, "LEFT", 0, 0)
						else
							if T.lowversion then
								pb[i]:Width((186 / 3) - 1)
							else
								pb[i]:Width((250 / 3))
							end
							pb[i]:SetPoint("LEFT", pb[i-1], "RIGHT", 1, 0)
						end
					end
					
					pb:SetScript("OnShow", function(self) 
						local f = self:GetParent()
						f.shadow:Point("TOPLEFT", -4, 12)
					end)
					
					pb:SetScript("OnHide", function(self)
						local f = self:GetParent()
						f.shadow:Point("TOPLEFT", -4, 4)
					end)
					
					self.ShadowOrbsBar = pb
					
					-- statue bar
					local bar = CreateFrame("StatusBar", "TukuiStatueBar", self)
					bar:SetWidth((T.lowversion and 186) or 250)
					bar:SetHeight(8)
					bar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
					bar:SetStatusBarTexture(C.media.normTex)
					bar.bg = bar:CreateTexture(nil, 'ARTWORK')
					
					bar.background = CreateFrame("Frame", "TukuiStatue", bar)
					bar.background:SetAllPoints()
					bar.background:SetFrameLevel(bar:GetFrameLevel() - 1)
					bar.background:SetBackdrop(backdrop)
					bar.background:SetBackdropColor(0, 0, 0)
					bar.background:SetBackdropBorderColor(0,0,0)
					
					bar:SetScript("OnShow", function(self) 
						local f = self:GetParent()
						f.shadow:Point("TOPLEFT", -4, 12)
					end)
					
					bar:SetScript("OnHide", function(self)
						local f = self:GetParent()
						f.shadow:Point("TOPLEFT", -4, 4)
					end)

					self.Statue = bar
				end
				
				-- shaman totem bar
				if T.myclass == "SHAMAN" then
					-- rescale top shadow border
					self.shadow:Point("TOPLEFT", -4, 12)
					
					local TotemBar = {}
					TotemBar.Destroy = true
					for i = 1, 4 do
						TotemBar[i] = CreateFrame("StatusBar", self:GetName().."_TotemBar"..i, self)
						-- a totem "slot" in the default ui doesn"t necessarily correspond to its place on the screen.
						-- for example, on the default totem action bar frame, the first totem is earth, but earth"s
						-- slot id is two according to Blizzard default slotID!
						-- we want to match action bar so we fix them by moving status bar around.
						local fixme
						if (i == 2) then
							TotemBar[i]:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
						elseif i == 1 then
							fixme = 62
							if T.lowversion then fixme = 46 end
							TotemBar[i]:Point("BOTTOMLEFT", self, "TOPLEFT", fixme + 1, 1)
						else
							fixme = i
							if i == 3 then fixme = i-1 end
							TotemBar[i]:Point("TOPLEFT", TotemBar[fixme-1], "TOPRIGHT", 1, 0)
						end
						TotemBar[i]:SetStatusBarTexture(normTex)
						TotemBar[i]:Height(8)
						if T.lowversion then
							if i == 1 then
								TotemBar[i]:SetWidth(45)
							else
								TotemBar[i]:SetWidth(46)
							end
						else
							if i == 4 then
								TotemBar[i]:SetWidth(61)
							else
								TotemBar[i]:SetWidth(62)
							end
						end
						TotemBar[i]:SetBackdrop(backdrop)
						TotemBar[i]:SetBackdropColor(0, 0, 0)
						TotemBar[i]:SetMinMaxValues(0, 1)

						TotemBar[i].bg = TotemBar[i]:CreateTexture(nil, "BORDER")
						TotemBar[i].bg:SetAllPoints(TotemBar[i])
						TotemBar[i].bg:SetTexture(normTex)
						TotemBar[i].bg.multiplier = 0.3
					end
					self.TotemBar = TotemBar
				end
				
				-- script for pvp status and low mana
				self:SetScript("OnEnter", function(self)
					if self.EclipseBar and self.EclipseBar:IsShown() then 
						self.EclipseBar.Text:Hide()
					end
					FlashInfo.ManaLevel:Hide()
					status:Show()
					UnitFrame_OnEnter(self) 
					if UnitIsPVP("Player") then
						status:SetText("PvP")
					else
						status:SetText("")
					end
				end)
				self:SetScript("OnLeave", function(self) 
					if self.EclipseBar and self.EclipseBar:IsShown() then 
						self.EclipseBar.Text:Show()
					end
					FlashInfo.ManaLevel:Show()
					status:Hide()
					UnitFrame_OnLeave(self) 
				end)
			end
		end
		
		if (unit == "target") then			
			-- Unit name on target
			local Name = health:CreateFontString(nil, "OVERLAY")
			Name:Point("LEFT", panel, "LEFT", 4, 0)
			Name:SetJustifyH("LEFT")
			Name:SetFont(font1, 12)

			self:Tag(Name, "[Tukui:getnamecolor][Tukui:namelong] [Tukui:diffcolor][level] [shortclassification]")
			self.Name = Name
		end
			
		-- standard combo points on target if combo plugin is disabled
		if C["unitframes"].classiccombo and unit == "target" then
			local CPoints = {}
			CPoints.unit = PlayerFrame.unit
			for i = 1, 5 do
				CPoints[i] = self:CreateTexture(nil, "OVERLAY")
				CPoints[i]:Height(12)
				CPoints[i]:Width(12)
				CPoints[i]:SetTexture(bubbleTex)
				if i == 1 then
					if T.lowversion then
						CPoints[i]:Point("TOPRIGHT", 15, 1.5)
					else
						CPoints[i]:Point("TOPLEFT", -15, 1.5)
					end
					CPoints[i]:SetVertexColor(0.69, 0.31, 0.31)
				else
					CPoints[i]:Point("TOP", CPoints[i-1], "BOTTOM", 1)
				end
			end
			CPoints[2]:SetVertexColor(0.69, 0.31, 0.31)
			CPoints[3]:SetVertexColor(0.65, 0.63, 0.35)
			CPoints[4]:SetVertexColor(0.65, 0.63, 0.35)
			CPoints[5]:SetVertexColor(0.33, 0.59, 0.33)
			self.CPoints = CPoints
		else
			if (unit == "target" and T.myclass ~= "ROGUE") or (T.myclass == "ROGUE" and C.unitframes.movecombobar and unit == "player") or (T.myclass == "ROGUE" and not C.unitframes.movecombobar and unit == "target") then
				local CP = CreateFrame("Frame", "TukuiCombo", self)
				CP:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
				CP:Width(T.lowversion and 186 or 250)
				CP:Height(8)
				CP:SetBackdrop(backdrop)
				CP:SetBackdropColor(0, 0, 0)
				CP:SetBackdropBorderColor(unpack(C.media.backdropcolor))
				CP.PostUpdate = T.ComboPointsBarUpdate

				for i = 1, 5 do
					CP[i] = CreateFrame("StatusBar", "TukuiComboBar"..i, CP)
					CP[i]:Height(8)
					CP[i]:SetStatusBarTexture(normTex)
					
					if i == 1 then
						CP[i]:Point("LEFT", CP, "LEFT", 0, 0)
						if T.lowversion then CP[i]:Width(186 / 5 + 1) else CP[i]:Width(250 / 5) end
					else
						CP[i]:Point("LEFT", CP[i-1], "RIGHT", 1, 0)
						if T.lowversion then CP[i]:Width(186 / 5 - 1) else CP[i]:Width(250 / 5 - 1) end
					end					
				end
				
				self.ComboPointsBar = CP
			end
		end

		if (unit == "target" and C["unitframes"].targetauras) then
			local buffs = CreateFrame("Frame", nil, self)
			local debuffs = CreateFrame("Frame", nil, self)

			
			buffs:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 4)
			
			if T.lowversion then
				buffs:SetHeight(21.5)
				buffs:SetWidth(186)
				buffs.size = 21.5
				buffs.num = 32
				buffs.numRow = 8
				
				debuffs:SetHeight(21.5)
				debuffs:SetWidth(186)
				debuffs:SetPoint("BOTTOMLEFT", buffs, "TOPLEFT", 0, 2)
				debuffs.size = 21.5	
				debuffs.num = 32
			else				
				buffs:SetHeight(26)
				buffs:SetWidth(252)
				buffs.size = 26
				buffs.num = 36
				buffs.numRow = 9
				
				debuffs:SetHeight(26)
				debuffs:SetWidth(252)
				debuffs:SetPoint("BOTTOMLEFT", buffs, "TOPLEFT", -2, 2)
				debuffs.size = 26
				debuffs.num = 36
			end
						
			buffs.spacing = 2
			buffs.initialAnchor = "TOPLEFT"
			buffs.PostCreateIcon = T.PostCreateAura
			buffs.PostUpdateIcon = T.PostUpdateAura
			buffs.PostUpdate = T.UpdateTargetDebuffsHeader
			self.Buffs = buffs	
						
			debuffs.spacing = 2
			debuffs.initialAnchor = "TOPRIGHT"
			debuffs["growth-y"] = "UP"
			debuffs["growth-x"] = "LEFT"
			debuffs.PostCreateIcon = T.PostCreateAura
			debuffs.PostUpdateIcon = T.PostUpdateAura		
			
			-- an option to show only our debuffs on target
			if unit == "target" then
				debuffs.onlyShowPlayer = C.unitframes.onlyselfdebuffs
			end
			
			self.Debuffs = debuffs
		end
		
		-- cast bar for player and target
		if (C["unitframes"].unitcastbar == true) then
			-- castbar of player and target
			local castbar = CreateFrame("StatusBar", self:GetName().."CastBar", self)
			castbar:SetStatusBarTexture(normTex)
			
			castbar.bg = castbar:CreateTexture(nil, "BORDER")
			castbar.bg:SetAllPoints(castbar)
			castbar.bg:SetTexture(normTex)
			castbar.bg:SetVertexColor(0.15, 0.15, 0.15)
			castbar:SetFrameLevel(6)
			castbar:Point("TOPLEFT", panel, 2, -2)
			castbar:Point("BOTTOMRIGHT", panel, -2, 2)
			
			castbar.CustomTimeText = T.CustomCastTimeText
			castbar.CustomDelayText = T.CustomCastDelayText
			castbar.PostCastStart = T.CheckCast
			castbar.PostChannelStart = T.CheckChannel

			castbar.time = T.SetFontString(castbar, font1, 12)
			castbar.time:Point("RIGHT", panel, "RIGHT", -4, 0)
			castbar.time:SetTextColor(0.84, 0.75, 0.65)
			castbar.time:SetJustifyH("RIGHT")

			castbar.Text = T.SetFontString(castbar, font1, 12)
			castbar.Text:Point("LEFT", panel, "LEFT", 4, 0)
			castbar.Text:SetTextColor(0.84, 0.75, 0.65)
			
			if C["unitframes"].cbicons == true then
				castbar.button = CreateFrame("Frame", nil, castbar)
				castbar.button:Size(26)
				castbar.button:SetTemplate("Default")
				castbar.button:CreateShadow("Default")

				castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
				castbar.icon:Point("TOPLEFT", castbar.button, 2, -2)
				castbar.icon:Point("BOTTOMRIGHT", castbar.button, -2, 2)
				castbar.icon:SetTexCoord(0.08, 0.92, 0.08, .92)
			
				if unit == "player" then
					if C["unitframes"].charportrait == true then
						castbar.button:SetPoint("LEFT", -82.5, 26.5)
					else
						castbar.button:SetPoint("LEFT", -46.5, 26.5)
					end
				elseif unit == "target" then
					if C["unitframes"].charportrait == true then
						castbar.button:SetPoint("RIGHT", 82.5, 26.5)
					else
						castbar.button:SetPoint("RIGHT", 46.5, 26.5)
					end					
				end
			end
			
			-- cast bar latency on player
			if unit == "player" and C["unitframes"].cblatency == true then
				castbar.safezone = castbar:CreateTexture(nil, "ARTWORK")
				castbar.safezone:SetTexture(normTex)
				castbar.safezone:SetVertexColor(0.69, 0.31, 0.31, 0.75)
				castbar.SafeZone = castbar.safezone
			end
					
			self.Castbar = castbar
			self.Castbar.Time = castbar.time
			self.Castbar.Icon = castbar.icon
		end
		
		-- add combat feedback support
		if C["unitframes"].combatfeedback == true then
			local CombatFeedbackText 
			if T.lowversion then
				CombatFeedbackText = T.SetFontString(health, font1, 12, "OUTLINE")
			else
				CombatFeedbackText = T.SetFontString(health, font1, 14, "OUTLINE")
			end
			CombatFeedbackText:SetPoint("CENTER", 0, 1)
			CombatFeedbackText.colors = {
				DAMAGE = {0.69, 0.31, 0.31},
				CRUSHING = {0.69, 0.31, 0.31},
				CRITICAL = {0.69, 0.31, 0.31},
				GLANCING = {0.69, 0.31, 0.31},
				STANDARD = {0.84, 0.75, 0.65},
				IMMUNE = {0.84, 0.75, 0.65},
				ABSORB = {0.84, 0.75, 0.65},
				BLOCK = {0.84, 0.75, 0.65},
				RESIST = {0.84, 0.75, 0.65},
				MISS = {0.84, 0.75, 0.65},
				HEAL = {0.33, 0.59, 0.33},
				CRITHEAL = {0.33, 0.59, 0.33},
				ENERGIZE = {0.31, 0.45, 0.63},
				CRITENERGIZE = {0.31, 0.45, 0.63},
			}
			self.CombatFeedbackText = CombatFeedbackText
		end
		
		if C["unitframes"].healcomm then
			local mhpb = CreateFrame("StatusBar", nil, self.Health)
			mhpb:SetPoint("TOPLEFT", self.Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
			mhpb:SetPoint("BOTTOMLEFT", self.Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
			if T.lowversion then
				mhpb:SetWidth(186)
			else
				mhpb:SetWidth(250)
			end
			mhpb:SetStatusBarTexture(normTex)
			mhpb:SetStatusBarColor(0, 1, 0.5, 0.25)
			mhpb:SetMinMaxValues(0,1)

			local ohpb = CreateFrame("StatusBar", nil, self.Health)
			ohpb:SetPoint("TOPLEFT", mhpb:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
			ohpb:SetPoint("BOTTOMLEFT", mhpb:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
			ohpb:SetWidth(250)
			ohpb:SetStatusBarTexture(normTex)
			ohpb:SetStatusBarColor(0, 1, 0, 0.25)

			self.HealPrediction = {
				myBar = mhpb,
				otherBar = ohpb,
				maxOverflow = 1,
			}
		end
		
		-- player aggro
		if C["unitframes"].playeraggro == true then
			table.insert(self.__elements, T.UpdateThreat)
			self:RegisterEvent("PLAYER_TARGET_CHANGED", T.UpdateThreat)
			self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", T.UpdateThreat)
			self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", T.UpdateThreat)
		end
	end
	
	------------------------------------------------------------------------
	--	Target of Target unit layout
	------------------------------------------------------------------------
	
	if (unit == "targettarget") then
		-- create panel if higher version
		local panel = CreateFrame("Frame", nil, self)
		if not T.lowversion then
			panel:SetTemplate()
			panel:Size(129, 17)
			panel:Point("BOTTOM", self, "BOTTOM", 0, T.Scale(0))
			panel:SetFrameLevel(2)
			panel:SetFrameStrata("MEDIUM")
			panel:SetBackdropBorderColor(bdcr * 0.7, bdcg * 0.7, bdcb * 0.7)
			self.panel = panel
		end
		
		-- health bar
		local health = CreateFrame("StatusBar", nil, self)
		health:Height(18)
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)
		
		local healthBG = health:CreateTexture(nil, "BORDER")
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
		
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if C["unitframes"].showsmooth == true then
			health.Smooth = true
		end
		
		if C["unitframes"].unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.3, .3, .3, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true			
		end
		
		-- Unit name
		local Name = health:CreateFontString(nil, "OVERLAY")
		if T.lowversion then
			Name:SetPoint("CENTER", health, "CENTER", 0, 0)
			Name:SetFont(font1, 12, "OUTLINE")
		else
			Name:SetPoint("CENTER", panel, "CENTER", 0, 0)
			Name:SetFont(font1, 12)
		end
		Name:SetJustifyH("CENTER")

		self:Tag(Name, "[Tukui:getnamecolor][Tukui:namemedium]")
		self.Name = Name
		
		if C["unitframes"].totdebuffs == true and T.lowversion ~= true then
			local debuffs = CreateFrame("Frame", nil, health)
			debuffs:SetHeight(20)
			debuffs:SetWidth(127)
			debuffs.size = 20
			debuffs.spacing = 2
			debuffs.num = 6

			debuffs:SetPoint("TOPLEFT", health, "TOPLEFT", -0.5, 24)
			debuffs.initialAnchor = "TOPLEFT"
			debuffs["growth-y"] = "UP"
			debuffs.PostCreateIcon = T.PostCreateAura
			debuffs.PostUpdateIcon = T.PostUpdateAura
			self.Debuffs = debuffs
		end
	end
	
	------------------------------------------------------------------------
	--	Pet unit layout
	------------------------------------------------------------------------
	
	if (unit == "pet") then
		-- create panel if higher version
		local panel = CreateFrame("Frame", nil, self)
		if not T.lowversion then
			panel:SetTemplate()
			panel:Size(129, 17)
			panel:Point("BOTTOM", self, "BOTTOM", 0, 0)
			panel:SetFrameLevel(2)
			panel:SetFrameStrata("MEDIUM")
			panel:SetBackdropBorderColor(bdcr * 0.7, bdcg * 0.7, bdcb * 0.7)
			self.panel = panel
		end
		
		-- health bar
		local health = CreateFrame("StatusBar", nil, self)
		health:Height(13)
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)
		
		health.PostUpdate = T.PostUpdatePetColor
				
		self.Health = health
		
		local healthBG = health:CreateTexture(nil, "BORDER")
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
		
		health.frequentUpdates = true
		if C["unitframes"].showsmooth == true then
			health.Smooth = true
		end
		
		if C["unitframes"].unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.3, .3, .3, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true	
			health.colorClass = true
			health.colorReaction = true	
			if T.myclass == "HUNTER" then
				health.colorHappiness = true
			end
		end
		
		self.Health.bg = healthBG
		
		-- power
		local power = CreateFrame("StatusBar", nil, self)
		power:Height(4)
		power:Point("TOPLEFT", health, "BOTTOMLEFT", 0, -1)
		power:Point("TOPRIGHT", health, "BOTTOMRIGHT", 0, -1)
		power:SetStatusBarTexture(normTex)
		
		power.frequentUpdates = true
		power.colorPower = true
		if C["unitframes"].showsmooth == true then
			power.Smooth = true
		end

		local powerBG = power:CreateTexture(nil, "BORDER")
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(normTex)
		powerBG.multiplier = 0.3
				
		self.Power = power
		self.Power.bg = powerBG
				
		-- Unit name
		local Name = health:CreateFontString(nil, "OVERLAY")
		if T.lowversion then
			Name:SetPoint("CENTER", self, "CENTER", 0, 0)
			Name:SetFont(font1, 12, "OUTLINE")
		else
			Name:SetPoint("CENTER", panel, "CENTER", 0, 0)
			Name:SetFont(font1, 12)
		end
		Name:SetJustifyH("CENTER")

		self:Tag(Name, "[Tukui:getnamecolor][Tukui:namemedium] [Tukui:diffcolor][level]")
		self.Name = Name
		
		if (C["unitframes"].unitcastbar == true) then
			local castbar = CreateFrame("StatusBar", self:GetName().."CastBar", self)
			castbar:SetStatusBarTexture(normTex)
			self.Castbar = castbar
			
			if not T.lowversion then
				castbar.bg = castbar:CreateTexture(nil, "BORDER")
				castbar.bg:SetAllPoints(castbar)
				castbar.bg:SetTexture(normTex)
				castbar.bg:SetVertexColor(0.15, 0.15, 0.15)
				castbar:SetFrameLevel(6)
				castbar:Point("TOPLEFT", panel, 2, -2)
				castbar:Point("BOTTOMRIGHT", panel, -2, 2)
				
				castbar.CustomTimeText = T.CustomCastTimeText
				castbar.CustomDelayText = T.CustomCastDelayText
				castbar.PostCastStart = T.CheckCast
				castbar.PostChannelStart = T.CheckChannel

				castbar.time = T.SetFontString(castbar, font1, 12)
				castbar.time:Point("RIGHT", panel, "RIGHT", -4, 0)
				castbar.time:SetTextColor(0.84, 0.75, 0.65)
				castbar.time:SetJustifyH("RIGHT")

				castbar.Text = T.SetFontString(castbar, font1, 12)
				castbar.Text:Point("LEFT", panel, "LEFT", 4, 0)
				castbar.Text:SetTextColor(0.84, 0.75, 0.65)
				
				self.Castbar.Time = castbar.time
			end
		end
		
		-- update pet name, this should fix "UNKNOWN" pet names on pet unit, health and bar color sometime being "grayish".
		self:RegisterEvent("UNIT_PET", T.updateAllElements)
	end


	------------------------------------------------------------------------
	--	Focus unit layout
	------------------------------------------------------------------------
	
	if (unit == "focus") then
		-- health 
		local health = CreateFrame("StatusBar", nil, self)
		health:Height(22)
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)

		health.frequentUpdates = true
		health.colorDisconnected = true
		if C["unitframes"].showsmooth == true then
			health.Smooth = true
		end
		health.colorClass = true
		
		local healthBG = health:CreateTexture(nil, "BORDER")
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)

		health.value = T.SetFontString(health, font1,12, "OUTLINE")
		health.value:Point("LEFT", 2, 0)
		health.PostUpdate = T.PostUpdateHealth
				
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if C["unitframes"].showsmooth == true then
			health.Smooth = true
		end
		
		if C["unitframes"].unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.3, .3, .3, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true	
		end
	
		-- power
		local power = CreateFrame("StatusBar", nil, self)
		power:Height(6)
		power:Point("TOPLEFT", health, "BOTTOMLEFT", 0, -1)
		power:Point("TOPRIGHT", health, "BOTTOMRIGHT", 0, -1)
		power:SetStatusBarTexture(normTex)
		
		power.frequentUpdates = true
		power.colorPower = true
		if C["unitframes"].showsmooth == true then
			power.Smooth = true
		end

		local powerBG = power:CreateTexture(nil, "BORDER")
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(normTex)
		powerBG.multiplier = 0.3
		
		power.value = T.SetFontString(health, font1, 12, "OUTLINE")
		power.value:Point("RIGHT", -2, 0)
		power.PreUpdate = T.PreUpdatePower
		power.PostUpdate = T.PostUpdatePower
				
		self.Power = power
		self.Power.bg = powerBG
		
		-- names
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", health, "CENTER", 0, 0)
		Name:SetJustifyH("CENTER")
		Name:SetFont(font1, 12, "OUTLINE")
		Name:SetShadowColor(0, 0, 0)
		Name:SetShadowOffset(1.25, -1.25)
		
		self:Tag(Name, "[Tukui:getnamecolor][Tukui:namelong]")
		self.Name = Name

		-- create debuff for arena units
		local debuffs = CreateFrame("Frame", nil, self)
		debuffs:SetHeight(26)
		debuffs:SetWidth(200)
		debuffs:Point("RIGHT", self, "LEFT", -4, 0)
		debuffs.size = 26
		debuffs.num = 5
		debuffs.spacing = 2
		debuffs.initialAnchor = "RIGHT"
		debuffs["growth-x"] = "LEFT"
		debuffs.PostCreateIcon = T.PostCreateAura
		debuffs.PostUpdateIcon = T.PostUpdateAura
		self.Debuffs = debuffs
		
		if (C["unitframes"].unitcastbar == true) then		
			local castbar = CreateFrame("StatusBar", self:GetName().."CastBar", self)
			castbar:SetPoint("LEFT", 2, 0)
			castbar:SetPoint("RIGHT", -24, 0)
			castbar:SetPoint("BOTTOM", 0, -22)
			
			castbar:SetHeight(16)
			castbar:SetStatusBarTexture(normTex)
			castbar:SetFrameLevel(6)
			
			castbar.bg = CreateFrame("Frame", nil, castbar)
			castbar.bg:SetTemplate("Default")
			castbar.bg:SetBackdropBorderColor(bdcr * 0.7, bdcg * 0.7, bdcb * 0.7)
			castbar.bg:Point("TOPLEFT", -2, 2)
			castbar.bg:Point("BOTTOMRIGHT", 2, -2)
			castbar.bg:SetFrameLevel(5)
			
			castbar.time = T.SetFontString(castbar, font1, 12)
			castbar.time:Point("RIGHT", castbar, "RIGHT", -4, 0)
			castbar.time:SetTextColor(0.84, 0.75, 0.65)
			castbar.time:SetJustifyH("RIGHT")
			castbar.CustomTimeText = T.CustomCastTimeText

			castbar.Text = T.SetFontString(castbar, font1, 12)
			castbar.Text:SetPoint("LEFT", castbar, "LEFT", 4, 0)
			castbar.Text:SetTextColor(0.84, 0.75, 0.65)
			
			castbar.CustomDelayText = T.CustomCastDelayText
			castbar.PostCastStart = T.CheckCast
			castbar.PostChannelStart = T.CheckChannel
									
			castbar.button = CreateFrame("Frame", nil, castbar)
			castbar.button:Height(castbar:GetHeight()+4)
			castbar.button:Width(castbar:GetHeight()+4)
			castbar.button:Point("LEFT", castbar, "RIGHT", 4, 0)
			castbar.button:SetTemplate("Default")
			castbar.button:SetBackdropBorderColor(bdcr * 0.7, bdcg * 0.7, bdcb * 0.7)
			castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
			castbar.icon:Point("TOPLEFT", castbar.button, 2, -2)
			castbar.icon:Point("BOTTOMRIGHT", castbar.button, -2, 2)
			castbar.icon:SetTexCoord(0.08, 0.92, 0.08, .92)

			self.Castbar = castbar
			self.Castbar.Time = castbar.time
			self.Castbar.Icon = castbar.icon
		end
	end
	
	------------------------------------------------------------------------
	--	Focus target unit layout
	------------------------------------------------------------------------

	if (unit == "focustarget") then
		-- health 
		local health = CreateFrame("StatusBar", nil, self)
		health:Height(22)
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)

		health.frequentUpdates = true
		health.colorDisconnected = true
		if C["unitframes"].showsmooth == true then
			health.Smooth = true
		end
		health.colorClass = true
		
		local healthBG = health:CreateTexture(nil, "BORDER")
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)

		health.value = T.SetFontString(health, font1,12, "OUTLINE")
		health.value:Point("LEFT", 2, 0)
		health.PostUpdate = T.PostUpdateHealth
				
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if C["unitframes"].showsmooth == true then
			health.Smooth = true
		end
		
		if C["unitframes"].unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.3, .3, .3, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true	
		end
	
		-- power
		local power = CreateFrame("StatusBar", nil, self)
		power:Height(6)
		power:Point("TOPLEFT", health, "BOTTOMLEFT", 0, -1)
		power:Point("TOPRIGHT", health, "BOTTOMRIGHT", 0, -1)
		power:SetStatusBarTexture(normTex)
		
		power.frequentUpdates = true
		power.colorPower = true
		if C["unitframes"].showsmooth == true then
			power.Smooth = true
		end

		local powerBG = power:CreateTexture(nil, "BORDER")
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(normTex)
		powerBG.multiplier = 0.3
		
		power.value = T.SetFontString(health, font1, 12, "OUTLINE")
		power.value:Point("RIGHT", -2, 0)
		power.PreUpdate = T.PreUpdatePower
		power.PostUpdate = T.PostUpdatePower
				
		self.Power = power
		self.Power.bg = powerBG
		
		-- names
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", health, "CENTER", 0, 0)
		Name:SetJustifyH("CENTER")
		Name:SetFont(font1, 12, "OUTLINE")
		Name:SetShadowColor(0, 0, 0)
		Name:SetShadowOffset(1.25, -1.25)
		
		self:Tag(Name, "[Tukui:getnamecolor][Tukui:namelong]")
		self.Name = Name

		-- create debuff for arena units
		local debuffs = CreateFrame("Frame", nil, self)
		debuffs:SetHeight(26)
		debuffs:SetWidth(200)
		debuffs:Point("RIGHT", self, "LEFT", -4, 0)
		debuffs.size = 26
		debuffs.num = 5
		debuffs.spacing = 2
		debuffs.initialAnchor = "RIGHT"
		debuffs["growth-x"] = "LEFT"
		debuffs.PostCreateIcon = T.PostCreateAura
		debuffs.PostUpdateIcon = T.PostUpdateAura
		self.Debuffs = debuffs
		
		if (C["unitframes"].unitcastbar == true) then
			local castbar = CreateFrame("StatusBar", self:GetName().."CastBar", self)
			castbar:SetPoint("LEFT", 2, 0)
			castbar:SetPoint("RIGHT", -24, 0)
			castbar:SetPoint("BOTTOM", 0, -22)
			
			castbar:SetHeight(16)
			castbar:SetStatusBarTexture(normTex)
			castbar:SetFrameLevel(6)
			
			castbar.bg = CreateFrame("Frame", nil, castbar)
			castbar.bg:SetTemplate("Default")
			castbar.bg:SetBackdropBorderColor(bdcr * 0.7, bdcg * 0.7, bdcb * 0.7)
			castbar.bg:Point("TOPLEFT", -2, 2)
			castbar.bg:Point("BOTTOMRIGHT", 2, -2)
			castbar.bg:SetFrameLevel(5)
			
			castbar.time = T.SetFontString(castbar, font1, 12)
			castbar.time:Point("RIGHT", castbar, "RIGHT", -4, 0)
			castbar.time:SetTextColor(0.84, 0.75, 0.65)
			castbar.time:SetJustifyH("RIGHT")
			castbar.CustomTimeText = T.CustomCastTimeText

			castbar.Text = T.SetFontString(castbar, font1, 12)
			castbar.Text:Point("LEFT", castbar, "LEFT", 4, 0)
			castbar.Text:SetTextColor(0.84, 0.75, 0.65)
			
			castbar.CustomDelayText = T.CustomCastDelayText
			castbar.PostCastStart = T.CheckCast
			castbar.PostChannelStart = T.CheckChannel
									
			castbar.button = CreateFrame("Frame", nil, castbar)
			castbar.button:Height(castbar:GetHeight()+4)
			castbar.button:Width(castbar:GetHeight()+4)
			castbar.button:Point("LEFT", castbar, "RIGHT", 4, 0)
			castbar.button:SetTemplate("Default")
			castbar.button:SetBackdropBorderColor(bdcr * 0.7, bdcg * 0.7, bdcb * 0.7)
			castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
			castbar.icon:Point("TOPLEFT", castbar.button, 2, -2)
			castbar.icon:Point("BOTTOMRIGHT", castbar.button, -2, 2)
			castbar.icon:SetTexCoord(0.08, 0.92, 0.08, .92)

			self.Castbar = castbar
			self.Castbar.Time = castbar.time
			self.Castbar.Icon = castbar.icon
		end
	end

	------------------------------------------------------------------------
	--	Arena or boss units layout (both mirror"d)
	------------------------------------------------------------------------
	
	if (unit and unit:find("arena%d") and C["unitframes"].arena == true) or (unit and unit:find("boss%d") and C["unitframes"].showboss == true) then
		-- Right-click focus on arena or boss units
		self:SetAttribute("type2", "focus")
		
		-- health 
		local health = CreateFrame("StatusBar", nil, self)
		health:Height(22)
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)

		health.frequentUpdates = true
		health.colorDisconnected = true
		if C["unitframes"].showsmooth == true then
			health.Smooth = true
		end
		health.colorClass = true
		
		local healthBG = health:CreateTexture(nil, "BORDER")
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)

		health.value = T.SetFontString(health, font1,12, "OUTLINE")
		health.value:Point("LEFT", 2, 0)
		health.PostUpdate = T.PostUpdateHealth
				
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if C["unitframes"].showsmooth == true then
			health.Smooth = true
		end
		
		if C["unitframes"].unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.3, .3, .3, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true	
		end
	
		-- power
		local power = CreateFrame("StatusBar", nil, self)
		power:Height(6)
		power:Point("TOPLEFT", health, "BOTTOMLEFT", 0, -1)
		power:Point("TOPRIGHT", health, "BOTTOMRIGHT", 0, -1)
		power:SetStatusBarTexture(normTex)
		
		power.frequentUpdates = true
		power.colorPower = true
		if C["unitframes"].showsmooth == true then
			power.Smooth = true
		end

		local powerBG = power:CreateTexture(nil, "BORDER")
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(normTex)
		powerBG.multiplier = 0.3
		
		power.value = T.SetFontString(health, font1, 12, "OUTLINE")
		power.value:Point("RIGHT", -2, 0)
		power.PreUpdate = T.PreUpdatePower
		power.PostUpdate = T.PostUpdatePower
				
		self.Power = power
		self.Power.bg = powerBG
		
		-- names
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", health, "CENTER", 0, 0)
		Name:SetJustifyH("CENTER")
		Name:SetFont(font1, 12, "OUTLINE")
		Name:SetShadowColor(0, 0, 0)
		Name:SetShadowOffset(1.25, -1.25)
		Name.frequentUpdates = 0.2
		
		self:Tag(Name, "[Tukui:getnamecolor][Tukui:namelong]")
		self.Name = Name
		
		if (unit and unit:find("boss%d")) then
			-- alt power bar
			local AltPowerBar = CreateFrame("StatusBar", nil, self.Health)
			AltPowerBar:SetFrameLevel(self.Health:GetFrameLevel() + 1)
			AltPowerBar:Height(4)
			AltPowerBar:SetStatusBarTexture(C.media.normTex)
			AltPowerBar:GetStatusBarTexture():SetHorizTile(false)
			AltPowerBar:SetStatusBarColor(1, 0, 0)

			AltPowerBar:SetPoint("LEFT")
			AltPowerBar:SetPoint("RIGHT")
			AltPowerBar:SetPoint("TOP", self.Health, "TOP")
			
			AltPowerBar:SetBackdrop({
			  bgFile = C["media"].blank, 
			  edgeFile = C["media"].blank, 
			  tile = false, tileSize = 0, edgeSize = T.Scale(1), 
			  insets = { left = 0, right = 0, top = 0, bottom = T.Scale(-1)}
			})
			AltPowerBar:SetBackdropColor(0, 0, 0)

			self.AltPowerBar = AltPowerBar
			
			-- create buff at left of unit if they are boss units
			local buffs = CreateFrame("Frame", nil, self)
			buffs:SetHeight(26)
			buffs:SetWidth(252)
			buffs:Point("RIGHT", self, "LEFT", -4, 0)
			buffs.size = 26
			buffs.num = 3
			buffs.spacing = 2
			buffs.initialAnchor = "RIGHT"
			buffs["growth-x"] = "LEFT"
			buffs.PostCreateIcon = T.PostCreateAura
			buffs.PostUpdateIcon = T.PostUpdateAura
			self.Buffs = buffs
			
			-- because it appear that sometime elements are not correct.
			self:HookScript("OnShow", T.updateAllElements)
		end

		-- create debuff for arena units
		local debuffs = CreateFrame("Frame", nil, self)
		debuffs:SetHeight(26)
		debuffs:SetWidth(200)
		debuffs:Point("LEFT", self, "RIGHT", 4, 0)
		debuffs.size = 26
		debuffs.num = 5
		debuffs.spacing = 2
		debuffs.initialAnchor = "LEFT"
		debuffs["growth-x"] = "RIGHT"
		debuffs.PostCreateIcon = T.PostCreateAura
		debuffs.PostUpdateIcon = T.PostUpdateAura
		self.Debuffs = debuffs
				
		-- trinket feature via trinket plugin
		if (C.unitframes.arena) and (unit and unit:find("arena%d")) then
			local specIcon = CreateFrame("Frame", nil, self)
			specIcon:Size(22)
			specIcon:SetPoint("RIGHT", self, "LEFT", -6, 0)
			specIcon:CreateBackdrop('Default')
			specIcon.backdrop:CreateShadow()
			self.PVPSpecIcon = specIcon

			local Trinket = CreateFrame("Frame", nil, self)
			Trinket:Size(22)
			Trinket:SetPoint("RIGHT", self, "LEFT", -34, 0)
			Trinket:CreateBackdrop('Default')
			Trinket.backdrop:CreateShadow()
			self.Trinket = Trinket
		end
		
		if (C["unitframes"].unitcastbar == true) then
			-- boss & arena frames cast bar!
			local castbar = CreateFrame("StatusBar", self:GetName().."CastBar", self)
			castbar:SetPoint("LEFT", 24, 0)
			castbar:SetPoint("RIGHT", -2, 0)
			castbar:SetPoint("BOTTOM", 0, -22)
			
			castbar:SetHeight(16)
			castbar:SetStatusBarTexture(normTex)
			castbar:SetFrameLevel(6)
			
			castbar.bg = CreateFrame("Frame", nil, castbar)
			castbar.bg:SetTemplate("Default")
			castbar.bg:SetBackdropBorderColor(bdcr * 0.7, bdcg * 0.7, bdcb * 0.7)
			castbar.bg:Point("TOPLEFT", -2, 2)
			castbar.bg:Point("BOTTOMRIGHT", 2, -2)
			castbar.bg:SetFrameLevel(5)
			
			castbar.time = T.SetFontString(castbar, font1, 12)
			castbar.time:Point("RIGHT", castbar, "RIGHT", -4, 0)
			castbar.time:SetTextColor(0.84, 0.75, 0.65)
			castbar.time:SetJustifyH("RIGHT")
			castbar.CustomTimeText = T.CustomCastTimeText

			castbar.Text = T.SetFontString(castbar, font1, 12)
			castbar.Text:Point("LEFT", castbar, "LEFT", 4, 0)
			castbar.Text:SetTextColor(0.84, 0.75, 0.65)
			
			castbar.CustomDelayText = T.CustomCastDelayText
			castbar.PostCastStart = T.CheckCast
			castbar.PostChannelStart = T.CheckChannel
									
			castbar.button = CreateFrame("Frame", nil, castbar)
			castbar.button:Height(castbar:GetHeight()+4)
			castbar.button:Width(castbar:GetHeight()+4)
			castbar.button:Point("RIGHT", castbar, "LEFT",-4, 0)
			castbar.button:SetTemplate("Default")
			castbar.button:SetBackdropBorderColor(bdcr * 0.7, bdcg * 0.7, bdcb * 0.7)
			castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
			castbar.icon:Point("TOPLEFT", castbar.button, 2, -2)
			castbar.icon:Point("BOTTOMRIGHT", castbar.button, -2, 2)
			castbar.icon:SetTexCoord(0.08, 0.92, 0.08, .92)

			self.Castbar = castbar
			self.Castbar.Time = castbar.time
			self.Castbar.Icon = castbar.icon
		end
	end

	------------------------------------------------------------------------
	--	Main tanks and Main Assists layout (both mirror"d)
	------------------------------------------------------------------------
	
	if(self:GetParent():GetName():match"TukuiMainTank" or self:GetParent():GetName():match"TukuiMainAssist") then
		-- Right-click focus on maintank or mainassist units
		self:SetAttribute("type2", "focus")
		
		-- health 
		local health = CreateFrame("StatusBar", nil, self)
		health:Height(20)
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)
		
		local healthBG = health:CreateTexture(nil, "BORDER")
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
				
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if C["unitframes"].showsmooth == true then
			health.Smooth = true
		end
		
		if C["unitframes"].unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.3, .3, .3, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true	
		end
		
		-- names
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", health, "CENTER", 0, 0)
		Name:SetJustifyH("CENTER")
		Name:SetFont(font1, 12, "OUTLINE")
		Name:SetShadowColor(0, 0, 0)
		Name:SetShadowOffset(1.25, -1.25)
		
		self:Tag(Name, "[Tukui:getnamecolor][Tukui:nameshort]")
		self.Name = Name
	end
	
	-- post update for editors
	self.PostUpdateUnit = T.PostUpdateUnit or T.dummy
	self:PostUpdateUnit(unit)
	
	return self
end

------------------------------------------------------------------------
--	Default position of Tukui unitframes
------------------------------------------------------------------------

local adjust = 0
if T.lowversion then adjust = 125 end

-- for lower reso
local adjustXY = 0
local totdebuffs = 0
if T.lowversion then adjustXY = 24 end
if C["unitframes"].totdebuffs then totdebuffs = 24 end

oUF:RegisterStyle("Tukui", Shared)

-- player
local player = oUF:Spawn("player", "TukuiPlayer")
player:SetPoint("BOTTOMLEFT", InvTukuiActionBarBackground, "TOPLEFT", 0,8+adjustXY)
player:SetParent(TukuiPetBattleHider)
if T.lowversion then
	player:Size(186, 51)
else
	player:Size(250, 57)
end
G.UnitFrames.Player = player

-- focus
local focus = oUF:Spawn("focus", "TukuiFocus")
focus:SetPoint("BOTTOMLEFT", InvTukuiActionBarBackground, "TOPLEFT", 0 - adjust, 300)
focus:SetParent(TukuiPetBattleHider)
focus:Size(200, 29)
G.UnitFrames.Focus = focus

-- target
local target = oUF:Spawn("target", "TukuiTarget")
target:SetPoint("BOTTOMRIGHT", InvTukuiActionBarBackground, "TOPRIGHT", 0,8+adjustXY)
target:SetParent(TukuiPetBattleHider)
if T.lowversion then
	target:Size(186, 51)
else
	target:Size(250, 57)
end
G.UnitFrames.Target = target

-- tot
local tot = oUF:Spawn("targettarget", "TukuiTargetTarget")
tot:SetParent(TukuiPetBattleHider)
if T.lowversion then
	tot:SetPoint("BOTTOMRIGHT", InvTukuiActionBarBackground, "TOPRIGHT", 0,8)
	tot:Size(186, 18)
else
	tot:SetPoint("BOTTOM", InvTukuiActionBarBackground, "TOP", 0,8)
	tot:Size(129, 36)
end
G.UnitFrames.TargetTarget = tot

-- pet
local pet = oUF:Spawn("pet", "TukuiPet")
pet:SetParent(TukuiPetBattleHider)
if T.lowversion then
	pet:SetPoint("BOTTOMLEFT", InvTukuiActionBarBackground, "TOPLEFT", 0,8)
	pet:Size(186, 18)
else
	pet:SetPoint("BOTTOM", InvTukuiActionBarBackground, "TOP", 0,49+totdebuffs)
	pet:Size(129, 36)
end
G.UnitFrames.Pet = pet

if C.unitframes.showfocustarget then
	local focustarget = oUF:Spawn("focustarget", "TukuiFocusTarget")
	focustarget:SetParent(TukuiPetBattleHider)
	focustarget:SetPoint("BOTTOM", focus, "TOP", 0 - adjust, 35)
	focustarget:Size(200, 29)
	G.UnitFrames.FocusTarget = focustarget
end


if C.unitframes.arena then
	local arena = {}
	for i = 1, 5 do
		arena[i] = oUF:Spawn("arena"..i, "TukuiArena"..i)
		arena[i]:SetParent(TukuiPetBattleHider)
		if i == 1 then
			arena[i]:SetPoint("BOTTOMRIGHT", InvTukuiActionBarBackground, "TOPRIGHT", 0 + adjust, 300)
		else
			arena[i]:SetPoint("BOTTOM", arena[i-1], "TOP", 0, 35)
		end
		arena[i]:Size(200, 29)
		G.UnitFrames["Arena"..i] = arena[i]
	end
	
	local TukuiPrepArena = {}
	for i = 1, 5 do
		TukuiPrepArena[i] = CreateFrame("Frame", "TukuiPrepArena"..i, UIParent)
		TukuiPrepArena[i]:SetAllPoints(arena[i])
		TukuiPrepArena[i]:SetBackdrop(backdrop)
		TukuiPrepArena[i]:SetBackdropColor(0,0,0)
		TukuiPrepArena[i]:CreateShadow()
		TukuiPrepArena[i].Health = CreateFrame("StatusBar", nil, TukuiPrepArena[i])
		TukuiPrepArena[i].Health:SetAllPoints()
		TukuiPrepArena[i].Health:SetStatusBarTexture(normTex)
		TukuiPrepArena[i].Health:SetStatusBarColor(.3, .3, .3, 1)
		TukuiPrepArena[i].SpecClass = TukuiPrepArena[i].Health:CreateFontString(nil, "OVERLAY")
		TukuiPrepArena[i].SpecClass:SetFont(C.media.uffont, 12, "OUTLINE")
		TukuiPrepArena[i].SpecClass:SetPoint("CENTER")
		TukuiPrepArena[i]:Hide()
	end

	local ArenaListener = CreateFrame("Frame", "TukuiArenaListener", UIParent)
	ArenaListener:RegisterEvent("PLAYER_ENTERING_WORLD")
	ArenaListener:RegisterEvent("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
	ArenaListener:RegisterEvent("ARENA_OPPONENT_UPDATE")
	ArenaListener:SetScript("OnEvent", function(self, event)
		if event == "ARENA_OPPONENT_UPDATE" then
			for i=1, 5 do
				local f = _G["TukuiPrepArena"..i]
				f:Hide()
			end			
		else
			local numOpps = GetNumArenaOpponentSpecs()
			
			if numOpps > 0 then
				for i=1, 5 do
					local f = _G["TukuiPrepArena"..i]
					local s = GetArenaOpponentSpec(i)
					local _, spec, class = nil, "UNKNOWN", "UNKNOWN"
					
					if s and s > 0 then 
						_, spec, _, _, _, _, class = GetSpecializationInfoByID(s)
					end
					
					if (i <= numOpps) then
						if class and spec then
							f.SpecClass:SetText(spec.."  -  "..LOCALIZED_CLASS_NAMES_MALE[class])
							if not C.unitframes.unicolor then
								local color = arena[i].colors.class[class]
								f.Health:SetStatusBarColor(unpack(color))
							end
							f:Show()
						end
					else
						f:Hide()
					end
				end
			else
				for i=1, 5 do
					local f = _G["TukuiPrepArena"..i]
					f:Hide()
				end			
			end
		end
	end)
end

if C["unitframes"].showboss then
	for i = 1,MAX_BOSS_FRAMES do
		local t_boss = _G["Boss"..i.."TargetFrame"]
		t_boss:UnregisterAllEvents()
		t_boss.Show = T.dummy
		t_boss:Hide()
		_G["Boss"..i.."TargetFrame".."HealthBar"]:UnregisterAllEvents()
		_G["Boss"..i.."TargetFrame".."ManaBar"]:UnregisterAllEvents()
	end

	local boss = {}
	for i = 1, MAX_BOSS_FRAMES do
		boss[i] = oUF:Spawn("boss"..i, "TukuiBoss"..i)
		boss[i]:SetParent(TukuiPetBattleHider)
		if i == 1 then
			boss[i]:SetPoint("BOTTOMRIGHT", InvTukuiActionBarBackground, "TOPRIGHT", 0 + adjust, 300)
		else
			boss[i]:SetPoint("BOTTOM", boss[i-1], "TOP", 0, 35)             
		end
		boss[i]:Size(200, 29)
		G.UnitFrames["Boss"..i] = boss[i]
	end
end

local assisttank_width = 100
local assisttank_height  = 20
if C["unitframes"].maintank == true then
	local function GetAttributes()
		return
		"TukuiMainTank", nil, "raid",
		"oUF-initialConfigFunction", ([[
			self:SetWidth(%d)
			self:SetHeight(%d)
		]]):format(assisttank_width, assisttank_height),
		"showRaid", true,
		"groupFilter", "MAINTANK",
		"yOffset", 7,
		"point" , "BOTTOM",
		"template", "oUF_TukuiMtt"		
	end
	T.MainTankAttributes = GetAttributes
	
	local tank = oUF:SpawnHeader(T.MainTankAttributes())
	tank:SetParent(TukuiPetBattleHider)
	tank:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
end
 
if C["unitframes"].mainassist == true then
	local function GetAttributes()
		return
		"TukuiMainAssist", nil, "raid",
		"oUF-initialConfigFunction", ([[
			self:SetWidth(%d)
			self:SetHeight(%d)
		]]):format(assisttank_width, assisttank_height),
		"showRaid", true,
		"groupFilter", "MAINASSIST",
		"yOffset", 7,
		"point" , "BOTTOM",
		"template", "oUF_TukuiMtt"
	end
	T.MainAssistAttributes = GetAttributes
	
	local assist = oUF:SpawnHeader(T.MainAssistAttributes())
	assist:SetParent(TukuiPetBattleHider)
	if C["unitframes"].maintank == true then
		assist:SetPoint("TOPLEFT", TukuiMainTank, "BOTTOMLEFT", 2, -50)
	else
		assist:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
end

------------------------------------------------------------------------
-- Right-Click on unit frames menu. 
-- Removing some useless stuff and tainting stuff
------------------------------------------------------------------------

for _, menu in pairs(UnitPopupMenus) do
	for index = #menu, 1, -1 do
		if menu[index] == "SET_FOCUS" or menu[index] == "CLEAR_FOCUS" or menu[index] == "MOVE_PLAYER_FRAME" or menu[index] == "MOVE_TARGET_FRAME" or (T.myclass == "HUNTER" and menu[index] == "PET_DISMISS") then
			table.remove(menu, index)
		end
	end
end

------------------------------------------------------------------------
-- Raid Frames
------------------------------------------------------------------------

if C.unitframes.raid == true then
	local font2 = C["media"].uffont
	local font1 = C["media"].font
	local normTex = C["media"].normTex
	local bdcr, bdcg, bdcb = unpack(C["media"].bordercolor)
	local backdrop = {
		bgFile = C["media"].blank,
		insets = {top = -T.mult, left = -T.mult, bottom = -T.mult, right = -T.mult},
	}

	local function Shared(self, unit)
		self.colors = T.UnitColor
		self:RegisterForClicks("AnyUp")
		self:SetScript("OnEnter", UnitFrame_OnEnter)
		self:SetScript("OnLeave", UnitFrame_OnLeave)
		
		self.menu = T.SpawnMenu
		
		self:SetBackdrop({bgFile = C["media"].blank, insets = {top = -T.mult, left = -T.mult, bottom = -T.mult, right = -T.mult}})
		self:SetBackdropColor(0, 0, 0)
		
		local health = CreateFrame("StatusBar", nil, self)
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:Height(28*C["unitframes"].gridscale*T.raidscale)
		health:SetStatusBarTexture(normTex)
		self.Health = health
		
		if C["unitframes"].gridhealthvertical == true then
			health:SetOrientation("VERTICAL")
		end
		
		health.bg = health:CreateTexture(nil, "BORDER")
		health.bg:SetAllPoints(health)
		health.bg:SetTexture(normTex)
		health.bg:SetTexture(0.3, 0.3, 0.3)
		health.bg.multiplier = (0.3)
		self.Health.bg = health.bg
			
		health.value = health:CreateFontString(nil, "OVERLAY")
		health.value:Point("CENTER", health, 1, 0)
		health.value:SetFont(font2, 11*C["unitframes"].gridscale*T.raidscale, "THINOUTLINE")
		health.value:SetTextColor(1,1,1)
		health.value:SetShadowOffset(1, -1)
		self.Health.value = health.value
		
		health.PostUpdate = T.PostUpdateHealthRaid
		
		health.frequentUpdates = true
		
		if C.unitframes.unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.3, .3, .3, 1)
			health.bg:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true			
		end
			
		local power = CreateFrame("StatusBar", nil, self)
		power:SetHeight(3*C["unitframes"].gridscale*T.raidscale)
		power:Point("TOPLEFT", self.Health, "BOTTOMLEFT", 0, -1)
		power:Point("TOPRIGHT", self.Health, "BOTTOMRIGHT", 0, -1)
		power:SetStatusBarTexture(normTex)
		self.Power = power

		power.frequentUpdates = true
		power.colorDisconnected = true

		power.bg = power:CreateTexture(nil, "BORDER")
		power.bg:SetAllPoints(power)
		power.bg:SetTexture(normTex)
		power.bg:SetAlpha(1)
		power.bg.multiplier = 0.4
		
		if C.unitframes.unicolor == true then
			power.colorClass = true
			power.bg.multiplier = 0.1				
		else
			power.colorPower = true
		end
		
		local panel = CreateFrame("Frame", nil, self)
		panel:Point("TOPLEFT", power, "BOTTOMLEFT", 0, -1)
		panel:Point("TOPRIGHT", power, "BOTTOMRIGHT", 0, -1)
		panel:SetPoint("BOTTOM", 0,0)
		panel:SetTemplate()
		self.panel = panel
		
		local name = panel:CreateFontString(nil, "OVERLAY")
		name:SetPoint("TOP") 
		name:SetPoint("BOTTOM") 
		name:SetPoint("LEFT") 
		name:SetPoint("RIGHT")
		name:SetFont(font2, 12*C["unitframes"].gridscale*T.raidscale)
		self:Tag(name, "[Tukui:getnamecolor][Tukui:nameshort]")
		self.Name = name
		
		if C["unitframes"].aggro == true then
			table.insert(self.__elements, T.UpdateThreat)
			self:RegisterEvent("PLAYER_TARGET_CHANGED", T.UpdateThreat)
			self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", T.UpdateThreat)
			self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", T.UpdateThreat)
		end
		
		if C["unitframes"].showsymbols == true then
			local RaidIcon = health:CreateTexture(nil, "OVERLAY")
			RaidIcon:Height(18*T.raidscale)
			RaidIcon:Width(18*T.raidscale)
			RaidIcon:SetPoint("CENTER", self, "TOP")
			RaidIcon:SetTexture("Interface\\AddOns\\Tukui\\medias\\textures\\raidicons.blp") -- thx hankthetank for texture
			RaidIcon.SetTexture = T.dummy -- idk why but RaidIcon:GetTexture() is returning nil in oUF, resetting icons to default ... stop it!
			self.RaidIcon = RaidIcon
		end
		
		local ReadyCheck = power:CreateTexture(nil, "OVERLAY")
		ReadyCheck:Height(12*C["unitframes"].gridscale*T.raidscale)
		ReadyCheck:Width(12*C["unitframes"].gridscale*T.raidscale)
		ReadyCheck:SetPoint("CENTER") 	
		self.ReadyCheck = ReadyCheck
		
		--local picon = self.Health:CreateTexture(nil, "OVERLAY")
		--picon:SetPoint("CENTER", self.Health)
		--picon:SetSize(16, 16)
		--picon:SetTexture[[Interface\AddOns\Tukui\medias\textures\picon]]
		--picon.Override = T.Phasing
		--self.PhaseIcon = picon
		
		if C["unitframes"].showrange == true then
			local range = {insideAlpha = 1, outsideAlpha = C["unitframes"].raidalphaoor}
			self.Range = range
		end
		
		if C["unitframes"].showsmooth == true then
			health.Smooth = true
			power.Smooth = true
		end
		
		if C["unitframes"].healcomm then
			local mhpb = CreateFrame("StatusBar", nil, self.Health)
			if C["unitframes"].gridhealthvertical then
				mhpb:SetOrientation("VERTICAL")
				mhpb:SetPoint("BOTTOM", self.Health:GetStatusBarTexture(), "TOP", 0, 0)
				mhpb:Width(66*C["unitframes"].gridscale*T.raidscale)
				mhpb:Height(50*C["unitframes"].gridscale*T.raidscale)		
			else
				mhpb:SetPoint("TOPLEFT", self.Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
				mhpb:SetPoint("BOTTOMLEFT", self.Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
				mhpb:Width(66*C["unitframes"].gridscale*T.raidscale)
			end				
			mhpb:SetStatusBarTexture(normTex)
			mhpb:SetStatusBarColor(0, 1, 0.5, 0.25)

			local ohpb = CreateFrame("StatusBar", nil, self.Health)
			if C["unitframes"].gridhealthvertical then
				ohpb:SetOrientation("VERTICAL")
				ohpb:SetPoint("BOTTOM", mhpb:GetStatusBarTexture(), "TOP", 0, 0)
				ohpb:Width(66*C["unitframes"].gridscale*T.raidscale)
				ohpb:Height(50*C["unitframes"].gridscale*T.raidscale)
			else
				ohpb:SetPoint("TOPLEFT", mhpb:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
				ohpb:SetPoint("BOTTOMLEFT", mhpb:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
				ohpb:Width(6*C["unitframes"].gridscale*T.raidscale)
			end
			ohpb:SetStatusBarTexture(normTex)
			ohpb:SetStatusBarColor(0, 1, 0, 0.25)

			self.HealPrediction = {
				myBar = mhpb,
				otherBar = ohpb,
				maxOverflow = 1,
			}
		end
		
		if C["unitframes"].raidunitdebuffwatch == true then
			-- AuraWatch (corner icon)
			T.createAuraWatch(self,unit)
			
			-- Raid Debuffs (big middle icon)
			local RaidDebuffs = CreateFrame("Frame", nil, self)
			RaidDebuffs:Height(24*C["unitframes"].gridscale)
			RaidDebuffs:Width(24*C["unitframes"].gridscale)
			RaidDebuffs:Point("CENTER", health, 1,0)
			RaidDebuffs:SetFrameStrata(health:GetFrameStrata())
			RaidDebuffs:SetFrameLevel(health:GetFrameLevel() + 2)
			
			RaidDebuffs:SetTemplate("Default")
			
			RaidDebuffs.icon = RaidDebuffs:CreateTexture(nil, "OVERLAY")
			RaidDebuffs.icon:SetTexCoord(.1,.9,.1,.9)
			RaidDebuffs.icon:Point("TOPLEFT", 2, -2)
			RaidDebuffs.icon:Point("BOTTOMRIGHT", -2, 2)
			
			-- just in case someone want to add this feature, uncomment to enable it
			--[[
			if C["unitframes"].auratimer then
				RaidDebuffs.cd = CreateFrame("Cooldown", nil, RaidDebuffs)
				RaidDebuffs.cd:Point("TOPLEFT", 2, -2)
				RaidDebuffs.cd:Point("BOTTOMRIGHT", -2, 2)
				RaidDebuffs.cd.noOCC = true -- remove this line if you want cooldown number on it
			end
			--]]
			
			RaidDebuffs.count = RaidDebuffs:CreateFontString(nil, "OVERLAY")
			RaidDebuffs.count:SetFont(C["media"].uffont, 9*C["unitframes"].gridscale, "THINOUTLINE")
			RaidDebuffs.count:SetPoint("BOTTOMRIGHT", RaidDebuffs, "BOTTOMRIGHT", 0, 2)
			RaidDebuffs.count:SetTextColor(1, .9, 0)
			
			RaidDebuffs:FontString("time", C["media"].uffont, 9*C["unitframes"].gridscale, "THINOUTLINE")
			RaidDebuffs.time:SetPoint("CENTER")
			RaidDebuffs.time:SetTextColor(1, .9, 0)
			
			self.RaidDebuffs = RaidDebuffs
		end
		
		if T.myclass == "PRIEST" and C["unitframes"].weakenedsoulbar then
			local ws = CreateFrame("StatusBar", self:GetName().."_WeakenedSoul", power)
			ws:SetAllPoints(power)
			ws:SetStatusBarTexture(C.media.normTex)
			ws:GetStatusBarTexture():SetHorizTile(false)
			ws:SetBackdrop(backdrop)
			ws:SetBackdropColor(unpack(C.media.backdropcolor))
			ws:SetStatusBarColor(191/255, 10/255, 10/255)
			
			self.WeakenedSoul = ws
		end
		
		-- for editors, easy way to edit raid unit frames
		local header = self:GetParent():GetName()
		self.PostUpdateRaidUnit = T.PostUpdateRaidUnit or T.dummy
		self:PostUpdateRaidUnit(unit, header)
		
		-- highlight
		self:HighlightUnit(218/255, 197/255, 92/255)

		return self
	end

	local point = "LEFT"
	local columnAnchorPoint = "TOP"
	local pa1, pa2, px, py = "TOPLEFT", "BOTTOMLEFT", 0, -3
	if C.unitframes.raidunitspercolumn == 0 then C.unitframes.raidunitspercolumn = 8 end

	if C.unitframes.gridvertical then
		point = "TOP"
		columnAnchorPoint = "LEFT"
		pa1, pa2, px, py = "TOPLEFT", "TOPRIGHT", 3, 0
	end
	
	local y = T.screenheight / 9
	
	oUF:RegisterStyle("TukuiRaid", Shared)

	local function GetAttributes()
		return
		"TukuiRaid", 
		nil, 
		"solo,party,raid",
		"oUF-initialConfigFunction", [[
			local header = self:GetParent()
			self:SetWidth(header:GetAttribute("initial-width"))
			self:SetHeight(header:GetAttribute("initial-height"))
		]],
		"initial-width", T.Scale(66*C["unitframes"].gridscale*T.raidscale),
		"initial-height", T.Scale(50*C["unitframes"].gridscale*T.raidscale),
		"showParty", true,
		"showRaid", true,
		"showPlayer", true,
		--"showSolo", true, -- used to show raid unit in solo, for coding purpose
		"xoffset", T.Scale(3),
		"yOffset", T.Scale(-3),
		"point", point,
		"groupFilter", "1,2,3,4,5,6,7,8",
		"groupingOrder", "1,2,3,4,5,6,7,8",
		"groupBy", "GROUP",
		"maxColumns", math.ceil(40/C.unitframes.raidunitspercolumn),
		"unitsPerColumn", C.unitframes.raidunitspercolumn or 5,
		"columnSpacing", T.Scale(3),
		"columnAnchorPoint", columnAnchorPoint
	end
	T.RaidFrameAttributes = GetAttributes
	
	if C.unitframes.showraidpets then
		local function GetPetAttributes()
			return
			"TukuiRaidPet", "SecureGroupPetHeaderTemplate", "solo,party,raid",
			"showPlayer", true,
			"showParty", true,
			"showRaid", true,
			--"showSolo", true, -- used to show raid pet in solo, for coding purpose
			"maxColumns", math.ceil(40/C.unitframes.raidunitspercolumn),
			"point", point,
			"unitsPerColumn", C.unitframes.raidunitspercolumn or 5,
			"columnSpacing", T.Scale(3),
			"columnAnchorPoint", columnAnchorPoint,
			"yOffset", T.Scale(-3),
			"xOffset", T.Scale(3),
			"initial-width", T.Scale(66*C["unitframes"].gridscale*T.raidscale),
			"initial-height", T.Scale(50*C["unitframes"].gridscale*T.raidscale),
			"oUF-initialConfigFunction", [[
				local header = self:GetParent()
				self:SetWidth(header:GetAttribute("initial-width"))
				self:SetHeight(header:GetAttribute("initial-height"))
			]]
		end
		T.RaidFramePetAttributes = GetPetAttributes
	end
		
	oUF:Factory(function(self)
		if T.isAltRaidFrame then return end
		
		oUF:SetActiveStyle("TukuiRaid")

		local raid = self:SpawnHeader(T.RaidFrameAttributes())
		raid:SetParent(TukuiPetBattleHider)
		raid:Point("TOPLEFT", UIParent, "TOPLEFT", 18, -y)
		G.UnitFrames.RaidUnits = raid
	
		if C.unitframes.showraidpets then
			local pet = self:SpawnHeader(T.RaidFramePetAttributes())
			pet:SetParent(TukuiPetBattleHider)
			pet:Point(pa1, raid, pa2, px, py)
			G.UnitFrames.RaidPets = pet
		end
		
		if C.unitframes.maxraidplayers then
			-- Max number of group according to Instance max players
			local ten = "1,2"
			local twentyfive = "1,2,3,4,5"
			local forty = "1,2,3,4,5,6,7,8"

			local MaxGroup = CreateFrame("Frame", "TukuiRaidMaxGroup")
			MaxGroup:RegisterEvent("PLAYER_ENTERING_WORLD")
			MaxGroup:RegisterEvent("ZONE_CHANGED_NEW_AREA")
			MaxGroup:SetScript("OnEvent", function(self)
				local filter
				local inInstance, instanceType = IsInInstance()
				local _, _, _, _, maxPlayers, _, _ = GetInstanceInfo()
				
				if maxPlayers == 25 then
					filter = twentyfive
				elseif maxPlayers == 10 then
					filter = ten
				else
					filter = forty
				end

				if inInstance and instanceType == "raid" then
					TukuiRaid:SetAttribute("groupFilter", filter)
					if C.unitframes.showraidpets then
						TukuiRaidPet:SetAttribute("groupFilter", filter)
					end
				else
					TukuiRaid:SetAttribute("groupFilter", "1,2,3,4,5,6,7,8")
					if C.unitframes.showraidpets then
						TukuiRaidPet:SetAttribute("groupFilter", "1,2,3,4,5,6,7,8")
					end
				end
			end)
		end
	end)
end