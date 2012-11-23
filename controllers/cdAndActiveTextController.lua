local addon, ns = ...

--[[ns.controller.addText("CDANDACTIVE", function(monitor, display, extra)
	
	display.cooldown:Show()
	display.text:Hide()
	
	monitor:addListener("cdAndActiveTextController", function(m)
		CooldownFrame_SetTimer(display.cooldown, m.start, m.duration, 1, m.stacks, m.maxStacks)
	end)

end)]]