fx_version 'bodacious'
game 'gta5'
description 'Sogolisica'

version '1.0.0'

server_scripts {
	"@vrp/lib/utils.lua",
	'config.lua',
	'server/vehicleshop.lua'
}

client_scripts { 
	"@vrp/lib/utils.lua",
	"@vrp/client/Tunnel.lua",
    "@vrp/client/Proxy.lua",
	'config.lua',
	'client/vehicleshop.lua'
}

ui_page 'html/index.html'

files {
	'html/js/main.js',
	'html/index.html',
	'html/css/main.css',
	'html/img/container.png',
	'html/img/Logo.png',
	'html/path.png'
}