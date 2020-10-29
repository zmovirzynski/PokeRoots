local janelaWindow = nil
local pokeBarWindow = nil
local pokeBarButton = nil
local barList = {}
local barVar = nil
 
function init()
   connect(g_game, { onGameStart = online,
                      onGameEnd = offline})
   janelaWindow = g_ui.displayUI('janela.otui')
   pokeBarButton = modules.client_topmenu.addRightGameToggleButton('pokeBarButton', tr('Poke Bar') .. ' ', '/images/topbuttons/bar', toggle)
   pokeBarButton:setWidth(25)
   pokeBarButton:setOn(false)
   pokeBarWindow = g_ui.displayUI('pokebar',  modules.game_interface.getRightPanel())
 
   pokeBarWindow:move(250,50)
   pokeBarWindow:hide()
   janelaWindow:hide()
 
   ProtocolGame.registerExtendedOpcode(160, receive)
   connect(g_game, 'onTextMessage', portrait)
end
 
function portrait(mode, text)
    if not g_game.isOnline() then return end
    if mode == MessageModes.Failure then
        local t = text:explode(",")
        table.remove(t, 1)
       
        if string.find(text, 'p#') then
            for i = 6, 1, -1 do
                barVar = #t
                pokeBarWindow:setHeight((44*#t))
                if i <= #t then
                    local t2 = t[i]:explode("|")
                    pokeBarWindow:getChildById('slot'..i):setVisible(true)
                    pokeBarWindow:getChildById('slot'..i):setItemId(tonumber(t2[1]))
                    pokeBarWindow:getChildById('bar'..i).onClick = function() g_game.talk('!@pokebar@ '..tonumber(t2[3])) end
                    pokeBarWindow:getChildById('L'..i):setColor("#FFFF00")
                    pokeBarWindow:getChildById('bar'..i):setImageSource("bar.png")
                    pokeBarWindow:getChildById('bar'..i):setVisible(true)
                    pokeBarWindow:getChildById('B'..i):setVisible(true)
                    receive(i, t2[2], tonumber(t2[4]), tonumber(t2[5]), tonumber(t2[6]))
                else
                    pokeBarWindow:getChildById('slot'..i):setItemId(3283)
                    pokeBarWindow:getChildById('slot'..i):setVisible(false)
                    pokeBarWindow:getChildById('bar'..i):setVisible(false)
                    pokeBarWindow:getChildById('B'..i):setVisible(false)
                    pokeBarWindow:getChildById('bar'..i).onClick = function()  end
                    receive(i, "", 0, 0, 0)
                end
            end
        elseif string.find(text, 'pGS') then
            local t2 = t[1]:explode("|")
            lifeBarAtual(tonumber(t2[2]), tonumber(t2[1]), t2[3])
        elseif string.find(text, 'KGT') then
                local t2 = t[1]:explode("|")
                    levelBarAtual(t2[1], 0)
        end
    end
end
 
function levelBarAtual(i)
    pokeBarWindow:getChildById('bar'..i):setImageSource("bar1.png")
    pokeBarWindow:getChildById('L'..i):setColor("black")
end
 
function lifeBarAtual(i, hp)
    color = '#'
    pokeBarWindow:getChildById('HP'..i):setBackgroundColor("#ff0000")
    if tonumber(hp) == 0 then
        pokeBarWindow:getChildById('HP'..i):setText("Desmaiado")
        pokeBarWindow:getChildById('HP'..i):setPercent(100);
        pokeBarWindow:getChildById('HP'..i):setBackgroundColor("#202020")
        pokeBarWindow:getChildById('L'..i):setColor("gray")
        pokeBarWindow:getChildById('bar'..i):setImageSource("bar2.png")
    else
        color = color..string.format("%.2x",255-math.ceil(hp)*2.5)..string.format("%.2x",math.ceil(hp)*2.5)..string.format("%.2x",0)
               
        pokeBarWindow:getChildById('HP'..i):setBackgroundColor(color)
        if tonumber(hp) == -1 then
            pokeBarWindow:getChildById('HP'..i):setPercent(100);
            pokeBarWindow:getChildById('HP'..i):setText(string.format( "%3d %%", 100 ) ) ;
        else
            pokeBarWindow:getChildById('HP'..i):setPercent(hp);
            pokeBarWindow:getChildById('HP'..i):setText(hp.."%");
        end
    end
end
 
function receive(i, name, hp, boost)
    color = '#'
    pokeBarWindow:getChildById('L'..i):setText(name)
    pokeBarWindow:getChildById('B'..i):setText("+"..boost)
    pokeBarWindow:getChildById('HP'..i):setBackgroundColor("#ff0000")
    if tonumber(hp) == 0 then
        pokeBarWindow:getChildById('HP'..i):setText("Desmaiado")
        pokeBarWindow:getChildById('HP'..i):setPercent(100);
        pokeBarWindow:getChildById('HP'..i):setBackgroundColor("#202020")
        pokeBarWindow:getChildById('L'..i):setColor("gray")
        pokeBarWindow:getChildById('bar'..i):setImageSource("bar2.png")
    else
        color = color..string.format("%.2x",255-math.ceil(hp)*2.5)..string.format("%.2x",math.ceil(hp)*2.5)..string.format("%.2x",0)
               
        pokeBarWindow:getChildById('HP'..i):setBackgroundColor(color)
        if tonumber(hp) == -1 then
            pokeBarWindow:getChildById('HP'..i):setPercent(100);
            pokeBarWindow:getChildById('HP'..i):setText(string.format( "%3d %%", 100 ) ) ;
        else
            pokeBarWindow:getChildById('HP'..i):setPercent(hp);
            pokeBarWindow:getChildById('HP'..i):setText(hp.."%");
        end
    end
   
end
 
function terminate()
  disconnect(g_game, { onGameStart = online,
                         onGameEnd = offline})
  pokeBarWindow:destroy()
  janelaWindow:destroy()
  disconnect(g_game, 'onTextMessage', portrait)
end
 
function toggle()
  if pokeBarButton:isOn() then
    pokeBarWindow:hide()
    pokeBarButton:setOn(false)
  else
    pokeBarWindow:show()
    pokeBarButton:setOn(true)
  end
end
 
function online()
    if g_game.isOnline() then
        pokeBarWindow:show()
        janelaWindow:show()
        pokeBarButton:setOn(true)
    end
end
 
function offline()
    pokeBarWindow:hide()
    janelaWindow:hide()
    pokeBarButton:setOn(false)
end
 
function onMoveBottomPanelHoverChange(widget)
  if widget:isHovered() and not g_mouse.isPressed(MouseLeftButton) then
    addEvent(function() g_effects.fadeIn(widget, 250) end)
  elseif not widget:isHovered() and not g_mouse.isPressed(MouseLeftButton) then
    addEvent(function() g_effects.fadeOut(widget, 250) end)
  end
end
 
function getMoveBottomPanel()
  return gameRootPanel:recursiveGetChildById('moveBottomPanel')
end