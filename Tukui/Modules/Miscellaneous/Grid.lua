local T, C, L = select(2, ...):unpack()

--------------------------------------------------------------------------------
-- Align by Akeru / http://www.wowinterface.com/downloads/info6153-Align.html --
--------------------------------------------------------------------------------

local Miscellaneous = T["Miscellaneous"]
local Align = CreateFrame("Frame")
Align.Enable = false
Align.BoxSize = 128

function Align:Show()
	if not self.Frame then
		Align:Create()
	elseif self.Frame.boxSize ~= Align.BoxSize then
		self.Frame:Hide()
		Align:Create()
	else
		self.Frame:Show()
	end
end

function Align:Hide()
	if self.Frame then
		self.Frame:Hide()
	end
end

function Align:Create()
	local Frame = CreateFrame('Frame', nil, UIParent)
	Frame.boxSize = Align.BoxSize
	Frame:SetAllPoints(UIParent)

	local Size = 2
	local Width = GetScreenWidth()
	local Ratio = Width / GetScreenHeight()
	local Height = GetScreenHeight() * Ratio
	local WidthStep = Width / Align.BoxSize
	local HeightStep = Height / Align.BoxSize

	for i = 0, Align.BoxSize do
		local Texture = Frame:CreateTexture(nil, 'BACKGROUND')
		if i == Align.BoxSize / 2 then
			Texture:SetColorTexture(1, 0, 0, 0.8)
		else
			Texture:SetColorTexture(0, 0, 0, 0.8)
		end
		Texture:Point("TOPLEFT", Frame, "TOPLEFT", i*WidthStep - (Size/2), 0)
		Texture:Point('BOTTOMRIGHT', Frame, 'BOTTOMLEFT', i*WidthStep + (Size/2), 0)
	end

	Height = GetScreenHeight()

	do
		local Texture = Frame:CreateTexture(nil, 'BACKGROUND')
		Texture:SetColorTexture(1, 0, 0, 0.8)
		Texture:Point("TOPLEFT", Frame, "TOPLEFT", 0, -(Height/2) + (Size/2))
		Texture:Point('BOTTOMRIGHT', Frame, 'TOPRIGHT', 0, -(Height/2 + Size/2))
	end

	for i = 1, math.floor((Height/2)/HeightStep) do
		local Texture = Frame:CreateTexture(nil, 'BACKGROUND')
		Texture:SetColorTexture(0, 0, 0, 0.8)

		Texture:Point("TOPLEFT", Frame, "TOPLEFT", 0, -(Height/2+i*HeightStep) + (Size/2))
		Texture:Point('BOTTOMRIGHT', Frame, 'TOPRIGHT', 0, -(Height/2+i*HeightStep + Size/2))

		Texture = Frame:CreateTexture(nil, 'BACKGROUND')
		Texture:SetColorTexture(0, 0, 0, 0.8)

		Texture:Point("TOPLEFT", Frame, "TOPLEFT", 0, -(Height/2-i*HeightStep) + (Size/2))
		Texture:Point('BOTTOMRIGHT', Frame, 'TOPRIGHT', 0, -(Height/2-i*HeightStep + Size/2))
	end

	self.Frame = Frame
end

SLASH_TOGGLEGRID1 = "/showgrid"
SlashCmdList["TOGGLEGRID"] = function(arg)
	if Align.Enable then
		Align:Hide()
		Align.Enable = false
	else
		Align.BoxSize = (math.ceil((tonumber(arg) or Align.BoxSize) / 32) * 32)
	if Align.BoxSize > 256 then Align.BoxSize = 256 end
		Align:Show()
		Align.Enable = true
	end
end

Miscellaneous.Grid = Align
