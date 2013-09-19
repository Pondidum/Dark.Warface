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
					{ type = "spell", args = 48743 },  --pact
					{ type = "spell", args = 48982 },  --blood tap
					{ type = "spell", args = 55233 },  --vamp
					{ type = "spell", args = 48792 },  --ibf
					{ type = "spell", args = 48707 },  --ams
					{ type = "spell", args = 49222, controllers = { "stacksText", "activeGlow" }},  --bone shield
				},
				rotation = {
					{ type = "spell", args = 49028 }, 	-- drw
					{ type = "spell", args = 114866 },	-- soul reaper
					{ type = "spell", args = 43265 },	-- death and decay
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
					{ type = "spell", 	args = 130736, 	controllers = { "healthGlow", "cdAndActiveText" }, 	extra = { unit="target", percent=45}}, 	-- soul reaper (unholy)
					{ type = "spell", 	args = 114851,	controllers = { "stacksGlow", "stacksText" }, 		extra = {stacks = 5}}, --blood tap
					{ type = "spell", 	args = 81340, }, 		-- sudden doom
					{ type = "spell", 	args = 91342,	controllers = { "stacksGlow", "stacksText" }, 		extra = {stacks = 5}}, --shadow infusion
				},
				cooldowns = {
					{ type = "spell",	args = 47568 },			-- Empower Rune Weapon
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
		["Frost"] = {
			alerts = {
				rotation = {
					{ type = "spell", 	args = 130736, 	controllers = { "healthGlow", "cdAndActiveText" }, 	extra = { unit="target", percent=45}}, 	-- soul reaper (unholy)
					{ type = "spell", 	args = 114851,	controllers = { "stacksGlow", "stacksText" }, 		extra = {stacks = 5}}, --blood tap
					{ type = "spell", 	args = 51124,	},		-- killing machine
					{ type = "spell", 	args = 59052,	},		-- rime
				},
				cooldowns = {
					{ type = "spell",	args = 51271 },			-- pillar of frost
					{ type = "spell",	args = 77575 },			-- outbreak
					{ type = "item",	args = {10, 96229} },	-- gloves, synapse springs (strength)
				},
			},
			auras = {
				player = {
					53365,		-- unholy strength (rune of the fallen crusader)
					51271,		-- pillar of frost
					126657,		-- Darkmist Vortex trinket
					138702,		-- Shadow pan assult
					126582,		-- unwavering might (Lei Shen's Final Orders)
					138870,		-- Primordius' Talisman of Rage
					105706,		-- Potion of Mogu Power
					138759,		-- feather
					48792,		-- ibf
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
		},

		["Feral"] = {
			alerts = {
				rotation = {
					--{ type = "spell",	args = 127538 },	-- savage roar
					{ type = "spell",	args = 5221 },		-- shred
					{ type = "spell",	args = 33876 },		-- mangle
					{ type = "spell",	args = 1822 },		-- rake
					{ type = "spell",	args = 1079 },		-- rip
				},
				cooldowns = {
					{ type = "spell",	args = 135700 },	-- clearcasting
					{ type = "spell",	args = 5217 },		-- tigers fury
					{ type = "spell",	args = 26297 },		-- berserking (racial)
					{ type = "spell",	args = 106951 },	-- berserk
				},
			},
			auras = {
				player = {
					26297,		-- berserking
					69369, 		-- predatory swiftness
					127538,		-- savage roar
					108381,		-- dream of cenarius
					139120,		-- re-origination
				},
				target = {
					58180		-- infected wounds
				},
				focus = {
					58180		-- infected wounds
				},
			},

		}
	},

	MAGE = {
		["Fire"] = {
			auras = {
				player = {
					116257,		-- invoker's energy
					104509		-- windsong (crit)
				}
			}
		},	
	},

	MONK = {
		["Windwalker"] = {
			auras = {
				player = {
					125359,		--tiger palm
				},
			},

		},
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

		["Retribution"] = {
			auras = {
				player = {
					84963, 		-- Inquisition
				},
			},
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
				},
				target = {
					17364		-- stormstrike
				},
				focus = {
					17364		-- stormstrike
				}
			},
		}
	},

	WARLOCK = {
		["Destruction"] = {
			auras = {
				player = {
					117828,		-- backdraft
					104232,		-- rain of fire
				},
			},
		},
		["Affliction"] = {

		},
	},

	WARRIOR = {
		["Arms"] = {
			alerts = {
				cooldowns = {
					{ type = "spell", 	args = 18499 },			-- berserker rage
					{ type = "spell", 	args = 114207 },		-- Skull Banner
					{ type = "spell", 	args = 107574 },		-- avatar
					{ type = "spell", 	args = 1719 },			-- recklessness
				},
				rotation = {
					--{ type = "spell", 	args = 18499 },			-- berserker rage
					{ type = "spell", 	args = 7384 },			-- overpower
					{ type = "spell", 	args = 12294 },			-- mortal strike
					{ type = "spell", 	args = 86346 },			-- colossus smash
					--{ type = "spell", 	args = 1719 },			-- recklessness	
				},
			},
			auras = {
				player = {
					12880,		-- enrage
				},
			},
		}

	}

}
