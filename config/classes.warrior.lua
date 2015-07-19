local addon, ns = ...

local config = {
	["Arms"] = {
		alerts = {
			cooldowns = {
				{ type = "spell", 	args = 18499 },			-- berserker rage
				{ type = "spell", 	args = 107574 },		-- avatar
				{ type = "spell", 	args = 1719 },			-- recklessness
			},
			rotation = {
				{ type = "spell", 	args = 12294 },			-- mortal strike
				{ type = "spell", 	args = 86346 },			-- colossus smash
			},
		},
		auras = {
			player = {
				12880,		-- enrage
			},
		},
	},
	["Fury"] = {
		auras = {
			player = {
				12880,		-- enrage
			},
		},
	}
}

ns.config.classConfig.WARRIOR = config