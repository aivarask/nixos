import { strict as assert } from 'node:assert';
import { describe, test, it } from "node:test";

console.log('Hello node.test.js')

test('test 1', () => {
  assert.strictEqual(1, 1);
});

test('test 2', () => {
  assert.strictEqual(1, 1);
});

/** Increment function
 * @param {number} a -- number to increment 
 */
function inc(a) {
  return a + 1
}

describe('desc math', function() {
  it('it inc 1', () => {
    assert.strictEqual(inc(1), 2)
  })
})
