local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	GuildBankFrame:StripTextures()
	GuildBankFrame:SetTemplate("Default")
	GuildBankEmblemFrame:StripTextures(true)
	
	--Close button doesn't have a fucking name, extreme hackage
	for i=1, GuildBankFrame:GetNumChildren() do
		local child = select(i, GuildBankFrame:GetChildren())
		if child.GetPushedTexture and child:GetPushedTexture() and not child:GetName() then
			child:SkinCloseButton()
		end
	end
	
	GuildBankFrameDepositButton:SkinButton(true)
	GuildBankFrameWithdrawButton:SkinButton(true)
	GuildBankInfoSaveButton:SkinButton(true)
	GuildBankFramePurchaseButton:SkinButton(true)
	GuildBankTransactionsScrollFrameScrollBar:SkinScrollBar()
	
	GuildBankFrameWithdrawButton:Point("RIGHT", GuildBankFrameDepositButton, "LEFT", -2, 0)

	GuildBankInfoScrollFrame:StripTextures()
	GuildBankTransactionsScrollFrame:StripTextures()
	
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
		button:StyleButton()
		button:SetTemplate("Default", true)
		
		texture:ClearAllPoints()
		texture:Point("TOPLEFT", 2, -2)
		texture:Point("BOTTOMRIGHT", -2, 2)
		texture:SetTexCoord(.08, .92, .08, .92)
	end
	
	for i=1, 4 do
		_G["GuildBankFrameTab"..i]:SkinTab()
	end
	
	--Popup
	GuildBankPopupFrame:StripTextures()
	GuildBankPopupScrollFrame:StripTextures()
	GuildBankPopupScrollFrameScrollBar:SkinScrollBar()
	GuildBankPopupFrame:SetTemplate("Default")
	GuildBankPopupFrame:Point("TOPLEFT", GuildBankFrame, "TOPRIGHT", 1, -30)
	GuildBankPopupOkayButton:SkinButton()
	GuildBankPopupCancelButton:SkinButton()
	GuildBankPopupEditBox:SkinEditBox()
	GuildBankPopupNameLeft:Kill()
	GuildBankPopupNameRight:Kill()
	GuildBankPopupNameMiddle:Kill()

	for i=1, 16 do
		local button = _G["GuildBankPopupButton"..i]
		local icon = _G[button:GetName().."Icon"]
		button:StripTextures()
		button:SetTemplate("Default")
		button:StyleButton()
		icon:ClearAllPoints()
		icon:Point("TOPLEFT", 2, -2)
		icon:Point("BOTTOMRIGHT", -2, 2)
		icon:SetTexCoord(.08, .92, .08, .92)
	end
	
	GuildItemSearchBox:SkinEditBox()
	GuildBankMoneyFrameBackground:StripTextures()
	GuildBankInfoScrollFrameScrollBar:SkinScrollBar()
end

T.SkinFuncs["Blizzard_GuildBankUI"] = LoadSkin