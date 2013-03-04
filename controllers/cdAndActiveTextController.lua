local addon, ns = ...

ns.controller.addTextController("CDANDACTIVE", function(monitor, display, extra)
	
	display.showCooldown()
	display.hideText()
	
	monitor:addListener("cdAndActiveTextController", function(m)
		display.setCooldown(m.start, m.duration, 1, m.stacks, m.maxStacks)
	end)

end)
