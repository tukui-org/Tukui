local T, C = select(2, ...):unpack()

-- Local values
local MenuFrame = CreateFrame("Frame", "TukuiDataTextToggleDropDown", UIParent, "UIDropDownMenuTemplate")
local TukuiDT = T["DataTexts"]
local Anchors = TukuiDT.Anchors
local Menu = TukuiDT.Menu
local Active = false
local CurrentFrame

TukuiDT.Toggle = function(self, object)
	CurrentFrame:SetData(object)
end

TukuiDT.Remove = function()
	CurrentFrame:RemoveData()
end

local OnMouseDown = function(self)
	CurrentFrame = self

	EasyMenu(Menu, MenuFrame, "cursor", 0 , 0, "MENU", 2)
end

function TukuiDT:ToggleDataPositions()
	if Active then
		for i = 1, self.NumAnchors do
			local Frame = Anchors[i]
			
			Frame:EnableMouse(false)
			Frame.Tex:SetTexture(0.2, 1, 0.2, 0)
		end
		
		Active = false
	else
		for i = 1, self.NumAnchors do
			local Frame = Anchors[i]
			
			Frame:EnableMouse(true)
			Frame.Tex:SetTexture(0.2, 1, 0.2, 0.2)
			Frame:SetScript("OnMouseDown", OnMouseDown)
		end
		
		Active = true
	end
end

function TukuiDT:AddRemove()
	-- Add a remove button
	tinsert(Menu, {text = "", notCheckable = true})
	tinsert(Menu, {text = "|cffFF0000"..REMOVE.."|r", notCheckable = true, func = TukuiDT.Remove})
end