local image = nil
local cardinalmsgWindow = nil
local cardinalmsg1 = nil

function init()

  connect(g_game, { onGameEnd = onGameEnd })

  cardinalmsgWindow = g_ui.displayUI('cardinalmsg')
  cardinalmsgWindow:hide()
  cardinalmsgWindow:setHeight(139)
  cardinalmsgWindow:setWidth(508)
  ProtocolGame.registerExtendedOpcode(10, function(protocol, opcode, buffer)
  local strings = string.explode(buffer, '-')
  
  show(strings[1], strings[2])

  end)
end

function terminate()
  disconnect(g_game, { onGameEnd = onGameEnd })
  ProtocolGame.unregisterExtendedOpcode(10)
  
  cardinalmsgWindow:destroy()
end

function onGameEnd()
  if cardinalmsgWindow:isVisible() then
    cardinalmsgWindow:hide()
  end
end

function show(image)

	if image == "false" then
			hide()
		return true
	end

	if not cardinalmsgWindow:isVisible() then
		addEvent(function() g_effects.fadeIn(cardinalmsgWindow, 250) end)
	end
	
  cardinalmsgWindow:show()
  cardinalmsgWindow:raise()
  cardinalmsgWindow:focus()
  cardinalmsgWindow:setImageSource('imagens/'..image..'.png') 
end

function hide()
  addEvent(function() g_effects.fadeOut(cardinalmsgWindow, 250) end)
  scheduleEvent(function() cardinalmsgWindow:hide() end, 250)
end
