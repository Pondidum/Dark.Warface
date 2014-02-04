local addon, ns = ...
local alerts = ns.alerts

alerts.controllerFactory.register("powerText", function(monitor, display, extra)

	display.hideCooldown()
	display.showText()

	monitor:addListener("powerTextController", function(m)

		if m.power == nil or m.power == 0 then
			display.setText("")
		else
			display.setText(m.power)
		end

	end)

end)
