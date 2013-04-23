local addon, ns = ...

local core = Dark.core
local ui = core.ui
local style = core.style


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

ns.auras.createBarView = createBar