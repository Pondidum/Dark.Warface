local addon, ns = ...

local core = Dark.core
local events = core.events
local style = core.style

ns.views.addView("bar", function(name, parent)

	local frame = CreateFrame("Statusbar", name, parent)
	frame:SetStatusbarTexture(core.textures.normal)

	style.addBackground(frame)
	style.addShadow(frame)

	local cdStart, cdDuration
	local fill = true

	local setCooldown = function(start, duration)
		cdStart = start
		cdDuration = duration

		frame:SetMinMaxValues(0, duration)
		frame:Show()
	end

	local reverseFill = function(value)
		fill = not value
	end

	local onUpdate = function()

		local t = GetTime() - cdStart

		if t > cdDuration then
			frame:Hide()

		elseif fill then
			frame:SetValue(t)

		else
			frame:SetValue(cdDuration - t)
			
		end

	end

	frame:SetScript("OnUpdate", onUpdate)
	frame.setCooldown = setCooldown
	frame.setReverseFill = reverseFill

	return frame

end)