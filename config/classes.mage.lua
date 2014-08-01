local addon, ns = ...

local config = {
	["Fire"] = {
		auras = {
			player = {
				116257,		-- invoker's energy
				104509		-- windsong (crit)
			}
		}
	},
}

ns.config.classConfig.MAGE = config