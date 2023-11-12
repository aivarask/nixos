import { inspect } from "util";
const foo = 'bar'

function hi() {
  const person = { name: "Alice", age: 25 }
  // inspect(foo)
  // console.log(inspect)

  console.log('Hello')
  // console.log(process.env.APP_FOO)
  return
}

function bye() {
  console.log('Bye')
}

hi()

