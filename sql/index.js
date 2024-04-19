import Database from 'better-sqlite3';
import { readFile } from "fs/promises";
import { loadEnvFile } from 'process';



loadEnv()
const db = Database(process.env.DB_PATH);
const f = (await readFile(process.env.SQL_INIT)).toString()

const statements = f.split(';').slice(0, -1)

for (let index = 0; index < statements.length; index++) {
  const s = statements[index];
  db.prepare(s).run()
}

export function loadEnv() { return loadEnvFile("/etc/nixos/sql/.env") }

