function init()
  connect(g_game, 'onTextMessage', onClick)
  connect(g_game, 'onGameEnd', onGameEnd)
  channelsWindow = g_ui.displayUI('tplistwindow1')
  channelsWindow:hide()
end

function terminate()
  disconnect(g_game, 'onTextMessage', onClick)
  disconnect(g_game, 'onGameEnd', onGameEnd)

  channelsWindow:destroy()
end

function onGameEnd()
  if channelsWindow:isVisible() then
    channelsWindow:hide()
  end
end

function show()
  channelsWindow:show()
  channelsWindow:raise()
  channelsWindow:focus()
end

function hide()
	if channelsWindow:isVisible() then
	  channelsWindow:hide()
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function pewter()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h pewter")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Pewter'), tr("Tem certeza de que deseja teleportar-se para a cidade de Pewter?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function saffron()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h saffron")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Saffron'), tr("Tem certeza de que deseja teleportar-se para a cidade de Saffron?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function lavender()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h lavender")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Lavender'), tr("Tem certeza de que deseja teleportar-se para a cidade de Lavender?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function fuchsia()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h fuchsia")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Fuchsia'), tr("Tem certeza de que deseja teleportar-se para a cidade de Fuchsia?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function viridian()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h viridian")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Viridian'), tr("Tem certeza de que deseja teleportar-se para a cidade de Viridian?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function cerulean()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h cerulean")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Cerulean'), tr("Tem certeza de que deseja teleportar-se para a cidade de Cerulean?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function celadon()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h celadon")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Celadon'), tr("Tem certeza de que deseja teleportar-se para a cidade de Celadon?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function vermilion()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h vermilion")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Vermilion'), tr("Tem certeza de que deseja teleportar-se para a cidade de Vermilion?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function onClick(mode, text)
  if mode == MessageModes.Failure then
    if text:find('#PAG_ONE1#') then
      channelsWindow:show()
    end
  end
end