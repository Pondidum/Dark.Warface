local addon, ns = ...

local class = ns.lib.class
local style = ns.lib.style
local fonts = ns.lib.media.fonts

local core = Dark.core
local ui = core.ui


local cooldownBar = class:extend({

	ctor = function(self, name, parent)

		local frame = CreateFrame("Statusbar", name, parent)

		local text = fonts:create(frame)
		text:SetAllPoints(frame)
		text:SetJustifyH("RIGHT")
		frame.text = text

		self.cdStart = 0
		self.cdDuration = 0
		self.fill = false

		frame:SetScript("OnUpdate", function()

			local t = GetTime() - self.cdStart

			if t > self.cdDuration then
				frame:Hide()

			elseif self.fill then
				frame:SetValue(t)
				text:SetText(self:round(t, 1))

			else
				frame:SetValue(self.cdDuration - t)
				text:SetText(self:round(self.cdDuration - t, 1))

			end

		end)

		self.frame = frame

	end,

	round = function(self, number, decimals)
    	return (("%%.%df"):format(decimals)):format(number)
	end,

	setCooldown = function(self, start, duration)
		self.cdStart = start
		self.cdDuration = duration

		self.frame:SetMinMaxValues(0, duration)
		self.frame:Show()
	end,

	setReverseFill = function(self, value)
		self.fill = not value
	end,

	setTexture = function(self, texture)
		self.frame:SetStatusBarTexture(texture)
	end,

	setColor = function(self, r, g, b)
		self.frame:SetStatusBarColor(r, g, b)
	end,

	setPoint = function(self, ...)
		self.frame:SetPoint(...)
	end,
})



local barView = {

	new = function(name, parent)

		local container = CreateFrame("Frame", name, parent)
		container:SetHeight(20)
		container:SetAlpha(0.8)
		style:frame(container)

		container.remaining = 0

		local icon = container:CreateTexture()
		icon:SetPoint("TOPLEFT")
		icon:SetPoint("BOTTOMLEFT")
		icon:SetTexCoord(.08, .92, .08, .92)
		icon:SetWidth(20)

		local stacks = fonts:create(container, nil, 16)
		stacks:SetAllPoints(icon)
		stacks:SetJustifyH("CENTER")

		local bar = cooldownBar:new("TestBar", container)
		bar:setTexture(core.textures.normal)
		bar:setPoint("BOTTOMLEFT", icon, "BOTTOMRIGHT", 0, 0)
		bar:setPoint("TOPRIGHT", container, "TOPRIGHT", 0, 0)

		local name = fonts:create(bar.frame)
		name:SetPoint("TOPLEFT", 5, 0)
		name:SetPoint("BOTTOMLEFT", 5, 0)
		name:SetPoint("RIGHT", bar.frame, "CENTER", 0, 0)

		container.setName = function(value)
			name:SetText(value)
		end

		container.setIcon = function(value)
			icon:SetTexture(value)
		end

		container.setStacks = function(value)

			if value == 0 then
				stacks:SetText('')
			else
				stacks:SetText(value)
			end

		end

		container.setColor = function(r, g, b)
			bar:setColor(r, g, b)
		end

		container.setCooldown = function(start, duration, active, stacks, maxStacks)
			bar:setCooldown(start, duration)
			container.remaining = duration - (GetTime() - start)
		end

		bar.frame:SetScript("OnHide", function(s, e)
			container:Hide()
		end)

		return container

	end
}

ns.auras.barView = barView