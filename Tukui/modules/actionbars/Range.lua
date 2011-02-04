local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
--[[
	Thx to Tulla
		Adds out of range coloring to action buttons
		Derived from RedRange and TullaRange
--]]

if not C["actionbar"].enable == true then return end

--locals and speed
local _G = _G
local UPDATE_DELAY = 0.15
local ATTACK_BUTTON_FLASH_TIME = ATTACK_BUTTON_FLASH_TIME
local SPELL_POWER_HOLY_POWER = SPELL_POWER_HOLY_POWER
local ActionButton_GetPagedID = ActionButton_GetPagedID
local ActionButton_IsFlashing = ActionButton_IsFlashing
local ActionHasRange = ActionHasRange
local IsActionInRange = IsActionInRange
local IsUsableAction = IsUsableAction
local HasAction = HasAction

--code for handling defaults
local function removeDefaults(tbl, defaults)
	for k, v in pairs(defaults) do
		if type(tbl[k]) == 'table' and type(v) == 'table' then
			removeDefaults(tbl[k], v)
			if next(tbl[k]) == nil then
				tbl[k] = nil
			end
		elseif tbl[k] == v then
			tbl[k] = nil
		end
	end
	return tbl
end

local function copyDefaults(tbl, defaults)
	for k, v in pairs(defaults) do
		if type(v) == 'table' then
			tbl[k] = copyDefaults(tbl[k] or {}, v)
		elseif tbl[k] == nil then
			tbl[k] = v
		end
	end
	return tbl
end

local function timer_Create(parent, interval)
	local updater = parent:CreateAnimationGroup()
	updater:SetLooping('NONE')
	updater:SetScript('OnFinished', function(self)
		if parent:Update() then
			parent:Start(interval)
		end
	end)

	local a = updater:CreateAnimation('Animation'); a:SetOrder(1)

	parent.Start = function(self)
		self:Stop()
		a:SetDuration(interval)
		updater:Play()
		return self
	end

	parent.Stop = function(self)
		if updater:IsPlaying() then
			updater:Stop()
		end
		return self
	end

	parent.Active = function(self)
		return updater:IsPlaying()
	end

	return parent
end

--stuff for holy power detection
local PLAYER_IS_PALADIN = select(2, UnitClass('player')) == 'PALADIN'
local HAND_OF_LIGHT = GetSpellInfo(90174)
local isHolyPowerAbility
do
	local HOLY_POWER_SPELLS = {
		[85256] = GetSpellInfo(85256), --Templar's Verdict
		[53600] = GetSpellInfo(53600), --Shield of the Righteous
		-- [84963] = GetSpellInfo(84963), --Inquisition
		-- [85673] = GetSpellInfo(85673), --Word of Glory
		-- [85222] = GetSpellInfo(85222), --Light of Dawn
	}

	isHolyPowerAbility = function(actionId)
		local actionType, id = GetActionInfo(actionId)
		if actionType == 'macro' then
			local macroSpell = GetMacroSpell(id)
			if macroSpell then
				for spellId, spellName in pairs(HOLY_POWER_SPELLS) do
					if macroSpell == spellName then
						return true
					end
				end
			end
		else
			return HOLY_POWER_SPELLS[id]
		end
		return false
	end
end

--[[ The main thing ]]--
local TukuiRange = timer_Create(CreateFrame('Frame', 'TukuiRange'), UPDATE_DELAY)

function TukuiRange:Load()
	self:SetScript('OnEvent', self.OnEvent)
	self:RegisterEvent('PLAYER_LOGIN')
	self:RegisterEvent('PLAYER_LOGOUT')
end


--[[ Frame Events ]]--
function TukuiRange:OnEvent(event, ...)
	local action = self[event]
	if action then
		action(self, event, ...)
	end
end

--[[ Game Events ]]--
function TukuiRange:PLAYER_LOGIN()
	if not TukuiRange_COLORS then
		TukuiRange_COLORS = {}
	end
	self.colors = copyDefaults(TukuiRange_COLORS, self:GetDefaults())

	--add options loader
	local f = CreateFrame('Frame', nil, InterfaceOptionsFrame)
	f:SetScript('OnShow', function(self)
		self:SetScript('OnShow', nil)
		LoadAddOn('TukuiRange_Config')
	end)

	self.buttonsToUpdate = {}

	hooksecurefunc('ActionButton_OnUpdate', self.RegisterButton)
	hooksecurefunc('ActionButton_UpdateUsable', self.OnUpdateButtonUsable)
	hooksecurefunc('ActionButton_Update', self.OnButtonUpdate)
end

function TukuiRange:PLAYER_LOGOUT()
	removeDefaults(TukuiRange_COLORS, self:GetDefaults())
end

--[[ Actions ]]--
function TukuiRange:Update()
	return self:UpdateButtons(UPDATE_DELAY)
end

function TukuiRange:ForceColorUpdate()
	for button in pairs(self.buttonsToUpdate) do
		TukuiRange.OnUpdateButtonUsable(button)
	end
end

function TukuiRange:UpdateActive()
	if next(self.buttonsToUpdate) then
		if not self:Active() then
			self:Start()
		end
	else
		self:Stop()
	end
end

function TukuiRange:UpdateButtons(elapsed)
	if next(self.buttonsToUpdate) then
		for button in pairs(self.buttonsToUpdate) do
			self:UpdateButton(button, elapsed)
		end
		return true
	end
	return false
end

function TukuiRange:UpdateButton(button, elapsed)
	TukuiRange.UpdateButtonUsable(button)
	TukuiRange.UpdateFlash(button, elapsed)
end

function TukuiRange:UpdateButtonStatus(button)
	local action = ActionButton_GetPagedID(button)
	if button:IsVisible() and action and HasAction(action) and ActionHasRange(action) then
		self.buttonsToUpdate[button] = true
	else
		self.buttonsToUpdate[button] = nil
	end
	self:UpdateActive()
end

--[[ Button Hooking ]]--
function TukuiRange.RegisterButton(button)
	button:HookScript('OnShow', TukuiRange.OnButtonShow)
	button:HookScript('OnHide', TukuiRange.OnButtonHide)
	button:SetScript('OnUpdate', nil)

	TukuiRange:UpdateButtonStatus(button)
end

function TukuiRange.OnButtonShow(button)
	TukuiRange:UpdateButtonStatus(button)
end

function TukuiRange.OnButtonHide(button)
	TukuiRange:UpdateButtonStatus(button)
end

function TukuiRange.OnUpdateButtonUsable(button)
	button.TukuiRangeColor = nil
	TukuiRange.UpdateButtonUsable(button)
end

function TukuiRange.OnButtonUpdate(button)
	 TukuiRange:UpdateButtonStatus(button)
end

--[[ Range Coloring ]]--
function TukuiRange.UpdateButtonUsable(button)
	local action = ActionButton_GetPagedID(button)
	local isUsable, notEnoughMana = IsUsableAction(action)

	--usable
	if isUsable then
		--but out of range
		if IsActionInRange(action) == 0 then
			TukuiRange.SetButtonColor(button, 'oor')
		--a holy power abilty, and we're less than 3 Holy Power
		elseif PLAYER_IS_PALADIN and isHolyPowerAbility(action) and not(UnitPower('player', SPELL_POWER_HOLY_POWER) == 3 or UnitBuff('player', HAND_OF_LIGHT)) then
			TukuiRange.SetButtonColor(button, 'ooh')
		--in range
		else
			TukuiRange.SetButtonColor(button, 'normal')
		end
	--out of mana
	elseif notEnoughMana then
		TukuiRange.SetButtonColor(button, 'oom')
	--unusable
	else
		button.TukuiRangeColor = 'unusuable'
	end
end

function TukuiRange.SetButtonColor(button, colorType)
	if button.TukuiRangeColor ~= colorType then
		button.TukuiRangeColor = colorType

		local r, g, b = TukuiRange:GetColor(colorType)

		local icon =  _G[button:GetName() .. 'Icon']
		icon:SetVertexColor(r, g, b)

		local nt = button:GetNormalTexture()
		nt:SetVertexColor(r, g, b)
	end
end

function TukuiRange.UpdateFlash(button, elapsed)
	if ActionButton_IsFlashing(button) then
		local flashtime = button.flashtime - elapsed

		if flashtime <= 0 then
			local overtime = -flashtime
			if overtime >= ATTACK_BUTTON_FLASH_TIME then
				overtime = 0
			end
			flashtime = ATTACK_BUTTON_FLASH_TIME - overtime

			local flashTexture = _G[button:GetName() .. 'Flash']
			if flashTexture:IsShown() then
				flashTexture:Hide()
			else
				flashTexture:Show()
			end
		end

		button.flashtime = flashtime
	end
end


--[[ Configuration ]]--
function TukuiRange:GetDefaults()
	return {
		normal = {1, 1, 1},
		oor = {1, 0.1, 0.1},
		oom = {0.1, 0.3, 1},
		ooh = {0.45, 0.45, 1},
	}
end

function TukuiRange:Reset()
	TukuiRange_COLORS = {}
	self.colors = copyDefaults(TukuiRange_COLORS, self:GetDefaults())

	self:ForceColorUpdate()
end

function TukuiRange:SetColor(index, r, g, b)
	local color = self.colors[index]
	color[1] = r
	color[2] = g
	color[3] = b

	self:ForceColorUpdate()
end

function TukuiRange:GetColor(index)
	local color = self.colors[index]
	return color[1], color[2], color[3]
end

--[[ Load The Thing ]]--
TukuiRange:Load()
