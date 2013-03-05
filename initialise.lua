local addon, ns = ...
local config = ns.config

local init = function()

	--config processing
	setmetatable(config.cooldowns.spells, { __index = function(t, v) return {} end})


	--Dark.Warface = ns	-- change to lib object later

	ns.monitors = {}


end

init()