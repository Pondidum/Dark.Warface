local addon, ns = ...

local totemMonitor = {
	
	new = function(totemSlot)

		local this = setmetatable({}, ns.targetMeta)
	
		this.name = "TotemSlot" .. totemSlot
		this.texture = "Interface\\Icons\\Spell_Fire_TotemOfWrath"

		local update = function()

			local current = {start = this.start, duration = this.duration, mode = this.mode}
			local haveTotem, name, startTime, duration, icon = GetTotemInfo(totemSlot)

			if haveTotem then
				
				this.mode = "ACTIVE"

				this.start = start
				this.duration = duration
				this.texture = icon
					
			else
				this:reset()
			end 

			for key, state in pairs(current) do
				if current[key] ~= this[key] then
					this:updated()
					break
				end
			end

		end

		this:onEvent("PLAYER_TOTEM_UPDATE", update)

		return this

	end,

}

ns.monitors["totem"] = totemMonitor