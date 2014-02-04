local addon, ns = ...
local alerts = ns.alerts

alerts.controllerFactory.register("powerGlow", function(monitor, display, extra)

	monitor:addListener("powerGlowController", function(m)

		if m.power >= extra.power then
			display.showGlow()
		else
			display.hideGlow()
		end

	end)

end)
