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
	
	TukuiActionBars.RangeUpdate(self)
end

function TukuiActionBars:RangeUpdate()
	local Name = self:GetName()
	local Icon = _G[Name.."Icon"]
	local NormalTexture = _G[Name.."NormalTexture"]
    local ID = self.action
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