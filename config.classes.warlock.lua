local addon, ns = ...

local config = {
	["Destruction"] = {
		auras = {
			player = {
				117828,		-- backdraft
				104232,		-- rain of fire
				114635, 	-- embertap hot
				113858,		-- darksoul: instability
			},
		},
	},
	["Affliction"] = {
		auras = {
			player = {
				113860,		-- darksoul: misery
				6229,		-- twilight ward
			},
			target = {
				103103,		-- malefic grasp
				1120,		-- drain soul
			},
			focus = {
				103103,		-- malefic grasp
				1120,		-- drain soul
			},
		},
	},
}

ns.config.classConfig.WARLOCK = config