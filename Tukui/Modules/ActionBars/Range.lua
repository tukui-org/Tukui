local T, C, L = select(2, ...):unpack()

local _G = _G
local TukuiActionBars = T["ActionBars"]
local IsUsableAction = IsUsableAction
local IsActionInRange = IsActionInRange
local ActionHasRange = ActionHasRange
local HasAction = HasAction

function TukuiActionBars:RangeOnUpdate(elapsed)
	if (not self.rangeTimer) then
		return
	end

	if ( self.rangeTimer == TOOLTIP_UPDATE_TIME ) then
		TukuiActionBars.RangeUpdate(self)
	end
end

function TukuiActionBars:RangeUpdate()
	local Icon = self.icon
	local NormalTexture = self.NormalTexture
    local ID = self.action

	if not ID then return end

	local IsUsable, NotEnoughMana = IsUsableAction(ID)
	local HasRange = ActionHasRange(ID)
	local InRange = IsActionInRange(ID)

	if IsUsable then -- Usable
		if (HasRange and InRange == false) then -- Out of range
			Icon:SetVertexColor(0.8, 0.1, 0.1)
			NormalTexture:SetVertexColor(0.8, 0.1, 0.1)
		else -- In range
			Icon:SetVertexColor(1.0, 1.0, 1.0)
			NormalTexture:SetVertexColor(1.0, 1.0, 1.0)
		end
	elseif NotEnoughMana then -- Not enough power
		Icon:SetVertexColor(0.1, 0.3, 1.0)
		NormalTexture:SetVertexColor(0.1, 0.3, 1.0)
	else -- Not usable
		Icon:SetVertexColor(0.3, 0.3, 0.3)
		NormalTexture:SetVertexColor(0.3, 0.3, 0.3)
	end
end

hooksecurefunc("ActionButton_OnUpdate", TukuiActionBars.RangeOnUpdate)
hooksecurefunc("ActionButton_Update", TukuiActionBars.RangeUpdate)
hooksecurefunc("ActionButton_UpdateUsable", TukuiActionBars.RangeUpdate)