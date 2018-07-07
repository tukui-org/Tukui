local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local UIWidgets = CreateFrame("Frame")

function UIWidgets:Enable()
	local MinimapWidget = UIWidgetBelowMinimapContainerFrame
	
	-- Hack to avoid UIWidgetBelowMinimapContainerFrame to move in UIParent.lua (L2987)
	MinimapWidget.GetHeight = function() return 0 end
	
	-- This is now the frame that contain capture bar and other shit like that.
	MinimapWidget:ClearAllPoints()
	MinimapWidget:SetPoint("TOP", 3, -66)
end

Miscellaneous.UIWidgets = UIWidgets

