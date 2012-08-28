local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	InspectFrame:StripTextures(true)
	InspectFrameInset:StripTextures(true)
	InspectFrame:CreateBackdrop("Default")
	InspectFrame.backdrop:SetAllPoints()
	InspectFrameCloseButton:SkinCloseButton()
	
	for i=1, 4 do
		_G["InspectFrameTab"..i]:SkinTab()
	end
	
	InspectModelFrameBorderTopLeft:Kill()
	InspectModelFrameBorderTopRight:Kill()
	InspectModelFrameBorderTop:Kill()
	InspectModelFrameBorderLeft:Kill()
	InspectModelFrameBorderRight:Kill()
	InspectModelFrameBorderBottomLeft:Kill()
	InspectModelFrameBorderBottomRight:Kill()
	InspectModelFrameBorderBottom:Kill()
	InspectModelFrameBorderBottom2:Kill()
	InspectModelFrameBackgroundOverlay:Kill()
	InspectModelFrame:CreateBackdrop("Default")
	
		local slots = {
			"HeadSlot",
			"NeckSlot",
			"ShoulderSlot",
			"BackSlot",
			"ChestSlot",
			"ShirtSlot",
			"TabardSlot",
			"WristSlot",
			"HandsSlot",
			"WaistSlot",
			"LegsSlot",
			"FeetSlot",
			"Finger0Slot",
			"Finger1Slot",
			"Trinket0Slot",
			"Trinket1Slot",
			"MainHandSlot",
			"SecondaryHandSlot",
		}
		for _, slot in pairs(slots) do
			local icon = _G["Inspect"..slot.."IconTexture"]
			local slot = _G["Inspect"..slot]
			slot:StripTextures()
			slot:StyleButton(false)
			icon:SetTexCoord(.08, .92, .08, .92)
			icon:ClearAllPoints()
			icon:Point("TOPLEFT", 2, -2)
			icon:Point("BOTTOMRIGHT", -2, 2)
			
			slot:SetFrameLevel(slot:GetFrameLevel() + 2)
			slot:CreateBackdrop("Default")
			slot.backdrop:SetAllPoints()
		end		
	
	InspectPVPFrameBottom:Kill()
	InspectGuildFrameBG:Kill()
	InspectPVPFrame:HookScript("OnShow", function() InspectPVPFrameBG:Kill() end)
	
	for i=1, 3 do
		_G["InspectPVPTeam"..i]:StripTextures()
	end
	
	InspectTalentFrame:StripTextures()
end

T.SkinFuncs["Blizzard_InspectUI"] = LoadSkin