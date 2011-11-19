local T, C, L = unpack(select(2, ...))

-- Bags & Bank
if C["bags"].enable == true then return end	

local function LoadSkin()
	-- BAGS
	for i = 1, 5 do
		local bag = _G["ContainerFrame"..i]
		if bag then
			bag:StripTextures(true)
			bag:CreateBackdrop("Default")
			bag.backdrop:CreateShadow("Default")
			bag.backdrop:Point("TOPLEFT", 4, -2)
			bag.backdrop:Point("BOTTOMRIGHT", 1, 1)
			T.SkinCloseButton(_G["ContainerFrame"..i.."CloseButton"], _G["ContainerFrame"..i.."CloseButton"].backdrop)

			--Slots
			for j = 1, 36 do
				local icon = _G["ContainerFrame"..i.."Item"..j.."IconTexture"]
				local slots = _G["ContainerFrame"..i.."Item"..j]

				T.SkinButton(slots)
				icon:SetTexCoord(.08, .92, .08, .92)
				icon:ClearAllPoints()
				icon:SetAllPoints()
				icon:Point("TOPLEFT", slots, 2, -2)
				icon:Point("BOTTOMRIGHT", slots, -2, 2)
			end
		end
		
		BackpackTokenFrame:StripTextures()
	end
	
	if T.toc >= 40300 then
		BagItemSearchBox:Size(159, 15)
		BagItemSearchBox:ClearAllPoints()
		BagItemSearchBox:Point("TOPLEFT", 19, -29)
		BagItemSearchBox.ClearAllPoints = T.dummy
		BagItemSearchBox.SetPoint = T.dummy
		T.SkinEditBox(BagItemSearchBox)
	end

	-- BANK
	local bank = BankFrame
	if bank then
		bank:StripTextures(true)
		bank:CreateBackdrop("Default")
		bank.backdrop:CreateShadow("Default")
		bank.backdrop:Point("TOPLEFT", 4, 0)
		bank.backdrop:Point("BOTTOMRIGHT", -18, 90)
		T.SkinCloseButton(BankCloseButton, BankCloseButton.backdrop)

		T.SkinButton(BankFramePurchaseButton)
		BankFramePurchaseButton:Height(22)
		
		if T.toc >= 40300 then
			BankItemSearchBox:Size(159, 15)
			BankItemSearchBox:ClearAllPoints()
			BankItemSearchBox:Point("TOPRIGHT", -56, -48)
			BankItemSearchBox.ClearAllPoints = T.dummy
			BankItemSearchBox.SetPoint = T.dummy
			T.SkinEditBox(BankItemSearchBox)
		end

		-- Bank Bags
		for i = 1, 7 do
			local bankbags = _G["BankFrameBag"..i]
			local highlight = _G["BankFrameBag"..i.."HighlightFrameTexture"];
			local icon = _G["BankFrameBag"..i.."IconTexture"]

			T.SkinButton(bankbags)
			bankbags:StyleButton()
			highlight:Kill()
			icon:SetTexCoord(.08, .92, .08, .92)
			icon:ClearAllPoints()
			icon:SetAllPoints()
			icon:Point("TOPLEFT", bankbags, 2, -2)
			icon:Point("BOTTOMRIGHT", bankbags, -2, 2)
		end

		-- Bank Slots
		for i = 1, 28 do
			local slots = _G["BankFrameItem"..i]
			local icon = _G["BankFrameItem"..i.."IconTexture"]
			T.SkinButton(slots)
			icon:SetTexCoord(.08, .92, .08, .92)
			icon:ClearAllPoints()
			icon:SetAllPoints()
			icon:Point("TOPLEFT", slots, 2, -2)
			icon:Point("BOTTOMRIGHT", slots, -2, 2)
		end

		-- Bank Bags Frame
		for i = 6, 12 do
			local bag = _G["ContainerFrame"..i]
			if bag then
				bag:StripTextures(true)
				bag:CreateBackdrop("Default")
				bag.backdrop:CreateShadow("Default")
				bag.backdrop:Point("TOPLEFT", 4, -2)
				bag.backdrop:Point("BOTTOMRIGHT", 1, 1)
				T.SkinCloseButton(_G["ContainerFrame"..i.."CloseButton"], _G["ContainerFrame"..i.."CloseButton"].backdrop)

				--Slots
				for j = 1, 36 do
					local icon = _G["ContainerFrame"..i.."Item"..j.."IconTexture"]
					local slots = _G["ContainerFrame"..i.."Item"..j]

					T.SkinButton(slots)
					icon:SetTexCoord(.08, .92, .08, .92)
					icon:ClearAllPoints()
					icon:SetAllPoints()
					icon:Point("TOPLEFT", slots, 2, -2)
					icon:Point("BOTTOMRIGHT", slots, -2, 2)
				end
			end
		end
	end
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)