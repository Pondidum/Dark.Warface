local addon, ns = ...

ns.controller.add("stacksglow", function(monitor, display, extra)
	
	monitor:addListener("stacksGlowController", function(m)

		if m.mode == "ACTIVE" and m.stacks >= extra.stacks then
			display.showGlow()
		else
			display.hideGlow()
		end

	end)

end)
	