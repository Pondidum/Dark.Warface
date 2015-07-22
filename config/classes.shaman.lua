local addon, ns = ...

local config = {
	["Enhancement"] = {
		auras = {
			player = {
				73683,		-- unleash flame
				114893,		-- stone bulwark
				30823,		-- shamanistic rage
				108281,		-- ancestral guidance
				108271,		-- astral shift
				156423,		-- draenic agility potion
				159675,		-- mark of warsong,
				118472		-- unleashed fury
			},
			target = {
				17364		-- stormstrike
			},
			focus = {
				17364		-- stormstrike
			}
		},
	},
	["Elemental"] = {
		alerts = {
			cooldowns = {
				{ type = "spell", 	args = 2894 },			--fire elemental
				{ type = "spell", 	args = 114049 },		--ascendance
			},
			rotation = {
				{ type = "spell", 	args = 117014},		-- elemental blast
				{ type = "spell",	args = 51505 },		-- lava burst
				{ type = "spell",	args = 8050 },		-- flameshock
				{ type = "spell",	args = 324 , controllers = { "stacksGlow", "stacksText" }, extra = {stacks = 5}},		-- earthshock
			},
		}
	},
}

ns.config.classConfig.SHAMAN = config
