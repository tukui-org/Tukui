local T, C, L = unpack((select(2, ...)))

local UnitFrames = T["UnitFrames"]

local WidgetManager = {}

-- Add a widget to the index.
function WidgetManager:addToIndex(widget)
	self.count = self.count + 1
	self.index[self.count] = widget
end

-- Rebuild the index for insert or remove.
function WidgetManager:rebuildIndex(widget, atIndex)
	local oldIndex = self.index

	self.index = {}
	self.count = 0

	for i, _widget in ipairs(oldIndex) do
		if i == atIndex then
			self.addToIndex(self, widget)
			self.addToIndex(self, _widget)
		elseif _widget == widget then
			-- deleted
		else
			self.addToIndex(self, _widget)
		end
	end
end

-- Add a new or replace an existing widget create function.
function WidgetManager:addOrReplace(name, widget)
	if self.widgets and self.widgets[name] then
		self.widgets[name] = widget
	else
		if self.addToIndex then
			self.addToIndex(self, widget)
		end
		
		if self.widgets then
			self.widgets[name] = widget
		end
	end
	
	return true
end

-- Returns the number of registered widgets.
function WidgetManager:getCount()
	return self.count
end

-- Returns the registered widget by its name or index.
function WidgetManager:get(nameOrIndex)
	if type(nameOrIndex) == "string" then
		return self.widgets[nameOrIndex]
	elseif type(nameOrIndex) == "number" then
		return self.index[nameOrIndex]
	end
end

-- Insert a new widget at position "atIndex".
-- Other widgets will be shifted if needed.
function WidgetManager:insert(atIndex, name, widget)
	if not self.widgets[name] and atIndex <= self.count then
		self.widgets[name] = widget
		self.rebuildIndex(self, widget, atIndex)
		return true
	else
		return false
	end
end

-- Remove a registered widget.
function WidgetManager:remove(name)
	local widget = self:get(name)
	if widget then
		self.widgets[name] = nil
		self.rebuildIndex(self, widget)
		return true
	else
		return false
	end
end

--Calls all registered widgets in order.
function WidgetManager:createWidgets(unitFrame)
	for _, widget in ipairs(self.index) do
		widget(unitFrame)
	end
end

-- Creates a new widget manager.
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
