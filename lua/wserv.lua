#!/usr/bin/env lua

local new_headers = require('http.headers').new
local server = require('http.server')
local websocket = require('http.websocket')

server.new({
	host = 'localhost',
	port = '4000',
	tls = false,
	onstream = function(sv, st)
		local ws = websocket.new_from_stream(st, st:get_headers())
		ws:accept()
		while true do
			local txt, opcode = ws:receive()
			if txt == nil then
				break
			end
			print(txt)
			os.execute('notify-send woo')
			ws:send(txt, opcode)
		end
		ws:close()
	end,
}):loop()
