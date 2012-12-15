local addon, ns = ...


local parseArgs = function(args)

	if type(args) == "table" then
		return unpack(args)
	else
		return args
	end

end

local displayConfig = {
	
	default = {
		anchor = {"CENTER", DarkuiFrame, "CENTER", 0, -100},
		autosize = true, 
		marginLeft = 10, 
		marginRight = 10,
		defaultChildWidth = 27,
		defaultChildHeight = 27,
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

}

local spellConfig = {
	
	SHAMAN = {

		{ type = "item",	args = {10, 96228} },	--gloves, synapse springs
		{ type = "spell", 	args = 51533 },			--feral spirit
		{ type = "spell", 	args = 2894 },			--fire elemental
		{ type = "spell", 	args = 114049 },		--ascendance
		{ type = "spell", 	args = 57994 },			--wind shear

		{ type = "spell", 	args = 8042,			view = "rotation" },			--earthshock
		{ type = "spell", 	args = 60103,			view = "rotation" },			--lavalash
		{ type = "spell", 	args = 17364,			view = "rotation" },			--stormstrike
		{ type = "spell", 	args = 53817,			view = "rotation", controllers = { glowmode = "STACKS", stacks = 5, textmode = "STACKS"} },			--maelstrom
		{ type = "macro", 	args = "EnhUnleash",	view = "rotation" },			--unleash/flameshock macro
	},

	DRUID = {

		{ type = "spell",	args = 78674 }

	}

}


local init = function()
	
	ns.controller.defaultTextControllerIs("CDANDACTIVE")
	ns.controller.defaultGlowControllerIs("ACTIVE")

	local containers = {}

	for name, conf in pairs(displayConfig) do

		local container = CreateFrame("Frame", "DarkuiWarface" .. name, UIParent)
		container:SetPoint(unpack(conf.anchor))
		Dark.core.layout.init(container, conf)		

		containers[name] = container

	end


	

	local class, classFile = UnitClass("Player")
	local classSets = spellConfig[classFile]

	for i, entry in ipairs(classSets) do
		
		local model = ns.monitors[entry.type].new(parseArgs(entry.args))
		local view = ns.button.new("DarkWarface" .. model.name, UIParent)

		ns.controller.factory(model, view, entry.controllers or {})

		containers[entry.view or "default"].add(view)

	end
	
	Dark.warface = ns

end

Dark.core.events.register("PLAYER_LOGIN", nil, init)

