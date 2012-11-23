local addon, ns = ...

local macroMonitor = {
	
	new = function(macroName)

		local this = setmetatable({}, ns.targetMeta)
	
		this.name = macroName

		local update = function()

			local current = {start = this.start, duration = this.duration, stacks = this.stacks, mode = this.mode}
			
			local spellName = GetMacroSpell(macroName)
			local auraName, auraRank, auraTexture, auraCount, auraDispel, auraDuration, auraExpires = UnitAura("player", spellName)

			this.texture  = GetSpellTexture(spellName)

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

			self:updated(current)

		end

		local macrosUpdated = function()

			local spellName = GetMacroSpell(macroName)
			this.texture  = GetSpellTexture(spellName)

		end

		this:onEvent("ACTIONBAR_UPDATE_COOLDOWN", update)
		this:onEvent("SPELL_UPDATE_USABLE", update)

		this:onEvent("UPDATE_MACROS", macrosUpdated)

		return this

	end,

}

ns.monitors["macro"] = macroMonitor