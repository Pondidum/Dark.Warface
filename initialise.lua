local addon, ns = ...
local config = ns.config

local combineTables = function(base, specific)
	
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

local processConfig = function()
	
	-- use a default value for unspecified classes
	config.classConfig.default = {}
	setmetatable(config.classConfig, { __index = function(t, k) 
		return t.default 
	end })

	for class, classConfig in pairs(config.classConfig) do

		print("class", class)

		--handle unspecified specs
		setmetatable(classConfig, { __index = function(t, k)
			return config.specBase
		end })


		for spec, specConfig in pairs(classConfig) do
		
			--handle unspecified elements
			setmetatable(specConfig, { __index = config.specBase })

			local baseAuraConfig = config.specBase.auras
			local auraConfig = specConfig.auras

			--handle unspecified units
			setmetatable(auraConfig, { __index = config.specBase.auras })
			
			auraConfig.player = combineTables(baseAuraConfig.player, auraConfig.player)
			auraConfig.target = combineTables(baseAuraConfig.target, auraConfig.target)
			auraConfig.focus = combineTables(baseAuraConfig.focus, auraConfig.focus)	

		end		

	end

end

local init = function()

	processConfig()


	ns.monitors = {}
	ns.auras = {}


end

init()