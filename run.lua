local addon, ns = ...
local config = ns.config

local core = Dark.core
local layout = core.layout
local events = core.events

-- local parseArgs = function(args)

-- 	if type(args) == "table" then
-- 		return unpack(args)
-- 	else
-- 		return args
-- 	end

-- end

-- local containers = {}
-- local models = {}

-- local resetViews = function()
	
-- 	ns.views.recycleAll()

-- 	for n, container in pairs(containers) do
-- 		container.clear()
-- 	end

-- end

-- local resetModels = function()
	
-- 	for i, model in pairs(models) do
-- 		model.clearListeners()
-- 	end

-- 	models = {}
-- end

-- local onSpecChanged = function()
	
-- 	resetViews()
-- 	resetModels()

-- 	local class, classFile = UnitClass("Player")
-- 	local specID, specName = GetSpecializationInfo(GetSpecialization())

-- 	local classSets = config.cooldowns.spells[classFile]
-- 	local spellMeta = { __index = config.cooldowns.base }

-- 	for i, entry in ipairs(classSets) do
		
-- 		setmetatable(entry, spellMeta)

-- 		if entry.spec == "ALL" or entry.spec == specName then
			
-- 			local container = containers[entry.container]

-- 			local model = ns.monitors[entry.type].new(parseArgs(entry.args))
-- 			local view = container.getChildView()

-- 			ns.controller.factory(model, view, entry.controllers, entry.extra)

-- 			container.add(view)

-- 			table.insert(models, model)

-- 		end

-- 	end

-- end

-- local onPlayerLogin = function()
	
-- 	for name, conf in pairs(config.cooldowns.displays) do

-- 		local container = CreateFrame("Frame", "DarkuiWarface" .. name, UIParent)
-- 		conf.customise(UIParent, container)
-- 		layout.init(container, conf)		

-- 		container.getChildView = function()
-- 			return ns.views.get(conf.childView)
-- 		end

-- 		containers[name] = container

-- 	end

-- 	onSpecChanged()
-- 	events.register("ACTIVE_TALENT_GROUP_CHANGED", nil, onSpecChanged)

-- end

-- events.register("PLAYER_LOGIN", nil, onPlayerLogin)

local auras = ns.auras.viewModel.new()

local onPlayerLogin = function()
	
	auras.run()	

end

events.register("PLAYER_LOGIN", nil, onPlayerLogin)
Dark.warface = ns
