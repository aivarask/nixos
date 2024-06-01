document.body.onload = e => {
  console.log('index.js onload')
}

document.body.addEventListener("myEvent", function(e) {
  alert("myEvent was triggered!");
})

