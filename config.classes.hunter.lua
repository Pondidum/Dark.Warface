local addon, ns = ...

local config = {
	["Survival"] = {
		alerts = {
			cooldowns = {
				{ type = "spell", 	args = 131894 },		-- a murder of crows
				{ type = "spell", 	args = 120679 },		-- dire beast
				{ type = "spell", 	args = 121818 },		-- stampede
				{ type = "spell", 	args = 3045 },			-- rapid fire
			},
			rotation = {
				{ type = "spell", 	args = 117050 },	-- galive toss
				{ type = "spell",	args = 53301 },		-- explosive shot
				{ type = "spell",	args = 3674 },		-- black arrow
			},
		}
	},
}

ns.config.classConfig.HUNTER = config
