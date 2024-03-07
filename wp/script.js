
document.addEventListener('DOMContentLoaded', function() {
  newFunction()

  setInterval(() => {
    false && location.reload()
  }, 2000);

  // var conn = new WebSocket('ws://localhost:8080');
  // conn.onopen = function(e) {
  //   console.log("Connection established!");
  // };

  // conn.onmessage = function(e) {
  //   console.log(e.data);
  // };
})

onstorage = console.log
onlanguagechange = console.log

function newFunction() {
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

