local addon, ns = ...

local textControllers = {}
local glowControllers = {}

textControllers["CDANDACTIVE"] = function(monitor, display, extra)
	
	display.cooldown:Show()
	display.text:Hide()

	monitor:addListener("cdAndActiveTextController", function(m)
		CooldownFrame_SetTimer(display.cooldown, m.start, m.duration, 1, m.stacks, m.maxStacks)
	end)

end

textControllers["STACKS"] = function(monitor, display, extra)
	
	display.cooldown:Hide()
	display.text:Show()

	monitor:addListener("stacksTextController", function(m)

		if m.stacks == nil or m.stacks == 0 then
			display.text:SetText("")
		else
			display.text:SetText(m.stacks)
		end

	end)

end

glowControllers["STACKS"] = function(monitor, display, extra)
	
	monitor:addListener("stacksGlowController", function(m)

		if m.mode == "ACTIVE" and m.stacks >= extra.stacks then
			display.showGlow()
		else
			display.hideGlow()
		end

	end)

end

glowControllers["ACTIVE"] = function(monitor, display, extra)
	
	monitor:addListener("activeGlowController", function(m)

		if m.mode == "ACTIVE" then
			display.showGlow()
		else
			display.hideGlow()
		end

	end)

end

defaultKeyMeta = {
	__index = function(table, key)
		return table.default
	end,
}



textControllers.default = textControllers["CDANDACTIVE"]
glowControllers.default = glowControllers["ACTIVE"]

setmetatable(textControllers, defaultKeyMeta)
setmetatable(glowControllers, defaultKeyMeta)


local baseController = function(monitor, display, extra)

	monitor:addListener("baseController", function(m)
		display.icon:SetTexture(m.texture)
	end)

	textControllers[extra.textmode](monitor, display, extra)
	glowControllers[extra.glowmode](monitor, display, extra)

end

local init = function()

	local spellcd = ns.monitors["item"].new(10, 96228)		--shammy rage

	local display = ns.button.new("WarfaceTestButton", UIParent)
	display:SetSize(32,32)
	display:SetPoint("CENTER", UIParent, "CENTER", 0, -185)

	baseController(spellcd, display, { textmode = "", glowmode = "" })--{ textmode = "STACKS", glowmode = "STACKS", stacks = 5 })
	
	ns.TestSpell = spellcd
	


	Dark.warface = ns

end

init()