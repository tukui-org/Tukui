local T, C, L = select(2, ...):unpack()
local Miscellaneous = T["Miscellaneous"]
local Grid = CreateFrame("Frame")

Grid.Enable = false
Grid.BoxSize = 128

function Grid:Show()
	if not self.Frame then
		Grid:Create()
	elseif self.Frame.boxSize ~= Grid.BoxSize then
		self.Frame:Hide()
		Grid:Create()
	else
		self.Frame:Show()
	end
end

function Grid:Hide()
	if self.Frame then
		self.Frame:Hide()
	end
end

function Grid:Create()
	local Frame = CreateFrame("Frame", nil, UIParent)
	
	Frame.boxSize = Grid.BoxSize
	Frame:SetAllPoints(UIParent)

	local Size = 2
	local Width = GetScreenWidth()
	local Ratio = Width / GetScreenHeight()
	local Height = GetScreenHeight() * Ratio
	local WidthStep = Width / Grid.BoxSize
	local HeightStep = Height / Grid.BoxSize

	for i = 0, Grid.BoxSize do
		local Texture = Frame:CreateTexture(nil, "BACKGROUND")
		if i == Grid.BoxSize / 2 then
			Texture:SetColorTexture(1, 0, 0, 0.8)
		else
			Texture:SetColorTexture(0, 0, 0, 0.8)
		end
		Texture:SetPoint("TOPLEFT", Frame, "TOPLEFT", i*WidthStep - (Size/2), 0)
		Texture:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMLEFT", i*WidthStep + (Size/2), 0)
	end

	Height = GetScreenHeight()

	do
		local Texture = Frame:CreateTexture(nil, "BACKGROUND")
		Texture:SetColorTexture(1, 0, 0, 0.8)
		Texture:SetPoint("TOPLEFT", Frame, "TOPLEFT", 0, -(Height/2) + (Size/2))
		Texture:SetPoint("BOTTOMRIGHT", Frame, "TOPRIGHT", 0, -(Height/2 + Size/2))
	end

	for i = 1, math.floor((Height/2)/HeightStep) do
		local Texture = Frame:CreateTexture(nil, "BACKGROUND")
		Texture:SetColorTexture(0, 0, 0, 0.8)

		Texture:SetPoint("TOPLEFT", Frame, "TOPLEFT", 0, -(Height/2+i*HeightStep) + (Size/2))
		Texture:SetPoint("BOTTOMRIGHT", Frame, "TOPRIGHT", 0, -(Height/2+i*HeightStep + Size/2))

		Texture = Frame:CreateTexture(nil, "BACKGROUND")
		Texture:SetColorTexture(0, 0, 0, 0.8)

		Texture:SetPoint("TOPLEFT", Frame, "TOPLEFT", 0, -(Height/2-i*HeightStep) + (Size/2))
		Texture:SetPoint("BOTTOMRIGHT", Frame, "TOPRIGHT", 0, -(Height/2-i*HeightStep + Size/2))
	end

	self.Frame = Frame
end

SLASH_TOGGLEGRID1 = "/showgrid"
SlashCmdList["TOGGLEGRID"] = function(arg)
	if Grid.Enable then
		Grid:Hide()
		Grid.Enable = false
	else
		Grid.BoxSize = (math.ceil((tonumber(arg) or Grid.BoxSize) / 32) * 32)
	if Grid.BoxSize > 256 then Grid.BoxSize = 256 end
		Grid:Show()
		Grid.Enable = true
	end
end

Miscellaneous.Grid = Grid
