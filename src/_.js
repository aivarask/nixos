import './js/ws.js';
import './js/xhr.js';
import './js/ls.js'
import './sse/index.js'



/** @type {import("htmx.org")} */
const htmx = window.htmx


htmx.logger = function(elt, event, data) {
  if (console) {
    // console.log(event, elt, data);
  }
}


// htmx.logNone()
// htmx.on('htmx:sseError', function(e) {
// console.log(e)
// debugger
// })

// import { logNone } from './js/_htmx.js'
// onerror = function() { setTimeout(location.reload, 1000) }

document.addEventListener('DOMContentLoaded', function() {
  setInterval(() => { false && location.reload() }, 2000);
})
