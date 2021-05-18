local _, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, 'oUF not loaded')

local Update = function(self, event, ...)
	local _, instanceType = IsInInstance()
	
	if instanceType ~= 'arena' then
		self.Trinket.Icon:SetTexture(select(2, UnitFactionGroup("player")) == "Horde" and "Interface\\Icons\\inv_jewelry_trinketpvp_01" or "Interface\\Icons\\inv_jewelry_trinketpvp_02")
		self.Trinket:Hide()
		
		return
	else
		self.Trinket:Show()
	end

	if(self.Trinket.PreUpdate) then self.Trinket:PreUpdate(event, ...) end

	if event == "ARENA_COOLDOWNS_UPDATE" then
		local unit = ...
		local tunit = self.unit
		
		if self.unit == unit then
			C_PvP.RequestCrowdControlSpell(unit)

			local spellID, startTime, duration = C_PvP.GetArenaCrowdControlInfo(unit)

			if spellID and startTime ~= 0 and duration ~= 0 then
				CooldownFrame_Set(self.Trinket.cooldownFrame, startTime / 1000, duration / 1000, 1)
			end
		end
	elseif event == "ARENA_CROWD_CONTROL_SPELL_UPDATE" then
		local unit, spellID = ...
		
		if self.unit == unit then
			local _, _, spellTexture = GetSpellInfo(spellID)

			self.Trinket.Icon:SetTexture(spellTexture)
		end
	elseif event == 'PLAYER_ENTERING_WORLD' then
		CooldownFrame_Set(self.Trinket.cooldownFrame, 1, 1, 1)
	end

	if(self.Trinket.PostUpdate) then self.Trinket:PostUpdate(event, ...) end
end

local Enable = function(self)
	if self.Trinket then
		self:RegisterEvent("ARENA_COOLDOWNS_UPDATE", Update, true)
		self:RegisterEvent("PLAYER_ENTERING_WORLD", Update, true)
		self:RegisterEvent("ARENA_CROWD_CONTROL_SPELL_UPDATE", Update, true)
		
		if not self.Trinket.cooldownFrame then
			self.Trinket.cooldownFrame = CreateFrame("Cooldown", nil, self.Trinket)
			self.Trinket.cooldownFrame:SetAllPoints(self.Trinket)
		end

		if not self.Trinket.Icon then
			self.Trinket.Icon = self.Trinket:CreateTexture(nil, "BORDER")
			self.Trinket.Icon:SetAllPoints(self.Trinket)
			self.Trinket.Icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
			self.Trinket.Icon:SetTexture(select(2, UnitFactionGroup("player")) == "Horde" and "Interface\\Icons\\inv_jewelry_trinketpvp_01" or "Interface\\Icons\\inv_jewelry_trinketpvp_02")
		end

		return true
	end
end

local Disable = function(self)
	if self.Trinket then
		self:UnregisterEvent("ARENA_COOLDOWNS_UPDATE", Update)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD", Update)
		self:UnregisterEvent("ARENA_CROWD_CONTROL_SPELL_UPDATE", Update)
		self.Trinket:Hide()
	end
end

oUF:AddElement('Trinket', Update, Enable, Disable)