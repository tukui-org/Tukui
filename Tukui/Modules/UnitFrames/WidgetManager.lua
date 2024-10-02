local T, C, L = unpack((select(2, ...)))

local UnitFrames = T["UnitFrames"]

local WidgetManager = {}

--[[ Internal: Add a widget to the index. ]]
local function addToIndex(self, widget)
	self.count = self.count + 1
	self.index[self.count] = widget
end

--[[ Internal: Rebuild the index for insert or remove. ]]
local function rebuildIndex(self, widget, atIndex)
	local oldIndex = self.index

	self.index = {}
	self.count = 0

	for i, _widget in ipairs(oldIndex) do
		if i == atIndex then
			addToIndex(self, widget)
            addToIndex(self, _widget)
		elseif _widget == widget then
			-- deleted
		else
			addToIndex(self, _widget)
		end
	end
end

--[[ Add a new widget create function.

* self       - RaidWidgets object
* name       - Name of the new widget
* widget     - The new widget
* returns    - True
]]
WidgetManager.addOrReplace = function(self, name, widget)
    if self.widgets[name] then
        self.widgets[name] = widget
    else
        addToIndex(self, widget)
	    self.widgets[name] = widget
    end
    return true
end

--[[ Gets the number of registered widgets.

* self       - RaidWidgets object
* returns    - Number of registered widgets
]]
WidgetManager.getCount = function(self)
	return self.count
end

--[[ Returns the registered widget by its name or index.

* self           - RaidWidgets object
* nameOrIndex    - The name or index of the widget to retrieve
* returns        - The registered widget or nil
]]
WidgetManager.get = function(self, nameOrIndex)
	if type(nameOrIndex) == "string" then
		return self.widgets[nameOrIndex]
	elseif type(nameOrIndex) == "number" then
		return self.index[nameOrIndex]
	end
end

--[[ Insert a new widget at a specific position.

Other widgets will be shifted if needed.
* self       - RaidWidgets object
* atIndex    - The index where to insert it
* name       - Name of the new widget
* widget     - The new widget
* returns    - True if successful, false otherwise
]]
WidgetManager.insert = function(self, atIndex, name, widget)
    if not self.widgets[name] and atIndex <= self.count then
        self.widgets[name] = widget
        rebuildIndex(self, widget, atIndex)
        return true
    else
        return false
    end
end

--[[ Remove a registered widget.

* self       - RaidWidgets object
* name       - Name of the widget to be removed
* returns    - True if successful, false otherwise
]]
WidgetManager.remove = function(self, name)
	local widget = self:get(name)
	if widget then
		self.widgets[name] = nil
		rebuildIndex(self, widget)
        return true
    else
        return false
	end
end

--[[ Calls all registered widgets in order.

* self         - RaidWidgets object
* unitFrame    - The unitFrame these widgets belong to
]]
WidgetManager.createWidgets = function(self, unitFrame)
	for _, widget in ipairs(self.index) do
		widget(unitFrame)
	end
end

--[[ Create a new widget manager. ]]
WidgetManager.new = function()
    return {
        index = {},
        count = 0,
        widgets = {},
        addOrReplace = WidgetManager.addOrReplace,
        get = WidgetManager.get,
        insert = WidgetManager.insert,
        remove = WidgetManager.remove,
        getCount = WidgetManager.getCount,
        createWidgets = WidgetManager.createWidgets,
    }
end

UnitFrames.newWidgetManager = WidgetManager.new