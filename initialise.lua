local addon, ns = ...
local config = ns.config

local convertToHash = function(input)
	
	for i,v in ipairs(input) do
		input[v] = true
	end

end

local function combineTables(t1, t2)

	local out = {}

	for k,value in pairs(t1) do

		if type(value) == "table" then
			out[k] = combineTables(value, t2[k] or {})
		else
			out[k] = value 	
		end

	end

	for k,value in pairs(t2) do
		
		if type(value) == "table" then
			out[k] = combineTables(t1[k] or {}, value)
		else
			out[k] = value
		end

	end

    return out

end

local combineSpecTablesWithBase = function()

	local base = ns.config.specBase
	
	--use base data for unspecified classes
	config.classConfig.default = {}
	setmetatable(config.classConfig, { __index = function(t) return t.default end })

	for className, classSpecs in pairs(config.classConfig) do
		
		--use base data for unspecified specs
		setmetatable(classSpecs, { __index = base })

		--rollup base data into spec data
		for specName, specConfig in pairs(classSpecs) do

			classSpecs[specName] = combineTables(base, specConfig)
			
		end

	end

end

local preProcessAuras = function()

	local hashAuras = function(set)
		
		for k,v in pairs(set) do
			convertToHash(v)
		end

	end

	hashAuras(config.specBase.auras)

	for className, classSpecs in pairs(config.classConfig) do
		for specName, specConfig in pairs(classSpecs) do
			
			if specConfig.auras then
				convertToHash(specConfig.auras)
			end

		end
	end

end

local preProcessAlerts = function()
	
	for displayName, displayConfig in pairs(config.specBase.alerts) do

		if displayConfig.controllers then
			convertToHash(displayConfig.controllers)
		end

	end

	for className, classSpecs in pairs(config.classConfig) do
		for specName, specConfig in pairs(classSpecs) do

			for displayName, displayConfig in pairs(specConfig.alerts) do

			end

		end
	end
end

local postProcessAlerts = function()
	
	for className, classSpecs in pairs(config.classConfig) do
		for specName, specConfig in pairs(classSpecs) do
			
			for displayName, displayConfig in pairs(specConfig.alerts) do
				
				if displayConfig.controllers then
					convertToHash(displayConfig.controllers)
				end

				for i, entry in pairs(displayConfig) do
					
					if entry.controllers then
						convertToHash(entry.controllers)
					end
					
				end

			end
			
		end
	end

end

local processConfig = function()
	
	preProcessAuras()	
	preProcessAlerts()

	combineSpecTablesWithBase()	

	--postProcessAuras
	postProcessAlerts()

end

local init = function()

	processConfig()


	ns.monitors = {}
	ns.auras = {}
	ns.alerts = {}


end

init()