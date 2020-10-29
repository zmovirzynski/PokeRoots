
local pokemoves = nil
local namesAtks = ''
local icons = {}

function init()

	connect(g_game, { 
		onGameEnd = offline,
		onTextMessage = getParams 
	})
	
    connect(LocalPlayer, { onLevelChange = onLevelChange })
   
	pokemoves = g_ui.loadUI('pokemoves.otui', modules.game_interface.getRootPanel())
	pokemoves:hide()
	
	createIcons()
end

function terminate()
	disconnect(g_game, { 
		onGameEnd = offline,
		onTextMessage = getParams 
	})
	disconnect(LocalPlayer, { onLevelChange = onLevelChange })
	
	pokemoves:destroy()
end

function offline()
	pokemoves:hide()
end

function animationIn(width)
	local _width = 0
	pokemoves:hide()	
	pokemoves.animation = cycleEvent(function()
		pokemoves:show()
		pokemoves:setWidth(_width+6)
		_width = _width+20	
		if _width > width then
			pokemoves:setWidth(width+2)
			removeEvent(pokemoves.animation)
			pokemoves.animation = nil
		end
	end, 25)
end


function createIcons()
	local d = 38
	for i = 1, 12 do
		local icon = g_ui.createWidget('SpellIcon', pokemoves)
		local progress = g_ui.createWidget('SpellProgress', pokemoves) 
		icon:setId('Icon'..i)  
		progress:setId('Progress' ..i)
		icons['Icon'..i] = {icon = icon, progress = progress, dist = (i == 1 and 5 or i == 2 and 38 or d + ((i-2)*34)), event = nil}
		icon:setMarginTop(icons['Icon'..i].dist)
		icon:setMarginLeft(4)
		progress:fill(icon:getId())
		progress.onClick = function() g_game.talk('m'..i) end
	end
end

function destroyIcons()
	for i = 1, 12 do
		icons['Icon'..i].icon:destroy()
		icons['Icon'..i].progress:destroy()
	end                                
	cleanEvents()
	icons = {}
end

function cleanEvents(icon)
	local e = nil
	if icon then
		e = icons[icon] 
		if e and e.event ~= nil then
			removeEvent(e.event)
			e.event = nil
		end
	else
		for i = 1, 12 do
			e = icons['Icon'..i]
			cleanEvents('Icon'..i)
			e.progress:setPercent(100)
			e.progress:setText("")
		end
	end
end

function hide()	
	cleanEvents()
	pokemoves:hide()
end

function show()
	pokemoves:show()
end

-- function onLevelChange(localPlayer, value, percent)
	-- if not pokemoves:isVisible() then return end
	-- g_game.talk("/reloadCDs")
-- end

function getParams(mode, text)
	if not g_game.isOnline() then return end
	if mode == MessageModes.Failure then 
		if string.find(text, '12//,') then
			if string.find(text, 'hide') then hide() else  show() end
		elseif string.find(text, '12|,') then
			atualizarCDs(text)
		elseif string.find(text, '12&,') then
			FixTooltip(text)
		end
	end
end

function atualizarCDs(text)
	if not g_game.isOnline() then return end
	if not pokemoves:isVisible() then return end 
	local t = text:explode(",")
	table.remove(t, 1)   
	for i = 1, 12 do
		local t2 = t[i]:explode("|")
		barChange(i, tonumber(t2[1]), tonumber(t2[2]), tonumber(t2[3]))
	end 
end

function barChange(ic, num, lvl, lvlPoke)
	if not g_game.isOnline() then return end
	if not pokemoves:isVisible() then return end 
	
	local icon = icons['Icon'..ic].icon
	local progress = icons['Icon'..ic].progress
   
	if not progress:getTooltip() then return end
	local player = g_game.getLocalPlayer()
	
    local pathOn = "moves_icon/"..icons['Icon'..ic].spellName.."_on.png"
    icon:setImageSource(pathOn)
	
	if num and num >= 1 then   
		cleanEvents('Icon'..ic)
		changePercent(progress, icon, 100/num, num, true)      
	else   
		if (lvlPoke and lvlPoke < lvl) or player:getLevel() < lvl then
			progress:setPercent(0)
			progress:setText('L.'.. lvl)
			progress:setColor('#FF0000')
		else
			progress:setPercent(100)
			progress:setText("") 
		end
	end    
end

function changePercent(progress, icon, perc, num, init)
	if not pokemoves:isVisible() then return end      
	if init then
		progress:setPercent(0)
	else
		progress:setPercent(progress:getPercent()+perc)
	end
	if progress:getPercent() >= 100 then 
		progress:setText("")
		return
	end
	progress:setText(num)
	icons[icon:getId()].event = scheduleEvent(function() changePercent(progress, icon, perc, num-1) end, 1000)
end

function FixTooltip(text)

   if not text then text = namesAtks else namesAtks = text end 
   
   local t2 = text:explode(",")
   local count = 0
   for j = 2, 13 do
       local ic = icons['Icon'..(j-1)]
       ic.icon:setMarginLeft(ic.dist+2)
       ic.icon:setMarginTop(5)
       if t2[j] == 'n/n' then    
          ic.icon:hide()      
          count = count+1
       else
          ic.icon:show()
		    if t2[j]:find("- ") then
			   ic.progress:setTooltip("Mega Evoluir")	
			   ic.spellName = "Mega Evoluir"
			elseif t2[j]:find("Sketch") then
			   ic.progress:setTooltip("Sketch")	
			   ic.spellName = "Sketch"
			else
               ic.progress:setTooltip(t2[j]) 
			   ic.spellName = t2[j]
			end
          ic.progress:setVisible(true)
       end
   end
   if count > 0 and count ~= 12 then
	  animationIn(416 - (count*34))
   elseif count == 12 then
      pokemoves:setWidth(40)
      local p = icons['Icon1'].progress
      p:setTooltip(false)
      p:setVisible(false)
   end                
end