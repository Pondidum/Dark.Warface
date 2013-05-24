local addon, ns = ...
local core = Dark.core
local ui = core.ui
local style = core.style

local alertView = {

	new = function(name, parent)

		local button = CreateFrame("Button", name, parent, "ActionButtonTemplate")

		local glow = CreateFrame("Frame", nil, button, "ActionBarButtonSpellActivationAlert")
		local icon  = _G[name.."Icon"]
		local cooldown = _G[name.."Cooldown"]
		local text = core.ui.createFont(button, core.fonts.normal, 18, 'OUTLINE')

		core.style.actionButton(button)

		button:RegisterForClicks(nil);
		button:EnableMouse(false)

		text:SetAllPoints(button)
		text:SetJustifyH("CENTER")

		glow:SetWidth(button:GetWidth() * 1.4)
		glow:SetHeight(button:GetHeight() * 1.4)
		glow:SetPoint("CENTER", button, "CENTER", 0 ,0)

		glow.animOut:SetScript("OnFinished", function(self) glow:Hide() end)

		button.showGlow = function()
			
			if glow.animOut:IsPlaying() then
				glow.animOut:Stop()  
			end
			
			if not glow:IsVisible() then   
				glow.animIn:Play()    
			end
			
		end

		button.hideGlow = function()
			
			if glow.animIn:IsPlaying() then
				glow.animIn:Stop()  
			end
			
			if glow:IsVisible() then     
				glow.animOut:Play()  
			end
			
		end

		button.showText = function()
			text:Show()
		end

		button.hideText = function()
			text:Hide()
		end
		
		button.setText = function(value)
			text:SetText(value)
		end

		button.setIcon = function(value)
			icon:SetTexture(value)
		end

		button.showCooldown = function()
			cooldown:Show()
		end

		button.hideCooldown = function()
			cooldown:Hide()
		end

		button.setCooldown = function(start, duration, active, stacks, maxStacks)
			CooldownFrame_SetTimer(cooldown, start, duration, active, stacks, maxStacks)
		end

		return button

	end
}

ns.alerts.alertView = alertView
