local T, C, L, G = unpack(select(2, ...)) 
-- yleaf (yaroot@gmail.com)

if C.unitframes.enable ~= true or C.unitframes.raidunitdebuffwatch ~= true then return end

local _, ns = ...
local oUF = ns.oUF or oUF
local Plugin = CreateFrame("Frame")

local addon = {}
ns.oUF_RaidDebuffs = addon
if not _G.oUF_RaidDebuffs then
	_G.oUF_RaidDebuffs = addon
end

local debuff_data = {}
addon.DebuffData = debuff_data


addon.ShowDispelableDebuff = true
addon.FilterDispellableDebuff = true
addon.MatchBySpellName = true


addon.priority = 10

local function add(spell)
	if addon.MatchBySpellName and type(spell) == 'number' then
		spell = GetSpellInfo(spell)
	end
	
	debuff_data[spell] = addon.priority
	addon.priority = addon.priority + 1
end

function addon:RegisterDebuffs(t)
	for _, v in next, t do
		add(v)
	end
end

function addon:ResetDebuffData()
	wipe(debuff_data)
	addon.priority = 10
end

local DispellColor = {
	['Magic']	= {.2, .6, 1},
	['Curse']	= {.6, 0, 1},
	['Disease']	= {.6, .4, 0},
	['Poison']	= {0, .6, 0},
	['none'] = {.6, .6, .6},
}

local DispellPriority = {
	['Magic']	= 4,
	['Curse']	= 3,
	['Disease']	= 2,
	['Poison']	= 1,
}

local DispellFilter
do
	local dispellClasses = {
		['PRIEST'] = {
			['Magic'] = true,
			['Disease'] = true,
		},
		['SHAMAN'] = {
			['Magic'] = false,
			['Curse'] = true,
		},
		['PALADIN'] = {
			['Poison'] = true,
			['Magic'] = false,
			['Disease'] = true,
		},
		['MAGE'] = {
			['Curse'] = true,
		},
		['DRUID'] = {
			['Magic'] = false,
			['Curse'] = true,
			['Poison'] = true,
		},
		['MONK'] = {
			['Poison'] = true,
			['Magic'] = false,
			['Disease'] = true,
		},
	}
	
	DispellFilter = dispellClasses[select(2, UnitClass('player'))] or {}
end

local function CheckSpec()
	local role = ""
	local tree = GetSpecialization()
	
	if tree then
		role = select(6, GetSpecializationInfo(tree))
	end
	
	if role == "HEALER" then
		DispellFilter.Magic = true
	else
		DispellFilter.Magic = false	
	end
end
Plugin:RegisterEvent("PLAYER_TALENT_UPDATE")
Plugin:SetScript("OnEvent", CheckSpec)

local function formatTime(s)
	if s > 60 then
		return format('%dm', s/60), s%60
	elseif s < 1 then
		return format("%.1f", s), s - floor(s)
	else
		return format('%d', s), s - floor(s)
	end
end

local abs = math.abs
local function OnUpdate(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed >= 0.1 then
		local timeLeft = self.endTime - GetTime()
		if self.reverse then timeLeft = abs((self.endTime - GetTime()) - self.duration) end
		if timeLeft > 0 then
			local text = formatTime(timeLeft)
			self.time:SetText(text)
		else
			self:SetScript('OnUpdate', nil)
			self.time:Hide()
		end
		self.elapsed = 0
	end
end

local function UpdateDebuff(self, name, icon, count, debuffType, duration, endTime, spellId)
	local f = self.RaidDebuffs
	if name then
		f.icon:SetTexture(icon)
		f.icon:Show()
		f.duration = duration
		
		if f.count then
			if count and (count > 0) then
				f.count:SetText(count)
				f.count:Show()
			else
				f.count:Hide()
			end
		end
		
		if spellId and T.ReverseTimer[spellId] then
			f.reverse = true
		else
			f.reverse = nil
		end
		
		if f.time then
			if duration and (duration > 0) then
				f.endTime = endTime
				f.nextUpdate = 0
				f:SetScript('OnUpdate', OnUpdate)
				f.time:Show()
			else
				f:SetScript('OnUpdate', nil)
				f.time:Hide()
			end
		end
		
		if f.cd then
			if duration and (duration > 0) then
				f.cd:SetCooldown(endTime - duration, duration)
				f.cd:Show()
			else
				f.cd:Hide()
			end
		end
		
		local c = DispellColor[debuffType] or DispellColor.none
		f:SetBackdropBorderColor(c[1], c[2], c[3])
		
		f:Show()
	else
		f:Hide()
	end
end

-- used to blacklist some debuffs which can cause problems
local blacklist = {
	[101108] = true, -- Rage of Ragnaros
	[101109] = true, -- Rage of Ragnaros
	[101110] = true, -- Rage of Ragnaros
	[101228] = true, -- Rage of Ragnaros
}

-- kind of fix for deep corruption, which need to show stacking first
local DeepCorruption = {
	[103628] = true, -- Deep Corruption (stacking)
	[109389] = true, -- Deep Corruption (stacking)
}

local function Update(self, event, unit)
	if unit ~= self.unit then return end
	local _name, _icon, _count, _dtype, _duration, _endTime, _spellId
	local _priority, priority = 0
	for i = 1, 40 do
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitAura(unit, i, 'HARMFUL')
		if (not name) or (blacklist[spellId]) then break end
		
		if addon.ShowDispelableDebuff and debuffType then
			if addon.FilterDispellableDebuff then
				DispellPriority[debuffType] = DispellPriority[debuffType] + addon.priority --Make Dispell buffs on top of Boss Debuffs
				priority = DispellFilter[debuffType] and DispellPriority[debuffType]
			else
				priority = DispellPriority[debuffType]
			end
			
			if priority and (priority > _priority) then
				_priority, _name, _icon, _count, _dtype, _duration, _endTime, _spellId = priority, name, icon, count, debuffType, duration, expirationTime, spellId
			end
		end
		
		priority = debuff_data[addon.MatchBySpellName and name or spellId]
		if (priority and (priority > _priority)) or (addon.DeepCorruption and DeepCorruption[spellId]) then
			_priority, _name, _icon, _count, _dtype, _duration, _endTime, _spellId = priority, name, icon, count, debuffType, duration, expirationTime, spellId
		end
	end
	
	UpdateDebuff(self, _name, _icon, _count, _dtype, _duration, _endTime, _spellId)
	
	--Reset the DispellPriority
	DispellPriority = {
		['Magic']	= 4,
		['Curse']	= 3,
		['Disease']	= 2,
		['Poison']	= 1,
	}	
end

local function Enable(self)
	local rd = self.RaidDebuffs
	if rd then
		self:RegisterEvent('UNIT_AURA', Update)
		return true
	end
end

local function Disable(self)
	local rd = self.RaidDebuffs
	if rd then
		self:UnregisterEvent('UNIT_AURA', Update)
	end
end

oUF:AddElement('RaidDebuffs', Update, Enable, Disable)