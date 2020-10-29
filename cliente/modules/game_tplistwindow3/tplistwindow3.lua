function init()
  connect(g_game, 'onTextMessage', onClick)
  connect(g_game, 'onGameEnd', onGameEnd)
  channelsWindow = g_ui.displayUI('tplistwindow3')
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

function orre()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h Orre")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Orre'), tr("Tem certeza de que deseja teleportar-se para a cidade de Orre?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function mahogany()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h Mahogany")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Mahogany'), tr("Tem certeza de que deseja teleportar-se para a cidade de Mahogany?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function newbark()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h Newbark")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Newbark'), tr("Tem certeza de que deseja teleportar-se para a cidade de Newbark?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function olivine()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h Olivine")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Olivine'), tr("Tem certeza de que deseja teleportar-se para a cidade de Olivine?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function violet()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h Violet")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Violet'), tr("Tem certeza de que deseja teleportar-se para a cidade de Violet?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function goldenrod()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h Goldenrod")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Goldenrod'), tr("Tem certeza de que deseja teleportar-se para a cidade de Goldenrod?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function canavale()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h Canavale")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Canavale'), tr("Tem certeza de que deseja teleportar-se para a cidade de Canavale?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function larosse()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h Larosse")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Larosse'), tr("Tem certeza de que deseja teleportar-se para a cidade de Larosse?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function onClick(mode, text)
  if mode == MessageModes.Failure then
    if text:find('#PAG_THREE3#') then
      channelsWindow:show()
    end
  end
end