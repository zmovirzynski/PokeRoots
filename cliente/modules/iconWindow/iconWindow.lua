local iconWindow = nil

local codes = {
[1] = '� Alt+ 0128 | � Alt+ 0129 | � Alt+ 0130 | � Alt+ 0131 | � Alt+ 0132',
[2] = '� Alt+ 0133 | � Alt+ 0134 | � Alt+ 0135 | � Alt+ 0136 | � Alt+ 0137',
[3] = '� Alt+ 0138 | � Alt+ 0139 | � Alt+ 0140 | � Alt+ 0141 | � Alt+ 0142',
[4] = '� Alt+ 0143 | � Alt+ 0144 | � Alt+ 0145 | � Alt+ 0146 | � Alt+ 0147',
[5] = '� Alt+ 0148 | � Alt+ 0149 | � Alt+ 0150 | � Alt+ 0151 | � Alt+ 0152',
[6] = '� Alt+ 0153 | � Alt+ 0154 | � Alt+ 0155 | � Alt+ 0156 | � Alt+ 0157',
[7] = '� Alt+ 0158 | � Alt+ 0159',
}


function init()
iconWindow = g_ui.displayUI('iconWindow')
iconWindow:hide()
MenuButton = modules.client_topmenu.addLeftButton('Menubutton', tr('Icon Window'), 'Icon', toggle)
iconWindow:breakAnchors()
iconWindow.onEnter = hide
iconWindow.onEscape = hide
iconCode = iconWindow:recursiveGetChildById('text')
local text = ''
for i = 1, #codes do
	if i == #codes then
		text = text..codes[i]
	else
		text = text..codes[i]..'\n'
	end
end
iconCode:setText(text)
end

function terminate()
iconWindow:destroy()
end

function toggle()
if iconWindow:isVisible() then
	iconWindow:hide()
else
	iconWindow:show()
	iconWindow:focus()
end
end

function hide()
iconWindow:hide()
end