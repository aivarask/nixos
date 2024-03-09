window.onerror = function() { setTimeout(location.reload, 1000) }

var ws = new WebSocket('ws://localhost:8080/');
ws.onmessage = function() { location.reload() };
ws.onerror = function() { console.log('ws.onerror') }
ws.onclose = function() { }


document.addEventListener('DOMContentLoaded', function() {
  langStore()
  setInterval(() => { false && location.reload() }, 2000);
})

onstorage = console.log
onlanguagechange = console.log

function langStore() {
  const l = document.getElementById('lang')
  if (!l) return;

  l.state = function() {
    this.innerText = localStorage.getItem('lang') ?? navigator.language.split('-')[0]
  }
  l.onclick = function() {
    if (localStorage.getItem('lang') == 'lt') {
      localStorage.setItem('lang', 'en')
    } else {
      localStorage.setItem('lang', 'lt')
    }
    this.state()
    dispatchEvent(new Event('storage'))
  }
  l.state()
}
