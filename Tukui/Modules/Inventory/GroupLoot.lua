local T, C, L = select(2, ...):unpack()
local Inventory = T["Inventory"]
local GroupLoot = CreateFrame("Frame")

-- Lib Globals
local select = select
local unpack = unpack
local pairs = pairs

-- WoW Globals
local ITEM_QUALITY_COLORS = ITEM_QUALITY_COLORS
local NUM_GROUP_LOOT_FRAMES = NUM_GROUP_LOOT_FRAMES

-- Locals
GroupLoot.PreviousFrame = {}

function GroupLoot:TestGroupLootFrames()
	GetLootRollItemInfo = function(RollID)
		Texture = 135226
		Name = "Atiesh, Greatstaff of the Guardian"
		Count = RollID
		Quality	= RollID + 1
		BindOnPickUp = math.random(0, 1) > 0.5
		CanNeed	= true
		CanGreed = true
		ReasonNeed = 0
		ReasonGreed = 0

		return Texture, Name, Count, Quality, BindOnPickUp, CanNeed, CanGreed, ReasonNeed, ReasonGreed
	end

	function GroupLootFrame_OnUpdate() end

	for i = 1, NUM_GROUP_LOOT_FRAMES do
		GroupLootFrame_OpenNewFrame(i, 300)
		_G["GroupLootFrame" .. i].Timer:SetValue(math.random(8, 300))
	end
end

function GroupLoot:SkinGroupLoot(Frame)
    if (Frame.IsSkinned) then
		return
	end

	Frame:StripTextures()

	if (Frame.Timer.Background) then
		Frame.Timer.Background:Kill()
	end

	if (_G[Frame:GetName().."NameFrame"] or _G[Frame:GetName().."Corner"]) then
		_G[Frame:GetName().."NameFrame"]:Kill()
		_G[Frame:GetName().."Corner"]:Kill()
	end

	Frame.OverlayContrainerFrame = CreateFrame("Frame", nil, Frame)
	Frame.OverlayContrainerFrame:SetFrameLevel(Frame:GetFrameLevel() - 1)
	Frame.OverlayContrainerFrame:SetSize(233, 32)
	Frame.OverlayContrainerFrame:SetPoint("CENTER", Frame, 0, 0)
	Frame.OverlayContrainerFrame:CreateBackdrop("Transparent")
	Frame.OverlayContrainerFrame:CreateShadow()

	Frame.Name:ClearAllPoints()
	Frame.Name:SetPoint("LEFT", Frame.OverlayContrainerFrame, 6, 0)
	Frame.Name:SetFontTemplate(C.Medias.Font, 12)

	Frame.IconFrame.Count:ClearAllPoints()
	Frame.IconFrame.Count:SetPoint("BOTTOMRIGHT", -2, 4)
	Frame.IconFrame.Count:SetFontTemplate(C.Medias.Font, 12)

	Frame.Timer:CreateBackdrop()
	Frame.Timer:CreateShadow()
	Frame.Timer:StripTextures(true)
	Frame.Timer:SetStatusBarColor(1, 0.82, 0, 0.50)
	Frame.Timer:SetStatusBarTexture(C.Medias.Blank)
	Frame.Timer:ClearAllPoints()
	Frame.Timer:SetSize(Frame.OverlayContrainerFrame:GetWidth() + 1, 8)
	Frame.Timer:SetPoint("BOTTOMLEFT", Frame.OverlayContrainerFrame, 0, -12)
	
	Frame.Timer.Backdrop:SetFrameStrata("BACKGROUND")
	Frame.Timer.Backdrop:SetFrameLevel(0)

	Frame.IconFrame:CreateBackdrop()
	Frame.IconFrame:CreateShadow()
	Frame.IconFrame:SetSize(44, 44)
	Frame.IconFrame:ClearAllPoints()
	Frame.IconFrame:SetPoint("LEFT", Frame.OverlayContrainerFrame, -48, -6)

	Frame.IconFrame.Icon:SetTexCoord(unpack(T.IconCoord))
	Frame.IconFrame.Icon:SetInside()
	Frame.IconFrame.Icon:SetSnapToPixelGrid(false)
	Frame.IconFrame.Icon:SetTexelSnappingBias(0)

	Frame.PassButton:SetSize(24, 24)
	Frame.PassButton:ClearAllPoints()
	Frame.PassButton:SetPoint("RIGHT", Frame.OverlayContrainerFrame, 0, 0)
	Frame.PassButton:SkinCloseButton(nil, nil, 12)

	Frame.GreedButton:SetSize(24, 24)
	Frame.GreedButton:ClearAllPoints()
	Frame.GreedButton:SetPoint("LEFT", Frame.PassButton, -24, -2)

	Frame.NeedButton:SetSize(24, 24)
	Frame.NeedButton:ClearAllPoints()
	Frame.NeedButton:SetPoint("LEFT", Frame.GreedButton, -24, 1)
	
	if not T.Retail then
		hooksecurefunc(Frame, "SetBackdrop", Frame.ClearBackdrop)
	end

	Frame.IsSkinned = true
end

function GroupLoot:UpdateGroupLootContainer()
	for i = 1, NUM_GROUP_LOOT_FRAMES do
		local Frame = _G["GroupLootFrame" .. i]
		local Mover = GroupLoot.Mover

		Frame:ClearAllPoints()

		if (i == 1) then
			Frame:SetPoint("CENTER", Mover, 24, -32)
		else

			Frame:SetPoint("BOTTOM", GroupLoot.PreviousFrame, "BOTTOM", 0, -52)
		end

		GroupLoot.PreviousFrame = Frame
	end
end

function GroupLoot:SkinFrames()
	for i = 1, NUM_GROUP_LOOT_FRAMES do
		local Frame = _G["GroupLootFrame" .. i]
		
		self:SkinGroupLoot(Frame)
	end
end

function GroupLoot:AddMover()
	self.Mover = CreateFrame("Frame", "TukuiGroupLoot", UIParent)
	self.Mover:SetPoint("TOP", UIParent, 0, 0)
	self.Mover:SetSize(284, 22)

	T.Movers:RegisterFrame(self.Mover, "Group Loot")
end

function GroupLoot:AddHooks()
	-- So we can move the Group Loot Container.
	UIPARENT_MANAGED_FRAME_POSITIONS.GroupLootContainer = nil
	
	hooksecurefunc("GroupLootContainer_Update", self.UpdateGroupLootContainer)
end

function GroupLoot:Enable()
	self:AddMover()
	self:SkinFrames()
	self:AddHooks()
	--self:TestGroupLootFrames()
end

Inventory.GroupLoot = GroupLoot
