local T, C, L = select(2, ...):unpack()

local CD = CreateFrame("Frame")

function CD:UpdateCooldown(start, duration, enable, charges, maxcharges, forceShowdrawedge)
	local Enabled = GetCVar("countdownForCooldowns")
	
	if (Enabled) then
		local Regions = self:GetRegions() 
	
		for i, v in pairs(Regions) do
			if Regions.GetText and not self.IsCooldownTextEdited then
				local Font = T.GetFont(C["Cooldowns"].Font)
				Font = _G[Font]:GetFont()
				
				Regions:SetFont(Font, 14, "OUTLINE")
				Regions:Point("CENTER", 1, 0)
				Regions:SetTextColor(1, 0, 0)
				
				self.IsCooldownTextEdited = true
			end 
		end
	end
end

function CD:AddHooks()
	hooksecurefunc("CooldownFrame_SetTimer", CD.UpdateCooldown)
end

function CD:Enable()
	CD:AddHooks()
end

T["Cooldowns"] = CD
