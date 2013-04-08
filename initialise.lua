local addon, ns = ...
local config = ns.config


local getSpellNameHash = function(ids)
	
	local names = {}

	for i, value in ipairs(ids) do

		local spellName = GetSpellInfo(value)
		names[spellName] = true 

	end

	return names
end


local init = function()

	--make sure all classes return an empty table if they are not specified
	setmetatable(config.cooldowns.spells, { __index = function(t, v) return {} end})


	--copy the base blacklist onto each unit's blacklist
	local baseBlacklist = getSpellNameHash(config.auras.blacklist)
	config.auras.blacklist = baseBlacklist
	
	for unit, setup in pairs(config.auras.units) do

		local blacklist = getSpellNameHash(setup.blacklist or {})

		for k,v in pairs(baseBlacklist) do
			blacklist[k] = v
		end

		setup.blacklist = blacklist

	end

	

	ns.monitors = {}


end

init()