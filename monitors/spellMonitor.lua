local addon, ns = ...

local spellMonitor = {
	
	new = function(spellName)

		local this = {}
		setmetatable(this, ns.targetMeta)
		
		this.name = spellName
		this.texture = GetSpellTexture(spellName)

		local update = function()

			local current = {start = this.start, duration = this.duration, stacks = this.stacks, mode = this.mode}

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

			for key, state in pairs(current) do
				if current[key] ~= this[key] then
					this:updated()
					break
				end
			end

		end

		this:onEvent("ACTIONBAR_UPDATE_COOLDOWN", update)
		this:onEvent("SPELL_UPDATE_USABLE", update)

		return this

	end,

}


ns.monitors["spell"] = spellMonitor