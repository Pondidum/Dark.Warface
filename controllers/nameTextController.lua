local addon, ns = ...

ns.controller.add("nameText", function(monitor, display, extra)
			
	monitor:addListener("nameTextController", function(m)
		display.setName(m.name)
	end)

end)
