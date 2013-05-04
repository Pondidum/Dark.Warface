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

		local onSpecChanged = function()

			local _, playerClass = UnitClass("player")
			local playerSpecID, playerSpec = GetSpecializationInfo(GetSpecialization())

			specConfig = config.classConfig[playerClass][playerSpec]

		end

		local onUnitAura = function()

			for unit, container in pairs(containers.getUnitViews()) do
				
				local auraConfig = specConfig.auras[unit]

				local check = auraConfig.mode == "WHITELIST" and checkWhiteList or checkBlackList
				local children = {}

				for i = 1, 20 do

					local auraName, auraRank, auraTexture, auraCount, auraDispel, auraDuration, auraExpires, caster, isStealable, shouldConsolidate, spellID = UnitAura(unit, i, auraConfig.filter)

					if auraName and auraDuration and auraDuration ~= 0 and auraExpires and auraExpires ~= 0  then

						if auraDuration < 60 and caster == "player" and check(auraConfig, spellID) then
							
							local view = container.getView(spellID)
							view.setName(auraName)
							view.setIcon(auraTexture)
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

		end

		local onTargetChanged = function()

			containers.resetDisplays()
			onUnitAura()

		end

		local registerEvents = function()
		
			events.register("UNIT_AURA", nil, onUnitAura)
			events.register("PLAYER_TARGET_CHANGED", nil, onTargetChanged)
			events.register("PLAYER_FOCUS_CHANGED", nil, onTargetChanged)

		end


		local this = {}

		this.run = function()

			containers.createDisplays(config.auraDisplays)
			onSpecChanged()
			
			registerEvents()

		end

		return this 

	end
}

ns.auras.viewModel = viewModel