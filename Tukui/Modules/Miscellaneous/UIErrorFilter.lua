local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local Errors = CreateFrame("Frame")

-- unregister LUA_WARNING from other addons (ie. UIParent and possibly !BugGrabber)
local Frames = {GetFramesRegisteredForEvent("LUA_WARNING")}

function Errors:OnEvent(ev, warnType, warnMessage)
	if (warnMessage:match("^Couldn't open")) or (warnMessage:match("^Error loading")) or (warnMessage:match("^%(null%)")) or (warnMessage:match("^Deferred XML")) then
		return
	end

	geterrorhandler()(warnMessage, true)
end

function Errors:Enable()
	for _, Frame in ipairs(Frames) do
		self.UnregisterEvent(Frame, "LUA_WARNING")
	end

	self:RegisterEvent("LUA_WARNING")
end

Miscellaneous.UIErrorFilter = Errors
