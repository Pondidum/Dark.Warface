local addon, ns = ...

local auraMonitor = {
	
	new = function(spellID, unit)

		local this = ns.monitor:new()
		
		local spellName, spellRank, spellTexture = GetSpellInfo(spellID)

		this.name = spellName
		this.texture = spellTexture

		local update = function()

			local lastState = {start = this.start, duration = this.duration, stacks = this.stacks, mode = this.mode}

			local auraName, auraRank, auraTexture, auraCount, auraDispel, auraDuration, auraExpires = UnitAura(unit, spellName, nil, "PLAYER|HARMFUL")

			if auraName then
				
				this.mode = "ACTIVE"

				local start = auraExpires - auraDuration

				this.start = start
				this.duration = auraDuration
				this.stacks = auraCount
				this.maxStacks = auraCount
				
			else
				this:reset()
				this:forceUpdate()
			end

			this:updated(lastState)

		end

		this:onEvent("UNIT_AURA", update)
		this:onEvent("PLAYER_TARGET_CHANGED", update)
		this:onEvent("PLAYER_FOCUS_CHANGED", update)

		return this

	end,

}


ns.monitors["aura"] = auraMonitor