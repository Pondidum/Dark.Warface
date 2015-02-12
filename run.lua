local addon, ns = ...

local class = ns.lib.class
local events = ns.lib.events

local warface = class:extend({

	events = {
		"PLAYER_ENTERING_WORLD",
		"ACTIVE_TALENT_GROUP_CHANGED",
	},

	ctor = function(self)
		self:include(events)

		self.auras = ns.auras.viewModel.new()
		Dark.warface = ns

	end,

	PLAYER_ENTERING_WORLD = function(self)
		self:unregister("PLAYER_ENTERING_WORLD")

		self.auras.run()
	end,

	ACTIVE_TALENT_GROUP_CHANGED = function(self)
		self.auras.specChanged()
	end,
})

warface:new()
