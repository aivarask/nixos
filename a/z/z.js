
function xhr() {
  let lastResponseLength = false;

  var xhr = new XMLHttpRequest();

  xhr.open("GET", "/xhr", true);

  xhr.setRequestHeader("Content-Type", "application/json");
  xhr.setRequestHeader("Accept", "application/json");
  // xhr.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content);
  xhr.onprogress = function(e) {
    let progressResponse;
    let response = e.currentTarget.response;

    progressResponse = lastResponseLength ?
      response.substring(lastResponseLength)
      : response;

    lastResponseLength = response.length;
    let parsedResponse = progressResponse;
    console.log(parsedResponse);
    if (Object.prototype.hasOwnProperty.call(parsedResponse, 'success')) {
      // handle process success
    }
  }
  xhr.onreadystatechange = function() {
    if (xhr.readyState == 4 && this.status == 200) {
      console.log("Complete = " + xhr.responseText);
    }
  }

  xhr.send();
};


// htmx.logAll();

document.body.addEventListener('htmx:load', function(evt) {
  // myJavascriptLib.init(evt.detail.elt);
  // console.log('htmx:load')
});

htmx.on('htmx:xhr:progress', function(e) {
  console.log(e)
})
