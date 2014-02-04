local addon, ns = ...

local core = Dark.core
local layout = core.layout

local containerView = {

	new = function(unitName, config)

		local container = CreateFrame("Frame", "DarkWarfaceAlert" .. unitName, UIParent)

		layout.init(container, config)

		return container

	end

}

ns.alerts.containerView = containerView