local addon, ns = ...

local spellMonitor = {
	
	new = function(spellID)

		local this = ns.monitor:new()
		
		local spellName, spellRank, spellTexture = GetSpellInfo(spellID)

		this.name = spellName
		this.texture = spellTexture

		local update = function()

			local lastState = {start = this.start, duration = this.duration, stacks = this.stacks, mode = this.mode}

			local auraName, auraRank, auraTexture, auraCount, auraDispel, auraDuration, auraExpires = UnitAura("player", spellName)

			if auraName then
				
				this.mode = "ACTIVE"

				local start = auraExpires - auraDuration

				this.start = start
				this.duration = auraDuration
				this.stacks = auraCount
				this.maxStacks = auraCount
					
			else
				
				local start, duration, enable, charges, maxCharges = GetSpellCooldown(spellName)

				if start ~= nil then

					this.mode = "INACTIVE"

					this.start = start
					this.duration = duration
					this.stacks = charges
					this.maxStacks = maxCharges

				else
					this:reset()
				end

			end 

			this:updated(lastState)

		end

		this:onEvent("ACTIONBAR_UPDATE_COOLDOWN", update)
		this:onEvent("SPELL_UPDATE_USABLE", update)

		return this

	end,

}

ns.alerts.monitorFactory.register("spell", spellMonitor)
