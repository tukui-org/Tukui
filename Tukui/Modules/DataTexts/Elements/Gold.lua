local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local format = format
local floor = floor
local abs = abs
local mod = mod

local Profit = 0
local Spent = 0
local MyRealm = GetRealmName()
local MyName = UnitName("player")

local FormatMoney = function(money)
	local Gold = floor(abs(money) / 10000)
	local Silver = mod(floor(abs(money) / 100), 100)
	local Copper = mod(floor(abs(money)), 100)
	
	if (Gold ~= 0) then
		return format(DataText.ValueColor.."%s|r"..L.DataText.GoldShort..DataText.ValueColor.." %s|r"..L.DataText.SilverShort..DataText.ValueColor.." %s|r"..L.DataText.CopperShort, Gold, Silver, Copper)
	elseif (Silver ~= 0) then
		return format(DataText.ValueColor.."%s|r"..L.DataText.SilverShort..DataText.ValueColor.." %s|r"..L.DataText.CopperShort, Silver, Copper)
	else
		return format(DataText.ValueColor.."%s|r"..L.DataText.CopperShort, Copper)
	end
end

local FormatTooltipMoney = function(money)
	local Gold, Silver, Copper = abs(money / 10000), abs(mod(money / 100, 100)), abs(mod(money, 100))
	local Money = format("%.2d"..L.DataText.GoldShort.." %.2d"..L.DataText.SilverShort.." %.2d"..L.DataText.CopperShort, Gold, Silver, Copper)
	
	return Money
end

local OnEnter = function(self)
	if (not InCombatLockdown()) then
		GameTooltip:SetOwner(self:GetTooltipAnchor())
		GameTooltip:ClearLines()
		GameTooltip:AddLine(L.DataText.Session)
		GameTooltip:AddDoubleLine(L.DataText.Earned, FormatMoney(Profit), 1, 1, 1, 1, 1, 1)
		GameTooltip:AddDoubleLine(L.DataText.Spent, FormatMoney(Spent), 1, 1, 1, 1, 1, 1)
		
		if (Profit < Spent) then
			GameTooltip:AddDoubleLine(L.DataText.Deficit, FormatMoney(Profit-Spent), 1, 0, 0, 1, 1, 1)
		elseif ((Profit-Spent) > 0) then
			GameTooltip:AddDoubleLine(L.DataText.Profit, FormatMoney(Profit-Spent), 0, 1, 0, 1, 1, 1)
		end
		
		GameTooltip:AddLine(" ")							
		
		local TotalGold = 0				
		GameTooltip:AddLine(L.DataText.Character)			

		for key, value in pairs(TukuiData.Gold[MyRealm]) do
			GameTooltip:AddDoubleLine(key, FormatTooltipMoney(value), 1, 1, 1, 1, 1, 1)
			TotalGold = TotalGold + value
		end
		
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(L.DataText.Server)
		GameTooltip:AddDoubleLine(L.DataText.TotalGold, FormatTooltipMoney(TotalGold), 1, 1, 1, 1, 1, 1)
		
		for i = 1, GetNumWatchedTokens() do
			local Name, Count, _, _, ItemID = GetBackpackCurrencyInfo(i)
			if (Name and i == 1) then
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine(CURRENCY)
			end
			
			local R, G, B = 1, 1, 1
			
			if ItemID then
				R, G, B = GetItemQualityColor(select(3, GetItemInfo(ItemID)))
			end
			
			if (Name and Count) then
				GameTooltip:AddDoubleLine(Name, Count, R, G, B, 1, 1, 1)
			end
		end
		
		GameTooltip:Show()
	end
end

local OnLeave = function()
	GameTooltip:Hide()
end

local Update = function(self, event)
	if (not IsLoggedIn()) then
		return
	end
	
	local NewMoney = GetMoney()
	
	TukuiData = TukuiData or {}
	TukuiData["Gold"] = TukuiData["Gold"] or {}
	TukuiData["Gold"][MyRealm] = TukuiData["Gold"][MyRealm] or {}
	TukuiData["Gold"][MyRealm][MyName] = TukuiData["Gold"][MyRealm][MyName] or NewMoney
	
	local OldMoney = TukuiData["Gold"][MyRealm][MyName] or NewMoney
	
	local Change = NewMoney - OldMoney
	
	if (OldMoney > NewMoney) then
		Spent = Spent - Change
	else
		Profit = Profit + Change
	end
	
	self.Text:SetText(FormatMoney(NewMoney))
	
	TukuiData["Gold"][MyRealm][MyName] = NewMoney
end

local OnMouseDown = function(self)
	if BankFrame:IsShown() then
		CloseBankBagFrames()
		CloseBankFrame()
		CloseAllBags()
	else
		if ContainerFrame1:IsShown() then
			CloseAllBags()
		else
			ToggleAllBags()
		end
	end
end

local Enable = function(self)
	self:RegisterEvent("PLAYER_MONEY")
	self:RegisterEvent("SEND_MAIL_MONEY_CHANGED")
	self:RegisterEvent("SEND_MAIL_COD_CHANGED")
	self:RegisterEvent("PLAYER_TRADE_MONEY")
	self:RegisterEvent("TRADE_MONEY_CHANGED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:SetScript("OnMouseDown", OnMouseDown)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", OnLeave)
	self:SetScript("OnEvent", Update)
	self:Update()
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
	self:SetScript("OnMouseDown", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
end

DataText:Register(L.DataText.Gold, Enable, Disable, Update)