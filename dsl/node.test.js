import { strict as assert } from 'node:assert';
import { describe, test, it } from "node:test";

/** Hello function
 * @param {string} name -- name variable */
function hello(name) {
  console.log('Hello ', name)
}

console.log('Hello, Node')
console.log('This is something imprtant')

test('synchronous passing test', (t) => {
  // This test passes because it does not throw an exception.
  assert.strictEqual(1, 1);
});

test('synchronous passing test 2', (t) => {
  // This test passes because it does not throw an exception.
  assert.strictEqual(1, 1);
});

/** Increment function
 * @param {number} a -- number to increment 
 */
function inc(a) {
  return a + 1
}

describe('Some math', function() {
  it('Incrementation by 1', () => {
    assert.strictEqual(inc(1), 2)
  })
})
