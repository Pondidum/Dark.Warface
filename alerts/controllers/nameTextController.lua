local addon, ns = ...
local alerts = ns.alerts

alerts.controllerFactory.register("nameText", function(monitor, display, extra)
			
	monitor:addListener("nameTextController", function(m)
		display.setName(m.name)
	end)

end)
