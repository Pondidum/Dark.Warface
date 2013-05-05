local addon, ns = ...

local core = Dark.core
local events = core.events

local auras = ns.auras.viewModel.new()
local alerts = ns.alerts.viewModel.new()

local onPlayerLogin = function()
	
	auras.run()	
	alerts.run()

end

events.register("PLAYER_LOGIN", nil, onPlayerLogin)
Dark.warface = ns
