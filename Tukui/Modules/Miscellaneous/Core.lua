local T, C, L = unpack((select(2, ...)))

local Miscellaneous = T["Miscellaneous"]

function Miscellaneous:Enable()
	Miscellaneous["Experience"]:Enable()
	Miscellaneous["Errors"]:Enable()
	Miscellaneous["MirrorTimers"]:Enable()
	Miscellaneous["DropDown"]:Enable()
	Miscellaneous["GarbageCollection"]:Enable()
	Miscellaneous["GameMenu"]:Enable()
	Miscellaneous["StaticPopups"]:Enable()
	Miscellaneous["Durability"]:Enable()
	Miscellaneous["UIWidgets"]:Enable()
	Miscellaneous["AFK"]:Enable()
	Miscellaneous["MicroMenu"]:Enable()
	Miscellaneous["Keybinds"]:Enable()
	Miscellaneous["TimeManager"]:Enable()
	Miscellaneous["ThreatBar"]:Enable()
	Miscellaneous["ItemLevel"]:Enable()
	Miscellaneous["Alerts"]:Enable()
	
	if T.Retail or T.WotLK then
		Miscellaneous["VehicleIndicator"]:Enable()
	end

	if T.Retail then
		Miscellaneous["TalkingHead"]:Enable()
		Miscellaneous["LossControl"]:Enable()
		Miscellaneous["DeathRecap"]:Enable()
		Miscellaneous["Ghost"]:Enable()
		Miscellaneous["TimerTracker"]:Enable()
		Miscellaneous["AltPowerBar"]:Enable()
		Miscellaneous["OrderHall"]:Enable()
		Miscellaneous["Tutorials"]:Enable()
		Miscellaneous["RaidUtilities"]:Enable()
	end
end
