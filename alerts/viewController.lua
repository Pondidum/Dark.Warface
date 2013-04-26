local addon, ns = ...

local viewController = {
	
	new = function()

		local this = {}
		local views = {}

		this.createDisplays = function(config)

			for name, displayConfig in pairs(config) do

				local container = ns.alerts.containerView.new(unit, displayConfig)

				for i, anchorConfig in pairs(displayConfig.anchors) do
					container:SetPoint(unpack(anchorConfig))
				end

				views[name] = container

			end

		end

		this.getUnitViews = function()
			return views
		end
		
		return this

	end	
}

ns.alerts.viewController = viewController