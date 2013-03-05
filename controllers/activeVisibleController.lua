local addon, ns = ...

ns.controller.add("activeVisible", function(monitor, display, extra)
	
	monitor:addListener("activeVisibleController", function(m)

		if m.mode == "ACTIVE" then
			display:Show()
		else
			display:Hide()
		end

	end)

end)
