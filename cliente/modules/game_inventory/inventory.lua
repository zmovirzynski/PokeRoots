function init()
  g_keyboard.bindKeyDown('Ctrl+I', toggle)
  inventoryButton = modules.client_topmenu.addRightGameToggleButton('inventoryButton', tr('Inventory') .. ' (Ctrl+I)', '/images/topbuttons/inventory', toggle)
  inventoryButton:setWidth(29)
  inventoryButton:setOpacity(0.5)
end

function terminate()
  inventoryButton:destroy()
  g_keyboard.unbindKeyDown('Ctrl+I')
end

function toggle()
  g_game.open(g_game.getLocalPlayer():getInventoryItem(3))
end

function getInventoryButton()
  return inventoryButton
end
