local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	local StripAllTextures = {
		"LFDParentFrame",
		"LFDQueueFrame",
		"LFDQueueFrameSpecific",
		"LFDQueueFrameRandom",
		"LFDQueueFrameRandomScrollFrame",
		"LFDQueueFrameCapBar",
		"LFDDungeonReadyDialog",
		"LFGDungeonReadyDialog",
	}

	local KillTextures = {
		"LFDQueueFrameBackground",
		"LFDParentFrameInset",
		"LFDParentFrameEyeFrame",
		"LFDQueueFrameRoleButtonTankBackground",
		"LFDQueueFrameRoleButtonHealerBackground",
		"LFDQueueFrameRoleButtonDPSBackground",
		"LFDDungeonReadyDialogBackground",
		"LFGDungeonReadyDialogBackground",
	}
	
	local buttons = {
		"LFDQueueFrameFindGroupButton",
		"LFDQueueFrameCancelButton",
		"LFDQueueFramePartyBackfillBackfillButton",
		"LFDQueueFramePartyBackfillNoBackfillButton",
		"LFDQueueFrameNoLFDWhileLFRLeaveQueueButton",
	}

	local checkButtons = {
		"LFDQueueFrameRoleButtonTank",
		"LFDQueueFrameRoleButtonHealer",
		"LFDQueueFrameRoleButtonDPS",
		"LFDQueueFrameRoleButtonLeader",
	}

	for _, object in pairs(checkButtons) do
		_G[object]:GetChildren():SetFrameLevel(_G[object]:GetChildren():GetFrameLevel() + 2)
		T.SkinCheckBox(_G[object]:GetChildren())
	end

	for _, object in pairs(StripAllTextures) do
		if _G[object] then _G[object]:StripTextures() end
	end

	for _, texture in pairs(KillTextures) do
		if _G[texture] then _G[texture]:Kill() end
	end

	for i = 1, #buttons do
		_G[buttons[i]]:StripTextures()
		T.SkinButton(_G[buttons[i]])
	end	

	for i= 1,15 do
		T.SkinCheckBox(_G["LFDQueueFrameSpecificListButton"..i.."EnableButton"])
	end

	LFDQueueFrameCapBar:SetPoint("LEFT", 40, 0)
	LFDQueueFrameRandom:HookScript("OnShow", function()
		for i=1, LFD_MAX_REWARDS do
			local button = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i]
			local icon = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."IconTexture"]
			local count = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."Count"]
			local role1 = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."RoleIcon1"]
			local role2 = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."RoleIcon2"]
			local role3 = _G["LFDQueueFrameRandomScrollFrameChildFrameItem"..i.."RoleIcon3"]
			
			if button then
				button:StripTextures()
				icon:SetTexCoord(.08, .92, .08, .92)
				icon:Point("TOPLEFT", 2, -2)
				icon:SetDrawLayer("OVERLAY")
				count:SetDrawLayer("OVERLAY")
				if not button.backdrop then
					button:CreateBackdrop("Default")
					button.backdrop:Point("TOPLEFT", icon, "TOPLEFT", -2, 2)
					button.backdrop:Point("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)
					icon:SetParent(button.backdrop)
					icon.SetPoint = T.dummy
					
					if count then
						count:SetParent(button.backdrop)
					end
					if role1 then
						role1:SetParent(button.backdrop)
					end
					if role2 then
						role2:SetParent(button.backdrop)
					end
					if role3 then
						role3:SetParent(button.backdrop)
					end							
				end
			end
		end
	end)
	
	if T.toc < 40300 then
		LFDDungeonReadyDialog:SetTemplate("Default")
		LFDDungeonReadyDialog:CreateShadow("Default")
		T.SkinCloseButton(LFDDungeonReadyDialogCloseButton,LFDDungeonReadyDialog)
		T.SkinButton(LFDDungeonReadyDialogEnterDungeonButton)
		T.SkinButton(LFDDungeonReadyDialogLeaveQueueButton)
	end

	LFDQueueFrameSpecificListScrollFrame:StripTextures()
	LFDQueueFrameSpecificListScrollFrame:Height(LFDQueueFrameSpecificListScrollFrame:GetHeight() - 8)
	LFDParentFrame:CreateBackdrop("Default")
	LFDParentFrame.backdrop:Point( "TOPLEFT", LFDParentFrame, "TOPLEFT")
	LFDParentFrame.backdrop:Point( "BOTTOMRIGHT", LFDParentFrame, "BOTTOMRIGHT")
	T.SkinCloseButton(LFDParentFrameCloseButton,LFDParentFrame)	
	T.SkinDropDownBox(LFDQueueFrameTypeDropDown, 300)
	LFDQueueFrameTypeDropDown:Point("RIGHT",-10,0)
	LFDQueueFrameCapBar:CreateBackdrop("Default")
	LFDQueueFrameCapBar.backdrop:Point( "TOPLEFT", LFDQueueFrameCapBar, "TOPLEFT", 1, -1)
	LFDQueueFrameCapBar.backdrop:Point( "BOTTOMRIGHT", LFDQueueFrameCapBar, "BOTTOMRIGHT", -1, 1 )
	LFDQueueFrameCapBarProgress:SetTexture(C["media"].normTex)
	LFDQueueFrameCapBarCap1:SetTexture(C["media"].normTex)
	LFDQueueFrameCapBarCap2:SetTexture(C["media"].normTex)
	T.SkinScrollBar(LFDQueueFrameSpecificListScrollFrameScrollBar)
	LFDQueueFrameNoLFDWhileLFR:SetTemplate("Default")
	
	if T.toc >= 40300 then
		LFGDungeonReadyDialog:SetTemplate("Default")
		LFGDungeonReadyDialog:CreateShadow("Default")
		T.SkinButton(LFGDungeonReadyDialogLeaveQueueButton)
		T.SkinButton(LFGDungeonReadyDialogEnterDungeonButton)
		T.SkinCloseButton(LFGDungeonReadyDialogCloseButton)
		LFGDungeonReadyDialogCloseButton.t:SetText("_")
		LFGDungeonReadyStatus:SetTemplate("Default")
		T.SkinCloseButton(LFGDungeonReadyStatusCloseButton)
		LFGDungeonReadyStatusCloseButton.t:SetText("_")
	end
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)