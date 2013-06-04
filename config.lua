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

ns.config.classConfig = {
	
	DEATHKNIGHT = {
		["Blood"] = {
			alerts = {
				cooldowns = {
					{ type = "spell", args = 48707 }
				}
			},
			auras = {
				player = {
					77535,	-- blood sheild
				}
			},
		},
		["Unholy"] = {
			alerts = {
				rotation = {
					{ type = "spell", 	args = 130736, 	controllers = { "healthGlow", "cdAndActiveText" }, 	extra = { unit="target", percent=35}}, 	-- soul reaper (unholy)
					{ type = "spell", 	args = 114851,	controllers = { "stacksGlow", "stacksText" }, 		extra = {stacks = 5}}, --blood tap
					{ type = "spell", 	args = 81340, }, 		-- sudden doom
					{ type = "spell", 	args = 91342,	controllers = { "stacksGlow", "stacksText" }, 		extra = {stacks = 5}}, --shadow infusion
				},
				cooldowns = {
					{ type = "spell",	args = 49016 },			-- unholy frenzy
					{ type = "spell",	args = 20572 },			-- blood fury (attack power)
					{ type = "item",	args = {10, 96229} },	-- gloves, synapse springs (strength)
					{ type = "spell",	args = 49206 },			-- summon gargoyle
				}
			},
			auras = {
				player = {
					53365,		-- unholy strength (rune of the fallen crusader)
					--81340,		-- sudden doom
					126657,		-- Darkmist Vortex trinket
					138702,		-- Shadow pan assult
					126582,		-- unwavering might (Lei Shen's Final Orders)
					138870,		-- Primordius' Talisman of Rage
					105706,		-- Potion of Mogu Power
					138759,		-- feather
					48792,		-- ibf

				},
				pet = {
					--91342,		-- shadow infusion
					63560,		-- dark transformation
				}
			},
		},
	},

	DRUID = {
		["Balance"] = {
			alerts = {
				rotation = {
					{ type = "spell",	args = 78674 },
				}
			},
			auras = {
				player = {
					26297,		-- berserking
					112071, 	-- celestial alignment
					102560,		-- incarnation: chosen of elune
					16886,		-- nature's grace
					48505,		-- starfall
					105702,		-- potion of the jade serpent
				},
			},
		}
	},

	PALADIN = {
		["Protection"] = {
			alerts = {
				cooldowns = {
					--{ type = "spell", args = 1111 },		-- argent defender
					--{ type = "spell", args = 2222 },		-- wings
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

	PRIEST = {

		["Shadow"] = {
			alerts = {
				rotation = {
					{ type = "spell", args = 120644 },		-- halo
					{ type = "spell", args = 8092 },		-- mind blast
					{ type = "spell", args = 34433 },		-- shadowfiend
				},
			},
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

				},
				target = {
					17364		-- stormstrike
				}
			},
		}
	},

}
