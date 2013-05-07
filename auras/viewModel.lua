local addon, ns = ...
local config = ns.config

local core = Dark.core
local events = core.events

local checkWhiteList = function(config, spellID)
	return config[spellID]
end

local checkBlackList = function(config, spellID)
	return not config[spellID]
end

local viewModel = {
	
	new = function()

		local containers = ns.auras.viewController.new()
		local specConfig
		local classColor = {}

		local onSpecChanged = function()

			local _, playerClass = UnitClass("player")
			local playerSpecID, playerSpec = GetSpecializationInfo(GetSpecialization())
			local raidColor = RAID_CLASS_COLORS[playerClass]

			specConfig = config.classConfig[playerClass][playerSpec]
			classColor = {raidColor.r, raidColor.g, raidColor.b}

		end

		local onUnitAura = function(self, event, unit)

			if unit == nil then
				return 
			end

			local container = containers.getView(unit)
			
			if container == nil then
				return
			end

			containers.resetView(unit)
			
			local auraConfig = specConfig.auras[unit]

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

						view.setColor(unpack(classColor))
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

		local onTargetChanged = function()

			containers.resetAllViews()
			onUnitAura(nil, nil, "target")

		end

		local onFocusChanged = function()

			containers.resetAllViews()
			onUnitAura(nil, nil, "focus")

		end

		local registerEvents = function()
		
			events.register("UNIT_AURA", nil, onUnitAura)
			events.register("PLAYER_TARGET_CHANGED", nil, onTargetChanged)
			events.register("PLAYER_FOCUS_CHANGED", nil, onFocusChanged)

		end


		local this = {}

		this.run = function()

			containers.createViews(config.auraDisplays)
			onSpecChanged()
			
			registerEvents()

		end

		return this 

	end
}

ns.auras.viewModel = viewModel