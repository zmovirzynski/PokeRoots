local facebookWindow = nil
local facebookButton = nil


function init()
  facebookWindow = g_ui.displayUI('facebook')
  facebookWindow:hide()

  facebookButton = modules.client_topmenu.addLeftButton('facebookButton', tr('Facebook'), 'facebook', toggle)
  facebookWindow:breakAnchors()
  facebookWindow:setPosition({x = 100, y = 100})
  facebookWindow.onEnter = hide
  facebookWindow.onEscape = hide

end

function CharacterList.facebook()
  os.execute("start https://www.facebook.com/")
end

function terminate()
  facebookWindow:destroy()
  facebookButton:destroy()
end

function toggle()
    if facebookWindow:isVisible() then
       CharacterList.facebook()
        facebookWindow:hide()
    else
        CharacterList.facebook()
        facebookWindow:show()
    end
end

function hide()
    facebookWindow:hide()
    facebookButton:setOn(false)
end