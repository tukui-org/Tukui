local T, C, L = unpack(select(2, ...))
if not IsAddOnLoaded("TinyDPS") then return end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event, addon)
	if not addon == "TinyDPS" then return end
	
	-- define our locals
	local frame = tdpsFrame
	local anchor = tdpsAnchor
	local status = tdpsStatusBar
	local tdps = tinydps
	local font = tdpsFont
	local position = tdpsPosition
	local button = TukuiRaidUtilityShowButton
	
	-- set our default configuration
	if tinydps then
		tinydps.width = TukuiMinimap:GetWidth()
		tinydps.spacing = 2
		tinydps.barHeight = 15
		font.name = C["media"].font
		font.size = 11
		font.outline = "OUTLINE"
	end
	
	-- set default position, under minimap
    anchor:Point('BOTTOMLEFT', TukuiMinimap, 'BOTTOMLEFT', 0, -26)
	
	-- needed, idk why
	position = {x = 0, y = 0}
	
	-- skin it
	frame:SetTemplate("Transparent", true)
	frame:CreateShadow("Default")
	
	if status then
		tdpsStatusBar:SetBackdrop({bgFile = C["media"].normTex, edgeFile = C["media"].blank, tile = false, tileSize = 0, edgeSize = 1, insets = { left = 0, right = 0, top = 0, bottom = 0}})
		tdpsStatusBar:SetStatusBarTexture(C["media"].normTex)
	end
	
	-- move it a little bit if you are a raid leader because of TukuiRaidUtility button.
	if button then
		button:HookScript("OnShow", function(self) 
			anchor:ClearAllPoints()
			anchor:Point('BOTTOMLEFT', TukuiMinimap, 'BOTTOMLEFT', 0, -49)
		end)
		button:HookScript("OnHide", function(self) 
			anchor:ClearAllPoints()
			anchor:Point('BOTTOMLEFT', TukuiMinimap, 'BOTTOMLEFT', 0, -26)
		end)
	end
end)