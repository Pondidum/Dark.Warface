local addon, ns = ...

local totemMonitor = {
	
	new = function(totemSlot)

		local this = setmetatable({}, ns.targetMeta)
	
		this.update = function(self)

			local haveTotem, name, startTime, duration, icon = GetTotemInfo(totemSlot)


			if name then
				
				self.mode = "ACTIVE"

				self.start = start
				self.duration = duration
				this.texture = icon
					
			else
				self:reset()
			end 

		end

		return this

	end,

}

ns.monitors["totem"] = totemMonitor