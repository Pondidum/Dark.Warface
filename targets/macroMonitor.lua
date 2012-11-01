local addon, ns = ...

local macroMonitor = {
	
	new = function(macroName)

		local this = setmetatable({}, ns.targetMeta)
	
		this.update = function(self)

			local spellName = GetMacroSpell(macroName)
			local auraName, auraRank, auraTexture, auraCount, auraDispel, auraDuration, auraExpires = UnitAura("player", spellName)

			this.texture  = GetSpellTexture(spellName)

			if auraName then
				
				self.mode = "ACTIVE"

				local start = auraExpires - auraDuration

				self.start = start
				self.duration = auraDuration
				self.stacks = auraCount
				self.maxStacks = auraCount
					
			else
				
				self.mode = "INACTIVE"

				local start, duration, enable, charges, maxCharges = GetSpellCooldown(spellName)

				self.start = start
				self.duration = duration
				self.stacks = charges
				self.maxStacks = maxCharges

			end 

		end

		return this

	end,

}

ns.monitors["macro"] = macroMonitor