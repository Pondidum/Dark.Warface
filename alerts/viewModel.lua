local addon, ns = ...

local alerts = ns.alerts
local config = ns.config

local core = Dark.core
local cache = core.cache

local viewModel = {

	new = function()

		local monitors = alerts.monitorFactory.new()
		local containers = alerts.viewController.new()
		local controllerFactory = alerts.controllerFactory.new()

		local alertViews = cache.new(function(i) return alerts.alertView.new("DarkWarface" .. i, UIParent) end)
		local specConfig

		local buildDisplays = function()

			local alertConfig = specConfig.alerts

			for containerName, containerConfig in pairs(alertConfig) do

				local container = containers.getView(containerName)

				for i, alertData in ipairs(containerConfig) do

					local model = monitors.getNew(alertData.type, alertData.args)
					local view = alertViews.get()
					view:Show()

					local controllers = alertData.controllers or containerConfig.controllers

					controllerFactory.bind(model, view, controllers, alertData.extra)

					model:forceUpdate()

					container.add(view)

				end

			end

		end

		local onSpecChanged = function()

			local dontCare, playerClass = UnitClass("player")
			local playerSpecID, playerSpec = GetSpecializationInfo(GetSpecialization())

			specConfig = config.classConfig[playerClass][playerSpec]


			containers.foreach(function(v)

				for k,v in pairs(v.children) do
					v:Hide()
				end

				v.clear()
			end)


			alertViews.recycleAll()
			monitors.recycleAll()

			buildDisplays()

		end



		local this = {}

		this.run = function()

			containers.createDisplays(config.alertDisplays)
			onSpecChanged()

		end

		this.specChanged = function()
			onSpecChanged()
		end

		return this
	end

}

alerts.viewModel = viewModel