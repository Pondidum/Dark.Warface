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

	container.setName = function(value) text:SetText(value) end
	container.setIcon = function(value) icon:SetTexture(value) end

	container.setCooldown = function(start, duration, active, stacks, maxStacks)
		bar.setCooldown(start, duration)
	end

	bar:SetScript("OnValueChanged", function(s, e) 
		if e <= 0 then  
			container:Hide()
		end
	end)

	return container

end


-----------------------------

local containers = {}

local createDisplays = function()

	for unit, unitConfig in pairs(config.units) do
		
		local container = CreateFrame("Frame", "DarkWarfaceAura" .. unit, UIParent)
		layout.init(container, {
			type = "STACK",
			origin = "BOTTOM",
			autosize = true,
		})

		unitConfig.customise(container)


		local cache = core.cache.new(function(i) return createBar("DarkWarfaceAura" ..unit .."Bar"..i, container) end)

		containers[unit] = { container = container, cache = cache, config = unitConfig}

	end

end

local monitorAuras = function()

	local recycleAll = function(container, cache)

		cache.recycleAll()

		--cache.debug()
	end

	local onEvent = function()

		for unit, unitParts in pairs(containers) do
			
			local cache = unitParts.cache
			local container = unitParts.container
			local conf = unitParts.config
			
			recycleAll(container, cache)

			local children = {}

			for i = 1, 20 do

				local auraName, auraRank, auraTexture, auraCount, auraDispel, auraDuration, auraExpires = UnitAura(unit, i, conf.filter)

				if auraName then

					local view = cache.get()
					view.setName(auraName)
					view.setIcon(auraTexture)
					view.setCooldown(auraExpires - auraDuration, auraDuration)

					table.insert(children, view)

				end

			end

			container.children = children
			container.performLayout()

		end

	end

	events.register("UNIT_AURA", nil, onEvent)
	events.register("PLAYER_TARGET_CHANGED", nil, onEvent)
	events.register("PLAYER_FOCUS_CHANGED", nil, onEvent)

end




local onPlayerLogin = function()
	createDisplays()
	monitorAuras()
end

events.register("PLAYER_LOGIN", nil, onPlayerLogin)
