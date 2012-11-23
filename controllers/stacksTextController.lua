local addon, ns = ...

ns.controller.addTextController("STACKS", function(monitor, display, extra)
			
	display.cooldown:Hide()
	display.text:Show()

	monitor:addListener("stacksTextController", function(m)

		if m.stacks == nil or m.stacks == 0 then
			display.text:SetText("")
		else
			display.text:SetText(m.stacks)
		end

	end)

end)
