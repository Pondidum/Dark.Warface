local addon, ns = ...

local config = {
	["Shadow"] = {
		alerts = {
			rotation = {
				{ type = "spell", args = 120644 },		-- halo
				{ type = "spell", args = 8092 },		-- mind blast
				{ type = "spell", args = 34433 },		-- shadowfiend
			},
		},
	},
}

ns.config.classConfig.PRIEST = config