local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	local buttons = {
	  "LFRQueueFrameFindGroupButton",
	  "LFRQueueFrameAcceptCommentButton",
	  "LFRBrowseFrameSendMessageButton",
	  "LFRBrowseFrameInviteButton",
	  "LFRBrowseFrameRefreshButton",
	}

	LFRParentFrame:StripTextures()
	LFRParentFrame:SetTemplate("Default")
	LFRQueueFrame:StripTextures()
	LFRBrowseFrame:StripTextures()


	for i=1, #buttons do
	  T.SkinButton(_G[buttons[i]])
	end

	--Close button doesn't have a fucking name, extreme hackage
	for i=1, LFRParentFrame:GetNumChildren() do
	  local child = select(i, LFRParentFrame:GetChildren())
	  if child.GetPushedTexture and child:GetPushedTexture() and not child:GetName() then
		T.SkinCloseButton(child)
	  end
	end

	T.SkinTab(LFRParentFrameTab1)
	T.SkinTab(LFRParentFrameTab2)

	T.SkinDropDownBox(LFRBrowseFrameRaidDropDown)

	for i=1, 20 do
	  local button = _G["LFRQueueFrameSpecificListButton"..i.."ExpandOrCollapseButton"]

	  if button then
		button:HookScript("OnClick", function()
		  T.SkinCloseButton(button)
		end)
		T.SkinCloseButton(button)
	  end
	end

	LFRQueueFrameCommentTextButton:CreateBackdrop("Default")
	LFRQueueFrameCommentTextButton:Height(35)

	for i=1, 7 do
		local button = "LFRBrowseFrameColumnHeader"..i
		_G[button.."Left"]:Kill()
		_G[button.."Middle"]:Kill()
		_G[button.."Right"]:Kill()
	end		

	for i=1, NUM_LFR_CHOICE_BUTTONS do
		local button = _G["LFRQueueFrameSpecificListButton"..i]
		T.SkinCheckBox(button.enableButton)
	end

	--DPS, Healer, Tank check button's don't have a name, use it's parent as a referance.
	T.SkinCheckBox(LFRQueueFrameRoleButtonTank:GetChildren())
	T.SkinCheckBox(LFRQueueFrameRoleButtonHealer:GetChildren())
	T.SkinCheckBox(LFRQueueFrameRoleButtonDPS:GetChildren())
	LFRQueueFrameRoleButtonTank:GetChildren():SetFrameLevel(LFRQueueFrameRoleButtonTank:GetChildren():GetFrameLevel() + 2)
	LFRQueueFrameRoleButtonHealer:GetChildren():SetFrameLevel(LFRQueueFrameRoleButtonHealer:GetChildren():GetFrameLevel() + 2)
	LFRQueueFrameRoleButtonDPS:GetChildren():SetFrameLevel(LFRQueueFrameRoleButtonDPS:GetChildren():GetFrameLevel() + 2)
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)