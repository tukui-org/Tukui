local T, C, L, G = unpack(select(2, ...)) 
if not C["actionbar"].enable == true or not T.lowversion then return end

TukuiBar5:SetWidth((T.buttonsize * 3) + (T.buttonspacing * 4))

local bar = TukuiBar6
bar:SetAlpha(1)
MultiBarBottomLeft:SetParent(bar)

-- setup the bar
for i=1, 12 do
	local b = _G["MultiBarBottomLeftButton"..i]
	local b2 = _G["MultiBarBottomLeftButton"..i-1]
	b:SetSize(T.buttonsize, T.buttonsize)
	b:ClearAllPoints()
	b:SetFrameStrata("BACKGROUND")
	b:SetFrameLevel(15)
	
	if i == 1 then
		b:SetPoint("TOPLEFT", bar, T.buttonspacing, -T.buttonspacing)
	else
		b:SetPoint("TOP", b2, "BOTTOM", 0, -T.buttonspacing)
	end
	
	G.ActionBars.Bar6["Button"..i] = b
end

RegisterStateDriver(bar, "visibility", "[vehicleui][petbattle][overridebar] hide; show")