local _, ns = ...
local oUF = ns.oUF or oUF

if not oUF then return end

local _, ns = ...
local oUF = ns.oUF or _G.oUF
assert(oUF, "oUF_Atonement cannot find an instance of oUF. If your oUF is embedded into a layout, it may not be embedded properly.")

local UnitBuff = UnitBuff

local function OnUpdate(self, elapsed)
	local CurrentTime = GetTime()
	local Timer = self.ExpirationTime - CurrentTime
	
	self:SetValue(Timer)
end

local function Update(self, event, ...)
	local Unit = self.unit
	
	if Unit and Unit ~= self.unit then
		return
	end
	
	local DiscSpec = 1
	local AtonementID = 194384
	local AtonementIDPvP = 214206
	
	self.Atonement.Active = false
	
	if GetSpecialization() == DiscSpec then
		for i = 1, 40 do
			local Buff, Icon, Count, DebuffType, Duration, ExpirationTime, UnitCaster, IsStealable, ShouldConsolidate, SpellID = UnitBuff(Unit, i)

			if not Buff then
				break
			end

			if (SpellID == AtonementID) or (SpellID == AtonementIDPvP) then
				self.Atonement.Duration = Duration
				self.Atonement.ExpirationTime = ExpirationTime
				self.Atonement:SetMinMaxValues(0, Duration)
				self.Atonement:SetScript("OnUpdate", OnUpdate)
				self.Atonement:Show()
				self.Atonement.Active = true

				return
			end
		end
		
		if not self.Atonement.Active then
			self.Atonement:SetScript("OnUpdate", nil)
			self.Atonement:SetValue(0)
			self.Atonement:Hide()
		end
	else
		self.Atonement:Hide()
		self.Atonement:SetScript("OnUpdate", nil)
		self.Atonement:SetValue(0)
		self.Atonement:Hide()
	end
end

local function Enable(self)
	if self.Atonement then
		self:RegisterEvent("UNIT_AURA", Update)
		self:RegisterEvent("PLAYER_TALENT_UPDATE", Update)
		
		self.Atonement:SetMinMaxValues(0, 15)
		self.Atonement:SetValue(0)
		self.Atonement:SetStatusBarColor(207/255, 181/255, 59/255)
		
		if not self.Atonement.Backdrop then
			self.Atonement.Backdrop = self.Atonement:CreateTexture(nil, "BACKGROUND")
			self.Atonement.Backdrop:SetAllPoints()
			self.Atonement.Backdrop:SetColorTexture(207/255 * 0.2, 181/255 * 0.2, 59/255 * 0.2)
		end

		return true
	else
		return false
	end
end

local function Disable(self)
	if self.Attonement then
		self:UnregisterEvent("UNIT_AURA", Update)
		self:UnregisterEvent("PLAYER_TALENT_UPDATE", Update)
	end
end

oUF:AddElement("Atonement", Update, Enable, Disable)
