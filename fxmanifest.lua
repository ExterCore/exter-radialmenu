fx_version 'adamant'
games { 'gta5' }
lua54 'yes'

author 'sobing'

description 'EXTER-RADIALMENU LIKE NOPIXEL 4.0 STANDALONE'

client_script {
  "config.lua",
  "client.lua",
	"utils.lua"
}

ui_page "nui/dist/index.html"

files {
  "nui/dist/*",
  "nui/dist/index.html",
	"nui/dist/assets/*",
}