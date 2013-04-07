local addon, ns = ...
local config = ns.config

local init = function()

	--config processing
	setmetatable(config.cooldowns.spells, { __index = function(t, v) return {} end})

	local ids = {}

	for i, value in ipairs (config.auras.blacklist) do

		local spellID = GetSpellInfo(value)
		ids[spellID] = true 

	end

	config.auras.blacklist = ids

	--Dark.Warface = ns	-- change to lib object later

	ns.monitors = {}


end

init()