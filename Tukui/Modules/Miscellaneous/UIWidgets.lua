local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local UIWidgets = CreateFrame("Frame")

function UIWidgets:Enable()
	local MinimapWidget = UIWidgetBelowMinimapContainerFrame

	-- Hack to avoid UIWidgetBelowMinimapContainerFrame to move in UIParent.lua (L2987)
	MinimapWidget.GetNumWidgetsShowing = function() return 0 end

	-- Create a widget holder
	local Holder = CreateFrame("Frame", "TukuiWidget", UIParent)
	Holder:SetSize(220, 20)
	Holder:SetPoint("TOP", 3, -96)

	-- This is now the frame that contain capture bar and other shit like that.
	MinimapWidget:SetParent(Holder)
	MinimapWidget:ClearAllPoints()
	MinimapWidget:SetPoint("CENTER")
	
	T.Movers:RegisterFrame(Holder, "UI Widgets")
end

Miscellaneous.UIWidgets = UIWidgets

