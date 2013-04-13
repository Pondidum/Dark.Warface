local addon, ns = ...
local config = ns.config

local auraBase = {
	filter = "PLAYER|HARMFUL",
	customise = function(this)
		this:SetPoint("CENTER", _G["UIParent"], "CENTER", 0, 0)
		this:SetHeight(50)
	end,

	mode = "BLACKLIST",
	blacklist = {},
	whitelist = {},
}

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

	--change spellids into spellnames
	for unit, setup in pairs(config.auras.units) do

		setup.blacklist = getSpellNameHash(setup.blacklist or {})
		setup.whitelist = getSpellNameHash(setup.whitelist or {})

		setmetatable(setup, { __index = auraBase })

	end

	

	ns.monitors = {}


end

init()