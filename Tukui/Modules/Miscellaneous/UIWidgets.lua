local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local UIWidgets = CreateFrame("Frame")

function UIWidgets:SkinUIWidgetStatusBar(widgetInfo, widgetContainer)
	local Bar = self.Bar
	
	if Bar and not Bar.IsSkinned then
		Bar.BGLeft:SetAlpha(0)
		Bar.BGRight:SetAlpha(0)
		Bar.BGCenter:SetAlpha(0)
		Bar.BorderLeft:SetAlpha(0)
		Bar.BorderRight:SetAlpha(0)
		Bar.BorderCenter:SetAlpha(0)
		Bar:CreateBackdrop()
		
		Bar.Backdrop:CreateShadow()
		Bar.Backdrop:SetFrameLevel(Bar:GetFrameLevel())
		Bar.Backdrop:SetOutside(Bar)
		
		Bar.IsSkinned = true
	end

	if self:GetParent() == UIWidgetPowerBarContainerFrame then
		Bar:ClearAllPoints()
		Bar:SetPoint("CENTER", UIWidgets.Holder, "CENTER", 0, 0)
	end
end

function UIWidgets:Enable()
	local MinimapWidget = UIWidgetBelowMinimapContainerFrame

	-- Hack to avoid UIWidgetBelowMinimapContainerFrame to move in UIParent.lua (L2987)
	MinimapWidget.GetNumWidgetsShowing = function() return 0 end

	-- Create a widget holder
	self.Holder = CreateFrame("Frame", "TukuiWidget", UIParent)
	self.Holder:SetSize(220, 20)
	self.Holder:SetPoint("TOP", 3, -96)

	-- This is now the frame that contain capture bar and other shit like that.
	MinimapWidget:SetParent(self.Holder)
	MinimapWidget:ClearAllPoints()
	MinimapWidget:SetPoint("CENTER")
	
	-- Skin status bars
	hooksecurefunc(UIWidgetTemplateStatusBarMixin, "Setup", self.SkinUIWidgetStatusBar)
	
	T.Movers:RegisterFrame(self.Holder, "UI Widgets")
end

Miscellaneous.UIWidgets = UIWidgets