local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
-- GhostFrame at top
GhostFrame:SetTemplate("Default")
GhostFrame:SetBackdropColor(0,0,0,0)
GhostFrame:SetBackdropBorderColor(0,0,0,0)
GhostFrame.SetBackdropColor = T.dummy
GhostFrame.SetBackdropBorderColor = T.dummy
GhostFrameContentsFrame:SetTemplate("Default")
GhostFrameContentsFrame:CreateShadow()
GhostFrameContentsFrameIcon:SetTexture(nil)
GhostFrameContentsFrame:Width(148)
GhostFrameContentsFrame:ClearAllPoints()
GhostFrameContentsFrame:SetPoint("CENTER")
GhostFrameContentsFrame.SetPoint = T.dummy
GhostFrame:SetFrameStrata("HIGH")
GhostFrame:SetFrameLevel(10)
GhostFrame:ClearAllPoints()
GhostFrame:Point("TOP", UIParent, 0, 26)
GhostFrameContentsFrameText:ClearAllPoints()
GhostFrameContentsFrameText:Point("BOTTOM", 0, 5)