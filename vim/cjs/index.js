const p = {
  name: "Alice",
  age: 25,
};

console.log("We have some visitors!");

function greet(person) {
  console.log("Hello, ", person.name);

  console.log("Your age is: ", person.age);
}

greet(p);

export default greet;
