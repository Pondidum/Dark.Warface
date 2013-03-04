local addon, ns = ...

local core = Dark.core
local events = core.events
local style = core.style

ns.views.addView("bar", function(name, parent)

	local frame = CreateFrame("Statusbar", name, parent)
	frame:SetStatusBarTexture(core.textures.normal)

	style.addBackground(frame)
	style.addShadow(frame)

	local cdStart, cdDuration
	local fill = false

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
	frame.setReverseFill = reverseFill


	frame.showGlow = function() end
	frame.hideGlow = function() end


	frame.showText = function() end
	frame.hideText = function() end	
	frame.setText = function(value) end

	frame.setIcon = function(value) end

	frame.showCooldown = function() end
	frame.hideCooldown = function() end

	frame.setCooldown = function(start, duration, active, stacks, maxStacks)
		setCooldown(start, duration)
	end

	setCooldown(0,0)
	return frame

end)
