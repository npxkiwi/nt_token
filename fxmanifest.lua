fx_version 'cerulean'
game 'gta5'

author 'Notepad'
description 'Used to prevent cheaters'
version '1.0.0'


shared_scripts {
    '@ox_lib/init.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

lue54 'yes'