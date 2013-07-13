local addon, ns = ...

local viewController = {
	
	new = function()

		local this = {}
		local views = {}

		this.createDisplays = function(config)

			for name, displayConfig in pairs(config) do

				local container = ns.alerts.containerView.new(name, displayConfig)

				for i, anchorConfig in pairs(displayConfig.anchors) do
					container:SetPoint(unpack(anchorConfig))
				end

				views[name] = container

			end

		end

		this.getView = function(name)
			return views[name]
		end

		this.foreach = function(action)

			for name, view in pairs(views) do
				action(view)
			end
			
		end
		
		return this

	end	
}

ns.alerts.viewController = viewController