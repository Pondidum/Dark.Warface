local addon, ns = ...

local config = {
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
		alerts = {
			cooldowns = {
				{ type = "spell", args = 114157 },		-- execution sentence
				{ type = "spell", args = 31884 },		-- avenging wrath
				{ type = "spell", args = 86698 },		-- guardian of ancient kings
			},
			rotation = {
				{ type = "spell", args = 20271 },		-- judgement
				{ type = "spell", args = 35395 },		-- crusader strike
				{ type = "spell", args = 85256, controllers = { "powerGlow", "powerText" }, extra = {power = 3}},		-- templar's verdict
				{ type = "spell", args = 122032 },		-- exorcism
				{ type = "spell", args = 24275 },		-- hammer of wrath
			},
		},
		auras = {
			player = {
				84963, 		-- Inquisition
			},
		},
	},
}

ns.config.classConfig.PALADIN = config