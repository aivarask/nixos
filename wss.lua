local new_headers = require('http.headers').new
local server = require('http.server')
local websocket = require('http.websocket')
local cqueues = require('cqueues')
local ce = require('cqueues.errno')

local cq = cqueues.new()
cq:wrap(function()
	local myserver = server.listen({
		host = 'localhost',
		port = '9001',
	})
	assert(myserver:run(function(stream)
		local req_headers, err, errno = stream:get_headers()
		if req_headers == nil then
			-- connection hit EOF before headers arrived
			stream:shutdown()
			if err ~= ce.EPIPE and errno ~= ce.ECONNRESET then
				error(string.format('header error: %s', tostring(err)))
			end
			return
		elseif stream.state == 'closed' then
			-- stream shutdown before we got the chance...
			return
		end

		local ws = websocket.new_from_stream(req_headers, stream)
		assert(ws:accept())
		while true do
			local msg, msg_type = ws:receive()
			if msg == nil then
				if msg_type ~= nil then
					print('Error:', msg_type)
				end
				break
			end
			assert(ws:send(msg, msg_type))
		end
		ws:close()
	end))
end)
assert(cq:loop())
