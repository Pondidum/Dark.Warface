local addon, ns = ...

ns.config = ns.config or {}

ns.config.specBase = {
	alerts = {
		cooldowns = {
			controllers = { "cdAndActiveText", "activeGlow" }
		},
		rotation = {
			controllers = { "cdAndActiveText", "activeGlow" }
		},
	},
	auras = {
		player = {
			mode = "WHITELIST",
			filter = "PLAYER|HELPFUL",
		},
		pet = {
			mode = "WHITELIST",
			filter = "PLAYER|HELPFUL",
		},
		target = {
			mode = "BLACKLIST",
			filter = "PLAYER|HARMFUL",
			115798,						-- weakened blows
			81326, 						-- physical vulnerability
		},
		focus = {
			mode = "BLACKLIST",
			filter = "PLAYER|HARMFUL",
			115798,						-- weakened blows
			81326, 						-- physical vulnerability
		},
	},
}

ns.config.classConfig = {}
