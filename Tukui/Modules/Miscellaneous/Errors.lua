local T, C, L = select(2, ...):unpack()

local Errors = CreateFrame("Frame")
local Miscellaneous = T["Miscellaneous"]

function Errors:Enable()
	local Font = T.GetFont(C.Misc.UIErrorFont)
	local Path, Size, Flag = _G[Font]:GetFont()
	
	UIErrorsFrame:SetFont(Path, C.Misc.UIErrorSize or 16, Flag)
	UIErrorsFrame:ClearAllPoints()
	UIErrorsFrame:SetPoint("TOP", 0, -300)
	
	T.Movers:RegisterFrame(UIErrorsFrame, "UI Errors")
end

Miscellaneous.Errors = Errors
