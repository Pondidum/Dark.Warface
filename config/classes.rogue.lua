local addon, ns = ...

local config = {
	["Subtlety"] = {
		auras = {
			player = {
				5171,		-- slice n dice
				73651,		-- recuperate
				137573,		-- burst of speed
				2983,		-- sprint
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