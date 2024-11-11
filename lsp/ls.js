#!/usr/bin/env node

import { createWriteStream } from "fs"
import { createInterface } from "readline/promises"


(async function() {
	const file = createWriteStream('/etc/nixos/lua/res.txt')
	for (let v of [1, 2, 3]) {
		file.write(v.toString())
	}


	for await (const line of createInterface({ input: process.stdin })) {
		console.log(line)
		file.write(line,)
	}
})()



// import { createInterface } from "readline/promises";
// import { stdin, stdout } from 'node:process';

// const rl = createInterface({ input: stdin, output: stdout })
// rl.on('line', (i) => {
// 	const json = i.substring(i.indexOf('{'), i.indexOf('}C') + 1)
// 	let obj = {
// 		jsonrpc: '2.0',
// 		method: 'initialized'
// 	}
// 	let str = JSON.stringify(obj)
// 	console.log(`Content-Length: ${str.length} \r\n\r\n${str}`)

// 	let log = JSON.stringify({
// 		jsonrpc: '2.0',
// 		method: 'window/logMessage',
// 		params: { type: 1, message: 'foo' }
// 	})
// 	console.log(`Content-Length: ${log.length} \r\n\r\n${log}`)

// });

// rl.once('close', () => {
// 	// end of input
// });


