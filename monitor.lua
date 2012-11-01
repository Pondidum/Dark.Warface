local addon, ns = ...

local target = {
	
	start = 0,
	duration = 0,
	stacks = 0,
	maxStacks = 0,	
	mode = "NONE",		--NONE, ACTIVE, INACTIVE
	texture = nil,

	setCooldown = function(self, cooldownFrame)

		CooldownFrame_SetTimer(cooldownFrame, self.start, self.duration, 1, self.stacks, self.maxStacks)

	end,

	setAura = function(self, auraFrame)

		CooldownFrame_SetTimer(cooldownFrame, self.start, self.duration, 1, self.stacks, self.maxStacks)

	end,

	setStacks = function(self, text)

		if self.stacks ~= nil and self.stacks > 0 then
			text:SetText(self.stacks)
		else
			text:SetText("")	
		end

	end,

	setTexture = function(self, texture)

		texture:SetTexture(self.texture)

	end,

	update = function (self)
		self:reset()
	end,

	reset = function(self) 

		self.start = 0
		self.duration = 0
		self.stacks = 0
		self.maxStacks = 0	
		self.mode = "NONE"
		self.texture = nil

	end,

}

ns.targetMeta = { __index = target }
