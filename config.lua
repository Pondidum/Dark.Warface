local addon, ns = ...

local config = {
	
	

	cooldowns = {
	
		base = { container = "default", controllers = { "cdAndActiveText", "activeGlow" }, spec = "ALL" },
		displays = {
		
			default = {
				autosize = true, 
				marginLeft = 3, 
				marginRight = 3,
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
				marginLeft = 5, 
				marginRight = 5,
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
			--[[
			PALADIN = {
				{ type = "spell", 	args = 20271 },			--judgement
				{ type = "spell", 	args = 35395 },			--crusader strike
				{ type = "spell", 	args = 85256 },			--templar's verdict
				{ type = "spell", 	args = 879 },			--exorcism
				{ type = "spell", 	args = 24275 },			--hammer of wrath
			},
			]]
			
			SHAMAN = {
				{ type = "spell", 	args = 2062 },			--earth elemental
				{ type = "spell", 	args = 120668 },		--stormlash
				{ type = "spell", 	args = 2894 },			--fire elemental
				{ type = "spell", 	args = 51533 },			--feral spirit
				{ type = "spell", 	args = 114049 },		--ascendance
				{ type = "item",	args = {10, 96228} },	--gloves, synapse springs
				{ type = "spell", 	args = 16166 },			--elemental mastery

				{ type = "spell", 	args = 8042,			container = "rotation"},			--earthshock
				{ type = "spell", 	args = 60103,			container = "rotation", spec = "Enhancement" },			--lavalash
				{ type = "spell", 	args = 17364,			container = "rotation", spec = "Enhancement" },			--stormstrike
				{ type = "macro", 	args = "EnhUnleash",	container = "rotation" },			--unleash/flameshock macro
				{ type = "spell", 	args = 53817,			container = "rotation", controllers = { "stacksGlow", "stacksText" }, extra = {stacks = 5}}, --maelstrom
			}
		},
	},

	auras = {

		target = { 
			filter = "PLAYER|HARMFUL",
			customise = function(this)
				this:SetPoint("BOTTOMLEFT", _G["oUF_DarkUnitFramesTarget"], "TOPLEFT", 0, 50)
				this:SetPoint("BOTTOMRIGHT", _G["oUF_DarkUnitFramesTarget"], "TOPRIGHT", 0, 50)
				this:SetHeight(50)
			end,
			blacklist = {
				115798,	--weakened blows
				17364	--stormstrike
			}
		},

		focus = { 
			filter = "PLAYER|HARMFUL",
			customise = function(this)
				this:SetPoint("BOTTOMLEFT", _G["oUF_DarkUnitFramesFocus"], "TOPLEFT", 0, 50)
				this:SetPoint("BOTTOMRIGHT", _G["oUF_DarkUnitFramesFocus"], "TOPRIGHT", 0, 50)
				this:SetHeight(50)
			end,
			blacklist = {
				115798,	--weakened blows
				17364	--stormstrike
			}
		},

		player = {
			filter = "PLAYER|HELPFUL",
			customise = function(this)
				this:SetPoint("BOTTOMLEFT", _G["oUF_DarkUnitFramesPlayer"], "TOPLEFT", 0, 50)
				this:SetPoint("BOTTOMRIGHT", _G["oUF_DarkUnitFramesPlayer"], "TOPRIGHT", 0, 50)
				this:SetHeight(50)
			end,
			mode = "WHITELIST",
			whitelist = {
				77535,				--blood shield
			},
		},

	}
}

ns.config = config