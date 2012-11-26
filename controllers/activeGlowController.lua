local addon, ns = ...

ns.controller.addGlowController("ACTIVE", function(monitor, display, extra)
	
	monitor:addListener("activeGlowController", function(m)

		if m.mode == "ACTIVE" then
			display.showGlow()
		else
			display.hideGlow()
		end

	end)

end)
