local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	TradeSkillFrame:StripTextures(true)
	TradeSkillListScrollFrame:StripTextures()
	TradeSkillDetailScrollFrame:StripTextures()
	TradeSkillFrameInset:StripTextures()
	TradeSkillExpandButtonFrame:StripTextures()
	TradeSkillDetailScrollChildFrame:StripTextures()
	
	TradeSkillFrame:SetTemplate("Default")
	TradeSkillFrame:CreateShadow("Default")
	TradeSkillFrame:Height(TradeSkillFrame:GetHeight() + 12)
	TradeSkillRankFrame:StripTextures()
	TradeSkillRankFrame:CreateBackdrop("Default")
	TradeSkillRankFrame:SetStatusBarTexture(C["media"].normTex)
	
	TradeSkillCreateButton:SkinButton(true)
	TradeSkillCancelButton:SkinButton(true)
	TradeSkillFilterButton:SkinButton(true)
	TradeSkillCreateAllButton:SkinButton(true)
	TradeSkillViewGuildCraftersButton:SkinButton(true)
	
	TradeSkillLinkButton:GetNormalTexture():SetTexCoord(0.25, 0.7, 0.37, 0.75)
	TradeSkillLinkButton:GetPushedTexture():SetTexCoord(0.25, 0.7, 0.45, 0.8)
	TradeSkillLinkButton:GetHighlightTexture():Kill()
	TradeSkillLinkButton:CreateBackdrop("Default")
	TradeSkillLinkButton:Size(17, 14)
	TradeSkillLinkButton:Point("LEFT", TradeSkillLinkFrame, "LEFT", 5, -1)
	TradeSkillFrameSearchBox:SkinEditBox()
	TradeSkillInputBox:SkinEditBox()
	TradeSkillDecrementButton:SkinNextPrevButton()
	TradeSkillIncrementButton:SkinNextPrevButton()
	TradeSkillIncrementButton:Point("RIGHT", TradeSkillCreateButton, "LEFT", -13, 0)
	
	TradeSkillFrameCloseButton:SkinCloseButton()
	TradeSkillDetailScrollFrameScrollBar:SkinScrollBar()
	TradeSkillListScrollFrameScrollBar:SkinScrollBar()
	
	local once = false
	hooksecurefunc("TradeSkillFrame_SetSelection", function(id)
		TradeSkillSkillIcon:StyleButton()
		if TradeSkillSkillIcon:GetNormalTexture() then
			TradeSkillSkillIcon:GetNormalTexture():SetTexCoord(.08, .92, .08, .92)
			TradeSkillSkillIcon:GetNormalTexture():ClearAllPoints()
			TradeSkillSkillIcon:GetNormalTexture():Point("TOPLEFT", 2, -2)
			TradeSkillSkillIcon:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
		end
		TradeSkillSkillIcon:SetTemplate("Default")

		for i=1, MAX_TRADE_SKILL_REAGENTS do
			local button = _G["TradeSkillReagent"..i]
			local icon = _G["TradeSkillReagent"..i.."IconTexture"]
			local count = _G["TradeSkillReagent"..i.."Count"]
			
			icon:SetTexCoord(.08, .92, .08, .92)
			icon:SetDrawLayer("OVERLAY")
			if not icon.backdrop then
				icon.backdrop = CreateFrame("Frame", nil, button)
				icon.backdrop:SetFrameLevel(button:GetFrameLevel() - 1)
				icon.backdrop:SetTemplate("Default")
				icon.backdrop:Point("TOPLEFT", icon, "TOPLEFT", -2, 2)
				icon.backdrop:Point("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)
			end
			
			icon:SetParent(icon.backdrop)
			count:SetParent(icon.backdrop)
			count:SetDrawLayer("OVERLAY")
			
			if i > 2 and once == false then
				local point, anchoredto, point2, x, y = button:GetPoint()
				button:ClearAllPoints()
				button:Point(point, anchoredto, point2, x, y - 3)
				once = true
			end
			
			_G["TradeSkillReagent"..i.."NameFrame"]:Kill()
		end
	end)
	
	
	--Guild Crafters
	TradeSkillGuildFrame:StripTextures()
	TradeSkillGuildFrame:SetTemplate("Default")
	TradeSkillGuildFrame:Point("BOTTOMLEFT", TradeSkillFrame, "BOTTOMRIGHT", 3, 19)
	TradeSkillGuildFrameContainer:StripTextures()
	TradeSkillGuildFrameContainer:SetTemplate("Default")
	TradeSkillGuildFrameCloseButton:SkinCloseButton()
end

T.SkinFuncs["Blizzard_TradeSkillUI"] = LoadSkin