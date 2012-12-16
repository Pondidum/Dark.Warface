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

local spellBaseConfig = {
	view = "default",
	controllers = { 
		textmode = "CDANDACTIVE", 
		glowmode = "ACTIVE"
	},
	spec = "ALL",
}

local spellConfig = {
	
	SHAMAN = {

		{ type = "item",	args = {10, 96228} },	--gloves, synapse springs
		{ type = "spell", 	args = 51533 },			--feral spirit
		{ type = "spell", 	args = 2894 },			--fire elemental
		{ type = "spell", 	args = 114049 },		--ascendance
		{ type = "spell", 	args = 57994 },			--wind shear

		{ type = "spell", 	args = 8042,			view = "rotation"},			--earthshock
		{ type = "spell", 	args = 60103,			view = "rotation", spec = "Enhancement" },			--lavalash
		{ type = "spell", 	args = 17364,			view = "rotation", spec = "Enhancement" },			--stormstrike
		{ type = "spell", 	args = 53817,			view = "rotation", controllers = { glowmode = "STACKS", stacks = 5, textmode = "STACKS"} },			--maelstrom
		{ type = "macro", 	args = "EnhUnleash",	view = "rotation" },			--unleash/flameshock macro
	},

	DRUID = {

		{ type = "spell",	args = 78674 }

	}

}


local containers = {}
local views = {}
local models = {}
local spellMeta = { __index = spellBaseConfig }

local getOrCreateView = function()
	
	for i, view in ipairs(views) do
		
		if not view.inUse then
			view.inUse = true
			view:Show()
			return view
		end

	end

	local view = ns.button.new("DarkWarface" .. #views, UIParent)
	view.inUse = true

	table.insert(views, view)

	return view

end

local resetViews = function()
	
	for i,view in ipairs(views) do
		view.inUse = false
	end

	for n, container in pairs(containers) do
		container.clear()
	end

end

local resetModels = function()
	
	for i, model in pairs(models) do
		model.clearListeners()
	end

	models = {}
end

local onSpecChanged = function()
	
	resetViews()
	resetModels()

	local class, classFile = UnitClass("Player")
	local specID, specName = GetSpecializationInfo(GetSpecialization())

	local classSets = spellConfig[classFile]

	for i, entry in ipairs(classSets) do
		
		setmetatable(entry, spellMeta)

		if entry.spec == "ALL" or entry.spec == specName then
			
			local model = ns.monitors[entry.type].new(parseArgs(entry.args))
			local view = getOrCreateView() --ns.button.new("DarkWarface" .. i, UIParent)

			ns.controller.factory(model, view, entry.controllers)

			containers[entry.view].add(view)
			table.insert(models, model)

		end

	end

end

local onPlayerLogin = function()
	
	ns.controller.defaultTextControllerIs("CDANDACTIVE")
	ns.controller.defaultGlowControllerIs("ACTIVE")


	for name, conf in pairs(displayConfig) do

		local container = CreateFrame("Frame", "DarkuiWarface" .. name, UIParent)
		container:SetPoint(unpack(conf.anchor))
		Dark.core.layout.init(container, conf)		

		containers[name] = container

	end

	onSpecChanged()
	Dark.core.events.register("ACTIVE_TALENT_GROUP_CHANGED", nil, onSpecChanged)

end

Dark.core.events.register("PLAYER_LOGIN", nil, onPlayerLogin)

Dark.warface = ns
