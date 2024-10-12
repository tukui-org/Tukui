local T, C, L = unpack((select(2, ...)))

local UnitFrames = T["UnitFrames"]
local WidgetManager = {}
local Widgets = {}


-- Creates a new Widget storing the parameters as key value pairs.
local function Widget(index, name, widget, config)
	return {
		index = index,
		name = name,
		func = widget,
		config = config
	}
end

-- Rebuild the index for insert or remove.
local function rebuildIndex(self, changedWidget)
	local manager = Widgets[self]

	if manager[changedWidget.index] then
		-- insert case: start at end, shift right
		for index = manager.Count, changedWidget.index, -1 do
			local newIndex = index + 1
			manager[newIndex] = manager[index]
			manager[newIndex].index = newIndex
		end
		manager[changedWidget.index] = changedWidget
		manager.Count = manager.Count + 1
	else
		-- remove case: start at index, shift left
		for index = changedWidget.index, manager.Count - 1 do
			local nextIndex = index + 1
			manager[index] = manager[nextIndex]
			manager[index].index = index
		end
		manager[manager.Count] = nil
		manager.Count = manager.Count - 1
	end
end


-- Returns the number of registered widgets.
function WidgetManager:getCount()
	return Widgets[self].Count
end

-- Add a new widget.
-- Returs the index it was added at or false if already existing.
function WidgetManager:add(name, func, config)
	-- name must not be a number, to not interfere with the index
	if type(name) == "string" and not Widgets[self][name] then
		local manager = Widgets[self]

		manager.Count = manager.Count + 1
		local count = manager.Count
		local widget = Widget(count, name, func, config)
		manager[count] = widget
		manager[name] = widget
		return widget.index
	end
	return false
end

-- Returns the registered widget or nil.
-- Supports name or index to retrieve the widget.
function WidgetManager:get(nameOrIndex)
	local widget = Widgets[self][nameOrIndex]
	return widget.index, widget.name, widget.func, widget.config
end

-- Update an already registered widget.
-- Returns the index and name of the updated widget or nil if not found.
function WidgetManager:update(nameOrIndex, func, config)
	local widget = Widgets[self][nameOrIndex]
	if widget then
		widget.func = func
		widget.config = config
		return widget.index, widget.name
	end
end

-- Remove a registered widget.
-- Returns the removed widget or nil if not found.
function WidgetManager:remove(nameOrIndex)
	local manager = Widgets[self]
	local widget = manager[nameOrIndex]
	if widget then
		manager[widget.index] = nil
		manager[widget.name] = nil

		rebuildIndex(self, widget)
		return widget.index, widget.name, widget.func, widget.config
	end
end

-- Insert a new widget at position "atIndex".
-- Returns the number of registered widgets or nil if failed.
function WidgetManager:insert(atIndex, name, func, config)
	local manager = Widgets[self]

	-- fails if a widget of that name already exists or the index is outside the current range
	if not manager[name] and atIndex <= manager.Count then
		local widget = Widget(atIndex, name, func, config)
		manager[name] = widget

		rebuildIndex(self, widget)
		return manager.Count
	end
end

-- Calls all registered widgets in order.
function WidgetManager:createWidgets(unitFrame)
	local manager = Widgets[self]

	if self.PreCreate then
		self.PreCreate(unitFrame)
	end

	for i = 1, manager.Count do
		local widget = manager[i]
		widget.func(unitFrame, widget.config)
	end

	if self.PostCreate then
		self.PostCreate(unitFrame)
	end
end

-- Create a new WidgetManager.
function WidgetManager:new()
	local manager = {
		-- PreCreate,
		-- PostCreate,
	}
	Widgets[manager] = {
		Count = 0,
	}
	return setmetatable(manager, { __index = WidgetManager })
end

UnitFrames.newWidgetManager = WidgetManager.new
