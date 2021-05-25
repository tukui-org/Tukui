local _, ns = ...
local oUF = ns.oUF

local myGUID = UnitGUID('player')
local HealComm = LibStub("LibHealComm-4.0")

local ALL_PENDING_HEALS = bit.bor(HealComm.DIRECT_HEALS, HealComm.BOMB_HEALS)
local ALL_OVERTIME_HEALS = bit.bor(HealComm.CHANNEL_HEALS, HealComm.HOT_HEALS)
local HEAL_TICK_INTERVAL = 3

--local function GetCasterHealAmount(targetGUID, currentTime)
--    local nextTickTime = currentTime + HEAL_TICK_INTERVAL
--
--    local pendingHeal = HealComm:GetCasterHealAmount(targetGUID, ALL_PENDING_HEALS, nil) or 0
--    local overtimeHeal = HealComm:GetCasterHealAmount(targetGUID, ALL_OVERTIME_HEALS, nextTickTime) or 0
--
--    return (pendingHeal + overtimeHeal) * HealComm:GetHealModifier(myGUID)
--end

local function GetHealAmount(targetGUID, currentTime, casterGUID)
    local nextTickTime = currentTime + HEAL_TICK_INTERVAL

    local pendingHeal = HealComm:GetHealAmount(targetGUID, ALL_PENDING_HEALS, nil, casterGUID) or 0
    local overtimeHeal = HealComm:GetHealAmount(targetGUID, ALL_OVERTIME_HEALS, nextTickTime, casterGUID) or 0

    return (pendingHeal + overtimeHeal) * HealComm:GetHealModifier(casterGUID)
end

local function Update(self, event, unit)
    if (self.unit ~= unit) then return end

    local element = self.HealthPrediction

    if (element.PreUpdate) then
        element:PreUpdate(unit)
    end

    local guid = UnitGUID(unit)
    local currentTime = GetTime()
    local isSmoothedEvent = event == "UNIT_MAXHEALTH" or event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_HEALTH"

    local myIncomingHeal = GetHealAmount(guid, currentTime, myGUID) or 0
    local allIncomingHeal = GetHealAmount(guid, currentTime, nil) or 0
    local health, maxHealth = UnitHealth(unit), UnitHealthMax(unit)
    local otherIncomingHeal = 0

    if(health + allIncomingHeal > maxHealth * element.maxOverflow) then
        allIncomingHeal = maxHealth * element.maxOverflow - health
    end

    if(allIncomingHeal < myIncomingHeal) then
        myIncomingHeal = allIncomingHeal
    else
        otherIncomingHeal = allIncomingHeal - myIncomingHeal
    end

    if (element.myBar) then
        if element.smoothing then
            element.myBar:SetMinMaxSmoothedValue(0, maxHealth)
            element.myBar:SetSmoothedValue(myIncomingHeal)
        end

        if not element.smoothing or not isSmoothedEvent then
            element.myBar:SetMinMaxValues(0, maxHealth)
            element.myBar:SetValue(myIncomingHeal)
        end

        element.myBar:Show()
    end

    if (element.otherBar) then
        if element.smoothing then
            element.otherBar:SetMinMaxSmoothedValue(0, maxHealth)
            element.otherBar:SetSmoothedValue(otherIncomingHeal)
        end

        if not element.smoothing or not isSmoothedEvent then
            element.otherBar:SetMinMaxValues(0, maxHealth)
            element.otherBar:SetValue(otherIncomingHeal)
        end

        element.otherBar:Show()
    end

    if (element.PostUpdate) then
        return element:PostUpdate(unit, myIncomingHeal, otherIncomingHeal, 0, 0, 0, 0)
    end
end

local function Path(self, ...)
    return (self.HealthPrediction.Override or Update)(self, ...)
end

local function ForceUpdate(element)
    return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local function HealCommUpdate(self, event, ...)
    if self:IsVisible() then
        for i = 1, select('#', ...) do
            if self.unit and UnitGUID(self.unit) == select(i, ...) then
                Path(self, event, self.unit)
            end
        end
    end
end

local function Enable(self)
    local element = self.HealthPrediction
    if (element) then
        element.__owner = self
        element.ForceUpdate = ForceUpdate

        self:RegisterEvent('UNIT_HEALTH_FREQUENT', Path)
        self:RegisterEvent('UNIT_MAXHEALTH', Path)

        local function HealComm_Heal_Update(event, casterGUID, spellID, healType, _, ...)
            HealCommUpdate(self, event, ...)
        end

        local function HealComm_Modified(event, guid)
            HealCommUpdate(self, event, guid)
        end

        HealComm.RegisterCallback(self, "HealComm_HealStarted", HealComm_Heal_Update)
        HealComm.RegisterCallback(self, "HealComm_HealUpdated", HealComm_Heal_Update)
        HealComm.RegisterCallback(self, "HealComm_HealDelayed", HealComm_Heal_Update)
        HealComm.RegisterCallback(self, "HealComm_HealStopped", HealComm_Heal_Update)
        HealComm.RegisterCallback(self, "HealComm_ModifierChanged", HealComm_Modified)
        HealComm.RegisterCallback(self, "HealComm_GUIDDisappeared", HealComm_Modified)

        if (not element.maxOverflow) then
            element.maxOverflow = 1.05
        end

        if (element.myBar) then
            if(element.smoothing) then
                element.myBar.SetSmoothedValue = SmoothStatusBarMixin.SetSmoothedValue
                element.myBar.SetMinMaxSmoothedValue = SmoothStatusBarMixin.SetMinMaxSmoothedValue
            end

            if (element.myBar:IsObjectType('StatusBar') and not element.myBar:GetStatusBarTexture()) then
                element.myBar:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
            end
        end

        if (element.otherBar) then
            if(element.smoothing) then
                element.otherBar.SetSmoothedValue = SmoothStatusBarMixin.SetSmoothedValue
                element.otherBar.SetMinMaxSmoothedValue = SmoothStatusBarMixin.SetMinMaxSmoothedValue
            end

            if (element.otherBar:IsObjectType('StatusBar') and not element.otherBar:GetStatusBarTexture()) then
                element.otherBar:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
            end
        end

        return true
    end
end

local function Disable(self)
    local element = self.HealthPrediction
    if (element) then
        if (element.myBar) then
            element.myBar:Hide()
        end

        if (element.otherBar) then
            element.otherBar:Hide()
        end

        self:UnregisterEvent('UNIT_HEALTH_FREQUENT', Path)
        self:UnregisterEvent('UNIT_MAXHEALTH', Path)
    end
end

oUF:AddElement('HealthPrediction', Path, Enable, Disable)
