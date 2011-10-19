local T, C, L = unpack(select(2, ...))
if T.toc < 40300 then return end

-- create the holder to allow moving extra button
local holder = CreateFrame("Frame", "TukuiExtraActionBarFrameHolder", UIParent)
holder:Size(160, 80)
holder:SetPoint("BOTTOM", 0, 250)
holder:SetMovable(true)
holder:SetTemplate("Default")
holder:SetBackdropBorderColor(0,0,0,0)
holder:SetBackdropColor(0,0,0,0)	
holder.text = T.SetFontString(holder, C.media.uffont, 12)
holder.text:SetPoint("CENTER")
holder.text:SetText(L.move_extrabutton)
holder.text:Hide()

-- We never use MainMenuBar, so we need to parent this frame outside of it else it will not work.
ExtraActionBarFrame:SetParent(holder)
ExtraActionBarFrame:ClearAllPoints()
ExtraActionBarFrame:SetPoint("CENTER", holder, "CENTER", 0, 0)
