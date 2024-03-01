import moment from "moment";

/** Hello function
 * @param {string} name -- name variable */
function hello(name) {
  console.log('Hello ', name)
}

function main() {
  console.log('Hello js')
  let start = moment.now()
  console.log('Time is: ', start)
  hello()
}

main()
