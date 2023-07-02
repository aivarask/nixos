const foo = {};
const bar = "baz";

function greet(message: string) {
  const preMes = "Some default";
  console.log(preMes, message);
}

interface Person {
  name: string;
  age: number;
}

const person = {
  name: "Alice",
  age: 25,
  sayHello: (message: string, something_else: string) => {
    console.log("Hi everyone", message, something_else);
  },
};

const items: (Person | any)[] = [
  { name: "Alice", age: 25 },
  { name: "Bob", age: 30 },
  [],
];
