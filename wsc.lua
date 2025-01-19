local websocket = require('http.websocket')
local http_version = require('http.version')
local json = require('cjson')

local agent = http_version.name .. '/' .. http_version.version
local wsuri = 'ws://localhost:9001'

print('Running test suite ..')

local caseCount
do -- getCaseCount
	local ws_uri = wsuri .. '/getCaseCount'
	local ws = websocket.new_from_uri(ws_uri)
	assert(ws:connect())
	local data = assert(ws:receive())
	caseCount = json.decode(data)
	ws:close()
end
print('Will run ' .. caseCount .. ' cases ..')

for currentCaseId = 1, caseCount do
	local ws_uri = wsuri .. '/runCase?case=' .. currentCaseId .. '&agent=' .. agent
	local ws = websocket.new_from_uri(ws_uri)
	assert(ws:connect())
	print('Executing test case ' .. currentCaseId .. '/' .. caseCount)
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
end
print('All test cases executed.')

local ws_uri = wsuri .. '/updateReports?agent=' .. agent
local ws = websocket.new_from_uri(ws_uri)
assert(ws:connect())
print('Updating reports ..')
-- Server closes connection when done
assert(ws:receive() == nil)
print('Reports updated.')
ws:close()
print('Test suite finished!')
