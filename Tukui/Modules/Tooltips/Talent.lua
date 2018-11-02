local T, C, L = select(2, ...):unpack()

local Tooltips = T["Tooltips"]
local Talent = CreateFrame("Frame")
local format = string.format

Talent.Cache = {}
Talent.LastInspectRequest = 0
Talent.SlotNames = {
	"Head",
	"Neck",
	"Shoulder",
	"Back",
	"Chest",
	"Wrist",
	"Hands",
	"Waist",
	"Legs",
	"Feet",
	"Finger0",
	"Finger1",
	"Trinket0",
	"Trinket1",
	"MainHand",
	"SecondaryHand"
}

function Talent:GetItemLevel(unit)
	local Total, Item = 0, 0
	local ArtifactEquipped = false
	local TotalSlots = 16

	for i = 1, #Talent.SlotNames do
		local ItemLink = GetInventoryItemLink(unit, GetInventorySlotInfo(("%sSlot"):format(Talent.SlotNames[i])))

		if (ItemLink ~= nil) then
			local _, _, Rarity, _, _, _, _, _, EquipLoc = GetItemInfo(ItemLink)

			--Check if we have an artifact equipped in main hand
			if (EquipLoc and EquipLoc == "INVTYPE_WEAPONMAINHAND" and Rarity and Rarity == 6) then
				ArtifactEquipped = true
			end

			--If we have artifact equipped in main hand, then we should not count the offhand as it displays an incorrect item level
			if (not ArtifactEquipped or (ArtifactEquipped and EquipLoc and EquipLoc ~= "INVTYPE_WEAPONOFFHAND")) then
				local ItemLevel

				ItemLevel = GetDetailedItemLevelInfo(ItemLink)

				if(ItemLevel and ItemLevel > 0) then
					Item = Item + 1
					Total = Total + ItemLevel
				end

				-- Total slots depend if one/two handed weapon
				if (i == 15) then
					if (ArtifactEquipped or (EquipLoc and EquipLoc == "INVTYPE_2HWEAPON")) then
						TotalSlots = 15
					end
				end
			end
		end
	end

	if(Total < 1 or Item < TotalSlots) then
		return
	end

	return floor(Total / Item)
end

function Talent:GetTalentSpec(unit)
	local Spec

	if not unit then
		Spec = GetSpecialization()
	else
		Spec = GetInspectSpecialization(unit)
	end

	if(Spec and Spec > 0) then
		if (unit) then
			local Role = GetSpecializationRoleByID(Spec)

			if (Role) then
				local Name = select(2, GetSpecializationInfoByID(Spec))

				return Name
			end
		else
			local Name = select(2, GetSpecializationInfo(Spec))

			return Name
		end
	end
end

Talent:SetScript("OnEvent", function(self, event, ...)
	if event == "MODIFIER_STATE_CHANGED" then
		local Button, Pressed = ...
		local GetMouseFocus = GetMouseFocus()
		local Unit = (select(2, GameTooltip:GetUnit())) or (GetMouseFocus and GetMouseFocus.GetAttribute and GetMouseFocus:GetAttribute("unit"))

		if Button == "LALT" and Pressed == 1 then
			if Unit then
				local IsInspectable = CanInspect(Unit)
				local IsPlayer = UnitIsPlayer(Unit)
				local IsFriend = UnitIsFriend("player", Unit)

				self.CurrentGUID = UnitGUID(Unit)

				if IsPlayer and IsFriend and IsInspectable then
					self:RegisterEvent("INSPECT_READY")

					NotifyInspect(Unit)
				end
			end
		end
	else
		self:UnregisterEvent("INSPECT_READY")

		local GUID = UnitGUID("mouseover")

		if self.CurrentGUID == GUID and IsAltKeyDown() then
			self.ILevel = self:GetItemLevel("mouseover")
			self.Spec = self:GetTalentSpec("mouseover")
			self.CurrentGUID = nil

			GameTooltip:SetUnit("mouseover")
		end

		ClearInspectPlayer()
	end
end)

Tooltips.Talent = Talent
