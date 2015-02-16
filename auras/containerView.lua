local addon, ns = ...

local class = ns.lib.class
local layout = ns.lib.layout

local containerView = class:extend({

	ctor = function(self, unitName)

		self.subViews = {}
		self.unitName = unitName

		self.frame = CreateFrame("Frame", "DarkWarfaceAura" .. unitName, UIParent)
		self.engine = layout:new(self.frame, {
			layout = "vertical",
			origin = "BOTTOM",
			itemSize = 20,
			itemSpacing = 2,
			autosize = "y"
		})

	end,

	setChildren = function(self, children)

		local engine = self.engine

		for i,child in ipairs(children) do
			engine:addChild(child)
		end

		engine:performLayout()

		for i,child in ipairs(children) do
			child:SetPoint("LEFT")
			child:SetPoint("RIGHT")
		end
	end,

	getView = function(self, id)

		if not self.subViews[id] then
			self.subViews[id] = ns.auras.barView.new("$parentBar"..id, self.frame)
		end

		return self.subViews[id]

	end,

	resetViews = function(self)

		for name, view in pairs(self.subViews) do
			view.setCooldown(0, 0)
		end

		self.engine:clearChildren()
	end,

	setPoint = function(self, ...)
		self.frame:SetPoint(...)
	end,
})

ns.auras.containerView = containerView