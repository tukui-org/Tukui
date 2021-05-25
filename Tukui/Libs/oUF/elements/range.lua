--[[
# Element: Range Fader

Changes the opacity of a unit frame based on whether the frame's unit is in the player's range.

## Widget

Range - A table containing opacity values.

## Notes

Offline units are handled as if they are in range.

## Options

.outsideAlpha - Opacity when the unit is out of range. Defaults to 0.55 (number)[0-1].
.insideAlpha  - Opacity when the unit is within range. Defaults to 1 (number)[0-1].

## Examples

    -- Register with oUF
    self.Range = {
        insideAlpha = 1,
        outsideAlpha = 1/2,
    }
--]]

local _, ns = ...
local oUF = ns.oUF

local _FRAMES = {}
local OnRangeFrame

local UnitInRange, UnitIsConnected = UnitInRange, UnitIsConnected

local RangeSpellID = {
	["PALADIN"] = 19750,
	["SHAMAN"] = 25357,
	["DRUID"] = 774,
	["PRIEST"] = 2050,
	["WARLOCK"] = 5697,
	["MAGE"] = 475,
}

local function Update(self, event)
	local element = self.Range
	local unit = self.unit

	--[[ Callback: Range:PreUpdate()
	Called before the element has been updated.

	* self - the Range element
	--]]
	if(element.PreUpdate) then
		element:PreUpdate()
	end

	local inRange, checkedRange
	local connected = UnitIsConnected(unit)
	if(connected) then
		if oUF.Retail then
			inRange, checkedRange = UnitInRange(unit)
		else
			local Spell = RangeSpellID[select(2, UnitClass("player"))]
			local IsFriend = UnitIsFriend(unit, "player")
			
			if IsFriend and Spell and IsSpellKnown(Spell) then
				local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(Spell)
				local IsSpellInRangeFromPlayer = IsSpellInRange(name, unit)
				
				if IsSpellInRangeFromPlayer == 1 then
					inRange = true
					checkedRange = true
				else
					inRange = false
					checkedRange = true
				end
			else
				inRange = CheckInteractDistance(unit, 4)
				checkedRange = true
			end
		end
		
		if(checkedRange and not inRange) then
			self:SetAlpha(element.outsideAlpha)
		else
			self:SetAlpha(element.insideAlpha)
		end
	else
		self:SetAlpha(element.insideAlpha)
	end

	--[[ Callback: Range:PostUpdate(object, inRange, checkedRange, isConnected)
	Called after the element has been updated.

	* self         - the Range element
	* object       - the parent object
	* inRange      - indicates if the unit was within 40 yards of the player (boolean)
	* checkedRange - indicates if the range check was actually performed (boolean)
	* isConnected  - indicates if the unit is online (boolean)
	--]]
	if(element.PostUpdate) then
		return element:PostUpdate(self, inRange, checkedRange, connected)
	end
end

local function Path(self, ...)
	--[[ Override: Range.Override(self, event)
	Used to completely override the internal update function.

	* self  - the parent object
	* event - the event triggering the update (string)
	--]]
	return (self.Range.Override or Update) (self, ...)
end

-- Internal updating method
local timer = 0
local function OnRangeUpdate(_, elapsed)
	timer = timer + elapsed

	if(timer >= .20) then
		for _, object in next, _FRAMES do
			if(object:IsShown()) then
				Path(object, 'OnUpdate')
			end
		end

		timer = 0
	end
end

local function Enable(self)
	local element = self.Range
	if(element) then
		element.__owner = self
		element.insideAlpha = element.insideAlpha or 1
		element.outsideAlpha = element.outsideAlpha or 0.55

		if(not OnRangeFrame) then
			OnRangeFrame = CreateFrame('Frame')
			OnRangeFrame:SetScript('OnUpdate', OnRangeUpdate)
		end

		table.insert(_FRAMES, self)
		OnRangeFrame:Show()

		return true
	end
end

local function Disable(self)
	local element = self.Range
	if(element) then
		for index, frame in next, _FRAMES do
			if(frame == self) then
				table.remove(_FRAMES, index)
				break
			end
		end
		self:SetAlpha(element.insideAlpha)

		if(#_FRAMES == 0) then
			OnRangeFrame:Hide()
		end
	end
end

oUF:AddElement('Range', nil, Enable, Disable)
