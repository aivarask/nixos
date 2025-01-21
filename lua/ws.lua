local new_headers = require('http.headers').new
local server = require('http.server')
local websocket = require('http.websocket')
local cqueues = require('cqueues')
local ce = require('cqueues.errno')

local cq = cqueues.new()

cq:wrap(function()
	local myserver = server.listen({
		host = 'localhost',
		port = '4000',
		onstream = function(sv, st)
			local ws = websocket.new_from_stream(st, st:get_headers())
			ws:accept()
			while true do
				local txt, opcode = ws:receive()
				if txt == nil then
					break
				end
				print(txt)
				ws:send(txt, opcode)
			end
			ws:close()
		end,
	})
	myserver:listen()
	myserver:loop()
end)
cq:loop()
