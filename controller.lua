local addon, ns = ...

local controller = {

	new = function()

		local defaultMeta = { __index = function(t, k) return t.default end }

		local textControllers = setmetatable({}, defaultMeta)
		local glowControllers = setmetatable({}, defaultMeta)

		local baseController = function(monitor, display, extra)

			monitor:addListener("baseController", function(m)
				display.icon:SetTexture(m.texture)
			end)

		end,

		local this = {}

		this.factory = function(monitor, display, extra)

			baseController(monitor, display, extra)

			textControllers[extra.textmode](monitor, display, extra)
			glowControllers[extra.glowmode](monitor, display, extra)

		end

		this.addTextController = function(name, action)	
			textControllers[name] = action
		end

		this.addGlowController = function(name, action)
			glowControllers[name] = action
		end	

		this.defaultTextControllerIs = function(name)
			textControllers.default = textControllers[name]
		end

		this.defaultGlowControllerIs = function(name)
			glowControllers.default = glowControllers[name]
		end

		return this

	end,

}

ns.controller = controller.new()