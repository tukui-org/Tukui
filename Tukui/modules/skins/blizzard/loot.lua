local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	local frame = MissingLootFrame
	local close = MissingLootFramePassButton

	frame:StripTextures()
	frame:SetTemplate("Default")

	T.SkinCloseButton(MissingLootFramePassButton)
	
	local function SkinButton()
		local number = GetNumMissingLootItems()
		for i = 1, number do
			local slot = _G["MissingLootFrameItem"..i]
			local icon = slot.icon
			
			if not slot.isSkinned then
				slot:StripTextures()
				slot:SetTemplate("Default")
				slot:StyleButton()
				icon:SetTexCoord(.08, .92, .08, .92)
				icon:ClearAllPoints()
				icon:Point("TOPLEFT", 2, -2)
				icon:Point("BOTTOMRIGHT", -2, 2)
				
				slot.isSkinned = true
			end
			
			local quality = select(4, GetMissingLootItemInfo(i))
			local color = (GetItemQualityColor(quality)) or (unpack(C.media.bordercolor))
			frame:SetBackdropBorderColor(color)
		end
	end
	hooksecurefunc("MissingLootFrame_Show", SkinButton)
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)