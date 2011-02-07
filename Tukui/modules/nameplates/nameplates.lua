local T, C, L = unpack(select(2, ...)) -- Import Functions/Constants/Variables, Config, Locales

--Base code by Dawn (dNameplates), Rewritten by Elv22
if not C["nameplate"].enable == true then return end

local TEXTURE = C["media"].normTex
local FONT = C["media"].font
local FONTSIZE = 10
local FONTFLAG = "THINOUTLINE"
local hpHeight = 12
local hpWidth = 110
local iconSize = 25		--Size of all Icons, RaidIcon/ClassIcon/Castbar Icon
local cbHeight = 5
local cbWidth = 110
local blankTex = C["media"].blank
local OVERLAY = [=[Interface\TargetingFrame\UI-TargetingFrame-Flash]=]
local numChildren = -1
local frames = {}
local noscalemult = T.mult * C["general"].uiscale

--Change defaults if we are showing health text or not
if C["nameplate"].showhealth ~= true then
	hpHeight = 7
	iconSize = 20
end

--Nameplates we do NOT want to see
local PlateBlacklist = {
	--Shaman Totems (Ones that don't matter)
	["Earth Elemental Totem"] = true,
	["Fire Elemental Totem"] = true,
	["Fire Resistance Totem"] = true,
	["Flametongue Totem"] = true,
	["Frost Resistance Totem"] = true,
	["Healing Stream Totem"] = true,
	["Magma Totem"] = true,
	["Mana Spring Totem"] = true,
	["Nature Resistance Totem"] = true,
	["Searing Totem"] = true,
	["Stoneclaw Totem"] = true,
	["Stoneskin Totem"] = true,
	["Strength of Earth Totem"] = true,
	["Windfury Totem"] = true,
	["Totem of Wrath"] = true,
	["Wrath of Air Totem"] = true,

	--Army of the Dead
	["Army of the Dead Ghoul"] = true,

	--Hunter Trap
	["Venomous Snake"] = true,
	["Viper"] = true,

	--Test
	--["Unbound Seer"] = true,
}

local NamePlates = CreateFrame("Frame", nil, UIParent)
NamePlates:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)

SetCVar("bloatthreat", 0)
SetCVar("bloattest", 0)
SetCVar("bloatnameplates", 0)

if C["nameplate"].overlap == true or T.eyefinity then
	SetCVar("spreadnameplates", "0")
else
	SetCVar("spreadnameplates", "1")
end

local function QueueObject(parent, object)
	parent.queue = parent.queue or {}
	parent.queue[object] = true
end

local function HideObjects(parent)
	for object in pairs(parent.queue) do
		if(object:GetObjectType() == 'Texture') then
			object:SetTexture(nil)
			object.SetTexture = T.dummy
		elseif (object:GetObjectType() == 'FontString') then
			object.ClearAllPoints = T.dummy
			object.SetFont = T.dummy
			object.SetPoint = T.dummy
			object:Hide()
			object.Show = T.dummy
			object.SetText = T.dummy
			object.SetShadowOffset = T.dummy
		else
			object:Hide()
			object.Show = T.dummy
		end
	end
end

--OnUpdate function for all nameplates, we use this to update threat, health, and anything else that may require rapid updates.
local goodR, goodG, goodB = unpack(C["nameplate"].goodcolor)
local badR, badG, badB = unpack(C["nameplate"].badcolor)
local transitionR, transitionG, transitionB = unpack(C["nameplate"].transitioncolor)
local function UpdateThreat(frame, elapsed)
	frame.hp:Show() --Blacklist needs this

	if C["nameplate"].enhancethreat ~= true then
		if(frame.region:IsShown()) then
			local _, val = frame.region:GetVertexColor()
			if(val > 0.7) then
				frame.healthborder_tex1:SetTexture(transitionR, transitionG, transitionB)
				frame.healthborder_tex2:SetTexture(transitionR, transitionG, transitionB)
				frame.healthborder_tex3:SetTexture(transitionR, transitionG, transitionB)
				frame.healthborder_tex4:SetTexture(transitionR, transitionG, transitionB)
			else
				frame.healthborder_tex1:SetTexture(1, 0, 0)
				frame.healthborder_tex2:SetTexture(1, 0, 0)
				frame.healthborder_tex3:SetTexture(1, 0, 0)
				frame.healthborder_tex4:SetTexture(1, 0, 0)
			end
		else
			frame.healthborder_tex1:SetTexture(unpack(C["media"].bordercolor))
			frame.healthborder_tex2:SetTexture(unpack(C["media"].bordercolor))
			frame.healthborder_tex3:SetTexture(unpack(C["media"].bordercolor))
			frame.healthborder_tex4:SetTexture(unpack(C["media"].bordercolor))
		end

		--Set colors to their original, fixes reloading UI with a nameplate shown, not being colored correctly
		frame.hp:SetStatusBarColor(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor)
		frame.hp.hpbg:SetTexture(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor, 0.25)
	else
		if not frame.region:IsShown() then
			if InCombatLockdown() and frame.hasclass ~= true and frame.isFriendly ~= true then
				--No Threat
				if T.Role == "Tank" then
					frame.hp:SetStatusBarColor(badR, badG, badB)
					frame.hp.hpbg:SetTexture(badR, badG, badB, 0.25)
				else
					frame.hp:SetStatusBarColor(goodR, goodG, goodB)
					frame.hp.hpbg:SetTexture(goodR, goodG, goodB, 0.25)
				end
			else
				--Set colors to their original, not in combat
				frame.hp:SetStatusBarColor(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor)
				frame.hp.hpbg:SetTexture(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor, 0.25)
			end
		else
			--Ok we either have threat or we're losing/gaining it
			local r, g, b = frame.region:GetVertexColor()
			if g + b == 0 then
				--Have Threat
				if T.Role == "Tank" then
					frame.hp:SetStatusBarColor(goodR, goodG, goodB)
					frame.hp.hpbg:SetTexture(goodR, goodG, goodB, 0.25)
				else
					frame.hp:SetStatusBarColor(badR, badG, badB)
					frame.hp.hpbg:SetTexture(badR, badG, badB, 0.25)
				end
			else
				--Losing/Gaining Threat
				frame.hp:SetStatusBarColor(transitionR, transitionG, transitionB)
				frame.hp.hpbg:SetTexture(transitionR, transitionG, transitionB, 0.25)
			end
		end
	end

	-- show current health value
	local minHealth, maxHealth = frame.healthOriginal:GetMinMaxValues()
	local valueHealth = frame.healthOriginal:GetValue()
	local d =(valueHealth/maxHealth)*100

	if C["nameplate"].showhealth == true then
		frame.hp.value:SetText(T.ShortValue(valueHealth).." - "..(string.format("%d%%", math.floor((valueHealth/maxHealth)*100))))
	end

	--Change frame style if the frame is our target or not
	if UnitName("target") == frame.name:GetText() and frame:GetAlpha() == 1 then
		--Targetted Unit
		frame.name:SetTextColor(1, 1, 0)
	else
		--Not Targetted
		frame.name:SetTextColor(1, 1, 1)
	end

	--Setup frame shadow to change depending on enemy players health, also setup targetted unit to have white shadow
	if frame.hasclass == true or frame.isFriendly == true then
		if(d <= 50 and d >= 20) then
			frame.healthborder_tex1:SetTexture(1, 1, 0)
			frame.healthborder_tex2:SetTexture(1, 1, 0)
			frame.healthborder_tex3:SetTexture(1, 1, 0)
			frame.healthborder_tex4:SetTexture(1, 1, 0)
		elseif(d < 20) then
			frame.healthborder_tex1:SetTexture(1, 0, 0)
			frame.healthborder_tex2:SetTexture(1, 0, 0)
			frame.healthborder_tex3:SetTexture(1, 0, 0)
			frame.healthborder_tex4:SetTexture(1, 0, 0)
		else
			frame.healthborder_tex1:SetTexture(unpack(C["media"].bordercolor))
			frame.healthborder_tex2:SetTexture(unpack(C["media"].bordercolor))
			frame.healthborder_tex3:SetTexture(unpack(C["media"].bordercolor))
			frame.healthborder_tex4:SetTexture(unpack(C["media"].bordercolor))
		end
	elseif (frame.hasclass ~= true and frame.isFriendly ~= true) and C["nameplate"].enhancethreat == true then
		frame.healthborder_tex1:SetTexture(unpack(C["media"].bordercolor))
		frame.healthborder_tex2:SetTexture(unpack(C["media"].bordercolor))
		frame.healthborder_tex3:SetTexture(unpack(C["media"].bordercolor))
		frame.healthborder_tex4:SetTexture(unpack(C["media"].bordercolor))
	end
end

--Color the castbar depending on if we can interrupt or not,
--also resize it as nameplates somehow manage to resize some frames when they reappear after being hidden
local function UpdateCastbar(frame)
	frame:ClearAllPoints()
	frame:SetSize(cbWidth, cbHeight)
	frame:SetPoint('TOP', frame:GetParent().hp, 'BOTTOM', 0, -8)
	frame:GetStatusBarTexture():SetHorizTile(true)

	if(not frame.shield:IsShown()) then
		frame:SetStatusBarColor(0.78, 0.25, 0.25, 1)
	end

	local frame = frame:GetParent()
	frame.castbarbackdrop_tex:ClearAllPoints()
	frame.castbarbackdrop_tex:SetPoint("TOPLEFT", frame.cb, "TOPLEFT", -noscalemult*3, noscalemult*3)
	frame.castbarbackdrop_tex:SetPoint("BOTTOMRIGHT", frame.cb, "BOTTOMRIGHT", noscalemult*3, -noscalemult*3)
end	

--Determine whether or not the cast is Channelled or a Regular cast so we can grab the proper Cast Name
local function UpdateCastText(frame, curValue)
	local minValue, maxValue = frame:GetMinMaxValues()

	if UnitChannelInfo("target") then
		frame.time:SetFormattedText("%.1f ", curValue)
		frame.name:SetText(select(1, (UnitChannelInfo("target"))))
	end

	if UnitCastingInfo("target") then
		frame.time:SetFormattedText("%.1f ", maxValue - curValue)
		frame.name:SetText(select(1, (UnitCastingInfo("target"))))
	end
end

--Sometimes castbar likes to randomly resize
local OnValueChanged = function(self, curValue)
	UpdateCastText(self, curValue)
	if self.needFix then
		UpdateCastbar(self)
		self.needFix = nil
	end
end

--Sometimes castbar likes to randomly resize
local OnSizeChanged = function(self)
	self.needFix = true
end

--We need to reset everything when a nameplate it hidden, this is so theres no left over data when a nameplate gets reshown for a differant mob.
local function OnHide(frame)
	frame.hp:SetStatusBarColor(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor)
	frame.overlay:Hide()
	frame.cb:Hide()
	frame.hasclass = nil
	frame.isFriendly = nil
	frame.hp.rcolor = nil
	frame.hp.gcolor = nil
	frame.hp.bcolor = nil
	frame:SetScript("OnUpdate",nil)
end

--Color the nameplate to 'Our' style instead of using blizzards ugly colors.
local function Colorize(frame)
	local r,g,b = frame.hp:GetStatusBarColor()
	if frame.hasclass == true then frame.isFriendly = false return end

	if g+b == 0 then -- hostile
		r,g,b = 222/255, 95/255,  95/255
		frame.isFriendly = false
	elseif r+b == 0 then -- friendly npc
		r,g,b = 0.31, 0.45, 0.63
		frame.isFriendly = true
	elseif r+g > 1.95 then -- neutral
		r,g,b = 218/255, 197/255, 92/255
		frame.isFriendly = false
	elseif r+g == 0 then -- friendly player
		r,g,b = 75/255,  175/255, 76/255
		frame.isFriendly = true
	else -- enemy player
		frame.isFriendly = false
	end
	frame.hp:SetStatusBarColor(r,g,b)
end

--HealthBar OnShow, use this to set variables for the nameplate, also size the healthbar here because it likes to lose it's
--size settings when it gets reshown
local function UpdateObjects(frame)
	local frame = frame:GetParent()

	local r, g, b = frame.hp:GetStatusBarColor()
	local r, g, b = floor(r*100+.5)/100, floor(g*100+.5)/100, floor(b*100+.5)/100
	local classname = ""

	--Have to reposition this here so it doesnt resize after being hidden
	frame.hp:ClearAllPoints()
	frame.hp:SetSize(hpWidth, hpHeight)
	frame.hp:SetPoint('TOP', frame, 'TOP', 0, -noscalemult*3)
	frame.hp:GetStatusBarTexture():SetHorizTile(true)

	-- Create Health Backdrop frame
	if not frame.hp.healthbarbackdrop_tex then
		frame.hp.healthbarbackdrop_tex = frame.hp:CreateTexture(nil, "BACKGROUND")
		frame.hp.healthbarbackdrop_tex:SetPoint("TOPLEFT", frame.hp, "TOPLEFT", -noscalemult*3, noscalemult*3)
		frame.hp.healthbarbackdrop_tex:SetPoint("TOPRIGHT", frame.hp, "TOPRIGHT", noscalemult*3, noscalemult*3)
		frame.hp.healthbarbackdrop_tex:SetHeight(hpHeight + noscalemult*6)
		frame.hp.healthbarbackdrop_tex:SetTexture(unpack(C["media"].backdropcolor))
	end

	--Determine if its an Enemy Player frame
	for class, color in pairs(RAID_CLASS_COLORS) do
		if RAID_CLASS_COLORS[class].r == r and RAID_CLASS_COLORS[class].g == g and RAID_CLASS_COLORS[class].b == b then
			classname = class
			break
		end
	end
	if (classname) then
		texcoord = CLASS_BUTTONS[classname]
		if texcoord then
			frame.hasclass = true
		else
			frame.hasclass = false
		end
	else
		frame.hasclass = false
	end

	if frame.hp.rcolor == 0 and frame.hp.gcolor == 0 and frame.hp.bcolor ~= 0 then
		frame.hasclass = true
	end

	--create variable for original colors
	Colorize(frame)
	frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor = frame.hp:GetStatusBarColor()
	frame.hp.hpbg:SetTexture(frame.hp.rcolor, frame.hp.gcolor, frame.hp.bcolor, 0.25)

	--Set the name text
	frame.name:SetText(frame.oldname:GetText())

	--Setup level text
	local level, elite, mylevel = tonumber(frame.oldlevel:GetText()), frame.elite:IsShown(), UnitLevel("player")
	frame.hp.level:ClearAllPoints()
	if C["nameplate"].showhealth == true then
		frame.hp.level:SetPoint("RIGHT", frame.hp, "RIGHT", 2, 0)
	else
		frame.hp.level:SetPoint("RIGHT", frame.hp, "LEFT", -1, 0)
	end

	frame.hp.level:SetTextColor(frame.oldlevel:GetTextColor())
	if frame.boss:IsShown() then
		frame.hp.level:SetText("B")
		frame.hp.level:SetTextColor(0.8, 0.05, 0)
		frame.hp.level:Show()
	elseif not elite and level == mylevel then
		frame.hp.level:Hide()
	else
		frame.hp.level:SetText(level..(elite and "+" or ""))
		frame.hp.level:Show()
	end

	frame.overlay:ClearAllPoints()
	frame.overlay:SetAllPoints(frame.hp)

	HideObjects(frame)
end

--This is where we create most 'Static' objects for the nameplate, it gets fired when a nameplate is first seen.
local function SkinObjects(frame)
	local hp, cb = frame:GetChildren()
	local threat, hpborder, cbshield, cbborder, cbicon, overlay, oldname, oldlevel, bossicon, raidicon, elite = frame:GetRegions()
	frame.healthOriginal = hp

	--Just make sure these are correct
	hp:SetFrameLevel(9)
	cb:SetFrameLevel(9)

	--Create our fake border.. fuck blizz
	local healthbarborder_tex1 = hp:CreateTexture(nil, "BORDER")
	healthbarborder_tex1:SetPoint("TOPLEFT", hp, "TOPLEFT", -noscalemult*2, noscalemult*2)
	healthbarborder_tex1:SetPoint("TOPRIGHT", hp, "TOPRIGHT", noscalemult*2, noscalemult*2)
	healthbarborder_tex1:SetHeight(noscalemult)
	healthbarborder_tex1:SetTexture(unpack(C["media"].bordercolor))
	frame.healthborder_tex1 = healthbarborder_tex1

	local healthbarborder_tex2 = hp:CreateTexture(nil, "BORDER")
	healthbarborder_tex2:SetPoint("BOTTOMLEFT", hp, "BOTTOMLEFT", -noscalemult*2, -noscalemult*2)
	healthbarborder_tex2:SetPoint("BOTTOMRIGHT", hp, "BOTTOMRIGHT", noscalemult*2, -noscalemult*2)
	healthbarborder_tex2:SetHeight(noscalemult)
	healthbarborder_tex2:SetTexture(unpack(C["media"].bordercolor))
	frame.healthborder_tex2 = healthbarborder_tex2

	local healthbarborder_tex3 = hp:CreateTexture(nil, "BORDER")
	healthbarborder_tex3:SetPoint("TOPLEFT", hp, "TOPLEFT", -noscalemult*2, noscalemult*2)
	healthbarborder_tex3:SetPoint("BOTTOMLEFT", hp, "BOTTOMLEFT", noscalemult*2, -noscalemult*2)
	healthbarborder_tex3:SetWidth(noscalemult)
	healthbarborder_tex3:SetTexture(unpack(C["media"].bordercolor))
	frame.healthborder_tex3 = healthbarborder_tex3

	local healthbarborder_tex4 = hp:CreateTexture(nil, "BORDER")
	healthbarborder_tex4:SetPoint("TOPRIGHT", hp, "TOPRIGHT", noscalemult*2, noscalemult*2)
	healthbarborder_tex4:SetPoint("BOTTOMRIGHT", hp, "BOTTOMRIGHT", -noscalemult*2, -noscalemult*2)
	healthbarborder_tex4:SetWidth(noscalemult)
	healthbarborder_tex4:SetTexture(unpack(C["media"].bordercolor))
	frame.healthborder_tex4 = healthbarborder_tex4

	hp:SetStatusBarTexture(TEXTURE)
	frame.hp = hp

	--Actual Background for the Healthbar
	hp.hpbg = hp:CreateTexture(nil, 'BORDER')
	hp.hpbg:SetAllPoints(hp)
	hp.hpbg:SetTexture(1,1,1,0.25)  

	--Reuse old Overlay Highlight
	frame.overlay = overlay
	frame.overlay:SetTexture(1,1,1,0.15)
	frame.overlay:SetAllPoints(hp)

	--Create Level
	hp.level = hp:CreateFontString(nil, "OVERLAY")
	hp.level:SetFont(FONT, FONTSIZE, FONTFLAG)
	hp.level:SetTextColor(1, 1, 1)
	hp.level:SetShadowOffset(T.mult, -T.mult)	

	--Needed for level text
	frame.oldlevel = oldlevel
	frame.boss = bossicon
	frame.elite = elite

	--Create Health Text
	if C["nameplate"].showhealth == true then
		hp.value = hp:CreateFontString(nil, "OVERLAY")
		hp.value:SetFont(FONT, FONTSIZE, FONTFLAG)
		hp.value:SetPoint("CENTER", hp)
		hp.value:SetTextColor(1,1,1)
		hp.value:SetShadowOffset(T.mult, -T.mult)
	end

	-- Create Cast Bar Backdrop frame
	local castbarbackdrop_tex = cb:CreateTexture(nil, "BACKGROUND")
	castbarbackdrop_tex:SetPoint("TOPLEFT", cb, "TOPLEFT", -noscalemult*3, noscalemult*3)
	castbarbackdrop_tex:SetPoint("BOTTOMRIGHT", cb, "BOTTOMRIGHT", noscalemult*3, -noscalemult*3)
	castbarbackdrop_tex:SetTexture(unpack(C["media"].backdropcolor))
	frame.castbarbackdrop_tex = castbarbackdrop_tex

	--Create our fake border.. fuck blizz
	local castbarborder_tex1 = cb:CreateTexture(nil, "BORDER")
	castbarborder_tex1:SetPoint("TOPLEFT", cb, "TOPLEFT", -noscalemult*2, noscalemult*2)
	castbarborder_tex1:SetPoint("TOPRIGHT", cb, "TOPRIGHT", noscalemult*2, noscalemult*2)
	castbarborder_tex1:SetHeight(noscalemult)
	castbarborder_tex1:SetTexture(unpack(C["media"].bordercolor))	

	local castbarborder_tex2 = cb:CreateTexture(nil, "BORDER")
	castbarborder_tex2:SetPoint("BOTTOMLEFT", cb, "BOTTOMLEFT", -noscalemult*2, -noscalemult*2)
	castbarborder_tex2:SetPoint("BOTTOMRIGHT", cb, "BOTTOMRIGHT", noscalemult*2, -noscalemult*2)
	castbarborder_tex2:SetHeight(noscalemult)
	castbarborder_tex2:SetTexture(unpack(C["media"].bordercolor))	

	local castbarborder_tex3 = cb:CreateTexture(nil, "BORDER")
	castbarborder_tex3:SetPoint("TOPLEFT", cb, "TOPLEFT", -noscalemult*2, noscalemult*2)
	castbarborder_tex3:SetPoint("BOTTOMLEFT", cb, "BOTTOMLEFT", noscalemult*2, -noscalemult*2)
	castbarborder_tex3:SetWidth(noscalemult)
	castbarborder_tex3:SetTexture(unpack(C["media"].bordercolor))	

	local castbarborder_tex4 = cb:CreateTexture(nil, "BORDER")
	castbarborder_tex4:SetPoint("TOPRIGHT", cb, "TOPRIGHT", noscalemult*2, noscalemult*2)
	castbarborder_tex4:SetPoint("BOTTOMRIGHT", cb, "BOTTOMRIGHT", -noscalemult*2, -noscalemult*2)
	castbarborder_tex4:SetWidth(noscalemult)
	castbarborder_tex4:SetTexture(unpack(C["media"].bordercolor))	

	--Setup CastBar Icon
	cbicon:ClearAllPoints()
	cbicon:SetPoint("TOPLEFT", hp, "TOPRIGHT", 8, 0)
	cbicon:SetSize(iconSize, iconSize)
	cbicon:SetTexCoord(.07, .93, .07, .93)
	cbicon:SetDrawLayer("OVERLAY")
	cb.icon = cbicon

	-- Create Cast Icon Backdrop frame
	local casticonbackdrop_tex = cb:CreateTexture(nil, "BACKGROUND")
	casticonbackdrop_tex:SetPoint("TOPLEFT", cbicon, "TOPLEFT", -noscalemult*3, noscalemult*3)
	casticonbackdrop_tex:SetPoint("BOTTOMRIGHT", cbicon, "BOTTOMRIGHT", noscalemult*3, -noscalemult*3)
	casticonbackdrop_tex:SetTexture(unpack(C["media"].backdropcolor))

	local casticonborder_tex = cb:CreateTexture(nil, "BORDER")
	casticonborder_tex:SetPoint("TOPLEFT", cbicon, "TOPLEFT", -noscalemult*2, noscalemult*2)
	casticonborder_tex:SetPoint("BOTTOMRIGHT", cbicon, "BOTTOMRIGHT", noscalemult*2, -noscalemult*2)
	casticonborder_tex:SetTexture(unpack(C["media"].bordercolor))	

	--Create Cast Backdrop Frame
	local casticonbackdrop2_tex = cb:CreateTexture(nil, "ARTWORK")
	casticonbackdrop2_tex:SetPoint("TOPLEFT", cbicon, "TOPLEFT", -noscalemult, noscalemult)
	casticonbackdrop2_tex:SetPoint("BOTTOMRIGHT", cbicon, "BOTTOMRIGHT", noscalemult, -noscalemult)
	casticonbackdrop2_tex:SetTexture(unpack(C["media"].backdropcolor))

	--Create Cast Time Text
	cb.time = cb:CreateFontString(nil, "ARTWORK")
	cb.time:SetPoint("RIGHT", cb, "LEFT", -1, 0)
	cb.time:SetFont(FONT, FONTSIZE, FONTFLAG)
	cb.time:SetTextColor(1, 1, 1)
	cb.time:SetShadowOffset(T.mult, -T.mult)

	--Create Cast Name Text
	cb.name = cb:CreateFontString(nil, "ARTWORK")
	cb.name:SetPoint("TOP", cb, "BOTTOM", 0, -3)
	cb.name:SetFont(FONT, FONTSIZE, FONTFLAG)
	cb.name:SetTextColor(1, 1, 1)
	cb.name:SetShadowOffset(T.mult, -T.mult)

	--We need the castbar shield to determine if it can be interrupted or not
	cb.shield = cbshield
	cb:HookScript('OnShow', UpdateCastbar)
	cb:HookScript('OnSizeChanged', OnSizeChanged)
	cb:HookScript('OnValueChanged', OnValueChanged)
	cb:SetStatusBarTexture(TEXTURE)
	frame.cb = cb

	--Create Name Text
	local name = hp:CreateFontString(nil, 'OVERLAY')
	name:SetPoint('BOTTOMLEFT', hp, 'TOPLEFT', -10, 3)
	name:SetPoint('BOTTOMRIGHT', hp, 'TOPRIGHT', 10, 3)
	name:SetFont(FONT, FONTSIZE, FONTFLAG)
	name:SetShadowOffset(T.mult, -T.mult)
	frame.oldname = oldname
	frame.name = name

	--Reposition and Resize RaidIcon
	raidicon:ClearAllPoints()
	raidicon:SetPoint("BOTTOM", hp, "TOP", 0, 16)
	raidicon:SetSize(iconSize*1.4, iconSize*1.4)
	raidicon:SetTexture([[Interface\AddOns\Tukui\medias\textures\raidicons.blp]])
	frame.raidicon = raidicon

	--Hide Old Stuff
	QueueObject(frame, oldlevel)
	QueueObject(frame, threat)
	QueueObject(frame, hpborder)
	QueueObject(frame, cbshield)
	QueueObject(frame, cbborder)
	QueueObject(frame, oldname)
	QueueObject(frame, bossicon)
	QueueObject(frame, elite)

	UpdateObjects(hp)
	UpdateCastbar(cb)

	frame.hp:HookScript('OnShow', UpdateObjects)
	frame:HookScript('OnHide', OnHide)
	frames[frame] = true
end

--Create our blacklist for nameplates, so prevent a certain nameplate from ever showing
local function CheckBlacklist(frame, ...)
	if PlateBlacklist[frame.name:GetText()] then
		frame:SetScript("OnUpdate", function() end)
		frame.hp:Hide()
		frame.cb:Hide()
		frame.overlay:Hide()
		frame.oldlevel:Hide()
	end
end

--When becoming intoxicated blizzard likes to re-show the old level text, this should fix that
local function HideDrunkenText(frame, ...)
	if frame and frame.oldlevel and frame.oldlevel:IsShown() then
		frame.oldlevel:Hide()
	end
end

--Run a function for all visible nameplates, we use this for the blacklist, to check unitguid, and to hide drunken text
local function ForEachPlate(functionToRun, ...)
	for frame in pairs(frames) do
		if frame:IsShown() then
			functionToRun(frame, ...)
		end
	end
end

--Check if the frames default overlay texture matches blizzards nameplates default overlay texture
local select = select
local function HookFrames(...)
	for index = 1, select('#', ...) do
		local frame = select(index, ...)
		local region = frame:GetRegions()

		if(not frames[frame] and not frame:GetName() and region and region:GetObjectType() == 'Texture' and region:GetTexture() == OVERLAY) then
			SkinObjects(frame)
			frame.region = region
		end
	end
end

--Core right here, scan for any possible nameplate frames that are Children of the WorldFrame
CreateFrame('Frame'):SetScript('OnUpdate', function(self, elapsed)
	if(WorldFrame:GetNumChildren() ~= numChildren) then
		numChildren = WorldFrame:GetNumChildren()
		HookFrames(WorldFrame:GetChildren())
	end

	if(self.elapsed and self.elapsed > 0.2) then
		for frame in pairs(frames) do
			UpdateThreat(frame, self.elapsed)
		end

		self.elapsed = 0
	else
		self.elapsed = (self.elapsed or 0) + elapsed
	end

	ForEachPlate(CheckBlacklist)
	ForEachPlate(HideDrunkenText)
end)

--Only show nameplates when in combat
if C["nameplate"].combat == true then
	NamePlates:RegisterEvent("PLAYER_REGEN_ENABLED")
	NamePlates:RegisterEvent("PLAYER_REGEN_DISABLED")
	NamePlates:RegisterEvent("PLAYER_ENTERING_WORLD")
	function NamePlates:PLAYER_REGEN_ENABLED()
		SetCVar("nameplateShowEnemies", 0)
	end

	function NamePlates:PLAYER_REGEN_DISABLED()
		SetCVar("nameplateShowEnemies", 1)
	end

	function NamePlates:PLAYER_ENTERING_WORLD()
		if InCombatLockdown() then
			SetCVar("nameplateShowEnemies", 1)
		else
			SetCVar("nameplateShowEnemies", 0)
		end
	end
end