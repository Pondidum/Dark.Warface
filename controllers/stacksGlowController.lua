local addon, ns = ...

ns.controller.add("stacksGlow", function(monitor, display, extra)
	
	monitor:addListener("stacksGlowController", function(m)

		if m.mode == "ACTIVE" and m.stacks >= extra.stacks then
			display.showGlow()
		else
			display.hideGlow()
		end

	end)

end)
	