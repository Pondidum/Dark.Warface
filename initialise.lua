local addon, ns = ...
local config = ns.config

local init = function()

	--config processing
	setmetatable(config.cooldowns.spells, { __index = function(t, v) return {} end})

	local ids = {}

	for i, value in ipairs (config.auras.filter) do

		local spellID = GetSpellInfo(value)
		ids[spellID] = true 

	end

	config.auras.filter = ids

	--Dark.Warface = ns	-- change to lib object later

	ns.monitors = {}


end

init()