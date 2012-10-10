local T, C, L, G = unpack(select(2, ...))
if not C.actionbar.enable then return end

-- create the holder to allow moving extra button
local holder = CreateFrame("Frame", "TukuiExtraActionBarFrameHolder", UIParent)
holder:Size(160, 80)
holder:SetPoint("BOTTOM", 0, 250)
holder:SetMovable(true)
holder:SetTemplate("Default")
holder:SetBackdropBorderColor(1,0,0)
holder:SetAlpha(0)
holder.text = T.SetFontString(holder, C.media.uffont, 12)
holder.text:SetPoint("CENTER")
holder.text:SetText(L.move_extrabutton)
holder.text:Hide()
tinsert(T.AllowFrameMoving, TukuiExtraActionBarFrameHolder)

ExtraActionBarFrame:SetParent(UIParent)
ExtraActionBarFrame:ClearAllPoints()
ExtraActionBarFrame:SetPoint("CENTER", holder, "CENTER", 0, 0)
ExtraActionBarFrame.ignoreFramePositionManager = true

G.ActionBars.BarExtra = ExtraActionBarFrame
G.ActionBars.BarExtra.Button1 = ExtraActionButton1
G.ActionBars.BarExtra.Holder = holder

-- hook the texture, idea by roth via WoWInterface forums
local button = ExtraActionButton1
local icon = button.icon
local texture = button.style
local disableTexture = function(style, texture)
	-- look like sometime the texture path is set to capital letter instead of lower-case
	if string.sub(texture,1,9) == "Interface" or string.sub(texture,1,9) == "INTERFACE" then
		style:SetTexture("")
	end
end
button.style:SetTexture("")
hooksecurefunc(texture, "SetTexture", disableTexture)