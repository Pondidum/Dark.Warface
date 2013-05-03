local addon, ns = ...

local alerts = ns.alerts
local controllers = {}

local controllerFactory = {
	
	new = function()

		local this = {}

		this.bind = function(model, view, config)

			for i, name in ipairs(config) do
				
				local c = controllers[string.lower(name)]	

				if c then
					c(model, view)
				end

			end

		end

		return this
	end,

	register = function(name, action)

		controllers[string.lower(name)] = action

	end,
}

alerts.controllerFactory = controllerFactory