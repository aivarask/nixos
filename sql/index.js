import Database from 'better-sqlite3';
const db = Database('/etc/nixos/sql/_.db');

import { readFile } from "fs/promises";

const f = (await readFile('/etc/nixos/sql/index.sql')).toString()
f.split(';').slice(0, -1).forEach(s => db.prepare(s).run())


const row = db.prepare('SELECT * FROM TEST').all();
console.table(row);
