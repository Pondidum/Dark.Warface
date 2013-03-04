local addon, ns = ...

local config = {
	
	displays = {
		
		default = {
			autosize = true, 
			marginLeft = 10, 
			marginRight = 10,
			defaultChildWidth = 25,
			defaultChildHeight = 25,
			forceChildSize = true,
			childView = "icon",
			customise = function(parent, this)
				this:SetPoint("CENTER", DarkuiFrame, "CENTER", 0, -100)
			end,
		},

		rotation = {
			autosize = true, 
			marginLeft = 10, 
			marginRight = 10,
			defaultChildWidth = 32,
			defaultChildHeight = 32,
			forceChildSize = true,
			childView = "icon",
			customise = function(parent, this)
				this:SetPoint("CENTER", DarkuiFrame, "CENTER", 0, -140)
			end,
		},
		--[[
		target = {
			type = "STACK",
			origin = "BOTTOM",
			autosize = true,
			paddingLeft = 0,
			paddingRight = 0,
			customise = function(parent, this)
				this:SetPoint("BOTTOMLEFT", oUF_DarkUnitFramesTarget, "TOPLEFT", 0, 30)
				this:SetPoint("BOTTOMRIGHT", oUF_DarkUnitFramesTarget, "TOPRIGHT", 0, 30)
			end,
			childView = "BAR",
		},
		]]--
	},

	spellBase = {
		container = "default",
		controllers = { 
			"cdandactiveText", 
			"activeglow",
		},
		spec = "ALL",
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
			{ type = "spell", 	args = 53817,			container = "rotation", controllers = { "stacksglow", "stackstext" }, extra = {stacks = 5}},			--maelstrom
			
			--{ type = "spell", 	args = 8050,			container = "target" } --flameshock
		}

	}
}

ns.config = config