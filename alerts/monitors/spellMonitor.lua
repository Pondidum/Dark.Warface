local addon, ns = ...

local powerMap = {
	MONK = SPELL_POWER_CHI,
	PALADIN = SPELL_POWER_HOLY_POWER,
	PRIEST = SPELL_POWER_SHADOW_ORBS,
	WARLOCK = SPELL_POWER_SOUL_SHARDS,
}

local spellMonitor = {

	new = function(spellID)

		local this = ns.monitor:new()

		local localClass, class = UnitClass("player")
		local powerType = powerMap[class]

		local spellName, spellRank, spellTexture = GetSpellInfo(spellID)

		this.name = spellName
		this.texture = spellTexture

		local update = function()

			local auraName, auraRank, auraTexture, auraCount, auraDispel, auraDuration, auraExpires = UnitAura("player", spellName)
			local power = UnitPower("player", powerType)

			this.power = power

			if auraName then

				this.mode = "ACTIVE"

				local start = auraExpires - auraDuration

				this.start = start
				this.duration = auraDuration
				this.stacks = auraCount
				this.maxStacks = auraCount

			else

				local start, duration, enable, charges, maxCharges = GetSpellCooldown(spellName)
				local usable, notEnoughPower = IsUsableSpell(spellName)

				if start ~= nil or usable then
					this.mode = "INACTIVE"

					this.start = start
					this.duration = duration
					this.stacks = charges
					this.maxStacks = maxCharges

				else
					this:reset()
				end

			end

			this:updated()

		end

		this:onEvent("ACTIONBAR_UPDATE_COOLDOWN", update)
		this:onEvent("SPELL_UPDATE_USABLE", update)
		this:onEvent("UNIT_POWER", update)
		this:onEvent("UNIT_POWER_FREQUENT", update)
		this:onEvent("UNIT_DISPLAYPOWER", update)

		return this

	end,

}

ns.alerts.monitorFactory.register("spell", spellMonitor)
