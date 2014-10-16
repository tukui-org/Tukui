local T, C, L = select(2, ...):unpack()
local Inventory = T["Inventory"]
local Movers = T["Movers"]
local Loot = CreateFrame("Frame")
local LootFrame = LootFrame
local TopFrame = CreateFrame("Frame", nil, LootFrame)

function Loot:Move()
	local IsUnderMouse = GetCVar("lootUnderMouse")
	
	if (IsUnderMouse ~= "1") then
		if not LootFrame.DragInfo then
			Movers:RegisterFrame(LootFrame)
		end
		
		if (not TukuiDataPerChar.Move) then
			TukuiDataPerChar.Move = {}
		end
		
		if not (TukuiDataPerChar.Move.LootFrame) then
			TukuiDataPerChar.Move.LootFrame = {"TOPLEFT", UIParent, "TOPLEFT", 16, -116}
		end
		
		LootFrame:ClearAllPoints()
		LootFrame:SetPoint(unpack(TukuiDataPerChar.Move.LootFrame))
	end
end

function Loot:SkinLootFrame()
	LootFrame:StripTextures()
	LootFrameInset:StripTextures()
	LootFrameInset:CreateBackdrop("Transparent")
	LootFrameInset.Backdrop:CreateShadow()
	LootFramePortraitOverlay:SetAlpha(0)
	
	LootFrameDownButton:StripTextures()
	LootFrameDownButton:Size(LootFrame:GetWidth() - 6, 23)
	LootFrameDownButton:SkinButton()
	LootFrameDownButton:FontString("Text", C.Medias.Font, 12)
	LootFrameDownButton.Text:SetPoint("CENTER")
	LootFrameDownButton.Text:SetText(NEXT)
	LootFrameDownButton:ClearAllPoints()
	LootFrameDownButton:Point("TOP", LootFrame, "BOTTOM", -1, -1)
	LootFrameDownButton:CreateShadow()
	LootFrameNext:SetAlpha(0)
	
	LootFrameUpButton:StripTextures()
	LootFrameUpButton:Size(LootFrame:GetWidth() - 6, 23)
	LootFrameUpButton:SkinButton()
	LootFrameUpButton:FontString("Text", C.Medias.Font, 12)
	LootFrameUpButton.Text:SetPoint("CENTER")
	LootFrameUpButton.Text:SetText(PREV)
	LootFrameUpButton:ClearAllPoints()
	LootFrameUpButton:Point("TOP", LootFrameDownButton, "BOTTOM", 0, -2)
	LootFrameUpButton:CreateShadow()
	LootFramePrev:SetAlpha(0)

	TopFrame:Size(LootFrame:GetWidth() - 6, 23)
	TopFrame:SetFrameLevel(LootFrame:GetFrameLevel())
	TopFrame:Point("TOPLEFT", 2, -32)
	TopFrame:SetTemplate("Transparent")
	TopFrame:CreateShadow()

	LootFrameCloseButton:SkinCloseButton()
	LootFrameCloseButton:ClearAllPoints()
	LootFrameCloseButton:SetPoint("RIGHT", TopFrame, "RIGHT", 8, 0)

	local ItemText = select(19, LootFrame:GetRegions())
	
	ItemText:ClearAllPoints()
	ItemText:SetPoint("LEFT", TopFrame, "LEFT", 6, 0)
end

function Loot:SkinLootFrameButtons(i)
	for i = 1, LootFrame.numLootItems do
		local Button = _G["LootButton" .. i]
		local Slot = (LOOTFRAME_NUMBUTTONS * (LootFrame.page - 1)) + i
		
		if Button then
			local Icon = _G["LootButton" .. i .. "IconTexture"]
			local Quest = _G["LootButton" .. i .. "IconQuestTexture"]
			local IconTexture = Icon:GetTexture()
			local IsQuestItem, QuestID, IsActive = select(6, GetLootSlotInfo(Slot))
			
			if (not Button.IsSkinned) then
				Button:StripTextures()
				Button:CreateBackdrop()
				Button.Backdrop:SetOutside(Icon)
				
				Icon:SetTexture(IconTexture)
				Icon:SetTexCoord(unpack(T.IconCoord))
				Icon:SetInside()
				
				Quest:SetAlpha(0)
				
				Button.IsSkinned = true
			end
			
			if (QuestID and not IsActive) then
				Button.Backdrop:SetBackdropBorderColor(0.97, 0.85, 0.31) -- Quest item
			elseif (QuestID or IsQuestItem) then
				Button.Backdrop:SetBackdropBorderColor(0.97, 0.85, 0.31) -- Quest item
			else
				Button.Backdrop:SetBackdropBorderColor(unpack(C.General.BorderColor)) -- Recolor if the previous item in the slot was a quest item
			end
		end
	end
end

function Loot:AddHooks()
	hooksecurefunc("LootFrame_UpdateButton", self.SkinLootFrameButtons)
	hooksecurefunc("LootFrame_Show", self.Move)
end

function Loot:Enable()
	self:SkinLootFrame()
	self:AddHooks()
end

Inventory.Loot = Loot