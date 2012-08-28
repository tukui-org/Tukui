local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	local frame = MissingLootFrame
	local close = MissingLootFramePassButton

	frame:StripTextures()
	frame:SetTemplate("Default")
	frame:CreateShadow()

	MissingLootFramePassButton:SkinCloseButton()
	
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
	
	-- loot history frame
	LootHistoryFrame:StripTextures()
	LootHistoryFrame.CloseButton:SkinCloseButton()
	LootHistoryFrame:StripTextures()
	LootHistoryFrame:SetTemplate()
	LootHistoryFrame.ResizeButton:SkinCloseButton()
	LootHistoryFrame.ResizeButton.t:SetText("v v v v")
	LootHistoryFrame.ResizeButton:SetTemplate()
	LootHistoryFrame.ResizeButton:Width(LootHistoryFrame:GetWidth())
	LootHistoryFrame.ResizeButton:Height(19)
	LootHistoryFrame.ResizeButton:ClearAllPoints()
	LootHistoryFrame.ResizeButton:Point("TOP", LootHistoryFrame, "BOTTOM", 0, -2)
	LootHistoryFrameScrollFrameScrollBar:SkinScrollBar()
	
	local function UpdateLoots(self)
		local numItems = C_LootHistory.GetNumItems()
		for i=1, numItems do
			local frame = self.itemFrames[i]
			
			if not frame.isSkinned then
				frame.NameBorderLeft:Hide()
				frame.NameBorderRight:Hide()
				frame.NameBorderMid:Hide()
				frame.IconBorder:Hide()
				frame.Divider:Hide()
				frame.ActiveHighlight:Hide()
				frame.Icon:SetTexCoord(.08,.88,.08,.88)
				frame.Icon:SetDrawLayer("ARTWORK")
				
				-- create a backdrop around the icon
				frame:CreateBackdrop("Default")
				frame.backdrop:Point("TOPLEFT", frame.Icon, -2, 2)
				frame.backdrop:Point("BOTTOMRIGHT", frame.Icon, 2, -2)
				frame.backdrop:SetBackdropColor(0,0,0,0)
				frame.isSkinned = true
			end
		end
	end
	hooksecurefunc("LootHistoryFrame_FullUpdate", UpdateLoots)
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)