local addon, ns = ...
local config = ns.config.auras

local core = Dark.core
local events = core.events
local layout = core.layout
local ui = core.ui
local style = core.style


local round = function(number, decimals)
	if not decimals then decimals = 0 end
    return (("%%.%df"):format(decimals)):format(number)
end


local createBar = function(name, parent)

	local container = CreateFrame("Frame", name, parent)
	container:SetHeight(20)
	style.addBackground(container)
	style.addShadow(container)

	container.remaining = 0
	
	local icon = container:CreateTexture()
	icon:SetPoint("TOPLEFT")
	icon:SetPoint("BOTTOMLEFT")
	icon:SetTexCoord(.08, .92, .08, .92)
	icon:SetWidth(20)

	local bar = ui.createCooldownBar("TestBar", container)
	bar:SetStatusBarTexture(core.textures.normal)
	bar:SetPoint("BOTTOMLEFT", icon, "BOTTOMRIGHT", 0, 0)
	bar:SetPoint("TOPRIGHT", container, "TOPRIGHT", 0, 0)


	local text = ui.createFont(bar)
	text:SetPoint("TOPLEFT")
	text:SetPoint("BOTTOMLEFT")
	text:SetPoint("RIGHT", bar, "CENTER", 0, 0)

	container.setName = function(value) 
		text:SetText(value)
	end

	container.setIcon = function(value) 
		icon:SetTexture(value)
	end

	container.setCooldown = function(start, duration, active, stacks, maxStacks)
		bar.setCooldown(start, duration)
		container.remaining = duration - (GetTime() - start)
	end

	bar:SetScript("OnHide", function(s, e) 
		container:Hide()
	end)

	return container

end


local containers = {}

local createDisplays = function()

	for unit, unitConfig in pairs(config) do
		
		local container = CreateFrame("Frame", "DarkWarfaceAura" .. unit, UIParent)
		layout.init(container, {
			type = "STACK",
			origin = "BOTTOM",
			autosize = true,
		})

		unitConfig.customise(container)

		container.views = {}
		local getView = function(name)

			if container.views[name] then
				return container.views[name]
			end

			local v = createBar("DarkWarfaceAura" ..unit .."Bar"..name, container)

			container.views[name] = v
			return v

		end

		container.getView = getView
		container.config = unitConfig

		containers[unit] = container

	end

end

local checkWhiteList = function(config, spellID)
	return config.whitelist[spellID]
end

local checkBlackList = function(config, spellID)
	return not config.blacklist[spellID]
end

local monitorAuras = function()
	
	local sort = function(children)
		return children
	end

	local onUnitAura = function()

		for unit, container in pairs(containers) do
			
			local containerConfig = container.config

			local check = containerConfig.mode == "WHITELIST" and checkWhiteList or checkBlackList
			local children = {}

			for i = 1, 20 do

				local auraName, auraRank, auraTexture, auraCount, auraDispel, auraDuration, auraExpires, caster, isStealable, shouldConsolidate, spellID = UnitAura(unit, i, containerConfig.filter)

				if auraName and auraDuration and auraDuration ~= 0 and auraExpires and auraExpires ~= 0  then

					if auraDuration < 60 and caster == "player" and check(containerConfig, spellID) then
						
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

			container.children = sort(children)
			container.performLayout()

		end

	end

	events.register("UNIT_AURA", nil, onUnitAura)

	local onTargetChanged = function()

		for unit, container in pairs(containers) do

			for name, view in pairs(container.views) do
				view.setCooldown(0, 0)
			end

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
