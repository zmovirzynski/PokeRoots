local MensagensWindow = nil

function init()
  connect(g_game, { onGameEnd = onGameEnd })
  MensagensWindow = g_ui.displayUI('Mensagens', modules.game_interface.getRootPanel())
  MensagensWindow:hide()
  ProtocolGame.registerExtendedOpcode(90, Mensagens)  
  connect(g_game, { onGameStart = AdjustSize})
end

function AdjustSize()
	local top = (g_window.getHeight()/2) - 55
	MensagensWindow:setMarginTop(-top)
end

function terminate()
  disconnect(g_game, { onGameEnd = onGameEnd })
  ProtocolGame.unregisterExtendedOpcode(90)

  MensagensWindow:destroy()
end

function onGameEnd()
  if MensagensWindow:isVisible() then
    MensagensWindow:hide()
	end
end

function show()
    addEvent(function() g_effects.fadeIn(MensagensWindow, 350) end)
  MensagensWindow:show()
  MensagensWindow:raise()
  scheduleEvent(function() g_effects.fadeOut(MensagensWindow, 500) end, 20000)
end

function hide()
  addEvent(function() g_effects.fadeOut(MensagensWindow, 250) end)
  scheduleEvent(function() MensagensWindow:hide() end, 250)
end

local function clickOptionButton(option) 
  g_game.talk(option)
end

function Mensagens(protocol, opcode, buffer)
  local param = buffer:split('@') 
  local eventAnimation = nil

  if param[1] == "close" then
    hide()
  else
    show()
  end

  MensagensWindow:getChildById('nome'):setText(param[1])
  MensagensWindow:getChildById('img'):setImageSource("img/megaphone.png")

end