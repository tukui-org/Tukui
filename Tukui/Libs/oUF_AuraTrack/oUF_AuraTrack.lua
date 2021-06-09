local parent, ns = ...
local oUF = ns.oUF
local Tracker

--[[
	By Tukz, for Tukui

	.Thickness : Thickness of the statusbar
	.Tracker : Table of buffs spell id to track, if not spiecified, use default listing
	.Texture : Texture you want to use for status bars
	.Icons : Set to true if you wish to use squared icons instead of status bars
	.SpellTextures : Spell Textures instead of colored squares
	.MaxAuras : Set the max amount of status or icons shows

	Example:
		local AuraTrack = CreateFrame("Frame", nil, Health)
		AuraTrack:SetAllPoints()
		AuraTrack.Texture = C.Medias.Normal

		self.AuraTrack = AuraTrack
]]

if oUF.Retail then
	Tracker = {
		-- Priest
		[194384]  = {1, 1, 0.66}, -- Atonement
		[214206]  = {1, 1, 0.66}, -- Atonement (PvP)
		[41635]   = {0.2, 0.7, 0.2}, -- Prayer of Mending
		[193065]  = {0.54, 0.21, 0.78}, -- Masochism
		[139]     = {0.4, 0.7, 0.2}, -- Renew
		[17]      = {0.89, 0.1, 0.1}, -- Power Word: Shield
		[47788]   = {0.86, 0.45, 0}, -- Guardian Spirit
		[33206]   = {0, 0, 0.74}, -- Pain Suppression
		[10060]   = {0, 0, 0.74}, -- Power Infusion

		-- Druid
		[774]     = {0.8, 0.4, 0.8}, -- Rejuvenation
		[155777]  = {0.8, 0.4, 0.8}, -- Germination
		[8936]    = {1, 1, 0}, -- Regrowth
		[33763]   = {0.4, 0.8, 0.2}, -- Lifebloom (Normal version)
		[188550]  = {0.4, 0.8, 0.2}, -- Lifebloom (Legendary version)
		[48438]   = {0.8, 0.4, 0}, -- Wild Growth
		[207386]  = {0.4, 0.2, 0.8}, -- Spring Blossoms
		[102351]  = {0.2, 0.8, 0.8}, -- Cenarion Ward (Initial Buff)
		[102352]  = {0.2, 0.8, 0.8}, -- Cenarion Ward (HoT)
		[200389]  = {1, 1, 0.4}, -- Cultivation

		-- Paladin
		[53563]   = {0.7, 0.3, 0.7}, -- Beacon of Light
		[156910]  = {0.7, 0.3, 0.7}, -- Beacon of Faith
		[200025]  = {0.7, 0.3, 0.7}, -- Beacon of Virtue
		[1022]    = {0.2, 0.2, 1}, -- Hand of Protection
		[1044]    = {0.89, 0.45, 0}, -- Hand of Freedom
		[6940]    = {0.89, 0.1, 0.1}, -- Hand of Sacrifice
		[223306]  = {0.7, 0.7, 0.3}, -- Bestow Faith
		[287280]  = {0.2, 0.8, 0.2}, -- Glimmer of Light (Artifact HoT)

		-- Shaman
		[61295]   = {0.7, 0.3, 0.7}, -- Riptide
		[974]     = {0.2, 0.2, 1}, -- Earth Shield

		-- Monk
		[119611]  = {0.3, 0.8, 0.6}, -- Renewing Mist
		[116849]  = {0.2, 0.8, 0.2}, -- Life Cocoon
		[124682]  = {0.8, 0.8, 0.25}, -- Enveloping Mist
		[191840]  = {0.27, 0.62, 0.7}, -- Essence Font

		-- Rogue
		[57934]   = {0.89, 0.09, 0.05}, -- Tricks of the Trade

		-- Warrior
		[114030]  = {0.2, 0.2, 1}, -- Vigilance
		[3411]    = {0.89, 0.09, 0.05}, -- Intervene

		-- Others
		[193396]  = {0.6, 0.2, 0.8}, -- Demonic Empowerment
		[272790]  = {0.89, 0.09, 0.05}, -- Frenzy
		[136]     = {0.2, 0.8, 0.2}, -- Mend Pet
	}
else
	Tracker = {
	-- Priest
		[1243]    = {1, 1, 0.66}, -- Power Word: Fortitude(Rank 1)
		[1244]    = {1, 1, 0.66}, -- Power Word: Fortitude(Rank 2)
		[1245]    = {1, 1, 0.66}, -- Power Word: Fortitude(Rank 3)
		[2791]    = {1, 1, 0.66}, -- Power Word: Fortitude(Rank 4)
		[10937]   = {1, 1, 0.66}, -- Power Word: Fortitude(Rank 5)
		[10938]   = {1, 1, 0.66}, -- Power Word: Fortitude(Rank 6)
		[25389]   = {1, 1, 0.66}, -- Power Word: Fortitude(Rank 7)
		[21562]   = {1, 1, 0.66}, -- Prayer of Fortitude(Rank 1)
		[21564]   = {1, 1, 0.66}, -- Prayer of Fortitude(Rank 2)
		[14752]   = {0.2, 0.7, 0.2}, -- Divine Spirit(Rank 1)
		[14818]   = {0.2, 0.7, 0.2}, -- Divine Spirit(Rank 2)
		[14819]   = {0.2, 0.7, 0.2}, -- Divine Spirit(Rank 3)
		[27841]   = {0.2, 0.7, 0.2}, -- Divine Spirit(Rank 4)
		[25312]   = {0.2, 0.7, 0.2}, -- Divine Spirit(Rank 5)
		[27681]   = {0.2, 0.7, 0.2}, -- Prayer of Spirit(Rank 1)
		[32999]   = {0.2, 0.7, 0.2}, -- Prayer of Spirit(Rank 2)
		[976]     = {0.7, 0.7, 0.7}, -- Shadow Protection(Rank 1)
		[10957]   = {0.7, 0.7, 0.7}, -- Shadow Protection(Rank 2)
		[10958]   = {0.7, 0.7, 0.7}, -- Shadow Protection(Rank 3)
		[25433]   = {0.7, 0.7, 0.7}, -- Shadow Protection(Rank 4)
		[27683]   = {0.7, 0.7, 0.7}, -- Prayer of Shadow Protection(Rank 1)
		[17]      = {0.00, 0.00, 1.00}, -- Power Word: Shield(Rank 1)
		[592]     = {0.00, 0.00, 1.00}, -- Power Word: Shield(Rank 2)
		[600]     = {0.00, 0.00, 1.00}, -- Power Word: Shield(Rank 3)
		[3747]    = {0.00, 0.00, 1.00}, -- Power Word: Shield(Rank 4)
		[6065]    = {0.00, 0.00, 1.00}, -- Power Word: Shield(Rank 5)
		[6066]    = {0.00, 0.00, 1.00}, -- Power Word: Shield(Rank 6)
		[10898]   = {0.00, 0.00, 1.00}, -- Power Word: Shield(Rank 7)
		[10899]   = {0.00, 0.00, 1.00}, -- Power Word: Shield(Rank 8)
		[10900]   = {0.00, 0.00, 1.00}, -- Power Word: Shield(Rank 9)
		[10901]   = {0.00, 0.00, 1.00}, -- Power Word: Shield(Rank 10)
		[25217]   = {0.00, 0.00, 1.00}, -- Power Word: Shield(Rank 11)
		[25218]   = {0.00, 0.00, 1.00}, -- Power Word: Shield(Rank 12)
		[139]     = {0.33, 0.73, 0.75}, -- Renew(Rank 1)
		[6074]    = {0.33, 0.73, 0.75}, -- Renew(Rank 2)
		[6075]    = {0.33, 0.73, 0.75}, -- Renew(Rank 3)
		[6076]    = {0.33, 0.73, 0.75}, -- Renew(Rank 4)
		[6077]    = {0.33, 0.73, 0.75}, -- Renew(Rank 5)
		[6078]    = {0.33, 0.73, 0.75}, -- Renew(Rank 6)
		[10927]   = {0.33, 0.73, 0.75}, -- Renew(Rank 7)
		[10928]   = {0.33, 0.73, 0.75}, -- Renew(Rank 8)
		[10929]   = {0.33, 0.73, 0.75}, -- Renew(Rank 9)
		[25315]   = {0.33, 0.73, 0.75}, -- Renew(Rank 10)
		[25221]   = {0.33, 0.73, 0.75}, -- Renew(Rank 11)
		[25222]   = {0.33, 0.73, 0.75}, -- Renew(Rank 12)
	-- Hunter
		[19506]   = {0.89, 0.09, 0.05}, -- Trueshot Aura (Rank 1)
		[20905]   = {0.89, 0.09, 0.05}, -- Trueshot Aura (Rank 2)
		[20906]   = {0.89, 0.09, 0.05}, -- Trueshot Aura (Rank 3)
		[27066]   = {0.89, 0.09, 0.05}, -- Trueshot Aura (Rank 4)
		[13159]   = {0.00, 0.00, 0.85}, -- Aspect of the Pack
		[20043]   = {0.33, 0.93, 0.79}, -- Aspect of the Wild (Rank 1)
		[20190]   = {0.33, 0.93, 0.79}, -- Aspect of the Wild (Rank 2)
		[27045]   = {0.33, 0.93, 0.79}, -- Aspect of the Wild (Rank 3)
	-- Mage
		[1459]    = {0.89, 0.09, 0.05}, -- Arcane Intellect(Rank 1)
		[1460]    = {0.89, 0.09, 0.05}, -- Arcane Intellect(Rank 2)
		[1461]    = {0.89, 0.09, 0.05}, -- Arcane Intellect(Rank 3)
		[10156]   = {0.89, 0.09, 0.05}, -- Arcane Intellect(Rank 4)
		[10157]   = {0.89, 0.09, 0.05}, -- Arcane Intellect(Rank 5)
		[27126]   = {0.89, 0.09, 0.05}, -- Arcane Intellect(Rank 6)
		[23028]   = {0.89, 0.09, 0.05}, -- Arcane Brilliance(Rank 1)
		[27127]   = {0.89, 0.09, 0.05}, -- Arcane Brilliance(Rank 2)
		[604]     = {0.2, 0.8, 0.2}, -- Dampen Magic(Rank 1)
		[8450]    = {0.2, 0.8, 0.2}, -- Dampen Magic(Rank 2)
		[8451]    = {0.2, 0.8, 0.2}, -- Dampen Magic(Rank 3)
		[10173]   = {0.2, 0.8, 0.2}, -- Dampen Magic(Rank 4)
		[10174]   = {0.2, 0.8, 0.2}, -- Dampen Magic(Rank 5)
		[33944]   = {0.2, 0.8, 0.2}, -- Dampen Magic(Rank 6)
		[1008]    = {0.2, 0.8, 0.2}, -- Amplify Magic(Rank 1)
		[8455]    = {0.2, 0.8, 0.2}, -- Amplify Magic(Rank 2)
		[10169]   = {0.2, 0.8, 0.2}, -- Amplify Magic(Rank 3)
		[10170]   = {0.2, 0.8, 0.2}, -- Amplify Magic(Rank 4)
		[27130]   = {0.2, 0.8, 0.2}, -- Amplify Magic(Rank 5)
		[33946]   = {0.2, 0.8, 0.2}, -- Amplify Magic(Rank 6)
		[130]     = {0.00, 0.00, 0.50}, -- Slow Fall
	-- Paladin
		[1044]    = {0.89, 0.45, 0}, -- Blessing of Freedom
		[6940]    = {0.89, 0.1, 0.1}, -- Blessing Sacrifice(Rank 1)
		[20729]   = {0.89, 0.1, 0.1}, -- Blessing Sacrifice(Rank 2)
		[27147]   = {0.89, 0.1, 0.1}, -- Blessing Sacrifice(Rank 3)
		[27148]   = {0.89, 0.1, 0.1}, -- Blessing Sacrifice(Rank 4)
		[19740]   = {0.2, 0.8, 0.2}, -- Blessing of Might(Rank 1)
		[19834]   = {0.2, 0.8, 0.2}, -- Blessing of Might(Rank 2)
		[19835]   = {0.2, 0.8, 0.2}, -- Blessing of Might(Rank 3)
		[19836]   = {0.2, 0.8, 0.2}, -- Blessing of Might(Rank 4)
		[19837]   = {0.2, 0.8, 0.2}, -- Blessing of Might(Rank 5)
		[19838]   = {0.2, 0.8, 0.2}, -- Blessing of Might(Rank 6)
		[25291]   = {0.2, 0.8, 0.2}, -- Blessing of Might(Rank 7)
		[27140]   = {0.2, 0.8, 0.2}, -- Blessing of Might(Rank 8)
		[19742]   = {0.2, 0.8, 0.2}, -- Blessing of Wisdom(Rank 1)
		[19850]   = {0.2, 0.8, 0.2}, -- Blessing of Wisdom(Rank 2)
		[19852]   = {0.2, 0.8, 0.2}, -- Blessing of Wisdom(Rank 3)
		[19853]   = {0.2, 0.8, 0.2}, -- Blessing of Wisdom(Rank 4)
		[19854]   = {0.2, 0.8, 0.2}, -- Blessing of Wisdom(Rank 5)
		[25290]   = {0.2, 0.8, 0.2}, -- Blessing of Wisdom(Rank 6)
		[27142]   = {0.2, 0.8, 0.2}, -- Blessing of Wisdom(Rank 7)
		[25782]   = {0.2, 0.8, 0.2}, -- Greater Blessing of Might(Rank 1)
		[25916]   = {0.2, 0.8, 0.2}, -- Greater Blessing of Might(Rank 2)
		[27141]   = {0.2, 0.8, 0.2}, -- Greater Blessing of Might(Rank 3)
		[25894]   = {0.2, 0.8, 0.2}, -- Greater Blessing of Wisdom(Rank 1)
		[25918]   = {0.2, 0.8, 0.2}, -- Greater Blessing of Wisdom(Rank 2)
		[27143]   = {0.2, 0.8, 0.2}, -- Greater Blessing of Wisdom(Rank 3)
		[465]     = {0.58, 1.00, 0.50}, -- Devotion Aura(Rank 1)
		[10290]   = {0.58, 1.00, 0.50}, -- Devotion Aura(Rank 2)
		[643]     = {0.58, 1.00, 0.50}, -- Devotion Aura(Rank 3)
		[10291]   = {0.58, 1.00, 0.50}, -- Devotion Aura(Rank 4)
		[1032]    = {0.58, 1.00, 0.50}, -- Devotion Aura(Rank 5)
		[10292]   = {0.58, 1.00, 0.50}, -- Devotion Aura(Rank 6)
		[10293]   = {0.58, 1.00, 0.50}, -- Devotion Aura(Rank 7)
		[27149]   = {0.58, 1.00, 0.50}, -- Devotion Aura(Rank 8)
		[19977]   = {0.17, 1.00, 0.75}, -- Blessing of Light(Rank 1)
		[19978]   = {0.17, 1.00, 0.75}, -- Blessing of Light(Rank 2)
		[19979]   = {0.17, 1.00, 0.75}, -- Blessing of Light(Rank 3)
		[27144]   = {0.17, 1.00, 0.75}, -- Blessing of Light(Rank 4)
		[1022]    = {0.17, 1.00, 0.75}, -- Blessing of Protection(Rank 1)
		[5599]    = {0.17, 1.00, 0.75}, -- Blessing of Protection(Rank 2)
		[10278]   = {0.17, 1.00, 0.75}, -- Blessing of Protection(Rank 3)
		[19746]   = {0.83, 1.00, 0.07}, -- Concentration Aura
		[32223]   = {0.83, 1.00, 0.07}, -- Crusader Aura
		[28790]   = {1.00, 1.00, 0.07}, -- Holy Power (armor)
		[28791]   = {1.00, 1.00, 0.07}, -- Holy Power (attack power)
		[28793]   = {1.00, 1.00, 0.07}, -- Holy Power (spell damage)
		[28795]   = {1.00, 1.00, 0.07}, -- Holy Power (mana regeneration)
	-- Druid
		[1126]    = {0.2, 0.8, 0.8}, -- Mark of the Wild(Rank 1)
		[5232]    = {0.2, 0.8, 0.8}, -- Mark of the Wild(Rank 2)
		[6756]    = {0.2, 0.8, 0.8}, -- Mark of the Wild(Rank 3)
		[5234]    = {0.2, 0.8, 0.8}, -- Mark of the Wild(Rank 4)
		[8907]    = {0.2, 0.8, 0.8}, -- Mark of the Wild(Rank 5)
		[9884]    = {0.2, 0.8, 0.8}, -- Mark of the Wild(Rank 6)
		[9885]    = {0.2, 0.8, 0.8}, -- Mark of the Wild(Rank 7)
		[26990]   = {0.2, 0.8, 0.8}, -- Mark of the Wild(Rank 8)
		[21849]   = {0.2, 0.8, 0.8}, -- Gift of the Wild(Rank 1)
		[21850]   = {0.2, 0.8, 0.8}, -- Gift of the Wild(Rank 2)
		[467]     = {0.4, 0.2, 0.8}, -- Thorns(Rank 1)
		[782]     = {0.4, 0.2, 0.8}, -- Thorns(Rank 2)
		[1075]    = {0.4, 0.2, 0.8}, -- Thorns(Rank 3)
		[8914]    = {0.4, 0.2, 0.8}, -- Thorns(Rank 4)
		[9756]    = {0.4, 0.2, 0.8}, -- Thorns(Rank 5)
		[9910]    = {0.4, 0.2, 0.8}, -- Thorns(Rank 6)
		[26992]   = {0.4, 0.2, 0.8}, -- Thorns(Rank 7)
		[774]     = {0.83, 1.00, 0.25}, -- Rejuvenation(Rank 1)
		[1058]    = {0.83, 1.00, 0.25}, -- Rejuvenation(Rank 2)
		[1430]    = {0.83, 1.00, 0.25}, -- Rejuvenation(Rank 3)
		[2090]    = {0.83, 1.00, 0.25}, -- Rejuvenation(Rank 4)
		[2091]    = {0.83, 1.00, 0.25}, -- Rejuvenation(Rank 5)
		[3627]    = {0.83, 1.00, 0.25}, -- Rejuvenation(Rank 6)
		[8910]    = {0.83, 1.00, 0.25}, -- Rejuvenation(Rank 7)
		[9839]    = {0.83, 1.00, 0.25}, -- Rejuvenation(Rank 8)
		[9840]    = {0.83, 1.00, 0.25}, -- Rejuvenation(Rank 9)
		[9841]    = {0.83, 1.00, 0.25}, -- Rejuvenation(Rank 10)
		[25299]   = {0.83, 1.00, 0.25}, -- Rejuvenation(Rank 11)
		[26981]   = {0.83, 1.00, 0.25}, -- Rejuvenation(Rank 12)
		[26982]   = {0.83, 1.00, 0.25}, -- Rejuvenation(Rank 13)
		[8936]    = {0.33, 0.73, 0.75}, -- Regrowth(Rank 1)
		[8938]    = {0.33, 0.73, 0.75}, -- Regrowth(Rank 2)
		[8939]    = {0.33, 0.73, 0.75}, -- Regrowth(Rank 3)
		[8940]    = {0.33, 0.73, 0.75}, -- Regrowth(Rank 4)
		[8941]    = {0.33, 0.73, 0.75}, -- Regrowth(Rank 5)
		[9750]    = {0.33, 0.73, 0.75}, -- Regrowth(Rank 6)
		[9856]    = {0.33, 0.73, 0.75}, -- Regrowth(Rank 7)
		[9857]    = {0.33, 0.73, 0.75}, -- Regrowth(Rank 8)
		[9858]    = {0.33, 0.73, 0.75}, -- Regrowth(Rank 9)
		[26980]   = {0.33, 0.73, 0.75}, -- Regrowth(Rank 10)
		[29166]   = {0.49, 0.60, 0.55}, -- Innervate
		[33763]   = {0.33, 0.37, 0.47}, -- Lifebloom
	-- Rogue
		-- No buffs to track
	-- Shaman
		[974]     = {0.2, 0.2, 1}, -- Earth Shield(Rank 1)
		[32593]   = {0.2, 0.2, 1}, -- Earth Shield(Rank 2)
		[32594]   = {0.2, 0.2, 1}, -- Earth Shield(Rank 3)
		[30708]   = {1.00, 0, 0}, -- Totem of Wrath(Rank 1)
		[29203]   = {0.7, 0.3, 0.7}, -- Healing Way
		[16237]   = {0.2, 0.2, 1}, -- Ancestral Fortitude
		[25909]   = {0.00, 0.00, 0.50}, -- Tranquil Air
		[8185]    = {0.05, 1.00, 0.50}, -- Fire Resistance Totem(Rank 1)
		[10534]   = {0.05, 1.00, 0.50}, -- Fire Resistance Totem(Rank 2)
		[10535]   = {0.05, 1.00, 0.50}, -- Fire Resistance Totem(Rank 3)
		[25562]   = {0.05, 1.00, 0.50}, -- Fire Resistance Totem(Rank 4)
		[8182]    = {0.54, 0.53, 0.79}, -- Frost Resistance Totem(Rank 1)
		[10476]   = {0.54, 0.53, 0.79}, -- Frost Resistance Totem(Rank 2)
		[10477]   = {0.54, 0.53, 0.79}, -- Frost Resistance Totem(Rank 3)
		[25559]   = {0.54, 0.53, 0.79}, -- Frost Resistance Totem(Rank 4)
		[10596]   = {0.33, 1.00, 0.20}, -- Nature Resistance Totem(Rank 1)
		[10598]   = {0.33, 1.00, 0.20}, -- Nature Resistance Totem(Rank 2)
		[10599]   = {0.33, 1.00, 0.20}, -- Nature Resistance Totem(Rank 3)
		[25573]   = {0.33, 1.00, 0.20}, -- Nature Resistance Totem(Rank 4)
		[5672]    = {0.67, 1.00, 0.50}, -- Healing Stream Totem(Rank 1)
		[6371]    = {0.67, 1.00, 0.50}, -- Healing Stream Totem(Rank 2)
		[6372]    = {0.67, 1.00, 0.50}, -- Healing Stream Totem(Rank 3)
		[10460]   = {0.67, 1.00, 0.50}, -- Healing Stream Totem(Rank 4)
		[10461]   = {0.67, 1.00, 0.50}, -- Healing Stream Totem(Rank 5)
		[25566]   = {0.67, 1.00, 0.50}, -- Healing Stream Totem(Rank 6)
		[5677]    = {0.67, 1.00, 0.80}, -- Mana Spring Totem(Rank 1)
		[10491]   = {0.67, 1.00, 0.80}, -- Mana Spring Totem(Rank 2)
		[10493]   = {0.67, 1.00, 0.80}, -- Mana Spring Totem(Rank 3)
		[10494]   = {0.67, 1.00, 0.80}, -- Mana Spring Totem(Rank 4)
		[25569]   = {0.67, 1.00, 0.80}, -- Mana Spring Totem(Rank 5)
		[8072]    = {0.00, 0.00, 0.26}, -- Stoneskin Totem(Rank 1)
		[8156]    = {0.00, 0.00, 0.26}, -- Stoneskin Totem(Rank 2)
		[8157]    = {0.00, 0.00, 0.26}, -- Stoneskin Totem(Rank 3)
		[10403]   = {0.00, 0.00, 0.26}, -- Stoneskin Totem(Rank 4)
		[10404]   = {0.00, 0.00, 0.26}, -- Stoneskin Totem(Rank 5)
		[10405]   = {0.00, 0.00, 0.26}, -- Stoneskin Totem(Rank 6)
		[25506]   = {0.00, 0.00, 0.26}, -- Stoneskin Totem(Rank 7)
		[25507]   = {0.00, 0.00, 0.26}, -- Stoneskin Totem(Rank 8)
		[8076]    = {0.78, 0.61, 0.43}, -- Strength of Earth Totem(Rank 1)
		[8162]    = {0.78, 0.61, 0.43}, -- Strength of Earth Totem(Rank 2)
		[8163]    = {0.78, 0.61, 0.43}, -- Strength of Earth Totem(Rank 3)
		[10441]   = {0.78, 0.61, 0.43}, -- Strength of Earth Totem(Rank 4)
		[25362]   = {0.78, 0.61, 0.43}, -- Strength of Earth Totem(Rank 5)
		[25527]   = {0.78, 0.61, 0.43}, -- Strength of Earth Totem(Rank 6)
		[8836]    = {1.00, 1.00, 1.00}, -- Grace of Air Totem(Rank 1)
		[10626]   = {1.00, 1.00, 1.00}, -- Grace of Air Totem(Rank 2)
		[25360]   = {1.00, 1.00, 1.00}, -- Grace of Air Totem(Rank 3)
		[2895]    = {1.00, 1.00, 1.00}, -- Wrath of Air Totem(Rank 1)
	-- Warlock
		[5597]    = {0.89, 0.09, 0.05}, -- Unending Breath
		[6512]    = {0.2, 0.8, 0.2}, -- Detect Lesser Invisibility
		[2970]    = {0.2, 0.8, 0.2}, -- Detect Invisibility
		[11743]   = {0.2, 0.8, 0.2}, -- Detect Greater Invisibility
		[6307]    = {0.89, 0.09, 0.05}, -- Blood Pact(Rank 1)
		[7804]    = {0.89, 0.09, 0.05}, -- Blood Pact(Rank 2)
		[7805]    = {0.89, 0.09, 0.05}, -- Blood Pact(Rank 3)
		[11766]   = {0.89, 0.09, 0.05}, -- Blood Pact(Rank 4)
		[11767]   = {0.89, 0.09, 0.05}, -- Blood Pact(Rank 5)
		[19480]   = {0.2, 0.8, 0.2}, -- Paranoia
		[24604]   = {0.08, 0.59, 0.41}, -- Furious Howl(Rank 1)
		[24605]   = {0.08, 0.59, 0.41}, -- Furious Howl(Rank 2)
		[24603]   = {0.08, 0.59, 0.41}, -- Furious Howl(Rank 3)
		[24597]   = {0.08, 0.59, 0.41}, -- Furious Howl(Rank 4)
	-- Warrior
		[6673]    = {0.2, 0.2, 1}, -- Battle Shout(Rank 1)
		[5242]    = {0.2, 0.2, 1}, -- Battle Shout(Rank 2)
		[6192]    = {0.2, 0.2, 1}, -- Battle Shout(Rank 3)
		[11549]   = {0.2, 0.2, 1}, -- Battle Shout(Rank 4)
		[11550]   = {0.2, 0.2, 1}, -- Battle Shout(Rank 5)
		[11551]   = {0.2, 0.2, 1}, -- Battle Shout(Rank 6)
		[25289]   = {0.2, 0.2, 1}, -- Battle Shout(Rank 7)
		[2048]    = {0.2, 0.2, 1}, -- Battle Shout(Rank 8)
		[469]     = {0.4, 0.2, 0.8}, -- Commanding Shout
	-- Racial

	}
end

local OnUpdate = function(self)
	local Time = GetTime()
	local Timeleft = self.Expiration - Time
	local Duration = self.Duration
	
	if self.SetMinMaxValues then
		self:SetMinMaxValues(0, Duration)
		self:SetValue(Timeleft)
	end
end

local UpdateIcon = function(self, unit, spellID, texture, id, expiration, duration, count)
	local AuraTrack = self.AuraTrack
	
	if id > AuraTrack.MaxAuras then
		return
	end
	
	local PositionX = (id * AuraTrack.IconSize) - (AuraTrack.IconSize) + (AuraTrack.Spacing * id)
	local r, g, b = unpack(Tracker[spellID])
	
	if not AuraTrack.Auras[id] then
		AuraTrack.Auras[id] = CreateFrame("Frame", nil, AuraTrack)
		AuraTrack.Auras[id]:SetSize(AuraTrack.IconSize, AuraTrack.IconSize)
		AuraTrack.Auras[id]:SetPoint("TOPLEFT", PositionX, AuraTrack.IconSize / 3)
		
		AuraTrack.Auras[id].Backdrop = AuraTrack.Auras[id]:CreateTexture(nil, "BACKGROUND")
		AuraTrack.Auras[id].Backdrop:SetPoint("TOPLEFT", AuraTrack.Auras[id], -1, 1)
		AuraTrack.Auras[id].Backdrop:SetPoint("BOTTOMRIGHT", AuraTrack.Auras[id], 1, -1)
		
		if AuraTrack.Auras[id].Backdrop.CreateShadow then
			AuraTrack.Auras[id]:CreateShadow()
		end
		
		AuraTrack.Auras[id].Texture = AuraTrack.Auras[id]:CreateTexture(nil, "ARTWORK")
		AuraTrack.Auras[id].Texture:SetAllPoints()
		AuraTrack.Auras[id].Texture:SetTexCoord(.1, .9, .1, .9)
		
		AuraTrack.Auras[id].Cooldown = CreateFrame("Cooldown", nil, AuraTrack.Auras[id], "CooldownFrameTemplate")
		AuraTrack.Auras[id].Cooldown:SetAllPoints()
		AuraTrack.Auras[id].Cooldown:SetReverse(true)
		AuraTrack.Auras[id].Cooldown:SetHideCountdownNumbers(true)
		
		AuraTrack.Auras[id].Count = AuraTrack.Auras[id]:CreateFontString(nil, "OVERLAY")
		AuraTrack.Auras[id].Count:SetFont(AuraTrack.Font, 12, "THINOUTLINE")
		AuraTrack.Auras[id].Count:SetPoint("CENTER", 1, 0)
	end
	
	AuraTrack.Auras[id].Expiration = expiration
	AuraTrack.Auras[id].Duration = duration
	AuraTrack.Auras[id].Backdrop:SetColorTexture(r * 0.2, g * 0.2, b * 0.2)
	AuraTrack.Auras[id].Cooldown:SetCooldown(expiration - duration, duration)
	AuraTrack.Auras[id]:Show()
	
	if count and count > 1 then
		AuraTrack.Auras[id].Count:SetText(count)
	else
		AuraTrack.Auras[id].Count:SetText("")
	end
	
	if AuraTrack.SpellTextures then
		AuraTrack.Auras[id].Texture:SetTexture(texture)
	else
		AuraTrack.Auras[id].Texture:SetColorTexture(r, g, b)
	end
end

local UpdateBar = function(self, unit, spellID, texture, id, expiration, duration)
	local AuraTrack = self.AuraTrack
	local Orientation = self.Health:GetOrientation()
	local Size = Orientation == "HORIZONTAL" and AuraTrack:GetHeight() or AuraTrack:GetWidth()
	
	AuraTrack.MaxAuras = AuraTrack.MaxAuras or floor(Size / (AuraTrack.Thickness))
	
	if id > AuraTrack.MaxAuras then
		return
	end
	
	local r, g, b = unpack(Tracker[spellID])
	local Position = (id * AuraTrack.Thickness) - AuraTrack.Thickness
	local X = Orientation == "VERTICAL" and -Position or 0
	local Y = Orientation == "HORIZONTAL" and -Position or 0
	local SizeX = Orientation == "VERTICAL" and AuraTrack.Thickness or AuraTrack:GetWidth()
	local SizeY = Orientation == "VERTICAL" and AuraTrack:GetHeight() or AuraTrack.Thickness

	if not AuraTrack.Auras[id] then
		AuraTrack.Auras[id] = CreateFrame("StatusBar", nil, AuraTrack)
		
		AuraTrack.Auras[id]:SetSize(SizeX, SizeY)
		AuraTrack.Auras[id]:SetPoint("TOPRIGHT", X, Y)
		
		if Orientation == "VERTICAL" then
			AuraTrack.Auras[id]:SetOrientation("VERTICAL")
		end
		
		AuraTrack.Auras[id].Backdrop = AuraTrack.Auras[id]:CreateTexture(nil, "BACKGROUND")
		AuraTrack.Auras[id].Backdrop:SetAllPoints()
	end
	
	AuraTrack.Auras[id].Expiration = expiration
	AuraTrack.Auras[id].Duration = duration
	AuraTrack.Auras[id]:SetStatusBarTexture(AuraTrack.Texture)
	AuraTrack.Auras[id]:SetStatusBarColor(r, g, b)
	AuraTrack.Auras[id].Backdrop:SetColorTexture(r * 0.2, g * 0.2, b * 0.2)
	
	if expiration > 0 and duration > 0 then
		AuraTrack.Auras[id]:SetScript("OnUpdate", OnUpdate)
	else
		AuraTrack.Auras[id]:SetScript("OnUpdate", nil)
		AuraTrack.Auras[id]:SetMinMaxValues(0, 1)
		AuraTrack.Auras[id]:SetValue(1)
	end
	
	AuraTrack.Auras[id]:Show()
end

local Update = function(self, event, unit)
	if self.unit ~= unit then
		return
	end
	
	local ID = 0
	
	if self.AuraTrack:GetWidth() == 0 then
		return
	end
	
	self.AuraTrack.MaxAuras = self.AuraTrack.MaxAuras or 4
	self.AuraTrack.Spacing = self.AuraTrack.Spacing or 6
	self.AuraTrack.IconSize = (self.AuraTrack:GetWidth() / self.AuraTrack.MaxAuras) - (self.AuraTrack.Spacing) - (self.AuraTrack.Spacing / (self.AuraTrack.MaxAuras))
	
	for i = 1, 40 do
		local name, texture, count, debuffType, duration, expiration, caster, isStealable,
			nameplateShowSelf, spellID, canApply, isBossDebuff, casterIsPlayer, nameplateShowAll,
			timeMod, effect1, effect2, effect3 = UnitAura(unit, i, "HELPFUL")
		
		if (self.AuraTrack.Tracker[spellID]) and (caster == "player" or caster == "pet") then
			ID = ID + 1
			
			if self.AuraTrack.Icons then
				UpdateIcon(self, unit, spellID, texture, ID, expiration, duration, count)
			else
				UpdateBar(self, unit, spellID, texture, ID, expiration, duration, count)
			end
		end
	end
	
	for i = ID + 1, self.AuraTrack.MaxAuras do
		if self.AuraTrack.Auras[i] and self.AuraTrack.Auras[i]:IsShown() then
			self.AuraTrack.Auras[i]:Hide()
		end
	end
end

local Path = function(self, ...)
	return (self.AuraTrack.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, "ForceUpdate", element.__owner.unit)
end

local function Enable(self)
	local AuraTrack = self.AuraTrack
	
	if (AuraTrack) then
		AuraTrack.__owner = self
		AuraTrack.ForceUpdate = ForceUpdate
		
		AuraTrack.Tracker = AuraTrack.Tracker or Tracker
		AuraTrack.Thickness = AuraTrack.Thickness or 5
		AuraTrack.Texture = AuraTrack.Texture or [[Interface\\TargetingFrame\\UI-StatusBar]]
		AuraTrack.SpellTextures = AuraTrack.SpellTextures or AuraTrack.Icons == nil and true
		AuraTrack.Icons = AuraTrack.Icons or AuraTrack.Icons == nil and true
		AuraTrack.Auras = {}
			
		self:RegisterEvent("UNIT_AURA", Path)

		return true
	end
end

local function Disable(self)
	local AuraTrack = self.AuraTrack
	
	if (AuraTrack) then
		self:UnregisterEvent("UNIT_AURA", Path)
	end
end

oUF:AddElement("AuraTrack", Path, Enable, Disable)