local T, C, L = select(2, ...):unpack()

local TukuiActionBars = T["ActionBars"]
local Movers = T["Movers"]
local Button = ExtraActionButton1
local Texture = Button.style

function TukuiActionBars:DisableExtraButtonTexture(texture)
	if (string.sub(texture, 1, 9) == "Interface" or string.sub(texture, 1, 9) == "INTERFACE") then
		self:SetTexture("")
	end
end

function TukuiActionBars:SetUpExtraActionButton()
	local Holder = CreateFrame("Frame", "TukuiExtraActionButton", UIParent)
	Holder:Size(160, 80)
	Holder:SetPoint("BOTTOM", 0, 250)
	
	ExtraActionBarFrame:SetParent(UIParent)
	ExtraActionBarFrame:ClearAllPoints()
	ExtraActionBarFrame:SetPoint("CENTER", Holder, "CENTER", 0, 0)
	ExtraActionBarFrame.ignoreFramePositionManager = true
	
	Texture:SetTexture("")
	
	Movers:RegisterFrame(Holder)
end