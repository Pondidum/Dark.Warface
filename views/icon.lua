local addon, ns = ...
local core = Dark.core

ns.views.addView("icon", function(name, parent)

	local button = CreateFrame("Button", name, parent, "ActionButtonTemplate")

	button.glow = CreateFrame("Frame", nil, button, "ActionBarButtonSpellActivationAlert")
	button.icon  = _G[name.."Icon"]
	button.cooldown = _G[name.."Cooldown"]
	button.text = core.ui.createFont(button, core.fonts.normal, 18, 'OUTLINE')

	core.style.addShadow(button)
	core.style.actionButton(button)

	button:RegisterForClicks(nil);
	button:EnableMouse(false)

	button.text:SetAllPoints(button)
	button.text:SetJustifyH("CENTER")


	button.glow:SetWidth(button:GetWidth() * 1.4)
	button.glow:SetHeight(button:GetHeight() * 1.4)
	button.glow:SetPoint("CENTER", button, "CENTER", 0 ,0)

	button.glow.animOut:SetScript("OnFinished", function(self) button.glow:Hide() end)

	button.showGlow = function()
		
		if button.glow.animOut:IsPlaying() then
			button.glow.animOut:Stop()  
		end
		
		if not button.glow:IsVisible() then   
			button.glow.animIn:Play()    
		end
		
	end

	button.hideGlow = function()
		
		if button.glow.animIn:IsPlaying() then
			button.glow.animIn:Stop()  
		end
		
		if button.glow:IsVisible() then     
			button.glow.animOut:Play()  
		end
		
		
	end

	return button

end)