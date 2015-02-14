local addon, ns = ...

local class = ns.lib.class
local events = ns.lib.events

local warface = class:extend({

	events = {
		"PLAYER_ENTERING_WORLD",
	},

	ctor = function(self)
		self:include(events)

		Dark.warface = ns
	end,

	PLAYER_ENTERING_WORLD = function(self)
		self:unregister("PLAYER_ENTERING_WORLD")

		self.auras = ns.auras.viewModel:new()
	end,
})

warface:new()
