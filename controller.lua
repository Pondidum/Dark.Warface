local addon, ns = ...

local controller = {

	new = function()

		local defaultMeta = { __index = function(t, k) return function() end end }

		local controllers = setmetatable({}, defaultMeta)
		local baseControllers = setmetatable({}, defaultMeta)

		baseControllers["default"] = function(model, view, extra)

			model:addListener("baseController", function(m)
				view.setIcon(m.texture)
			end)

		end

		local this = {}

		this.factory = function(monitor, display, viewControllers, extra)

			baseControllers["default"](monitor, display, extra)

			for i, name in ipairs(viewControllers) do
				controllers[string.lower(name)](monitor, display, extra)
			end

			monitor:forceUpdate()

		end

		this.add = function(name, action)	
			controllers[string.lower(name)] = action
		end

		return this

	end,

}

ns.controller = controller.new()