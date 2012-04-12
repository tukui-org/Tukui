local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	GuildBankFrame:StripTextures()
	GuildBankFrame:SetTemplate("Default")
	GuildBankEmblemFrame:StripTextures(true)
	
	--Close button doesn't have a fucking name, extreme hackage
	for i=1, GuildBankFrame:GetNumChildren() do
		local child = select(i, GuildBankFrame:GetChildren())
		if child.GetPushedTexture and child:GetPushedTexture() and not child:GetName() then
			T.SkinCloseButton(child)
		end
	end
	
	T.SkinButton(GuildBankFrameDepositButton, true)
	T.SkinButton(GuildBankFrameWithdrawButton, true)
	T.SkinButton(GuildBankInfoSaveButton, true)
	T.SkinButton(GuildBankFramePurchaseButton, true)
	T.SkinScrollBar(GuildBankTransactionsScrollFrameScrollBar)
	
	GuildBankFrameWithdrawButton:Point("RIGHT", GuildBankFrameDepositButton, "LEFT", -2, 0)

	GuildBankInfoScrollFrame:StripTextures()
	GuildBankTransactionsScrollFrame:StripTextures()
	
	GuildBankFrame.inset = CreateFrame("Frame", nil, GuildBankFrame)
	GuildBankFrame.inset:SetTemplate("Default")
	GuildBankFrame.inset:Point("TOPLEFT", 30, -65)
	GuildBankFrame.inset:Point("BOTTOMRIGHT", -20, 63)
	
	for i=1, NUM_GUILDBANK_COLUMNS do
		_G["GuildBankColumn"..i]:StripTextures()
		
		for x=1, NUM_SLOTS_PER_GUILDBANK_GROUP do
			local button = _G["GuildBankColumn"..i.."Button"..x]
			local icon = _G["GuildBankColumn"..i.."Button"..x.."IconTexture"]
			button:StripTextures()
			button:StyleButton()
			button:SetTemplate("Default", true)
			
			icon:ClearAllPoints()
			icon:Point("TOPLEFT", 2, -2)
			icon:Point("BOTTOMRIGHT", -2, 2)
			icon:SetTexCoord(.08, .92, .08, .92)
		end
	end
	
	for i=1, 8 do
		local button = _G["GuildBankTab"..i.."Button"]
		local texture = _G["GuildBankTab"..i.."ButtonIconTexture"]
		_G["GuildBankTab"..i]:StripTextures(true)
		
		button:StripTextures()
		button:StyleButton(true)
		button:SetTemplate("Default", true)
		
		texture:ClearAllPoints()
		texture:Point("TOPLEFT", 2, -2)
		texture:Point("BOTTOMRIGHT", -2, 2)
		texture:SetTexCoord(.08, .92, .08, .92)
	end
	
	for i=1, 4 do
		T.SkinTab(_G["GuildBankFrameTab"..i])
	end
	
	--Popup
	GuildBankPopupFrame:StripTextures()
	GuildBankPopupScrollFrame:StripTextures()
	GuildBankPopupFrame:SetTemplate("Default")
	GuildBankPopupFrame:Point("TOPLEFT", GuildBankFrame, "TOPRIGHT", 1, -30)
	T.SkinButton(GuildBankPopupOkayButton)
	T.SkinButton(GuildBankPopupCancelButton)
	T.SkinEditBox(GuildBankPopupEditBox)
	GuildBankPopupNameLeft:Kill()
	GuildBankPopupNameRight:Kill()
	GuildBankPopupNameMiddle:Kill()

	for i=1, 16 do
		local button = _G["GuildBankPopupButton"..i]
		local icon = _G[button:GetName().."Icon"]
		button:StripTextures()
		button:SetTemplate("Default")
		button:StyleButton(true)
		icon:ClearAllPoints()
		icon:Point("TOPLEFT", 2, -2)
		icon:Point("BOTTOMRIGHT", -2, 2)
		icon:SetTexCoord(.08, .92, .08, .92)
	end
	
	if T.toc >= 40300 then
		T.SkinEditBox(GuildItemSearchBox)
	end
end

T.SkinFuncs["Blizzard_GuildBankUI"] = LoadSkin