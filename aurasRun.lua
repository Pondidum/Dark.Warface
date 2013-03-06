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

	bar:SetScript("OnValueChanged", function(s, e) 
		if e <= 0 then  
			container:Hide()
		end
	end)

	return container

end


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

		local views = {}
		local getView = function(name)

			if views[name] then
				return views[name]
			end

			local v = createBar("DarkWarfaceAura" ..unit .."Bar"..name, container)

			views[name] = v
			return v

		end

		container.getView = getView
		container.config = unitConfig

		containers[unit] = container

	end

end

local monitorAuras = function()
	
	local sort = function(children)

		return children

	end

	local onEvent = function()

		for unit, container in pairs(containers) do
			
			local children = {}

			for i = 1, 20 do

				local auraName, auraRank, auraTexture, auraCount, auraDispel, auraDuration, auraExpires = UnitAura(unit, i, container.config.filter)

				if auraName then

					local view = container.getView(auraName)
					view.setName(auraName)
					view.setIcon(auraTexture)
					view.setCooldown(auraExpires - auraDuration, auraDuration)

					table.insert(children, view)

				end

			end
			
			table.sort(children, function(a, b) return a.remaining < b.remaining end)

			container.children = sort(children)
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