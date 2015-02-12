local addon, ns = ...

local core = Dark.core
local events = core.events.new()

local auras = ns.auras.viewModel.new()

local initialised = false
local onPlayerLogin = function()

	if initialised then
		return
	end

	auras.run()

	initialised = true

end

local onSpecChanged = function()

	auras.specChanged()

end

events.register("PLAYER_ENTERING_WORLD", onPlayerLogin)
events.register("ACTIVE_TALENT_GROUP_CHANGED", onSpecChanged)

Dark.warface = ns
