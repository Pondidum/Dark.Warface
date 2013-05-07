local addon, ns = ...

local viewController = {
	
	new = function()

		local this = {}
		local views = {}

		this.createViews = function(displays)

			for unit, displayConfig in pairs(displays) do
				
				local container = ns.auras.containerView.new(unit)

				for i, anchorConfig in pairs(displayConfig.anchors) do
					container:SetPoint(unpack(anchorConfig))
				end

				views[unit] = container

			end

		end

		this.getView = function(unit)
			return views[unit]
		end

		this.resetView = function(unit)

			local view = views[unit]

			if view then
				view.resetViews()
				view.children = {}
				view.performLayout()
			end

		end

		this.resetAllViews = function()
	
			for unit, container in pairs(views) do
				this.resetView(unit)
			end
			
		end

		return this

	end

}

ns.auras.viewController = viewController

