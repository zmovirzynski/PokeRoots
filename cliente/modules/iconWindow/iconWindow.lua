local iconWindow = nil

local codes = {
[1] = 'Ä Alt+ 0128 | Å Alt+ 0129 | Ç Alt+ 0130 | É Alt+ 0131 | Ñ Alt+ 0132',
[2] = 'Ö Alt+ 0133 | Ü Alt+ 0134 | á Alt+ 0135 | à Alt+ 0136 | â Alt+ 0137',
[3] = 'ä Alt+ 0138 | ã Alt+ 0139 | å Alt+ 0140 | ç Alt+ 0141 | é Alt+ 0142',
[4] = 'è Alt+ 0143 | ê Alt+ 0144 | ë Alt+ 0145 | í Alt+ 0146 | ì Alt+ 0147',
[5] = 'î Alt+ 0148 | ï Alt+ 0149 | ñ Alt+ 0150 | ó Alt+ 0151 | ò Alt+ 0152',
[6] = 'ô Alt+ 0153 | ö Alt+ 0154 | õ Alt+ 0155 | ú Alt+ 0156 | ù Alt+ 0157',
[7] = 'û Alt+ 0158 | ü Alt+ 0159',
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