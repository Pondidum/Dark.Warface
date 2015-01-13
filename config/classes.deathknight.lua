local addon, ns = ...

local config = {
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
				96268,		-- death's advance
				114868,		-- glyph of swift death

			},
			pet = {
				--91342,		-- shadow infusion
				63560,		-- dark transformation
			}
		},
	},
	["Frost"] = {
		auras = {
			player = {
				105706,		-- Potion of Mogu Power
				48792,		-- ibf
			},
			target = {
				51714,		-- frost vulnerability
			},
		}
	},
}

ns.config.classConfig.DEATHKNIGHT = config