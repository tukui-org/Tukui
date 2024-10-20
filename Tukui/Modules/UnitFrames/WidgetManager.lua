local T, C, L = unpack((select(2, ...)))

local UnitFrames = T["UnitFrames"]
local WidgetManager = {}
local Widgets = {}

local function toString(self)
	local manager = Widgets[self]

	return string.format("WidgetManager: %s, Elements: %i", manager._Name, manager._Count)
end

--[[ Instanciate a new WidgetManager.

## Parameter
	* Name              Stored for identification but not further used (string?)
	* AddDefaultWidgets Adds add all default widgets (function)

## Extension points
	._UpdateWidgetList: Called once before creating any widgets.
	                    Here you can add, insert, update and remove widgets/their config.

	._PreCreate:        Will be called for each unitFrame before creating any widgets.
	                    Here the unitFrame is available but none of the widgets yet.

	._PostCreate:       Will be called for each unitFrame after creating the widgets.
	                    Here the widgets are available and you can also edit properties that are not available in their config.
]]
UnitFrames.newWidgetManager = function(Name, AddDefaultWidgets)
	local manager = {}
	Widgets[manager] = {
		_Count = 0,
		_Name = Name or tostring(manager),
		_AddDefaultWidgets = AddDefaultWidgets,
		_Initialized = false,
	}
	return setmetatable(manager, { __index = WidgetManager, __tostring = toString })
end


-- Creates a new Widget storing the parameters as key value pairs.
local function Widget(index, name, createFunction, config)
	local function merge(t1, t2)
		if t2 then
			for k, v in pairs(t2) do
				t1[k] = v
			end
		end
		return t1
	end

	-- function gets replaced if provided
	-- config is merged with existing
	-- to replace config instead use: get("name").config = { k = v, }
	local function update(self, conf, func)
		self.func = func or self.func
		self.config = merge(self.config, conf)
		return self
	end

	return {
		index = index,
		name = name,
		func = createFunction,
		config = config or {},
		update = update,
	}
end

-- Rebuild the index for insert or remove.
local function rebuildIndex(self, changedWidget)
	local manager = Widgets[self]
	local changedIndex = changedWidget.index

	if changedIndex == manager._Count + 1 then
		-- add case
		manager[changedIndex] = changedWidget
		manager._Count = manager._Count + 1
	elseif manager[changedIndex] then
		-- insert case: start at end, shift right
		for index = manager._Count, changedIndex, -1 do
			local newIndex = index + 1
			manager[newIndex] = manager[index]
			manager[newIndex].index = newIndex
		end
		manager[changedIndex] = changedWidget
		manager._Count = manager._Count + 1
	else
		-- remove case: start at index, shift left
		for index = changedIndex, manager._Count - 1 do
			local nextIndex = index + 1
			manager[index] = manager[nextIndex]
			manager[index].index = index
		end
		manager[manager._Count] = nil
		manager._Count = manager._Count - 1
	end
end


--[[ Returns the number of registered widgets. ]]
function WidgetManager:getCount()
	return Widgets[self]._Count
end

--[[ Returns the name of the WidgetManager. ]]
function WidgetManager:getName()
	return Widgets[self]._Name
end

--[[ Add a new widget.

	Returs the added widget at or nil if already existing.
]]
function WidgetManager:add(name, func, config)
	local manager = Widgets[self]

	return self:insert(manager._Count + 1, name, func, config)
end

--[[ Returns the registered widget or nil. ]]
function WidgetManager:get(nameOrIndex)
	return Widgets[self][nameOrIndex]
end

--[[ Update an already registered widget.

	Returns the updated widget or nil if not found.
]]
function WidgetManager:replace(nameOrIndex, func, config)
	local widget = Widgets[self][nameOrIndex]
	if widget then
		return widget:update(config, func)
	end
end

--[[ Remove a registered widget.

	Returns the removed widget or nil if not found.
]]
function WidgetManager:remove(nameOrIndex)
	local manager = Widgets[self]
	local widget = manager[nameOrIndex]

	if widget then
		manager[widget.index] = nil
		manager[widget.name] = nil

		rebuildIndex(self, widget)
		return widget
	end
end

--[[ Insert a new widget at position "atIndex".

	Returns the inserted widget or nil if failed.
]]
function WidgetManager:insert(atIndex, name, func, config)
	local manager = Widgets[self]

	-- fails if name is not a string, a widget of that name already exists, or the index is outside the current range
	if type(name) == "string" and not manager[name] and 0 <= atIndex and atIndex <= manager._Count + 1 then
		local widget = Widget(atIndex, name, func, config)
		manager[name] = widget

		rebuildIndex(self, widget)
		return widget
	end
end

--[[ Calls all registered widgets in order. ]]
function WidgetManager:createWidgets(unitFrame)
	local manager = Widgets[self]

	-- Execute only once as changes are stored in the manager
	if not manager._Initialized then
		manager._AddDefaultWidgets(self)
		if self._UpdateWidgetList then
			self._UpdateWidgetList(self)
		end
		manager._Initialized = true
	end

	if self._PreCreate then
		self._PreCreate(unitFrame)
	end

	for i = 1, manager._Count do
		local widget = manager[i]
		widget.func(unitFrame, widget.config)
	end

	if self._PostCreate then
		self._PostCreate(unitFrame)
	end
end
