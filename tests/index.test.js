import { strict as assert } from 'node:assert';
import test from "node:test";

test('synchronous passing test', (t) => {
  // This test passes because it does not throw an exception.
  assert.strictEqual(1, 1);
});

test('synchronous passing test 2', (t) => {
  // This test passes because it does not throw an exception.
  assert.strictEqual(1, 1);
});

