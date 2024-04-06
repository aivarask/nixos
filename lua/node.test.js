import { strict as assert } from 'node:assert';
import { test, describe, it } from "node:test";


test('test 1', () => { assert.strictEqual(1, 1); });
test('test 2', () => { assert.strictEqual(1, 1); });


it('it 1', () => { assert.strictEqual(1, 1); });


describe('describe 1', () => {
  let a = 0
  for (const i of [1, 2, 3]) {
    a = i
  }
  it('it 2', () => { assert.strictEqual(1, 1); });
})
