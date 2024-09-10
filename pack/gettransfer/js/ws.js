var ws = new WebSocket('ws://localhost:8080/');
ws.onmessage = function() { location.reload() };
ws.onerror = console.error

