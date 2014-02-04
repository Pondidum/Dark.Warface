local addon, ns = ...
local events = Dark.core.events

local monitor = {

	new = function(self)

		local this = {
			name = "",
			start = 0,
			duration = 0,
			stacks = 0,
			maxStacks = 0,
			power = 0,
			mode = "NONE",		--NONE, ACTIVE, INACTIVE
			texture = nil,
			listeners = {},
			events = events.new()
		}

		return setmetatable(this, { __index = self } )

	end,

	clearListeners = function(self)
		self.listeners = {}
	end,

	addListener = function(self, key, action)
		self.listeners[key] = action
	end,

	updated = function(self)

		for key, action in pairs(self.listeners) do
			action(self)
		end

	end,

	forceUpdate = function(self)

		for key, action in pairs(self.listeners) do
			action(self)
		end
	end,

	onEvent = function(self, event, action)
		self.events.register(event, action)
	end,

	reset = function(self)

		self.start = 0
		self.duration = 0
		self.stacks = 0
		self.maxStacks = 0
		self.mode = "NONE"

	end,

	report = function(self)

		print(string.format("%s (%s) Start: %d, Duration: %d, Stacks: %d, Texture: %s",
			self.name,
			self.mode,
			self.start,
			self.duration,
			self.stacks,
			self.texture
			))

	end,

}

ns.monitor = monitor
