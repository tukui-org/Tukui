local T, C, L = select(2, ...):unpack()

local ActionBars = T["ActionBars"]
local NUM_PET_ACTION_SLOTS = NUM_PET_ACTION_SLOTS
local Replace = string.gsub
local FlyoutButtons = 0
local Noop = function() end

function ActionBars:SkinButton(button)
	local Name = button:GetName()
	local Action = button.action
	local Button = button
	local KeybindTex = Button.QuickKeybindHighlightTexture
	local Icon = _G[Name.."Icon"]
	local Count = _G[Name.."Count"]
	local Flash	 = _G[Name.."Flash"]
	local HotKey = _G[Name.."HotKey"]
	local Border = _G[Name.."Border"]
	local Btname = _G[Name.."Name"]
	local Normal = _G[Name.."NormalTexture"]
	local BtnBG = _G[Name.."FloatingBG"]
	local Font = T.GetFont(C["ActionBars"].Font)

	if not Button.IsSkinned then
		Flash:SetTexture("")
		Button:SetNormalTexture("")

		Count:ClearAllPoints()
		Count:SetPoint("BOTTOMRIGHT", 0, 2)

		HotKey:ClearAllPoints()
		HotKey:SetPoint("TOPRIGHT", 0, -3)
		HotKey:SetFontObject(Font)

		Count:SetFontObject(Font)

		if (Btname) then
			if (C.ActionBars.Macro) then
				Btname:SetFontObject(Font)
				Btname:ClearAllPoints()
				Btname:SetPoint("BOTTOM", 1, 1)
			else
				Btname:SetText("")
				Btname:Kill()
			end
		end

		if (BtnBG) then
			BtnBG:Kill()
		end

		if not (C.ActionBars.HotKey) then
			HotKey:SetText("")
			HotKey:Kill()
		end

		if (Name:match("Extra")) then
			Button.Pushed = true
		end

		Button:CreateBackdrop()

		if C.ActionBars.HideBackdrop then
			Button:CreateShadow()
		end

		Icon:SetTexCoord(unpack(T.IconCoord))
		Icon:SetDrawLayer("BACKGROUND", 7)

		if (Normal) then
			Normal:ClearAllPoints()
			Normal:SetPoint("TOPLEFT")
			Normal:SetPoint("BOTTOMRIGHT")

			if (Button:GetChecked() and Button.UpdateState) then
				Button:UpdateState(Button)
			end
		end

		if (Border) then
			Border:SetTexture("")
		end
		
		if KeybindTex then
			KeybindTex:SetTexture("")
		end
		
		if C.ActionBars.HotKey then
			if T.Retail and Button.UpdateHotkeys then
				hooksecurefunc(Button, "UpdateHotkeys", ActionBars.SetHotKeyText)
			end

			ActionBars.SetHotKeyText(Button)
		end
		
		Button:StyleButton()
		Button.isSkinned = true
	end
	
	
	-- WORKLATER (note: Need to be moved into another hook)
	--[[
	if (Border and C.ActionBars.EquipBorder) then
		if (Border:IsShown()) then
			Button.Backdrop:SetBorderColor(.08, .70, 0)
		else
			Button.Backdrop:SetBorderColor(unpack(C["General"].BorderColor))
		end
	end


	if (Action and Btname and Normal and C.ActionBars.Macro) then
		local String = GetActionText(Action)

		if String then
			local Text

			if string.byte(String, 1) > 223 then
				Text = string.sub(String, 1, 9)
			else
				Text = string.sub(String, 1, 4)
			end

			Btname:SetText(Text)
		end
	end
	--]]
end

function ActionBars:SkinPetAndShiftButton(Normal, Button, Icon, Name, Pet)
	if Button.isSkinned then return end

	local PetSize = C.ActionBars.PetButtonSize
	local HotKey = _G[Button:GetName().."HotKey"]
	local Cooldown = _G[Button:GetName().."Cooldown"]
	local Flash = _G[Name.."Flash"]
	local Font = T.GetFont(C["ActionBars"].Font)

	Button:SetWidth(PetSize)
	Button:SetHeight(PetSize)
	Button:CreateBackdrop()

	if C.ActionBars.HideBackdrop then
		Button:CreateShadow()
	end

	if (C.ActionBars.HotKey) then
		HotKey:SetFontObject(Font)
		HotKey:ClearAllPoints()
		HotKey:SetPoint("TOPRIGHT", 0, -3)
	else
		HotKey:SetText("")
		HotKey:SetAlpha(0)
	end

	Icon:SetTexCoord(unpack(T.IconCoord))
	Icon:SetDrawLayer("BACKGROUND", 7)

	if (Pet) then
		if (PetSize < 30) then
			local AutoCast = _G[Name.."AutoCastable"]
			AutoCast:SetAlpha(0)
		end

		local Shine = _G[Name.."Shine"]
		Shine:SetSize(PetSize, PetSize)
		Shine:ClearAllPoints()
		Shine:SetPoint("CENTER", Button, 0, 0)
		
		Button.Backdrop:SetParent(Button:GetParent())
	end

	Flash:SetTexture("")

	if Normal then
		Normal:ClearAllPoints()
		Normal:SetPoint("TOPLEFT")
		Normal:SetPoint("BOTTOMRIGHT")
	end
	
	if Button.QuickKeybindHighlightTexture then
		Button.QuickKeybindHighlightTexture:SetTexture("")
	end
	
	if C.ActionBars.HotKey then
		ActionBars.SetHotKeyText(Button)
	end

	Button:StyleButton()
	Button.isSkinned = true
end

function ActionBars:SkinPetButtons()
	for i = 1, NUM_PET_ACTION_SLOTS do
		local Name = "PetActionButton"..i
		local Button = _G[Name]
		local Icon = _G[Name.."Icon"]
		local Normal = _G[Name.."NormalTexture2"] -- ?? 2

		ActionBars:SkinPetAndShiftButton(Normal, Button, Icon, Name, true)
	end
end

function ActionBars:SkinStanceButtons()
	for i=1, NUM_STANCE_SLOTS do
		local Name = "StanceButton"..i
		local Button = _G[Name]
		local Icon = _G[Name.."Icon"]
		local Normal = _G[Name.."NormalTexture"]

		ActionBars:SkinPetAndShiftButton(Normal, Button, Icon, Name, false)
	end
end

function ActionBars:SkinFlyoutButtons()
	for i = 1, FlyoutButtons do
		local Button = _G["SpellFlyoutButton"..i]

		if Button and not Button.IsSkinned then
			ActionBars:SkinButton(Button)
			

			if Button:GetChecked() then
				Button:SetChecked(nil)
			end

			Button.IsSkinned = true
		end
	end
end

function ActionBars:StyleFlyout()
	if (self.FlyoutArrow) and (not self.FlyoutArrow:IsShown()) then
		return
	end

	local HB = SpellFlyoutHorizontalBackground
	local VB = SpellFlyoutVerticalBackground
	local BE = SpellFlyoutBackgroundEnd

	if self.FlyoutBorder then
		self.FlyoutBorder:SetAlpha(0)
		self.FlyoutBorderShadow:SetAlpha(0)
	end

	HB:SetAlpha(0)
	VB:SetAlpha(0)
	BE:SetAlpha(0)

	for i = 1, GetNumFlyouts() do
		local ID = GetFlyoutID(i)
		local _, _, NumSlots, IsKnown = GetFlyoutInfo(ID)
		
		if IsKnown then
			FlyoutButtons = NumSlots
			
			break
		end
	end

	ActionBars:SkinFlyoutButtons()
end

function ActionBars:StopButtonHighlight()
	if self.Animation and self.Animation:IsPlaying() then
		self.Animation:Stop()
		self.NewProc:Hide()
	end
end