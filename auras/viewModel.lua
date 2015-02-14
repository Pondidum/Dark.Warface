local addon, ns = ...
local config = ns.config

local class = ns.lib.class
local events = ns.lib.events
local colors = ns.lib.media.colors

local checkWhiteList = function(config, spellID)
	return config[spellID]
end

local checkBlackList = function(config, spellID)
	return not config[spellID]
end


local viewModel = class:extend({

	events = {
		"ACTIVE_TALENT_GROUP_CHANGED",
		"PLAYER_TARGET_CHANGED",
		"PLAYER_FOCUS_CHANGED",
		"UNIT_AURA",
	},

	ctor = function(self)
		self:include(events)

		self.containers = ns.auras.viewController.new()

		self.containers.createViews(config.auraDisplays)
		self:ACTIVE_TALENT_GROUP_CHANGED()

	end,

	ACTIVE_TALENT_GROUP_CHANGED = function(self)

		local _, playerClass = UnitClass("player")
		local spec = GetSpecialization()


		local raidColor = colors.class[playerClass]
		if spec then
			local playerSpecID, playerSpec = GetSpecializationInfo(spec)
			self.specConfig = config.classConfig[playerClass][playerSpec]
		else
			self.specConfig = setmetatable({}, { __index = config.specBase })
		end

		self.classColor = raidColor

	end,

	PLAYER_TARGET_CHANGED = function(self)

		self.containers.resetAllViews()
		self:UNIT_AURA("target")

	end,

	PLAYER_FOCUS_CHANGED = function(self)

		self.containers.resetAllViews()
		self:UNIT_AURA("focus")

	end,

	UNIT_AURA = function(self, unit)

		local container = self.containers.getView(unit)

		if container == nil then
			return
		end

		self.containers.resetView(unit)

		local auraConfig = self.specConfig.auras[unit]

		if auraConfig == nil then
			return
		end

		local check = auraConfig.mode == "WHITELIST" and checkWhiteList or checkBlackList
		local children = {}

		for i = 1, 20 do

			local auraName, auraRank, auraTexture, auraCount, auraDispel, auraDuration, auraExpires, caster, isStealable, shouldConsolidate, spellID = UnitAura(unit, i, auraConfig.filter)

			if auraName and auraDuration and auraDuration ~= 0 and auraExpires and auraExpires ~= 0  then

				if caster == "player" and check(auraConfig, spellID) then

					local view = container.getView(spellID)

					view.setColor(unpack(self.classColor))
					view.setName(auraName)
					view.setIcon(auraTexture)
					view.setStacks(auraCount)
					view.setCooldown(auraExpires - auraDuration, auraDuration)

					view:Show()

					table.insert(children, view)
				end

			end

		end

		table.sort(children, function(a, b) return a.remaining > b.remaining end)

		container.children = children
		container.performLayout()

	end

})

ns.auras.viewModel = viewModel
