local addon, ns = ...

local totemMonitor = {
	
	new = function(totemSlot)

		local this = ns.monitor:new()
	
		this.name = "TotemSlot" .. totemSlot
		this.texture = "Interface\\Icons\\Spell_Fire_TotemOfWrath"

		local update = function()

			local lastState = {start = this.start, duration = this.duration, mode = this.mode}
			local haveTotem, name, startTime, duration, icon = GetTotemInfo(totemSlot)

			if haveTotem then
				
				this.mode = "ACTIVE"

				this.start = start
				this.duration = duration
				this.texture = icon
					
			else
				this:reset()
			end 

			this:updated(lastState)

		end

		this:onEvent("PLAYER_TOTEM_UPDATE", update)

		return this

	end,

}

ns.monitors["totem"] = totemMonitor