local T, C = unpack((select(2, ...)))

-- Local values
local MenuFrame = CreateFrame("Frame", "TukuiDataTextToggleDropDown", UIParent, "UIDropDownMenuTemplate")
local DataTexts = T["DataTexts"]
local Anchors = DataTexts.Anchors
local DataMenu = DataTexts.Menu
local Active = false
local CurrentFrame


DataTexts.Toggle = function(self, object)
	CurrentFrame:SetData(object)
end

DataTexts.Remove = function()
	CurrentFrame:RemoveData()
end

local OnMouseDown = function(self)
	if Menu then
		T.Miscellaneous.DropDown.DisplayDataTexts(self)
	else
		T.Miscellaneous.DropDown.Open(DataMenu, MenuFrame, "cursor", 0 , 0, "MENU", 2)
	end
end

function DataTexts:ToggleDataPositions()
	if Active then
		for i = 1, self.NumAnchors do
			local Frame = Anchors[i]

			Frame:EnableMouse(false)
			Frame.Tex:SetColorTexture(0.2, 1, 0.2, 0)
		end

		Active = false
	else
		for i = 1, self.NumAnchors do
			local Frame = Anchors[i]

			Frame:EnableMouse(true)
			Frame.Tex:SetColorTexture(0.2, 1, 0.2, 0.2)
			Frame:SetScript("OnMouseDown", OnMouseDown)
		end

		Active = true
	end
end

function DataTexts:AddRemove()
	-- Add a remove button
	tinsert(DataMenu, {text = "", notCheckable = true})
	tinsert(DataMenu, {text = "|cffFF0000"..REMOVE.."|r", notCheckable = true, func = DataTexts.Remove})
end
