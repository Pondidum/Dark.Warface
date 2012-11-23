local addon, ns = ...

local init = function()

	ns.controller.defaultTextControllerIs("CDANDACTIVE")
	ns.controller.defaultGlowControllerIs("ACTIVE")

	local spellcd = ns.monitors["item"].new(10, 96228)		--gloves, synapse springs

	local display = ns.button.new("WarfaceTestButton", UIParent)
	display:SetSize(32,32)
	display:SetPoint("CENTER", UIParent, "CENTER", 0, -185)

	ns.controller.factory(spellcd, display, { textmode = "STACKS", glowmode = "STACKS", stacks = 5})
	
	Dark.warface = ns

end

init()