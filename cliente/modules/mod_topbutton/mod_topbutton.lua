local config = {
	id = 'modTopButton', --Não pode conter espaços
	name = 'Teletransportar', --Nome que aparecerá quando passar o mouse por cima do botão
	img = 'button', --ícone do botão [no caso, pega a imagem button.png localizada na pasta do mod]
	options = { --opções que aparecem ao clicar no botão
		--[texto] = comando,
		['Saffron'] = '!h Saffron',
		['Cerulean'] = '!h Cerulean',
		['Lavender'] = '!h Lavender',
		['Fuchsia'] = '!h Fuchsia',
		['Celadon'] = '!h Celadon',
		['Viridian'] = '!h Viridian',
		['Vermilion'] = '!h Vermilion',
		['Pewter'] = '!h Pewter',
		['Pallet'] = '!h Pallet',
		['Cinnabar'] = '!h Cinnabar',	
		['Larosse'] = '!h Larosse',
		['Canavale'] = '!h Canavale',
		['Orre'] = '!h Orre',
		['Castelia'] = '!h Castelia',
		['Goldenrod'] = '!h Goldenrod',
		['Azalea'] = '!h Azalea',
		['Violet'] = '!h Violet',
		['Cherrygrove'] = '!h Cherrygrove',
		['Olivine'] = '!h Olivine',
		['Ecruteak'] = '!h Ecruteak',
		['Olivine'] = '!h Olivine',
		['Mahogany'] = '!h Mahogany',
		['Cianwood'] = '!h Cianwood',
		['Newbark'] = '!h Newbark',
		['Blackthorn'] = '!h Blackthorn',
		['Snow'] = '!h Snow',
		['Golden'] = '!h Golden',
	
	}
}

function init()  
   connect(g_game, { onGameStart = reload, onGameEnd = reload})
   TopButton = modules.client_topmenu.addRightGameButton(config.id, tr(config.name), config.img, toggle, true)
   TopButton:setWidth(34)
   reload()
end

function toggle()
g_game.talk("#PAG_ONE1#")
end

function reload()
	TopButton:setVisible(g_game.isOnline())
end