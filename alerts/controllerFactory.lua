local addon, ns = ...

local alerts = ns.alerts
local controllers = {}

local controllerFactory = {
	
	new = function()

		local this = {}

		this.bind = function(model, view, config)

			model:addListener("texture", function(m) view.setIcon(m.texture) end)
			
			for i, name in ipairs(config) do
				

				local c = controllers[string.lower(name)]	
				print("Finding controller", name, c)

				if c then
					c(model, view)
				end

			end

		end

		return this
	end,

	register = function(name, action)

		print("Registering controller", name)
		controllers[string.lower(name)] = action

	end,
}

alerts.controllerFactory = controllerFactory