local addon, ns = ...
local alerts = ns.alerts

alerts.controllerFactory.register("activeVisible", function(monitor, display, extra)
	
	monitor:addListener("activeVisibleController", function(m)

		if m.mode == "ACTIVE" then
			display:Show()
		else
			display:Hide()
		end

	end)

end)
