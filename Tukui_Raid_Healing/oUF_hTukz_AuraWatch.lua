local T, C, L = unpack(Tukui) -- Import: T - functions, constants, variables; C - config; L - locales
--------------------------------------------------------------------------------------------
-- THE AURAWATCH FUNCTION ITSELF. HERE BE DRAGONS!
--------------------------------------------------------------------------------------------

T.countOffsets = {
	TOPLEFT = {6*C["unitframes"].gridscale, 1},
	TOPRIGHT = {-6*C["unitframes"].gridscale, 1},
	BOTTOMLEFT = {6*C["unitframes"].gridscale, 1},
	BOTTOMRIGHT = {-6*C["unitframes"].gridscale, 1},
	LEFT = {6*C["unitframes"].gridscale, 1},
	RIGHT = {-6*C["unitframes"].gridscale, 1},
	TOP = {0, 0},
	BOTTOM = {0, 0},
}

T.CreateAuraWatchIcon = function(self, icon)
	icon:SetTemplate("Default")
	icon.icon:Point("TOPLEFT", 1, -1)
	icon.icon:Point("BOTTOMRIGHT", -1, 1)
	icon.icon:SetTexCoord(.08, .92, .08, .92)
	icon.icon:SetDrawLayer("ARTWORK")
	if (icon.cd) then
		icon.cd:SetReverse()
	end
	icon.overlay:SetTexture()
end

T.createAuraWatch = function(self, unit)
	local auras = CreateFrame("Frame", nil, self)
	auras:SetPoint("TOPLEFT", self.Health, 2, -2)
	auras:SetPoint("BOTTOMRIGHT", self.Health, -2, 2)
	auras.presentAlpha = 1
	auras.missingAlpha = 0
	auras.icons = {}
	auras.PostCreateIcon = T.CreateAuraWatchIcon

	if (not C["unitframes"].auratimer) then
		auras.hideCooldown = true
	end

	local buffs = {}

	if (T.buffids["ALL"]) then
		for key, value in pairs(T.buffids["ALL"]) do
			tinsert(buffs, value)
		end
	end

	if (T.buffids[T.myclass]) then
		for key, value in pairs(T.buffids[T.myclass]) do
			tinsert(buffs, value)
		end
	end

	-- "Cornerbuffs"
	if (buffs) then
		for key, spell in pairs(buffs) do
			local icon = CreateFrame("Frame", nil, auras)
			icon.spellID = spell[1]
			icon.anyUnit = spell[4]
			icon:SetWidth(T.Scale(6*C["unitframes"].gridscale))
			icon:SetHeight(T.Scale(6*C["unitframes"].gridscale))
			icon:SetPoint(spell[2], 0, 0)

			local tex = icon:CreateTexture(nil, "OVERLAY")
			tex:SetAllPoints(icon)
			tex:SetTexture(C.media.blank)
			if (spell[3]) then
				tex:SetVertexColor(unpack(spell[3]))
			else
				tex:SetVertexColor(0.8, 0.8, 0.8)
			end

			local count = icon:CreateFontString(nil, "OVERLAY")
			count:SetFont(C["media"].uffont, 8*C["unitframes"].gridscale, "THINOUTLINE")
			count:SetPoint("CENTER", unpack(T.countOffsets[spell[2]]))
			icon.count = count

			auras.icons[spell[1]] = icon
		end
	end
	
	self.AuraWatch = auras
end

if C["unitframes"].raidunitdebuffwatch == true then
	-- Classbuffs { spell ID, position [, {r,g,b,a}][, anyUnit] }
	-- For oUF_AuraWatch
	do
		T.buffids = {
			PRIEST = {
				{6788, "TOPLEFT", {1, 0, 0}, true}, -- Weakened Soul
				{33076, "TOPRIGHT", {0.2, 0.7, 0.2}}, -- Prayer of Mending
				{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, -- Renew
				{17, "BOTTOMRIGHT", {0.81, 0.85, 0.1}, true}, -- Power Word: Shield
			},
			DRUID = {
				{774, "TOPLEFT", {0.8, 0.4, 0.8}}, -- Rejuvenation
				{8936, "TOPRIGHT", {0.2, 0.8, 0.2}}, -- Regrowth
				{33763, "BOTTOMLEFT", {0.4, 0.8, 0.2}}, -- Lifebloom
				{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}}, -- Wild Growth
			},
			PALADIN = {
				{53563, "TOPLEFT", {0.7, 0.3, 0.7}}, -- Beacon of Light
			},
			SHAMAN = {
				{61295, "TOPLEFT", {0.7, 0.3, 0.7}}, -- Riptide 
				{51945, "TOPRIGHT", {0.2, 0.7, 0.2}}, -- Earthliving
				{16177, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, -- Ancestral Fortitude
				{974, "BOTTOMRIGHT", {0.7, 0.4, 0}, true}, -- Earth Shield
			},
			ALL = {
				{14253, "RIGHT", {0, 1, 0}}, -- Abolish Poison
				{23333, "LEFT", {1, 0, 0}}, -- Warsong flag xD
			},
		}
	end
		local _, ns = ...
	-- Raid debuffs (now using it with oUF_RaidDebuff instead of oUF_Aurawatch)
	do
		local ORD = ns.oUF_RaidDebuffs or oUF_RaidDebuffs

		if not ORD then return end
		
		ORD.ShowDispelableDebuff = true
		ORD.FilterDispellableDebuff = true
		ORD.MatchBySpellName = false

		T.debuffids = {
			-- Other debuff
			67479, -- Impale
			
			--CATA DEBUFFS
		--Baradin Hold
			95173, -- Consuming Darkness
			
		--Blackwing Descent
			--Magmaw
			91911, -- Constricting Chains
			94679, -- Parasitic Infection
			94617, -- Mangle
			
			--Omintron Defense System
			79835, --Poison Soaked Shell	
			91433, --Lightning Conductor
			91521, --Incineration Security Measure
			
			--Maloriak
			77699, -- Flash Freeze
			77760, -- Biting Chill
			
			--Atramedes
			92423, -- Searing Flame
			92485, -- Roaring Flame
			92407, -- Sonic Breath
			
			--Chimaeron
			82881, -- Break
			89084, -- Low Health
			
			--Nefarian
			
		--The Bastion of Twilight
			--Valiona & Theralion
			92878, -- Blackout
			86840, -- Devouring Flames
			95639, -- Engulfing Magic
			
			--Halfus Wyrmbreaker
			39171, -- Malevolent Strikes
			
			--Twilight Ascendant Council
			92511, -- Hydro Lance
			82762, -- Waterlogged
			92505, -- Frozen
			92518, -- Flame Torrent
			83099, -- Lightning Rod
			92075, -- Gravity Core
			92488, -- Gravity Crush
			
			--Cho'gall
			86028, -- Cho's Blast
			86029, -- Gall's Blast
			
		--Throne of the Four Winds
			--Conclave of Wind
				--Nezir <Lord of the North Wind>
				93131, --Ice Patch
				--Anshal <Lord of the West Wind>
				86206, --Soothing Breeze
				93122, --Toxic Spores
				--Rohash <Lord of the East Wind>
				93058, --Slicing Gale 
			--Al'Akir
			93260, -- Ice Storm
			93295, -- Lightning Rod
		}
		
		ORD:RegisterDebuffs(T.debuffids)
	end
end