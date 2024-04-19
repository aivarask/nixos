import assert from 'node:assert';
import { before, describe, it } from "node:test";
import { loadEnv } from './index.js';

before(() => {
  loadEnv()
})

describe('env', () => {
  describe('variables', () => {
    it('db path', () => {
      assert.notStrictEqual(process.env.DB_PATH, undefined)
    })
    it('sql path', () => {
      assert.notStrictEqual(process.env.SQL_INIT, undefined)
    })

    it('rest', () => {
      assert.strictEqual(1, 1)
    })
  })
})
