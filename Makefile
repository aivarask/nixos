# https://makefiletutorial.com/#multiple-targets
include ./dsl/*.mk
include ./sql/*.mk

go.all: go.run go.test
go.run:
	go run ./src/main.go
go.test:
	go test
go.debug:
	dlv debug
go.doc:
	parallel ::: 'godoc -http=localhost:6060' 'sleep 1; firefox http://localhost:6060/pkg/nixos'


node.all: node.run node.test node.doc
node.run:
	node --watch-path=./src/ ./src/index.js
node.test:
	node --test
node.doc:
	jsdoc -d ./doc/jsdoc ./src/*.js && parallel ::: 'serve ./doc/jsdoc' 'sleep 1; firefox http://localhost:3000'



