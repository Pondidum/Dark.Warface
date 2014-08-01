local addon, ns = ...

local config = {
	["Windwalker"] = {
		auras = {
			player = {
				125359,		-- tiger palm
				116740,		-- tiger eye brew
				115288,		-- energising brew
			},
			target = {
				115804,		-- mortal wounds
				128531,		-- blackout kick
			},
		},

	},
}

ns.config.classConfig.MONK = config