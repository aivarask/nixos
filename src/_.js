import './js/ws.js';

/** @type {import("htmx.org")} */
const htmx = window.htmx

htmx.logger = function(elt, event, data) { }

htmx.on('htmx:sseError', function(e) {
})

document.addEventListener('DOMContentLoaded', function() {
  setInterval(() => { false && location.reload() }, 2000);
})
