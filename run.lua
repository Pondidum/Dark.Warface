local addon, ns = ...

local core = Dark.core
local events = core.events.new()

local auras = ns.auras.viewModel.new()
local alerts = ns.alerts.viewModel.new()

local onPlayerLogin = function()
	
	auras.run()	
	alerts.run()

end

local onSpecChanged = function()
	
	auras.specChanged()
	alerts.specChanged()

end

events.register("PLAYER_ENTERING_WORLD", onPlayerLogin)
events.register("ACTIVE_TALENT_GROUP_CHANGED", onSpecChanged)

Dark.warface = ns
