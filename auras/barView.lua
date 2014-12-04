local addon, ns = ...

local core = Dark.core
local ui = core.ui
local style = core.style

local barView = {

	new = function(name, parent)

		local container = CreateFrame("Frame", name, parent)
		container:SetHeight(20)
		container:SetAlpha(0.8)
		style.addBackground(container)
		style.addShadow(container)

		container.remaining = 0

		local icon = container:CreateTexture()
		icon:SetPoint("TOPLEFT")
		icon:SetPoint("BOTTOMLEFT")
		icon:SetTexCoord(.08, .92, .08, .92)
		icon:SetWidth(20)

		local stacks = ui.createFont(container, nil, 16, "OUTLINE")
		stacks:SetAllPoints(icon)
		stacks:SetJustifyH("CENTER")

		local bar = ui.createCooldownBar("TestBar", container)
		bar:SetStatusBarTexture(core.textures.normal)
		bar:SetPoint("BOTTOMLEFT", icon, "BOTTOMRIGHT", 0, 0)
		bar:SetPoint("TOPRIGHT", container, "TOPRIGHT", 0, 0)

		local name = ui.createFont(bar)
		name:SetPoint("TOPLEFT", 5, 0)
		name:SetPoint("BOTTOMLEFT", 5, 0)
		name:SetPoint("RIGHT", bar, "CENTER", 0, 0)

		container.setName = function(value)
			name:SetText(value)
		end

		container.setIcon = function(value)
			icon:SetTexture(value)
		end

		container.setStacks = function(value)

			if value == 0 then
				stacks:SetText('')
			else
				stacks:SetText(value)
			end

		end

		container.setColor = function(r, g, b)
			bar:SetStatusBarColor(r, g, b)
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
}

ns.auras.barView = barView