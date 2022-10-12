local T, C, L = select(2, ...):unpack()

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

	if T.Retail then
		Miscellaneous["TalkingHead"]:Enable()
		Miscellaneous["LossControl"]:Enable()
		Miscellaneous["DeathRecap"]:Enable()
		Miscellaneous["Ghost"]:Enable()
		Miscellaneous["TimerTracker"]:Enable()
		Miscellaneous["AltPowerBar"]:Enable()
		Miscellaneous["OrderHall"]:Enable()
		Miscellaneous["Tutorials"]:Enable()
		Miscellaneous["VehicleIndicator"]:Enable()
		Miscellaneous["RaidUtilities"]:Enable()
	end
end
