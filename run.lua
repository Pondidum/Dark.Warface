local addon, ns = ...
local config = ns.config

local parseArgs = function(args)

	if type(args) == "table" then
		return unpack(args)
	else
		return args
	end

end



local spellBaseConfig = {
	container = "default",
	controllers = { 
		textmode = "CDANDACTIVE", 
		glowmode = "ACTIVE"
	},
	spec = "ALL",
}

setmetatable(config.spells, { __index = function(t, v) return {} end})

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

	local view = ns.views["BUTTON"].new("DarkWarface" .. #views, UIParent)
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

	local classSets = config.spells[classFile]

	for i, entry in ipairs(classSets) do
		
		setmetatable(entry, spellMeta)

		if entry.spec == "ALL" or entry.spec == specName then
			
			local model = ns.monitors[entry.type].new(parseArgs(entry.args))
			local view = getOrCreateView() --ns.button.new("DarkWarface" .. i, UIParent)

			ns.controller.factory(model, view, entry.controllers)

			containers[entry.container].add(view)
			table.insert(models, model)

		end

	end

end

local onPlayerLogin = function()
	
	ns.controller.defaultTextControllerIs("CDANDACTIVE")
	ns.controller.defaultGlowControllerIs("ACTIVE")


	for name, conf in pairs(config.displays) do

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
