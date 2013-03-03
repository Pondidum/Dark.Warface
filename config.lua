local addon, ns = ...

local config = {
	
	displays = {
		
		default = {
			anchor = {"CENTER", DarkuiFrame, "CENTER", 0, -100},
			autosize = true, 
			marginLeft = 10, 
			marginRight = 10,
			defaultChildWidth = 25,
			defaultChildHeight = 25,
			forceChildSize = true,
		},

		rotation = {
			anchor = {"CENTER", DarkuiFrame, "CENTER", 0, -140},
			autosize = true, 
			marginLeft = 10, 
			marginRight = 10,
			defaultChildWidth = 32,
			defaultChildHeight = 32,
			forceChildSize = true,
		},

	},


	spells = {
	
		DRUID = {

			{ type = "spell",	args = 78674 }

		},

		SHAMAN = {

			{ type = "spell", 	args = 120668 },		--stormlash
			{ type = "spell", 	args = 2894 },			--fire elemental
			{ type = "spell", 	args = 51533 },			--feral spirit
			{ type = "spell", 	args = 114049 },		--ascendance
			{ type = "item",	args = {10, 96228} },	--gloves, synapse springs
			--{ type = "spell", 	args = 57994 },			--wind shear

			{ type = "spell", 	args = 8042,			container = "rotation"},			--earthshock
			{ type = "spell", 	args = 60103,			container = "rotation", spec = "Enhancement" },			--lavalash
			{ type = "spell", 	args = 17364,			container = "rotation", spec = "Enhancement" },			--stormstrike
			{ type = "macro", 	args = "EnhUnleash",	container = "rotation" },			--unleash/flameshock macro
			{ type = "spell", 	args = 53817,			container = "rotation", controllers = { glowmode = "STACKS", stacks = 5, textmode = "STACKS"} },			--maelstrom
			
		}

	}
}

ns.config = config