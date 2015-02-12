local addon, ns = ...

local class = ns.lib.class
local style = ns.lib.style
local fonts = ns.lib.media.fonts

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

ns.cooldownBar = cooldownBar
