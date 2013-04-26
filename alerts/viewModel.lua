local addon, ns = ...

local alerts = ns.alerts

local viewModel = {
	
	new = function()
		
		local monitors = alerts.monitorController.new()
		local containers = alerts.viewController.new()

		local alertViews = cache.new(function(i) return alerts.alertView.new("DarkWarface" .. i, UIParent) end)
		local specConfig

		local buildDisplays = function()

			local alertConfig = specConfig.alerts
			local containers = containers.getUnitViews()

			for containerName, containerConfig in pairs(alertConfig) do
				
					local container = containers[containerName]

					--local model = ns.monitors[entry.type].new(parseArgs(entry.args))
					local view = alertviews.get()

					--ns.controller.factory(model, view, entry.controllers, entry.extra)

					container.add(view)

					--table.insert(models, model)

				
			end
		end
		local onSpecChanged = function()

			local playerClass = UnitClass("player")
			local playerSpecID, playerSpec = GetSpecializationInfo(GetSpecialization())

			specConfig = config.classConfig[playerClass][playerSpec]

			alertView.recycleAll()
			models.recycleAll()


		end



		local this = {}

		this.run = function()

			containers.createDisplays(config.alertDIsplays)

		end

		return this
	end

}

alerts.viewModel = viewModel