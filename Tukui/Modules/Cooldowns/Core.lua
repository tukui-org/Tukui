local T, C, L = select(2, ...):unpack()

local CD = CreateFrame("Frame")

function CD:UpdateCooldown(start, duration, enable, charges, maxcharges, forceShowdrawedge)
	local Enabled = GetCVar("countdownForCooldowns")
	
	if (Enabled) then
		local NumRegions = self:GetNumRegions()
		
		for i = 1, NumRegions do
			local Region = select(i, self:GetRegions())
			
			if Region.GetText and not self.IsCooldownTextEdited then
				local Font = T.GetFont(C["Cooldowns"].Font)
				Font = _G[Font]:GetFont()
				
				Region:SetFont(Font, 14, "OUTLINE")
				Region:Point("CENTER", 1, 0)
				Region:SetTextColor(1, 0, 0)
				
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
