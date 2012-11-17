local addon, ns = ...

local spellMonitor = {
	
	new = function(spellName)

		local this = {}
		setmetatable(this, ns.targetMeta)
		
		this.name = spellName
		this.texture = GetSpellTexture(spellName)

		this.update = function(self)

			local auraName, auraRank, auraTexture, auraCount, auraDispel, auraDuration, auraExpires = UnitAura("player", spellName)

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


ns.monitors["spell"] = spellMonitor