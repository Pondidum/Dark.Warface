local addon, ns = ...
local config = ns.config

local combineAuraTables = function(base, specific)
	
	local output = {}

	for k,v in ipairs(base) do
		output[v] = true
	end

	for k,v in ipairs(specific) do
		output[v] = true
	end

	output.mode = specific.mode or base.mode
	output.filter = specific.filter or base.filter

	return output

end

local combineControllers = function(base, specific)
	
	local combined = {}

	for i,v in ipairs(base) do
		combined[v] = true
	end

	for i,v in ipairs(specific) do
		combined[v] = true
	end

	local output = {}

	for k,v in pairs(combined) do
		table.insert(output, k)
	end

	return output

end

local processAuraConfig = function(specConfig)

	local baseAuraConfig = config.specBase.auras
	local auraConfig = specConfig.auras

	--handle unspecified units
	setmetatable(auraConfig, { __index = config.specBase.auras })

	auraConfig.player = combineAuraTables(baseAuraConfig.player, auraConfig.player)
	auraConfig.target = combineAuraTables(baseAuraConfig.target, auraConfig.target)
	auraConfig.focus = combineAuraTables(baseAuraConfig.focus, auraConfig.focus)	

end

local processAlertConfig = function(specConfig)

	local alerts = specConfig.alerts
	local base = config.specBase.alerts

	for displayName, items in pairs(alerts) do
		
		local baseControllers = base[displayName].controllers

		for i, alert in ipairs(items) do
			
			alert.controllers = combineControllers(baseControllers, alert.controllers or {})

		end

	end
	--[[
	local baseAlertConfig = config.specBase.alerts
	

	for name, alertDisplay in pairs(alerts) do
		
		local baseControllers = baseAlertConfig[name].controllers

		if baseControllers then

			for i, alert in pairs(alertDisplay) do
				print(alert.type)
			end
		end

	end
	]]

end

local processConfig = function()
	
	-- use a default value for unspecified classes
	config.classConfig.default = {}

	setmetatable(config.classConfig, { __index = function(t, k) 
		return t.default 
	end })

	for class, classConfig in pairs(config.classConfig) do

		--handle unspecified specs
		setmetatable(classConfig, { __index = function(t, k)
			return config.specBase
		end })


		for spec, specConfig in pairs(classConfig) do
		
			--handle unspecified elements
			setmetatable(specConfig, { __index = config.specBase })

			processAuraConfig(specConfig)
			processAlertConfig(specConfig)

		end		

	end

end

local init = function()

	processConfig()


	ns.monitors = {}
	ns.auras = {}
	ns.alerts = {}


end

init()