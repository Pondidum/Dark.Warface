local addon, ns = ...
local alerts = ns.alerts

local monitors = {}

local monitorFactory = {
	
	new = function()

		local this = {}
		local inUse = {}

		this.getNew = function(type, args)

			local monitorType = monitors[type]
			local instance = monitorType.new(args)

			table.insert(inUse, instance)

			return instance
			
		end

		this.recycleAll = function()

			for i, monitor in pairs(inUse) do
				monitor:clearListeners()
			end

			inUse = {}
		end

		return this

	end,

	register = function(type, action)
		monitors[type] = action
	end,

}

alerts.monitorFactory = monitorFactory