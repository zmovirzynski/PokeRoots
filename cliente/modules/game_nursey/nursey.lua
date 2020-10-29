function init()
  connect(g_game, { onGameEnd = onGameEnd })
	  ProtocolGame.registerExtendedOpcode(176, function(protocol, opcode, buffer) show() end)
  deadWindow = g_ui.displayUI('nursey')
  deadWindow:hide()
end

function terminate()
  disconnect(g_game, { onGameEnd = onGameEnd })
  deadWindow:destroy()
end

function onGameEnd()
  if deadWindow:isVisible() then
    deadWindow:hide()
	end
end

function show()
    addEvent(function() g_effects.fadeIn(deadWindow, 350) end)
  deadWindow:show()
  deadWindow:raise()
  scheduleEvent(function() g_effects.fadeOut(deadWindow, 500) end, 5000)
end

function hide()
  addEvent(function() g_effects.fadeOut(deadWindow, 250) end)
  scheduleEvent(function() deadWindow:hide() end, 250)
end