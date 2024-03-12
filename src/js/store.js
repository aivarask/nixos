onstorage = console.log
onlanguagechange = console.log

export function langStore() {
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

