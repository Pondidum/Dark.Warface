local addon, ns = ...

ns.config = ns.config or {}

ns.config.specBase = {
	alerts = {
		cooldowns = {},
		rotation = {},
	},
	auras = {
		player = {
			mode = "WHITELIST",
			filter = "PLAYER|HELPFUL",
		},
		target = {
			mode = "BLACKLIST",
			filter = "PLAYER|HARMFUL",
			115798,	--weakened blows
		},
		focus = {
			mode = "BLACKLIST",
			filter = "PLAYER|HARMFUL",
			115798,	--weakened blows
		},
	},
}

ns.config.classConfig = {
	
	DRUID = {
		["Balance"] = {
			alerts = {
				rotation = {
					{ type = "spell",	args = 78674 },
				}
			}
		}
	},

	PALADIN = {
		["Protection"] = {
			alerts = {
				cooldowns = {
					{ type = "spell", args = 1111 },		-- argent defender
					{ type = "spell", args = 2222 },		-- wings
				},
				rotation = {
					{ type = "spell", args = 20271 },		-- judgement
					{ type = "spell", args = 53600 },		-- shield of the righteous
					{ type = "spell", args = 35395 },		-- crusader strike
					{ type = "spell", args = 31935 },		-- avengers shield
					--etc
				},
			},
			auras = {
				player = {
					20925,		-- sacred shield
					86659, 		-- guardian of ancient kings
					31850,		-- ardent defender
					498,		-- divine protection
					31884,		-- avenging wrath
				}
			}
		},
	},

	SHAMAN = {
		["Enhancement"] = {
			alerts = {
				cooldowns = {
					{ type = "spell", 	args = 2062 },			--earth elemental
					{ type = "spell", 	args = 120668 },		--stormlash
					{ type = "spell", 	args = 2894 },			--fire elemental
					{ type = "spell", 	args = 51533 },			--feral spirit
					{ type = "spell", 	args = 114049 },		--ascendance
					{ type = "item",	args = {10, 96228} },	--gloves, synapse springs
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
				},
				target = {
					17364		-- stormstrike
				}
			},
		}
	},

}
