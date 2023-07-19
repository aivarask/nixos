type Person = {
  name: string;
  age: number;
};

const p: Person = {
  name: "Alice",
  age: 25,
};

console.log("Hey, this is Typescript!");
console.log("We have some visitors!");

function greet(person: Person) {
  console.log("Hello, ", person.name);

  console.log("Your age is: ", person.age);
}

greet(p);
