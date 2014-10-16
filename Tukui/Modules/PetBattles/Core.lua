local T, C, L = select(2, ...):unpack()
local Battle = CreateFrame("Frame")
local PetBattleFrame = PetBattleFrame

function Battle:Enable()
	PetBattleFrame:StripTextures()

	self:SkinUnitFrames()
	self:AddUnitFramesHooks()
	self:SkinTooltips()
	self:AddTooltipsHooks()
	self:SkinPetSelection()
	self:AddActionBar()
	self:SkinActionBar()
	self:AddActionBarHooks()
end

T["PetBattles"] = Battle