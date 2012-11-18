local addon, ns = ...
local eventStore = Dark.core.events

local target = {
	
	name = "",
	start = 0,
	duration = 0,
	stacks = 0,
	maxStacks = 0,	
	mode = "NONE",		--NONE, ACTIVE, INACTIVE
	texture = nil,
	listeners = {},

	setCooldown = function(self, cooldownFrame)

		CooldownFrame_SetTimer(cooldownFrame, self.start, self.duration, 1, self.stacks, self.maxStacks)

	end,

	setAura = function(self, auraFrame)

		CooldownFrame_SetTimer(auraFrame, self.start, self.duration, 1, self.stacks, self.maxStacks)

	end,

	setStacks = function(self, text)

		if self.stacks ~= nil and self.stacks > 0 then
			text:SetText(self.stacks)
		else
			text:SetText("")	
		end

	end,

	addListener = function(self, key, action)

		self.listeners[key] = action

	end,

	updated = function(self)

		for key, action in pairs(self.listeners) do
			action(self)
		end

	end,

	setTexture = function(self, texture)

		texture:SetTexture(self.texture)

	end,

	onEvent = function(self, event, action)
		eventStore.register(event, nil, action)
	end,

	reset = function(self) 

		self.start = 0
		self.duration = 0
		self.stacks = 0
		self.maxStacks = 0	
		self.mode = "NONE"
		self.texture = nil

	end,

	report = function(self)

		print(string.format("%s (%s) Start: %d, Duration: %d, Stacks: %d, Texture: %s", 
			self.name, 
			self.mode,
			self.start, 
			self.duration, 
			self.stacks, 
			self.texture
			))

	end,

}

ns.targetMeta = { __index = target }
