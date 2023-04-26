const foo = "bara";
console.log("main ", foo);

const array = [1, 2, 3, 4];
for (let index = 0; index < array.length; index++) {
  const element = array[index];
  console.log("loop ", foo);
  console.log(element);
}
