local D, S, E = unpack(select(2, ...))

local glowHandlers = {

	NONE = function(button, extra, spellName)
		button.hideGlow()
	end,

	ONACTIVE = function(button, extra, spellName) 

		local auraName = UnitAura("player", spellName)
		
		if auraName then
			button.showGlow()			
		else
			button.hideGlow()
		end 

	end,

	READY = function(button, extra, spellName)

	end,

	STACKS = function(button, extra, spellName)

		local auraName, auraRank, auraTexture, auraCount, auraDispel, auraDuration, auraExpires = UnitAura("player", spellName)

		if auraName and auraCount >= extra.stacks then
			button.showGlow()			
		else
			button.hideGlow()
		end

	end,

}

local textHandlers = {
	
	NONE = function(button, extra, spellName)

		button.cooldown:Hide()
		button.text:Hide()

	end,

	CDANDACTIVE = function(button, extra, spellName)

		button.text:Hide()
		
		local auraName, auraRank, auraTexture, auraCount, auraDispel, auraDuration, auraExpires = UnitAura("player", spellName)

		if auraName then
			
			local start = auraExpires - auraDuration
			CooldownFrame_SetTimer(button.cooldown, start, auraDuration, 1, auraCount, auraCount)
			
		else
			
			local start, duration, enable, charges, maxCharges = GetSpellCooldown(spellName)
			CooldownFrame_SetTimer(button.cooldown, start, duration, enable, charges, maxCharges)
			
		end 

	end,

	STACKS = function(button, extra, spellName)

		button.cooldown:Hide()
		button.text:Show()

		local auraName, auraRank, auraTexture, auraCount, auraDispel, auraDuration, auraExpires = UnitAura("player", spellName)

		if auraCount ~= nil and auraCount > 0 then
			button.text:SetText(auraCount)
		else
			button.text:SetText("")	
		end

	end,
}

local typeHandlers = {
	
	spell = function(button, value) 
	
		local spellName, spellRank, spellTexture = GetSpellInfo(value)
		button.icon:SetTexture(spellTexture)

		return spellName
	end,
	
	macro = function(button, value) 

		local macroSpell = GetMacroSpell(value)
		

		if macroSpell == nil then

			local macroItem = GetMacroItem(value)

			if macroItem then

				local item = GetItemSpell(macroItem)		
				local macroName, macroTexture = GetMacroInfo(value)
				
				button.icon:SetTexture(macroTexture)
				return item
				
			end

		end

		local spellName, spellRank, spellTexture = GetSpellInfo(macroSpell)
		button.icon:SetTexture(spellTexture)
	
		return spellName
	
	end,

	item = function(button, value)

		local texture = GetInventoryItemTexture("player", value)
		
		button.icon:SetTexture(texture)
		
	end,
}

local EXTRA_DEFAULT = {
	glow = "ONACTIVE",
	text = "CDANDACTIVE"
}


local DarkCD = {
	
	new = function(name, parent, extra)

		local button = CreateFrame("Button", name, parent,"ActionButtonTemplate")
	
		button.glow = CreateFrame("Frame", name .. "Glow", button, "ActionBarButtonSpellActivationAlert")
		button.icon  = _G[name.."Icon"]
		button.cooldown = _G[name.."Cooldown"]
		button.text = D.CreateFontString(button, S.fonts.normal, 18, 'OUTLINE')

		
		D.CreateBackground(button)
		D.CreateShadow(button)
		D.Style(button)

		local pushed = button.GetPushedTexture and button:GetPushedTexture() or nil
		pushed:SetTexture(nil)

		button:RegisterForDrag("LeftButton", "RightButton");
		button:RegisterForClicks(nil);

		for key, value in pairs(extra or {}) do
			button[key](button, unpack(value))
		end	

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

		button.apply = function(type, data, extra)

			button:SetAttribute("type", type)
			button:SetAttribute(type,  data)
			button:SetAttribute("extra", extra)

		end


		button:SetScript("OnDragStart", function(self) 
			
			if InCombatLockdown() or not IsShiftKeyDown() then
				return
			end

			local type = self:GetAttribute("type")
			local id = self:GetAttribute(type)
			
			if id then
				
				if type == "spell" then
					PickupSpell(id)
				elseif type == "macro" then
					PickupMacro(id)  
				end
				
				self:SetAttribute("type", nil)
				self:SetAttribute(type, nil)
				button:SetAttribute("extra", nil)
				
			end
			
				
		end)


		button:SetScript("OnReceiveDrag", function(self)
				
				local type, data, subType, subData = GetCursorInfo()
				
				if type == "spell" then
					button.apply(type,  subData)
				else
					button.apply(type, data)
				end
				
				ClearCursor()
				
		end)

		button:SetScript("OnUpdate", function(self, elapsed)
			
			
			local type = button:GetAttribute("type")
			local extra = button:GetAttribute("extra") or EXTRA_DEFAULT
			
			if type == nil or type == "" then
				
				button.icon:SetTexture(nil)
				button.cooldown:Hide()
				
				return 
				
			end
			
			local value = button:GetAttribute(type)
			local cdName = typeHandlers[type](button, value)

			if cdName == nil or cdName == "" then
				extra.glow = "NONE"
			end

			textHandlers[extra.text](button, extra, cdName)
			glowHandlers[extra.glow](button, extra, cdName)
			
		end)

		return button

	end,
}



local ButtonBar = {
	
	new = function(config)

		local name = "DarkuiWarface" .. config.name
		local container = CreateFrame("Frame", name, DarkuiFrame)
		D.LayoutEngine:Init(container)

		container.AutoSize = true 
		container.MarginLeft = 10
		container.MarginRight = 10
		container.Direction = config.direction or "HORIZONTAL"

		for i, spell in ipairs(config.items) do
			
			local f = DarkCD.new(name .. i, container, config.itemConfig)
			f.apply(spell.type, spell.id, spell.extra)

			container:Add(f)
		end

		for i, v in ipairs(config.anchors) do
			container:SetPoint(unpack(v))
		end

	end,

}


if D.Player.name == "Darkend" then

	local shortCds = {
		name = "ShortCds",
		items = {
			[1] = { type = "spell", id = 8042 },
			[2] = { type = "spell", id = 60103 },
			[3] = { type = "spell", id = 17364 },
			[4] = { type = "spell", id = 51530, extra = { glow = "STACKS", stacks = 5, text = "STACKS" } },
			[5] = { type = "macro", id = 41 },
		},
		anchors = {
			{"CENTER", DarkuiFrame, "CENTER", 0, -100}
		},
		itemConfig = {
			SetSize = {32, 32}
		}
	}

	local longCds = {
		name = "LongCds",
		items = {
			--[1] = { type = "spell", id = 96228 },
			[1] = { type = "macro", id = 10 },
			[2] = { type = "macro", id = 47 },
			[3] = { type = "macro", id = 45 },
			[4] = { type = "spell", id = 114049 },
		},
		anchors = {
			{"CENTER", DarkuiFrame, "CENTER", 0, -140}
		},
		itemConfig = {
			SetSize = {27, 27}
		}, 
	}

	ButtonBar.new(shortCds)
	ButtonBar.new(longCds)
end
