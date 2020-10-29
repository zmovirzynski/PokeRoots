local auto_loot = {
  window = nil,
  panel = nil,
  key = "Alt+A",
  opcode = 33,
  button = nil
}

function init()
  connect(g_game, { 
      onGameStart = offline,
      onGameEnd = offline
  })
  c_a_l()
  g_keyboard.bindKeyDown(auto_loot.key, toggle)
  
  auto_loot.button = modules.client_topmenu.addRightGameToggleButton('alButton', tr('Auto-Loot') .. '('..auto_loot.key..')', '/images/topbuttons/loot', toggle)
  auto_loot.button:setOn(false)
  
  ProtocolGame.registerExtendedOpcode(auto_loot.opcode, getAlItems)
end

function c_a_l()
  auto_loot.window = g_ui.createWidget("ALWindow", modules.game_interface.getRootPanel())
  auto_loot.window:setWidth(400)
  auto_loot.window:setHeight(300)
  auto_loot.window:setText("Auto-loot")
  auto_loot.window.onClose = function(self)
    self:hide()
	auto_loot.button:setOn(false)
  end
  
  auto_loot.panel = g_ui.createWidget("Panel", auto_loot.window)
  auto_loot.panel:setId("contentsPanel")
  auto_loot.panel:fill("parent")

  auto_loot.window:hide()
end

function terminate()
    g_keyboard.unbindKeyDown(auto_loot.key, toggle)
  ProtocolGame.unregisterExtendedOpcode(auto_loot.opcode)
  disconnect(g_game, 
  { 
      --onGameStart = refresh, 
      onGameEnd = offline
  })
  --disconnect(g_game, { onGameStart = refresh})
end

function toggle()
  local player = g_game.getLocalPlayer()
  if not player then return end
  if auto_loot.window:isVisible() then
    auto_loot.window:hide()
	auto_loot.button:setOn(false)
  else
    local protocolGame = g_game.getProtocolGame()
    protocolGame:sendExtendedOpcode(auto_loot.opcode, "/items/Stones")
	auto_loot.button:setOn(true)
  end
end

function offline()
  auto_loot.window:hide()
  auto_loot.panel:destroyChildren()
end

function getAlItems(protocol, opcode, buffer)
  local player = g_game.getLocalPlayer()
  if not player then return end
  local receive = loadstring("return ".. buffer)()
  auto_loot.panel:destroyChildren()
  if receive[3] == "items" then
    local state = Protocol_read(receive)
    local type = Protocol_read(receive)
    local types = Protocol_read(receive)
    local items = Protocol_read(receive)
    local itemsAL = Protocol_read(receive)
    local sort = g_ui.createWidget("ComboBox", auto_loot.panel)
    sort:setId("sort")
    sort:addAnchor(AnchorTop, "parent", AnchorTop)
    sort:addAnchor(AnchorLeft, "parent", AnchorLeft)
    sort:setWidth(120)
    sort:setHeight(20)
    sort:setMarginTop(5)
    sort:setMarginLeft(10)
    sort:addOption(type)
    for v=1, #types do
      sort:addOption(types[v])
    end
    sort.onOptionChange = function(self)
      local protocolGame = g_game.getProtocolGame()
      protocolGame:sendExtendedOpcode(auto_loot.opcode, "/items/"..self:getText())
    end
    
    local search = g_ui.createWidget("TextEdit", auto_loot.panel)
    search:setId("search")
    search:setWidth(130)
    search:setHeight(20)
    search:addAnchor(AnchorTop, "sort", AnchorTop)
    search:addAnchor(AnchorLeft, "sort", AnchorRight)
    search:setMarginLeft(15)
	
    local searchC = g_ui.createWidget("Button", auto_loot.panel)
    searchC:setId("searchC")
    searchC:setWidth(80)
    searchC:setHeight(20)
    searchC:addAnchor(AnchorTop, "search", AnchorTop)
    searchC:addAnchor(AnchorLeft, "search", AnchorRight)
    searchC:setMarginLeft(17)
    searchC:setText("OFF")
	searchC:setTooltip("Ative o auto-loot")
	if state == 1 then searchC:setText("ON") searchC:setTooltip("Desative o auto-loot") end
	searchC.onClick = function()
      local protocolGame = g_game.getProtocolGame()
      protocolGame:sendExtendedOpcode(auto_loot.opcode, "/state/"..sort:getText())
	end

    local list = g_ui.createWidget("VerticalList", auto_loot.panel)
    list:setId("list")
    list:setHeight(110)
	list:setWidth(250)
    list:addAnchor(AnchorLeft, "parent", AnchorLeft)
    list:addAnchor(AnchorTop, "search", AnchorBottom)
	list:addAnchor(AnchorBottom, "parent", AnchorBottom)
    list:setMarginLeft(10)
    list:setMarginTop(10)
	list:setMarginBottom(30)
    list:setBackgroundColor("alpha")
    
    local listScrollbar = g_ui.createWidget("VerticalScrollBar", auto_loot.panel)
    listScrollbar:setId("listScrollbar")
    listScrollbar:setWidth(10)
    listScrollbar:addAnchor(AnchorTop, "list", AnchorTop)
    listScrollbar:addAnchor(AnchorLeft, "list", AnchorRight)
    listScrollbar:addAnchor(AnchorBottom, "list", AnchorBottom)
    listScrollbar:setMarginLeft(1)
    list:setVerticalScrollBar(listScrollbar)
    
	local list_ = {}
	
    for itemid, index in pairs(items) do
      local bar = g_ui.createWidget("FlatPanel", list)
      bar:setId("bar"..itemid)
	  bar:setHeight(30)
      local item = g_ui.createWidget("Item", bar)
      item:setId(itemid)
      item:setWidth(30)
      item:setHeight(30)
	  item:addAnchor(AnchorTop, "parent", AnchorTop)
	  item:addAnchor(AnchorLeft, "parent", AnchorLeft)
	  item:setMarginLeft(5)
      item:setItemId(index.itemid)
      item:setVirtual(true)
	  local itName = g_ui.createWidget("UIWidget", bar)
	  itName:setId("itName")
	  itName:setWidth(180)
	  itName:setHeight(20)
	  itName:addAnchor(AnchorLeft, itemid, AnchorRight)
	  itName:addAnchor(AnchorTop, "parent", AnchorTop)
	  itName:setMarginLeft(5)
	  itName:setMarginTop(5)
	  itName:setText(index.name)
      local button = g_ui.createWidget("Button", bar)
      button:setId(itemid)
      button:setWidth(20)
      button:setHeight(20)
	  button:addAnchor(AnchorTop, "parent", AnchorTop)
	  button:addAnchor(AnchorLeft, "itName", AnchorRight)
	  button:setMarginLeft(5)
	  button:setMarginTop(5)
      button:setText("+")
	  button:setTooltip("Adicione a lista do auto-loot.")
	  if isInArray(itemsAL, itemid) then
	    button:setTooltip("Remova da lista do auto-loot.")
	    button:setText("-")
	  end
	  button.onClick = function()
        local protocolGame = g_game.getProtocolGame()
        protocolGame:sendExtendedOpcode(auto_loot.opcode, itemid.."/item/"..sort:getText())
	  end
	  table.insert(list_, bar)
    end
	
	search.onTextChange = function()
      for type, index in pairs(list_) do
		index:hide()
      end
      for type, index in pairs(list_) do
		local txt = index:getChildById("itName"):getText()
		if search:getText() == txt or search:getText() == "" then
		  index:show()
		end
      end
	end
	
    local list2 = g_ui.createWidget("VerticalList", auto_loot.panel)
    list2:setId("list2")
    list2:setHeight(110)
	list2:setWidth(70)
    list2:addAnchor(AnchorLeft, "list", AnchorRight)
    list2:addAnchor(AnchorTop, "search", AnchorBottom)
	list2:addAnchor(AnchorBottom, "parent", AnchorBottom)
    list2:setMarginLeft(30)
    list2:setMarginTop(10)
	list2:setMarginBottom(30)
    list2:setBackgroundColor("alpha")
    
    local listScrollbar2 = g_ui.createWidget("VerticalScrollBar", auto_loot.panel)
    listScrollbar2:setId("listScrollbar2")
    listScrollbar2:setWidth(10)
    listScrollbar2:addAnchor(AnchorTop, "list2", AnchorTop)
    listScrollbar2:addAnchor(AnchorLeft, "list2", AnchorRight)
    listScrollbar2:addAnchor(AnchorBottom, "list2", AnchorBottom)
    listScrollbar2:setMarginLeft(1)
    list2:setVerticalScrollBar(listScrollbar2)
    
    for num, index in pairs(itemsAL) do
	  local itemid = index.itemid
      local bar = g_ui.createWidget("FlatPanel", list2)
      bar:setId("bar"..itemid)
	  bar:setHeight(30)
      local item = g_ui.createWidget("Item", bar)
      item:setId(itemid)
      item:setWidth(30)
      item:setHeight(30)
	  item:addAnchor(AnchorTop, "parent", AnchorTop)
	  item:addAnchor(AnchorLeft, "parent", AnchorLeft)
	  item:setMarginLeft(5)
      item:setItemId(tonumber(itemid))
      item:setVirtual(true)
      local button = g_ui.createWidget("Button", bar)
      button:setId(itemid)
      button:setWidth(20)
      button:setHeight(20)
	  button:addAnchor(AnchorTop, "parent", AnchorTop)
	  button:addAnchor(AnchorLeft, itemid, AnchorRight)
	  button:setMarginLeft(5)
	  button:setMarginTop(5)
      button:setText("-")
	  button:setTooltip("Remova da lista do auto-loot.")
	  button.onClick = function()
        local protocolGame = g_game.getProtocolGame()
        protocolGame:sendExtendedOpcode(auto_loot.opcode, index.id.."/item/"..sort:getText())
	  end
    end
    local _close = g_ui.createWidget("Button", auto_loot.panel)
    _close:setId("close")
    _close:setWidth(70)
    _close:setHeight(20)
    _close:addAnchor(AnchorBottom, "parent", AnchorBottom)
    _close:addAnchor(AnchorRight, "parent", AnchorRight)
    _close:setText(tr("Fechar"))
    _close.onClick = function()
      auto_loot.window:hide()
	  auto_loot.button:setOn(false)
    end
    auto_loot.window:show()
  end
  
end