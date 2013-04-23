local addon, ns = ...

local core = Dark.core
local layout = core.layout

local createContainer = function(unitName)

	local container = CreateFrame("Frame", "DarkWarfaceAura" .. unitName, UIParent)
	layout.init(container, {
		type = "STACK",
		origin = "BOTTOM",
		autosize = true,
	})

	local subViews = {}

	container.getView = function(id)

		if subViews[id] then
			return subViews[id]
		end

		local v = ns.auras.createBarView("DarkWarfaceAura" ..unitName .."Bar"..id, container)

		subViews[id] = v
		return v

	end

	container.resetViews = function()
		
		for name, view in pairs(subViews) do
			view.setCooldown(0, 0)
		end

	end

	return container

end

ns.auras.createUnitView = createContainer