UIGameMap = extends(UIMap)
local TVBLOCK = false
function UIGameMap.create()
  local gameMap = UIGameMap.internalCreate()
  gameMap:setKeepAspectRatio(true)
  gameMap:setVisibleDimension({width = 15, height = 11})
  gameMap:setDrawLights(true)
  return gameMap
end

function setTVBLOCK(buffer)
	if buffer == "sim" then
	   TVBLOCK = true
	else 
	   TVBLOCK = false
	end
end

function getTVBlock()
   return TVBLOCK
end

function UIGameMap:onDragEnter(mousePos)
  local tile = self:getTile(mousePos)
  if not tile then return false end

  local thing = tile:getTopMoveThing()
  if not thing then return false end

  self.currentDragThing = thing

  g_mouse.pushCursor('target')
  self.allowNextRelease = false
  return true
end

function UIGameMap:onDragLeave(droppedWidget, mousePos)
  self.currentDragThing = nil
  self.hoveredWho = nil
  g_mouse.popCursor('target')
  return true
end

function UIGameMap:onDrop(widget, mousePos)
  if not self:canAcceptDrop(widget, mousePos) then return false end
	
  if g_game.getLocalPlayer():getHealthPercent() <= 0 then return false end
	
  local tile = self:getTile(mousePos)
  if not tile then return false end

  local thing = widget.currentDragThing
  local toPos = tile:getPosition()

  local thingPos = thing:getPosition()
  if thingPos.x == toPos.x and thingPos.y == toPos.y and thingPos.z == toPos.z then return false end

  if thing:isItem() and thing:getCount() > 1 then
    modules.game_interface.moveStackableItem(thing, toPos)
  else
    g_game.move(thing, toPos, 1)
  end

  return true
end

function UIGameMap:onMousePress()
  if not self:isDragging() then
    self.allowNextRelease = true
  end
end

function UIGameMap:onMouseRelease(mousePosition, mouseButton)
	
  --if TVBLOCK then return false end	
	
  if not self.allowNextRelease then
    return true
  end

  local autoWalkPos = self:getPosition(mousePosition)

  -- happens when clicking outside of map boundaries
  if not autoWalkPos then return false end

  local localPlayerPos = g_game.getLocalPlayer():getPosition()
  if autoWalkPos.z ~= localPlayerPos.z then
    local dz = autoWalkPos.z - localPlayerPos.z
    autoWalkPos.x = autoWalkPos.x + dz
    autoWalkPos.y = autoWalkPos.y + dz
    autoWalkPos.z = localPlayerPos.z
  end

  local lookThing
  local useThing
  local creatureThing
  local multiUseThing
  local attackCreature

  local tile = self:getTile(mousePosition)
  if tile then
    lookThing = tile:getTopLookThing()
    useThing = tile:getTopUseThing()
    creatureThing = tile:getTopCreature()
  end

  local autoWalkTile = g_map.getTile(autoWalkPos)
  if autoWalkTile then
    attackCreature = autoWalkTile:getTopCreature()
  end
  
  local ret = modules.game_interface.processMouseAction(mousePosition, mouseButton, autoWalkPos, lookThing, useThing, creatureThing, attackCreature)
  if ret then
	self.allowNextRelease = false
  end

  return ret
end

function UIGameMap:canAcceptDrop(widget, mousePos)
  if not widget or not widget.currentDragThing then return false end

  local children = rootWidget:recursiveGetChildrenByPos(mousePos)
  for i=1,#children do
    local child = children[i]
    if child == self then
      return true
    elseif not child:isPhantom() then
      return false
    end
  end

  error('Widget ' .. self:getId() .. ' not in drop list.')
  return false
end
