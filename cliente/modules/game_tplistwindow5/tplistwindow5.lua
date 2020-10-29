function init()
  connect(g_game, 'onTextMessage', onClick)
  connect(g_game, 'onGameEnd', onGameEnd)
  channelsWindow = g_ui.displayUI('tplistwindow5')
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


function onClick(mode, text)
  if mode == MessageModes.Failure then
    if text:find('#PAG_FIVE5#') then
      channelsWindow:show()
    end
  end
end