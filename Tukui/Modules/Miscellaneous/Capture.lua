local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local Capture = CreateFrame("Frame")

function Capture:Update()
	local Frames = NUM_EXTENDED_UI_FRAMES
	
	if Frames then
		for i=1, NUM_EXTENDED_UI_FRAMES do
			local Bar = _G["WorldStateCaptureBar" .. i]

			if Bar and Bar:IsVisible() then
				Bar:ClearAllPoints()

				if (i == 1) then
					Bar:Point("TOP", UIParent, "TOP", 0, -120)
				else
					Bar:Point("TOPLEFT", _G["WorldStateCaptureBar" .. i - 1], "TOPLEFT", 0, -25)
				end
			end
		end
	end
end

function Capture:Enable()
	hooksecurefunc("UIParent_ManageFramePositions", Capture.Update)
end

Miscellaneous.Capture = Capture