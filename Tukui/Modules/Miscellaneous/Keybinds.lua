local T, C, L = select(2, ...):unpack()
local Bind = CreateFrame("Frame")
local Miscellaneous = T["Miscellaneous"]

if T.Retail then
	function Bind:OnEvent(event, addon)
		if addon ~= "Blizzard_BindingUI" then
			return
		end

		local Frame = QuickKeybindFrame
		local Header = Frame.Header
		local Title = Frame.Header.Text
		local Background = Frame.BG
		local Tooltip = QuickKeybindTooltip
		local Buttons = {"okayButton", "defaultsButton", "cancelButton"}
		local CheckBox = Frame.characterSpecificButton
		--local Extra = Frame.phantomExtraActionButton

		Frame:StripTextures()
		Frame:CreateBackdrop("Transparent")
		Frame:CreateShadow()

		Background:StripTextures()

		Header:StripTextures()

		Title:Hide()

		Tooltip:CreateBackdrop()

		Tooltip.Backdrop:CreateShadow()
		Tooltip.Backdrop:SetBorderColor(unpack(T.Colors.class[T.MyClass]))

		CheckBox:SkinCheckBox()

		for _, Button in pairs(Buttons) do
			Frame[Button]:SkinButton()
		end

		--Extra:SetParent(T.Hider)
	end

	function Bind:Enable()
		self:RegisterEvent("ADDON_LOADED")
		self:SetScript("OnEvent", self.OnEvent)
	end
else
	local Popups = T.Popups
	local LocalMacros = 0
	local find = string.find
	local _G = getfenv(0)
	local elapsed = 0
	local stance = StanceButton1:GetScript("OnClick")
	local pet = PetActionButton1:GetScript("OnClick")
	local button = ActionButton1:GetScript("OnClick")

	Popups.Popup["KEYBIND_MODE"] = {
		Question = "Hover your mouse over any actionbutton to bind it. Press the escape key or right click to clear the current actionbutton's keybinding.",
		Answer1 = "Save bindings",
		Answer2 = "Discard bindings",
		Function1 = function(self)
			Bind:Deactivate(true)
		end,
		Function2 = function(self)
			Bind:Deactivate(false)
		end,
	}

	function Bind:TooltipOnUpdate(e)
		elapsed = elapsed + e

		if elapsed < .2 then
			return
		else
			elapsed = 0
		end

		if not Bind.enabled then
			return
		end

		if (not self.comparing and IsModifiedClick("COMPAREITEMS")) then
			GameTooltip_ShowCompareItem(self)

			self.comparing = true
		elseif (self.comparing and not IsModifiedClick("COMPAREITEMS")) then
			for _, frame in pairs(self.shoppingTooltips) do
				frame:Hide()
			end

			self.comparing = false
		end
	end

	function Bind:TooltipOnHide()
		self:SetOwner(Bind, "ANCHOR_NONE")
		self:SetPoint("BOTTOM", Bind, "TOP", 0, 1)
		self:AddLine(Bind.button.name, 1, 1, 1)

		Bind.button.bindings = {GetBindingKey(Bind.button.bindstring)}

		if #Bind.button.bindings == 0 then
			self:AddLine("No bindings set.", .6, .6, .6)
		else
			self:AddDoubleLine("Binding", "Key", .6, .6, .6, .6, .6, .6)

			for i = 1, #Bind.button.bindings do
				self:AddDoubleLine(i, Bind.button.bindings[i])
			end
		end

		self:Show()
		self:SetScript("OnHide", nil)
	end

	function Bind:Update(b, spellmacro)
		if not self.enabled or InCombatLockdown() then
			return
		end

		self.button = b
		self.spellmacro = spellmacro

		self:ClearAllPoints()
		self:SetAllPoints(b)
		self:Show()

		ShoppingTooltip1:Hide()

		if spellmacro=="SPELL" then
			self.button.id = SpellBook_GetSpellBookSlot(self.button)
			self.button.name = GetSpellBookItemName(self.button.id, SpellBookFrame.bookType)

			GameTooltip:AddLine("Trigger")
			GameTooltip:Show()
			GameTooltip:SetScript("OnHide", Bind.TooltipOnHide)
		elseif spellmacro=="MACRO" then
			self.button.id = self.button:GetID()

			if LocalMacros==1 then
				self.button.id = self.button.id + 120
			end

			self.button.name = GetMacroInfo(self.button.id)

			GameTooltip:SetOwner(Bind, "ANCHOR_NONE")
			GameTooltip:SetPoint("BOTTOM", Bind, "TOP", 0, 1)
			GameTooltip:AddLine(Bind.button.name, 1, 1, 1)

			Bind.button.bindings = {GetBindingKey(spellmacro.." "..Bind.button.name)}

			if #Bind.button.bindings == 0 then
				GameTooltip:AddLine("No bindings set.", .6, .6, .6)
			else
				GameTooltip:AddDoubleLine("Binding", "Key", .6, .6, .6, .6, .6, .6)

				for i = 1, #Bind.button.bindings do
					GameTooltip:AddDoubleLine("Binding"..i, Bind.button.bindings[i], 1, 1, 1)
				end
			end

			GameTooltip:Show()
		elseif spellmacro=="STANCE" or spellmacro=="PET" then
			self.button.id = tonumber(b:GetID())
			self.button.name = b:GetName()

			if not self.button.name then
				return
			end

			if not self.button.id or self.button.id < 1 or self.button.id > (spellmacro=="STANCE" and 10 or 12) then
				self.button.bindstring = "CLICK "..self.button.name..":LeftButton"
			else
				self.button.bindstring = (spellmacro=="STANCE" and "SHAPESHIFTBUTTON" or "BONUSACTIONBUTTON")..self.button.id
			end

			GameTooltip:AddLine("Trigger")
			GameTooltip:Show()
			GameTooltip:SetScript("OnHide", Bind.TooltipOnHide)
		else
			self.button.action = tonumber(b.action)
			self.button.name = b:GetName()

			if not self.button.name then
				return
			end

			if not self.button.action or self.button.action < 1 or self.button.action > 132 then
				self.button.bindstring = "CLICK "..self.button.name..":LeftButton"
			else
				local modact = 1+(self.button.action-1)%12

				if self.button.action < 25 or self.button.action > 72 then
					self.button.bindstring = "ACTIONBUTTON"..modact
				elseif self.button.action < 73 and self.button.action > 60 then
					self.button.bindstring = "MULTIACTIONBAR1BUTTON"..modact
				elseif self.button.action < 61 and self.button.action > 48 then
					self.button.bindstring = "MULTIACTIONBAR2BUTTON"..modact
				elseif self.button.action < 49 and self.button.action > 36 then
					self.button.bindstring = "MULTIACTIONBAR4BUTTON"..modact
				elseif self.button.action < 37 and self.button.action > 24 then
					self.button.bindstring = "MULTIACTIONBAR3BUTTON"..modact
				end
			end

			GameTooltip:AddLine("Trigger")
			GameTooltip:Show()
			GameTooltip:SetScript("OnHide", Bind.TooltipOnHide)
		end
	end

	function Bind:Listener(key)
		if key == "ESCAPE" or key == "RightButton" then
			for i = 1, #self.button.bindings do
				SetBinding(self.button.bindings[i])
			end

			T.Print("All keybindings cleared for |cff00ff00"..self.button.name.."|r.")

			self:Update(self.button, self.spellmacro)

			if self.spellmacro~="MACRO" then
				GameTooltip:Hide()
			end

			return
		end

		if key == "LSHIFT" or key == "RSHIFT" or key == "LCTRL" or key == "RCTRL" or key == "LALT" or key == "RALT" or key == "UNKNOWN" or key == "LeftButton" then
			return
		end

		if key == "MiddleButton" then
			key = "BUTTON3"
		end

		if key == "Button4" then
			key = "BUTTON4"
		end

		if key == "Button5" then
			key = "BUTTON5"
		end

		local alt = IsAltKeyDown() and "ALT-" or ""
		local ctrl = IsControlKeyDown() and "CTRL-" or ""
		local shift = IsShiftKeyDown() and "SHIFT-" or ""

		if not self.spellmacro or self.spellmacro=="PET" or self.spellmacro=="STANCE" then
			SetBinding(alt..ctrl..shift..key, self.button.bindstring)
		else
			SetBinding(alt..ctrl..shift..key, self.spellmacro.." "..self.button.name)
		end

		T.Print(alt..ctrl..shift..key.." |cff00ff00bound to |r"..self.button.name..".")

		self:Update(self.button, self.spellmacro)

		if self.spellmacro~="MACRO" then
			GameTooltip:Hide()
		end
	end

	function Bind:HideFrame()
		self:ClearAllPoints()
		self:Hide()

		GameTooltip:Hide()
	end

	function Bind:Activate()
		self.enabled = true
		self:RegisterEvent("PLAYER_REGEN_DISABLED")
	end

	function Bind:Deactivate(save)
		if save then
			SaveBindings(2)

			T.Print("All keybindings have been saved.")
		else
			LoadBindings(2)

			T.Print("All newly set keybindings have been discarded.")
		end

		self.enabled = false
		self:HideFrame()
		self:UnregisterEvent("PLAYER_REGEN_DISABLED")

		T.Popups.HidePopupByName("KEYBIND_MODE")
	end

	function Bind:Enable()
		Bind:SetFrameStrata("DIALOG")
		Bind:EnableMouse(true)
		Bind:EnableKeyboard(true)
		Bind:EnableMouseWheel(true)
		Bind.texture = Bind:CreateTexture()
		Bind.texture:SetAllPoints(Bind)
		Bind.texture:SetTexture(0, 0, 0, .25)
		Bind:Hide()

		GameTooltip:HookScript("OnUpdate", Bind.TooltipOnUpdate)

		hooksecurefunc(GameTooltip, "Hide", function(self)
			for _, tt in pairs(self.shoppingTooltips) do
				tt:Hide()
			end
		end)

		Bind:SetScript("OnEvent", function(self) self:Deactivate(false) end)
		Bind:SetScript("OnLeave", function(self) self:HideFrame() end)
		Bind:SetScript("OnKeyUp", function(self, key) self:Listener(key) end)
		Bind:SetScript("OnMouseUp", function(self, key) self:Listener(key) end)
		Bind:SetScript("OnMouseWheel", function(self, delta)
			if delta>0 then
				self:Listener("MOUSEWHEELUP")
			else self:Listener("MOUSEWHEELDOWN")

			end
		end)

		local function register(val)
			if val.IsProtected and val.GetObjectType and val.GetScript and val:GetObjectType()=="CheckButton" and val:IsProtected() then
				local script = val:GetScript("OnClick")
				if script==button then
					val:HookScript("OnEnter", function(self) Bind:Update(self) end)
				elseif script==stance then
					val:HookScript("OnEnter", function(self) Bind:Update(self, "STANCE") end)
				elseif script==pet then
					val:HookScript("OnEnter", function(self) Bind:Update(self, "PET") end)
				end
			end
		end

		local val = EnumerateFrames()

		while val do
			register(val)
			val = EnumerateFrames(val)
		end

		for i=1,12 do
			local sb = _G["SpellButton"..i]

			sb:HookScript("OnEnter", function(self) Bind:Update(self, "SPELL") end)
		end

		local function registermacro()
			for i=1,120 do
				local mb = _G["MacroButton"..i]
				mb:HookScript("OnEnter", function(self) Bind:Update(self, "MACRO") end)
			end

			MacroFrameTab1:HookScript("OnMouseUp", function() LocalMacros = 0 end)
			MacroFrameTab2:HookScript("OnMouseUp", function() LocalMacros = 1 end)
		end


		hooksecurefunc("LoadAddOn", function(addon)
			if addon=="Blizzard_MacroUI" then
				registermacro()
			end
		end)
	end

	function Bind:Toggle()
		Bind:Activate()

		T.Popups.ShowPopup("KEYBIND_MODE")
	end
end

Miscellaneous.Keybinds = Bind
