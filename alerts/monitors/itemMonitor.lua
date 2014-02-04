local addon, ns = ...

local itemMonitor = {

	new = function(args)

		local itemslot, auraID = unpack(args)

		local this = ns.monitor:new()
		local name, rank, auraTexture = GetSpellInfo(auraID)

		this.name = name
		this.texture  = auraTexture

		local update = function()

			local auraName, auraRank, auraTexture, auraCount, auraDispel, auraDuration, auraExpires = UnitAura("player", name)

			if auraName then

				this.mode = "ACTIVE"

				local start = auraExpires - auraDuration

				this.start = start
				this.duration = auraDuration
				this.stacks = auraCount
				this.maxStacks = auraCount

			else

				this.mode = "INACTIVE"

				local start, duration, enable = GetInventoryItemCooldown("player", itemslot)

				this.start = start
				this.duration = duration
				this.stacks = 0
				this.maxStacks = 0

			end

			this:updated()

		end

		this:onEvent("ACTIONBAR_UPDATE_COOLDOWN", update)
		this:onEvent("SPELL_UPDATE_USABLE", update)

		return this

	end,

}

ns.alerts.monitorFactory.register("item", itemMonitor)