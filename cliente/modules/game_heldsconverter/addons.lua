function hide()
  addonWindow:hide()
  addonWindow2:hide()
  addonWindow3:hide()
  addonWindow4:hide()
  addonWindow5:hide()
  addonWindow6:hide()
  addonWindow7:hide()
end

function init()
  connect(g_game, 'onTextMessage', onClick)
  addonWindow = g_ui.displayUI('addons')
  addonWindow:hide()
  addonWindow2 = g_ui.displayUI('addons2')
  addonWindow2:hide()
  addonWindow3 = g_ui.displayUI('addons3')
  addonWindow3:hide()
  addonWindow4 = g_ui.displayUI('addons4')
  addonWindow4:hide()
  addonWindow5 = g_ui.displayUI('addons5')
  addonWindow5:hide()
  addonWindow6 = g_ui.displayUI('addons6')
  addonWindow6:hide()
  addonWindow7 = g_ui.displayUI('addons7')
  addonWindow7:hide()
end

function terminate()
  disconnect(g_game, 'onTextMessage', onClick)
end

function onClick(mode, text)
  if mode == MessageModes.Failure then
    if text:find('HeldConverter_P1') then
      addonWindow:show()
    end
  end
  if mode == MessageModes.Failure then
    if text:find('HeldConverter_P2') then
      addonWindow2:show()
    end
  end
  if mode == MessageModes.Failure then
    if text:find('HeldConverter_P3') then
      addonWindow3:show()
    end
  end
  if mode == MessageModes.Failure then
    if text:find('HeldConverter_P4') then
      addonWindow4:show()
    end
  end
  if mode == MessageModes.Failure then
    if text:find('HeldConverter_P5') then
      addonWindow5:show()
    end
  end
  if mode == MessageModes.Failure then
    if text:find('HeldConverter_P6') then
      addonWindow6:show()
    end
  end
  if mode == MessageModes.Failure then
    if text:find('HeldConverter_P7') then
      addonWindow7:show()
    end
  end
end