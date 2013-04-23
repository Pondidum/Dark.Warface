local addon, ns = ...

local viewController = {
	
	new = function()

		local this = {}
		local views = {}

		this.createDisplays = function(displays)

			for unit, displayConfig in pairs(displays) do
				
				local container = ns.auras.createUnitView(unit)

				for i, anchorConfig in pairs(displayConfig.anchors) do
					container:SetPoint(unpack(anchorConfig))
				end

				views[unit] = container

			end

		end

		this.resetDisplays = function()
	
			for unit, container in pairs(views) do

				container.resetViews()

				container.children = {}
				container.performLayout()
			end
			
		end

		this.getUnitViews = function()

			return views
			
		end

		return this

	end

}

ns.auras.viewController = viewController

