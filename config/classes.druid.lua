local addon, ns = ...

local config = {
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
				{ type = "spell",	args = 5221 },		-- shred
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

	},

	["Guardian"] = {
		auras = {
			player = {
				132402,		-- savage defence,
				106922,		-- might of ursoc,
				61336,		-- survival instincts
				22812,		-- barkskin
				137593,		-- meta gem
			},
		},
	},
}

ns.config.classConfig.DRUID = config