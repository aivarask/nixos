#!/usr/bin/env lua
local websocket = require('http.websocket')
local ws = websocket.new_from_uri('ws://localhost:4000')
ws:connect()

while true do
	local txt = io.read('*line')
	if txt == '' then
		break
	end
	ws:send(txt)
	print(ws:receive())
end

ws:close()
