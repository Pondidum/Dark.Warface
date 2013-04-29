local addon, ns = ...
local alerts = ns.alerts

local monitors = {}

local monitorFactory = {
	
	new = function()

		local this = {}
		local inUse = {}

		this.get = function(type)

			return monitors[type]
			
		end

		this.recycleAll = function()

			for i, monitor in pairs(inUse) do
				inUse.clearListeners()
			end

			inUse = {}
		end

		return this

	end,

	register = function()

	end,

}

alerts.monitorFactory = monitorFactory