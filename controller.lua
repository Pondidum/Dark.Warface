local addon, ns = ...

local controller = {
	
	factory = function(self, monitor, display, extra)

		self.baseController(monitor, display, extra)
		self.textControllers[extra.textmode](monitor, display, extra)
		self.glowControllers[extra.glowmode](monitor, display, extra)

	end,

	baseController = function(monitor, display, extra)

		monitor:addListener("baseController", function(m)
			display.icon:SetTexture(m.texture)
		end)

	end,

	textControllers = {},

	glowControllers = {},
	

}

ns.controller = controller