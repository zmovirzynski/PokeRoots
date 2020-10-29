function init()
  connect(g_game, 'onTextMessage', onClick)
  connect(g_game, 'onGameEnd', onGameEnd)
  channelsWindow = g_ui.displayUI('tplistwindow4')
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

function castelia()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h castelia")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Castelia'), tr("Tem certeza de que deseja teleportar-se para a cidade de Castelia?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function golden()
  if acceptWindow then
    return true
  end

  local acceptFunc = function()
    g_game.talk("!h Golden")
	acceptWindow:destroy()
	acceptWindow = nil
  end
  
  local cancelFunc = function() acceptWindow:destroy() acceptWindow = nil end

  acceptWindow = displayGeneralBox(tr('Pokémon Teleport: Golden'), tr("Tem certeza de que deseja teleportar-se para a cidade de Golden?"),
  { { text=tr('Sim'), callback=acceptFunc },
    { text=tr('Não'), callback=cancelFunc },
    anchor=AnchorHorizontalCenter }, acceptFunc, cancelFunc)
  return true
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function onClick(mode, text)
  if mode == MessageModes.Failure then
    if text:find('#PAG_FOUR4#') then
      channelsWindow:show()
    end
  end
end