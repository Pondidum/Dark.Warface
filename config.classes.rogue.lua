local addon, ns = ...

local config = {
	["Subtlety"] = {
		auras = {
			player = {
				5171,		-- slice n dice
				73651,		-- recuperate
			},
			target = {
				2818,		-- deadly poison
				112961,		-- leeching poison
				93068,		-- master poisoner
			},
		},
	},
	}

ns.config.classConfig.ROGUE = config