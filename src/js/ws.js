var ws = new WebSocket('ws://localhost:8080/');
ws.onmessage = function() { location.reload() };
// ws.onmessage = function(e) { console.log(e) }
ws.onerror = function() { console.log('ws.onerror') }
ws.onclose = function() { }

