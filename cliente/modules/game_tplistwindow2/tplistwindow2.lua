function init()
  connect(g_game, 'onTextMessage', onClick)
  connect(g_game, 'onGameEnd', onGameEnd)
  channelsWindow = g_ui.displayUI('tplistwindow2')
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

function cinnabar()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h cinnabar")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Cinnabar'), tr("Tem certeza de que deseja teleportar-se para a cidade de Cinnabar?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function pallet()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h pallet")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Pallet'), tr("Tem certeza de que deseja teleportar-se para a cidade de Pallet?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function snow()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h snow")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Snow'), tr("Tem certeza de que deseja teleportar-se para a cidade de Snow?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function azalea()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h Azalea")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Azalea'), tr("Tem certeza de que deseja teleportar-se para a cidade de Azalea?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function blackthorn()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h blackthorn")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Blackthorn'), tr("Tem certeza de que deseja teleportar-se para a cidade de Blackthorn?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function cherrygrove()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h cherrygrove")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Cherrygrove'), tr("Tem certeza de que deseja teleportar-se para a cidade de Cherrygrove?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function cianwood()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h cianwood")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Cianwood'), tr("Tem certeza de que deseja teleportar-se para a cidade de Cianwood?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function ecruteak()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h ecruteak")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Ecruteak'), tr("Tem certeza de que deseja teleportar-se para a cidade de Ecruteak?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function onClick(mode, text)
  if mode == MessageModes.Failure then
    if text:find('#PAG_TWO2#') then
      channelsWindow:show()
    end
  end
end