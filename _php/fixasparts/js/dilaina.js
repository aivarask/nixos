/**
 * Clears HTMLInputElement.
 * @param {Event} e - Click event.
 */
function empty() {
  document.getElementById('fraze').value = ''
}

function emptyLast() {
  const el = document.getElementById('fraze');
  var val = el.value;
  var lastIndex = val.lastIndexOf(" ");
  el.value = val.substring(0, lastIndex);
  // .replace(/[\W]*\S+[\W]*$/, '')
}

function extractWord(text, pos) {
  let words = text.split(' ');
  var chars = 0;

  for (const word of words) {
    chars += word.length
    if (chars >= pos) return word
  }
}

function remove(e) {
  var pos = e.target.selectionStart
  var currentValue = e.currentTarget.value;
  let word = extractWord(currentValue, pos);
  const input = document.getElementById('fraze');
  let value = currentValue.replace(word, '')
  value = value.replace(/\s\s+/g, ' ');
  input.value = value
}

/**
 * Add clicked word to HTMLInputElement.
 * @param {Event} e - Click event.
 */
function append(e) {
  if (!e.ctrlKey) {
    e.preventDefault()

    var selection = window.getSelection();
    var range = selection.getRangeAt(0);
    var node = selection.anchorNode;

    while (range.toString().indexOf(' ') != 0) {
      range.setStart(node, (range.startOffset - 1));
    }
    range.setStart(node, range.startOffset + 1);
    do {
      range.setEnd(node, range.endOffset + 1);
    } while (range.toString().indexOf(' ') == -1 && range.toString().trim() != '');

    var word = range.toString().trim().replace('(', '').replace(')', '');
    var input = document.getElementById('fraze');
    input.value += `${word} `;
  }
}

document.onkeydown = function(e) {
  switch (e.key) {
    case 'Escape':
      const dilainaClose = document.getElementById('dilaina_close');
      dilainaClose && dilainaClose.click()
      break;

    case 'Backspace':
      if (e.ctrlKey) {
        const dilainaInput = document.getElementById('fraze');
        let value = dilainaInput.value
        value = value.substring(0, value.lastIndexOf(" "));
        dilainaInput.value = value
      }
      break

    case 'Enter':
      const form = document.getElementById('dilaina_form');
      const submitter = form.querySelector('#dilaina_submit');
      e.ctrlKey && form.requestSubmit(submitter);

    case 'Delete':
      e.ctrlKey && empty()
      break;

    default:
      break;
  }
}
