local addon, ns = ...

local itemMonitor = {
	
	new = function(itemslot, auraName)

		local this = setmetatable({}, ns.targetMeta)
	
		this.update = function(self)

			
			-- local spellName = GetMacroSpell(macroName)
			local auraName, auraRank, auraTexture, auraCount, auraDispel, auraDuration, auraExpires = UnitAura("player", auraName)

			this.texture  = GetSpellTexture(auraName)

			if auraName then
				
				self.mode = "ACTIVE"

				local start = auraExpires - auraDuration

				self.start = start
				self.duration = auraDuration
				self.stacks = auraCount
				self.maxStacks = auraCount
					
			else
				
				self.mode = "INACTIVE"

				local start, duration, enable = GetInventoryItemCooldown("player", itemslot)

				self.start = start
				self.duration = duration
				self.stacks = 0
				self.maxStacks = 0

			end 

		end

		return this

	end,

}

ns.monitors["item"] = itemMonitor