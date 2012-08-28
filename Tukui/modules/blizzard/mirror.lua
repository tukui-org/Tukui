local T, C, L, G = unpack(select(2, ...)) 
local total = MIRRORTIMER_NUMTIMERS

local function Skin(timer, value, maxvalue, scale, paused, label)
	for i = 1, total, 1 do
		local frame = _G["MirrorTimer"..i]
		if not frame.isSkinned then
			frame:SetTemplate("Default")
			
			local statusbar = _G[frame:GetName().."StatusBar"]
			local border = _G[frame:GetName().."Border"]
			local text = _G[frame:GetName().."Text"]
			
			-- status bar position
			statusbar:ClearAllPoints()
			statusbar:Point("TOPLEFT", frame, 2, -2)
			statusbar:Point("BOTTOMRIGHT", frame, -2, 2)
			
			-- text position
			text:ClearAllPoints()
			text:SetPoint("CENTER", frame)
			
			-- status bar texture
			statusbar:SetStatusBarTexture(C.media.normTex)
			
			-- remove blizzard border texture
			border:SetTexture(nil)
			
			-- set the bar as skinned
			frame.isSkinned = true
		end
	end
end

hooksecurefunc("MirrorTimer_Show", Skin)