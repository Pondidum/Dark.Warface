local addon, ns = ...
local alerts = ns.alerts
local events = Dark.core.events

local UnitHealthMax, UnitHealth,UnitIsDeadOrGhost, UnitExists = UnitHealthMax, UnitHealth,UnitIsDeadOrGhost, UnitExists

local getHealthPercent = function(unit)

	local m = UnitHealthMax(unit)

	if(m == 0) then
		return 0
	else
		return math.floor(UnitHealth(unit) / m * 100 + .5)
	end

end


alerts.controllerFactory.register("healthGlow", function(monitor, display, extra)

	local onHealthChange = function()

		if not UnitExists(extra.unit) or UnitIsDeadOrGhost(extra.unit) then

			display.hideGlow()

		else

			local health = getHealthPercent(extra.unit)

			if health <= extra.percent then
				display.showGlow()
			else
				display.hideGlow()
			end

		end
		
	end

	events.register("UNIT_HEALTH", nil, onHealthChange)
	events.register("PLAYER_TARGET_CHANGED", nil, onHealthChange)

end)
