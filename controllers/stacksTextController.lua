local addon, ns = ...

ns.controller.add("stacksText", function(monitor, display, extra)
			
	display.hideCooldown()
	display.showText()

	monitor:addListener("stacksTextController", function(m)

		if m.stacks == nil or m.stacks == 0 then
			display.setText("")
		else
			display.setText(m.stacks)
		end

	end)

end)
