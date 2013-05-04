local addon, ns = ...
local alerts = ns.alerts

alerts.controllerFactory.register("activeGlow", function(monitor, display, extra)
	
	monitor:addListener("activeGlowController", function(m)

		if m.mode == "ACTIVE" then
			display.showGlow()
		else
			display.hideGlow()
		end

	end)

end)
