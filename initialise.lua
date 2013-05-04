local addon, ns = ...
local config = ns.config

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

local convertToHash = function(input)
	
	for i,v in ipairs(input) do
		input[v] = true
	end

end

local combineSpecTablesWithBase = function()

	local base = ns.config.specBase

	convertToHash(base.auras.player)
	convertToHash(base.auras.focus)
	convertToHash(base.auras.target)
	
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

local processConfig = function()
	
	combineSpecTablesWithBase()	

end

local init = function()

	processConfig()


	ns.monitors = {}
	ns.auras = {}
	ns.alerts = {}


end

init()