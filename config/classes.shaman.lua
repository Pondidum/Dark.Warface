local addon, ns = ...

local config = {
	["Enhancement"] = {
		alerts = {
			cooldowns = {
				{ type = "spell", 	args = 120668 },		--stormlash
				{ type = "spell", 	args = 2894 },			--fire elemental
				{ type = "spell", 	args = 51533 },			--feral spirit
				{ type = "spell", 	args = 114049 },		--ascendance
				{ type = "item",	args = {10, 96228} },	--gloves, synapse springs (agility)
				{ type = "spell", 	args = 16166 },			--elemental mastery
			},
			rotation = {
				{ type = "spell", 	args = 8042 },			--earthshock
				{ type = "spell", 	args = 60103 },			--lavalash
				{ type = "spell", 	args = 17364 },			--stormstrike
				{ type = "macro", 	args = "EnhUnleash", },	--unleash/flameshock macro
				{ type = "spell", 	args = 53817,		 controllers = { "stacksGlow", "stacksText" }, extra = {stacks = 5}}, --maelstrom
			},
		},
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
				{ type = "spell", 	args = 120668 },		--stormlash
				{ type = "spell", 	args = 2894 },			--fire elemental
				{ type = "spell", 	args = 114049 },		--ascendance
				{ type = "item",	args = {10, 96230} },	--gloves, synapse springs (agility)
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
