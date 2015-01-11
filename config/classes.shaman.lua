local addon, ns = ...

local config = {
	["Enhancement"] = {
		auras = {
			player = {
				73683,		-- unleash flame
				138756,		-- blades of rentaki
				120032,		-- dancing steel
				146308,		-- assurance of consequence
				148903,		-- haromm's talisman
				114893,		-- stone bulwark
				30823,		-- shamanistic rage
				108281,		-- ancestral guidance
				108271,		-- astral shift
				105697,		-- virmen's bite
				159675,		-- mark of warsong,
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
		},
		auras = {
			player = {
				105702
			},
			target = {},
			focus = {}
		}
	},
}

ns.config.classConfig.SHAMAN = config
