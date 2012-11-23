local addon, ns = ...

local spellMonitor = {
	
	new = function(spellID)

		local this = {}
		setmetatable(this, ns.targetMeta)
		
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
				
				this.mode = "INACTIVE"

				local start, duration, enable, charges, maxCharges = GetSpellCooldown(spellName)

				this.start = start
				this.duration = duration
				this.stacks = charges
				this.maxStacks = maxCharges

			end 

			this:updated(lastState)

		end

		this:onEvent("ACTIONBAR_UPDATE_COOLDOWN", update)
		this:onEvent("SPELL_UPDATE_USABLE", update)

		return this

	end,

}


ns.monitors["spell"] = spellMonitor