local addon, ns = ...

ns.config = ns.config or {}

ns.config.alertDisplayBase = { 
	container = "default", 
	controllers = { "cdAndActiveText", "activeGlow" }, 
	spec = "ALL"
}

ns.config.alertDisplays  = {

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

}

ns.config.auraDisplays = {
	
	player = {
		anchors = {
			{"BOTTOMLEFT", "oUF_DarkUnitFramesPlayer", "TOPLEFT", 0, 50},
			{"BOTTOMRIGHT", "oUF_DarkUnitFramesPlayer", "TOPRIGHT", 0, 50}
		}
	},
	target = {
		anchors = {
			{"BOTTOMLEFT", "oUF_DarkUnitFramesTarget", "TOPLEFT", 0, 50},
			{"BOTTOMRIGHT", "oUF_DarkUnitFramesTarget", "TOPRIGHT", 0, 50}
		}
	
	},
	focus = {	
		anchors = {
			{"BOTTOMLEFT", "oUF_DarkUnitFramesFocus", "TOPLEFT", 0, 50},
			{"BOTTOMRIGHT", "oUF_DarkUnitFramesFocus", "TOPRIGHT", 0, 50}
		}
	},
	
}
