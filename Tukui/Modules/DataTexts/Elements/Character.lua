local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local format = format
local ClassColor = T.RGBToHex(unpack(T.Colors.class[T.MyClass]))

local LeftTexts = {
	"PlayerStatFrameLeft1",
	"PlayerStatFrameLeft2",
	"PlayerStatFrameLeft3",
	"PlayerStatFrameLeft4",
	"PlayerStatFrameLeft5",
	"PlayerStatFrameLeft6",
}
local RightTexts = {
	"PlayerStatFrameRight1",
	"PlayerStatFrameRight2",
	"PlayerStatFrameRight3",
	"PlayerStatFrameRight4",
	"PlayerStatFrameRight5",
	"PlayerStatFrameRight6",
}

local CharacterStatFrame ={
	"CharacterStatFrame1",
	"CharacterStatFrame2",
	"CharacterStatFrame3",
	"CharacterStatFrame4",
	"CharacterStatFrame5",
}

local Update = function(self)
	local Total = 0
	local Current, Max

	for i = 1, 11 do
		if (GetInventoryItemLink("player", L.DataText.Slots[i][1]) ~= nil) then
			Current, Max = GetInventoryItemDurability(L.DataText.Slots[i][1])

			if Current then
				L.DataText.Slots[i][3] = Current / Max

				Total = Total + 1
			end
		end
	end

	table.sort(L.DataText.Slots, function(a, b) return a[3] < b[3] end)

	self.Text:SetText(ClassColor..T.MyName.."|r".." ("..floor(L.DataText.Slots[1][3] * 100).."%)")
end

local OnEnter = function(self)
	PaperDollFrame_UpdateStats()

	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()

	if T.Retail then
		local Objects = CharacterStatsPane.statsFramePool.activeObjects

		-- Sort attributes
		GameTooltip:AddDoubleLine(ClassColor..T.MyName.."|r", T.MyRealm)
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("|CFFFFFFFF"..PET_BATTLE_STATS_LABEL.."|r")
		GameTooltip:AddDoubleLine("|CF00FFF00"..LEVEL.."|r", UnitLevel("player"))
		GameTooltip:AddDoubleLine("|CF00FFF00"..ITEM_UPGRADE_STAT_AVERAGE_ITEM_LEVEL.."|r", GetAverageItemLevel())
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("|CFFFFFFFF"..STAT_CATEGORY_ATTRIBUTES.."|r")

		for Table in pairs(Objects) do
			local Label = Table.Label:GetText()
			local Value = Table.Value:GetText()
			local Percent = string.find(Value, "%%")


			if not Percent then
				GameTooltip:AddDoubleLine("|CF00FFF00"..Label.."|r", "|CFFFFFFFF"..Value.."|r")
			end
		end

		-- Sort enhancements
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("|CFFFFFFFF"..STAT_CATEGORY_ENHANCEMENTS.."|r")

		for Table in pairs(Objects) do
			local Label = Table.Label:GetText()
			local Value = Table.Value:GetText()
			local Percent = string.find(Value, "%%")

			if Percent then
				GameTooltip:AddDoubleLine("|CFFFFFF00"..Label.."|r", "|CFFFFFFFF"..Value.."|r")
			end
		end

		GameTooltip:AddLine(" ")
	end

	if T.BCC or T.WotLK then
		local IsAlternativeTooltip = IsShiftKeyDown() or IsAltKeyDown()

		GameTooltip:AddDoubleLine(ClassColor..T.MyName.."|r "..UnitLevel("player"), T.MyRealm)
		GameTooltip:AddLine(" ")

		-- Display left stats
		for _, Frame in pairs(LeftTexts) do
			local Name = _G[Frame.."Label"]
			local Value = _G[Frame.."StatText"]
			local Tooltip = _G[Frame].tooltip2
			local StatName, StatValue

			if Name:GetText() then
				StatName = "|cffff8000"..Name:GetText().."|r"
			end

			if Value:GetText() then
				StatValue = "|cffffffff"..Value:GetText().."|r"
			end

			if StatName and StatValue then
				if IsAlternativeTooltip then
					GameTooltip:AddLine("|CF00FFF00"..StatName.."|r |CFFFFFFFF"..StatValue.."|r")
				else
					GameTooltip:AddDoubleLine("|CF00FFF00"..StatName.."|r", "|CFFFFFFFF"..StatValue.."|r")
				end

				if Tooltip and IsAlternativeTooltip then
					-- Remove double enter, for gaining tooltip space
					Tooltip = string.gsub(Tooltip, "\n\n", " ")

					GameTooltip:AddLine(Tooltip, .75, .75, .75)
					GameTooltip:AddLine(" ")
				end
			end
		end

		-- Display right stats
		for _, Frame in pairs(RightTexts) do
			local Name = _G[Frame.."Label"]
			local Value = _G[Frame.."StatText"]
			local Tooltip = _G[Frame].tooltip2
			local StatName, StatValue

			if Name:GetText() then
				StatName = "|cffff8000"..Name:GetText().."|r"
			end

			if Value:GetText() then
				StatValue = "|cffffffff"..Value:GetText().."|r"
			end

			if StatName and StatValue then
				if IsAlternativeTooltip then
					GameTooltip:AddLine("|CF00FFF00"..StatName.."|r |CFFFFFFFF"..StatValue.."|r")
				else
					GameTooltip:AddDoubleLine("|CF00FFF00"..StatName.."|r", "|CFFFFFFFF"..StatValue.."|r")
				end

				if Tooltip and IsAlternativeTooltip then
					-- Remove double enter, for gaining tooltip space
					Tooltip = string.gsub(Tooltip, "\n\n", "\n")

					GameTooltip:AddLine(Tooltip, .75, .75, .75)
					GameTooltip:AddLine(" ")
				end
			end
		end

		if not IsShiftKeyDown() then
			GameTooltip:AddLine(" ")
		end
	end

	if T.Classic then
		GameTooltip:AddDoubleLine(ClassColor..T.MyName.."|r "..UnitLevel("player"), T.MyRealm)
		GameTooltip:AddLine(" ")

		for _, Frame in pairs(CharacterStatFrame) do
			local Name = _G[Frame.."Label"]
			local Value = _G[Frame.."StatText"]
			local Tooltip = _G[Frame].tooltip2
			local StatName, StatValue

			if Name:GetText() then
				StatName = "|cffff8000"..Name:GetText().."|r"
			end

			if Value:GetText() then
				StatValue = "|cffffffff"..Value:GetText().."|r"
			end

			if StatName and StatValue then
				if IsAlternativeTooltip then
					GameTooltip:AddLine("|CF00FFF00"..StatName.."|r |CFFFFFFFF"..StatValue.."|r")
				else
					GameTooltip:AddDoubleLine("|CF00FFF00"..StatName.."|r", "|CFFFFFFFF"..StatValue.."|r")
				end

				if Tooltip and IsAlternativeTooltip then
					-- Remove double enter, for gaining tooltip space
					Tooltip = string.gsub(Tooltip, "\n\n", " ")

					GameTooltip:AddLine(Tooltip, .75, .75, .75)
					GameTooltip:AddLine(" ")
				end
			end
		end

		if not IsShiftKeyDown() then
			GameTooltip:AddLine(" ")
		end
	end

	-- Display durability
	GameTooltip:AddDoubleLine("|CFFFF8000"..DURABILITY..":|r", floor(L.DataText.Slots[1][3] * 100).."%")

	for i = 1, 11 do
		if (L.DataText.Slots[i][3] ~= 1000) then
			local Green, Red

			Green = L.DataText.Slots[i][3] * 2
			Red = 1 - Green

			GameTooltip:AddDoubleLine(L.DataText.Slots[i][2]..":", floor(L.DataText.Slots[i][3] * 100).."%", .75, .75, .75, Red + 1, Green, 0)
		end
	end

	GameTooltip:Show()
end

local ToggleCharacter = function(self)
	if InCombatLockdown() then
		T.Print(ERR_NOT_IN_COMBAT)

		return
	end

	ToggleCharacter("PaperDollFrame")
end

local Enable = function(self)
	self:RegisterEvent("MERCHANT_SHOW")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
	self:SetScript("OnEvent", Update)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", GameTooltip_Hide)
	self:SetScript("OnMouseDown", ToggleCharacter)
	self:Update()
	self.Text:SetText(ClassColor..T.MyName.."|r")
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
end

DataText:Register("Character", Enable, Disable, Update)
