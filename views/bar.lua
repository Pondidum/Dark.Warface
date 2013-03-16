local addon, ns = ...

local core = Dark.core
local events = core.events
local style = core.style
local ui = core.ui


local round = function(number, decimals)
	if not decimals then decimals = 0 end
    return (("%%.%df"):format(decimals)):format(number)
end

local cooldownBar = {
	
	new = function(name, parent)

		local frame = CreateFrame("Statusbar", name, parent)

		local text = ui.createFont(frame)
		text:SetAllPoints(frame)
		text:SetJustifyH("RIGHT")
		frame.text = text

		local cdStart, cdDuration = 0, 0
		local fill = false

		frame.setCooldown = function(start, duration)
			cdStart = start
			cdDuration = duration

			frame:SetMinMaxValues(0, duration)
			frame:Show()

		end

		frame.setReverseFill = function(value)
			fill = not value
		end

		frame:SetScript("OnUpdate", function()

			local t = GetTime() - cdStart

			if t > cdDuration then
				frame:Hide()

			elseif fill then
				frame:SetValue(t)
				text:SetText(round(t, 1))

			else
				frame:SetValue(cdDuration - t)
				text:SetText(round(cdDuration - t, 1))

			end

		end)

		return frame

	end,

}

ns.views.addView("bar", function(name, parent)

	local container = CreateFrame("Frame", name, parent)
	style.addBackground(container)
	style.addShadow(container)
	
	local icon = container:CreateTexture()
	icon:SetPoint("TOPLEFT")
	icon:SetPoint("BOTTOMLEFT")
	icon:SetTexCoord(.08, .92, .08, .92)
	icon:SetWidth(20)

	local bar = cooldownBar.new("TestBar", container)
	bar:SetStatusBarTexture(core.textures.normal)
	bar:SetPoint("BOTTOMLEFT", icon, "BOTTOMRIGHT", 0, 0)
	bar:SetPoint("TOPRIGHT", container, "TOPRIGHT", 0, 0)


	local text = ui.createFont(bar)
	text:SetPoint("TOPLEFT")
	text:SetPoint("BOTTOMLEFT")
	text:SetPoint("RIGHT", bar, "CENTER", 0, 0)

	container.setName = function(value) text:SetText(value) end
	container.setIcon = function(value) icon:SetTexture(value) end

	container.setCooldown = function(start, duration, active, stacks, maxStacks)
		bar.setCooldown(start, duration)
	end

	return container

end)
