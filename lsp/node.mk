# https://nodejs.org/docs/latest/api/
# https://jsdoc.app/

node.test:
	node --test ./dsl/node.test.js
node.run:
	node ./dsl/node.test.js
node.watch:
	node --watch-path=./dsl/ ./dsl/node.test.js
node.doc:
	jsdoc -d ./docs/jsdoc ./dsl/*.js
node.all: node.test node.run node.doc
