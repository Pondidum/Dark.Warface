local addon, ns = ...

local init = function()

	local spellcd = ns.monitors["totem"].new(1)

	spellcd:addListener("dev", function(cd) print(cd.name) end)

	ns.TestSpell = spellcd
	

	Dark.warface = ns

end

init()