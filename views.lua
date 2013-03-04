local addon, ns = ...
local core = Dark.core
local cache = core.cache

local views = {
	
	new = function()

		local this = {}
		local viewCaches = {}

		this.addView = function(type, createAction)
			viewCaches[type] = cache.new(function(i) return createAction("DarkWarface" .. i, UIParent) end)
		end

		this.get = function(type)
			return viewCaches[type].get()		
		end

		this.recycleAll = function()

			for k,v in pairs(viewCaches) do
				v.recycleAll()
			end

		end

		return this
		
	end,
	

}

ns.views = views.new()