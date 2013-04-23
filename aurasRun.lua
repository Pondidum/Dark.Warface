local addon, ns = ...
local config = ns.config

local core = Dark.core
local events = core.events
local layout = core.layout
local ui = core.ui
local style = core.style


-- local round = function(number, decimals)
-- 	if not decimals then decimals = 0 end
--     return (("%%.%df"):format(decimals)):format(number)
-- end




local containers = {}

local createDisplays = function()

	for unit, displayConfig in pairs(config.auraDisplays) do
		
		local container = ns.auras.createUnitView(unit)

		for i, anchorConfig in pairs(displayConfig.anchors) do
			container:SetPoint(unpack(anchorConfig))
		end

		containers[unit] = container

	end

end

local checkWhiteList = function(config, spellID)
	return config[spellID]
end

local checkBlackList = function(config, spellID)
	return not config[spellID]
end

 local monitorAuras = function()
	

	local playerClass = UnitClass("player")
	local playerSpecID, playerSpec = GetSpecializationInfo(GetSpecialization())

	local specConfig = config.classConfig[playerClass][playerSpec]

	local onUnitAura = function()

		for unit, container in pairs(containers) do
			
			local auraConfig = specConfig.auras[unit]

			local check = auraConfig.mode == "WHITELIST" and checkWhiteList or checkBlackList
			local children = {}

			for i = 1, 20 do

				local auraName, auraRank, auraTexture, auraCount, auraDispel, auraDuration, auraExpires, caster, isStealable, shouldConsolidate, spellID = UnitAura(unit, i, auraConfig.filter)

				if auraName and auraDuration and auraDuration ~= 0 and auraExpires and auraExpires ~= 0  then

					if auraDuration < 60 and caster == "player" and check(auraConfig, spellID) then
						
						local view = container.getView(auraName)
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

 	events.register("UNIT_AURA", nil, onUnitAura)

	local onTargetChanged = function()

		for unit, container in pairs(containers) do

			container.resetViews()

			container.children = {}
			container.performLayout()
		end

		onUnitAura()

	end

	events.register("PLAYER_TARGET_CHANGED", nil, onTargetChanged)
	events.register("PLAYER_FOCUS_CHANGED", nil, onTargetChanged)

end




local onPlayerLogin = function()
	createDisplays()
	monitorAuras()
end

events.register("PLAYER_LOGIN", nil, onPlayerLogin)
