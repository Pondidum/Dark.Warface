local addon, ns = ...

local controller = {

	new = function()

		local defaultMeta = { __index = function(t, k) return t.default end }

		local textControllers = setmetatable({}, defaultMeta)
		local glowControllers = setmetatable({}, defaultMeta)
		local baseControllers = setmetatable({}, defaultMeta)

		baseControllers["default"] = function(model, view, extra)

			model:addListener("baseController", function(m)
				view.setIcon(m.texture)
			end)

		end


		local this = {}

		this.factory = function(monitor, display, extra)

			baseControllers["default"](monitor, display, extra)

			textControllers[extra.textmode](monitor, display, extra)
			glowControllers[extra.glowmode](monitor, display, extra)

			monitor:forceUpdate()

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