local addon, ns = ...

local config = {
	
	

	cooldowns = {
	
		base = { container = "default", controllers = { "cdAndActiveText", "activeGlow" }, spec = "ALL" },
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

				{ type = "spell", 	args = 8042,			container = "rotation"},			--earthshock
				{ type = "spell", 	args = 60103,			container = "rotation", spec = "Enhancement" },			--lavalash
				{ type = "spell", 	args = 17364,			container = "rotation", spec = "Enhancement" },			--stormstrike
				{ type = "macro", 	args = "EnhUnleash",	container = "rotation" },			--unleash/flameshock macro
				{ type = "spell", 	args = 53817,			container = "rotation", controllers = { "stacksGlow", "stacksText" }, extra = {stacks = 5}}, --maelstrom
			}
		},
	},

	auras = {

		units = { 
			target = { 
				filter = "PLAYER|HARMFUL",
				customise = function(this)
					this:SetPoint("BOTTOMLEFT", _G["oUF_DarkUnitFramesTarget"], "TOPLEFT", 0, 50)
					this:SetPoint("BOTTOMRIGHT", _G["oUF_DarkUnitFramesTarget"], "TOPRIGHT", 0, 50)
					this:SetHeight(50)
				end,
			},
			focus = { 
				filter = "PLAYER|HARMFUL",
				customise = function(this)
					this:SetPoint("BOTTOMLEFT", _G["oUF_DarkUnitFramesFocus"], "TOPLEFT", 0, 50)
					this:SetPoint("BOTTOMRIGHT", _G["oUF_DarkUnitFramesFocus"], "TOPRIGHT", 0, 50)
					this:SetHeight(50)
				end,
			}
		},
		filter = {
			115798,
		}

	}
}

ns.config = config